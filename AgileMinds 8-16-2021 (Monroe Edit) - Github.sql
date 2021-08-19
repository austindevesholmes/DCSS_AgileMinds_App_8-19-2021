--This is a script for the Agile Minds Application to retrieve students that are taking specific courses during a specific period number.  

SELECT DISTINCT
p.studentnumber as 'Student Local ID', 
ua.username as 'User ID',
i.lastname AS StudentLastName,
i.firstname AS StudentFirstName,
e.grade AS StudentGrade, 
sl.name AS School, 
course_num AS Course,  
period_num AS 'Class/Period' ,  
it.firstname + ' ' + it.lastname as 'Teacher' 


FROM p
JOIN i with(nolock) on i.identityID = p.currentidentityID
JOIN e with(nolock) on e.personID = p.personID
JOIN cl with(nolock) on cl.calendarID = e.calendarID 
JOIN sl with(nolock) ON sl.schoolid = cl.schoolid 
JOIN sy with(nolock) on sy.endyear = e.endyear and sy.active =1
LEFT JOIN ct with(nolock) on ct.personID = p.personID
JOIN sc with(nolock) on sc.personID = e.personID and e.calendarID  = sc.calendarID
LEFT JOIN r with(nolock) on r.personID = p.personID
LEFT JOIN se with(nolock) on se.sectionID = r.sectionID
LEFT JOIN pd with(nolock) on pd.periodid = se.sectionid 
LEFT JOIN c with(nolock) on c.courseID = se.courseID and c.calendarID = cl.calendarID
JOIN pt with(nolock) on pt.personID = sc.teacherPersonID
JOIN it with(nolock) on it.identityID= pt.currentIdentityID
LEFT JOIN ctt with(nolock) on ctt.personID = pt.personID
LEFT JOIN ua ON ua.personid = p.personid

WHERE
sy.active = 1 
AND e.active = 1
AND ISNULL(e.noshow, 0) = 0
AND e.enddate is null
AND sc.term_num = '1'
AND sc.end_date IS NULL
AND ct.email IS NOT NULL 
AND (course_num in ('27.0990038') OR  course_num = '27.1990038' and period_num = '6')

ORDER BY 
sl.name, 'Teacher', i.lastname, i.firstname