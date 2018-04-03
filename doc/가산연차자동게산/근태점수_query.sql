select Αυ, caps_name, dept_cd, dept_name,startDt,endDt,availCount,usedLeave,usedHlLeave,usedCount,currReplace,subShort,subLong,subFailTm,subAbsence,subLate
	       ,(subLate+subFailTm+subAbsence) as subCount
		   ,(availCount-usedCount-(subLate+subFailTm+subAbsence)) as currCount

	from (
		select u.id
			,u.caps_name
			,u.dept_cd
			,(select name from code_data where group_key='DEPT' and code=u.dept_cd and use_yn='Y') as dept_name
			,a.start_dt as startDt
			,a.end_dt as endDt
			,isnull(a.avail_count,0) as availCount
			,isnull(b.usedLeave,0) as usedLeave
			,isnull(c.usedHlLeave,0) as usedHlLeave
			,(isnull(b.usedLeave,0) + isnull(c.usedHlLeave,0)) as usedCount
			,kdr.month_replace_count-isnull(d.currReplace,0) as currReplace
			,isnull(e.subShort,0) as subShort
			,isnull(e.subLong,0) as subLong
			,isnull(e.subFailTm,0) as subFailTm
			,isnull(e.subAbsence,0) as subAbsence
			,isnull(FLOOR((1/convert(float, e.short_late_count)*subShort)+(1/convert(float, e.long_late_count)*subLong)),0) as subLate
		from ks_user u
		left outer join
			(select id, avail_count,start_dt,end_dt from ks_auto_annual where CONVERT(CHAR(10), getdate(), 23) between start_dt and end_dt) a on u.id=a.id
		left outer join
			(select crtd_id,count(distinct le_dt) as usedLeave from ks_leave where offcial='N' and year='2017' group by crtd_id) b on u.id=b.crtd_id
		left outer join
			(select crtd_id, count(distinct hl_dt)*0.5 as usedHlLeave from ks_half_leave where offcial='N' and year='2017' group by crtd_id) c on u.id=c.crtd_id
		left outer join
			(select kr.crtd_id,count(distinct repl_dt) as currReplace from ks_replace kr
			where  convert(varchar(7), repl_dt, 120) =convert(varchar(7), getdate(), 120)

			group by kr.crtd_id) d on u.id=d.crtd_id
		left outer join
			(
			select id
					,sum(kds.st_short_late) as subShort
					,sum(kds.st_long_late) as subLong
					,sum(kds.st_fail_work_tm) as subFailTm
					,sum(kds.st_absence) as subAbsence
					,min(kyr.short_late_count) as short_late_count
					,min(kyr.long_late_count) as long_late_count
			from ks_daily_stat kds,  ks_yearly_rule kyr
			where kds.st_year='2017' and kds.st_adjust='N'
			and kyr.apply_year='2017'
			and kds.st_year=kyr.apply_year
			group by id
		) e on u.id=e.id
		,ks_daily_rule kdr
		where getdate() between kdr.apply_start_dt and kdr.apply_end_dt
		and u.auth_cd <> '003' and u.state_cd='001'
	) a

select u.id, u.caps_id,u.caps_name,a.avail_count,a.start_dt,a.end_dt 
      ,ifnull((select count(*) from ks_leave where id=u.id and offcial='N' and leave_dt between a.start_dt and a.end_dt group by id),0) usedLeave 
from ks_user u left outer join ks_auto_annual a on u.id=a.id 
and u.auth_cd <> '003' and u.state_cd='001'



-- 1

select u.id, u.auth_cd,u.state_cd,u.caps_id,u.caps_name,a.avail_count,a.start_dt,a.end_dt 
      ,ISNULL((select count(*) from ks_leave where crtd_id=u.id and offcial='N' and le_dt between a.start_dt and a.end_dt group by crtd_id),0) as usedLeave
	  ,ISNULL((select count(distinct hl_dt)*0.5from ks_half_leave where crtd_id=u.id and offcial='N' and hl_dt between a.start_dt and a.end_dt group by crtd_id),0) as usedHlLeave
	  ,kdr.month_replace_count-ISNULL(d.currReplace,0) as currReplace
from ks_user u left outer join ks_auto_annual a on u.id=a.id 
left outer join
			(select kr.crtd_id,count(distinct repl_dt) as currReplace from ks_replace kr
			where  convert(varchar(7), repl_dt, 120) =convert(varchar(7), getdate(), 120)
			group by kr.crtd_id) d on u.id=d.crtd_id
,ks_daily_rule kdr
where u.auth_cd <> '003' and u.state_cd = '001';


-- 2 stat
select kds.id
		,sum(kds.st_short_late) as subShort
		,sum(kds.st_long_late) as subLong
		,sum(kds.st_fail_work_tm) as subFailTm
		,sum(kds.st_absence) as subAbsence
		,min(kyr.short_late_count) as short_late_count
		,min(kyr.long_late_count) as long_late_count
from ks_daily_stat kds
left outer join ks_auto_annual a on kds.id=a.id 
, ks_yearly_rule kyr
where kds.st_dt between a.start_dt and a.end_dt and  kds.st_adjust='N'
and kyr.apply_year='2017'
and kds.st_year=kyr.apply_year
group by kds.id;

-- °ΛΑυ
select id
		,sum(kds.st_short_late) as subShort
		,sum(kds.st_long_late) as subLong
		,sum(kds.st_fail_work_tm) as subFailTm
		,sum(kds.st_absence) as subAbsence
		,min(kyr.short_late_count) as short_late_count
		,min(kyr.long_late_count) as long_late_count
from ks_daily_stat kds,  ks_yearly_rule kyr
where kds.st_year='2017' and kds.st_adjust='N'
and kyr.apply_year='2017'
and kds.st_year=kyr.apply_year
group by id;




select * from ks_daily_stat;



select * from ks_half_Leave  where crtd_id=2 and offcial='N';



select * from ks_user
where auth_cd <> '003' and state_cd = '001';