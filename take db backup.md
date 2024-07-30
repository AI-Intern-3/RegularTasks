To copy all properties of tables present in a schema into a new table, you can write a SQL script that collects metadata about tables, columns, indexes, foreign keys, and triggers. Here’s a comprehensive approach using MySQL stored procedures and temporary tables.

### Step 1: Create the Destination Table for Metadata

First, create a table to store the metadata information.

```sql
CREATE TABLE schema_metadata (
    table_name VARCHAR(255),
    property_type VARCHAR(50),
    property_name VARCHAR(255),
    property_details TEXT
);
```

### Step 2: Create a Stored Procedure to Collect Metadata

Next, create a stored procedure to collect metadata about all tables in the schema and insert it into the `schema_metadata` table.

```sql
DELIMITER //

CREATE PROCEDURE collect_schema_metadata()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE tbl_name VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT table_name FROM information_schema.tables WHERE table_schema = 'your_schema_name';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open cursor
    OPEN cur;

    -- Loop through all tables
    read_loop: LOOP
        FETCH cur INTO tbl_name;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Collect column information
        INSERT INTO schema_metadata (table_name, property_type, property_name, property_details)
        SELECT tbl_name, 'COLUMN', column_name, CONCAT('Data Type: ', data_type, ', Is Nullable: ', is_nullable, ', Default: ', column_default)
        FROM information_schema.columns
        WHERE table_name = tbl_name AND table_schema = 'your_schema_name';

        -- Collect index information
        INSERT INTO schema_metadata (table_name, property_type, property_name, property_details)
        SELECT tbl_name, 'INDEX', index_name, CONCAT('Index Type: ', index_type, ', Non Unique: ', non_unique, ', Column Name: ', column_name)
        FROM information_schema.statistics
        WHERE table_name = tbl_name AND table_schema = 'your_schema_name';

        -- Collect foreign key information
        INSERT INTO schema_metadata (table_name, property_type, property_name, property_details)
        SELECT tbl_name, 'FOREIGN KEY', constraint_name, CONCAT('Column Name: ', column_name, ', Referenced Table: ', referenced_table_name, ', Referenced Column: ', referenced_column_name)
        FROM information_schema.key_column_usage
        WHERE table_name = tbl_name AND table_schema = 'your_schema_name' AND referenced_table_name IS NOT NULL;

        -- Collect trigger information
        INSERT INTO schema_metadata (table_name, property_type, property_name, property_details)
        SELECT tbl_name, 'TRIGGER', trigger_name, CONCAT('Event: ', event_manipulation, ', Timing: ', action_timing, ', Statement: ', action_statement)
        FROM information_schema.triggers
        WHERE event_object_table = tbl_name AND trigger_schema = 'your_schema_name';

    END LOOP;

    -- Close cursor
    CLOSE cur;
END //

DELIMITER ;
```

### Step 3: Execute the Stored Procedure

Once the stored procedure is created, execute it to populate the `schema_metadata` table with all the necessary information.

```sql
CALL collect_schema_metadata();
```

### Step 4: View or Export the Metadata

You can now view the collected metadata by querying the `schema_metadata` table.

```sql
SELECT * FROM schema_metadata;
```

### Explanation

- **Table Creation**: The `schema_metadata` table is created to store the metadata information.
- **Stored Procedure**: The `collect_schema_metadata` procedure iterates through all tables in the specified schema (`your_schema_name`), collects metadata for columns, indexes, foreign keys, and triggers, and inserts this information into the `schema_metadata` table.
- **Execution**: The stored procedure is executed to populate the metadata table.

Replace `your_schema_name` with the actual name of your schema. This script will help you collect and store all properties of tables in your schema in a structured format.
