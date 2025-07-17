use quanlysinhvien;

select * from student where StudentName like 'h%';
select * from class where month(StartDate) = 12; 
select * from subject where Credit between 3 and 5;
UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';
SELECT s.StudentName, sub.SubName, m.Mark
FROM Student s
JOIN Mark m ON s.StudentID = m.StudentID
JOIN Subject sub ON m.SubID = sub.SubID
ORDER BY m.Mark DESC, s.StudentName ASC;