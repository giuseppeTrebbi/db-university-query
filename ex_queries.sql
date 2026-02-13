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










