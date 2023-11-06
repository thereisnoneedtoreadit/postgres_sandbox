CREATE
OR REPLACE FUNCTION move_to_test_history()
    RETURNS trigger AS
$BODY$
BEGIN
insert into test_history (id, process, user_id, inn)
SELECT id, process, user_id, inn
FROM test
WHERE id = old.id;
RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER tr_move_to_test_history
    BEFORE DELETE
    ON test
    FOR EACH ROW
    EXECUTE PROCEDURE move_to_test_history();