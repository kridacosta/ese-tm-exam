CREATE OR REPLACE FUNCTION log_inserts()
        RETURNS TRIGGER AS $$
        BEGIN
            PERFORM pg_notify('insert_event', row_to_json(NEW)::TEXT);
            RETURN NEW;
            
        END;
        $$ LANGUAGE plpgsql;