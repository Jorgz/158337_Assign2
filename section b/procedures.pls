-- M
create or replace PROCEDURE M 
(
  nu_ID IN NUMBER 
, nu_LAST IN VARCHAR2 
, nu_FIRST IN VARCHAR2 
, nu_MI IN VARCHAR2 
, nu_LOC IN NUMBER 
, nu_PHONE IN NUMBER 
, nu_RANK IN VARCHAR2 
, nu_SUPER IN NUMBER  
, nu_PIN IN NUMBER 
) AS 

fac_average number;
fac_calculated number;
BEGIN
    SELECT AVG(f_salary) INTO fac_average FROM faculty;
    fac_calculated := fac_average * 0.85;
    INSERT INTO faculty (F_ID, F_LAST, F_FIRST, F_MI, LOC_ID, F_PHONE, F_RANK, F_SALARY, F_SUPER, F_PIN)
    VALUES (nu_id, nu_last, nu_first, nu_mi, nu_loc, nu_phone, nu_rank, fac_calculated, nu_super, nu_pin);
END;