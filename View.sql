CREATE VIEW CONNECTION_RELATION AS
	
    SELECT DISTINCT From_ID AS User, To_ID AS Connection, Connection_List_Name AS Relation
    FROM CONNECTION, CONNECTION_LIST
    WHERE State=1 AND CONNECTION.Connection_ID = CONNECTION_LIST.Connection_ID
    
    UNION
    
    SELECT DISTINCT To_ID AS User, From_ID AS Connection, Connection_List_Name AS Relation
    FROM CONNECTION, CONNECTION_LIST
    WHERE State=1 AND CONNECTION.Connection_ID = CONNECTION_LIST.Connection_ID