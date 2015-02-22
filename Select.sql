#2 kişinin ortak arkadaşlarını çeken sorgu
SELECT Fname,Lname 
FROM USER 
WHERE User_ID IN (SELECT connection
				  FROM  connection_relation  AS u1
                  WHERE u1.user=1 AND u1.connection IN(SELECT connection
															FROM  connection_relation  AS u2
															WHERE u2.user=2 ));
																													
																												
#En az 2 event'e katılan kişiler 
SELECT Fname,Lname 
FROM USER 
WHERE User_ID IN (SELECT User_ID
				  FROM  event_user
                  WHERE Participate_Status=1
                  GROUP BY User_ID
                  HAVING COUNT(*) > 1);
                  


#Aynı adreste kalmalarına rağmen arkadaş olmayan kişileri listeleyen sorgu
SELECT Fname, Lname 
FROM USER
WHERE User_ID IN( SELECT p1.User_ID
					FROM PROFILE  AS p1,PROFILE  AS p2
					WHERE p1.User_ID<>p2.User_ID AND p1.Address_ID=p2.Address_ID AND p1.User_ID<>ALL(SELECT  user
																			FROM  connection_relation 	
																			WHERE p1.User_ID=user AND connection=p2.User_ID) );



#2 Kullanıcı arasındaki sohbeti listeleyen sorgu
SELECT  Fname,Lname,message
FROM CHAT, USER
WHERE (Chat_ID,User_ID) IN(SELECT Chat_ID,Sender_ID
									   FROM  GROUP_CHAT
									   WHERE (Sender_ID=1 AND Receiver_ID=2) 
									   OR 
									   Chat_ID IN(SELECT Chat_ID
												  FROM  GROUP_CHAT
												  WHERE Sender_ID=2 AND Receiver_ID=1));
  
  
 #kişinin durumlarına hiç yorum yapmayan arkadaşları 
SELECT Fname,Lname
FROM USER 
WHERE User_ID!=3 AND User_ID IN ( SELECT Connection
								  FROM connection_relation 
								  WHERE NOT EXISTS(
													SELECT *
													FROM COMMENT 
													WHERE COMMENT.Friend_ID=connection_relation.connection AND Object_ID IN (SELECT Status_ID
																															 FROM STATUS 
																															 WHERE User_ID=3)));
                                                                                                                             
#Doğum günü aynı olan kişiler
SELECT u1.Fname, u1.Lname, u2.Fname, u2.Lname
FROM USER AS u1 , USER AS u2
WHERE  (u1.User_ID,u2.User_ID) IN( SELECT p1.User_ID,p2.User_ID
								FROM PROFILE AS p1, PROFILE AS p2
								WHERE p1.User_ID!=p2.User_ID AND p1.Date_of_Birth=p2.Date_of_Birth );
                                

                                                                
                                                                
#Aynı duruma/feed.’e hem lıke hemde comment yapan kişiler.
SELECT Fname,Lname 
FROM USER
WHERE User_ID IN (SELECT DISTINCT Comment.Friend_ID
				  FROM Comment,like_dislike
                  WHERE comment.Object_ID=like_dislike.Object_ID AND comment.Object_Type=like_dislike.Object_Type AND comment.Friend_id=like_dislike.Friend_ID);
				  


#IZMIR'de yaşayan kullanıcılar				
SELECT Fname,Lname
FROM USER
WHERE User_ID IN (SELECT User_ID
				  FROM PROFILE
                  WHERE Address_ID IN (SELECT Address_ID
									FROM ADDRESS join CITY ON Address.City_ID = City.City_ID
                                    WHERE City="IZMIR"));





 
 # bir kullanıcının diğer kullanıcı için yazdığı tavsiye mektubu.
 SELECT Text_Recommendation 
 FROM recommendation
 WHERE (From_ID, To_ID) IN (SELECT u1.User_ID,u2.User_ID
							FROM user AS u1, user AS U2
                            WHERE u1.Fname="Ayşe" AND u2.Fname="Samet");
 
 
 
 
 
 #1 event'in başlangıç ve bitiş tarihi
 SELECT Start_Date,Finish_Date
 FROM event
 WHERE Event_Name="Proje Partisi";
 
 
 #1 kişinin online olan arkadaşları
 SELECT Fname,Lname
 FROM USER
 WHERE Active=1 AND User_ID IN  (SELECT Connection 
								FROM CONNECTION_RELATION
                                WHERE User IN (SELECT User_ID
												FROM USER
                                                WHERE Fname="Ayşe" AND Lname="Can"));
 