-- L
create or replace TRIGGER L 
BEFORE INSERT OR UPDATE OF F_RANK ON FACULTY
FOR EACH ROW

DECLARE 
    CURSOR f_rank IS
        SELECT F_ID FROM faculty WHERE f_rank = 'Full';
fullfac number := 0;
BEGIN
    IF inserting THEN
        fullfac := fullfac + 1;
    END IF;
    IF :NEW.F_RANK = 'Full' THEN
        FOR fac in f_rank
        LOOP
        fullfac := fullfac + 1;
        IF(fullfac > 2) THEN 
            RAISE_APPLICATION_ERROR(-20002, 'Can not have more than two full faculty per department');
        END IF;
        END LOOP;
    END IF;
END;


-- N
create or replace TRIGGER N 
BEFORE UPDATE OF F_SALARY ON FACULTY 
FOR EACH ROW

DECLARE
limitsalary number;

BEGIN
    limitsalary := :old.f_salary * 1.04;
    IF(:new.F_SALARY > limitsalary) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Raise can not be more than 4%');
    END IF;
END;