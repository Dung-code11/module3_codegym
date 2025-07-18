use quanlysinhvien;

-- bài 1
select * from subject where Credit = (select max(Credit) from subject);
-- bài 2
select subject.* from subject
join mark on subject.SubId = mark.SubId
where mark.Mark = (select max(Mark) from mark);
-- bài 3
select student.StudentId,student.StudentName,avg(mark.Mark) as avg_score
from student
join mark on student.StudentId = mark.StudentId
group by student.StudentId,student.StudentName
order by avg_score desc;