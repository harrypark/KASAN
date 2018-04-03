create table Copy_T(date char(8),year char(4),month char(2),day char(2))

declare @s_date char(8),@e_date char(8)
select @s_date ='20160101',@e_date = '20301231'

while @s_date <= @e_date
begin
           insert Copy_T values(@s_date,left(@s_date,4),substring(@s_date,5,2),right(@s_date,2))
           set @s_date = convert(char(8),dateadd(d,1,@s_date),112)
end

select * from Copy_T;


USE [KASAN_01]
GO

/****** Object:  Table [dbo].[ks_calendar]    Script Date: 2016-08-16 오후 10:51:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ks_calendar](
	[CAL_YEAR] [char](4) NOT NULL,
	[CAL_MONTH] [char](2) NOT NULL,
	[CAL_DAY] [char](2) NOT NULL,
	[CAL_DATE1] [varchar](10) NOT NULL,
	[CAL_DATE2] [varchar](8) NOT NULL,
	[CAL_DATE3] [date] NOT NULL,
	[CAL_WEEK_NAME] [varchar](10) NOT NULL,
	[CAL_WEEK_PART] [char](1) NOT NULL,
	[CAL_WEEKEND_YN] [char](1) NULL,
	[CAL_HOLIDAY_YN] [char](1) NULL,
	[CAL_HOLIDAY_NAME] [varchar](50) NULL,

 CONSTRAINT [PK__ks_calen__F66245EC8D6EA479] PRIMARY KEY CLUSTERED
(
	[CAL_YEAR] ASC,
	[CAL_MONTH] ASC,
	[CAL_DAY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO





insert into ks_calendar
select left(a.dt,4) as CAL_YEAR,
	   substring(a.dt,5,2) as CAL_MONTH,
	   right(a.dt,2) as CAL_DAY,
	   CONCAT(left(a.dt,4),'-',substring(a.dt,5,2),'-',right(a.dt,2)) as CAL_DATE1,
	   a.dt as CAL_DATE2,
	   convert(DATE,a.dt) as CAL_DATE3,
	   datename(dw,a.dt) as CAL_WEEK_NAME,
	   datepart(dw,a.dt) as CAL_WEEK_PART,
	   (CASE datepart(dw,a.dt)
		WHEN 1 THEN 'Y'
		WHEN 7 THEN 'Y'
		ELSE 'N'
		END ) as CAL_WEEKEND_YN,
	   'N' as CAL_LEGAL_HOLIDAY_YN,
	   null as CAL_LEGAL_HOLIDAY_NAME
from
(
select date dt from Copy_T
) a
;

-- 신정
update ks_calendar
set CAL_HOLIDAY_YN='Y',CAL_HOLIDAY_NAME='신정'
where CAL_MONTH='01' and CAL_DAY='01';
-- 삼일절
update ks_calendar
set CAL_HOLIDAY_YN='Y',CAL_HOLIDAY_NAME='삼일절'
where CAL_MONTH='03' and CAL_DAY='01';
-- 어린이날
update ks_calendar
set CAL_HOLIDAY_YN='Y',CAL_HOLIDAY_NAME='어린이날'
where CAL_MONTH='05' and CAL_DAY='05';
-- 현충일
update ks_calendar
set CAL_HOLIDAY_YN='Y',CAL_HOLIDAY_NAME='현충일'
where CAL_MONTH='06' and CAL_DAY='06';
-- 광복절
update ks_calendar
set CAL_HOLIDAY_YN='Y',CAL_HOLIDAY_NAME='광복절'
where CAL_MONTH='08' and CAL_DAY='15';
-- 개천절
update ks_calendar
set CAL_HOLIDAY_YN='Y',CAL_HOLIDAY_NAME='개천절'
where CAL_MONTH='10' and CAL_DAY='03';
-- 한글날
update ks_calendar
set CAL_HOLIDAY_YN='Y',CAL_HOLIDAY_NAME='한글날'
where CAL_MONTH='10' and CAL_DAY='09';
-- 크리스마스
update ks_calendar
set CAL_HOLIDAY_YN='Y',CAL_HOLIDAY_NAME='크리스마스'
where CAL_MONTH='12' and CAL_DAY='25';


select * from ks_calendar;


