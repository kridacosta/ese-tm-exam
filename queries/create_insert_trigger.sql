CREATE TRIGGER log_inserts
   AFTER INSERT ON customers
    FOR EACH ROW EXECUTE PROCEDURE log_inserts();