--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2026-09-01 19:20:57

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 25122)
-- Name: diagnoses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diagnoses (
    diagnosis_id uuid NOT NULL,
    visit_id uuid NOT NULL,
    patient_id uuid NOT NULL,
    diagnosis_date date NOT NULL,
    mkb_code character varying(10) NOT NULL,
    is_primary boolean NOT NULL,
    diagnosis_type character varying(40) NOT NULL,
    CONSTRAINT diagnoses_diagnosis_type_check CHECK (((diagnosis_type)::text = ANY ((ARRAY['впервые установленный'::character varying, 'уточненный'::character varying])::text[])))
);


ALTER TABLE public.diagnoses OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 25138)
-- Name: dispensary_registry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dispensary_registry (
    registry_id uuid NOT NULL,
    patient_id uuid NOT NULL,
    mkb_code character varying(10) NOT NULL,
    registration_date date NOT NULL,
    removal_date date,
    doctor_id integer NOT NULL
);


ALTER TABLE public.dispensary_registry OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25148)
-- Name: examinations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.examinations (
    exam_id uuid NOT NULL,
    patient_id uuid NOT NULL,
    exam_date date NOT NULL,
    exam_type character varying(30) NOT NULL,
    result character varying(30) NOT NULL,
    CONSTRAINT examinations_exam_type_check CHECK (((exam_type)::text = ANY ((ARRAY['предварительный'::character varying, 'периодический'::character varying, 'углубленный'::character varying])::text[]))),
    CONSTRAINT examinations_result_check CHECK (((result)::text = ANY ((ARRAY['годен'::character varying, 'ограниченно годен'::character varying, 'не годен'::character varying])::text[])))
);


ALTER TABLE public.examinations OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 25105)
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients (
    patient_id uuid NOT NULL,
    birth_date date NOT NULL,
    gender character varying(1) NOT NULL,
    attachment_date date NOT NULL,
    polyclinic_id integer NOT NULL,
    CONSTRAINT patients_gender_check CHECK (((gender)::text = ANY ((ARRAY['М'::character varying, 'Ж'::character varying])::text[])))
);


ALTER TABLE public.patients OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 25111)
-- Name: visits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visits (
    visit_id uuid NOT NULL,
    patient_id uuid NOT NULL,
    visit_date date NOT NULL,
    visit_type character varying(30) NOT NULL,
    doctor_id integer NOT NULL,
    department character varying(50) NOT NULL,
    CONSTRAINT visits_visit_type_check CHECK (((visit_type)::text = ANY ((ARRAY['первичный'::character varying, 'повторный'::character varying, 'профосмотр'::character varying, 'диспансеризация'::character varying, 'скорая'::character varying])::text[])))
);


ALTER TABLE public.visits OWNER TO postgres;

--
-- TOC entry 4868 (class 0 OID 25122)
-- Dependencies: 217
-- Data for Name: diagnoses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diagnoses (diagnosis_id, visit_id, patient_id, diagnosis_date, mkb_code, is_primary, diagnosis_type) FROM stdin;
20000000-0000-0000-0000-000000000001	10000000-0000-0000-0000-000000000001	11111111-1111-1111-1111-111111111111	2024-01-10	J06	t	впервые установленный
20000000-0000-0000-0000-000000000002	10000000-0000-0000-0000-000000000002	11111111-1111-1111-1111-111111111111	2024-03-01	J06	f	уточненный
20000000-0000-0000-0000-000000000003	10000000-0000-0000-0000-000000000003	22222222-2222-2222-2222-222222222222	2024-02-05	I10	t	впервые установленный
20000000-0000-0000-0000-000000000004	10000000-0000-0000-0000-000000000004	22222222-2222-2222-2222-222222222222	2024-04-18	I10	f	уточненный
20000000-0000-0000-0000-000000000005	10000000-0000-0000-0000-000000000005	33333333-3333-3333-3333-333333333333	2024-01-22	S62	t	впервые установленный
20000000-0000-0000-0000-000000000006	10000000-0000-0000-0000-000000000006	33333333-3333-3333-3333-333333333333	2024-05-02	S62	f	уточненный
20000000-0000-0000-0000-000000000007	10000000-0000-0000-0000-000000000007	44444444-4444-4444-4444-444444444444	2024-03-12	E11	t	впервые установленный
20000000-0000-0000-0000-000000000008	10000000-0000-0000-0000-000000000009	66666666-6666-6666-6666-666666666666	2024-01-28	G43	t	впервые установленный
20000000-0000-0000-0000-000000000009	10000000-0000-0000-0000-000000000010	77777777-7777-7777-7777-777777777777	2024-06-06	E66	t	впервые установленный
20000000-0000-0000-0000-000000000010	10000000-0000-0000-0000-000000000011	88888888-8888-8888-8888-888888888888	2024-02-14	I20	t	впервые установленный
20000000-0000-0000-0000-000000000011	10000000-0000-0000-0000-000000000012	99999999-9999-9999-9999-999999999999	2024-05-20	I21	t	впервые установленный
20000000-0000-0000-0000-000000000012	10000000-0000-0000-0000-000000000013	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	2024-04-25	N39	t	впервые установленный
60000000-0000-0000-0000-000000000001	50000000-0000-0000-0000-000000000002	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	2026-01-18	E43	t	впервые установленный
60000000-0000-0000-0000-000000000002	50000000-0000-0000-0000-000000000004	cccccccc-cccc-cccc-cccc-cccccccccccc	2026-02-09	E44	t	впервые установленный
60000000-0000-0000-0000-000000000003	50000000-0000-0000-0000-000000000006	dddddddd-dddd-dddd-dddd-dddddddddddd	2026-01-12	E45	t	впервые установленный
60000000-0000-0000-0000-000000000004	50000000-0000-0000-0000-000000000008	eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee	2026-03-03	I10	t	впервые установленный
60000000-0000-0000-0000-000000000005	50000000-0000-0000-0000-000000000010	11111111-1111-1111-1111-111111111111	2026-02-10	J06	t	впервые установленный
60000000-0000-0000-0000-000000000006	50000000-0000-0000-0000-000000000011	66666666-6666-6666-6666-666666666666	2026-03-10	G43	t	впервые установленный
\.


--
-- TOC entry 4869 (class 0 OID 25138)
-- Dependencies: 218
-- Data for Name: dispensary_registry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dispensary_registry (registry_id, patient_id, mkb_code, registration_date, removal_date, doctor_id) FROM stdin;
30000000-0000-0000-0000-000000000001	22222222-2222-2222-2222-222222222222	I10	2024-02-05	\N	102
30000000-0000-0000-0000-000000000002	44444444-4444-4444-4444-444444444444	E11	2024-03-12	\N	104
30000000-0000-0000-0000-000000000003	77777777-7777-7777-7777-777777777777	E66	2024-06-06	\N	107
30000000-0000-0000-0000-000000000004	88888888-8888-8888-8888-888888888888	I20	2024-02-14	\N	108
30000000-0000-0000-0000-000000000005	99999999-9999-9999-9999-999999999999	I21	2024-05-20	\N	109
30000000-0000-0000-0000-000000000006	33333333-3333-3333-3333-333333333333	S62	2024-01-22	2024-06-01	103
70000000-0000-0000-0000-000000000001	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	E43	2026-02-05	\N	201
70000000-0000-0000-0000-000000000002	cccccccc-cccc-cccc-cccc-cccccccccccc	E44	2026-02-20	\N	202
70000000-0000-0000-0000-000000000003	dddddddd-dddd-dddd-dddd-dddddddddddd	E45	2026-03-30	\N	203
70000000-0000-0000-0000-000000000004	66666666-6666-6666-6666-666666666666	G43	2026-03-01	\N	106
\.


--
-- TOC entry 4870 (class 0 OID 25148)
-- Dependencies: 219
-- Data for Name: examinations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.examinations (exam_id, patient_id, exam_date, exam_type, result) FROM stdin;
40000000-0000-0000-0000-000000000001	11111111-1111-1111-1111-111111111111	2024-02-01	периодический	годен
40000000-0000-0000-0000-000000000002	22222222-2222-2222-2222-222222222222	2024-02-01	углубленный	ограниченно годен
40000000-0000-0000-0000-000000000003	33333333-3333-3333-3333-333333333333	2024-01-15	предварительный	годен
40000000-0000-0000-0000-000000000004	44444444-4444-4444-4444-444444444444	2024-03-10	углубленный	ограниченно годен
40000000-0000-0000-0000-000000000005	55555555-5555-5555-5555-555555555555	2024-04-15	предварительный	годен
40000000-0000-0000-0000-000000000006	66666666-6666-6666-6666-666666666666	2024-05-08	периодический	годен
40000000-0000-0000-0000-000000000007	77777777-7777-7777-7777-777777777777	2024-06-10	углубленный	ограниченно годен
40000000-0000-0000-0000-000000000008	88888888-8888-8888-8888-888888888888	2024-02-15	периодический	не годен
40000000-0000-0000-0000-000000000009	99999999-9999-9999-9999-999999999999	2024-05-25	углубленный	не годен
40000000-0000-0000-0000-000000000010	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	2024-04-26	предварительный	годен
80000000-0000-0000-0000-000000000001	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	2026-01-15	периодический	годен
80000000-0000-0000-0000-000000000002	cccccccc-cccc-cccc-cccc-cccccccccccc	2026-02-05	углубленный	годен
80000000-0000-0000-0000-000000000003	dddddddd-dddd-dddd-dddd-dddddddddddd	2026-01-10	предварительный	годен
80000000-0000-0000-0000-000000000004	eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee	2026-03-01	периодический	годен
80000000-0000-0000-0000-000000000005	ffffffff-ffff-ffff-ffff-ffffffffffff	2026-02-18	предварительный	годен
\.


--
-- TOC entry 4866 (class 0 OID 25105)
-- Dependencies: 215
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients (patient_id, birth_date, gender, attachment_date, polyclinic_id) FROM stdin;
11111111-1111-1111-1111-111111111111	1985-03-14	М	2018-05-10	1
22222222-2222-2222-2222-222222222222	1990-08-21	Ж	2019-02-15	1
33333333-3333-3333-3333-333333333333	1972-11-04	М	2017-06-20	2
44444444-4444-4444-4444-444444444444	1968-01-30	Ж	2016-01-12	2
55555555-5555-5555-5555-555555555555	2000-09-10	М	2021-04-01	3
66666666-6666-6666-6666-666666666666	1995-12-18	Ж	2020-10-05	3
77777777-7777-7777-7777-777777777777	1988-07-11	М	2018-09-14	1
88888888-8888-8888-8888-888888888888	1979-02-22	Ж	2015-03-19	2
99999999-9999-9999-9999-999999999999	1960-05-08	М	2014-07-08	1
aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	1998-04-17	Ж	2022-02-01	3
bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	1982-05-14	М	2023-02-01	1
cccccccc-cccc-cccc-cccc-cccccccccccc	1978-08-30	Ж	2022-04-12	2
dddddddd-dddd-dddd-dddd-dddddddddddd	1991-11-08	М	2024-01-20	1
eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee	1987-09-18	Ж	2021-07-15	3
ffffffff-ffff-ffff-ffff-ffffffffffff	1994-12-03	М	2020-10-10	2
\.


--
-- TOC entry 4867 (class 0 OID 25111)
-- Dependencies: 216
-- Data for Name: visits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.visits (visit_id, patient_id, visit_date, visit_type, doctor_id, department) FROM stdin;
10000000-0000-0000-0000-000000000001	11111111-1111-1111-1111-111111111111	2024-01-10	первичный	101	терапия
10000000-0000-0000-0000-000000000002	11111111-1111-1111-1111-111111111111	2024-03-01	повторный	101	терапия
10000000-0000-0000-0000-000000000003	22222222-2222-2222-2222-222222222222	2024-02-05	первичный	102	кардиология
10000000-0000-0000-0000-000000000004	22222222-2222-2222-2222-222222222222	2024-04-18	повторный	102	кардиология
10000000-0000-0000-0000-000000000005	33333333-3333-3333-3333-333333333333	2024-01-22	скорая	103	хирургия
10000000-0000-0000-0000-000000000006	33333333-3333-3333-3333-333333333333	2024-05-02	повторный	103	хирургия
10000000-0000-0000-0000-000000000007	44444444-4444-4444-4444-444444444444	2024-03-12	диспансеризация	104	терапия
10000000-0000-0000-0000-000000000008	55555555-5555-5555-5555-555555555555	2024-04-15	профосмотр	105	терапия
10000000-0000-0000-0000-000000000009	66666666-6666-6666-6666-666666666666	2024-01-28	первичный	106	неврология
10000000-0000-0000-0000-000000000010	77777777-7777-7777-7777-777777777777	2024-06-06	первичный	107	эндокринология
10000000-0000-0000-0000-000000000011	88888888-8888-8888-8888-888888888888	2024-02-14	повторный	108	кардиология
10000000-0000-0000-0000-000000000012	99999999-9999-9999-9999-999999999999	2024-05-20	скорая	109	реанимация
10000000-0000-0000-0000-000000000013	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	2024-04-25	первичный	110	гинекология
50000000-0000-0000-0000-000000000001	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	2026-01-15	профосмотр	201	терапия
50000000-0000-0000-0000-000000000002	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	2026-01-18	первичный	201	терапия
50000000-0000-0000-0000-000000000003	cccccccc-cccc-cccc-cccc-cccccccccccc	2026-02-05	профосмотр	202	терапия
50000000-0000-0000-0000-000000000004	cccccccc-cccc-cccc-cccc-cccccccccccc	2026-02-09	первичный	202	терапия
50000000-0000-0000-0000-000000000005	dddddddd-dddd-dddd-dddd-dddddddddddd	2026-01-10	профосмотр	203	терапия
50000000-0000-0000-0000-000000000006	dddddddd-dddd-dddd-dddd-dddddddddddd	2026-01-12	первичный	203	терапия
50000000-0000-0000-0000-000000000007	eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee	2026-03-01	профосмотр	204	терапия
50000000-0000-0000-0000-000000000008	eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee	2026-03-03	первичный	204	терапия
50000000-0000-0000-0000-000000000010	11111111-1111-1111-1111-111111111111	2026-02-10	повторный	101	терапия
50000000-0000-0000-0000-000000000011	66666666-6666-6666-6666-666666666666	2026-03-10	первичный	106	неврология
\.


--
-- TOC entry 4713 (class 2606 OID 25127)
-- Name: diagnoses diagnoses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnoses
    ADD CONSTRAINT diagnoses_pkey PRIMARY KEY (diagnosis_id);


--
-- TOC entry 4715 (class 2606 OID 25142)
-- Name: dispensary_registry dispensary_registry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispensary_registry
    ADD CONSTRAINT dispensary_registry_pkey PRIMARY KEY (registry_id);


--
-- TOC entry 4717 (class 2606 OID 25154)
-- Name: examinations examinations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examinations
    ADD CONSTRAINT examinations_pkey PRIMARY KEY (exam_id);


--
-- TOC entry 4709 (class 2606 OID 25110)
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (patient_id);


--
-- TOC entry 4711 (class 2606 OID 25116)
-- Name: visits visits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visits
    ADD CONSTRAINT visits_pkey PRIMARY KEY (visit_id);


--
-- TOC entry 4719 (class 2606 OID 25133)
-- Name: diagnoses diagnoses_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnoses
    ADD CONSTRAINT diagnoses_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- TOC entry 4720 (class 2606 OID 25128)
-- Name: diagnoses diagnoses_visit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnoses
    ADD CONSTRAINT diagnoses_visit_id_fkey FOREIGN KEY (visit_id) REFERENCES public.visits(visit_id);


--
-- TOC entry 4721 (class 2606 OID 25143)
-- Name: dispensary_registry dispensary_registry_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispensary_registry
    ADD CONSTRAINT dispensary_registry_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- TOC entry 4722 (class 2606 OID 25155)
-- Name: examinations examinations_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examinations
    ADD CONSTRAINT examinations_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- TOC entry 4718 (class 2606 OID 25117)
-- Name: visits visits_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visits
    ADD CONSTRAINT visits_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


-- Completed on 2026-09-01 19:20:58

--
-- PostgreSQL database dump complete
--

