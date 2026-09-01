-- ============================================================
-- 02_optimized.sql
-- Optimized solution
-- PostgreSQL
-- ============================================================

with

primary_diagnosis as
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
