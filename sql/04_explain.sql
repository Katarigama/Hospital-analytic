-- ============================================================
-- 04_explain.sql
-- Query execution plan
-- ============================================================


EXPLAIN (ANALYZE, BUFFERS)
with

lpd AS
(
    SELECT
        dr.patient_id,
        max(v.visit_date) AS last_visit_date
    from dispensary_registry dr
    inner join visits v on dr.patient_id = v.patient_id
    where
        v.visit_type = 'профосмотр'
        and v.visit_date <= dr.registration_date
    group by
        dr.patient_id,
        dr.registration_date
)


select 
	count(p.patient_id) from patients p 
	left join visits v on v.patient_id = p.patient_id 
	left join diagnoses d on d.visit_id = v.visit_id 
	left join dispensary_registry dr on dr.patient_id = p.patient_id 
	left join lpd on lpd.patient_id = p.patient_id 
	left join examinations e on e.patient_id = p.patient_id 
where 
	d.mkb_code between 'E40' and 'E46'
	and d.is_primary = true
	and (d.diagnosis_date between '2026-01-01' and '2026-03-31') 
	and (dr.registration_date - lpd.last_visit_date) <= 45 
	and dr.removal_date IS null
	and lpd.last_visit_date <= dr.registration_date;




EXPLAIN (ANALYZE, BUFFERS)
with primary_diagnosis as
(
    select
        patient_id,
        mkb_code
    from diagnoses
    where
        is_primary = true
        and diagnosis_date between '2026-01-01' and '2026-03-31'
        and mkb_code between 'E40' and 'E46'
),

primary_registry as
(
    select
        r.patient_id,
        r.mkb_code,
        r.registration_date,
        max(v.visit_date) as last_exam_date
    from dispensary_registry r
    inner join visits v
        on r.patient_id = v.patient_id
    where removal_date IS null
    	and v.visit_type = 'профосмотр'
        and v.visit_date <= r.registration_date
    group by
        r.patient_id,
        r.registration_date,
        r.mkb_code
)

select
    count(distinct pd.patient_id) AS patients_count
from primary_diagnosis pd
inner join primary_registry pr
    on pd.patient_id = pr.patient_id
   and pd.mkb_code = pr.mkb_code
where
        (pr.registration_date- pr.last_exam_date ) <= 45;
       
       
-- результат показывает, что первая версия планируется 5.8 мс, выполняется 0.5 мс, 
-- а вторая версия планируется 0.24 мс, а выполняется за 0.1 мс.
