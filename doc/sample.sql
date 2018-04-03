-- 연차
select ku.id,ku.caps_id,ku.caps_name,ka.year,ISNULL(ka.year,'2016'),ISNULL(ka.avail_count,0),ISNULL(ka.used_count,0)
from ks_user ku left outer join
(select * from ks_annual where year='2016' ) ka
on ku.id=ka.id
;

select min(Att_Date),id,UserName
from Attendance
where Att_Date BETWEEN '20160728080000' AND 20160728100000
group by id,UserName;


select max(Att_Date),id,UserName
from Attendance
where Att_Date BETWEEN '20160728080000' AND '20160728235959'
group by id,UserName;

