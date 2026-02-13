USE university_db;


-- Selezionare tutti gli studenti nati nel 1990 (160)
SELECT id, `name`, surname, date_of_birth, registration_number 
FROM students
WHERE date_of_birth LIKE "1990%";


-- Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT *
FROM courses
WHERE cfu > 10;


-- Selezionare tutti gli studenti che hanno più di 30 anni
SELECT id, name, surname, date_of_birth, TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age
FROM students
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) > 30;


-- Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT *
FROM courses
WHERE period LIKE "I %"
AND year = 1;


-- Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT *
FROM exams
WHERE `date` = "2020-06-20"
AND HOUR(`hour`) >= 14;


-- Selezionare tutti i corsi di laurea magistrale (38)
SELECT *
FROM degrees
WHERE `level` LIKE "magi%";


-- Da quanti dipartimenti è composta l'università? (12)
SELECT count(id) AS numero_dipartimenti
FROM departments;


-- Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT count(id) AS insegnanti_senza_cellulare
FROM teachers
WHERE phone IS NULL;


-- Contare quanti iscritti ci sono stati ogni anno
SELECT count(id) AS numero_iscritti, year(enrolment_date) AS anno_scolastico
FROM students
GROUP BY year(enrolment_date);


-- Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT count(id) AS numero_insegnanti, office_address
FROM teachers
GROUP BY office_address;


-- Calcolare la media dei voti di ogni appello d'esame
SELECT exam_id, AVG(vote) AS media_voti, count(student_id) AS esami_sostenuti
FROM exam_student
GROUP BY exam_id;


-- Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT departments.id, departments.name, count(degrees.id) AS nr_corsi_di_laurea
FROM degrees
INNER JOIN departments
ON degrees.department_id = departments.id
GROUP BY departments.id;







