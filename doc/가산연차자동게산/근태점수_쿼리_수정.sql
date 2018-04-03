
select u.id, u.auth_cd,u.state_cd,u.caps_id,u.caps_name,a.avail_count,a.start_dt,a.end_dt 
      ,ISNULL((select count(*) from ks_leave where crtd_id=u.id and offcial='N' and le_dt between a.start_dt and a.end_dt group by crtd_id),0) as usedLeave
	  ,ISNULL((select count(distinct hl_dt)*0.5from ks_half_leave where crtd_id=u.id and offcial='N' and hl_dt between a.start_dt and a.end_dt group by crtd_id),0) as usedHlLeave
	  ,kdr.month_replace_count-ISNULL(d.currReplace,0) as currReplace
	  ,ds.subShort
	  ,ds.subLong
	  ,ds.subFailTm
	  ,ds.subAbsence
	  ,ds.short_late_count
	  ,ds.long_late_count
from ks_user u left outer join ks_auto_annual a on u.id=a.id 
left outer join
			(select kr.crtd_id,count(distinct repl_dt) as currReplace from ks_replace kr
			where  convert(varchar(7), repl_dt, 120) =convert(varchar(7), getdate(), 120)
			group by kr.crtd_id) d on u.id=d.crtd_id
left outer join
(
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
group by kds.id
) ds on u.id=ds.id 
,ks_daily_rule kdr
where u.auth_cd <> '003' and u.state_cd = '001';


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

=====================================================================================================================================================
√÷¡æƒı∏Æ

select id, caps_name, dept_cd, dept_name,availCount,usedLeave,usedHlLeave
           , (isnull(usedLeave,0) + isnull(usedHlLeave,0)) as usedCount
		   ,currReplace,subShort,subLong,subFailTm,subAbsence
		   ,subLate
	       ,(subLate+subFailTm+subAbsence) as subCount
		   ,(availCount-(isnull(usedLeave,0) + isnull(usedHlLeave,0))-(subLate+subFailTm+subAbsence)) as currCount

	from (
		select u.id, u.auth_cd,u.state_cd,u.caps_id,u.caps_name
		        ,a.avail_count as availCount
				,a.start_dt,a.end_dt
		       ,u.dept_cd
			   ,(select name from code_data where group_key='DEPT' and code=u.dept_cd and use_yn='Y') as dept_name 
			  ,ISNULL((select count(*) from ks_leave where crtd_id=u.id and offcial='N' and le_dt between a.start_dt and a.end_dt group by crtd_id),0) as usedLeave
			  ,ISNULL((select count(distinct hl_dt)*0.5from ks_half_leave where crtd_id=u.id and offcial='N' and hl_dt between a.start_dt and a.end_dt group by crtd_id),0) as usedHlLeave
			  ,kdr.month_replace_count-ISNULL(d.currReplace,0) as currReplace
			  ,ds.subShort
			  ,ds.subLong
			  ,ds.subFailTm
			  ,ds.subAbsence
			  ,ds.short_late_count
			  ,ds.long_late_count
			  ,isnull(FLOOR((1/convert(float, ds.short_late_count)*ds.subShort)+(1/convert(float, ds.long_late_count)*ds.subLong)),0) as subLate
		from ks_user u left outer join ks_auto_annual a on u.id=a.id 
		left outer join
					(select kr.crtd_id,count(distinct repl_dt) as currReplace from ks_replace kr
					where  convert(varchar(7), repl_dt, 120) =convert(varchar(7), getdate(), 120)
					group by kr.crtd_id) d on u.id=d.crtd_id
		left outer join
		(
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
		and kyr.apply_year=YEAR(GETDATE())
		and kds.st_year=kyr.apply_year
		group by kds.id
		) ds on u.id=ds.id 
		,ks_daily_rule kdr
		where u.auth_cd <> '003' and u.state_cd = '001'
		-- and u.id=2
		-- and u.dept_cd='001'
		) k