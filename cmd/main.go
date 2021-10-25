package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/phamtrung99/auth-service/client/mysql"
	"github.com/phamtrung99/auth-service/config"
	serviceGRPC "github.com/phamtrung99/auth-service/delivery/grpc"
	serviceHttp "github.com/phamtrung99/auth-service/delivery/http"
	"github.com/phamtrung99/auth-service/migration"
	"github.com/phamtrung99/auth-service/proto"
	"github.com/phamtrung99/auth-service/usecase"
	"github.com/phamtrung99/user-service/repository"
	"github.com/soheilhy/cmux"
	"github.com/swaggo/echo-swagger/example/docs"
	"google.golang.org/grpc"
	"gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
)

func main() {
	cfg := config.GetConfig()

	// setup locale
	{
		loc, _ := time.LoadLocation(cfg.TimeZone)
		time.Local = loc
	}

	mysql.Init()
	migration.Up()

	repo := repository.New(mysql.GetClient)
	ucase := usecase.New(repo)

	executeServer(repo, ucase)

}

// func executeServer(repo *repository.Repository, ucase *usecase.UseCase) {
// 	cfg := config.GetConfig()

// 	l, err := net.Listen("tcp", ":"+cfg.Port)

// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	errs := make(chan error)

// 	// http
// 	h := serviceHttp.NewHTTPHandler(repo, ucase)

// 	go func() {
// 		h.Listener = l

// 		log.Printf("Server is running on http://localhost:%s", cfg.Port)
// 		errs <- h.Start("")
// 	}()

// 	// grpc
// 	s := grpc.NewServer()

// 	go func() {
// 		grpcServ := &serviceGRPC.AuthService{AuthUsecase: ucase.Auth}

// 		proto.RegisterAuthServiceServer(s, grpcServ)

// 		errs <- s.Serve(grpcL)
// 	}()

// 	log.Println("exit", <-errs)
// }

func executeServer(repo *repository.Repository, ucase *usecase.UseCase) {
	cfg := config.GetConfig()

	// Swagger
	docs.SwaggerInfo.Host = cfg.SwaggerHost

	l, err := net.Listen("tcp", ":"+cfg.Port)
	if err != nil {
		log.Fatal(err)
	}

	// Datadog
	if cfg.Endpoints.DatadogAgentEndpoint != "" {
		tracer.Start(tracer.WithAgentAddr(cfg.Endpoints.DatadogAgentEndpoint))
		defer tracer.Stop()
	}

	m := cmux.New(l)
	grpcL := m.MatchWithWriters(cmux.HTTP2MatchHeaderFieldSendSettings("content-type", "application/grpc"))
	httpL := m.Match(cmux.HTTP1Fast())

	errs := make(chan error)

	// http
	h := serviceHttp.NewHTTPHandler(repo, ucase)

	go func() {
		h.Listener = httpL

		log.Printf("Server is running on http://localhost:%s", cfg.Port)
		errs <- h.Start("")
	}()

	// grpc
	s := grpc.NewServer()

	go func() {
		grpcServ := &serviceGRPC.AuthService{AuthUsecase: ucase.Auth}

		proto.RegisterAuthServiceServer(s, grpcServ)

		errs <- s.Serve(grpcL)
	}()

	go func() {
		errs <- m.Serve()
	}()

	// graceful
	go func() {
		c := make(chan os.Signal, 1)
		signal.Notify(c, syscall.SIGINT, syscall.SIGTERM)
		errs <- fmt.Errorf("%s", <-c)

		_ = h.Shutdown(context.Background())

		s.GracefulStop()
	}()

	log.Println("exit", <-errs)
}
