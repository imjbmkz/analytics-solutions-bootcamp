with employee_250 as (
	SELECT 
		e.business_entity_id
		, e.national_id_number
		, e.login_id
		, e.organization_node
		, e.organization_level
		, e.job_title
		, e.birth_date
		, e.marital_status
		, e.gender
		, e.hire_date
		, e.salaried_flag
		, e.vacation_hours
		, e.sick_leave_hours
		, e.current_flag
		, e.rowguid
		, e.modified_date
		, edh.department_id 
		, edh.start_date as department_start_date
		, coalesce(edh.end_date,'9999-12-31') as department_end_date
		, d."name" as department_name
		, d.group_name as department_group_name
		, s."name" as shift
		, eph.rate
		, eph.rate_change_date::date as rate_change_date
		, eph.pay_frequency
		, count(1) over (partition by e.business_entity_id) as n
	FROM human_resources.employee e
	left join human_resources.employee_department_history edh on e.business_entity_id = edh.business_entity_id 
	left join human_resources.department d on edh.department_id = d.department_id 
	left join human_resources.shift s on edh.shift_id = s.shift_id
	left join human_resources.employee_pay_history eph on e.business_entity_id = eph.business_entity_id
	where e.business_entity_id = 250
)
select 
	business_entity_id
	,hire_date
	,department_start_date
	,department_end_date
	,department_name
	,department_group_name
	,shift
	,rate
	,rate_change_date
	,pay_frequency
from employee_250
order by department_start_date, rate_change_date
;

