CALL apoc.export.cypher.all("backup.cypher", { format: "plain", useOptimizations: {type: "UNWIND_BATCH", unwindBatchSize: 100}}) YIELD file, batches, source, format, nodes, relationships, properties, time, rows, batchSize RETURN file, batches, source, format, nodes, relationships, properties, time, rows, batchSize;