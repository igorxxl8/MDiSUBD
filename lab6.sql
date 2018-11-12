-- 1.1+
SELECT COUNT(group_id)
FROM LESSONS

-- 1.2+
SELECT Students.last_name, Students.first_name
FROM (
    SELECT RATING.student_id AS suid,
           AVG(RATING.val) AS avg_mark
    FROM RATING
    GROUP BY RATING.student_id
)
JOIN Students ON Students.id = suid
LIMIT 10;

--1.3+
SELECT COUNT(suid) AS 'SUBJECTS COUNT', 
       COUNT(DISTINCT TYPE_STUDY_LOAD.id) AS 'COUNT OF SUBJECTS TYPE'
FROM (
    SELECT DISTINCT RATING.study_id AS suid
    FROM RATING
    WHERE RATING.val IS NOT NULL
)
JOIN STUDY_LOAD ON STUDY_LOAD.id = suid
JOIN TYPE_STUDY_LOAD ON STUDY_LOAD.type_study_id = TYPE_STUDY_LOAD.id;

--1.4+
SELECT Prepods.last_name AS 'Name', 
       Prepods.first_name AS 'Surname',
       rval AS 'Count of mark'
FROM (
    SELECT COUNT(RATING.prepods_id) AS rval,
                    RATING.prepods_id AS pid
    FROM RATING
    WHERE RATING.val IS NOT NULL
    GROUP BY RATING.prepods_id
)
JOIN Prepods ON Prepods.id = pid
ORDER BY rval DESC;



--1.5+
SELECT Students.last_name
FROM Students
WHERE Students.id NOT IN (
    SELECT RATING.student_id
    FROM RATING
	WHERE RATING.val IS NOT NULL
);


--1.6+
SELECT Students.last_name as 'Name',
       Students.first_name as 'Surname', 
	   GROUPS.name AS 'Group',  
	   MAX(avg_mark) AS 'Average mark'
FROM (
    SELECT AVG(Rating.val) AS avg_mark,
           RATING.student_id AS suid
    FROM RATING
    GROUP BY Rating.student_id
)
JOIN Students ON suid = Students.id
JOIN GROUPS ON GROUPS.id = Students.group_id;