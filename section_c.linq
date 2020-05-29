// q
const int salaryscope = 80000;
var selectedFaculty = from f in Faculties
where f.FSalary >= salaryscope
select f;

selectedFaculty.Dump();


// r
var misCourses = 
	from Cor in Courses
	where Cor.CourseNo.Contains("MIS")
	select Cor;

misCourses.Dump();


// t
var roomNum = 
	from l in Locations
	group l.Capacity by l.BldgCode
	into tr
	select new
	{
		BuildingCode = tr.Key,
		TotalRooms = tr.Sum()
	};
	
roomNum.Dump();