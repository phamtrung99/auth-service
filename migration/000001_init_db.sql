-- +goose Up
-- +goose StatementBegin
CREATE TABLE `movies` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `is_adult` tinyint(4) NOT NULL DEFAULT 0,
  `image` varchar(255) NOT NULL,
  `original_language` varchar(20) NOT NULL,
  `original_title` varchar(128) NOT NULL,
  `overview` text,
  `popularity` float,
  `movie_link` varchar(255) NOT NULL,
  `release_date` datetime ,
  `duration` int(11) NOT NULL DEFAULT 0,
  `spoken_language` varchar(50),
  `rating_average` float NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: Coming soon, 1: Release, 2: Prohibit',
  `created_at` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` datetime,
  `deleted_at` datetime
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `categories` (
  `id` int(5) PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(128) NOT NULL
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `producers` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `logo_path` varchar(128) NOT NULL,
  `name` varchar(50) NOT NULL
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `movie_categories` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `movie_id` bigint(20) NOT NULL,
  `cate_id` int NOT NULL
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `movie_producers` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `movie_id` bigint(20) NOT NULL,
  `producer_id` int NOT NULL
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `actors` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `birthday` datetime,
  `deathday` datetime DEFAULT null,
  `gender` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: female, 1: male, 2: other',
  `place_of_birth` varchar(255),
  `popularity` float,
  `avatar` varchar(128) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` datetime,
  `deleted_at` datetime
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `movie_actors` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `movie_id` bigint(20) NOT NULL,
  `actor_id` bigint(20) NOT NULL,
  `character_name` varchar(128) NOT NULL,
  `is_main_actor` tinyint(4) DEFAULT 0 COMMENT '0: not main actor, 1: main actor'
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `users` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `full_name` varchar(128) NOT NULL,
  `avatar`  varchar(255),
  `email` varchar(128) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `age` int NOT NULL DEFAULT 0,
  `role` varchar(10) NOT NULL,
  `ref_token` varchar(255),
  `created_at` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` datetime,
  `deleted_at` datetime DEFAULT null
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `comments` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `parent_id` bigint(20),
  `actor_id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` datetime,
  `deleted_at` datetime
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `movie_ratings` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `rating` tinyint(4)
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `user_favorites` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL
);

-- +goose StatementEnd
-- +goose StatementBegin
CREATE TABLE `view_histories` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `last_movies_runtime` int(11) NOT NULL DEFAULT 0,
  `last_view_at` datetime
);

-- +goose StatementEnd
-- +goose StatementBegin
INSERT INTO `users` VALUES 
(1,'Trung Pham Quoc','/public/avatar/1.png','teotu@gmail.com','$2a$10$AJSsJPJxrs0Fz1VX4xuNNO7y/75By2GstSQe84egXtC8GG7cDaQS6',19,'user','','2021-09-29 00:35:33','2021-09-29 08:16:14',NULL),
(2,'admin','/public/avatar/2.jpeg','admin@gmail.com','$2a$10$f9FmMgC3KUBixQG7Y7CjOe0e9pj4/BJubbWfTbNY0/dvwYLXvc5hu',30,'admin','','2021-09-29 02:26:52','2021-09-29 09:26:52',NULL);

-- +goose StatementEnd
-- +goose StatementBegin
INSERT INTO `categories` VALUES 
(1,'Action'),
 (2,'Adventure'),
 (3,'Animation'),
 (4,'Comedy'),
 (5,'Crime'),
 (6,'Documentary'),
 (7,'Drama'),
 (8,'Family'),
 (9,'Fantasy'),
 (10,'History'),
 (11,'Horror'),
 (12,'Music'),
 (13,'Mystery'),
 (14,'Romance'),
 (15,'Science Fiction'),
 (16,'TV Movie'),
 (17,'Thriller'),
 (18,'War'),
 (19,'Western');

-- +goose StatementEnd
-- +goose StatementBegin
INSERT INTO `comments` ( id, parent_id, actor_id, movie_id, content, created_at, updated_at)VALUES 
(1,1,1,1,"blank", '2021-09-30','2021-09-30');

-- +goose StatementEnd
-- +goose StatementBegin
INSERT INTO `movies` (is_adult,image,original_language,original_title,overview,popularity ,movie_link, release_date, duration, spoken_language, rating_average, status) VALUES
    (0,'https://image.tmdb.org/t/p/w500/xmbU4JTUm8rsdtn7Y3Fcm30GpeT.jpg','en','Free Guy','A bank teller called Guy realizes he is a background character in an open world video game called Free City that will soon go offline.',5418.816,'https://youtu.be/KYQNUZrvnew','2021-08-11',7800,'en',7.9,1),
    (0,'https://image.tmdb.org/t/p/w500/uIXF0sQGXOxQhbaEaKOi2VYlIL0.jpg','en','Snake Eyes: G.I. Joe Origins','After saving the life of their heir apparent, tenacious loner Snake Eyes is welcomed into an ancient Japanese clan called the Arashikage where he is taught the ways of the ninja warrior. But, when secrets from his past are revealed, Snake Eyes'''' honor and allegiance will be tested – even if that means losing the trust of those closest to him.',2958.528,'https://youtu.be/KYQNUZrvnew','2021-07-22',10300,'en',7,1),
    (0,'https://image.tmdb.org/t/p/w500/nLanxl7Xhfbd5s8FxPy8jWZw4rv.jpg','en','The Stronghold','A police brigade working in the dangerous northern neighborhoods of Marseille, where the level of crime is higher than anywhere else in France.',2869.826,'https://youtu.be/KYQNUZrvnew','2021-08-18',9000,'en',7.9,1),
    (0,'https://image.tmdb.org/t/p/w500/xeItgLK9qcafxbd8kYgv7XnMEog.jpg','en','Shang-Chi and the Legend of the Ten Rings','Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.',1937.308,'https://youtu.be/KYQNUZrvnew','2021-09-01',7800,'en',7.8,1),
    (1,'https://image.tmdb.org/t/p/w500/vclShucpUmPhdAOmKgf3B3Z4POD.jpg','en','Old','A group of families on a tropical holiday discover that the secluded beach where they are staying is somehow causing them to age rapidly – reducing their entire lives into a single day.',1877.482,'https://youtu.be/KYQNUZrvnew','2021-07-21',10300,'en',6.7,1),
    (0,'https://image.tmdb.org/t/p/w500/5VJSIAhSn4qUsg5nOj4MhQhF5wQ.jpg','en','The Last Warrior: Root of Evil','Peace and tranquility have set in Belogorie. The evil was defeated and Ivan is now enjoying his well-deserved fame. He is surrounded by his family, friends and small wonders from the modern world that help him lead a comfortable life. Luckily, he has his Magic Sword to cut a gap between the worlds to get some supplies quite regularly. But when an ancient evil rises and the existence of the magic world is put to danger, Ivan has to team up with his old friends and his new rivals. They will set out on a long journey beyond the known world to find a way to defeat the enemies and to return peace to Belogorie.',1563.555,'https://youtu.be/KYQNUZrvnew','2021-01-01',9000,'en',7.6,2),
    (0,'https://image.tmdb.org/t/p/w500/qKxrBZ8Ts4KHZKp7BT6GAVMLFO2.jpg','en','Catch the Bullet','U.S. marshal Britt MacMasters returns from a mission to find his father wounded and his son kidnapped by the outlaw Jed Blake. Hot on their trail, Britt forms a posse with a gunslinging deputy and a stoic Pawnee tracker. But Jed and Britt tread dangerously close to the Red Desert’s Sioux territory.',1485.372,'https://youtu.be/KYQNUZrvnew','2021-09-10',7800,'en',5.9,2),
    (0,'https://image.tmdb.org/t/p/w500/kb4s0ML0iVZlG6wAKbbs9NAm6X.jpg','en','The Suicide Squad','Supervillains Harley Quinn, Bloodsport, Peacemaker and a collection of nutty cons at Belle Reve prison join the super-secret, super-shady Task Force X as they are dropped off at the remote, enemy-infused island of Corto Maltese.',1415.16,'https://youtu.be/KYQNUZrvnew','2021-07-28',10300,'en',7.9,2),
    (0,'https://image.tmdb.org/t/p/w500/vFIHbiy55smzi50RmF8LQjmpGcx.jpg','en','Deathstroke: Knights & Dragons - The Movie','The assassin Deathstroke tries to save his family from the wrath of H.I.V.E. and the murderous Jackal.',1248.075,'https://youtu.be/KYQNUZrvnew','2020-08-04',9000,'en',7,3),
    (1,'https://image.tmdb.org/t/p/w500/6Y9fl8tD1xtyUrOHV2MkCYTpzgi.jpg','en','SAS: Red Notice','An off-duty SAS soldier, Tom Buckingham, must thwart a terror attack on a train running through the Channel Tunnel. As the action escalates on the train, events transpire in the corridors of power that may make the difference as to whether Buckingham and the civilian passengers make it out of the tunnel alive.',1218.476,'https://youtu.be/KYQNUZrvnew','2021-08-11',7800,'en',6,1),
    (0,'https://image.tmdb.org/t/p/w500/uJgdT1boTSP0dDIjdTgGleg71l4.jpg','en','Kate','After she''''s irreversibly poisoned, a ruthless criminal operative has less than 24 hours to exact revenge on her enemies and in the process forms an unexpected bond with the daughter of one of her past victims.',1195.763,'https://youtu.be/KYQNUZrvnew','2021-09-10',10300,'en',6.8,1),
    (0,'https://image.tmdb.org/t/p/w500/9dKCd55IuTT5QRs989m9Qlb7d2B.jpg','en','Jungle Cruise','Dr. Lily Houghton enlists the aid of wisecracking skipper Frank Wolff to take her down the Amazon in his dilapidated boat. Together, they search for an ancient tree that holds the power to heal – a discovery that will change the future of medicine.',1174.4,'https://youtu.be/KYQNUZrvnew','2021-07-28',9000,'en',7.8,1),
    (0,'https://image.tmdb.org/t/p/w500/bOFaAXmWWXC3Rbv4u4uM9ZSzRXP.jpg','en','F9','Dominic Toretto and his crew battle the most skilled assassin and high-performance driver they''''ve ever encountered: his forsaken brother.',1077.121,'https://youtu.be/KYQNUZrvnew','2021-05-19',7800,'en',7.5,1),
    (0,'https://image.tmdb.org/t/p/w500/6Wm7P6y22UZA40QuPYHyWyJ6leI.jpg','en','Cosmic Sin','In the year 2524, four centuries after humans started colonizing the outer planets, retired General James Ford gets called back into service when a hostile alien fleet attacks soldiers on a remote planet. The threat against mankind soon escalates into an interstellar war as Ford and a team of elite soldiers try to stop the imminent attack before it''''s too late.',1037.061,'https://youtu.be/KYQNUZrvnew','2021-03-12',10300,'en',4.5,1),
    (1,'https://image.tmdb.org/t/p/w500/ic0intvXZSfBlYPIvWXpU1ivUCO.jpg','en','PAW Patrol: The Movie','Ryder and the pups are called to Adventure City to stop Mayor Humdinger from turning the bustling metropolis into a state of chaos.',992.29,'https://youtu.be/KYQNUZrvnew','2021-08-09',9000,'en',7.9,2),
    (0,'https://image.tmdb.org/t/p/w500/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg','en','Space Jam: A New Legacy','When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.''''s digitized champions on the court. It''''s Tunes versus Goons in the highest-stakes challenge of his life.',965.433,'https://youtu.be/KYQNUZrvnew','2021-07-08',7800,'en',7.4,2),
    (0,'https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg','en','Black Widow','Natasha Romanoff, also known as Black Widow, confronts the darker parts of her ledger when a dangerous conspiracy with ties to her past arises. Pursued by a force that will stop at nothing to bring her down, Natasha must deal with her history as a spy and the broken relationships left in her wake long before she became an Avenger.',935.764,'https://youtu.be/KYQNUZrvnew','2021-07-07',10300,'en',7.7,2),
    (0,'https://image.tmdb.org/t/p/w500/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg','en','Venom: Let There Be Carnage','Sequel to the box-office hit film "Venom."',925.142,'https://youtu.be/KYQNUZrvnew','2021-09-30',7800,'en',8.6,1),
    (0,'https://image.tmdb.org/t/p/w500/8tABCBpzu3mZbzMB3sRzMEHEvJi.jpg','en','Luca','Luca and his best friend Alberto experience an unforgettable summer on the Italian Riviera. But all the fun is threatened by a deeply-held secret: they are sea monsters from another world just below the water’s surface.',921.586,'https://youtu.be/KYQNUZrvnew','2021-06-17',10300,'en',8,1),
    (0,'https://image.tmdb.org/t/p/w500/ysJte1iqN8pFQ470tumnViB1wHP.jpg','en','Nightbooks','Alex, a boy obsessed with scary stories, is trapped by a witch in her modern, magical New York City apartment. His original hair-raising tales are the only thing keeping him safe as he desperately tries to find a way out of this twisted place.',780.618,'https://youtu.be/KYQNUZrvnew','2021-09-15',9000,'en',6.7,1),
    (0,'https://image.tmdb.org/t/p/w500/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg','en','Venom: Let There Be Carnage','Sequel to the box-office hit film "Venom."',925.142,'https://youtu.be/KYQNUZrvnew','2021-09-30',7800,'en',8.6,1),
    (0,'https://image.tmdb.org/t/p/w500/dGv2BWjzwAz6LB8a8JeRIZL8hSz.jpg','en','Malignant','Madison is paralyzed by shocking visions of grisly murders, and her torment worsens as she discovers that these waking dreams are in fact terrifying realities with a mysterious tie to her past.',779.879,'https://youtu.be/KYQNUZrvnew','2021-09-01',10300,'en',7.1,1),
    (0,'https://image.tmdb.org/t/p/w500/34nDCQZwaEvsy4CFO5hkGRFDCVU.jpg','en','The Tomorrow War',NULL,603.654,'https://youtu.be/KYQNUZrvnew','2021-07-02',9000,'en',8.1,2),
    (0,'https://image.tmdb.org/t/p/w500/hRMfgGFRAZIlvwVWy8DYJdLTpvN.jpg','en','Don''''t Breathe 2',NULL,796.326,'https://youtu.be/KYQNUZrvnew','2021-08-12',7800,'en',7.7,2),
    (0,'https://image.tmdb.org/t/p/w500/uIdMpWrQ30SHPINsy7LcPFloyvO.jpg','en','Straight Outta Nowhere: Scooby-Doo! Meets Courage the Cowardly Dog','With Mystery, Inc. on the tail of a strange object in Nowhere, Kansas, the strange hometown of Eustice, Muriel, and Courage, the gang soon find themselves contending with a giant cicada monster and her winged warriors.',804.15,'https://youtu.be/KYQNUZrvnew','2021-09-14',10300,'en',8.4,2),
    (0,'https://image.tmdb.org/t/p/w500/dqoshZPLNsXlC1qtz5n34raUyrE.jpg','en','Candyman','Anthony and his partner move into a loft in the now gentrified Cabrini-Green, and after a chance encounter with an old-timer exposes Anthony to the true story behind Candyman, he unknowingly opens a door to a complex past that unravels his own sanity and unleashes a terrifying wave of violence.',671.446,'https://youtu.be/KYQNUZrvnew','2021-08-25',9000,'en',6.5,3),
    (1,'https://image.tmdb.org/t/p/w500/niw2AKHz6XmwiRMLWaoyAOAti0G.jpg','en','Infinite','Evan McCauley has skills he never learned and memories of places he has never visited. Self-medicated and on the brink of a mental breakdown, a secret group that call themselves “Infinites” come to his rescue, revealing that his memories are real.',613.756,'https://youtu.be/KYQNUZrvnew','2021-06-10',7800,'en',7.4,1),
    (0,'https://image.tmdb.org/t/p/w500/vFIHbiy55smzi50RmF8LQjmpGcx.jpg','en','Deathstroke: Knights & Dragons - The Movie','The assassin Deathstroke tries to save his family from the wrath of H.I.V.E. and the murderous Jackal.',1248.075,'https://youtu.be/KYQNUZrvnew','2020-08-04',10300,'en',7,1),
    (0,'https://image.tmdb.org/t/p/w500/ttpKJ7XQxDZV252KNEHXtykYT41.jpg','en','The Last Mercenary','A mysterious former secret service agent must urgently return to France when his estranged son  is falsely accused of arms and drug trafficking by the government, following a blunder by an overzealous bureaucrat and a mafia operation.',533.508,'https://youtu.be/KYQNUZrvnew','2021-07-30',9000,'en',6.9,1),
    (0,'https://image.tmdb.org/t/p/w500/h8Rb9gBr48ODIwYUttZNYeMWeUU.jpg','en','Demon Slayer -Kimetsu no Yaiba- The Movie: Mugen Train','Tanjirō Kamado, joined with Inosuke Hashibira, a boy raised by boars who wears a boar''''s head, and Zenitsu Agatsuma, a scared boy who reveals his true power when he sleeps, boards the Infinity Train on a new mission with the Fire Hashira, Kyōjurō Rengoku, to defeat a demon who has been tormenting the people and killing the demon slayers who oppose it!',765.958,'https://youtu.be/KYQNUZrvnew','2020-10-16',7800,'en',8.4,1),
    (0,'https://image.tmdb.org/t/p/w500/sHgh7lTrqYQlQ1jCHfRcLvY9AUt.jpg','en','After We Fell','Just as Tessa''''s life begins to become unglued, nothing is what she thought it would be. Not her friends nor her family. The only person that she should be able to rely on is Hardin, who is furious when he discovers the massive secret that she''''s been keeping. Before Tessa makes the biggest decision of her life, everything changes because of revelations about her family.',787.118,'https://youtu.be/KYQNUZrvnew','2021-09-01',10300,'en',8.2,1),
    (0,'https://image.tmdb.org/t/p/w500/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg','en','Venom','Investigative journalist Eddie Brock attempts a comeback following a scandal, but accidentally becomes the host of Venom, a violent, super powerful alien symbiote. Soon, he must rely on his newfound powers to protect the world from a shadowy organization looking for a symbiote of their own.',573.861,'https://youtu.be/KYQNUZrvnew','2018-09-28',9000,'en',6.8,2),
    (0,'https://image.tmdb.org/t/p/w500/fBJducGBcmrcIOQdhm4BUBNDiMu.jpg','en','Beckett','While vacationing in Greece, Beckett, becomes the target of a manhunt after a devastating car accident forces him to run for his life across the country to clear his name but tensions escalate as the authorities close in and political unrest mounts which makes Beckett fall even deeper into a dangerous web of conspiracy.',502.365,'https://youtu.be/KYQNUZrvnew','2021-08-04',7800,'en',6.5,2),
    (0,'https://image.tmdb.org/t/p/w500/6Wm7P6y22UZA40QuPYHyWyJ6leI.jpg','en','Cosmic Sin','In the year 2524, four centuries after humans started colonizing the outer planets, retired General James Ford gets called back into service when a hostile alien fleet attacks soldiers on a remote planet. The threat against mankind soon escalates into an interstellar war as Ford and a team of elite soldiers try to stop the imminent attack before it''''s too late.',1037.061,'https://youtu.be/KYQNUZrvnew','2021-03-12',10300,'en',4.5,2),
    (0,'https://image.tmdb.org/t/p/w500/M7SUK85sKjaStg4TKhlAVyGlz3.jpg','en','Wrath of Man','A cold and mysterious new security guard for a Los Angeles cash truck company surprises his co-workers when he unleashes precision skills during a heist. The crew is left wondering who he is and where he came from. Soon, the marksman''''s ultimate motive becomes clear as he takes dramatic and irrevocable steps to settle a score.',607.202,'https://youtu.be/KYQNUZrvnew','2021-04-22',9000,'en',7.8,3),
    (0,'https://image.tmdb.org/t/p/w500/wToO8opxkGwKgSfJ1JK8tGvkG6U.jpg','en','Cruella','In 1970s London amidst the punk rock revolution, a young grifter named Estella is determined to make a name for herself with her designs. She befriends a pair of young thieves who appreciate her appetite for mischief, and together they are able to build a life for themselves on the London streets. One day, Estella’s flair for fashion catches the eye of the Baroness von Hellman, a fashion legend who is devastatingly chic and terrifyingly haute. But their relationship sets in motion a course of events and revelations that will cause Estella to embrace her wicked side and become the raucous, fashionable and revenge-bent Cruella.',604.03,'https://youtu.be/KYQNUZrvnew','2021-05-26',7800,'en',8.3,1),
    (0,'https://image.tmdb.org/t/p/w500/nkayOAUBUu4mMvyNf9iHSUiPjF1.jpg','en','Mortal Kombat','Washed-up MMA fighter Cole Young, unaware of his heritage, and hunted by Emperor Shang Tsung''''s best warrior, Sub-Zero, seeks out and trains with Earth''''s greatest champions as he prepares to stand against the enemies of Outworld in a high stakes battle for the universe.',555.029,'https://youtu.be/KYQNUZrvnew','2021-04-07',10300,'en',7.4,1),
    (0,'https://image.tmdb.org/t/p/w500/pgqgaUx1cJb5oZQQ5v0tNARCeBp.jpg','en','Godzilla vs. Kong','In a time when monsters walk the Earth, humanity’s fight for its future sets Godzilla and Kong on a collision course that will see the two most powerful forces of nature on the planet collide in a spectacular battle for the ages.',502.389,'https://youtu.be/KYQNUZrvnew','2021-03-24',7800,'en',7.9,1),
    (0,'https://image.tmdb.org/t/p/w500/gYZAHan5CHPFXORpQMvOjCTug4E.jpg','en','Jolt','Lindy is an acid-tongued woman with rage issues who controls her temper by shocking herself with an electrode vest. One day she makes a connection with Justin, who gives her a glimmer of hope for a shock-free future, but when he’s murdered she launches herself on a revenge-fueled rampage in pursuit of his killer.',387.095,'https://youtu.be/KYQNUZrvnew','2021-07-15',10300,'en',6.8,1),
    (1,'https://image.tmdb.org/t/p/w500/4dsInlpfp4QnaOyuVq8axUE0l4A.jpg','en','The Mad Women''''s Ball','Eugenie has a unique gift: she hears and sees the dead. When her family discovers her secret, at the end of the 19th century, she is taken by her father and brother to the neurological clinic at La Pitié Salpêtrière with no possibility of escaping her fate. Her destiny becomes entwined with that of Geneviève, a nurse at the hospital.',464.058,'https://youtu.be/KYQNUZrvnew','2021-09-17',9000,'en',7.3,2),
    (0,'https://image.tmdb.org/t/p/w500/oxNoVgbu2v9ETL93Kri1pw8osYf.jpg','en','Breathless','In the DR, hardened cop Manolo tries to take down an infamous drug cartel; meanwhile, his daughter has fallen in love with Lorenzo, a construction worker who''''s unwittingly gotten embroiled in the drug cartel''''s dealings.',370.909,'https://youtu.be/KYQNUZrvnew','2021-08-11',7800,'en',5.9,2),
    (0,'https://image.tmdb.org/t/p/w500/wrlQnKHLCBheXMNWotyr5cVDqNM.jpg','en','Eggs Run','A rooster and his fowl partner embark on a dangerous trip to the Congo to recover their stolen eggs from a group of Russian goons.',497.039,'https://youtu.be/KYQNUZrvnew','2021-08-12',10300,'en',8.1,2),
    (0,'https://image.tmdb.org/t/p/w500/lB068qa6bQ0QKYKyC2xnYGvYjl7.jpg','en','The Forever Purge','All the rules are broken as a sect of lawless marauders decides that the annual Purge does not stop at daybreak and instead should never end as they chase a group of immigrants who they want to punish because of their harsh historical past.',473.671,'https://youtu.be/KYQNUZrvnew','2021-06-30',9000,'en',7.5,3),
    (0,'https://image.tmdb.org/t/p/w500/7BCTdek5LFHglcgl7shsm7igJAH.jpg','en','Dynasty Warriors','Warlords, warriors and statesmen wage a battle for supremacy in this fantasy tale based on the hit video games and the "Romance of the Three Kingdoms."',481.958,'https://youtu.be/KYQNUZrvnew','2021-04-29',7800,'en',6.7,1),
    (0,'https://image.tmdb.org/t/p/w500/6gw8onh4FKsruBA7Oouv01EFxzn.jpg','en','Mobile Suit Gundam Hathaway','After Char''''s rebellion, Hathaway Noa leads an insurgency against Earth Federation, but meeting an enemy officer and a mysterious woman alters his fate.',501.573,'https://youtu.be/KYQNUZrvnew','2021-06-11',10300,'en',8.1,1),
    (0,'https://image.tmdb.org/t/p/w500/uTgZuqUQbaCB6Wfk03N8IUEuzQf.jpg','en','Vacation Friends','When a straight-laced couple that has fun with a rowdy couple on vacation in Mexico return to the States, they discover that the crazy couple they met in Mexico followed them back home and decide to play tricks on them.',403.737,'https://youtu.be/KYQNUZrvnew','2021-08-27',9000,'en',7.3,1),
    (0,'https://image.tmdb.org/t/p/w500/rODS466qSdrwMlGdbUwPENhDN2c.jpg','en','Rurouni Kenshin: The Beginning','Before he was a protector, Kenshin was a fearsome assassin known as Battosai. But when he meets gentle Tomoe Yukishiro, a beautiful young woman who carries a huge burden in her heart, his life will change forever.',491.762,'https://youtu.be/KYQNUZrvnew','2021-06-04',7800,'en',7.8,1),
    (0,'https://image.tmdb.org/t/p/w500/zvGC5jX5wQmU1GgPc0VGZz7Mtcs.jpg','en','El mesero','A waiter pretends to be an important businessman in order to reach the upper class through his entrepreneurial dreams.',432.378,'https://youtu.be/KYQNUZrvnew','2021-07-15',10300,'en',8.3,1),
    (0,'https://image.tmdb.org/t/p/w500/dPOyYnCkRbWAEem85N3VFpQODf5.jpg','en','The Misfits','After being recruited by a group of unconventional thieves, renowned criminal Richard Pace finds himself caught up in an elaborate gold heist that promises to have far-reaching implications on his life and the lives of countless others.',342.643,'https://youtu.be/KYQNUZrvnew','2021-06-10',9000,'en',5.7,2),
    (0,'https://image.tmdb.org/t/p/w500/kOVko9u2CSwpU8zGj14Pzei6Eco.jpg','en','Bartkowiak','After his brother dies in a car crash, a disgraced MMA fighter takes over the family nightclub — and soon learns his sibling''''s death wasn’t an accident.',302.947,'https://youtu.be/KYQNUZrvnew','2021-07-28',7800,'en',6.4,2),
    (0,'https://image.tmdb.org/t/p/w500/z8CExJekGrEThbpMXAmCFvvgoJR.jpg','en','Army of the Dead','Following a zombie outbreak in Las Vegas, a group of mercenaries take the ultimate gamble: venturing into the quarantine zone to pull off the greatest heist ever attempted.',351.722,'https://youtu.be/KYQNUZrvnew','2021-05-14',10300,'en',6.4,2),
    (0,'https://image.tmdb.org/t/p/w500/6WcJ4cV2Y3gnTYp5zHu968TYmTJ.jpg','en','Dragon Fury','A group of soldiers are taken to the mountains of Wales to investigate a strange beast.',690.857,'https://youtu.be/KYQNUZrvnew','2021-06-15',9000,'en',4,3),
    (1,'https://image.tmdb.org/t/p/w500/ablrE8IbWcIrAxMmm4gnPn75AMS.jpg','en','Mortal Kombat Legends: Battle of the Realms','The Earthrealm heroes must journey to the Outworld and fight for the survival of their homeland, invaded by the forces of evil warlord Shao Kahn, in the tournament to end all tournaments: the final Mortal Kombat.',422.781,'https://youtu.be/KYQNUZrvnew','2021-08-30',7800,'en',8,1),
    (0,'https://image.tmdb.org/t/p/w500/xbSuFiJbbBWCkyCCKIMfuDCA4yV.jpg','en','The Conjuring: The Devil Made Me Do It','Paranormal investigators Ed and Lorraine Warren encounter what would become one of the most sensational cases from their files. The fight for the soul of a young boy takes them beyond anything they''''d ever seen before, to mark the first time in U.S. history that a murder suspect would claim demonic possession as a defense.',404.202,'https://youtu.be/KYQNUZrvnew','2021-05-25',10300,'en',7.8,1),
    (0,'https://image.tmdb.org/t/p/w500/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg','en','Zack Snyder''''s Justice League','Determined to ensure Superman''''s ultimate sacrifice was not in vain, Bruce Wayne aligns forces with Diana Prince with plans to recruit a team of metahumans to protect the world from an approaching threat of catastrophic proportions.',350.452,'https://youtu.be/KYQNUZrvnew','2021-03-18',9000,'en',8.4,1),
    (0,'https://image.tmdb.org/t/p/w500/qQ0VKsGRQ2ofAmswGNzZnvC1xPE.jpg','en','Miraculous World: Shanghai – The Legend of Ladydragon','On school break, Marinette heads to Shanghai to meet Adrien. But after arriving, Marinette loses all her stuff, including the Miraculous that allows her to turn into Ladybug!',410.053,'https://youtu.be/KYQNUZrvnew','2021-04-04',7800,'en',7.9,1),
    (0,'https://image.tmdb.org/t/p/w500/bShgiEQoPnWdw4LBrYT5u18JF34.jpg','en','The Unholy','Alice, a young hearing-impaired girl who, after a supposed visitation from the Virgin Mary, is inexplicably able to hear, speak and heal the sick. As word spreads and people from near and far flock to witness her miracles, a disgraced journalist hoping to revive his career visits the small New England town to investigate. When terrifying events begin to happen all around, he starts to question if these phenomena are the works of the Virgin Mary or something much more sinister.',357.532,'https://youtu.be/KYQNUZrvnew','2021-03-31',10300,'en',6.9,1),
    (0,'https://image.tmdb.org/t/p/w500/nxxuWC32Y6TULj4VnVwMPUFLIpK.jpg','en','Seobok','A former intelligence agent gets involved with the first human clone, Seo Bok, who others seek, causing trouble.',329.896,'https://youtu.be/KYQNUZrvnew','2021-04-12',9000,'en',7.4,2);

-- +goose StatementEnd
-- +goose StatementBegin
INSERT INTO actors (name,birthday ,deathday,gender,place_of_birth,popularity,avatar)VALUES
    ('Katherine LaNasa',NULL,NULL,0,'New Orleans, Louisiana, USA',491.278,'https://image.tmdb.org/t/p/w500/a1T5Smn7sCEtV8NHvTa5WaxgOML.jpg'),
    ('Jackie Chan',NULL,NULL,1,'New Orleans, Louisiana, USA',56.44,'https://image.tmdb.org/t/p/w500/nraZoTzwJQPHspAVsKfgl3RXKKa.jpg'),
    ('Janaina Liesenfeld',NULL,NULL,0,'New Orleans, Louisiana, USA',54.612,'https://image.tmdb.org/t/p/w500/1AGg7Rh5a2wAIsHQYl0IGtrddW9.jpg'),
    ('Ryan Reynolds',NULL,NULL,1,'New Orleans, Louisiana, USA',54.388,'https://image.tmdb.org/t/p/w500/yDNXyrH14OVKOojlTsltqAOmKNr.jpg'),
    ('Anupam Tripathi',NULL,NULL,0,'New Orleans, Louisiana, USA',47.926,'https://image.tmdb.org/t/p/w500/qiypxSxV93cIv7F4O2MeOpXNlsJ.jpg'),
    ('Miles Wei',NULL,NULL,1,'New Orleans, Louisiana, USA',47.62,'https://image.tmdb.org/t/p/w500/fT4v4LTDXGEFGHe7ZAaRTtqBFYM.jpg'),
    ('Oh Young-soo',NULL,NULL,0,'New Orleans, Louisiana, USA',43.523,'https://image.tmdb.org/t/p/w500/bGCLm8LzCqH5maYUKOV8KCQidVV.jpg'),
    ('Jodie Comer',NULL,NULL,1,'New Orleans, Louisiana, USA',41.583,'https://image.tmdb.org/t/p/w500/va8pcuzXodVLYUQLjB1USZVB6gz.jpg'),
    ('Scarlett Johansson',NULL,NULL,0,'New Orleans, Louisiana, USA',41.483,'https://image.tmdb.org/t/p/w500/zmvK1jJ6UZpAAeMMgdEOWir0kQN.jpg'),
    ('Jason Statham',NULL,NULL,1,'New Orleans, Louisiana, USA',41.099,'https://image.tmdb.org/t/p/w500/lldeQ91GwIVff43JBrpdbAAeYWj.jpg'),
    ('Jung Ho-yeon',NULL,NULL,0,'New Orleans, Louisiana, USA',39.844,'https://image.tmdb.org/t/p/w500/2nKZaOgwpJbJXegDISQIdfsfnm0.jpg'),
    ('Paul Rudd',NULL,NULL,1,'New Orleans, Louisiana, USA',35.788,'https://image.tmdb.org/t/p/w500/8eTtJ7XVXY0BnEeUaSiTAraTIXd.jpg'),
    ('Ayame Misaki',NULL,NULL,0,'New Orleans, Louisiana, USA',35.657,'https://image.tmdb.org/t/p/w500/7ViHWgrPifqwjMTGrzS7XI32VZs.jpg'),
    ('Tom Cruise',NULL,NULL,1,'New Orleans, Louisiana, USA',34.252,'https://image.tmdb.org/t/p/w500/8qBylBsQf4llkGrWR3qAsOtOU8O.jpg'),
    ('Sylvester Stallone',NULL,NULL,0,'New Orleans, Louisiana, USA',34.186,'https://image.tmdb.org/t/p/w500/qDRGPAcQoW8Wuig9bvoLpHwf1gU.jpg'),
    ('Vin Diesel',NULL,NULL,1,'New Orleans, Louisiana, USA',33.803,'https://image.tmdb.org/t/p/w500/9uxTwqB8anAiPomB6Kqm6A73VTV.jpg'),
    ('Henry Cavill',NULL,NULL,0,'New Orleans, Louisiana, USA',32.993,'https://image.tmdb.org/t/p/w500/iWdKjMry5Pt7vmxU7bmOQsIUyHa.jpg'),
    ('Mark Wahlberg',NULL,NULL,1,'New Orleans, Louisiana, USA',31.16,'https://image.tmdb.org/t/p/w500/bTEFpaWd7A6AZVWOqKKBWzKEUe8.jpg'),
    ('Lee Jung-jae',NULL,NULL,0,'New Orleans, Louisiana, USA',30.435,'https://image.tmdb.org/t/p/w500/s3Sv4bZORQ5DuZJahgU2X0RgMUQ.jpg'),
    ('Matsuri Mizuguchi',NULL,NULL,1,'New Orleans, Louisiana, USA',29.894,'https://image.tmdb.org/t/p/w500/xJgBeksn0oWbbdyMU4iWrfrSTWc.jpg'),
    ('Rebecca Ferguson',NULL,NULL,0,'New Orleans, Louisiana, USA',29.222,'https://image.tmdb.org/t/p/w500/6NRlV9oUipeak7r00V6k73Jb7we.jpg'),
    ('Lauren German',NULL,NULL,1,'New Orleans, Louisiana, USA',29.221,'https://image.tmdb.org/t/p/w500/wlfew4J9O6fOhizjjQtqUeT36Jb.jpg'),
    ('Nicolas Cage',NULL,NULL,0,'New Orleans, Louisiana, USA',29.194,'https://image.tmdb.org/t/p/w500/ar33qcWbEgREn07ZpXv5Pbj8hbM.jpg'),
    ('Jason Momoa',NULL,NULL,1,'New Orleans, Louisiana, USA',28.932,'https://image.tmdb.org/t/p/w500/6dEFBpZH8C8OijsynkSajQT99Pb.jpg'),
    ('Hande Erçel',NULL,NULL,0,'New Orleans, Louisiana, USA',28.267,'https://image.tmdb.org/t/p/w500/heZOn03SAJkwbmTAdk7IXA5yMTV.jpg'),
    ('Margot Robbie',NULL,NULL,1,'New Orleans, Louisiana, USA',28.264,'https://image.tmdb.org/t/p/w500/euDPyqLnuwaWMHajcU3oZ9uZezR.jpg'),
    ('Úrsula Corberó',NULL,NULL,0,'New Orleans, Louisiana, USA',27.82,'https://image.tmdb.org/t/p/w500/wfy2YBmaGkH5kl60y3P03tTAMMc.jpg'),
    ('Tom Hardy',NULL,NULL,1,'New Orleans, Louisiana, USA',26.934,'https://image.tmdb.org/t/p/w500/sGMA6pA2D6X0gun49igJT3piHs3.jpg'),
    ('Kim Joo-ryoung',NULL,NULL,0,'New Orleans, Louisiana, USA',26.914,'https://image.tmdb.org/t/p/w500/fzAQghaykG5841cvSMogl1Xaafw.jpg'),
    ('Rika Izumi',NULL,NULL,1,'New Orleans, Louisiana, USA',26.908,'https://image.tmdb.org/t/p/w500/aJw3xkW60SQgJ2dxcDBddjoTNEA.jpg'),
    ('Keanu Reeves',NULL,NULL,0,'New Orleans, Louisiana, USA',26.322,'https://image.tmdb.org/t/p/w500/rRdru6REr9i3WIHv2mntpcgxnoY.jpg'),
    ('Mary Elizabeth Winstead',NULL,NULL,1,'New Orleans, Louisiana, USA',26.311,'https://image.tmdb.org/t/p/w500/vQn6IGsClpyhV6KTba9EDqSK7e2.jpg'),
    ('Dwayne Johnson',NULL,NULL,0,'New Orleans, Louisiana, USA',26.017,'https://image.tmdb.org/t/p/w500/cgoy7t5Ve075naBPcewZrc08qGw.jpg'),
    ('Jun Ji-hyun',NULL,NULL,1,'New Orleans, Louisiana, USA',25.96,'https://image.tmdb.org/t/p/w500/qejOQBdIzN18e69yRcsiD0JQi4c.jpg'),
    ('Tom Hiddleston',NULL,NULL,0,'New Orleans, Louisiana, USA',25.689,'https://image.tmdb.org/t/p/w500/mclHxMm8aPlCPKptP67257F5GPo.jpg'),
    ('Lisa Kudrow',NULL,NULL,1,'New Orleans, Louisiana, USA',25.401,'https://image.tmdb.org/t/p/w500/9YNzHuT7L0wdEl3zua6iUYz5tYT.jpg'),
    ('Elisabeth Shue',NULL,NULL,0,'New Orleans, Louisiana, USA',25.337,'https://image.tmdb.org/t/p/w500/oYSPh5yw1t8biktENTGS8X7n4zg.jpg'),
    ('Laura Surrich',NULL,NULL,1,'New Orleans, Louisiana, USA',25.254,'https://image.tmdb.org/t/p/w500/fbXZxpfIYjN0uexfAELkOVPx1bi.jpg'),
    ('Tom Holland',NULL,NULL,0,'New Orleans, Louisiana, USA',25.182,'https://image.tmdb.org/t/p/w500/2qhIDp44cAqP2clOgt2afQI07X8.jpg'),
    ('Rachel Weisz',NULL,NULL,1,'New Orleans, Louisiana, USA',24.907,'https://image.tmdb.org/t/p/w500/3QbFXeiUzXUVUrJ7fdiCn7A7ReW.jpg');

-- +goose StatementEnd
-- +goose StatementBegin
INSERT INTO movie_actors(movie_id, actor_id, character_name, is_main_actor)  VALUES
    (1,1,'Captain ',0),
    (1,2,'Captain ',1),
    (1,3,'Captain ',1),
    (1,4,'Captain ',1),
    (1,5,'Captain ',1),
    (1,6,'Captain ',0),
    (1,7,'Captain ',0),
    (1,8,'Captain ',0),
    (1,9,'Captain ',0),
    (2,10,'Captain ',1),
    (2,11,'Captain ',1),
    (2,12,'Captain ',1),
    (2,13,'Captain ',1),
    (2,14,'Captain ',0),
    (2,15,'Captain ',0),
    (2,16,'Captain ',0),
    (2,17,'Captain ',0),
    (2,18,'Captain ',1),
    (2,19,'Captain ',1),
    (3,20,'Captain ',1),
    (3,21,'Captain ',1),
    (3,22,'Captain ',0),
    (3,23,'Captain ',0),
    (3,24,'Captain ',0),
    (3,25,'Captain ',0),
    (3,26,'Captain ',1),
    (3,27,'Captain ',1),
    (3,28,'Captain ',1),
    (3,29,'Captain ',1),
    (4,30,'Captain ',0),
    (4,31,'Captain ',0),
    (4,32,'Captain ',0),
    (4,33,'Captain ',0),
    (4,34,'Captain ',1),
    (4,35,'Captain ',1),
    (4,36,'Captain ',1),
    (4,37,'Captain ',1),
    (4,38,'Captain ',0),
    (5,39,'Captain ',0),
    (6,40,'Captain ',0),
    (7,1,'Captain ',0),
    (8,2,'Captain ',1),
    (9,3,'Captain ',1),
    (10,4,'Captain ',1),
    (11,5,'Captain ',1),
    (12,6,'Captain ',0),
    (13,7,'Captain ',0),
    (14,8,'Captain ',0),
    (15,9,'Captain ',0),
    (16,10,'Captain ',1),
    (17,11,'Captain ',1),
    (18,12,'Captain ',1),
    (19,13,'Captain ',1),
    (20,14,'Captain ',0),
    (21,15,'Captain ',0),
    (22,16,'Captain ',0),
    (23,17,'Captain ',0),
    (24,18,'Captain ',1),
    (25,19,'Captain ',1),
    (26,20,'Captain ',1),
    (27,21,'Captain ',1),
    (28,22,'Captain ',0),
    (29,23,'Captain ',0),
    (30,24,'Captain ',0),
    (31,25,'Captain ',0),
    (32,26,'Captain ',1),
    (33,27,'Captain ',1),
    (34,28,'Captain ',1),
    (35,29,'Captain ',1),
    (36,30,'Captain ',0),
    (37,31,'Captain ',0),
    (38,32,'Captain ',0),
    (39,33,'Captain ',0),
    (40,34,'Captain ',1),
    (41,35,'Captain ',1),
    (42,36,'Captain ',1),
    (43,37,'Captain ',1),
    (44,38,'Captain ',0),
    (45,39,'Captain ',0),
    (46,40,'Captain ',0),
    (47,1,'Captain ',0),
    (48,2,'Captain ',1),
    (49,3,'Captain ',1),
    (50,4,'Captain ',1),
    (51,5,'Captain ',1),
    (52,6,'Captain ',0),
    (53,7,'Captain ',0),
    (54,8,'Captain ',0),
    (55,9,'Captain ',0),
    (56,10,'Captain ',1),
    (57,11,'Captain ',1),
    (58,12,'Captain ',1);

-- +goose StatementEnd
-- +goose StatementBegin
INSERT INTO movie_categories (movie_id, cate_id)VALUES
    (1,1),
    (2,2),
    (3,3),
    (4,4),
    (5,5),
    (6,6),
    (7,7),
    (8,8),
    (9,9),
    (10,10),
    (11,11),
    (12,12),
    (13,13),
    (14,14),
    (15,15),
    (16,16),
    (17,17),
    (18,18),
    (19,1),
    (20,2),
    (21,3),
    (22,4),
    (23,5),
    (24,6),
    (25,7),
    (26,8),
    (27,9),
    (28,10),
    (29,11),
    (30,12),
    (31,13),
    (32,14),
    (33,15),
    (34,16),
    (35,17),
    (36,18),
    (37,1),
    (38,2),
    (39,3),
    (40,4),
    (41,5),
    (42,6),
    (43,7),
    (44,8),
    (45,9),
    (46,10),
    (47,11),
    (48,12),
    (49,13),
    (50,14),
    (51,15),
    (52,16),
    (53,17),
    (54,18),
    (55,1),
    (56,2),
    (57,3),
    (58,4);

-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `movie_categories` ADD FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `movie_categories` ADD FOREIGN KEY (`cate_id`) REFERENCES `categories` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `movie_producers` ADD FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `movie_producers` ADD FOREIGN KEY (`producer_id`) REFERENCES `producers` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `movie_actors` ADD FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `movie_actors` ADD FOREIGN KEY (`actor_id`) REFERENCES `actors` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `comments` ADD FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `comments` ADD FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `comments` ADD FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `movie_ratings` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `movie_ratings` ADD FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `view_histories` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `view_histories` ADD FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `user_favorites` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
-- +goose StatementEnd
-- +goose StatementBegin
ALTER TABLE `user_favorites` ADD FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`);
-- +goose StatementEnd


-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS `movie_producers`;
DROP TABLE IF EXISTS `producers`;
DROP TABLE IF EXISTS `movie_categories`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `movie_ratings`;
DROP TABLE IF EXISTS `movie_actors`;
DROP TABLE IF EXISTS `actors`;
DROP TABLE IF EXISTS `comments`;
DROP TABLE IF EXISTS `view_histories`;
DROP TABLE IF EXISTS `user_favorites`;
DROP TABLE IF EXISTS `movies`;
DROP TABLE IF EXISTS `users`;
-- +goose StatementEnd