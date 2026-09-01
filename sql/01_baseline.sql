-- ============================================================
-- 01_baseline.sql
-- Initial working solution
-- PostgreSQL
-- ============================================================

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
