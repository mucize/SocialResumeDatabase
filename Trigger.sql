
#ARKADAS ISTEGİ KABUL EDİLDİGİNDE ARDAKAS SAYISINI ARTIRIYOR VE LISTE'YE EKLIYOR.
DELIMITER //

CREATE TRIGGER connection_after_update
	AFTER UPDATE	
	ON connection FOR EACH ROW
	BEGIN
		IF(NEW.State=1)
		THEN
			UPDATE PROFILE SET Number_of_Connection=Number_of_Connection+1 WHERE NEW.From_ID=User_ID;
			UPDATE PROFILE SET Number_of_Connection=Number_of_Connection+1 WHERE NEW.To_ID=User_ID;
            INSERT INTO CONNECTION_LIST VALUE(NEW.Connection_ID,4);
		END IF;
	END; //

DELIMITER ;



#ARKADASLIKTAN CIKARILDIGINDA ARDAKAS SAYISINI AZALTIYOR VE LISTE'DEN KALDIRIYOR.
DELIMITER //

CREATE TRIGGER connection_after_delete
	AFTER DELETE	
	ON connection FOR EACH ROW
	BEGIN
			UPDATE PROFILE SET Number_of_Connection=Number_of_Connection-1 WHERE OLD.From_ID=User_ID;
			UPDATE PROFILE SET Number_of_Connection=Number_of_Connection-1 WHERE OLD.To_ID=User_ID;
	END; //

DELIMITER ;





#STATUS'e bir sey eklendiginde OBJECT tablosuna ekliyor.
DELIMITER //

CREATE TRIGGER status_object_after_insert
	AFTER INSERT 
    ON status FOR EACH ROW
    BEGIN 
		INSERT INTO OBJECT VALUE(NEW.Status_ID,"Status");
        
END ; //


DELIMITER ;


#FEED'e bir sey eklendiginde OBJECT tablosuna ekliyor.
DELIMITER //

CREATE TRIGGER feed_object_after_insert
	AFTER INSERT 
    ON feed FOR EACH ROW
    BEGIN 
		INSERT INTO OBJECT VALUE(NEW.Feed_ID,"Feed");
        
END ; //        

DELIMITER ;


#USER silindiginde durumlari da silinir.
DELIMITER //

CREATE TRIGGER status_object_after_delete
	AFTER DELETE 
    ON status FOR EACH ROW
    BEGIN
		DELETE FROM OBJECT WHERE Object_ID=OLD.Status_ID AND Object_Type="Status";
    END; //

DELIMITER;



#USER silindiginde paylasimlari da silinir.
DELIMITER //

CREATE TRIGGER feed_object_after_delete
	AFTER DELETE 
    ON feed FOR EACH ROW
    BEGIN
		DELETE FROM OBJECT WHERE Object_ID=OLD.Feed_ID AND Object_Type="Feed";
    END; //

DELIMITER;







#Herhangi bir OBJECT(STATUS or FEED)'e COMMENT yapıldıgında NOTIFICATION'a ekleniyor.
DELIMITER //

CREATE TRIGGER comment_notification_after_insert
	AFTER INSERT
    ON comment FOR EACH ROW
    BEGIN 
    
		DECLARE Connection_Fname VARCHAR(20);       #Comment yapan kisinin ADI
		DECLARE Connection_Lname VARCHAR(20);       # Comment yapan kisinin SOYADI
		DECLARE User_Notification_ID MEDIUMINT;            # Bildirim gönderileceK kisi
    
		IF NEW.Object_Type="Status" 
				THEN
				SELECT User_ID INTO User_Notification_ID FROM STATUS WHERE Status_ID=NEW.Object_ID;
				IF User_Notification_ID!=NEW.Friend_ID
					THEN
					SELECT Fname, Lname INTO Connection_Fname, Connection_Lname FROM USER WHERE User_ID=NEW.Friend_ID ;
					INSERT INTO NOTIFICATION (User_ID, Notification_Type, Message)VALUE(User_Notification_ID,"Comment",concat(Connection_Fname," ",Connection_Lname," ","bir duruma yorum yaptı."));
				END IF ;
        
			ELSE IF NEW.Object_Type="Feed" 
				THEN
				SELECT User_ID INTO User_Notification_ID FROM FEED WHERE NEW.Object_ID=Feed_ID;
				IF User_Notification_ID!=NEW.Friend_ID
					THEN
					SELECT Fname, Lname INTO Connection_Fname, Connection_Lname FROM USER WHERE User_ID=NEW.Friend_ID ;
					INSERT INTO NOTIFICATION (User_ID, Notification_Type, Message)VALUE(User_Notification_ID,"Comment",concat(Connection_Fname," ",Connection_Lname," ","bir paylasima yorum yaptı."));
				END IF ;
			END IF ;
		END IF;
 END; //


DELIMITER ; 





#Herhangi bir OBJECT(STATUS or FEED)'e LIKE/DISLIKE yapıldıgında NOTIFICATION'a ekleniyor.
DELIMITER //

CREATE TRIGGER like_notification_after_insert
	AFTER INSERT
    ON like_dislike FOR EACH ROW
    BEGIN 
    
		DECLARE Connection_Fname VARCHAR(20);       #Comment yapan kisinin ADI
		DECLARE Connection_Lname VARCHAR(20);       # Comment yapan kisinin SOYADI
		DECLARE User_Notification_ID MEDIUMINT;            # Bildirim gönderileceK kisi
    
		IF NEW.Object_Type="Status" 
				THEN
				SELECT User_ID INTO User_Notification_ID FROM STATUS WHERE Status_ID=NEW.Object_ID;
				IF User_Notification_ID!=NEW.Friend_ID
					THEN
					SELECT Fname, Lname INTO Connection_Fname, Connection_Lname FROM USER WHERE User_ID=NEW.Friend_ID ;
					INSERT INTO NOTIFICATION (User_ID, Notification_Type, Message)VALUE(User_Notification_ID,"Like_Dislike",concat(Connection_Fname," ",Connection_Lname," ",IF(NEW.Flag =0,"bir durumu begenmedi","bir durumu begendi")));
				END IF ;
        
			ELSE IF NEW.Object_Type="Feed" 
				THEN
				SELECT User_ID INTO User_Notification_ID FROM FEED WHERE NEW.Object_ID=Feed_ID;
				IF User_Notification_ID!=NEW.Friend_ID
					THEN
					SELECT Fname, Lname INTO Connection_Fname, Connection_Lname FROM USER WHERE User_ID=NEW.Friend_ID ;
					INSERT INTO NOTIFICATION (User_ID, Notification_Type, Message)VALUE(User_Notification_ID,"Like_Dislike",concat(Connection_Fname," ",Connection_Lname," ",IF(NEW.Flag =0,"bir paylasimi begenmedi","bir paylasimi begendi")));
				END IF ;
			END IF ;
		END IF;
 END; //


DELIMITER ; 


#CONNECTION istegi NOTIFICATION'a eklenir.
DELIMITER //

CREATE TRIGGER connection_notification_after_insert 
	AFTER INSERT
    ON connection FOR EACH ROW 
    BEGIN 
		DECLARE Request_Fname VARCHAR(20);
        DECLARE Request_Lname VARCHAR(20);
        
        SELECT Fname, Lname INTO Request_Fname, Request_Lname FROM USER WHERE User_ID=NEW.From_ID ;
		INSERT INTO NOTIFICATION(User_ID, Notification_Type, Message) VALUE(NEW.To_ID, "Connection", concat(Request_Fname," ",Request_Lname," baglanti isteginde bulundu."));
		

    END; //

DELIMITER ;



#CONNECTION istegi kabul edildiginde NOTIFICATION'a eklenir.
DELIMITER //

CREATE TRIGGER connection_list_notification_after_insert
	AFTER INSERT
    ON connection_list FOR EACH ROW
    BEGIN 
		DECLARE Confirm_Fname VARCHAR(20);
        DECLARE Confirm_Lname VARCHAR(20);
        DECLARE Request_User_ID MEDIUMINT;
        
        SELECT From_ID INTO Request_User_ID FROM CONNECTION WHERE Connection_ID=NEW.Connection_ID;
		SELECT Fname, Lname INTO Confirm_Fname, Confirm_Lname FROM USER WHERE User_ID IN( SELECT To_ID
																						  FROM CONNECTION 
																						  WHERE Connection_ID=NEW.Connection_ID);
		INSERT INTO NOTIFICATION (User_ID, Notification_Type, Message) VALUE(Request_User_ID, "Connection", concat(Confirm_Fname," ",Confirm_Lname," baglanti istegini kabul etti."));

	END ; //
    
DELIMITER ;


#ETKINLIGE davet edildiginde NOTIFICATION'a eklenir.
DELIMITER //

CREATE TRIGGER event_notification_after_insert
	AFTER INSERT
    ON event_user FOR EACH ROW
    BEGIN 
		DECLARE Name_of_Event VARCHAR(50);
	
		SELECT Event_Name INTO Name_of_Event FROM EVENT WHERE Event_ID=NEW.Event_ID;
        INSERT INTO NOTIFICATION (User_ID, Notification_Type, Message) VALUE(NEW.User_ID,"Event",concat(Name_of_Event," adli etkinligine davet edildi."));
    END ; //     
        
DELIMITER ;


