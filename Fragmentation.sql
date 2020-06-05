SELECT 
T.name AS TABLENAME,
I.name AS INDEXNAME,
(SELECT avg_fragmentation_in_percent FROM sys.dm_db_index_physical_stats(DB_ID(),T.object_id,I.index_id,0,NULL)) AS FRAGMENTATION


FROM sys.tables T

INNER JOIN sys.indexes I ON T.object_id=I.object_id

WHERE T.name='CUSTOMERS'

