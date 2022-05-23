pg_dump -h host-db-internal-1234.xyz.us-east-1.rds.amazonaws.com -U username -d postgres -v -t tablename --data-only --column-inserts > db_dump.sql
