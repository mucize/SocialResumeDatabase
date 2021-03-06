CREATE TABLE USER(

	User_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
	Email VARCHAR(50) NOT NULL UNIQUE,
	Password VARCHAR(50) NOT NULL,
	Date_Joined DATETIME NULL,
	Fname VARCHAR(20) NOT NULL,
	Mname VARCHAR(20),
	Lname VARCHAR(20) NOT NULL,
	Gender ENUM('Bay','Bayan') NOT NULL,
	Active ENUM('Aktif','Pasif') NOT NULL DEFAULT 'Aktif',


	CONSTRAINT User_PK
		PRIMARY KEY (User_ID)

);


CREATE TABLE COUNTRY (

	Country_ID SMALLINT NOT NULL AUTO_INCREMENT,
	Country VARCHAR(30) NOT NULL UNIQUE,
	

	CONSTRAINT Country_PK
		PRIMARY KEY (Country_ID)

)AUTO_INCREMENT=201;

CREATE TABLE CITY (

	City_ID SMALLINT NOT NULL AUTO_INCREMENT,
	City VARCHAR(30) NOT NULL UNIQUE,
	Country_ID SMALLINT,
	
	CONSTRAINT City_PK
		PRIMARY KEY (City_ID),

	CONSTRAINT C_Country_FK
		FOREIGN KEY(Country_ID) REFERENCES COUNTRY(Country_ID)
		ON DELETE SET NULL    ON UPDATE CASCADE

)AUTO_INCREMENT=301;

CREATE TABLE ADDRESS(

	Address_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
	Address VARCHAR(200) NOT NULL,
	City_ID SMALLINT,
	Zip INT,
    Privacy ENUM('Herkese Acık','Sadece Arkadaslar','Sadece Ben') default 'Herkese Acık', 
	
	CONSTRAINT Address_PK 
		PRIMARY KEY (Address_ID),

	CONSTRAINT A_City_FK
		FOREIGN KEY (City_ID) REFERENCES CITY(City_ID)
		ON DELETE SET NULL    ON UPDATE CASCADE

)AUTO_INCREMENT=401;


CREATE TABLE ORGANIZATION (

	Organization_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
    Organization_Name VARCHAR(45) NOT NULL UNIQUE,
    Address_ID MEDIUMINT,
    Organization_Description TEXT,
    
    CONSTRAINT Organization_PK
		PRIMARY KEY(Organization_ID),
    
	CONSTRAINT O_Address_FK
		FOREIGN KEY(Address_ID) REFERENCES ADDRESS(Address_ID)
		ON DELETE SET NULL      ON UPDATE CASCADE

)AUTO_INCREMENT=751;

CREATE TABLE PROFILE(

	Profile_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
	User_ID MEDIUMINT NOT NULL UNIQUE,
	Address_ID MEDIUMINT,
	Current_Organization_ID MEDIUMINT,
	Relationship ENUM('Evli','Bekar','Dul','Nişanlı','İlişkisi var','İlişkisi yok','Belirtilmemiş') DEFAULT 'Belirtilmemiş',
	Date_of_Birth DATE NOT NULL,
	Phone VARCHAR(15) UNIQUE,
	Last_Update TIMESTAMP,
	About_Me TEXT,
	Interests TEXT,
	Hobbies TEXT,
    Educations TEXT,
	Begin_Organization DATE,
    Number_of_Connection MEDIUMINT NOT NULL DEFAULT 0,
	Privacy ENUM('Herkese Acık','Sadece Arkadaslar','Sadece Ben') default 'Herkese Acık', 	
	CONSTRAINT Profile_PK
		PRIMARY KEY(Profile_ID),


	CONSTRAINT P_User_FK
		FOREIGN KEY(User_ID) REFERENCES USER(User_ID)
		ON DELETE CASCADE       ON UPDATE CASCADE,

	CONSTRAINT P_Address_FK
		FOREIGN KEY(Address_ID) REFERENCES ADDRESS(Address_ID)
		ON DELETE SET NULL      ON UPDATE CASCADE,

	CONSTRAINT P_Organization_FK
		FOREIGN KEY (Current_Organization_ID) REFERENCES ORGANIZATION(Organization_ID)
		ON DELETE SET NULL      ON UPDATE CASCADE
	    
)AUTO_INCREMENT=1001;

CREATE TABLE CHAT(
/*
	Chat_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
	Sender_ID MEDIUMINT NOT NULL,
	Receivers_ID MEDIUMINT NOT NULL,
	Message TEXT,
	Date_Created TIMESTAMP,

	CONSTRAINT Chat_PK
		PRIMARY KEY(Chat_ID),

	CONSTRAINT C_Sender_FK
		FOREIGN KEY(Sender_ID) REFERENCES USER(User_ID)
		  ON DELETE CASCADE   ON UPDATE CASCADE,

	CONSTRAINT C_Receiver_FK
		FOREIGN KEY(Receiver_ID) REFERENCES USER(User_ID)
		    ON DELETE CASCADE   ON UPDATE CASCADE
  */
	Chat_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
    Message TEXT,
    Date_Created TIMESTAMP,
    
    CONSTRAINT Chat_PK
		PRIMARY KEY(Chat_ID)
        
)AUTO_INCREMENT=3001 ;

#Alıcının birden fazla olması durumunda veri tekrarı(mesajın içeriği) olmaması için.
CREATE TABLE GROUP_CHAT(

	Chat_ID MEDIUMINT NOT NULL,
    Sender_ID MEDIUMINT NOT NULL,
    Receiver_ID MEDIUMINT NOT NULL,
    
    CONSTRAINT Group_Chat_PK
		PRIMARY KEY(Chat_ID,Receiver_ID),
        
     CONSTRAINT Group_Chat_FK
		FOREIGN KEY(Chat_ID) REFERENCES CHAT(Chat_ID)
		  ON DELETE CASCADE   ON UPDATE CASCADE,   

	CONSTRAINT GC_Sender_FK
		FOREIGN KEY(Sender_ID) REFERENCES USER(User_ID)
		  ON DELETE CASCADE   ON UPDATE CASCADE,
          
    CONSTRAINT GC_Receiver_FK
		FOREIGN KEY(Receiver_ID) REFERENCES USER(User_ID)
		    ON DELETE CASCADE   ON UPDATE CASCADE      

)AUTO_INCREMENT=3501;

CREATE TABLE MESSAGE(

	Message_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
	Sender_ID MEDIUMINT NOT NULL,
	Receiver_ID MEDIUMINT NOT NULL,
	Message TEXT,
	is_Read BOOLEAN DEFAULT 0,
	is_Spam BOOLEAN DEFAULT 0,
	is_Reply BOOLEAN DEFAULT 0,
    Created_at TIMESTAMP,

	CONSTRAINT Message_PK
		PRIMARY KEY(Message_ID),
	
	CONSTRAINT M_Sender_FK
		FOREIGN KEY(Sender_ID) REFERENCES USER(User_ID)
		 ON DELETE CASCADE    ON UPDATE CASCADE,

	CONSTRAINT M_Receiver_FK
		FOREIGN KEY(Receiver_ID) REFERENCES USER(User_ID)
		ON DELETE CASCADE	 ON UPDATE CASCADE
        
)AUTO_INCREMENT=4001 ;

CREATE TABLE CONNECTION(

	Connection_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
	From_ID MEDIUMINT NOT NULL,
	To_ID MEDIUMINT NOT NULL,
	Date_Created TIMESTAMP NOT NULL,  
	State BOOLEAN DEFAULT 0, #0: arkadaşlık isteği halinde   1:kabul edildi

	CONSTRAINT Connection_PK
		PRIMARY KEY(Connection_ID),

	CONSTRAINT C_From_FK
		FOREIGN KEY(From_ID) REFERENCES USER(User_ID)
		ON DELETE CASCADE		ON UPDATE CASCADE,

	CONSTRAINT C_To_FK
		FOREIGN KEY(To_ID) REFERENCES USER(User_ID)
		ON DELETE CASCADE		ON UPDATE CASCADE,
        
    UNIQUE KEY C_Unique 
			(From_ID, To_ID)


)AUTO_INCREMENT=1501;

CREATE TABLE CONNECTION_LIST (

	Connection_ID MEDIUMINT NOT NULL,
	Connection_List_Name ENUM('Okul Arkadaşı','İş arkadaşı','Aile','Diğer') DEFAULT 'Diger',

	CONSTRAINT Connection_List_PK
		PRIMARY KEY(Connection_ID),
			
    CONSTRAINT C_L_Connection_FK
		FOREIGN KEY (Connection_ID) REFERENCES CONNECTION(Connection_ID) 
        ON DELETE CASCADE       ON UPDATE CASCADE
);

CREATE TABLE CV(

	CV_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
	User_ID MEDIUMINT NOT NULL UNIQUE,
	Date_Created DATE NOT NULL,
	Date_Update TIMESTAMP,
	Privacy ENUM('Herkese Acık','Sadece Arkadaslar','Sadece Ben') default 'Herkese Acık', 
	CONSTRAINT CV_PK
		PRIMARY KEY(CV_ID),

	CONSTRAINT CV_User_FK
		FOREIGN KEY(User_ID) REFERENCES USER(User_ID)
		ON DELETE CASCADE       ON UPDATE CASCADE

)AUTO_INCREMENT=6001;
CREATE TABLE CV_SECTION(
							
	CV_Section_ID MEDIUMINT NOT NULL, # 0:EGITIM   1:YABANCI DIL 2:DENEYIMLER 3:SERTIFIKALAR 4:KISISEL NOT  VS... 
	CV_ID MEDIUMINT NOT NULL,
	CV_Section_Text TEXT,
	Date_Created DATE NOT NULL,
	Date_Update TIMESTAMP,
	Privacy ENUM('Herkese Acık','Sadece Arkadaslar','Sadece Ben') default 'Herkese Acık', 	
	CONSTRAINT CV_Section_PK
		PRIMARY KEY(CV_Section_ID,CV_ID),

	CONSTRAINT CV_Section_CV_FK
		FOREIGN KEY(CV_ID) REFERENCES CV(CV_ID)
		ON DELETE CASCADE       ON UPDATE CASCADE

);
CREATE TABLE REF_CV_SECTION(

	Ref_User_ID MEDIUMINT NOT NULL,
	CV_ID MEDIUMINT NOT NULL,
	CV_Section_ID MEDIUMINT NOT NULL,
	
	CONSTRAINT Ref_CV_Section_PK
		PRIMARY KEY(Ref_User_ID,CV_ID,CV_Section_ID),
	
	CONSTRAINT Ref_CV_Section_User_FK
		FOREIGN KEY(Ref_User_ID) REFERENCES USER(User_ID)
		ON DELETE CASCADE       ON UPDATE CASCADE,

	CONSTRAINT Ref_CV_Section_CV_FK
		FOREIGN KEY(CV_Section_ID,CV_ID) REFERENCES CV_SECTION(CV_Section_ID,CV_ID)
		ON DELETE CASCADE       ON UPDATE CASCADE
        
        
);
CREATE TABLE RECOMMENDATION(

	From_ID MEDIUMINT NOT NULL,
    To_ID MEDIUMINT NOT NULL,
    Created_at TIMESTAMP,
    Text_Recommendation TEXT NOT NULL,
	Privacy ENUM('Herkese Acık','Sadece Arkadaslar','Sadece Ben') default 'Herkese Acık',     
    
    CONSTRAINT Recommendation_PK
		PRIMARY KEY(From_ID,To_ID),
     
     CONSTRAINT Recommendation_From_FK
		FOREIGN KEY (From_ID) REFERENCES USER(User_ID)
			ON DELETE CASCADE 		ON UPDATE CASCADE,
            
	CONSTRAINT Recommendation_To_FK
		FOREIGN KEY (To_ID) REFERENCES USER(User_ID)
			ON DELETE CASCADE 		ON UPDATE CASCADE

);

CREATE TABLE OBJECT(

	Object_ID MEDIUMINT NOT NULL,
    Object_Type VARCHAR(20) NOT NULL,
    
    CONSTRAINT Object_PK
    PRIMARY KEY(Object_ID,Object_Type)
    

); 

CREATE TABLE STATUS (

	Status_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
	User_ID MEDIUMINT NOT NULL,
    Message TEXT NOT NULL,
    Created_at TIMESTAMP,
	Privacy ENUM('Herkese Acık','Sadece Arkadaslar','Sadece Ben') default 'Herkese Acık',     
    CONSTRAINT Status_PK
		PRIMARY KEY(Status_ID),
        
    CONSTRAINT Status_User_FK
		FOREIGN KEY(User_ID) REFERENCES USER(User_ID)
			ON DELETE CASCADE		 ON UPDATE CASCADE


)AUTO_INCREMENT=101;


CREATE TABLE GROUPs(

	Group_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
    Created_by_User_ID MEDIUMINT NOT NULL,
    Group_Name VARCHAR(50) NOT NULL UNIQUE,
    Group_Description TEXT,
    Created_at DATETIME NOT NULL,
	Privacy ENUM('Herkese Acık','Sadece Arkadaslar','Sadece Ben') default 'Herkese Acık',      
     CONSTRAINT Group_PK
		PRIMARY KEY(Group_ID),
    
    CONSTRAINT Group_Created_User_FK
		FOREIGN KEY(Created_by_User_ID) REFERENCES USER(User_ID)
        ON DELETE CASCADE          ON UPDATE CASCADE
    
)AUTO_INCREMENT=8001;

CREATE TABLE GROUPs_USER(
	
    User_ID MEDIUMINT NOT NULL,
    Group_ID MEDIUMINT NOT NULL,
    Date_Joined TIMESTAMP,

	CONSTRAINT Groups_User_PK
		PRIMARY KEY(User_ID,Group_ID),
        
	 CONSTRAINT Groups_User_User_FK
		FOREIGN KEY(User_ID) REFERENCES USER(User_ID)
        ON DELETE CASCADE          ON UPDATE CASCADE,
        
     CONSTRAINT Groups_User_Group_FK
		FOREIGN KEY(Group_ID) REFERENCES GROUPs(Group_ID)
        ON DELETE CASCADE          ON UPDATE CASCADE
);

CREATE TABLE FEED(
	
    Feed_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
    Feed_Status ENUM('Duvar','Group') DEFAULT 'Duvar',
    User_ID MEDIUMINT NOT NULL,
    Created_at TIMESTAMP,
    Click SMALLINT NOT NULL DEFAULT 0,
    URL VARCHAR(255) NOT NULL,
    Category_Name VARCHAR(50) NOT NULL,   # Bilgi_bilisim   /  Business  /  Economy   /  Insaat
    Type_Name ENUM('Makale','Is ilanı','Haber','Etkinlik','Diğer' ),
    Title VARCHAR(50),
	Privacy ENUM('Herkese Acık','Sadece Arkadaslar','Sadece Ben') default 'Herkese Acık',     
	CONSTRAINT Feed_PK 
		PRIMARY KEY(Feed_ID),

	CONSTRAINT Feed_User_FK
		FOREIGN KEY(User_ID) REFERENCES USER(User_ID)
			ON DELETE CASCADE		 ON UPDATE CASCADE
            
)AUTO_INCREMENT=151;

#Gruba paylaşım yapılması 
CREATE TABLE GROUP_FEED(
	Group_ID MEDIUMINT NOT NULL,
    Feed_ID MEDIUMINT NOT NULL,
    
    CONSTRAINT Group_Feed_PK
		PRIMARY KEY(Group_ID,Feed_ID),
     
    CONSTRAINT GF_Group_FK
		FOREIGN KEY (Group_ID) REFERENCES GROUPs(Group_ID)
        ON DELETE CASCADE		 ON UPDATE CASCADE,
     
     CONSTRAINT GF_Feed_FK
		FOREIGN KEY (Feed_ID) REFERENCES FEED(Feed_ID)
        ON DELETE CASCADE		 ON UPDATE CASCADE 
        

);

CREATE TABLE LIKE_DISLIKE(

	Object_ID MEDIUMINT NOT NULL,
	Object_Type VARCHAR(20) NOT NULL,
	Friend_ID MEDIUMINT NOT NULL,
    Flag BOOLEAN NOT NULL,     # 0:DISLIKE      1:LIKE    LIKE/DISLIKE YOKSA ZATEN BU TABLOYA EKLENMEZ
    Created_at TIMESTAMP,
    
    CONSTRAINT Like_Dislike_PK
		PRIMARY KEY(Object_ID,Object_Type,Friend_ID),
    
    CONSTRAINT Like_Dislike_Object_FK
		FOREIGN KEY(Object_ID,Object_Type) REFERENCES OBJECT(Object_ID,Object_Type)
			ON DELETE CASCADE		ON UPDATE CASCADE,
        
	CONSTRAINT Like_Dislike_Friend_FK
		FOREIGN KEY(Friend_ID) REFERENCES USER(User_ID)
			ON DELETE CASCADE 		ON UPDATE CASCADE
            
					        
);


CREATE TABLE COMMENT(

	Comment_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
	Object_ID MEDIUMINT NOT NULL,
	Object_Type VARCHAR(20) NOT NULL,
	Friend_ID MEDIUMINT NOT NULL,
    Message TEXT NOT NULL,
    Created_at TIMESTAMP,
    
    CONSTRAINT Comment_PK
		PRIMARY KEY(Comment_ID),
    
    CONSTRAINT Comment_Status_FK
		FOREIGN KEY(Object_ID,Object_Type) REFERENCES OBJECT(Object_ID,Object_Type)
			ON DELETE CASCADE		ON UPDATE CASCADE,
        
	CONSTRAINT Comment_Friend_FK
		FOREIGN KEY(Friend_ID) REFERENCES USER(User_ID)
			ON DELETE CASCADE 		ON UPDATE CASCADE
		
        
)AUTO_INCREMENT=7001;

CREATE TABLE EVENT(

	Event_ID MEDIUMINT NOT NULL AUTO_INCREMENT,
    Event_Created_by_User_ID MEDIUMINT NOT NULL,
    Event_Name VARCHAR(50) NOT NULL UNIQUE,
    Event_Description TEXT,
    Start_Date DATETIME NOT NULL,
    Finish_Date DATETIME NOT NULL,
	Privacy ENUM('Herkese Acık','Sadece Arkadaslar','Sadece Ben') default 'Herkese Acık',     
	
	CONSTRAINT Event_PK
		PRIMARY KEY (Event_ID),
    
    CONSTRAINT Event_Created_by_User_FK
		FOREIGN KEY(Event_Created_by_User_ID) REFERENCES USER(User_ID)
        ON DELETE CASCADE          ON UPDATE CASCADE
        
)AUTO_INCREMENT=9001;

CREATE TABLE EVENT_USER(
	
	Event_ID MEDIUMINT NOT NULL,
    User_ID MEDIUMINT NOT NULL,
    Participate_Status ENUM('CEVAPLANMAMIS','KATILACAK','KATILMAYACAK','KARARSIZ') DEFAULT 'CEVAPLANMAMIS',    
    CONSTRAINT Event_User_PK
		PRIMARY KEY(Event_ID,User_ID),
        
     CONSTRAINT Event_User_Event_FK
		FOREIGN KEY(Event_ID) REFERENCES EVENT(Event_ID)
        ON DELETE CASCADE          ON UPDATE CASCADE,
        
    CONSTRAINT Event_User_User_FK
		FOREIGN KEY(User_ID) REFERENCES USER(User_ID)
        ON DELETE CASCADE          ON UPDATE CASCADE
    
);


CREATE TABLE NOTIFICATION(
	
	Notification_ID INT NOT NULL AUTO_INCREMENT,
    User_ID MEDIUMINT NOT NULL,
    Notification_Type VARCHAR(50) NOT NULL,
    Message TEXT NOT NULL,
    Created_at TIMESTAMP,
    
    CONSTRAINT Notification_PK
		PRIMARY KEY(Notification_ID),
		
	CONSTRAINT Notification_User_FK
		FOREIGN KEY(User_ID) REFERENCES USER(User_ID)
        ON DELETE CASCADE        ON UPDATE CASCADE
    
)AUTO_INCREMENT=2501;





	