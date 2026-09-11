with department as (
	select 
		edh.business_entity_id
		,d."name" as department_name
		,d.group_name as department_group_name
		,s."name" as shift
		,edh.start_date as department_valid_from
		,coalesce(edh.end_date, '9999-12-31')::date as department_valid_to
	from human_resources.employee_department_history edh
	left join human_resources.department d on edh.department_id = d.department_id
	left join human_resources.shift s on edh.shift_id = s.shift_id
	order by edh.business_entity_id, department_valid_from
)

,pay_history as (
	select 
		business_entity_id
		,rate
		,pay_frequency
		,rate_change_date::date as pay_valid_from
		,coalesce((lead(rate_change_date::date) over (
			partition by business_entity_id
			order by rate_change_date::date
		))::date, '9999-12-31') as pay_valid_to
	from human_resources.employee_pay_history
	order by business_entity_id, pay_valid_from
)
,emps as (
	select 
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
		, d.department_valid_from
		, d.department_valid_to
		, d.department_name
		, d.department_group_name
		, d.shift
		, ph.rate
		, ph.pay_valid_from
		, ph.pay_valid_to
		, ph.pay_frequency
		, greatest(d.department_valid_from, ph.pay_valid_from) as valid_from
		, least(d.department_valid_to, ph.pay_valid_to) as valid_to
		, case 
			when least(d.department_valid_to, ph.pay_valid_to)='9999-12-31' then true 
			else false 
		end as is_current
		,count(1) over (partition by e.business_entity_id) as n
	from human_resources.employee e
	join department d on e.business_entity_id = d.business_entity_id
	join pay_history ph 
		on e.business_entity_id = ph.business_entity_id
			and d.department_valid_from < ph.pay_valid_to
			and ph.pay_valid_from < d.department_valid_to
	order by e.business_entity_id, valid_from
)
select *
from emps
where n > 1 