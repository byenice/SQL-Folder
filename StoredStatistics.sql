SELECT
d.object_id, d.database_id, OBJECT_NAME(object_id,database_id) 'proc name',
d.cached_time,d.last_execution_time,d.total_elapsed_time,
d.total_elapsed_time/d.execution_count AS [avg_elapsed_time],
d.last_elapsed_time,d.execution_count
FROM sys.dm_exec_procedure_stats AS d
WHERE database_id=6
ORDER BY [proc name]