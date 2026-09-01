-- ============================================================
-- 03_data_quality.sql
-- Data quality checks
-- ============================================================


-- ============================================================
-- Problem 1
-- is_primary = true, но существует более ранний
-- диагноз с тем же кодом у того же пациента
-- ============================================================

SELECT
    d1.patient_id,
    d1.mkb_code,
    d1.diagnosis_date,
    d2.diagnosis_date AS earlier_diagnosis
FROM diagnoses d1
INNER JOIN diagnoses d2
    ON d1.patient_id = d2.patient_id
   AND d1.mkb_code = d2.mkb_code
   AND d2.diagnosis_date < d1.diagnosis_date
WHERE d1.is_primary = TRUE;


-- ============================================================
-- Problem 2
-- Дата постановки на Д-учёт раньше даты диагноза
-- ============================================================

SELECT
    r.patient_id,
    r.mkb_code,
    r.registration_date,
    d.diagnosis_date
FROM dispensary_registry r
INNER JOIN diagnoses d
    ON r.patient_id = d.patient_id
   AND r.mkb_code = d.mkb_code
WHERE r.registration_date < d.diagnosis_date;


-- ============================================================
-- Problem 3
-- Неконсистентный регистр visit_type
-- ============================================================

SELECT
    visit_id,
    visit_type
FROM visits
WHERE LOWER(visit_type) = 'профосмотр'
  AND visit_type != 'профосмотр';