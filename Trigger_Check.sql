DELIMITER //

CREATE TRIGGER user_password_before_ınsert
	BEFORE INSERT 
    ON user FOR EACH ROW
     BEGIN 
     IF length(new.password)<6
		THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT='SIFRE 6 KARAKTERDEN AZ OLAMAZ';
     END IF;
END; //

DELIMITER ;



DELIMITER //

CREATE TRIGGER user_password_before_update
	BEFORE UPDATE 
    ON user FOR EACH ROW
     BEGIN 
		IF length(new.password)<6
			THEN 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT='SIFRE 6 KARAKTERDEN AZ OLAMAZ';
		END IF;
	END; //

DELIMITER ;



DELIMITER //

CREATE TRIGGER profile_date_control_before_ınsert
	BEFORE INSERT
    ON profile FOR EACH ROW
     BEGIN 
		IF NEW.Date_of_Birth > NEW.Begin_Organization
			THEN 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT='Dogum tarihi, Ise giris tarihinden sonra olamaz !';
		END IF;
	END; //
        
 DELIMITER ;
 
 
 
 
DELIMITER //

CREATE TRIGGER profile_date_control_before_update
	BEFORE UPDATE
    ON profile FOR EACH ROW
     BEGIN 
		IF NEW.Date_of_Birth > NEW.Begin_Organization
			THEN 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT='Dogum tarihi, Ise giris tarihinden sonra olamaz !';
		END IF;
	END; //
        
DELIMITER ;



DELIMITER //
 
 CREATE TRIGGER event_date_constraint_before_insert
	BEFORE INSERT
    ON Event  FOR EACH ROW
    BEGIN 
		IF NEW.Start_Date>NEW.Finish_Date
			THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT='Etkinligin baslama tarihi bitis tarihinden sonra olamaz. !';
         END IF;
     END; //    
 
 DELIMITER ;


#----ÖNEMLİ-------Programda zaten kullanıcı kendine baglantı isteginde bulunamaz...!!!
DELIMITER //

CREATE TRIGGER connection_control_before_ınsert
	BEFORE INSERT
    ON connection FOR EACH ROW
     BEGIN 
		IF NEW.From_ID = NEW.To_ID
			THEN 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT='Kisi Kendini Ekleyemez !';
		END IF;
	END; //
        
DELIMITER ;      
 
 
 
 
 
 DELIMITER //

CREATE TRIGGER connection_control_before_update
	BEFORE UPDATE
    ON connection FOR EACH ROW
     BEGIN 
		IF NEW.From_ID = NEW.To_ID
			THEN 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT='Kisi Kendini Ekleyemez !';
		END IF;
	END; //
        
DELIMITER ;      
 
 
 
 DELIMITER //
 
 CREATE TRIGGER CV_section_id_before_insert
	BEFORE INSERT
    ON cv_section FOR EACH ROW
    BEGIN 
		IF NEW.CV_Section_ID>10 OR NEW.CV_Section_ID<1
			THEN 
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT='Section Numarasi 1 ile 9 arasında olmalıdır.!';
        END IF;
    END; //    
 
 DELIMITER ;
 
 
 #----ÖNEMLİ------Programda zaten arkadaşı olmayan kişi listede olmayacağından chat yapılamaz.
 # Örnek olarak yazıldı.
 DELIMITER //
 
CREATE TRIGGER  group_chat_constraint_before_insert
	BEFORE INSERT
    ON group_chat FOR EACH ROW 
    BEGIN 
		IF  NOT EXISTS(SELECT * FROM CONNECTION_RELATION WHERE NEW.Sender_ID=User AND NEW.Receiver_ID=Connection)
			THEN 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT='ARKADAS OLMAYAN KISILER CHAT YAPAMAZ';
		END IF ;
    END; //    
			
	
 DELIMITER ;
 
 
 
 
DELIMITER //
 
CREATE TRIGGER ref_cv_section_connection_control_before_insert
		BEFORE INSERT
        ON Ref_CV_Section FOR EACH ROW
        BEGIN
			IF  NOT EXISTS(SELECT * 
						   FROM CONNECTION_RELATION 
                           WHERE NEW.Ref_User_ID= Connection AND User IN (SELECT CV.User_ID 
																		  FROM CV 
																		  WHERE NEW.CV_ID=CV.CV_ID))
				THEN 
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT='BAGLANTILI OLMAYAN KISILER BIRBIRLERINE REFERANS OLAMAZ!';
		
            ELSE IF NOT EXISTS(SELECT *							
								FROM CV,CV_SECTION
                                WHERE CV.CV_ID=NEW.CV_ID AND CV.Privacy!=3 AND NEW.CV_ID=CV_SECTION.CV_ID AND CV_SECTION.CV_Section_ID=NEW.CV_Section_ID AND CV_SECTION.Privacy!=3)
                  THEN 
                  SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT='Gorunurlugu kapali CVye REFERANS olunamaz!';
                END IF; 
           END IF ;
        END ; //   
 
 DELIMITER ;
 
 
 
 
DELIMITER //

CREATE TRIGGER recommendation_control_before_insert
	BEFORE INSERT
    ON recommendation FOR EACH ROW
    BEGIN
		IF NOT EXISTS( SELECT *
					   FROM CONNECTION_RELATION
                       WHERE NEW.From_ID= Connection AND NEW.To_ID= User)
			THEN 
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT='BAGLANTILI OLUNMAYAN KISI ICIN TAVSIYE METNI YAZILAMAZ!';
			END IF ;
        END ; //   
    
DELIMITER ;

