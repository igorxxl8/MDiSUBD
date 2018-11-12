--LAB5
--1.1)
SELECT * FROM PREPODS;

--1.2)
SELECT last_name, first_name
FROM Students
WHERE group_id = 1
ORDER BY last_name;

--1.3)
SELECT *
FROM Students
WHERE last_name LIKE 'O%';


--2.1)
SELECT val 
FROM RATING
WHERE prepods_id = (
    SELECT id 
    FROM Prepods
    WHERE last_name = 'Проволоцкий'
)
AND date LIKE '__-10-2016';

--2.2)
SELECT id, last_name
FROM Students
WHERE id IN (
    SELECT student_id
    FROM RATING
    WHERE is_absent = 'Y' AND study_id = 3
);


--2.3)
SELECT Faculty.NAME AS 'Faculty', 
	   Students.last_name AS 'Surname',  
	   Students.first_name AS 'Name',
	   GROUPS.name AS 'Group',  
	   Prepods.last_name AS 'Prepods surname', 
	   Prepods.first_name AS 'Prepods name', 
	   RATING.val AS 'Mark', 
	   RATING.date AS 'Date'
FROM RATING 
JOIN Students ON RATING.student_id = Students.id
JOIN Prepods ON RATING.prepods_id = Prepods.id
JOIN Faculty ON Prepods.faculty_id = Faculty.id
JOIN GROUPS ON Students.group_id = GROUPS.id
WHERE RATING.val <> 'NULL';

--2.4)
SELECT DISTINCT Subjects.name, 
       TYPE_STUDY_LOAD.name AS 'Study type',
       Prepods.last_name AS 'Substitute Prepod',
	   RATING.date AS 'DATE of replacement'
FROM RATING
JOIN LESSONS ON  RATING.study_id = LESSONS.study_id
JOIN STUDY_LOAD ON RATING.study_id = STUDY_LOAD.id
JOIN TYPE_STUDY_LOAD ON STUDY_LOAD.type_study_id = TYPE_STUDY_LOAD.id
JOIN Subjects ON STUDY_LOAD.subject_id = Subjects.id
JOIN Prepods ON RATING.prepods_id = Prepods.id
WHERE LESSONS.prepod_id <> RATING.prepods_id;

--2.5)
-- SELECT ;


--2.6)
SELECT DISTINCT Prepods.last_name, Prepods.first_name, GROUPS.name
FROM RATING
JOIN Prepods ON RATING.prepods_id = Prepods.id
JOIN Students ON RATING.student_id = Students.id 
JOIN GROUPS ON Students.group_id = GROUPS.id
WHERE RATING.val <> 'NULL'
ORDER BY Prepods.last_name;


--2.7)
SELECT Faculty.id, Faculty.name
FROM Faculty
WHERE id NOT IN (
	SELECT Faculty.id
	FROM GROUPS
	JOIN Faculty ON GROUPS.faculty_id = Faculty.id
);


