INSERT INTO USER (Email, Password, Date_Joined, Fname, Lname, Gender) VALUES("ayse.can@gmail.com","123456","2005-01-01","Ayşe","Can",2);
INSERT INTO USER (Email, Password, Date_Joined, Fname, Lname, Gender) VALUES("samet.aydin@gmail.com","123444","2006-01-01","Samet","Aydın",1);
INSERT INTO USER (Email, Password, Date_Joined, Fname, Lname, Gender) VALUES("onur.al@gmail.com","123456","2007-01-01","Onur","Al",1);
INSERT INTO USER (Email, Password, Date_Joined, Fname, Lname, Gender) VALUES("deniz.ay@gmail.com","123456","2008-01-01","Deniz", "Ay",2);
INSERT INTO USER (Email, Password, Date_Joined, Fname, Mname, Lname, Gender) VALUES("fikret.han@gmail.com","123456","2008-01-01","Fikret","Rasim","Han",1);


INSERT INTO COUNTRY (Country) VALUES("TURKIYE");
INSERT INTO COUNTRY (Country) VALUES("ENGLAND");


INSERT INTO CITY (City, Country_ID) VALUES("IZMIR",201);
INSERT INTO CITY (City, Country_ID) VALUES("AYDIN",201);
INSERT INTO CITY (City, Country_ID) VALUES("DENIZLI",201);
INSERT INTO CITY (City, Country_ID) VALUES("ESKİSEHİR",201);
 
 
INSERT INTO ADDRESS (Address, City_ID, Zip) VALUES("KONAK",301,725);
INSERT INTO ADDRESS (Address, City_ID, Zip) VALUES("BORNOVA",301,726);
INSERT INTO ADDRESS (Address, City_ID, Zip) VALUES("ALSANCAK",301,825);
INSERT INTO ADDRESS (Address, City_ID, Zip) VALUES("CINAR",303,826);
INSERT INTO ADDRESS (Address, City_ID, Zip) VALUES("BAYRAMYERI",303,826);


INSERT INTO ORGANIZATION (Organization_Name, Address_ID, Organization_Description) VALUES("BilisimB",401,"organizasyon_desp.");
INSERT INTO ORGANIZATION (Organization_Name, Address_ID, Organization_Description) VALUES("ProjeYonetimi",402,"organizasyon_desp_vsvsvss");


INSERT INTO PROFILE (User_ID, Address_ID, Current_Organization_ID, Relationship, Date_of_Birth, Phone, About_Me, Interests, Begin_Organization) VALUES(1,401,751,1,"1993-01-24","05**123567","kendin hakkinda yaz","ilgi alanlarini yaz","2013-05-19");
INSERT INTO PROFILE (User_ID, Address_ID, Current_Organization_ID, Relationship, Date_of_Birth, Phone, About_Me, Interests, Begin_Organization) VALUES(2,401,751,2,"1993-01-24","05**123444","kendin hakkinda yaz","ilgi alanlarini yaz","2013-05-19");
INSERT INTO PROFILE (User_ID, Address_ID, Current_Organization_ID, Date_of_Birth, Phone, Interests, Hobbies, Educations) VALUES(3,402,751,"1993-05-19","05**123555","ilgi alanlarini yaz"," hobileri"," egitim bilgileri");
INSERT INTO PROFILE (User_ID, Address_ID, Current_Organization_ID, Relationship, Date_of_Birth, Phone, About_Me, Interests, Hobbies, Begin_Organization) VALUES(4,403,752,4,"1994-03-20","05**123956","kendin hakkinda yaz","ilgi alanlarini yaz","hobileri... ","2012-05-06");
INSERT INTO PROFILE (User_ID, Address_ID, Current_Organization_ID, Relationship, Date_of_Birth, Phone, About_Me, Interests, Begin_Organization) VALUES(5,401,751,5,"1993-02-12","05**123666","kendin hakkinda yaz","ilgi alanlarini yaz","2013-05-06");


INSERT INTO CONNECTION (From_ID, To_ID) VALUES(2,1);
INSERT INTO CONNECTION (From_ID, To_ID) VALUES(3,2);
INSERT INTO CONNECTION (From_ID, To_ID) VALUES(3,4);
INSERT INTO CONNECTION (From_ID, To_ID) VALUES(4,5);
INSERT INTO CONNECTION (From_ID, To_ID) VALUES(3,1);
INSERT INTO CONNECTION (From_ID, To_ID) VALUES(4,2);
INSERT INTO CONNECTION (From_ID, To_ID) VALUES(4,1);


UPDATE CONNECTION SET State=1 WHERE Connection_ID=1501;
UPDATE CONNECTION SET State=1 WHERE Connection_ID=1502;
UPDATE CONNECTION SET State=1 WHERE Connection_ID=1503;
UPDATE CONNECTION SET State=1 WHERE Connection_ID=1505;
UPDATE CONNECTION SET State=1 WHERE Connection_ID=1506;
UPDATE CONNECTION SET State=1 WHERE Connection_ID=1507;


UPDATE CONNECTION_LIST SET Connection_List_Name=2 WHERE Connection_ID=1501;
UPDATE CONNECTION_LIST SET Connection_List_Name=1 WHERE Connection_ID=1502;
UPDATE CONNECTION_LIST SET Connection_List_Name=3 WHERE Connection_ID=1505;


INSERT INTO MESSAGE (Sender_ID, Receiver_ID, Message) VALUES(4,1,"Kosul");
INSERT INTO MESSAGE (Sender_ID, Receiver_ID, Message) VALUES(3,5,"Yemekhane Listesi");
INSERT INTO MESSAGE (Sender_ID, Receiver_ID, Message) VALUES(5,2,"Sanmsnm");
INSERT INTO MESSAGE (Sender_ID, Receiver_ID, Message) VALUES(5,3,"Sag ol");
INSERT INTO MESSAGE (Sender_ID, Receiver_ID, Message) VALUES(4,3,"Mann");


INSERT INTO CHAT (Message) VALUES("Nasılsınız?");
INSERT INTO CHAT (Message) VALUES("Iyi, sen?");
INSERT INTO CHAT (Message) VALUES("iyi :)");
INSERT INTO CHAT (Message) VALUES("odev var mı?");
INSERT INTO CHAT (Message) VALUES("yok");
INSERT INTO CHAT (Message) VALUES("Nasılsın?");
INSERT INTO CHAT (Message) VALUES("hadi");


INSERT INTO GROUP_CHAT (Chat_ID, Sender_ID, Receiver_ID) VALUES(3001,1,2);
INSERT INTO GROUP_CHAT (Chat_ID, Sender_ID, Receiver_ID) VALUES(3001,1,3);
INSERT INTO GROUP_CHAT (Chat_ID, Sender_ID, Receiver_ID) VALUES(3002,2,1);
INSERT INTO GROUP_CHAT (Chat_ID, Sender_ID, Receiver_ID) VALUES(3003,1,2);
INSERT INTO GROUP_CHAT (Chat_ID, Sender_ID, Receiver_ID) VALUES(3003,3,1);
INSERT INTO GROUP_CHAT (Chat_ID, Sender_ID, Receiver_ID) VALUES(3004,1,3);
INSERT INTO GROUP_CHAT (Chat_ID, Sender_ID, Receiver_ID) VALUES(3005,2,3);
INSERT INTO GROUP_CHAT (Chat_ID, Sender_ID, Receiver_ID) VALUES(3006,3,2);


INSERT INTO CV (User_ID, Date_Created) VALUES(1,"2010-10-10");
INSERT INTO CV (User_ID, Date_Created) VALUES(2,"2010-12-10");
INSERT INTO CV (User_ID, Date_Created) VALUES(3,"2010-11-10");


INSERT INTO CV_SECTION (CV_Section_ID, CV_ID, CV_Section_Text, Date_Created) VALUES(1,6001,"Egitim","2010-10-10");
INSERT INTO CV_SECTION (CV_Section_ID, CV_ID, CV_Section_Text, Date_Created) VALUES(2,6001,"Deneyim","2010-10-10");
INSERT INTO CV_SECTION (CV_Section_ID, CV_ID, CV_Section_Text, Date_Created) VALUES(1,6002,"Egitim","2010-10-10");
INSERT INTO CV_SECTION (CV_Section_ID, CV_ID, CV_Section_Text, Date_Created) VALUES(4,6003,"Yabanci Dil","2010-10-10");


INSERT INTO REF_CV_SECTION (Ref_User_ID, CV_ID, CV_Section_ID) VALUES(4,6001,2);
INSERT INTO REF_CV_SECTION (Ref_User_ID, CV_ID, CV_Section_ID) VALUES(1,6002,1);


INSERT INTO RECOMMENDATION(From_ID, To_ID, Text_Recommendation) VALUE(1,2,"Yazilim alaninda iyi.....");
INSERT INTO RECOMMENDATION(From_ID, To_ID,Text_Recommendation) VALUE(3,4,"Alaninda cesitli arastirmalar yapan ve .....");


INSERT INTO GROUPs (Created_by_User_ID, Group_Name, Group_Description, Created_at) VALUES(1,"Bilmuh","sdfsdfsdf","2012-10-10");
INSERT INTO GROUPs (Created_by_User_ID, Group_Name, Group_Description, Created_at) VALUES(2,"BilmuhAkademi","sdfsdwerfsdf","2012-10-11");


INSERT INTO GROUPs_USER (User_ID, Group_ID) VALUES(3,8001);
INSERT INTO GROUPs_USER (User_ID, Group_ID) VALUES(2,8001);
INSERT INTO GROUPs_USER (User_ID, Group_ID) VALUES(4,8001);
INSERT INTO GROUPs_USER (User_ID, Group_ID) VALUES(1,8002);


INSERT INTO FEED (Feed_Status, User_ID, Created_at, URL, Category_Name, Type_Name, Title) VALUES(2,1,"2012-01-01","www.youtube.com/asdasd","Bilisim",5,"Bilim Nereye Gidiyor");
INSERT INTO FEED (User_ID, Created_at, URL, Category_Name, Type_Name, Title) VALUES(1,"2012-02-01","www.youtube.com/asfvsdasd","Saglik",5,"Bilims Nereye Gidiyor");
INSERT INTO FEED (User_ID, Created_at, URL, Category_Name, Type_Name, Title) VALUES(2,"2012-03-01","www.youtube.com/asdwetasd","Insaat",5,"Bilimas Nereye Gidiyor");


INSERT INTO GROUP_FEED(Group_ID, Feed_ID) VALUES (8002,151);

INSERT INTO STATUS (User_ID, Message) VALUES(3,"Guzel bir gun");
INSERT INTO STATUS (User_ID, Message) VALUES(3,"Proje time");
INSERT INTO STATUS (User_ID, Message) VALUES(4,"Hayat cok degisik");
INSERT INTO STATUS (User_ID, Message) VALUES(2,"asdasdasd");
INSERT INTO STATUS (User_ID, Message) VALUES(3,"sdfsdwe");
INSERT INTO STATUS (User_ID, Message) VALUES(1,"Toplantı");


INSERT INTO LIKE_DISLIKE (Object_ID, Object_Type, Friend_ID, Flag) VALUES(105,"Status",1,1);
INSERT INTO LIKE_DISLIKE (Object_ID, Object_Type, Friend_ID, Flag) VALUES(103,"Status",2,0);
INSERT INTO LIKE_DISLIKE (Object_ID, Object_Type, Friend_ID, Flag) VALUES(152,"Feed",3,1);
INSERT INTO LIKE_DISLIKE (Object_ID, Object_Type, Friend_ID, Flag) VALUES(106,"Status",1,0);


INSERT INTO COMMENT (Object_ID, Object_Type, Friend_ID, Message) VALUES(106,"Status",2,"Bende :)");
INSERT INTO COMMENT (Object_ID, Object_Type, Friend_ID, Message) VALUES(105,"Status",1,":( :( :( :(");
INSERT INTO COMMENT (Object_ID, Object_Type, Friend_ID, Message) VALUES(106,"Status",3,"sdasdasd :)");
INSERT INTO COMMENT (Object_ID, Object_Type, Friend_ID, Message) VALUES(151,"Feed",1,"sdasdasd :)");
INSERT INTO COMMENT (Object_ID, Object_Type, Friend_ID, Message) VALUES(152,"Feed",2,"sdasdasd :)");

INSERT INTO EVENT (Event_Created_by_User_ID, Event_Name, Event_Description, Start_Date, Finish_Date) VALUES(2,"Proje Partisi","sdfsdf","2014-09-09","2014-12-12");
INSERT INTO EVENT (Event_Created_by_User_ID, Event_Name, Event_Description, Start_Date, Finish_Date) VALUES(4,"YilBasi","sdfsdf","2014-12-31","2015-01-01");


INSERT INTO EVENT_USER (Event_ID, User_ID) VALUES(9001,1);
INSERT INTO EVENT_USER (Event_ID, User_ID) VALUES(9001,3);
INSERT INTO EVENT_USER (Event_ID, User_ID) VALUES(9001,4);
INSERT INTO EVENT_USER (Event_ID, User_ID) VALUES(9002,3);
INSERT INTO EVENT_USER (Event_ID, User_ID) VALUES(9002, 1);



UPDATE EVENT_USER SET Participate_Status=1 WHERE Event_ID=9001 AND User_ID=1;
UPDATE EVENT_USER SET Participate_Status=1 WHERE Event_ID=9001 AND User_ID=3;
UPDATE EVENT_USER SET Participate_Status=1 WHERE Event_ID=9002 AND User_ID=3;


























