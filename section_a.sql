-- REPLACE NATURAL JOINS

-- A
SELECT CONCAT(S_FIRST, CONCAT(' ', S_LAST)) AS NAME, TRUNC(months_between(sysdate, S_DOB)/12) as AGE
FROM STUDENT
WHERE TRUNC(months_between(sysdate,S_DOB)/12) > 24;

-- B
SELECT bldg_code, SUM(capacity)
FROM LOCATION
WHERE capacity > 4
HAVING SUM(capacity) > 150
GROUP BY bldg_code;

-- C
SELECT f_last || ' ' || f_first AS advisor, s_last || ' ' || s_first AS student
FROM faculty JOIN student ON faculty.f_id = student.f_id
ORDER BY f_last || ' ' || f_first ASC;


-- D
SELECT CONCAT(F_FIRST, CONCAT(' ', F_LAST)) AS NAME, BLDG_CODE AS CODE, ROOM
FROM FACULTY NATURAL JOIN LOCATION
WHERE BLDG_CODE = 'BUS';

-- F
SELECT ENROLLMENT.S_ID AS ID, CONCAT(S_FIRST, CONCAT(' ', S_LAST)) AS NAME, course_name, GRADE 
FROM student JOIN enrollment ON student.s_id = enrollment.s_id JOIN course_section ON enrollment.c_sec_id = course_section.c_sec_id JOIN course ON course_section.course_no = course.course_no
WHERE GRADE < 'C'
ORDER BY ID ASC;

-- G
SELECT CONCAT(F_FIRST, CONCAT(' ', F_LAST)), COUNT(student.f_id)
FROM faculty JOIN student ON faculty.f_id = student.f_id
HAVING COUNT(student.f_id) = (SELECT MAX(f_max)
FROM(SELECT faculty.f_id, COUNT(student.f_id) AS f_max
FROM faculty JOIN student ON faculty.f_id = student.f_id
GROUP BY faculty.f_id))
GROUP BY CONCAT(F_FIRST, CONCAT(' ', F_LAST));

-- H
SELECT S_FIRST || ' ' || S_LAST  AS Name, SUM(credits)
FROM student JOIN enrollment ON student.s_id = enrollment.s_id JOIN course_section ON enrollment.c_sec_id = course_section.c_sec_id
JOIN course on course_section.course_no = course.course_no
GROUP BY S_FIRST || ' ' || S_LAST;

-- I
SELECT Name, COUNT(course), SUM(credits)
FROM student JOIN enrollment ON student.s_id = enrollment.s_id JOIN course_section ON enrollment.c_sec_id = course_section.c_sec_id
HAVING COUNT(*)
JOIN course on course_section.course_no = course.course_no
GROUP BY S_FIRST || ' ' || S_LAST;