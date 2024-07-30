To copy all properties of each table present in a schema (including columns, indexes, foreign keys, and triggers) into a new schema or table for documentation purposes, you can follow these steps. Here, we'll write SQL scripts to gather all necessary information and store it in a structured format.

### 1. Create a Table to Store the Metadata

First, create a table to store the metadata of all tables from the schema.

```sql
CREATE TABLE table_metadata (
    table_name VARCHAR(255),
    column_name VARCHAR(255),
    data_type VARCHAR(255),
    is_nullable VARCHAR(3),
    column_default VARCHAR(255),
    index_name VARCHAR(255),
    index_type VARCHAR(255),
    index_non_unique INT,
    foreign_key_name VARCHAR(255),
    referenced_table_name VARCHAR(255),
    referenced_column_name VARCHAR(255),
    trigger_name VARCHAR(255),
    trigger_event VARCHAR(255),
    trigger_timing VARCHAR(255),
    trigger_statement TEXT
);
```

### 2. Generate and Execute Queries to Insert Metadata

Now, generate and execute SQL queries to populate the `table_metadata` table with information about columns, indexes, foreign keys, and triggers.

```sql
DELIMITER //

CREATE PROCEDURE collect_table_metadata()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE tbl_name VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT table_name FROM information_schema.tables WHERE table_schema = 'eddb';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO tbl_name;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Insert column information
        SET @s1 = CONCAT('INSERT INTO table_metadata (table_name, column_name, data_type, is_nullable, column_default) SELECT "', tbl_name, '", column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = "', tbl_name, '" AND table_schema = ''eddb'';');
        PREPARE stmt1 FROM @s1;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;

        -- Insert index information
        SET @s2 = CONCAT('INSERT INTO table_metadata (table_name, index_name, index_type, index_non_unique) SELECT "', tbl_name, '", index_name, index_type, non_unique FROM information_schema.statistics WHERE table_name = "', tbl_name, '" AND table_schema = ''eddb'';');
        PREPARE stmt2 FROM @s2;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;

        -- Insert foreign key information
        SET @s3 = CONCAT('INSERT INTO table_metadata (table_name, foreign_key_name, referenced_table_name, referenced_column_name) SELECT "', tbl_name, '", constraint_name, referenced_table_name, referenced_column_name FROM information_schema.key_column_usage WHERE table_name = "', tbl_name, '" AND table_schema = ''eddb'' AND referenced_table_name IS NOT NULL;');
        PREPARE stmt3 FROM @s3;
        EXECUTE stmt3;
        DEALLOCATE PREPARE stmt3;

        -- Insert trigger information
        SET @s4 = CONCAT('INSERT INTO table_metadata (table_name, trigger_name, trigger_event, trigger_timing, trigger_statement) SELECT "', tbl_name, '", trigger_name, event_manipulation, action_timing, action_statement FROM information_schema.triggers WHERE event_object_table = "', tbl_name, '" AND trigger_schema = ''eddb'';');
        PREPARE stmt4 FROM @s4;
        EXECUTE stmt4;
        DEALLOCATE PREPARE stmt4;

    END LOOP;

    CLOSE cur;
END //

DELIMITER ;
```

### 3. Execute the Stored Procedure

Once the stored procedure is created, execute it to populate the `table_metadata` table with all the necessary information.

```sql
CALL collect_table_metadata();
```

### 4. View the Collected Metadata

You can now view the collected metadata by querying the `table_metadata` table.

```sql
SELECT * FROM table_metadata;
```

### 5. Export the Results

Finally, you can export the results from the `table_metadata` table using your MySQL client's export functionality.

This approach ensures that you collect comprehensive metadata for all tables in the specified schema, including columns, indexes, foreign keys, and triggers. The stored procedure automates the collection process, making it efficient even for databases with a large number of tables.
