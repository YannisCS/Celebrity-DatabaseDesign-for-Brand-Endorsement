-- 1. create database and tables
create database t6;

use t6;
-----------------------------------------------------------------------------------
create table Celebrity
(	CelebrityID int not null identity primary key,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	Country varchar(30)
);
create table Award
(	AwardID int not null identity primary key,
	Name varchar(50) not null,
	Value int not null check (Value between 0 and 100)
);
create table Work
(	WorkID int not null identity primary key,
	Name varchar(50) not null,
	Type varchar(30) not null,
	DBScore float
);
create table Brand
(	BrandID int not null identity primary key,
	Name varchar(30) not null,
	Type varchar(30) not null
);
create table Platform
(	PlatformID int not null identity primary key,
	Name varchar(30) not null,
	DailyUsers int not null
);
CREATE TABLE News (
NewsID int IDENTITY NOT NULL PRIMARY KEY,
TwitterLink varchar(255) NOT NULL,
Keyword varchar(30) NOT NULL,
Date date NOT NULL,
Views int NOT NULL
);
CREATE TABLE CelebrityNews (
CelebrityNewsID int IDENTITY NOT NULL PRIMARY KEY,
CelebrityID int NOT NULL REFERENCES Celebrity(CelebrityID),
NewsID int NOT NULL REFERENCES News(NewsID),
);
CREATE TABLE Award_Winning (
AwardWinningID int IDENTITY NOT NULL PRIMARY KEY,
CelebrityID int NOT NULL REFERENCES Celebrity(CelebrityID),
AwardID int NOT NULL REFERENCES Award(AwardID),
WorkID int NOT NULL REFERENCES Work(WorkID),
Date date NOT NULL
);
CREATE TABLE Participation (
ParticipationID int IDENTITY NOT NULL PRIMARY KEY,
CelebrityID int NOT NULL REFERENCES Celebrity(CelebrityID),
WorkID int NOT NULL REFERENCES Work(WorkID),
Role varchar(30) NOT NULL
);
CREATE TABLE Endorsement
(
	EndorsementID INT NOT NULL Identity Primary Key,
	CelebrityID INT NOT NULL REFERENCES Celebrity(CelebrityID),
	BrandID INT NOT NULL REFERENCES Brand(BrandID),
	Title varchar(30) NOT NULL,
	StartDate Date NOT NULL,
	EndDate Date NOT NULL
);
CREATE TABLE Account
(
	AccountID INT NOT NULL Identity Primary Key,
	PlatformID INT NOT NULL REFERENCES Platform(PlatformID),
	CelebrityID INT NOT NULL REFERENCES Celebrity(CelebrityID),
	FanAmount INT default 0
);
CREATE TABLE Post
(
	PostID INT NOT NULL Identity Primary Key,
	AccountID INT NOT NULL REFERENCES Account(AccountID),
	NumberLikes INT NOT NULL default 0,
	NumberComments INT NOT NULL default 0,
	NumberRetweets INT NOT NULL default 0,
	Date DATE NOT NULL default getdate(),
	BrandName varchar(50) NOT NULL,
);
CREATE TABLE SalePlatformData(
	SalePlatformDataID INT NOT NULL Identity Primary Key,
	BrandID INT  NOT NULL REFERENCES Brand(BrandID),
	platformName varchar(30) NOT NULL,
	platformSales Money NOT NULL default 0,
	Date DATE NOT NULL default getdate()
)


--------------------------------------------------------------------------------
--insert data
insert into Celebrity(FirstName,LastName, Country)
values ('Alicia', 'Vikander','Sweden'),
	   ('Kristen', 'Stewart', 'USA'),
	   ('Harry', 'Styles', 'UK'),
	   ('Jason', 'Statham','UK'),
	   ('Zendaya', 'Coleman','USA'),
	   ('Kanye', 'West','USA'),
	   ('Rihanna', 'Fenty', 'Barbados'),
	   ('Jennifer', 'Lawrence','USA'),
	   ('Beyoncé', 'Knowles-Carter','USA'),
	   ('Emma', 'Watson', 'UK');
insert into Award(Name, Value)
values ('Oscar Best Attress', 95),
	   ('César Best Actress', 90),
	   ('Grammy Best Pop Solo', 90),
	   ('Grammy Best Rap Album', 95),
	   ('Grammy Best Urban Contemporary Album',90),
	   ('Grammy Album of the Year', 100),
	   ('Teen Choice Movie Actress', 60),
	   ('Primetime Emmy Drama Series Outstanding Actress',85),
	   ('MTV VMA Best Male Video', 75),
	   ('Tony Best Play Actress', 80);
insert into Work(Name, Type, DBScore)
values ('The Danish Girl', 'movie', 8.7),
	   ('Clouds of Sils Maria', 'movie', null),
	   ('Watermelon Sugar', 'music', 7.9),
	   ('The College Dropout', 'music',9.3),
	   ('Unapologetic', 'music',7.8),
	   ('Silver Linings Playbook', 'movie', 8.8),
	   ('Savage', 'music',8.6),
	   ('Harry Potter', 'movie', 9.0),
	   ('Euphoria', 'TV series', 7.9),
	   ('Spider-Man: Homecoming','movie', null);
insert into Brand(Name, Type)
values ('LV', 'luxury fashion'),
	   ('Chanel', 'luxury fashion'),
	   ('Gucci', 'luxury fashion'),
	   ('Nike', 'athletic'),
	   ('Adidas', 'athletic'),
	   ('Savage X Fenty', 'clothes'),
	   ('Dior', 'Luxury fashion'),
	   ('Ivy Park', 'clothes'),
	   ('Lancôme', 'cosmetics'),
	   ('Tommy Hilfiger','fashion');
insert into Platform(Name, DailyUsers)
values ('Facebook', 1800000000 ),
	   ('YouTube', 2000000000),
	   ('RedBook', 100000000),
	   ('Instagram', 500000000),
	   ('TikTok', 1000000000),
	   ('Sina Weibo', 222000000),
	   ('Reddit', 52000000),
	   ('Twitter', 192000000),
	   ('Tumblr', 10000000),
	   ('KuaiShou', 300000000);
-- Adding more awards for the same celebrities, possibly for different works or the same work at different times
insert into Award_Winning(CelebrityID, AwardID, WorkID, Date)
values 
    (1, 1, 1, '2016-02-28'), -- Alicia Vikander for The Danish Girl at Oscars (repeated for reference)
	(1, 2, 1, '2017-04-22'), -- Assuming another award for 'The Danish Girl'
	(1, 9, 1, '2017-05-13'), -- Fictional award for versatility in 'The Danish Girl'
    (1, 10,1, '2016-03-15'), -- Alicia Vikander for The Danish Girl at Tony (fictional, showing versatility)
    (2, 2, 2, '2015-02-20'), -- Kristen Stewart for Clouds of Sils Maria at Césars (repeated for reference)
    (2, 6, 2, '2016-03-11'), -- Fictional Grammy for a soundtrack contribution in 'Clouds of Sils Maria'
    (2, 7, 2, '2015-08-16'), -- Kristen Stewart for Clouds of Sils Maria at Teen Choice (fictional, for broader appeal)
    (2, 8, 2, '2016-07-19'), -- Primetime Emmy for a fictional TV adaptation
    (3, 3, 3, '2020-11-24'), -- Harry Styles for Watermelon Sugar at Grammys (repeated for reference)
    (3, 9, 3, '2020-12-05'), -- Harry Styles for Watermelon Sugar at MTV VMA (showcasing cross-industry recognition)
    (6, 4, 4, '2005-02-13'), -- Kanye West for The College Dropout at Grammys (repeated for reference)
    (6, 6, 4, '2006-02-08'), -- Kanye West for The College Dropout at Grammy Album of the Year (adding prestigious recognition)
    (7, 3, 5, '2014-02-10'), -- Rihanna for a music performance related to Unapologetic at Grammy Best Pop Solo
    (7, 5, 5, '2014-01-26'), -- Rihanna for Unapologetic at Grammys (repeated for reference)
    (7, 6, 5, '2015-02-08'), -- Grammy Album of the Year for a different album
    (8, 1, 6, '2014-11-21'), -- Another Oscar for a different movie
    (8, 2, 6, '2015-02-17'), -- César Best Actress for a French film project
    (8, 6, 6, '2013-09-22'), -- Jennifer Lawrence for Silver Linings Playbook at Grammys Album of the Year (fictional)
    (8, 7, 6, '2013-10-10'), -- Jennifer Lawrence for Silver Linings Playbook at Teen Choice Movie Actress
    (9, 3, 7, '2013-08-25'), -- Grammy Best Pop Solo for a single from 'Savage'
    (9, 4, 7, '2014-12-14'), -- Grammy Best Rap Album for a collaborative project   
    (9, 3, 8, '2012-01-12'), -- Beyoncé for a song in Harry Potter (highly fictional, assuming Grammy Best Pop Solo)
    (9, 7, 8, '2011-08-07'), -- Beyoncé for Harry Potter (fictional, repeated for reference)
    (10, 7, 9, '2021-02-14'), -- Emma Watson for Euphoria at Teen Choice Movie Actress (expanding on her recognition)
    (10, 8, 9, '2020-09-20'), -- Emma Watson for Euphoria at Primetime Emmy (fictional, repeated for reference)
    (10, 1, 9, '2023-04-15'), -- Oscar Best Actress for a groundbreaking performance
    (10, 7, 9, '2022-03-27'); -- Teen Choice Movie Actress for a new role in a different movie	


-- Aligning celebrity roles with the specified works
insert into Participation(CelebrityID, WorkID, Role)
values 
    -- Alicia Vikander
    (1, 1, 'Lead Actress'), -- 'The Danish Girl'
    (1, 10, 'Supporting Actress'), -- Fictional role in 'Spider-Man: Homecoming'

    -- Kristen Stewart
    (2, 2, 'Supporting Actress'), -- 'Clouds of Sils Maria'
    (2, 9, 'Guest Star'), -- Fictional appearance in 'Euphoria'

    -- Harry Styles
    (3, 3, 'Singer'), -- 'Watermelon Sugar'
    (3, 8, 'Cameo'), -- Fictional cameo in 'Harry Potter'

    -- Jason Statham, assuming new entries based on provided works
    (4, 10, 'Stunt Advisor'), -- Fictional role in 'Spider-Man: Homecoming'
    
    -- Zendaya, aligning with an existing work
    (5, 10, 'Lead Actress'), -- Actual role in 'Spider-Man: Homecoming'\

    -- Kanye West
    (6, 4, 'Producer'), -- 'The College Dropout'
    (6, 7, 'Composer'), -- Fictional music composition for 'Savage'

    -- Rihanna
    (7, 5, 'Lead Singer'), -- 'Unapologetic'
    (7, 9, 'Music Producer'), -- Fictional music production for 'Euphoria'

    -- Jennifer Lawrence
    (8, 6, 'Lead Actress'), -- 'Silver Linings Playbook'
    (8, 1, 'Producer'), -- Fictional producer role for 'The Danish Girl'

    -- Beyoncé
    (9, 7, 'Songwriter'), -- Fictional songwriter for 'Savage'
    (9, 8, 'Guest Voice'), -- Fictional voice role in 'Harry Potter'

    -- Emma Watson
    (10, 9, 'Lead Actress'), -- 'Euphoria', assuming a new season or fictional scenario
    (10, 8, 'Narrator'); -- Fictional narrator role in a 'Harry Potter' documentary


-- Extending to all platforms for each celebrity
insert into Account(PlatformID, CelebrityID, FanAmount)
values 
    -- Alicia Vikander across all platforms
    (1, 1, 2000000), -- Facebook
    (2, 1, 3000000), -- YouTube
    (3, 1, 1000000), -- RedBook
    (4, 1, 5000000), -- Instagram
    (5, 1, 1500000), -- TikTok
    (6, 1, 500000),  -- Sina Weibo
    (7, 1, 250000),  -- Reddit
    (8, 1, 2000000), -- Twitter
    (9, 1, 100000),  -- Tumblr
    (10, 1, 500000), -- KuaiShou
    
    -- Kristen Stewart across all platforms (example incrementing for demonstration)
    (1, 2, 2500000), 
    (2, 2, 3500000), 
    (3, 2, 1200000), 
    (4, 2, 6000000), 
    (5, 2, 1800000), 
    (6, 2, 550000),  
    (7, 2, 300000),  
    (8, 2, 2200000), 
    (9, 2, 150000),  
    (10, 2, 550000),
    
    -- Following the pattern for Harry Styles
	-- Harry Styles across all platforms, with varying fan amounts
	(1, 3, 3500000),  -- Facebook
	(2, 3, 4500000),  -- YouTube
	(3, 3, 2000000),  -- RedBook
	(4, 3, 6000000),  -- Instagram
	(5, 3, 8000000),  -- TikTok
	(6, 3, 2500000),  -- Sina Weibo
	(7, 3, 1500000),  -- Reddit
	(8, 3, 5000000),  -- Twitter
	(9, 3, 800000),   -- Tumblr
	(10, 3, 2200000), -- KuaiShou

	-- Jason Statham across all platforms, with varying fan amounts
	(1, 4, 2500000),  -- Facebook
	(2, 4, 3000000),  -- YouTube
	(3, 4, 800000),   -- RedBook
	(4, 4, 4000000),  -- Instagram
	(5, 4, 1000000),  -- TikTok
	(6, 4, 500000),   -- Sina Weibo
	(7, 4, 300000),   -- Reddit
	(8, 4, 3500000),  -- Twitter
	(9, 4, 200000),   -- Tumblr
	(10, 4, 600000),  -- KuaiShou


	-- Zendaya Coleman across all platforms, with varying fan amounts
	(1, 5, 3000000),  -- Facebook
	(2, 5, 4500000),  -- YouTube
	(3, 5, 1200000),  -- RedBook
	(4, 5, 6000000),  -- Instagram
	(5, 5, 7000000),  -- TikTok
	(6, 5, 2000000),  -- Sina Weibo
	(7, 5, 1000000),  -- Reddit
	(8, 5, 4000000),  -- Twitter
	(9, 5, 500000),   -- Tumblr
	(10, 5, 1500000), -- KuaiShou

    -- Continuing this pattern for the remaining celebrities
    -- Note: For brevity, only a subset is shown. You should continue this pattern for each celebrity across all platforms.

    -- Example continuation for Kanye West
    (1, 6, 5000000), 
    (2, 6, 8000000), 
    (3, 6, 2000000), 
    (4, 6, 10000000), -- Already provided, shown for continuity
    (5, 6, 3000000), 
    (6, 6, 1000000),  
    (7, 6, 800000),  
    (8, 6, 12000000), -- Twitter, higher due to his active presence
    (9, 6, 600000),  
    (10, 6, 1500000),

	-- Rihanna across all platforms
	(1, 7, 4000000), 
	(2, 7, 5000000), 
	(3, 7, 2500000), 
	(4, 7, 9000000), -- Instagram
	(5, 7, 4000000), 
	(6, 7, 1500000),  
	(7, 7, 1000000),  
	(8, 7, 3000000), 
	(9, 7, 700000),  
	(10, 7, 2000000),

	-- Jennifer Lawrence across all platforms
	(1, 8, 4500000), 
	(2, 8, 5500000), 
	(3, 8, 1300000), 
	(4, 8, 11000000), -- Instagram
	(5, 8, 2000000), 
	(6, 8, 600000),  
	(7, 8, 350000),  
	(8, 8, 2500000), 
	(9, 8, 160000),  
	(10, 8, 600000),

	-- Beyoncé across all platforms
	(1, 9, 7000000), 
	(2, 9, 9000000), 
	(3, 9, 3500000), 
	(4, 9, 15000000), -- Instagram
	(5, 9, 12000000), -- TikTok
	(6, 9, 2500000),  
	(7, 9, 2000000),  
	(8, 9, 11000000), 
	(9, 9, 800000),  
	(10, 9, 3000000),

	-- Emma Watson across all platforms
	(1, 10, 3000000), 
	(2, 10, 4000000), 
	(3, 10, 1800000), 
	(4, 10, 7000000), -- Instagram
	(5, 10, 2200000), 
	(6, 10, 700000),  
	(7, 10, 400000),  
	(8, 10, 2300000), 
	(9, 10, 170000),  
	(10, 10, 650000);



insert into Post(AccountID, NumberLikes, NumberComments, NumberRetweets, Date, BrandName)
values 
	(100, 495798, 15341, 6263, '2023-12-24', 'null'),
	(100, 637080, 27632, 5564, '2023-05-03', 'Lancôme'),
	(100, 606116, 1037, 11121, '2023-09-09', 'null'),
	(98, 600121, 40111, 9773, '2023-02-22', 'null'),
	(98, 237330, 34271, 3986, '2023-11-18', 'Lancôme'),
	(98, 894962, 11463, 14348, '2023-06-25', 'null'),
	(97, 572707, 41986, 14984, '2023-01-28', 'Lancôme'),
	(97, 922335, 28627, 8766, '2023-02-12', 'null'),
	(97, 458930, 28460, 18136, '2023-10-08', 'null'),
	(97, 296277, 45092, 10671, '2023-04-27', 'null'),
	(96, 755000, 18181, 19654, '2023-07-16', 'Lancôme'),
	(96, 570856, 19756, 8040, '2023-11-08', 'null'),
	(96, 545951, 47217, 12992, '2023-07-18', 'null'),
	(96, 378838, 4746, 2143, '2023-10-28', 'null'),
	(95, 387978, 40564, 8704, '2023-01-15', 'Lancôme'),
	(95, 154053, 14617, 7414, '2023-05-17', 'null'),
	(95, 227934, 44178, 3278, '2023-05-27', 'null'),
	(95, 900132, 17263, 9242, '2023-03-24', 'Lancôme'),
	(95, 513298, 37154, 14514, '2023-10-16', 'null'),
	(95, 985518, 36741, 3348, '2023-10-31', 'null'),
	(94, 671254, 18589, 11061, '2023-05-07', 'null'),
	(94, 874629, 21557, 14799, '2023-11-08', 'null'),
	(94, 405784, 8161, 8647, '2023-04-10', 'null'),
	(94, 559597, 5535, 17955, '2023-03-07', 'Lancôme'),
	(94, 306702, 11708, 15647, '2023-07-15', 'null'),
	(93, 968398, 48164, 9130, '2023-09-15', 'null'),
	(92, 564663, 30371, 1065, '2023-02-18', 'null'),
	(92, 379445, 16642, 9203, '2023-07-23', 'Lancôme'),
	(92, 560311, 11144, 6722, '2023-06-02', 'null'),
	(91, 711759, 4858, 8001, '2023-02-05', 'null'),
	(91, 122933, 4003, 7967, '2023-05-30', 'null'),
	(90, 182413, 42803, 16585, '2023-02-23', 'Adidas'),
	(90, 860004, 20764, 4466, '2023-10-18', 'Lancôme'),
	(90, 360016, 37333, 4670, '2023-04-10', 'null'),
	(90, 163346, 26070, 1768, '2023-08-30', 'null'),
	(89, 569536, 19888, 13622, '2023-10-10', 'null'),
	(88, 866118, 49802, 2107, '2023-11-08', 'null'),
	(88, 302528, 33615, 19608, '2023-03-16', 'Adidas'),
	(88, 351338, 15908, 3461, '2023-08-12', 'null'),
	(88, 311650, 44708, 3868, '2023-07-02', 'Lancôme'),
	(88, 715046, 18300, 17061, '2023-09-09', 'null'),
	(88, 390035, 4665, 8005, '2023-01-18', 'null'),
	(88, 729514, 5679, 6107, '2023-10-02', 'null'),
	(87, 623149, 11353, 2920, '2023-08-16', 'Adidas'),
	(85, 465032, 18988, 765, '2023-10-18', 'null'),
	(85, 880884, 43730, 5484, '2023-09-12', 'Lancôme'),
	(85, 961597, 36559, 15638, '2023-08-01', 'Adidas'),
	(85, 135131, 11292, 8359, '2023-03-31', 'null'),
	(85, 659805, 25184, 16007, '2023-10-12', 'null'),
	(85, 158618, 9800, 9166, '2023-03-02', 'null'),
	(84, 153831, 33069, 13873, '2023-05-25', 'null'),
	(84, 211859, 5903, 15884, '2023-05-17', 'Lancôme'),
	(84, 513711, 19229, 6447, '2023-10-28', 'Adidas'),
	(84, 604634, 1512, 18673, '2023-06-04', 'null'),
	(84, 616847, 1967, 3556, '2023-05-03', 'null'),
	(84, 727568, 7449, 2486, '2023-07-27', 'null'),
	(84, 573481, 26928, 15535, '2023-03-16', 'null'),
	(83, 499433, 9893, 15628, '2023-04-05', 'Lancôme'),
	(83, 584150, 27193, 18070, '2023-06-20', 'Adidas'),
	(82, 439518, 8100, 8161, '2023-08-31', 'null'),
	(82, 166739, 2639, 9512, '2023-05-07', 'null'),
	(81, 668439, 44331, 6982, '2023-08-07', 'Lancôme'),
	(81, 653634, 13742, 13082, '2023-09-12', 'Adidas'),
	(81, 217753, 45596, 14333, '2023-11-03', 'null'),
	(81, 698564, 24700, 19418, '2023-04-10', 'null'),
	(80, 640341, 7552, 2900, '2023-10-04', 'Adidas'),
	(80, 135965, 28474, 19625, '2023-10-18', 'null'),
	(79, 904596, 48138, 17040, '2023-08-08', 'null'),
	(78, 991423, 15453, 16498, '2023-04-24', 'Adidas'),
	(78, 736508, 22118, 15736, '2023-08-16', 'null'),
	(78, 327370, 3847, 15554, '2023-10-03', 'null'),
	(77, 52973, 19171, 5241, '2023-03-09', 'null'),
	(77, 835339, 38303, 9957, '2023-08-14', 'Adidas'),
	(77, 879151, 41528, 7895, '2023-09-26', 'null'),
	(77, 785244, 19105, 18712, '2023-01-07', 'null'),
	(76, 828325, 48618, 5563, '2023-08-02', 'Adidas'),
	(76, 658093, 44249, 16544, '2023-03-19', 'null'),
	(74, 760250, 25596, 13497, '2023-04-13', 'null'),
	(73, 689979, 44790, 12918, '2023-06-23', 'Adidas'),
	(73, 365568, 27612, 18454, '2023-01-02', 'null'),
	(73, 308175, 38940, 19981, '2023-01-22', 'null'),
	(73, 968938, 48049, 10811, '2023-04-20', 'null'),
	(71, 849929, 36614, 12860, '2023-08-23', 'null'),
	(71, 128711, 11258, 587, '2023-07-30', 'Adidas'),
	(71, 517574, 11430, 16054, '2023-08-20', 'null'),
	(70, 312829, 12435, 4102, '2023-12-06', 'Adidas'),
	(70, 538557, 28248, 2540, '2023-04-17', 'null'),
	(70, 188739, 48405, 19211, '2023-10-24', 'null'),
	(70, 841952, 48836, 7091, '2023-06-10', 'Nike'),
	(69, 179592, 30804, 12577, '2023-12-12', 'Adidas'),
	(69, 862270, 32686, 15732, '2023-08-13', 'null'),
	(69, 837352, 18486, 11646, '2023-02-28', 'null'),
	(68, 410455, 28885, 18535, '2023-06-20', 'Adidas'),
	(68, 636075, 40023, 10897, '2023-08-16', 'null'),
	(67, 250337, 6610, 8408, '2023-07-29', 'Nike'),
	(67, 537115, 4291, 18765, '2023-05-09', 'null'),
	(67, 895687, 36287, 6956, '2023-07-07', 'Adidas'),
	(67, 381737, 18089, 7193, '2023-12-10', 'null'),
	(67, 523417, 8930, 8623, '2023-04-27', 'null'),
	(66, 789677, 18919, 14114, '2023-09-06', 'Nike'),
	(66, 746101, 42480, 11483, '2023-02-18', 'null'),
	(66, 171263, 26244, 19393, '2023-04-09', 'Adidas'),
	(66, 134002, 13178, 2745, '2023-11-02', 'null'),
	(65, 335765, 11783, 8920, '2023-09-05', 'null'),
	(64, 145325, 4087, 4092, '2023-03-21', 'Adidas'),
	(63, 632144, 16749, 16100, '2023-11-28', 'null'),
	(63, 707193, 16679, 9498, '2023-08-15', 'Adidas'),
	(62, 161834, 16545, 12996, '2023-10-21', 'Nike'),
	(62, 169629, 5282, 13630, '2023-09-10', 'null'),
	(62, 577276, 35807, 5658, '2023-01-31', 'Adidas'),
	(61, 305570, 30935, 18563, '2023-03-17', 'null'),
	(61, 70324, 36351, 2206, '2023-06-30', 'Nike'),
	(61, 690967, 5772, 15423, '2023-08-02', 'Adidas'),
	(61, 304801, 31996, 13838, '2023-04-09', 'null'),
	(60, 183827, 41780, 18002, '2023-01-15', 'Savage X Fenty'),
	(59, 439033, 44940, 18201, '2023-08-04', 'null'),
	(59, 66093, 48346, 5223, '2023-07-30', 'null'),
	(59, 124637, 46048, 8148, '2023-05-17', 'Savage X Fenty'),
	(59, 392722, 23118, 12923, '2023-05-24', 'null'),
	(58, 614742, 32741, 11809, '2023-06-21', 'Savage X Fenty'),
	(58, 772858, 39916, 15898, '2023-05-31', 'null'),
	(57, 297582, 24768, 3755, '2023-12-19', 'null'),
	(57, 84985, 38982, 12455, '2023-03-10', 'null'),
	(57, 973634, 46760, 16383, '2023-03-05', 'null'),
	(57, 134349, 40192, 1806, '2023-08-11', 'null'),
	(57, 407256, 13082, 2183, '2023-05-11', 'null'),
	(57, 758446, 15005, 17250, '2023-09-01', 'Savage X Fenty'),
	(57, 897272, 37066, 3708, '2023-01-27', 'null'),
	(56, 715620, 33225, 3489, '2023-08-30', 'null'),
	(56, 123372, 44531, 11319, '2023-11-17', 'Savage X Fenty'),
	(55, 370214, 38265, 2473, '2023-11-10', 'null'),
	(55, 919634, 19132, 1944, '2023-01-03', 'null'),
	(55, 780429, 48874, 18711, '2023-12-06', 'Savage X Fenty'),
	(55, 481071, 31606, 2275, '2023-12-12', 'null'),
	(55, 83326, 2952, 3570, '2023-04-23', 'null'),
	(54, 912276, 33125, 3958, '2023-08-11', 'null'),
	(54, 458396, 39278, 1140, '2023-10-23', 'Savage X Fenty'),
	(54, 747229, 25847, 6202, '2023-11-13', 'null'),
	(53, 643418, 45682, 6400, '2023-03-30', 'null'),
	(53, 147736, 15725, 4217, '2023-08-26', 'Savage X Fenty'),
	(52, 335470, 33798, 18194, '2023-09-11', 'null'),
	(52, 305836, 10671, 681, '2023-02-25', 'null'),
	(52, 996279, 4842, 5894, '2023-07-15', 'Savage X Fenty'),
	(52, 754314, 43590, 12736, '2023-08-14', 'null'),
	(52, 429580, 15373, 5032, '2023-09-19', 'null'),
	(51, 339282, 13439, 4502, '2023-08-22', 'Savage X Fenty'),
	(51, 670644, 37987, 1388, '2023-02-13', 'null'),
	(50, 294907, 27920, 1930, '2023-06-13', 'null'),
	(50, 249869, 40280, 17154, '2023-03-12', 'Dior'),
	(49, 522398, 30014, 10243, '2023-10-30', 'null'),
	(49, 550149, 1386, 12026, '2023-06-03', 'null'),
	(48, 620913, 43259, 12253, '2023-02-02', 'null'),
	(48, 501607, 10540, 8501, '2023-09-30', 'Dior'),
	(48, 122306, 34158, 11681, '2023-01-08', 'null'),
	(48, 422528, 14730, 9248, '2023-12-27', 'null'),
	(47, 144689, 26858, 956, '2023-05-17', 'null'),
	(47, 716459, 31129, 5513, '2023-08-12', 'Dior'),
	(47, 992650, 3614, 12224, '2023-04-19', 'null'),
	(46, 279642, 42721, 6730, '2023-11-15', 'null'),
	(46, 652733, 20390, 10174, '2023-01-13', 'Dior'),
	(46, 786996, 30736, 9377, '2023-06-07', 'null'),
	(45, 666113, 20605, 14403, '2023-12-21', 'null'),
	(45, 478184, 22843, 11020, '2023-12-11', 'Dior'),
	(44, 703534, 46397, 13524, '2023-11-30', 'Dior'),
	(44, 751364, 45508, 13748, '2023-03-27', 'null'),
	(43, 305400, 9252, 19000, '2023-04-17', 'null'),
	(43, 385239, 36399, 3140, '2023-03-13', 'null'),
	(43, 342136, 5549, 9646, '2023-06-30', 'Dior'),
	(43, 858577, 9573, 9083, '2023-03-25', 'null'),
	(42, 884816, 4677, 10113, '2023-07-04', 'null'),
	(42, 961843, 13363, 8325, '2023-10-21', 'Dior'),
	(42, 171552, 27488, 17362, '2023-01-02', 'null'),
	(41, 707246, 48101, 16489, '2023-10-06', 'null'),
	(41, 745612, 9167, 10340, '2023-09-18', 'null'),
	(41, 838387, 5754, 805, '2023-08-24', 'Dior'),
	(41, 470651, 18546, 2668, '2023-04-20', 'null'),
	(40, 163349, 38924, 1341, '2023-06-10', 'Nike'),
	(40, 749287, 27764, 11188, '2023-07-27', 'null'),
	(39, 730776, 27758, 4323, '2023-03-14', 'Nike'),
	(39, 64835, 47400, 18002, '2023-03-07', 'null'),
	(39, 350850, 14774, 14586, '2023-10-25', 'null'),
	(39, 932554, 42874, 17135, '2023-11-09', 'null'),
	(38, 832824, 23198, 4273, '2023-08-29', 'null'),
	(38, 282360, 27502, 8472, '2023-06-07', 'Nike'),
	(38, 505884, 11365, 15367, '2023-01-03', 'null'),
	(37, 684210, 14803, 11735, '2023-04-16', 'Nike'),
	(36, 97726, 4573, 18632, '2023-05-31', 'null'),
	(36, 525435, 42660, 12454, '2023-03-26', 'Nike'),
	(36, 213032, 15110, 11529, '2023-02-23', 'null'),
	(35, 910408, 1168, 9768, '2023-06-03', 'null'),
	(35, 507007, 32827, 1451, '2023-07-20', 'null'),
	(35, 721088, 46099, 18750, '2023-04-24', 'Nike'),
	(34, 838295, 17203, 9586, '2023-09-25', 'null'),
	(34, 90115, 8104, 14739, '2023-06-27', 'null'),
	(34, 603306, 40753, 14365, '2023-04-20', 'Nike'),
	(34, 833300, 39311, 14538, '2023-10-27', 'null'),
	(34, 196413, 17162, 18894, '2023-10-04', 'null'),
	(33, 760687, 48246, 4981, '2023-11-19', 'null'),
	(33, 529027, 20799, 7027, '2023-07-17', 'null'),
	(33, 749233, 1615, 15745, '2023-05-29', 'Nike'),
	(33, 291736, 8907, 6810, '2023-06-12', 'null'),
	(33, 96542, 47450, 14788, '2023-01-02', 'null'),
	(33, 999314, 4329, 3524, '2023-11-22', 'null'),
	(33, 630099, 1752, 4253, '2023-12-17', 'null'),
	(32, 174205, 37573, 14137, '2023-11-08', 'null'),
	(32, 259044, 2335, 5493, '2023-05-04', 'Nike'),
	(31, 342004, 44842, 16406, '2023-04-21', 'Nike'),
	(30, 533550, 42805, 8822, '2023-08-25', 'null'),
	(30, 283752, 2550, 6828, '2023-07-25', 'Gucci'),
	(30, 667024, 15432, 735, '2023-02-07', 'null'),
	(30, 579903, 40453, 1369, '2023-10-16', 'null'),
	(29, 729112, 5142, 15713, '2023-12-26', 'null'),
	(29, 731725, 5496, 1819, '2023-01-17', 'null'),
	(29, 259267, 31166, 11957, '2023-06-07', 'null'),
	(29, 521029, 39618, 9615, '2023-01-05', 'Gucci'),
	(29, 196316, 49265, 3858, '2023-12-14', 'null'),
	(28, 902547, 16269, 11266, '2023-03-18', 'null'),
	(28, 824483, 32732, 9560, '2023-10-30', 'null'),
	(28, 422060, 17931, 11652, '2023-05-25', 'null'),
	(28, 537623, 46840, 8896, '2023-07-09', 'null'),
	(28, 117348, 28188, 13856, '2023-06-20', 'null'),
	(28, 580458, 18380, 4840, '2023-06-29', 'Gucci'),
	(28, 111324, 38957, 18266, '2023-02-02', 'null'),
	(27, 330028, 36993, 4793, '2023-05-29', 'null'),
	(26, 188579, 36350, 12488, '2023-09-30', 'null'),
	(26, 204511, 2600, 2014, '2023-05-07', 'Gucci'),
	(26, 210263, 25504, 5793, '2023-10-05', 'null'),
	(26, 800800, 43590, 18356, '2023-08-04', 'null'),
	(25, 360636, 15908, 12325, '2023-04-03', 'null'),
	(25, 612336, 30400, 5093, '2023-08-06', 'Gucci'),
	(24, 342075, 31318, 8685, '2023-02-09', 'null'),
	(23, 132804, 40943, 13035, '2023-11-15', 'Gucci'),
	(23, 819440, 35193, 9350, '2023-11-13', 'null'),
	(23, 822343, 22770, 13991, '2023-12-10', 'null'),
	(22, 777712, 20625, 1448, '2023-01-25', 'null'),
	(22, 685324, 40796, 4253, '2023-03-26', 'Gucci'),
	(22, 476156, 32826, 16273, '2023-04-21', 'null'),
	(21, 375845, 37099, 948, '2023-10-11', 'null'),
	(21, 888742, 12603, 14010, '2023-01-14', 'Gucci'),
	(21, 509469, 36600, 10412, '2023-11-11', 'null'),
	(20, 900544, 37886, 10456, '2023-02-14', 'Ivy Park'),
	(20, 292495, 26102, 5507, '2023-12-29', 'Chanel'),
	(19, 124878, 4908, 5936, '2023-06-08', 'null'),
	(19, 500664, 9352, 1870, '2023-06-08', 'Chanel'),
	(17, 546564, 44873, 4248, '2023-10-17', 'null'),
	(17, 754318, 43303, 10330, '2023-08-24', 'Ivy Park'),
	(17, 741798, 32148, 18515, '2023-03-27', 'Chanel'),
	(16, 729172, 11090, 16830, '2023-05-31', 'null'),
	(16, 541465, 46133, 10464, '2023-12-26', 'Ivy Park'),
	(16, 828967, 36118, 6566, '2023-04-10', 'null'),
	(16, 528634, 9738, 15725, '2023-12-09', 'Chanel'),
	(16, 446922, 6164, 18589, '2023-06-01', 'null'),
	(15, 621015, 15733, 5382, '2023-05-18', 'Chanel'),
	(14, 949398, 11539, 11307, '2023-07-31', 'Ivy Park'),
	(14, 828480, 37256, 5593, '2023-05-21', 'Chanel'),
	(13, 296205, 36228, 4945, '2023-07-19', 'null'),
	(13, 997287, 42121, 1791, '2023-06-09', 'null'),
	(13, 847305, 42533, 3793, '2023-08-17', 'Ivy Park'),
	(13, 966655, 29855, 3767, '2023-09-28', 'Chanel'),
	(13, 151639, 44187, 14624, '2023-07-02', 'null'),
	(12, 744963, 14900, 1199, '2023-01-27', 'null'),
	(12, 359445, 22411, 14115, '2023-04-01', 'Ivy Park'),
	(12, 290044, 45190, 19348, '2023-10-29', 'null'),
	(12, 342477, 30543, 8490, '2023-08-27', 'Chanel'),
	(12, 448382, 7338, 12263, '2023-06-27', 'null'),
	(11, 943140, 22532, 17985, '2023-07-15', 'Chanel'),
	(11, 946865, 16256, 3809, '2023-07-15', 'null'),
	(10, 197594, 15785, 13522, '2023-10-14', 'null'),
	(10, 655050, 42251, 2256, '2023-03-20', 'LV'),
	(10, 670859, 46260, 8457, '2023-02-23', 'Tommy Hilfiger'),
	(10, 798206, 19725, 8183, '2023-05-21', 'null'),
	(9, 920127, 37320, 7288, '2023-10-29', 'null'),
	(9, 339666, 28193, 11637, '2023-09-18', 'null'),
	(9, 971981, 17009, 12608, '2023-05-27', 'null'),
	(9, 758011, 16414, 13730, '2023-03-04', 'Tommy Hilfiger'),
	(9, 404508, 2378, 19777, '2023-10-12', 'LV'),
	(9, 453457, 26009, 15837, '2023-09-29', 'null'),
	(8, 302572, 38182, 3080, '2023-02-14', 'Tommy Hilfiger'),
	(7, 246694, 34976, 12354, '2023-11-16', 'LV'),
	(7, 322793, 25844, 11226, '2023-04-20', 'null'),
	(6, 89019, 20946, 16642, '2023-03-02', 'LV'),
	(6, 850177, 12481, 15917, '2023-09-24', 'null'),
	(6, 414069, 35913, 14537, '2023-12-06', 'null'),
	(5, 773811, 25283, 7619, '2023-08-17', 'Tommy Hilfiger'),
	(5, 697453, 5484, 8192, '2023-11-21', 'null'),
	(5, 182378, 33918, 19839, '2023-06-20', 'null'),
	(5, 526919, 6771, 10806, '2023-05-11', 'LV'),
	(5, 292720, 19881, 9764, '2023-12-27', 'null'),
	(5, 925136, 25196, 19587, '2023-10-11', 'null'),
	(5, 951393, 22654, 2821, '2023-09-22', 'Tommy Hilfiger'),
	(4, 188205, 1973, 12238, '2023-05-03', 'null'),
	(4, 699641, 37792, 11248, '2023-11-10', 'LV'),
	(4, 710626, 40903, 8341, '2023-12-31', 'null'),
	(4, 568317, 22300, 6458, '2023-09-08', 'Tommy Hilfiger'),
	(4, 170944, 18118, 6351, '2023-10-26', 'null'),
	(3, 851909, 45058, 9331, '2023-10-24', 'Tommy Hilfiger'),
	(3, 167301, 24788, 10576, '2023-05-04', 'LV'),
	(2, 819250, 44422, 26457, '2023-04-10', 'LV'),
	(2, 651949, 19634, 15881, '2023-09-04', 'null'),
	(2, 167308, 5931, 5384, '2023-10-08', 'Tommy Hilfiger'),
	(1, 626694, 24311, 20793, '2023-05-28', 'LV'),
	(1, 459386, 18380, 15409, '2023-05-28', 'null');
	
INSERT INTO News (TwitterLink, Keyword, Date, Views) VALUES
('http://twitter.com/news1', 'keyword5', '2024-01-01', 926600),
('http://twitter.com/news2', 'keyword3', '2024-01-02', 427473),
('http://twitter.com/news3', 'keyword1', '2024-01-03', 70309),
('http://twitter.com/news4', 'keyword1', '2024-01-04', 249178),
('http://twitter.com/news5', 'keyword3', '2024-01-05', 259975),
('http://twitter.com/news6', 'keyword5', '2024-01-06', 363634),
('http://twitter.com/news7', 'keyword4', '2024-01-07', 468784),
('http://twitter.com/news8', 'keyword5', '2024-01-08', 314927),
('http://twitter.com/news9', 'keyword1', '2024-01-09', 239105),
('http://twitter.com/news10', 'keyword1', '2024-01-10', 1117332),
('http://twitter.com/news11', 'keyword2', '2024-02-01', 858204),
('http://twitter.com/news12', 'keyword2', '2024-02-02', 42448),
('http://twitter.com/news13', 'keyword3', '2024-02-03', 64779),
('http://twitter.com/news14', 'keyword4', '2024-02-04', 31192),
('http://twitter.com/news15', 'keyword3', '2024-02-05', 663003),
('http://twitter.com/news16', 'keyword5', '2024-02-06', 663003),
('http://twitter.com/news17', 'keyword3', '2024-02-07', 55696),
('http://twitter.com/news18', 'keyword2', '2024-02-08', 747503),
('http://twitter.com/news19', 'keyword2', '2024-02-09', 82064),
('http://twitter.com/news20', 'keyword1', '2024-02-10', 414653);



INSERT INTO CelebrityNews (CelebrityID, NewsID) VALUES
(1, 7),--Alicia Vikander
(2, 5),--Kristen Stewart
(3, 17),--Harry Styles
(4, 19),--Jason Statham
(5, 18),--Zendaya Coleman
(6, 9),--Kanye West
(7, 11),--Rihanna Fenty
(8, 10),--Jennifer Lawrence
(9, 1),--Beyoncé
(10, 14),--Emma Watson
(1, 12),--Alicia Vikander
(2, 15),--Kristen Stewart
(3, 13),--Harry Styles
(4, 3),--Jason Statham
(5, 2),--Zendaya Coleman
(6, 8),--Kanye West
(7, 20),--Rihanna Fenty
(8, 16),--Jennifer Lawrence
(9, 4),--Beyoncé
(10, 6),--Emma Watson
(1, 1),
(2, 1),
(3, 2),
(7, 9),
(1, 3);


INSERT INTO Endorsement (CelebrityID, BrandID, Title, StartDate, EndDate) VALUES
(1, 1, 'Ambassador', '2020-01-01', '2025-12-31'),
(2, 2, 'Ambassador', '2019-01-01', '2026-12-31'),
(3, 3, 'GlobalAmbassador', '2018-01-01', '2027-12-31'),
(4, 4, 'Endorser', '2017-01-01', '2028-12-31'),
(5, 4, 'Endorser', '2016-01-01', '2029-12-31'),
(6, 5, 'Collaborator', '2015-01-01', '2030-12-31'),
(7, 6, 'Founder', '2020-02-01', '2025-12-30'),
(8, 7, 'Muse', '2019-02-01', '2026-12-30'),
(9, 8, 'Founder', '2018-02-01', '2027-12-30'),
(10, 9, 'Ambassador', '2017-02-01', '2028-12-30'),
(5, 10, 'Collaborator', '2016-02-01', '2029-12-30');



INSERT INTO SalePlatformData (BrandID, platformName, platformSales, Date) VALUES

--LV
(1, 'Amazon', 1583000.00, '2024-01-01'),
(1, 'Alibaba', 34000.00, '2024-01-01'),
(1, 'eBay', 11981000.00, '2024-01-01'),
(1, 'Walmart', 153000.00, '2024-01-01'),
(1, 'JD', 1038000.00, '2024-01-01'),
(1, 'Shopify', 1814000.00, '2024-01-01'),
(1, 'Etsy', 228000.00, '2024-01-01'),
(1, 'Temu', 1044000.00, '2024-01-01'),
(1, 'Shein', 1026000.00, '2024-01-01'),
(1, 'Taobao', 1381000.00, '2024-01-01'),

--Chanel
(2, 'Amazon', 932000.00, '2024-01-01'),
(2, 'Alibaba', 347000.00, '2024-01-01'),
(2, 'eBay', 805000.00, '2024-01-01'),
(2, 'Walmart', 413000.00, '2024-01-01'),
(2, 'JD', 545000.00, '2024-01-01'),
(2, 'Shopify', 11871000.00, '2024-01-01'),
(2, 'Etsy', 1631000.00, '2024-01-01'),
(2, 'Temu', 1639000.00, '2024-01-01'),
(2, 'Shein', 163000.00, '2024-01-01'),
(2, 'Taobao', 983000.00, '2024-01-01'),

--Gucci
(3, 'Amazon', 1524000.00, '2024-01-01'),
(3, 'Alibaba', 1098000.00, '2024-01-01'),
(3, 'eBay', 1487000.00, '2024-01-01'),
(3, 'Walmart', 1476000.00, '2024-01-01'),
(3, 'JD', 1611000.00, '2024-01-01'),
(3, 'Shopify', 1569000.00, '2024-01-01'),
(3, 'Etsy', 75000.00, '2024-01-01'),
(3, 'Temu', 1864000.00, '2024-01-01'),
(3, 'Shein', 15000.00, '2024-01-01'),
(3, 'Taobao',171000.00, '2024-01-01'),

--Nike
(4, 'Amazon', 681000.00, '2024-01-01'),
(4, 'Alibaba', 1287000.00, '2024-01-01'),
(4, 'eBay', 1621000.00, '2024-01-01'),
(4, 'Walmart', 1464000.00, '2024-01-01'),
(4, 'JD', 715000.00, '2024-01-01'),
(4, 'Shopify', 1965000.00, '2024-01-01'),
(4, 'Etsy', 1952000.00, '2024-01-01'),
(4, 'Temu', 1138000.00, '2024-01-01'),
(4, 'Shein', 399000.00, '2024-01-01'),
(4, 'Taobao', 405000.00, '2024-01-01'),

--Adidas
(5, 'Amazon', 1450000.00, '2024-01-01'),
(5, 'Alibaba', 878000.00, '2024-01-01'),
(5, 'eBay', 1607000.00, '2024-01-01'),
(5, 'Walmart', 612000.00, '2024-01-01'),
(5, 'JD', 762000.00, '2024-01-01'),
(5, 'Shopify', 1523000.00, '2024-01-01'),
(5, 'Etsy', 1548000.00, '2024-01-01'),
(5, 'Temu', 1490000.00, '2024-01-01'),
(5, 'Shein', 522000.00, '2024-01-01'),
(5, 'Taobao', 465000.00, '2024-01-01'),

--Savage X Fenty
(6, 'Amazon', 565000.00, '2024-01-01'),
(6, 'Alibaba', 921000.00, '2024-01-01'),
(6, 'eBay', 139000.00, '2024-01-01'),
(6, 'Walmart', 181000.00, '2024-01-01'),
(6, 'JD', 506000.00, '2024-01-01'),
(6, 'Shopify', 978000.00, '2024-01-01'),
(6, 'Etsy', 839000.00, '2024-01-01'),
(6, 'Temu', 815000.00, '2024-01-01'),
(6, 'Shein', 1249000.00, '2024-01-01'),
(6, 'Taobao', 491000.00, '2024-01-01'),

--Dior
(7, 'Amazon', 1926000.00, '2024-01-01'),
(7, 'Alibaba', 176000.00, '2024-01-01'),
(7, 'eBay', 1224000.00, '2024-01-01'),
(7, 'Walmart', 1180000.00, '2024-01-01'),
(7, 'JD', 433000.00, '2024-01-01'),
(7, 'Shopify', 1641000.00, '2024-01-01'),
(7, 'Etsy', 657000.00, '2024-01-01'),
(7, 'Temu', 598000.00, '2024-01-01'),
(7, 'Shein', 455000.00, '2024-01-01'),
(7, 'Taobao', 28000.00, '2024-01-01'),

--Ivy Park
(8, 'Amazon', 693000.00, '2024-01-01'),
(8, 'Alibaba', 576000.00, '2024-01-01'),
(8, 'eBay', 187000.00, '2024-01-01'),
(8, 'Walmart', 1948000.00, '2024-01-01'),
(8, 'JD', 1808000.00, '2024-01-01'),
(8, 'Shopify', 400000.00, '2024-01-01'),
(8, 'Etsy', 416000.00, '2024-01-01'),
(8, 'Temu', 591000.00, '2024-01-01'),
(8, 'Shein', 543000.00, '2024-01-01'),
(8, 'Taobao', 643000.00, '2024-01-01'),

-- Lancôme
(9, 'Amazon', 1347000.00, '2024-01-01'),
(9, 'Alibaba', 1316000.00, '2024-01-01'),
(9, 'eBay', 1920000.00, '2024-01-01'),
(9, 'Walmart', 11499000.00, '2024-01-01'),
(9, 'JD', 1367000.00, '2024-01-01'),
(9, 'Shopify', 418000.00, '2024-01-01'),
(9, 'Etsy', 1083000.00, '2024-01-01'),
(9, 'Temu', 37000.00, '2024-01-01'),
(9, 'Shein', 205000.00, '2024-01-01'),
(9, 'Taobao', 332000.00, '2024-01-01'),

--Tommy Hilfiger
(10, 'Amazon', 728000.00, '2024-01-01'),
(10, 'Alibaba', 442000.00, '2024-01-01'),
(10, 'eBay', 1015000.00, '2024-01-01'),
(10, 'Walmart', 499000.00, '2024-01-01'),
(10, 'JD', 694000.00, '2024-01-01'),
(10, 'Shopify', 493000.00, '2024-01-01'),
(10, 'Etsy', 1347000.00, '2024-01-01'),
(10, 'Temu', 377000.00, '2024-01-01'),
(10, 'Shein', 1672000.00, '2024-01-01'),
(10, 'Taobao', 595000.00, '2024-01-01');
