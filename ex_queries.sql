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


-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT students.id, students.name, students.surname, degrees.id AS deg_id, degrees.name AS degree_name
FROM students
INNER JOIN degrees
ON degrees.id = students.degree_id
WHERE degrees.name LIKE "%Laurea in Econo%";


-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT degrees.id, degrees.name as degree_name, degrees.level, departments.name as department
FROM degrees
INNER JOIN departments
ON degrees.department_id = departments.id
WHERE departments.name LIKE "%Neuroscienze"
AND degrees.level = "magistrale";


-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT courses.id, courses.name as course_name, courses.period, courses.year, teachers.name as teacher, teachers.surname
FROM courses
INNER JOIN course_teacher
ON course_teacher.course_id = courses.id
INNER JOIN teachers
ON teachers.id = course_teacher.teacher_id
WHERE teachers.id = 44;


-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e 
-- il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT students.id, students.name, students.surname, degrees.name as degree, departments.name as department
FROM students
INNER JOIN degrees
ON degrees.id = students.degree_id
INNER JOIN departments
ON departments.id = degrees.department_id
ORDER BY students.surname, students.name;


-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT degrees.id, degrees.name as degree, degrees.level, courses.name as course, courses.year, teachers.name as teacher, teachers.surname
FROM degrees
INNER JOIN courses
ON courses.degree_id = degrees.id
INNER JOIN course_teacher
ON courses.id = course_teacher.course_id
INNER JOIN teachers
ON teachers.id = course_teacher.teacher_id
ORDER BY degrees.id;


-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT teachers.id, teachers.name, teachers.surname
FROM teachers
INNER JOIN course_teacher
ON course_teacher.teacher_id = teachers.id
INNER JOIN courses
ON courses.id = course_teacher.course_id
INNER JOIN degrees
ON degrees.id = courses.degree_id
INNER JOIN departments
ON departments.id = degrees.department_id
WHERE departments.name LIKE "%Matematica"
GROUP BY teachers.id;


-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT students.id, students.name, students.surname, exams.course_id, count(exam_student.exam_id) as tentativi, max(exam_student.vote) as voto_finale
FROM students
INNER JOIN exam_student
ON exam_student.student_id = students.id
INNER JOIN exams
ON exams.id = exam_student.exam_id
GROUP BY students.id, exams.course_id
HAVING voto_finale > 17;

















