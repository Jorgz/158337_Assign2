-- REPLACE NATURAL JOINS

-- A
SELECT CONCAT(S_FIRST, CONCAT(' ', S_LAST)) AS NAME, TRUNC(months_between(sysdate, S_DOB)/12) as AGE
FROM STUDENT
WHERE TRUNC(months_between(sysdate,S_DOB)/12) > 24;

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

-- H partial (counts totals twice, maybe use union?)
SELECT CONCAT(S_FIRST, CONCAT(' ', S_LAST)), SUM(credits)
FROM student JOIN enrollment ON student.s_id = enrollment.s_id JOIN course_section ON enrollment.c_sec_id = course_section.c_sec_id
JOIN course on course_section.course_no = course.course_no
GROUP BY CONCAT(S_FIRST, CONCAT(' ', S_LAST));