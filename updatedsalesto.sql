--
-- PostgreSQL database dump
--

\restrict OJc6ctZbv6boxj4DxdJc7icvSFKYq0KcQajxrDAparjIf6BW6CEKzXHNnb4vYc1

-- Dumped from database version 16.11 (Debian 16.11-1.pgdg12+1)
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-22 12:38:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16491)
-- Name: sales; Type: TABLE; Schema: public; Owner: banelo_db_user
--

CREATE TABLE public.sales (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    firebase_id character varying(255),
    order_id integer,
    product_name character varying(255) NOT NULL,
    category character varying(100),
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    total_amount numeric(10,2) GENERATED ALWAYS AS (((quantity)::numeric * price)) STORED,
    order_date timestamp without time zone NOT NULL,
    product_firebase_id uuid,
    payment_mode character varying(50) DEFAULT 'Cash'::character varying,
    gcash_reference_id character varying(255),
    cashier_username character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_payment_mode CHECK (((payment_mode)::text = ANY (ARRAY[('Cash'::character varying)::text, ('GCash'::character varying)::text, ('Card'::character varying)::text, ('cash'::character varying)::text, ('gcash'::character varying)::text, ('card'::character varying)::text]))),
    CONSTRAINT check_price_positive CHECK ((price >= (0)::numeric)),
    CONSTRAINT check_quantity_positive CHECK ((quantity > 0))
);


ALTER TABLE public.sales OWNER TO banelo_db_user;

--
-- TOC entry 3463 (class 0 OID 16491)
-- Dependencies: 221
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: banelo_db_user
--

COPY public.sales (id, firebase_id, order_id, product_name, category, quantity, price, order_date, product_firebase_id, payment_mode, gcash_reference_id, cashier_username, created_at) FROM stdin;
d6775541-cdf7-4c92-a5f6-4811298e0736	LaueWZ5CxkfsGgFS0cmP	7	Iced Coffee	Beverages	4	107.80	2025-07-13 06:16:43	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904511660	antonio.santos6	2025-07-13 06:16:43
77509f25-ec71-407a-99cd-7dfd20ee56cb	iCrFrMNT4WzGQrtE9YHM	8	Glazed Donut	Pastries	4	148.75	2025-05-23 09:53:01	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.reyes9	2025-05-23 09:53:01
5471ce1c-3406-4d61-a072-ad0550137855	2fHHVHa7Y77ya6MbPUuE	13	Baguette	Pastries	4	133.77	2024-11-25 02:24:09	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.delacruz	2024-11-25 02:24:09
116bd2de-b6df-4265-a062-18ee18b4e777	fR2lfbXSUwiFSl5zBPyb	17	Hot Chocolate	Pastries	4	131.53	2025-05-01 05:59:32	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.torres2	2025-05-01 05:59:32
866d9bcb-f04b-44d5-9620-cbf4683204dc	HvHynB9aFX8WEP2yKzXO	25	Mocha	Pastries	2	61.74	2025-02-08 01:47:34	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	rosa.cruz13	2025-02-08 01:47:34
1b5d4412-ad49-46cd-8ea7-235d8fb60e9d	9OpZsahQByG24OjmPFrk	28	Chocolate Chip Muffin	Pastries	4	103.79	2025-11-20 20:36:00	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	fernando.cruz	2025-11-20 20:36:00
bb1002b2-bb19-4fac-87b6-a613ddbf8ffc	uf4YH6jemkQu3tPgrCxt	32	Blueberry Muffin	Pastries	5	185.15	2025-03-24 05:05:08	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	sofia.reyes9	2025-03-24 05:05:08
a841ab21-4dbb-4f72-b2a8-08d4561e80a4	rFE9N6XDkacN1dCpPdE9	36	Latte	Pastries	1	108.74	2025-03-03 23:54:22	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carmen.santos1	2025-03-03 23:54:22
764c21b5-6d44-4eef-b4b6-65d2ac546315	p6w46HF524uEXRb9ordW	40	Americano	Pastries	3	80.96	2025-05-21 21:17:16	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904135309	rosa.rivera7	2025-05-21 21:17:16
24860f18-a609-4c4a-ad41-0338bd75526a	CW91yORioDN1YErTnyxM	44	Flat White	Pastries	4	113.21	2025-01-01 02:21:57	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	sofia.bautista5	2025-01-01 02:21:57
f4cc1d2d-8752-4cd4-85be-3407218fa7e9	0pHs6q3PsKcQPKHtMiFI	48	Apple Turnover	Pastries	5	154.54	2024-12-27 09:06:23	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904531366	fernando.cruz	2024-12-27 09:06:23
93b7c204-3140-4b12-bf36-fa610caa9c10	HK68LMWq5Ehu4e0Gecty	54	Glazed Donut	Pastries	4	148.75	2025-06-20 05:18:05	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	ana.rivera3	2025-06-20 05:18:05
6a053003-f6d5-4d10-be7d-463f03871660	JYkOGeALp9cZeEhVxGOp	59	Red Velvet Cake	Pastries	5	187.25	2025-07-05 20:41:05	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	antonio.santos6	2025-07-05 20:41:05
66d2a0c7-dfc1-4983-a8f5-7d588b0df50c	AnAjJuYWzclT5XML0r5J	60	Americano	Pastries	2	80.96	2025-05-22 07:18:51	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	pedro.cruz14	2025-05-22 07:18:51
d4ef0dee-4258-4385-ada1-930a952ac8da	RZC683rFjTh9cFV56OiO	61	Cappuccino	Pastries	4	76.25	2025-02-04 22:41:40	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	ana.rivera3	2025-02-04 22:41:40
791c0a81-cb45-42cd-9347-9c8d6a0e8b02	AtfN5ppNE6KwVjhcfhoX	63	Tiramisu	Pastries	2	196.55	2025-08-17 22:37:22	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	carlos.mendoza	2025-08-17 22:37:22
45594fd9-8f78-45ef-b232-7e587fb3edbd	1jT72Qe2D5BeIPg2EH0u	64	Cappuccino	Pastries	2	76.25	2025-02-18 02:08:16	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904690784	fernando.santos8	2025-02-18 02:08:16
a9d6fa7e-2357-4143-b3c8-70baa779b4be	K0mY5mUxnY6kn8tIl3r0	69	Americano	Pastries	5	80.96	2024-12-03 03:35:56	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904558105	ana.rivera3	2024-12-03 03:35:56
f534dd41-1b32-4fd1-ab20-f7c2045b0635	yXOte1GYsW0F57wBjIVW	70	Chai Latte	Pastries	4	100.50	2025-02-02 00:16:19	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	sofia.reyes9	2025-02-02 00:16:19
c974c454-196f-4d76-9204-21000ac4f096	4WB7AYRbtlICnm4qUPjA	72	Eclair	Pastries	2	146.12	2025-06-29 11:36:55	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.santos6	2025-06-29 11:36:55
dbf5820d-248d-416f-966d-74fb49afe9ef	ePXnjfENNY7RR66qiLY7	79	Blueberry Muffin	Pastries	5	185.15	2024-12-08 01:24:01	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904231262	fernando.cruz	2024-12-08 01:24:01
6b60487a-bc6b-403e-acfe-acc34323a86b	RPKPUXmYIuhYmZprVxRX	80	Iced Mocha	Pastries	1	144.00	2025-03-09 15:09:52	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	fernando.cruz	2025-03-09 15:09:52
c9489046-5730-4947-8109-efb84d31aeec	pwroTHqKB7t010PV8df2	83	Mocha	Pastries	3	61.74	2025-02-14 19:53:55	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carlos.mendoza	2025-02-14 19:53:55
bfb4de5b-9df1-4128-80ba-6e74aec09d3b	Pl88ee4BPqJpRJhYLz8Y	87	Chai Latte	Pastries	5	100.50	2025-11-15 23:54:21	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	antonio.santos6	2025-11-15 23:54:21
271bb0de-af58-4103-aa3c-6a240f1cf056	\N	\N	Apple Turnover	Pastries	1	154.54	2025-11-24 23:41:04.48265	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	admin	2025-11-24 23:41:04.48265
d9a755b8-4310-48a6-9a57-60dc417fb8b1	h04JlBvuSqy4KWQmuFtU	89	Mocha	Pastries	5	61.74	2025-05-03 16:02:55	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	isabella.delacruz4	2025-05-03 16:02:55
16f91226-1b48-4a9d-81d8-8f0bcede5b1c	nVe6Mf6ZP5ymfR5XAOwP	90	Espresso	Pastries	1	195.76	2025-03-16 18:55:59	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904889221	gabriela.mendoza	2025-03-16 18:55:59
c97fcde1-3afc-496f-b5b1-619948e95a7d	IdHNxWCKRtcXy1bZxetP	96	Blueberry Muffin	Pastries	5	185.15	2025-07-29 11:38:17	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	gabriela.mendoza	2025-07-29 11:38:17
15a06c4a-c876-4064-a22d-000f307fc4a0	v50IaLEbeAcvIrL3KFPK	110	Eclair	Pastries	2	146.12	2025-10-13 14:04:15	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.santos6	2025-10-13 14:04:15
e11dda9d-f688-45be-8fdf-9631583fe2f7	nUwL8mvXc1RaHSjCzoXD	111	Almonds	Pastries	4	5.59	2025-10-12 18:40:04	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904186985	isabella.delacruz4	2025-10-12 18:40:04
78565f6b-843c-4d1c-9375-50883f85fbf1	dxsYKCUo5jRUMvVtCiGx	114	Apple Turnover	Pastries	5	154.54	2025-04-13 03:36:38	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	carlos.cruz12	2025-04-13 03:36:38
510124c7-e342-43d4-a120-bf0f3d12affd	doNGYa46Q3OnfLRspFQR	115	Apple Turnover	Pastries	1	154.54	2025-07-10 05:56:04	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	gabriela.mendoza	2025-07-10 05:56:04
0b1dbd89-861e-4fd9-980d-d2a476c9d39f	lG8IUC8szMy9VrdgFTm2	118	Tea	Beverages	4	106.18	2025-04-03 16:11:36	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carmen.santos1	2025-04-03 16:11:36
609bb9dc-26ce-42e1-b31d-18687f41ee9b	Ek3Jj9cLurDw3ZaDJlXq	121	Apple Turnover	Pastries	4	154.54	2024-12-20 06:23:35	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	sofia.reyes9	2024-12-20 06:23:35
e32f4139-7b11-4c36-845a-a932aa9da4f9	p61u8uxL49TLc7IohHHB	127	Cappuccino	Pastries	5	76.25	2025-02-08 20:20:27	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.cruz	2025-02-08 20:20:27
2a972080-f55e-461d-b82b-18a3115153c0	YtxIqJMy7QYeHyqjPBEn	128	Red Velvet Cake	Pastries	2	187.25	2025-08-12 16:23:12	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	fernando.cruz	2025-08-12 16:23:12
88384ba7-a099-487f-9c25-850ba2dbab42	HTUZ4qCIzARZqjx1dBRK	129	Apple Turnover	Pastries	5	154.54	2025-06-16 11:17:53	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	gabriela.mendoza	2025-06-16 11:17:53
20bdfa51-4b74-423b-968f-5fdce6ec2a0a	58WHOqJZ7RkQbYRvP7vH	130	Almonds	Pastries	4	5.59	2025-05-14 11:45:38	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904109079	sofia.reyes9	2025-05-14 11:45:38
ff0620bd-d6fa-44f1-846b-33522189b988	B98LNwnSge07y2UVxNDQ	132	Apple Turnover	Pastries	5	154.54	2025-05-11 10:42:21	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.santos6	2025-05-11 10:42:21
f8317278-0025-44fd-939f-27fa135281f7	LRw7b5YGYY1RF1rIkYJL	140	Espresso	Pastries	4	195.76	2025-02-14 17:22:21	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.cruz13	2025-02-14 17:22:21
0a7acf35-6647-453d-925c-e1457d9022c7	ZWFNb5f861S8Mw6jNsIJ	141	Flat White	Pastries	4	113.21	2025-11-07 16:10:07	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	pedro.cruz14	2025-11-07 16:10:07
aaf5040d-9d9b-4782-9cad-2e46df1fe3ca	bgPEM43wQOCuwnxaWX38	142	Baguette	Pastries	3	133.77	2025-01-27 11:39:09	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183904021599	carlos.delacruz	2025-01-27 11:39:09
0cadeefa-1753-48e6-aabe-f6128e1d71b0	GOtazcgEtywecKEmN2jr	144	Espresso	Pastries	4	195.76	2025-03-15 19:29:55	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.rivera7	2025-03-15 19:29:55
5bb41143-c0c6-42f1-9c8d-7c53c0b6ba75	tBnCn0Lv94bZqdwjcbhC	148	Almonds	Pastries	3	5.59	2025-04-18 08:36:08	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	antonio.santos6	2025-04-18 08:36:08
09dab475-c152-4e89-a40e-812e264da4e5	yCvOFl5k1DNc4kP9cr0c	149	Tea	Beverages	5	106.18	2025-04-05 14:06:22	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	sofia.bautista5	2025-04-05 14:06:22
8bc5b03c-230d-4324-90ca-91b620c70134	iatwQ3tTnzeFrWcxBOBP	151	Chocolate Chip Muffin	Pastries	3	103.79	2025-09-06 00:01:18	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.cruz12	2025-09-06 00:01:18
f5d9df04-e38f-41f5-9c33-9fdf374dc2d5	1NrtZicJ9SIcOdpViUhV	154	Blueberry Muffin	Pastries	1	185.15	2025-07-18 17:34:13	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	elena.fernandez11	2025-07-18 17:34:13
a16cee88-0a37-4e69-8683-a3a0d16e6d37	WfSUQJkDxRnVachyjhI9	156	Tiramisu	Pastries	4	196.55	2025-04-16 06:54:37	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904616993	elena.fernandez11	2025-04-16 06:54:37
bc8cd21a-9dc9-4e35-afbf-0678180ff868	mBNpSPJwaTHdERpzeOry	157	Baguette	Pastries	2	133.77	2025-06-17 18:31:03	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	ana.rivera3	2025-06-17 18:31:03
65b6785f-ac93-4c57-8d27-23c8b4da0765	2yFAAWfyNMH0EvNgJ7sS	160	Cappuccino	Pastries	2	76.25	2025-03-29 03:35:21	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.mendoza	2025-03-29 03:35:21
13df8fa2-b02a-406d-8351-842290af0aeb	Wx07iWd2hAorxZQTnXQK	164	Flat White	Pastries	2	113.21	2025-06-05 20:44:33	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.cruz12	2025-06-05 20:44:33
6243d1e5-b7dd-4702-84b8-30735c1a708f	dmuK4ptEztgppRFxUfMN	168	Flat White	Pastries	5	113.21	2025-05-17 04:11:31	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904219420	elena.torres2	2025-05-17 04:11:31
39e4664c-56fb-4c6b-bb0c-d63a92b9c293	kTRAemE7JADDqhtz1wp4	170	Chocolate Chip Muffin	Pastries	3	103.79	2025-03-05 16:46:16	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904740724	ana.rivera3	2025-03-05 16:46:16
e65783fc-a6ed-442c-bdf2-ea548f659e11	Zy6Ocl7Jl2ubS9ev1t2a	348	Iced Mocha	Pastries	2	144.00	2025-10-18 10:23:09	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	elena.fernandez11	2025-10-18 10:23:09
1b014636-4b6b-4c49-9ddb-742abbf1f205	cyc0CVUdHn4JetWaCDBX	175	Cappuccino	Pastries	5	76.25	2025-11-16 00:03:31	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904996736	elena.fernandez11	2025-11-16 00:03:31
b4339a8a-88e5-4af6-9228-4e677b1e44bb	YmVriDMr5zwej7ffD91U	179	Blueberry Muffin	Pastries	2	185.15	2025-07-04 03:24:39	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	admin	2025-07-04 03:24:39
5d301026-d2f5-44ca-a4d9-06bccc7407b3	RfGMkH4UV0xOB438D9LR	180	Almonds	Pastries	1	5.59	2025-11-14 23:04:56	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904056786	carlos.cruz12	2025-11-14 23:04:56
b105bd6e-49e9-4eb2-822c-8fe2e0b13c27	4ehFXBVgMNKR0clFM3AS	182	Almond Croissant	Pastries	1	8.42	2025-10-16 19:40:15	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904720492	carlos.cruz12	2025-10-16 19:40:15
94072999-5031-4727-ba81-d97fe9ad9be7	FATQeqYu5wT09eto4qog	185	Flat White	Pastries	4	113.21	2025-11-09 23:06:11	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904546529	gabriela.mendoza	2025-11-09 23:06:11
5eb9d0bd-0cce-4ff6-bd6e-7a51a03d1643	C0igOfpn4o5YudWUvRj0	187	Tea	Beverages	4	106.18	2025-09-14 06:29:51	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.fernandez11	2025-09-14 06:29:51
43221e4d-7733-4f92-afec-b69a2c8a8d30	PxdhDr5hlSR7b1YbbrVZ	189	Espresso	Pastries	4	195.76	2025-10-03 07:53:35	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	carlos.cruz12	2025-10-03 07:53:35
74c3c74c-d9ba-4b8d-a022-2555113f0f72	pdsrCtzpQ5LyuB4brS0y	191	Tiramisu	Pastries	5	196.55	2025-04-27 09:20:59	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.mendoza	2025-04-27 09:20:59
3bc33b5b-34c8-4c75-bee8-756155e28c74	ORbLloynR0kFqAUC5dKr	199	Flat White	Pastries	2	113.21	2025-06-20 20:14:01	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904244241	carlos.delacruz	2025-06-20 20:14:01
2c3d7a97-0271-41d8-81ff-1c091170928a	mtXFXPOlnqZq3QmJoAEE	201	Almonds	Pastries	4	5.59	2025-08-09 03:40:17	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	elena.torres2	2025-08-09 03:40:17
a1088cd2-ab36-4c3d-ad82-6d16f23c1b1f	5KLoadopQez292dJyfDD	206	Latte	Pastries	3	108.74	2024-12-01 03:38:11	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	elena.fernandez11	2024-12-01 03:38:11
7f4382c4-0b7e-4f60-b777-6514ce23a715	dcntEadf5WW3uKAlzAAk	207	Flat White	Pastries	3	113.21	2025-02-04 04:32:36	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.mendoza	2025-02-04 04:32:36
82721150-ed9d-4377-9229-b58ca2d57f5e	yfGXaiBf0UcBDd7oPUN2	208	Almond Croissant	Pastries	4	8.42	2025-11-19 07:52:05	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	gabriela.mendoza	2025-11-19 07:52:05
a552e39c-afa6-431e-af96-72aeca326586	4TGXHvz397n01dg2kQSM	210	Almond Croissant	Pastries	5	8.42	2024-12-17 22:41:21	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2024-12-17 22:41:21
d44c5f07-c37b-4003-908e-c3c6b9f8435e	eVMMfSq5oUAZ3JJVeKCe	211	Latte	Pastries	3	108.74	2025-02-16 20:30:15	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	elena.torres2	2025-02-16 20:30:15
f26db374-8318-4200-9206-76dc3e64e2d0	whyEpDBd81jRSb9bwTw2	216	Blueberry Muffin	Pastries	5	185.15	2025-03-08 07:34:57	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carmen.santos1	2025-03-08 07:34:57
149897df-6e3f-4966-a966-2263ee063da0	b4MRwzEv6dxEBkyp1CTJ	217	Red Velvet Cake	Pastries	2	187.25	2025-11-06 10:13:02	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.torres2	2025-11-06 10:13:02
8ffd369a-b479-4695-ad49-3eb4229c1b85	de103QG9UMIFffz45W8N	220	Iced Coffee	Beverages	2	107.80	2025-02-11 00:33:25	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904380948	elena.fernandez11	2025-02-11 00:33:25
240423d4-6e76-4303-8dfe-4974a2d07755	lDHb4WwAbg85q7xz6Hfe	222	Cappuccino	Pastries	2	76.25	2025-11-16 13:43:26	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.cruz13	2025-11-16 13:43:26
857fedd4-0335-44b7-9208-b71d4cda8958	721VmdSXObrF18kCZfSL	224	Latte	Pastries	1	108.74	2025-05-31 05:02:02	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.delacruz	2025-05-31 05:02:02
6d30a999-30ef-4e94-baed-a0428d3d59cb	qbaAVZEZGUpQliwmoOSz	226	Apple Turnover	Pastries	5	154.54	2025-03-16 15:03:25	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904672026	admin	2025-03-16 15:03:25
a6f6e094-8531-4af1-8714-aec676f6adc7	9YXwhNqMfQ7ZYLRZUMFm	227	Cappuccino	Pastries	2	76.25	2025-05-13 09:01:14	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.mendoza	2025-05-13 09:01:14
7fc9ba81-4b08-4158-aa0e-73d84b6d993a	8JdgXMDKYjpYQvylN3jP	228	Apple Turnover	Pastries	5	154.54	2025-04-18 19:26:24	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904255553	fernando.cruz	2025-04-18 19:26:24
b5890c14-baf8-4561-85d1-9118c3f96e09	F1IkjZRXTVVPkDuU2KBX	229	Blueberry Muffin	Pastries	4	185.15	2025-08-09 17:55:19	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904002526	elena.fernandez11	2025-08-09 17:55:19
1c8a7ec0-841a-4090-a5df-af84cd839722	l8JNTEQMdqxWnnROhfYR	230	Mocha	Pastries	5	61.74	2025-09-06 11:56:25	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904240706	carlos.mendoza	2025-09-06 11:56:25
663a0c5b-2f91-48f1-a2f1-6bf5928d8422	B5UaHyUoB3G1bi8oInEJ	231	Macchiato	Pastries	4	93.97	2024-12-15 14:49:07	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	isabella.delacruz4	2024-12-15 14:49:07
d9a8ae1f-dea5-470e-932f-82cd3008f05f	Pics6Uywaoj7bJ1Luk7o	232	Iced Coffee	Beverages	5	107.80	2025-07-01 22:13:50	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	admin	2025-07-01 22:13:50
96553172-2abc-44dd-9924-4e957d79fbb6	B0Z4BQBgBTLXeGNWf7pv	234	Iced Mocha	Pastries	1	144.00	2025-04-13 20:38:11	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2025-04-13 20:38:11
e846e8df-39de-40c6-a115-0d268b5339f4	5qNrzaV1edY1hE1gnI0k	240	Red Velvet Cake	Pastries	3	187.25	2025-02-09 10:47:25	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.mendoza	2025-02-09 10:47:25
f7ee2fbc-f446-4068-b395-5029166cba5d	aX2vbgCacCz9kwlGLdV8	244	Apple Turnover	Pastries	1	154.54	2025-11-10 12:52:07	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	admin	2025-11-10 12:52:07
f09e3dae-452d-4366-9975-0461b7373658	weBm0LvF2TQxnUR8VR12	246	Americano	Pastries	1	80.96	2025-08-09 07:45:32	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carmen.santos1	2025-08-09 07:45:32
d92f3cff-e21b-4234-be66-07fb460b5299	ObybBKG2sEyI0LE9kymn	252	Mocha	Pastries	5	61.74	2025-05-16 00:15:58	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	gabriela.mendoza	2025-05-16 00:15:58
d1f31160-567a-4def-a718-7b7d6611db85	ZnoL0boqFZDcPud63Rvx	254	Mocha	Pastries	4	61.74	2025-05-28 20:37:56	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	miguel.cruz15	2025-05-28 20:37:56
764ba6f4-b6cc-40dd-8468-4ac62dbd2308	KBJN3lzWD11RZab6dppZ	256	Cappuccino	Pastries	3	76.25	2025-04-04 10:53:12	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	carlos.mendoza	2025-04-04 10:53:12
3f4fa683-0927-4008-8b13-5adfd96ce372	SlCBywbk3To0qjfUjcFa	257	Almonds	Pastries	2	5.59	2025-03-21 09:32:53	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904721084	gabriela.mendoza	2025-03-21 09:32:53
a8c3b7a2-451c-4d70-bd92-64508666713c	ZttzgvPGWHf1xkQPj0eD	266	Macchiato	Pastries	1	93.97	2025-09-21 17:03:49	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.santos6	2025-09-21 17:03:49
c5feadb1-354e-4fe0-8fb0-41b295036de8	cBvciHgKmxFM3AEIox6R	268	Cappuccino	Pastries	4	76.25	2025-03-28 08:58:35	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904879572	sofia.reyes9	2025-03-28 08:58:35
9b5b800d-a58f-4694-807c-df5e83a8bf49	UkjojVjSV1nd2SDxxz5c	270	Iced Mocha	Pastries	2	144.00	2025-09-30 00:51:59	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904487893	rosa.rivera7	2025-09-30 00:51:59
c9f89714-d3f6-470d-be8d-a95b05d3bb7b	juqKBuBSc3rAC9ucH9v4	271	Red Velvet Cake	Pastries	3	187.25	2025-11-21 00:00:57	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904559265	antonio.delacruz10	2025-11-21 00:00:57
e523bdad-eef4-4cb3-bd86-1fedb0fda36b	39yo5TgrpthQZjNAPiuy	272	Iced Coffee	Beverages	1	107.80	2025-04-12 17:20:13	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	rosa.rivera7	2025-04-12 17:20:13
140d08a2-38c8-4899-95a4-e728f2235a3e	rI3ksjEM9adbDLLzpyUU	275	Hot Chocolate	Pastries	4	131.53	2025-11-13 04:32:13	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	rosa.cruz13	2025-11-13 04:32:13
39384519-e4ec-4874-8b99-0a031b8c2dc2	HuIoDhM3sojs4yMPqmWv	276	Iced Coffee	Beverages	3	107.80	2025-03-07 14:15:29	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	admin	2025-03-07 14:15:29
260bb271-5535-4f8f-b98e-8c4e0b964250	9Zg84GbUv33bCcJlH6Dh	277	Tiramisu	Pastries	1	196.55	2025-08-01 05:43:21	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904580307	antonio.santos6	2025-08-01 05:43:21
3ca009d1-1d08-4b11-8fd7-7c00f5126f1b	mYNnGpXjPxXiNgnsLP3T	278	Eclair	Pastries	3	146.12	2024-12-14 08:59:37	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904492686	elena.fernandez11	2024-12-14 08:59:37
06fc4e89-914f-4bd7-a5ef-764fbf9faa57	XMjPhsP4PpIDDQsT6czk	282	Blueberry Muffin	Pastries	2	185.15	2025-05-23 15:40:31	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904063066	ana.rivera3	2025-05-23 15:40:31
803b46a0-30b8-4e1a-a751-c3b25d3861e7	Gcsqt5xIGJN5pfNFRejZ	284	Tea	Beverages	5	106.18	2025-03-02 09:11:30	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904306419	carlos.mendoza	2025-03-02 09:11:30
409f6af9-2665-4854-ac06-5bc6bd311fad	NgpBEoCasbvdQInfDzFL	286	Almonds	Pastries	4	5.59	2025-01-26 14:37:54	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	antonio.santos6	2025-01-26 14:37:54
dbfb85bd-f6ad-4788-bee6-c9958714af95	JwQbyOMY5pDEQPLWvm3U	290	Espresso	Pastries	5	195.76	2025-09-21 04:02:32	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904047744	elena.torres2	2025-09-21 04:02:32
32899761-b609-4e7d-91ca-18fdd4e5dcbd	Jo65mguv2qUH6asNo8Wf	296	Glazed Donut	Pastries	4	148.75	2025-09-18 19:58:58	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	pedro.cruz14	2025-09-18 19:58:58
147baff3-5b10-480e-80ca-38c45c0b3f1f	aJYz2sqoX8VJtWD0zu0V	297	Hot Chocolate	Pastries	1	131.53	2025-06-27 11:12:15	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	rosa.cruz13	2025-06-27 11:12:15
86576ac4-56fe-4536-b615-90ac9bc905c3	loKjcQXrsT2G1cBlMWry	298	Macchiato	Pastries	5	93.97	2025-01-09 03:12:54	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	sofia.bautista5	2025-01-09 03:12:54
f9990cf7-66f2-4cad-a622-84f12177ff0f	RIOXBAuHNff6hlEA0Al8	299	Latte	Pastries	4	108.74	2025-04-22 11:41:16	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	elena.fernandez11	2025-04-22 11:41:16
02fcfe1a-b0fe-46e4-9866-04a3d455f01a	cBZrlbE0e3LmAMhra6H9	303	Iced Coffee	Beverages	4	107.80	2025-05-21 16:27:45	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carmen.santos1	2025-05-21 16:27:45
ec25a92d-17c3-4e46-bede-51cde1aa7242	lJxKEfpov1aK1O3EFoQO	308	Eclair	Pastries	1	146.12	2025-09-19 06:13:09	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904588541	elena.fernandez11	2025-09-19 06:13:09
ba3a7a35-dee6-40f6-96e0-481b808baa9f	guFcS9lUeLejq8wzogoR	310	Apple Turnover	Pastries	4	154.54	2025-05-13 21:26:54	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.fernandez11	2025-05-13 21:26:54
4502c748-8a00-46e8-963f-3af6740c450a	tOpxevz7LIw41JSLOv9B	312	Almonds	Pastries	2	5.59	2025-04-22 20:38:38	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.delacruz	2025-04-22 20:38:38
b7434658-a94e-45f5-b18c-84c56a6ef9e6	p9WDtbUVFF8FvkObGqeM	313	Americano	Pastries	2	80.96	2025-11-09 06:20:09	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carlos.mendoza	2025-11-09 06:20:09
c2923f6a-0546-4d7d-8272-ef9929a671f7	SAo2MIKatqJ0hINwkKTp	318	Iced Mocha	Pastries	2	144.00	2025-06-28 22:33:29	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	carmen.santos1	2025-06-28 22:33:29
beeb08f9-7ef2-451c-a2df-ebd949715a22	TQyrpuqoMuTMZc8H2ufB	319	Espresso	Pastries	3	195.76	2025-08-14 19:07:41	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	sofia.reyes9	2025-08-14 19:07:41
bf36f9e0-3381-49de-acc8-0ce8805d94d4	zSCfzV8pPBfbfspWr4pc	322	Almond Croissant	Pastries	1	8.42	2025-05-17 15:43:08	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904905374	gabriela.mendoza	2025-05-17 15:43:08
40c51fd0-b9ad-48b6-bef9-5228e46907f6	bGJBfYHYhw9mXlXFlsDF	326	Mocha	Pastries	2	61.74	2025-03-08 14:13:13	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	rosa.rivera7	2025-03-08 14:13:13
97ea9c43-e5f7-4482-a3d1-ce2e067cf556	gx2CPQxxbzw3sgbKq9p4	328	Chocolate Chip Muffin	Pastries	1	103.79	2025-06-05 21:53:10	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	elena.torres2	2025-06-05 21:53:10
e0cb1e51-7088-49ee-bfbf-6e6af8d167a1	FIgVamGUzFDQcySlWEPB	336	Hot Chocolate	Pastries	2	131.53	2025-05-02 22:36:24	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	elena.torres2	2025-05-02 22:36:24
00851721-9424-451e-aea6-b723ec2789de	2tTXgLnZYOz3E7GM2WHS	338	Mocha	Pastries	5	61.74	2025-10-22 06:53:52	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904795136	isabella.delacruz4	2025-10-22 06:53:52
9fca8528-5ade-4e0a-8a6e-952842b59f1e	p8LqfUoeY1viChAWkbnV	341	Hot Chocolate	Pastries	2	131.53	2025-10-18 04:49:17	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	isabella.delacruz4	2025-10-18 04:49:17
8c03f74b-069b-4f3e-99fd-c0d1ea9ad9ba	y30GTcXv9gNTNXmE5bXM	344	Cappuccino	Pastries	1	76.25	2025-02-11 01:25:44	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.delacruz10	2025-02-11 01:25:44
fbea7eec-c581-43f7-92de-f1ad35e39419	9NBw3XbjXHfcj1Udx4aW	354	Chai Latte	Pastries	5	100.50	2025-05-14 13:33:54	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904066951	rosa.cruz13	2025-05-14 13:33:54
1a604882-5070-441f-91df-74b33aca178a	45weplpwBKKsoidIjhkx	358	Flat White	Pastries	4	113.21	2025-01-26 02:07:05	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.torres2	2025-01-26 02:07:05
296f8c8c-f715-49b4-b5cc-1c8cbacd8c71	hmK6uXmcP2TDWVDVGnM8	364	Cappuccino	Pastries	2	76.25	2025-08-17 00:06:01	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904714498	sofia.bautista5	2025-08-17 00:06:01
d007bd2b-583a-4231-96db-94ac926957a6	Y06fS3alb20LHxTtRTGZ	372	Americano	Pastries	5	80.96	2025-02-04 22:53:17	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904149338	elena.fernandez11	2025-02-04 22:53:17
1490e276-85ab-4891-85c8-426550157376	lfVcAhcEqiPlNz3oozJ5	373	Eclair	Pastries	5	146.12	2025-02-23 08:20:54	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904497028	ana.rivera3	2025-02-23 08:20:54
5efa738d-5052-45ee-8ead-0b05bdf99318	7iAazpjPVxtQbbfC4ATq	375	Apple Turnover	Pastries	3	154.54	2024-12-20 10:27:13	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904254185	gabriela.mendoza	2024-12-20 10:27:13
a421e24b-5377-4cb9-8466-2913797b1bb9	EOCfhU93GtjXIKuHrS0s	379	Glazed Donut	Pastries	4	148.75	2025-06-24 13:59:26	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carmen.santos1	2025-06-24 13:59:26
2960b134-c487-4b79-9472-73f71f588936	1jnghIVCHzf3HlRBCL3q	380	Iced Coffee	Beverages	4	107.80	2025-02-12 21:18:47	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.santos6	2025-02-12 21:18:47
80bb4b04-a89f-4c2b-bbc7-b9e772e910be	e473UZ0l6MgQYBjrS0pc	386	Almond Croissant	Pastries	2	8.42	2025-03-30 17:11:01	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2025-03-30 17:11:01
09ab5d65-4ab6-44f2-915a-eea42c94aef8	jj1ByNmr8PVoycrir7kr	388	Glazed Donut	Pastries	3	148.75	2025-09-07 09:45:34	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904493764	fernando.cruz	2025-09-07 09:45:34
a016c60f-1d25-4f6c-8a54-1ff60dacf8c5	fO8Mh14QJKwTPvNjhsBU	389	Tea	Beverages	2	106.18	2025-07-06 06:02:53	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904832531	pedro.cruz14	2025-07-06 06:02:53
e9165149-df94-459a-8f46-7a07ba383166	IqNECBG3wlSUk9itDlpH	391	Iced Mocha	Pastries	4	144.00	2025-07-18 04:39:45	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	pedro.cruz14	2025-07-18 04:39:45
07ee8453-0e4a-44b9-a3b7-1fc0a590286d	wrxkb5hAz7ifeYjjdIdT	395	Cappuccino	Pastries	3	76.25	2024-12-22 00:27:44	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904022950	pedro.cruz14	2024-12-22 00:27:44
70f19838-7d38-452f-acbc-da2d7ebee459	xBlDUuHpQlIRwwyBqGBv	396	Red Velvet Cake	Pastries	1	187.25	2025-10-17 06:20:59	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904433957	carlos.mendoza	2025-10-17 06:20:59
bd47e942-955d-48fe-8bd0-596990671bc7	Vtf0LNbMbKT5PPlc195f	398	Almond Croissant	Pastries	3	8.42	2025-08-30 14:48:25	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	sofia.bautista5	2025-08-30 14:48:25
9f940d33-45f9-4174-b058-e41a211c1fac	DFBbxHBzyfuomI3GbqTL	407	Tea	Beverages	2	106.18	2025-10-17 08:26:39	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	fernando.santos8	2025-10-17 08:26:39
dcaeba17-4ef6-4f18-b3a7-ca4e09a100ef	rguJNpcVIvUU5jQI0rwj	408	Iced Mocha	Pastries	5	144.00	2025-01-17 15:50:42	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	carlos.mendoza	2025-01-17 15:50:42
fccd8dce-5287-4339-abfc-e72069df888a	JeO45Ivz9EPvSR4PFi8l	410	Cappuccino	Pastries	4	76.25	2025-06-09 00:11:20	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904518188	ana.rivera3	2025-06-09 00:11:20
17f2dc54-c2b9-47f4-bddc-c957d75d6850	ZFFvSgYjGc7cz0wWuY9T	412	Almonds	Pastries	2	5.59	2025-03-06 13:15:06	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.bautista5	2025-03-06 13:15:06
793f18e5-9bc0-4837-9e30-d6d26ea8f26a	P3Nih2mffBmEx9Ddei8s	414	Flat White	Pastries	5	113.21	2025-02-12 04:24:05	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904108825	admin	2025-02-12 04:24:05
2c586035-d8cf-4bf0-8a94-5bf1cc6b0758	6Q95ILiSeANudleGaHFH	415	Almond Croissant	Pastries	2	8.42	2024-12-12 16:08:54	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.delacruz10	2024-12-12 16:08:54
e1b443ef-0faf-4b5e-baa9-89cddf935705	4FSnoxKfxBpfXOrDYVRB	418	Eclair	Pastries	5	146.12	2025-08-12 06:32:47	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904023977	elena.fernandez11	2025-08-12 06:32:47
e83d1af7-e305-4b42-ab2c-aa35e2952266	pnUow0dXP5RlKqXnqxtY	430	Espresso	Pastries	4	195.76	2025-09-26 15:09:20	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	sofia.bautista5	2025-09-26 15:09:20
c17625fc-c899-46b8-99af-24052c3eea3e	LMdEa3KWZbcItDdoOdkP	431	Almond Croissant	Pastries	4	8.42	2025-03-29 06:40:22	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	ana.rivera3	2025-03-29 06:40:22
d197c0b8-aea4-46fd-a0b6-a4eab1866400	\N	\N	Almonds	Pastries	1	5.59	2025-11-24 23:49:31.060219	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2025-11-24 23:49:31.060219
cd5eedbc-24b7-4211-923e-8076af139c22	hScpFg01eMBNggRS13ud	436	Red Velvet Cake	Pastries	5	187.25	2025-03-22 12:25:44	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	admin	2025-03-22 12:25:44
3b412003-1c47-480c-bea3-508d12ce4b24	ZZNCrbxcryawB2YzExFG	447	Latte	Pastries	4	108.74	2025-07-24 18:10:00	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	ana.rivera3	2025-07-24 18:10:00
689a0599-e362-4441-b3b4-75d8920495b3	KzUMZYOXl2lA7YmkhJoW	448	Iced Coffee	Beverages	3	107.80	2025-07-06 00:32:00	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.mendoza	2025-07-06 00:32:00
7e7b4188-eb1f-4e4c-b036-00df32944199	Jvo74OXNcg58xB6HSUyw	452	Chocolate Chip Muffin	Pastries	2	103.79	2025-07-19 09:06:31	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	gabriela.mendoza	2025-07-19 09:06:31
fa22b9e3-84cd-4527-917a-d2e9612472da	FtFPtxS05lNBVgdaphfb	453	Tea	Beverages	4	106.18	2025-03-23 04:07:30	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carmen.santos1	2025-03-23 04:07:30
c07b33dd-584c-44ff-950a-8af14a312555	PqXF4tqwFdggj4HkuISc	454	Macchiato	Pastries	1	93.97	2025-07-17 02:18:54	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	pedro.cruz14	2025-07-17 02:18:54
320d059f-ee76-401a-bbd0-37c410c269a4	RjnZQbgVDmlvnA3pCBvS	457	Iced Coffee	Beverages	3	107.80	2025-06-10 06:45:10	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.delacruz	2025-06-10 06:45:10
88adb6ea-ee2c-44f8-a15a-a3aea5ff4e0c	KoyHErHvyWRMjNMzXxuD	461	Almond Croissant	Pastries	3	8.42	2025-02-28 23:56:42	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	elena.fernandez11	2025-02-28 23:56:42
de052503-6261-4f27-b32b-57b63fe21d07	gksTASkE4zckeV1Dgc8R	462	Chai Latte	Pastries	3	100.50	2025-10-01 06:31:04	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904159169	miguel.cruz15	2025-10-01 06:31:04
88689f9e-a3a6-4e21-a710-eaeee8f926a2	mgezqEMC4PQdYkLin2v6	471	Apple Turnover	Pastries	4	154.54	2025-08-03 10:56:33	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	rosa.rivera7	2025-08-03 10:56:33
f0e00fc5-74e4-49be-8de2-97780b7b5cb4	vbgfmJncvufsrqPDuJR7	474	Tiramisu	Pastries	2	196.55	2025-08-14 09:44:09	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carmen.santos1	2025-08-14 09:44:09
7009e8b8-4832-4001-b22c-56ad99970b8c	U34p3HH39KBMiKCqgR98	477	Espresso	Pastries	2	195.76	2025-09-23 12:05:56	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	miguel.cruz15	2025-09-23 12:05:56
1c961249-969c-41d0-8448-e2128bce2976	w5Ejo8z7duYhVqqshX1b	480	Hot Chocolate	Pastries	3	131.53	2025-09-29 15:52:42	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.fernandez11	2025-09-29 15:52:42
69c6fdde-fcf6-47d0-a551-e9cb99b765e1	7CpwW5cbAclYSVZpHnDW	482	Iced Mocha	Pastries	5	144.00	2025-04-29 08:09:06	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2025-04-29 08:09:06
28af0ed8-39be-48ce-84b6-b9d62cd0f0e1	FIi6DLsOPURNlPZb6k7T	491	Hot Chocolate	Pastries	3	131.53	2025-01-28 04:44:59	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.fernandez11	2025-01-28 04:44:59
dc6065cb-b20b-469a-97fd-6fde2d27755f	TbQ7l3dZKl5p20N5kvOx	493	Macchiato	Pastries	3	93.97	2025-11-10 02:24:45	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	admin	2025-11-10 02:24:45
dcb01974-3ac1-4c3b-945f-e53466453d60	Pthp4vcPF3k8OY41L4no	494	Eclair	Pastries	1	146.12	2025-04-05 00:24:11	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	carlos.cruz12	2025-04-05 00:24:11
6e5da3cc-cb17-4666-8d21-e1d69c11f376	vFKQmdk7g7f9nb3r6yKe	496	Eclair	Pastries	2	146.12	2024-12-12 23:14:30	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	rosa.cruz13	2024-12-12 23:14:30
b8f741a3-b75d-4e0b-b846-3f2b40545861	aF0x71A6UzJay63xa04V	497	Eclair	Pastries	3	146.12	2025-02-10 14:04:01	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904149084	carmen.santos1	2025-02-10 14:04:01
599c2b74-f04a-4401-bcec-d8cdf6a2a74c	XKn4vX7a2ZAH3iMzv2sr	498	Blueberry Muffin	Pastries	4	185.15	2025-02-12 09:44:03	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.santos8	2025-02-12 09:44:03
646cb2a2-b738-4a12-a231-0942c75b06c3	rLMSq51KKxD5zIvc0Qhy	508	Eclair	Pastries	5	146.12	2025-10-01 06:53:19	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904966365	elena.fernandez11	2025-10-01 06:53:19
005b4ccb-b31d-474e-892f-1fb761125199	n33R2MyyXPgV1aZjq6CK	512	Flat White	Pastries	3	113.21	2025-01-08 06:48:14	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.fernandez11	2025-01-08 06:48:14
9a05d83b-0f8e-4048-b193-83b9de7e64e7	GPzYMhQwp5xdLKMi8kGa	516	Tea	Beverages	3	106.18	2025-07-31 10:54:27	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	gabriela.mendoza	2025-07-31 10:54:27
35b6a616-f4d1-45e8-9b56-f33a5e981f63	\N	\N	Almond Croissant	Pastries	1	8.42	2025-11-25 03:24:10.875913	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2025-11-25 03:24:10.875913
84e64d81-b1e9-45ba-a1fd-d9422f9418a2	0W8LRd8aQ8xOr91cunrT	523	Apple Turnover	Pastries	4	154.54	2025-11-21 12:38:05	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	miguel.cruz15	2025-11-21 12:38:05
46400818-1af3-47c0-b18e-8acf4f18857a	Ts6zzydqVT2dvWZokNnY	524	Almond Croissant	Pastries	5	8.42	2025-10-21 16:41:12	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2025-10-21 16:41:12
1e535ef7-6159-49e7-b611-6f9561cf79c6	ACP41TaC0uO8PC5QFLvw	526	Eclair	Pastries	2	146.12	2025-03-13 22:03:16	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	sofia.bautista5	2025-03-13 22:03:16
7e24f559-3f82-4d7c-b7a6-7fdf69ce0e7e	FWWkgTEzjCfCvAnbusI9	529	Blueberry Muffin	Pastries	2	185.15	2025-03-07 05:00:24	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904645739	fernando.cruz	2025-03-07 05:00:24
340106b6-8ee8-417d-8ddb-7515f55c193f	f8nOMVUYjQ1gYsMmkzAZ	532	Iced Mocha	Pastries	3	144.00	2025-04-12 14:48:09	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	elena.fernandez11	2025-04-12 14:48:09
855d1bb8-add4-47f9-8fd6-873de175b987	Jg1KN25IIbOJ1hOWPZnw	533	Apple Turnover	Pastries	2	154.54	2025-11-19 05:46:36	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	fernando.santos8	2025-11-19 05:46:36
3d416f89-6a04-45fa-a038-ab7cc3541c3f	UCczYFsjAymWamZd7Slc	536	Apple Turnover	Pastries	2	154.54	2025-08-13 05:25:29	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	gabriela.mendoza	2025-08-13 05:25:29
0dffce30-92a1-43c5-ba9f-1680740ed9f9	2oeyKkSWU8ToZ3hbuVnA	540	Americano	Pastries	2	80.96	2025-11-19 16:14:22	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904797220	admin	2025-11-19 16:14:22
eaf351d1-5d10-4bad-b73f-0dec08efa9f2	0MXkBwId0dguyPw2bEtk	542	Chai Latte	Pastries	5	100.50	2025-10-10 05:26:14	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904916392	elena.torres2	2025-10-10 05:26:14
7455a340-43b5-483e-a774-caaa5454e404	oLIRzVyLoFwiNJPjiZ6i	545	Glazed Donut	Pastries	1	148.75	2025-11-18 03:31:28	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904243421	rosa.cruz13	2025-11-18 03:31:28
78a2b158-1320-4f81-8f23-4d96fc4a15af	MAP19wMt4oirQ1it0m6I	548	Chai Latte	Pastries	2	100.50	2025-08-21 05:19:32	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	fernando.cruz	2025-08-21 05:19:32
aaf73f43-ff27-4cff-997c-bb8bb94fa060	rbynY5HAXMN4Q3NYrIRN	552	Chai Latte	Pastries	1	100.50	2025-09-29 21:06:03	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	admin	2025-09-29 21:06:03
1eb6f830-6263-4069-80be-1190c78873a7	ZTh8JyCbk7KFJvb5dNvL	554	Apple Turnover	Pastries	2	154.54	2025-04-08 14:14:38	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carlos.delacruz	2025-04-08 14:14:38
afccdb18-1992-4664-9efe-ea0167e529a3	bEHm3rijnJG5oczAk9E2	555	Glazed Donut	Pastries	4	148.75	2024-11-30 10:37:08	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904361831	elena.fernandez11	2024-11-30 10:37:08
4b1bfb85-bbc0-486d-a0cb-89b7a48ad80e	wZOt5pk4QepoWAURyrQr	557	Red Velvet Cake	Pastries	5	187.25	2025-05-04 14:06:24	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	gabriela.mendoza	2025-05-04 14:06:24
bd5331a4-d25d-482b-9339-c4754592c9b1	CnuJCGfMN9QjYVJd3dTq	561	Chocolate Chip Muffin	Pastries	2	103.79	2025-07-03 23:32:26	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904520474	antonio.santos6	2025-07-03 23:32:26
a3d98258-7d06-44e9-86f1-4a38a3d3215e	xdd6YMneki12zgeXjnLa	562	Glazed Donut	Pastries	2	148.75	2025-01-09 18:47:14	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	carlos.mendoza	2025-01-09 18:47:14
4ef01cea-de77-4440-af8b-db89abadbebc	iC3TIoVmFyV0aujuXSvc	565	Flat White	Pastries	4	113.21	2025-08-03 14:26:41	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	isabella.delacruz4	2025-08-03 14:26:41
1df4fa08-37e1-437f-93e3-6c0564482392	\N	\N	Almond Croissant	Pastries	1	8.42	2025-11-25 03:40:45.392503	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2025-11-25 03:40:45.392503
ef84b3db-8e66-4edd-9241-e1b16576b1e6	xhn15w9wQPgSqnBrMYuq	566	Almond Croissant	Pastries	3	8.42	2025-11-01 15:56:55	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	gabriela.mendoza	2025-11-01 15:56:55
a90b8dbb-d61b-4b26-9c51-4ba9f75b92b9	eC4xvMHYkJuCIBSeURqq	567	Iced Mocha	Pastries	5	144.00	2025-03-31 00:38:14	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.cruz12	2025-03-31 00:38:14
d938e082-52d6-47e3-8f19-961685c5587a	sgeLi3T93wOd1vyHIO2E	569	Hot Chocolate	Pastries	5	131.53	2025-09-12 16:33:59	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	rosa.cruz13	2025-09-12 16:33:59
69f4a255-1ddf-4286-ada0-d13f50092e5e	0GjeYjSycijNi9uqqo9B	572	Iced Coffee	Beverages	5	107.80	2025-09-21 13:11:37	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.mendoza	2025-09-21 13:11:37
2843b74d-dbd6-4b4e-9373-472a48c99321	pL28N4ufNzkn8YPCaUOi	573	Cappuccino	Pastries	2	76.25	2025-09-22 10:27:51	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904961323	carlos.cruz12	2025-09-22 10:27:51
06c1b2fb-59b5-4f50-8af9-d31813247b96	ihLztscQVYBw55V15p9Z	575	Flat White	Pastries	5	113.21	2025-09-05 23:05:48	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904284692	elena.fernandez11	2025-09-05 23:05:48
41ee99d2-8f5d-4eb9-b876-a9d7cd9fec17	snVhJ3dfrs7QGVnZ8Sfi	582	Iced Mocha	Pastries	1	144.00	2025-07-27 17:00:57	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904385430	carmen.santos1	2025-07-27 17:00:57
27676907-21cd-4d95-b434-f78c06850aad	MV5FIX9mpRGBBmFDgD5L	583	Hot Chocolate	Pastries	5	131.53	2025-01-06 00:12:10	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	admin	2025-01-06 00:12:10
e398b617-0fce-460c-8694-505755154b65	pqPiXlO6m3esqcp6JUri	585	Chocolate Chip Muffin	Pastries	3	103.79	2025-07-18 21:29:36	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	admin	2025-07-18 21:29:36
64a794e0-01cc-4ed8-a2df-e45ffbfcdbdf	OCAxnuiJegmpBlOGQxvS	588	Mocha	Pastries	5	61.74	2025-01-02 20:13:22	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.santos8	2025-01-02 20:13:22
5cd5e48c-fd2d-45b5-807e-4a792640e054	6h4Ac5ua5HuDEpidYuWA	589	Cappuccino	Pastries	4	76.25	2025-01-30 09:09:58	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.santos8	2025-01-30 09:09:58
d94087f0-a874-4fdb-97a2-9dd0fcbb48c2	diWyMatZBk7frgf9yEJ7	590	Iced Coffee	Beverages	3	107.80	2025-02-06 21:46:39	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904946026	sofia.bautista5	2025-02-06 21:46:39
ebe10725-4676-475d-96a5-b446889256d5	fSIKFei5Zd5sEe6RIdeP	601	Tiramisu	Pastries	1	196.55	2025-01-21 21:00:58	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904582242	rosa.rivera7	2025-01-21 21:00:58
c7547185-dba4-44c2-b3f3-25ed7e4b8c1f	xH2orNc3XMfQxm7ABEXl	602	Blueberry Muffin	Pastries	1	185.15	2025-05-24 14:17:47	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.cruz12	2025-05-24 14:17:47
01390255-7835-4488-bec9-0be9c1a76018	D9m5EKYRuc0GbBD29Bfy	604	Almond Croissant	Pastries	4	8.42	2025-07-10 18:20:46	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	miguel.cruz15	2025-07-10 18:20:46
da184260-5d6e-4b13-bc27-c76d1fd9f410	oU0ifw01cgtPhsQT5C6K	608	Red Velvet Cake	Pastries	3	187.25	2025-03-02 15:30:36	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	gabriela.mendoza	2025-03-02 15:30:36
38be08cf-b618-463b-8be6-3ef63da9e641	WQ7AJOioFm4UTzHO8Htz	612	Glazed Donut	Pastries	3	148.75	2025-03-27 07:42:18	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.delacruz	2025-03-27 07:42:18
d8753d73-93fd-42f1-8608-82fad56f4d4e	onhvA4FqzCXnSJmujI40	613	Hot Chocolate	Pastries	4	131.53	2025-11-17 14:43:08	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	rosa.rivera7	2025-11-17 14:43:08
c0901c40-15a2-45bd-817c-c8ffff276ba9	mZ4ypv2KmvW2CKg37P7F	617	Latte	Pastries	3	108.74	2024-12-23 23:43:42	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	sofia.bautista5	2024-12-23 23:43:42
ecffa442-df7b-4780-80c5-80a5ddfbff35	5MxMofiMLKMlYzu6xSst	622	Eclair	Pastries	2	146.12	2025-10-04 10:32:43	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904636855	carlos.mendoza	2025-10-04 10:32:43
85b71397-8f6d-4751-8c8d-8e82a4098652	jMZy5UhyVfUBiTGeegjy	623	Macchiato	Pastries	2	93.97	2025-02-24 00:51:07	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904530486	isabella.delacruz4	2025-02-24 00:51:07
675766e2-6642-41cd-bdae-7d6250e432b9	84RJILIEaiY8mD4Oa5OP	628	Macchiato	Pastries	1	93.97	2025-10-06 13:12:26	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	fernando.cruz	2025-10-06 13:12:26
75f89f51-af27-4416-9e9a-9c0879fee8fc	jGBIc949hwN2FEk5lOTS	632	Mocha	Pastries	4	61.74	2025-02-18 14:31:08	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	elena.fernandez11	2025-02-18 14:31:08
1b827e6a-159d-4ef6-90b0-adf46e7600fd	NJxYq68fMTWM5v6iiZQr	633	Americano	Pastries	4	80.96	2025-01-24 06:41:31	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904634164	fernando.santos8	2025-01-24 06:41:31
4ebc0686-bc4a-4596-8a6c-7cfae9999f3b	u32lut8ZPmtDW9B3DrBK	637	Tea	Beverages	1	106.18	2024-11-27 04:54:14	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	antonio.santos6	2024-11-27 04:54:14
4c629306-0df5-4b25-8af3-343868672ff9	ajVzpbZMcItHdOreD7h4	638	Glazed Donut	Pastries	5	148.75	2025-06-15 17:20:43	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904832737	carlos.mendoza	2025-06-15 17:20:43
96b36ff1-8ba9-44c0-96e2-573503041f97	116oXVSLYhEfUeNRAegA	640	Espresso	Pastries	1	195.76	2025-08-12 18:08:24	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.santos6	2025-08-12 18:08:24
7f759a1a-5295-496d-ae16-6e7ef1d917c9	PgmSivKwniRrxFthlfBg	641	Blueberry Muffin	Pastries	2	185.15	2025-04-08 19:11:03	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904641379	fernando.cruz	2025-04-08 19:11:03
d0c8bffb-25ee-4088-b65b-1bbbd26692f8	HaNFLzT1Oaw9qhu2gr7m	642	Tiramisu	Pastries	1	196.55	2025-09-22 11:19:18	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	ana.rivera3	2025-09-22 11:19:18
993c5969-b17f-4db4-8d94-7ad5cbf25dc4	joRrmhfzmZ8WefgZtGFY	643	Chocolate Chip Muffin	Pastries	1	103.79	2025-09-28 22:11:34	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	isabella.delacruz4	2025-09-28 22:11:34
b0663b9d-bfd0-487c-9794-241d72283596	Dg604Ty98UKh1F89akrX	645	Glazed Donut	Pastries	3	148.75	2025-08-26 02:21:50	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.delacruz	2025-08-26 02:21:50
bb23cdd8-8f66-498b-a4bb-83fc48eb95a1	DGXNQJs1p3qPlUU2CcLh	648	Mocha	Pastries	4	61.74	2025-01-27 06:51:09	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carmen.santos1	2025-01-27 06:51:09
b2d5d4f0-fa4b-4024-b023-c45b8505bf91	i7hMJk1C1vPyyls5CljP	649	Eclair	Pastries	4	146.12	2025-10-24 03:24:56	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	sofia.reyes9	2025-10-24 03:24:56
7ee664ca-8915-4f48-939d-7c5f2787dd53	8OJIaPTLBNSmwWFlTyaq	650	Cappuccino	Pastries	2	76.25	2025-11-02 11:08:23	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.delacruz	2025-11-02 11:08:23
7c15b97c-dc68-4f5a-96ec-5619262312c9	Q170yLa4eGCZ4fQZltLp	655	Apple Turnover	Pastries	5	154.54	2025-07-14 00:05:02	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	rosa.rivera7	2025-07-14 00:05:02
165715f1-89af-4126-9d36-5903ebda4e37	SpjHAvJhyA3AjUYktYwD	657	Iced Coffee	Beverages	3	107.80	2025-10-04 18:45:49	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	gabriela.mendoza	2025-10-04 18:45:49
2bbe0fce-612b-4e2e-bb03-5c3d35f0a3f9	FuCjWQPMZLR1ndWSgprG	659	Iced Mocha	Pastries	1	144.00	2024-12-02 17:34:18	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2024-12-02 17:34:18
296be7e0-a2b7-4044-8cc3-b19a77a75a4e	BjBGGgNmQ20M4XSnlebz	663	Chocolate Chip Muffin	Pastries	4	103.79	2025-08-10 18:50:13	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904420344	sofia.bautista5	2025-08-10 18:50:13
4e6d17c2-db9e-48ad-af78-ebd872b45a93	K9DxvZ4vTsAf3VHg8l07	664	Chocolate Chip Muffin	Pastries	3	103.79	2025-04-20 10:39:00	996934ff-5758-44b4-ad0e-4ed9d927901e	Card	\N	sofia.reyes9	2025-04-20 10:39:00
fa3275a6-6e63-4008-bca0-377d0d989d05	OFSjF4JAGhfWILqYalv5	667	Chocolate Chip Muffin	Pastries	1	103.79	2025-04-30 23:43:19	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904199897	rosa.rivera7	2025-04-30 23:43:19
718f2b34-c697-4b6b-afd0-006020c3f533	mtlsxjfqU0QXth2ObytH	671	Glazed Donut	Pastries	1	148.75	2025-05-13 09:24:57	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	rosa.cruz13	2025-05-13 09:24:57
3eae77d2-7cfc-4415-8e1e-4e3a22bca7a8	MFdCPil4IwllsiiSHQOc	673	Macchiato	Pastries	4	93.97	2025-04-02 11:56:42	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	miguel.cruz15	2025-04-02 11:56:42
c06a55b9-9b6c-4eff-86fc-973c6a431a7d	dAzCzFFYnbs3CxmKx37I	677	Red Velvet Cake	Pastries	4	187.25	2025-02-17 11:22:59	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	rosa.rivera7	2025-02-17 11:22:59
f8956f67-3545-4424-9c46-72f297d5ee74	Rh7S01K7RL2xrVrehYo4	681	Chai Latte	Pastries	5	100.50	2024-12-19 11:12:07	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904760425	antonio.delacruz10	2024-12-19 11:12:07
0af415a7-8926-4309-9b6f-70b54475e9b1	WDUY5oImS5bX6HbHGZ5T	684	Red Velvet Cake	Pastries	3	187.25	2025-02-13 11:22:40	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	miguel.cruz15	2025-02-13 11:22:40
cc26a8ff-6406-405d-b456-f4c8885278d1	qCxRb78XAD9SVmH7GfLZ	685	Iced Coffee	Beverages	1	107.80	2025-11-20 03:10:37	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.delacruz10	2025-11-20 03:10:37
9b7dd9b6-7785-4fd8-a5d0-47cb06969fe9	F66Svl7ufnQeWvsKs6Uu	693	Mocha	Pastries	5	61.74	2025-11-13 19:19:29	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.bautista5	2025-11-13 19:19:29
a95b88f5-61bc-47ce-b1f2-278f49bcf8af	GDkqedtg0dfZWe0TVxLW	694	Chai Latte	Pastries	5	100.50	2024-12-07 00:15:18	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904921067	elena.fernandez11	2024-12-07 00:15:18
9d6bd0ea-1c7f-43d8-a6d6-a751f899df6c	oF8UficAF9Fs0tpYh9GP	695	Flat White	Pastries	3	113.21	2025-01-15 20:41:42	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	ana.rivera3	2025-01-15 20:41:42
df3049b8-4eed-460b-8ba0-539ceded0475	gxzhIiT429RHfcWwWwMl	696	Tiramisu	Pastries	3	196.55	2025-09-25 19:22:39	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904036837	gabriela.mendoza	2025-09-25 19:22:39
d0cb8685-e9f2-4f75-89d6-e3657263c257	lZuW9taLZJ60nMvmCxcp	697	Glazed Donut	Pastries	5	148.75	2025-04-12 17:50:47	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904622999	sofia.reyes9	2025-04-12 17:50:47
135a19fb-01a2-43a8-9a03-a549cc81e807	LXkaXPOBXJq9feiiYabt	698	Mocha	Pastries	2	61.74	2024-12-12 01:30:35	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	gabriela.mendoza	2024-12-12 01:30:35
63e83ecb-188b-4996-b4ca-efe8a5998613	RkwtCnTDwH77Oe47O6Qq	702	Flat White	Pastries	2	113.21	2025-09-15 21:47:46	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.mendoza	2025-09-15 21:47:46
5a27a7d2-9137-4c77-a01f-4c3cb01c9cf4	1ibDJcfBoAdeDh6Hiymz	705	Macchiato	Pastries	3	93.97	2025-01-10 01:44:56	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	carmen.santos1	2025-01-10 01:44:56
c42d15cc-b0e0-4090-ac2b-ea1a967142e6	Z4dCuqIhxAuJ7ZO7RXng	706	Glazed Donut	Pastries	4	148.75	2025-08-09 02:54:14	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904298261	isabella.delacruz4	2025-08-09 02:54:14
0e0c9fe1-6355-4f09-8187-885f601f042f	IYGPUWc3H7uf1yAq8Z8j	715	Iced Coffee	Beverages	3	107.80	2025-03-12 17:57:15	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.cruz	2025-03-12 17:57:15
7d4b03ca-1a51-4a39-a6b2-2859fcb3cd58	VnIIf03CzTUK5V19mLT4	720	Espresso	Pastries	4	195.76	2025-05-23 18:58:58	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904432771	rosa.rivera7	2025-05-23 18:58:58
8670ca0e-d718-4671-a39b-a191ecabe128	Kmrm3G0hlyHeOC4UpmHN	723	Almonds	Pastries	5	5.59	2025-11-14 16:24:47	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carmen.santos1	2025-11-14 16:24:47
5d172e6c-afbc-49d2-b8c5-3b36ea2192fb	EUo9dejiyxwy9YMwx48M	724	Macchiato	Pastries	3	93.97	2025-10-11 08:36:04	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	fernando.santos8	2025-10-11 08:36:04
b5dc8d16-651e-443e-99fb-7783238be36e	5dRbVXZeogeNEq1bbogp	726	Blueberry Muffin	Pastries	4	185.15	2025-09-14 23:02:41	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	carlos.mendoza	2025-09-14 23:02:41
36f18357-da91-4839-8f36-fd875e54ab92	6hkzeoiGaufqRVV2NmEu	728	Americano	Pastries	1	80.96	2024-11-26 11:14:18	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	gabriela.mendoza	2024-11-26 11:14:18
d2fe46be-e6bd-4969-ae83-f7e415033c64	iWpwSAnSRkwCX5wveyyZ	730	Cappuccino	Pastries	3	76.25	2025-08-16 18:00:26	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	ana.rivera3	2025-08-16 18:00:26
300f1a44-3dff-4068-b2d3-187777419818	UhjCkKN9mJmoQL2uoQ2m	732	Macchiato	Pastries	4	93.97	2025-11-14 09:39:04	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.delacruz	2025-11-14 09:39:04
f9398cf0-6c54-4587-b2a3-f8b6000932fc	vslh5WLUIGFJ06rp3gAQ	737	Mocha	Pastries	1	61.74	2025-07-23 19:54:50	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	admin	2025-07-23 19:54:50
b229908d-043a-4709-ba20-c4888b37232d	VcJeSTWfYBwSHJ1T5vzM	740	Iced Mocha	Pastries	2	144.00	2025-09-15 18:36:44	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.delacruz	2025-09-15 18:36:44
61bea929-bec3-4611-92de-21ca3dfc1b4d	pnh1fTuBV32OJWJE4IEc	743	Red Velvet Cake	Pastries	1	187.25	2024-12-19 21:26:40	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.fernandez11	2024-12-19 21:26:40
28953cdc-8e9a-4e7b-acda-34c987064f88	oFuBuRLqPoSirD7g9Lca	748	Blueberry Muffin	Pastries	2	185.15	2025-03-07 03:01:53	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.rivera7	2025-03-07 03:01:53
fe3aa8e2-b3e1-4ef2-816f-ac998953aa93	t1UHritDkMmlVp7o7Rtc	754	Tea	Beverages	5	106.18	2025-06-18 04:13:20	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	fernando.santos8	2025-06-18 04:13:20
cb78608d-b6d2-4e3f-8f3d-9f7a69520952	JDjqOtI3MszanXVFwQYX	755	Iced Mocha	Pastries	2	144.00	2024-12-30 13:35:28	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	pedro.cruz14	2024-12-30 13:35:28
4a902277-06c3-463f-bb87-2b9abe6322ec	cGpTSrsdxtsPaH8zZnN0	756	Tiramisu	Pastries	1	196.55	2025-06-29 18:20:30	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	admin	2025-06-29 18:20:30
4741c177-cd2c-4093-94e9-0dde4088b7ef	k7bk4XlAf1OI9IDWJSHO	760	Blueberry Muffin	Pastries	5	185.15	2025-07-30 15:31:57	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	gabriela.mendoza	2025-07-30 15:31:57
e5e4c1d4-5893-4f5d-8ece-a53685e9e173	VEypZPRKAaFe15q7q8TN	767	Mocha	Pastries	1	61.74	2025-06-26 14:47:09	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904472424	ana.rivera3	2025-06-26 14:47:09
d8b83148-b9ab-4883-a358-749fbcb8439a	2TWoHvKrVUoAIBNq5D22	768	Red Velvet Cake	Pastries	4	187.25	2025-05-26 02:43:07	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	fernando.cruz	2025-05-26 02:43:07
900e5755-42b9-46e2-b4dc-0a807f18c8bd	Sx7cKLuF0SZtOA4U7tKM	770	Flat White	Pastries	4	113.21	2025-02-25 11:14:26	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	rosa.rivera7	2025-02-25 11:14:26
b80ac3e0-bba2-4bc1-a502-5b03be8b7c3d	bRTv0UAttMOIpCAUyLhr	774	Apple Turnover	Pastries	5	154.54	2025-06-29 15:38:50	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904772742	antonio.santos6	2025-06-29 15:38:50
6fd81048-1147-4c15-9e1c-a1b85ad4596b	uTGUpuempDBLVOXbBAGD	775	Almond Croissant	Pastries	3	8.42	2025-09-20 18:29:59	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	rosa.cruz13	2025-09-20 18:29:59
0403c17e-ccfb-482a-acba-41c41d376496	pvWbdmfMdhuVVlo2YpmM	777	Blueberry Muffin	Pastries	5	185.15	2025-06-01 12:34:41	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carmen.santos1	2025-06-01 12:34:41
bd631d67-87d5-4789-80dd-3783af6f4c3d	rbMgIH0mrDTMziOiohus	778	Hot Chocolate	Pastries	5	131.53	2025-02-17 22:45:11	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	sofia.bautista5	2025-02-17 22:45:11
3c3c9eeb-ba0f-4103-85a6-997961023871	uJ7IjXeQ214n9Leaofu6	779	Americano	Pastries	3	80.96	2025-04-02 21:29:27	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	sofia.reyes9	2025-04-02 21:29:27
a2d1b2ff-754b-4cd5-805d-431b0ec316bc	mRXVthXSmyfKubPzygDM	782	Glazed Donut	Pastries	5	148.75	2025-02-17 10:12:54	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	rosa.cruz13	2025-02-17 10:12:54
bc7507eb-7b3d-424a-ad4e-279ce023d603	MDYZa2AAd50RTpKqhb2S	786	Glazed Donut	Pastries	5	148.75	2025-11-06 02:32:08	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904921276	sofia.reyes9	2025-11-06 02:32:08
4ce4f5ba-ff9a-48aa-98d9-47632114876f	mD8vLfXCzhZ7XNGWa29o	788	Almonds	Pastries	3	5.59	2025-04-20 05:58:23	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	carlos.cruz12	2025-04-20 05:58:23
016e2782-edda-4107-9529-876d760858e9	44iK48S1Hc9zs8J4efmF	792	Eclair	Pastries	2	146.12	2025-06-12 12:29:24	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	rosa.cruz13	2025-06-12 12:29:24
916250c0-9238-4d28-a65f-a75a2c30cd52	3Nma6EYTuUomNJtcHpmz	796	Chai Latte	Pastries	3	100.50	2025-11-22 23:59:47	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904638879	sofia.reyes9	2025-11-22 23:59:47
012f146e-73a8-4823-8760-e5994a213bcb	IQp8rbQbIfcB64mHccrG	797	Macchiato	Pastries	1	93.97	2025-11-08 06:25:41	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	rosa.cruz13	2025-11-08 06:25:41
a646f223-1bfc-434d-ad5e-a6ef136e122f	hxHYd0FMurvlBOgbHkNE	798	Americano	Pastries	3	80.96	2025-03-24 19:10:05	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.rivera7	2025-03-24 19:10:05
7ede2523-275f-491f-9759-1fad67e7ac86	JdrIj5LYyo4LtJAXyRyJ	801	Apple Turnover	Pastries	3	154.54	2024-11-25 16:07:18	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904862168	antonio.santos6	2024-11-25 16:07:18
854f57b5-1d3b-4eea-8d80-d5046b4a599d	5OMonqMp2Jxzvpsx0vbM	803	Flat White	Pastries	5	113.21	2025-06-26 13:40:40	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.fernandez11	2025-06-26 13:40:40
f1a60d04-fc64-4925-8150-da07c26fe5bd	Cd4EkjtUhBiVaKQDZA0Q	806	Almond Croissant	Pastries	2	8.42	2025-11-09 04:21:17	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904897023	fernando.cruz	2025-11-09 04:21:17
310b5c14-919e-4ca1-8b83-9a669ddd9c30	DT7hs5fvluC2CIUml8iJ	807	Tiramisu	Pastries	2	196.55	2025-09-08 04:45:38	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.fernandez11	2025-09-08 04:45:38
21232079-e2e3-4391-a0d0-ba0002b4931f	2N1sqh6GntkQcDJRTKtY	809	Tea	Beverages	4	106.18	2025-08-24 14:02:33	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	gabriela.mendoza	2025-08-24 14:02:33
fabcfbd8-1db9-4246-96a2-4867add4d55e	rc0NxarYLmQug8HVhmpZ	812	Tiramisu	Pastries	2	196.55	2025-11-02 10:22:37	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	antonio.santos6	2025-11-02 10:22:37
4b071cfd-beef-49bc-9c98-5ae70ec4080c	5C42WvKnDeoyR1WSoB5N	814	Macchiato	Pastries	4	93.97	2025-07-22 06:19:00	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	rosa.rivera7	2025-07-22 06:19:00
35523b1f-08ee-4d9c-bd12-adcceac009ad	n57oWd38PWpF2i1HgwY5	816	Iced Mocha	Pastries	2	144.00	2025-06-12 15:38:25	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.delacruz	2025-06-12 15:38:25
d9b63e08-0589-4753-8e80-85c1d4a84279	bzdGIuZEGmq9UvBpqMhR	823	Chocolate Chip Muffin	Pastries	5	103.79	2025-03-09 15:00:42	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904540895	miguel.cruz15	2025-03-09 15:00:42
3b3e7b53-4b7a-47ed-9293-2037e05e1a4a	ayMNPkNgAOW6Zjm67jWE	826	Espresso	Pastries	4	195.76	2025-10-27 19:48:50	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904822699	admin	2025-10-27 19:48:50
5757f567-7bb7-4738-b5e0-c07366df3b08	6LguJywCGXsOOONu8owV	828	Espresso	Pastries	1	195.76	2025-06-25 11:45:41	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	fernando.cruz	2025-06-25 11:45:41
0d616eb4-efc2-4f16-bbb2-7bbaabbd3d1d	Ptv6HTfR1tdqNuGoG7Sz	829	Flat White	Pastries	1	113.21	2025-06-08 06:25:53	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.mendoza	2025-06-08 06:25:53
b1e51d02-5e8e-4ed0-8e72-8a48f46fd02f	XLMLkP9nULs6U0yUY1jJ	831	Macchiato	Pastries	2	93.97	2024-12-16 23:58:11	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904211412	carlos.delacruz	2024-12-16 23:58:11
063f2304-d084-40d1-a741-0cf4b80c83fc	lmu6TWOHbq0LH1Mq5nhn	832	Chai Latte	Pastries	1	100.50	2025-03-19 13:35:01	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	miguel.cruz15	2025-03-19 13:35:01
4ee2ac34-93d4-4e98-9bec-b00b27315953	8po0dFXANrbbvKHKkVQN	833	Americano	Pastries	5	80.96	2025-07-29 07:05:29	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904439848	rosa.cruz13	2025-07-29 07:05:29
981fcc6c-e5c3-4172-8804-82862fd9cfb7	081z1EOCufe9Fgielmfn	842	Baguette	Pastries	3	133.77	2025-06-24 08:44:11	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.mendoza	2025-06-24 08:44:11
b8ec16cb-17ab-4bcd-a817-78472355df38	Ns3neijL7PRkG6dkvCsu	846	Iced Mocha	Pastries	2	144.00	2024-11-25 01:42:13	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	ana.rivera3	2024-11-25 01:42:13
20e9516b-7211-4c46-88f4-343f2015fad1	0ChlNdJG2w2dYlMpeJAN	865	Tea	Beverages	4	106.18	2024-12-02 04:17:59	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904094238	sofia.reyes9	2024-12-02 04:17:59
c64d3e3e-5be9-4015-a252-06e1134095b9	IMNRL9PRSO67oL8dcHys	872	Iced Coffee	Beverages	1	107.80	2025-02-27 10:12:33	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904897820	sofia.bautista5	2025-02-27 10:12:33
8fbe4c1d-e910-4719-b11c-c52d537fee4c	X4uNx4mqIvmpJUKDU3xe	876	Mocha	Pastries	4	61.74	2025-02-05 02:27:10	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.bautista5	2025-02-05 02:27:10
b986dfc2-7eb1-4688-91ec-a218dd008bad	QAk2t9r9QF1iidiOI3Zj	880	Americano	Pastries	4	80.96	2025-02-08 17:05:50	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	admin	2025-02-08 17:05:50
590e4100-5e4f-46aa-a365-3a5c337af0ce	bUFTqhbYFEG8FjxOIbcU	882	Cappuccino	Pastries	5	76.25	2025-04-14 21:15:49	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	miguel.cruz15	2025-04-14 21:15:49
70c0eb04-ab71-4e3b-94dc-55efa81971fd	scXYX3wgxSxKHf9Xo55T	883	Chocolate Chip Muffin	Pastries	2	103.79	2025-02-16 17:57:27	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904089880	antonio.delacruz10	2025-02-16 17:57:27
ef450cea-83db-4527-a0d0-ef5566199db9	x6v4dDqWpikVgjmaxAfw	886	Cappuccino	Pastries	3	76.25	2025-09-30 01:13:33	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	sofia.reyes9	2025-09-30 01:13:33
2011a235-c3dd-443d-b120-05826272fd6a	ABFVG48TGrN0NkWIVhQ8	894	Flat White	Pastries	1	113.21	2025-02-23 05:16:14	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	fernando.santos8	2025-02-23 05:16:14
9b4ddc26-ac42-43e6-b76b-6872c074e765	8MnC0U4FV57sdxsYe5sW	896	Americano	Pastries	5	80.96	2025-07-10 08:16:39	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	antonio.santos6	2025-07-10 08:16:39
1d671dc1-2899-4260-a350-e28ac7144b4e	NKLGejOX5pXF6OyCpZVF	899	Almonds	Pastries	5	5.59	2025-04-12 08:04:53	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	antonio.delacruz10	2025-04-12 08:04:53
cab34c2a-7905-4abe-9931-2b2c3323922d	mxToawJbtKjN47GsXhcg	900	Iced Coffee	Beverages	2	107.80	2025-03-17 17:02:43	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904542386	antonio.santos6	2025-03-17 17:02:43
e368b167-f9ee-4ce4-947f-fe477079b278	yZZh8eJWPX7xGxhRrjI6	904	Eclair	Pastries	4	146.12	2025-10-16 11:48:23	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.delacruz10	2025-10-16 11:48:23
9bf6fe97-7e19-4bf3-be17-3af56f870e10	5UvwB4TlQIP4ov1JffHz	909	Chai Latte	Pastries	1	100.50	2025-05-29 03:45:11	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carmen.santos1	2025-05-29 03:45:11
029fc800-d6b5-4c4b-8b87-16986de5744e	wJTMgYzkWRN8zY9IekaF	912	Eclair	Pastries	4	146.12	2025-01-23 20:51:06	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.mendoza	2025-01-23 20:51:06
8516568a-657a-4db7-8e40-9be9f7c05d2d	EQ06XNeVi6KSQpsqQ2Kx	914	Red Velvet Cake	Pastries	2	187.25	2025-04-12 19:24:39	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.cruz12	2025-04-12 19:24:39
13c3cc46-cf67-45ba-9b9a-caf3b18c5ec9	GFMdKJJqmjlRhSDIf7uV	916	Eclair	Pastries	4	146.12	2025-04-29 17:01:46	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.cruz12	2025-04-29 17:01:46
54449252-3c18-4909-8a2c-0f2cf9dbb2f3	vqgvWGN4ojjEOXuKIgQi	929	Glazed Donut	Pastries	1	148.75	2024-12-03 05:43:41	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	fernando.cruz	2024-12-03 05:43:41
cccc3d23-d7d8-4ddd-ac44-528f855419db	RLOpIYa3W82J2GkVQBmw	932	Apple Turnover	Pastries	3	154.54	2025-01-28 19:12:24	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	admin	2025-01-28 19:12:24
fc927756-e10e-47ae-810b-a36a6e32bf87	0jdtKNLWbQqRmMTFs9OR	935	Cappuccino	Pastries	1	76.25	2025-07-25 09:45:43	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.fernandez11	2025-07-25 09:45:43
84049e52-27e9-4ee7-afbd-cf27978e7143	6Xu1LpwcWscO2XX3jflV	939	Macchiato	Pastries	5	93.97	2024-12-30 13:00:50	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.mendoza	2024-12-30 13:00:50
b8bcd1d2-c15c-46f0-bc0f-761a68b545b4	guJbpl2L6ik1d4layKJe	944	Tiramisu	Pastries	1	196.55	2025-10-31 15:54:27	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904118514	ana.rivera3	2025-10-31 15:54:27
6d9f1557-8081-49bb-8887-7c441b4c6baf	8NXDms24QWfbuUFQWQTG	947	Chocolate Chip Muffin	Pastries	1	103.79	2025-08-12 03:44:11	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	ana.rivera3	2025-08-12 03:44:11
adfacfc3-03d3-451d-b7db-2eb1b65926e2	Ycg35wlpuABJuvFlyVot	948	Tea	Beverages	2	106.18	2025-11-01 04:01:46	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.fernandez11	2025-11-01 04:01:46
ed29c5b4-69c6-400c-be94-0383b68e4823	mk1gnVeYHRkCR1otpP0d	953	Iced Coffee	Beverages	5	107.80	2025-10-28 14:35:54	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904998137	rosa.rivera7	2025-10-28 14:35:54
16e325f2-3c7f-48c1-b175-8c6f64dd820d	xG2WItUFtVFzwVkFjOP0	954	Red Velvet Cake	Pastries	5	187.25	2025-04-27 17:59:12	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904487195	elena.torres2	2025-04-27 17:59:12
5e7a431c-45ac-4d3a-8779-8e155330e217	zY1InBILVwmmnntyDgMz	956	Iced Coffee	Beverages	5	107.80	2025-02-26 05:22:06	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	ana.rivera3	2025-02-26 05:22:06
d68006d9-2443-4581-99aa-7465cf9ceb1e	xRFCboB4fQxNEOPcGxSQ	957	Macchiato	Pastries	3	93.97	2025-05-11 11:12:38	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904606066	sofia.reyes9	2025-05-11 11:12:38
8e89fc14-59d7-466a-82d2-ea38ae308420	nIGb688wi8klfLEKlVUJ	958	Cappuccino	Pastries	3	76.25	2025-01-09 19:53:32	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	sofia.bautista5	2025-01-09 19:53:32
67ab3150-831e-46de-8587-db8e0fe75985	9my8Mo8ENDmE3fvkVj8F	959	Iced Coffee	Beverages	4	107.80	2025-10-18 14:01:02	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.delacruz10	2025-10-18 14:01:02
01631134-09b9-45c9-a379-af3a037aa367	XbyTYZXWkoTVELh9q8AS	961	Iced Coffee	Beverages	4	107.80	2025-07-30 02:35:35	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904192514	sofia.bautista5	2025-07-30 02:35:35
eee8abfa-0183-4dfb-b735-1598c2a93e11	D1lnJpvsCIjX25lDw4EU	962	Latte	Pastries	4	108.74	2025-11-21 05:55:16	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	admin	2025-11-21 05:55:16
d5d47fb7-673a-4435-a49d-8ae660cff110	C5981c54fgjCUv4ZiUVg	966	Macchiato	Pastries	1	93.97	2025-01-18 17:50:47	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904074862	rosa.rivera7	2025-01-18 17:50:47
56978283-3c15-4d29-9c1a-ff12be86a040	7w8liyJZDNilHvD14WSS	968	Iced Mocha	Pastries	2	144.00	2025-10-15 07:40:57	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904291125	carlos.mendoza	2025-10-15 07:40:57
820610c0-6a85-4418-a14b-bf2a01c22df8	dI87iICkmAQFPF4kbkHa	970	Blueberry Muffin	Pastries	4	185.15	2025-07-29 11:45:12	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904352065	elena.fernandez11	2025-07-29 11:45:12
ad437db9-5915-4f3a-91a6-b44640e1a1b2	9JRmCL2dAT2V00VpNwVj	971	Glazed Donut	Pastries	5	148.75	2025-06-05 05:07:44	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904918238	ana.rivera3	2025-06-05 05:07:44
f604a648-8654-435c-9ce3-aa647a945121	CvuDFUM3bq2mVe8kdS8F	979	Eclair	Pastries	3	146.12	2025-06-14 09:06:15	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.fernandez11	2025-06-14 09:06:15
bb5d811a-64c2-4d7a-a7c9-ecdb93b82f8c	ym33UTYQ7pav47rt2vpB	982	Glazed Donut	Pastries	5	148.75	2024-12-18 20:02:50	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.delacruz	2024-12-18 20:02:50
0935c669-9b07-45e4-b03a-ec8337a396a2	AIwWyZyuwAKsj8svXXre	987	Glazed Donut	Pastries	4	148.75	2025-03-16 11:55:19	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	fernando.cruz	2025-03-16 11:55:19
24f4b867-7c30-4d26-9ec9-95cbe1ff9a99	36g0Ulv9LHF9BWPimG2L	988	Latte	Pastries	1	108.74	2025-03-09 16:11:05	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	antonio.delacruz10	2025-03-09 16:11:05
acd1c466-df44-4105-b99e-bd97d207e6d5	fVWR4KAw8lZApQzQPsLC	989	Apple Turnover	Pastries	5	154.54	2025-08-06 00:20:20	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904393188	admin	2025-08-06 00:20:20
46ed8993-fb04-4325-a960-f4b8c108fd38	MM2tVmjBpu9109Rt4gnj	992	Blueberry Muffin	Pastries	5	185.15	2025-02-03 12:56:02	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.cruz12	2025-02-03 12:56:02
5a991608-9ab2-4b20-9b82-208cd0fc2bcf	6VX2Cm6NLauQj6QMtayw	993	Americano	Pastries	4	80.96	2025-07-09 08:00:25	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	miguel.cruz15	2025-07-09 08:00:25
76bc6e34-de80-4e09-85f5-c8801df978ae	eDZY0dnCGIRiwWq2DWxj	995	Flat White	Pastries	3	113.21	2025-04-19 21:35:48	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.cruz12	2025-04-19 21:35:48
eb692f7f-0636-496d-ba6e-8122692a3347	HHAfqTO8p5bZLkoouy2B	996	Eclair	Pastries	5	146.12	2025-06-09 00:54:18	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904913069	fernando.santos8	2025-06-09 00:54:18
5c1e1d2f-b288-4861-86e7-1546951c67d4	DVvPrGHdWFKi4uwVETdY	997	Red Velvet Cake	Pastries	4	187.25	2025-04-30 08:48:13	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904941491	rosa.cruz13	2025-04-30 08:48:13
1fe3e0ed-52a8-43f8-93e4-df32732e5e2f	NOBzmByVzO0TRRQXvCUM	998	Blueberry Muffin	Pastries	5	185.15	2024-11-29 02:22:27	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904872556	carlos.delacruz	2024-11-29 02:22:27
a99a2970-31d5-4468-b9d2-8eaf51233f3e	tLwmrpxaflxBpQSMrX1F	1010	Tea	Beverages	3	106.18	2025-11-02 02:38:14	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.fernandez11	2025-11-02 02:38:14
0aad683d-1456-4599-a1cc-da3004a6e6cd	JhgnNe9NSTYJTSGZLDdt	1011	Eclair	Pastries	1	146.12	2025-09-07 04:08:04	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.santos6	2025-09-07 04:08:04
ff183fa0-7742-4a7f-bb5e-ca8dc082d2f6	YNaNlwPESxUbSS30MBJd	1017	Iced Coffee	Beverages	5	107.80	2024-12-18 19:01:31	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carmen.santos1	2024-12-18 19:01:31
495f2a60-d4e1-4ac4-a164-2cd5c79a7b40	7TbAHLYocQP5y9TuP0MK	1019	Iced Coffee	Beverages	3	107.80	2025-01-07 08:44:53	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.bautista5	2025-01-07 08:44:53
e3ba754a-311c-4bd3-89ee-def699a53672	50MD89p1wlPnDhUippai	1021	Chai Latte	Pastries	2	100.50	2025-06-11 20:15:37	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	antonio.delacruz10	2025-06-11 20:15:37
e15a54c6-a3fa-4809-88d5-7fc61193009d	FwReTULo3E6Ho12v7Mup	1023	Hot Chocolate	Pastries	1	131.53	2024-12-02 20:55:03	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	fernando.santos8	2024-12-02 20:55:03
f4e33323-ad13-4c6f-8f76-9c7dd7059175	kVNWkDQYrme9k3yuchCT	1025	Tiramisu	Pastries	5	196.55	2025-11-08 01:19:17	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	gabriela.mendoza	2025-11-08 01:19:17
d90052ce-c2f9-40db-a87d-2ca8fc1e60e3	dPn8oKnhJwYwprBMFNS3	1028	Baguette	Pastries	1	133.77	2025-02-18 02:39:51	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.torres2	2025-02-18 02:39:51
8a56ff79-6177-4568-bf34-b3cb8340c316	90IOsyJCffuGORbpsfea	1029	Hot Chocolate	Pastries	5	131.53	2024-12-26 10:04:14	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904373984	elena.torres2	2024-12-26 10:04:14
b3d29e6d-af00-45ff-9766-751febae5d20	9i901xqhTulpSmPLAVnq	1035	Apple Turnover	Pastries	3	154.54	2025-07-18 05:01:59	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	rosa.rivera7	2025-07-18 05:01:59
8a7e3c33-f903-4759-a2a9-af7b2b113f72	4wL0XKcnSpEPGQ8m8tSK	1043	Blueberry Muffin	Pastries	4	185.15	2025-08-11 12:08:28	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	elena.fernandez11	2025-08-11 12:08:28
3d6a5056-ffc9-492d-a7ae-6c06f629f8f8	rdjQAXICuXR9ZgN97R2U	1045	Almond Croissant	Pastries	4	8.42	2025-05-20 22:28:14	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.mendoza	2025-05-20 22:28:14
a1a36e81-9fe4-46d4-a2f3-0ce79983c19d	EYBdbfQCao33K9nF01QF	1049	Americano	Pastries	1	80.96	2025-03-03 13:53:44	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	sofia.reyes9	2025-03-03 13:53:44
6377d4a3-9ee2-4296-a6a4-1525397e9d84	NqRdSqpwO26csw4IWNGu	1051	Americano	Pastries	3	80.96	2025-05-10 15:23:17	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904871057	fernando.cruz	2025-05-10 15:23:17
0ab42694-2d63-4396-b28d-db031df50aad	DFCqTf9PFW1uDXwVGZGk	1056	Cappuccino	Pastries	4	76.25	2025-03-02 00:26:20	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904450560	admin	2025-03-02 00:26:20
9b11e417-e609-438f-8452-257abc723d49	oWKQGixqxljOaGIL9XVj	1061	Chocolate Chip Muffin	Pastries	4	103.79	2025-04-25 03:40:35	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.rivera7	2025-04-25 03:40:35
f791e62b-8008-4dc3-939f-860cc155bc08	bfz1rCzmw38gsZo1ePTC	1062	Flat White	Pastries	3	113.21	2025-04-02 06:30:07	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904745037	isabella.delacruz4	2025-04-02 06:30:07
212b436e-24ea-4166-b5a4-0355f69e9b8c	eXMCKC3kH6sKnUFmYrQw	1065	Iced Mocha	Pastries	1	144.00	2025-06-08 14:34:18	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904099057	rosa.cruz13	2025-06-08 14:34:18
38642bf1-bbd9-46b3-83ad-cfdf293c98b7	8Nnyw2pEHbbZmcNDTAwL	1066	Tea	Beverages	1	106.18	2025-04-29 07:02:28	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	gabriela.mendoza	2025-04-29 07:02:28
9f5d18be-b6f3-4054-b18c-f93325b65bc9	u5kjMKaugZKPk3mEexWz	1068	Chai Latte	Pastries	4	100.50	2025-04-06 03:41:30	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904287513	rosa.rivera7	2025-04-06 03:41:30
b1a993e9-20dd-4ce5-b602-47a9b49955cd	yC2khzFcBlwrTD2EUUnH	1069	Flat White	Pastries	2	113.21	2025-01-28 18:21:54	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	fernando.cruz	2025-01-28 18:21:54
1040b363-1eda-44e1-81bd-98621c2ef1a6	Y5ewieF7RaE44cDIvFQ0	1073	Blueberry Muffin	Pastries	5	185.15	2025-11-24 14:02:43	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	isabella.delacruz4	2025-11-24 14:02:43
52892e87-3c03-4a67-9ed3-6306f4b50bce	Z0sfwwD7v9p84kjV1XrU	1077	Tea	Beverages	4	106.18	2025-11-10 05:29:25	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	elena.torres2	2025-11-10 05:29:25
232f2f2a-e5f2-464e-a94a-aa6592357722	DxYiadTzzoTbtJPHg46P	1078	Espresso	Pastries	3	195.76	2024-12-06 19:09:08	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.delacruz	2024-12-06 19:09:08
9f046d2f-0054-48ed-8f2d-92ddc64c7249	Ky0X0olGSzgkJ0dyyp4B	1079	Tea	Beverages	2	106.18	2025-02-03 06:16:24	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904550100	admin	2025-02-03 06:16:24
09ff24ad-14e3-4977-b684-816dc3a9c627	NDp8RSRwNHj8JBC04PjQ	1082	Cappuccino	Pastries	5	76.25	2025-01-29 15:42:44	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.santos6	2025-01-29 15:42:44
d23a2e95-89e1-4588-b8f0-8c77c32b5ed7	kGt8moa36jIfr3CESk9E	1085	Iced Coffee	Beverages	5	107.80	2024-12-21 07:15:38	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904526175	antonio.delacruz10	2024-12-21 07:15:38
3e8379f6-2fbd-4f1c-878a-e7e71c6efc07	fyfJUzaUn42iP89aO7hA	1088	Hot Chocolate	Pastries	4	131.53	2025-07-11 22:07:29	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	sofia.reyes9	2025-07-11 22:07:29
a797b320-af21-462e-90d1-95be591625f1	o6ALNqHWIQk3DDKQ04jl	1090	Almond Croissant	Pastries	4	8.42	2025-07-07 12:26:58	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.cruz12	2025-07-07 12:26:58
c2895d7e-d0f6-4561-a574-46cc42312f1c	73G1Dfm88AZY9dITpnPp	1092	Flat White	Pastries	4	113.21	2025-09-06 07:11:38	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	carlos.delacruz	2025-09-06 07:11:38
11607202-2fa2-4f39-96ed-fbaeb76c2478	GSeo9bcNAQyS2khYoxPv	1100	Chai Latte	Pastries	1	100.50	2025-08-20 06:20:18	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carlos.cruz12	2025-08-20 06:20:18
a251bc70-fb2a-4279-b0b6-bbf681e8f19e	OqxtuipgQcQoEwauvGI2	1103	Apple Turnover	Pastries	2	154.54	2025-09-26 08:35:12	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	ana.rivera3	2025-09-26 08:35:12
cafa3131-11b6-43a7-8bba-1988b26bea32	JcEIOEsr9cAbQ8yXkDDy	1106	Iced Coffee	Beverages	1	107.80	2025-05-28 03:05:50	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.bautista5	2025-05-28 03:05:50
ed05b2e3-7f21-4871-a4fb-19b7a65dc7c5	roGLrIt3xOPBUOdkwYWh	1116	Tiramisu	Pastries	4	196.55	2025-09-05 01:14:42	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	fernando.cruz	2025-09-05 01:14:42
88d46ab8-a647-44c6-bb72-20d99ff434d0	diru6FB8zmL0dJ5sEvPP	1118	Iced Coffee	Beverages	5	107.80	2025-02-27 07:07:39	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carmen.santos1	2025-02-27 07:07:39
8c4daec9-a729-4dbc-8e98-954073ec84a8	BI9BELxTE06UQZtWPFAz	1129	Tiramisu	Pastries	4	196.55	2025-07-20 16:26:26	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	gabriela.mendoza	2025-07-20 16:26:26
54c592c1-2edd-437b-b1cb-a20eb4beaebb	Ctw7bYYG1whERtjyIQd2	1133	Glazed Donut	Pastries	4	148.75	2025-08-24 13:29:01	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904064122	carlos.cruz12	2025-08-24 13:29:01
5d7f41f6-b192-4d8c-9bc8-c7c0bcab29b5	KR7UGOThGwU9AH9FXHSq	1138	Almond Croissant	Pastries	5	8.42	2025-06-25 05:20:24	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904587192	rosa.cruz13	2025-06-25 05:20:24
2ce59f39-81dc-4947-838b-9a7be080b7b8	i5wOfQogg2hsyfBwQzUo	1141	Tiramisu	Pastries	4	196.55	2025-08-13 03:23:14	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	sofia.reyes9	2025-08-13 03:23:14
0996b2a8-d399-4be6-b5b7-4ea666d16cdf	q6LvlFAJclul8NEE7a4y	1144	Red Velvet Cake	Pastries	5	187.25	2025-11-01 09:10:24	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904194102	rosa.rivera7	2025-11-01 09:10:24
f818b51f-8304-4484-b327-8621641e3851	lEvc7NyuEpV9wJo98HRW	1147	Chocolate Chip Muffin	Pastries	3	103.79	2025-07-02 23:39:12	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	isabella.delacruz4	2025-07-02 23:39:12
5602de71-e27b-4d97-8c0c-3decd396599a	QHImymYLh96cCT9StXip	1149	Tea	Beverages	1	106.18	2025-09-04 12:15:53	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	isabella.delacruz4	2025-09-04 12:15:53
13bcbfd5-8fa6-4289-972b-fb9cd1ec8892	2fHG02wEJiyCkKUbOv2Y	1151	Almond Croissant	Pastries	5	8.42	2024-12-26 19:10:30	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904371637	pedro.cruz14	2024-12-26 19:10:30
d5803cbb-a391-4ae8-9ff8-50a870720ef9	Ow2uRfGQeFh0qVKGi52F	1156	Hot Chocolate	Pastries	1	131.53	2025-10-26 19:14:07	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	isabella.delacruz4	2025-10-26 19:14:07
da698148-5f61-4d05-b7c1-716bc186b520	4lhDEFw3wVKI44sRhmS0	1159	Americano	Pastries	2	80.96	2025-09-12 03:06:39	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	miguel.cruz15	2025-09-12 03:06:39
70032bd5-30cb-4de9-815a-1c3636bce95a	bYisABGmAdzfxZilyMgx	1160	Blueberry Muffin	Pastries	2	185.15	2025-06-05 17:53:52	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.cruz	2025-06-05 17:53:52
9ca3319c-e8c3-4e0c-96bb-41670650fba0	SdXoONvMWMGnKtzl6CjP	1162	Almonds	Pastries	1	5.59	2025-06-07 06:10:22	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	fernando.cruz	2025-06-07 06:10:22
8cce4024-c471-4559-87c9-2ab446bfa276	Qw0sO1k47lTw6nh9ZtlU	1164	Cappuccino	Pastries	5	76.25	2025-10-06 15:22:49	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	gabriela.mendoza	2025-10-06 15:22:49
babe17ef-d5eb-4ec9-a68f-99b666bb5bb6	uQE9A7nPZQjaMENxOWwY	1165	Hot Chocolate	Pastries	2	131.53	2025-10-14 15:17:08	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904870792	sofia.reyes9	2025-10-14 15:17:08
52e4722b-8c66-44ee-af12-9eef056ef0da	PjlkCi8oFYkvX5zUtJKs	1167	Mocha	Pastries	3	61.74	2025-01-05 03:05:03	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	pedro.cruz14	2025-01-05 03:05:03
77f60e98-ad15-42a7-8b6f-89917441cd31	D2FqX8o0uFqt4q4NJ148	1168	Tiramisu	Pastries	4	196.55	2025-10-18 16:56:56	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	antonio.delacruz10	2025-10-18 16:56:56
e121797f-645b-4831-8566-02438169c3c3	pnIQMvJd1ZCAfiLfR0YB	1169	Eclair	Pastries	5	146.12	2025-01-09 12:38:40	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	gabriela.mendoza	2025-01-09 12:38:40
2dbc23a2-8b3c-4bbd-a62f-a1d74d3b2ea4	nNJHeu4uyFlJU5NeJ9al	1174	Latte	Pastries	3	108.74	2025-07-25 18:12:12	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904589995	pedro.cruz14	2025-07-25 18:12:12
18af81bb-a5e1-4370-95ce-1cd5c64933b9	gu0UG1zEtRUK5z7iW2qI	1186	Latte	Pastries	5	108.74	2025-09-07 07:07:51	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904814081	fernando.santos8	2025-09-07 07:07:51
7a36b880-528a-47f2-9062-3cf20feb82ca	mUVKilFiDATN9ToFlF7e	1189	Blueberry Muffin	Pastries	4	185.15	2025-03-31 18:58:47	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904172874	carmen.santos1	2025-03-31 18:58:47
de00ed68-462d-4d6b-9cef-f335cb24ef2c	tp1RfAOXQnbmrO38cuOo	1200	Blueberry Muffin	Pastries	5	185.15	2025-01-14 08:23:44	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904307796	admin	2025-01-14 08:23:44
2250a785-5d02-40fe-849e-c2b1266f63f6	RLYjFbpOHUiu5OwxrwbI	1201	Apple Turnover	Pastries	5	154.54	2025-01-20 02:18:55	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	fernando.cruz	2025-01-20 02:18:55
f51dd847-ddaa-4ac1-a0d4-2df6dc963411	nI6J6uA7MWbaV9e9q6Bq	1204	Flat White	Pastries	5	113.21	2025-01-06 15:23:27	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	rosa.cruz13	2025-01-06 15:23:27
2d3bc457-8805-452a-ac92-c8b84acbb2cd	fS0ay6HS4uRcouKTbVtG	1206	Red Velvet Cake	Pastries	3	187.25	2025-06-15 11:42:46	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carmen.santos1	2025-06-15 11:42:46
86632d9d-c69b-44c0-bd86-2e3c28bd84b6	inqbaUSbC3kfvqrmbwpK	1207	Almonds	Pastries	5	5.59	2025-08-24 07:17:51	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.reyes9	2025-08-24 07:17:51
672816d8-35ad-421f-9f3a-daaa928ede79	eIuWANIsRr00H7HnLI2U	1210	Macchiato	Pastries	1	93.97	2024-12-17 12:20:35	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904625266	carlos.delacruz	2024-12-17 12:20:35
c267a725-7064-4ef2-98aa-3a3567dfc8cb	nzGPnwaKSFc5AK1i0Y5Z	1212	Macchiato	Pastries	4	93.97	2025-04-12 20:50:45	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.cruz12	2025-04-12 20:50:45
3ee0ed28-e573-4435-8970-60de70247d3a	GpW0nz2DTC16ABdolSON	1214	Flat White	Pastries	5	113.21	2025-11-20 10:40:20	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904839663	isabella.delacruz4	2025-11-20 10:40:20
990a1496-e93d-481f-ab76-969dd6e3cc79	4gxUYedyicdf1Z1zO1TC	1220	Flat White	Pastries	5	113.21	2025-06-24 16:56:13	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	ana.rivera3	2025-06-24 16:56:13
7764f6c1-d668-40e1-a27b-c19f7347dd4a	8pDlWhy98cG6qgslAeDC	1221	Cappuccino	Pastries	2	76.25	2025-01-07 23:55:43	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.cruz13	2025-01-07 23:55:43
3c15a10b-9bb8-4d22-ba0b-e5cf6af6384f	VVMlBzfoQUXtaCsvf6UH	1222	Baguette	Pastries	1	133.77	2025-06-26 19:53:34	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.delacruz	2025-06-26 19:53:34
a2235032-b50e-4f72-99c5-d5135231fd1c	T6aURWryqPpHk3rvoOh6	1224	Tea	Beverages	4	106.18	2025-11-18 02:30:49	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904424151	antonio.delacruz10	2025-11-18 02:30:49
0de02641-afb5-4f34-9f32-ba2c2ca8aac7	UyJ6W02gdu7F5aHe5FxA	1225	Almond Croissant	Pastries	1	8.42	2025-07-30 14:59:36	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.delacruz10	2025-07-30 14:59:36
76e58daa-ddc0-4cca-a0db-c22c49cf3d3f	mognWOwm51uXt99gRCBU	1229	Tea	Beverages	3	106.18	2025-02-01 08:16:46	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carmen.santos1	2025-02-01 08:16:46
ff5a3c7b-1fc0-4b3a-b884-1c3c2790565c	z7H0td25AhvCeZDMmv8f	1230	Almond Croissant	Pastries	2	8.42	2024-12-10 20:42:38	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904788240	antonio.santos6	2024-12-10 20:42:38
af219e84-6261-4f71-baa2-1549cb7ad4f9	ASG5YniaMq7EHITRLL6O	1234	Iced Mocha	Pastries	4	144.00	2024-12-16 19:36:43	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904761787	sofia.bautista5	2024-12-16 19:36:43
f90e2a0a-2736-416a-b75c-b5a7a11fe1a5	1x6YPc59S03rioHVZD9S	1236	Hot Chocolate	Pastries	1	131.53	2025-10-29 17:57:34	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	fernando.cruz	2025-10-29 17:57:34
22f93d6b-b1fe-4b2c-957f-925880655fbe	boledhTbP5HNd2Xboo1Y	1238	Mocha	Pastries	4	61.74	2025-10-25 20:39:09	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.cruz	2025-10-25 20:39:09
b017507e-b1f8-41d1-9544-6826e995e0f9	v8JDdZGs9ixpr7Qitygg	1239	Blueberry Muffin	Pastries	4	185.15	2025-09-02 09:07:04	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.cruz	2025-09-02 09:07:04
d9287470-aaee-4d75-bec8-a88b4365d5e6	M99gVzhBGMUM25xX5uBq	1248	Tea	Beverages	5	106.18	2025-10-19 21:38:38	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	miguel.cruz15	2025-10-19 21:38:38
9b2777b7-bb31-4e87-b7a1-088037057ad3	57Haxzk36uoNql4jBZWP	1251	Tiramisu	Pastries	5	196.55	2025-11-01 09:52:25	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	pedro.cruz14	2025-11-01 09:52:25
17b2640d-18c2-41b6-9fed-1f90b0bd8bf6	rduCGKM0yAhJv3X5Rx1U	1252	Apple Turnover	Pastries	5	154.54	2025-05-14 20:38:59	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	sofia.bautista5	2025-05-14 20:38:59
a28ce576-6b6a-4b94-aea1-af8dbd19c8f6	VkpSZ2Y8bc2zh2TAMhXG	1256	Eclair	Pastries	5	146.12	2025-03-12 14:31:55	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.santos6	2025-03-12 14:31:55
e06a77ac-4b5b-46e9-b43c-36ad629d00ef	HzMD9RsQsJh16D97yB7u	1260	Iced Mocha	Pastries	2	144.00	2024-11-30 20:24:14	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	fernando.cruz	2024-11-30 20:24:14
56f69c24-df36-4015-9572-c2535a6b9e99	4uyTyvJso82FgQlWZJZ7	1261	Mocha	Pastries	2	61.74	2025-03-14 21:13:16	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	admin	2025-03-14 21:13:16
f83abd51-0df6-45fd-b753-25dc7f0047de	uFduee5u5e1YWVoKH3cE	1265	Glazed Donut	Pastries	5	148.75	2025-03-15 18:33:59	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904320331	pedro.cruz14	2025-03-15 18:33:59
f4260638-5198-4955-bedf-fac608b5a279	fHZKGSUEwTUZHQXLaVas	1278	Hot Chocolate	Pastries	3	131.53	2025-08-13 10:13:42	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904066920	rosa.cruz13	2025-08-13 10:13:42
e99bd2d5-bd4c-4058-b7a9-1e7bb510240d	UM0B6s8kRNXiV8XBj2cR	1283	Chocolate Chip Muffin	Pastries	5	103.79	2025-07-23 06:47:10	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904211334	antonio.delacruz10	2025-07-23 06:47:10
9108ea7a-5751-4fe8-bc7f-e372ea942cf4	fBBLe4WJOFDBkvfGXbZ1	1284	Tea	Beverages	3	106.18	2025-06-07 18:17:52	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	antonio.santos6	2025-06-07 18:17:52
73c2b40e-0a9d-490d-8d1a-62015208e5ae	HeW2jlJunERpWKraDW4v	1286	Cappuccino	Pastries	2	76.25	2025-10-07 18:44:47	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	fernando.cruz	2025-10-07 18:44:47
c328249f-14f0-44bf-8375-9c434308a687	v8OOD2RNFRGN5Cv4zgUr	1293	Iced Mocha	Pastries	5	144.00	2025-10-31 06:24:54	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904918465	carmen.santos1	2025-10-31 06:24:54
22355528-29a0-4262-8946-033c1a54a907	yjPxGYtUty7txcudBCH6	1295	Blueberry Muffin	Pastries	3	185.15	2025-07-17 17:39:23	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carmen.santos1	2025-07-17 17:39:23
9720c7f8-5e0c-485e-99d2-f8864e69cf76	0uFHU016Q9D6IBtfmBSs	1296	Latte	Pastries	3	108.74	2025-04-05 01:39:47	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	elena.fernandez11	2025-04-05 01:39:47
401b8bdb-faf4-4c4f-ad10-781b9abfcb13	LXU57W6Vzs3UVY5X9P0G	1298	Macchiato	Pastries	1	93.97	2025-08-15 23:04:52	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904584014	elena.torres2	2025-08-15 23:04:52
363aad16-1173-4d15-b2e7-d177797836b5	6Mqtg2Iv9T6hI4ku9fLf	1302	Almond Croissant	Pastries	3	8.42	2025-08-19 23:45:29	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	elena.fernandez11	2025-08-19 23:45:29
d763f334-dcd6-4ff0-96a4-c65ea6bb8189	B5hdWm6mL5YMqqWdq1dA	1306	Tiramisu	Pastries	3	196.55	2025-03-20 22:54:59	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.torres2	2025-03-20 22:54:59
a6c85922-fb6f-4181-832f-65f62f800fe7	pXMDC9CcZoilVlHbrUkj	1308	Apple Turnover	Pastries	1	154.54	2025-07-13 10:32:21	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	fernando.cruz	2025-07-13 10:32:21
bd0c4d94-13a8-4d35-8ce7-f1927a05117f	qg07XQU7z2Bsd5Vomhlv	1309	Chai Latte	Pastries	4	100.50	2025-06-01 07:20:00	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carlos.delacruz	2025-06-01 07:20:00
2196ce5a-0c71-4a43-a82b-e7e762594847	uFjkQAgmzSiF22Xhtb5o	1311	Cappuccino	Pastries	5	76.25	2025-01-08 17:46:03	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904209515	carlos.delacruz	2025-01-08 17:46:03
b581f160-c331-4c59-b37a-4a9c51df1c6e	5xsn1a4hoYKXBlKfjMoB	1312	Macchiato	Pastries	3	93.97	2025-04-22 20:08:01	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carmen.santos1	2025-04-22 20:08:01
2a298fbe-1381-474e-84ea-233bc4e33b42	zxxSh9ASaqr16STunGvJ	1313	Espresso	Pastries	1	195.76	2025-03-23 06:39:53	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904079373	rosa.cruz13	2025-03-23 06:39:53
c34d2271-37fe-4ab7-ae9c-6ac6aff8dc16	rF2fcJEA938coCA52NB5	1314	Flat White	Pastries	1	113.21	2025-04-02 15:25:40	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.cruz12	2025-04-02 15:25:40
6f6716da-c59a-48df-b2b4-fed2fbbbc712	FoDZkAWyN7Y3pF6eGyZJ	1317	Glazed Donut	Pastries	2	148.75	2025-02-23 18:53:04	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	fernando.santos8	2025-02-23 18:53:04
dbe2496d-363f-41c0-b893-b339766d9254	qkCuz1meGUhWBrV5fO6J	1321	Macchiato	Pastries	2	93.97	2025-06-01 15:00:55	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904956568	sofia.reyes9	2025-06-01 15:00:55
1f744c16-4c94-4bd5-a766-1ff41891b553	WXb4Hyw0e69UEZLrK9M4	1322	Almonds	Pastries	3	5.59	2025-04-01 12:27:01	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.reyes9	2025-04-01 12:27:01
03df8f0d-b2b6-4994-8e64-bb5837e65d24	bk21aZqvYOgpmC3wDwuq	1328	Glazed Donut	Pastries	2	148.75	2025-09-25 06:57:51	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	rosa.rivera7	2025-09-25 06:57:51
115d7a80-5963-45fa-b848-918bd31f6567	RwqMvpcqVqtq5rjuAFra	1329	Red Velvet Cake	Pastries	1	187.25	2025-10-16 12:00:29	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.torres2	2025-10-16 12:00:29
8d980266-88e6-4399-9546-59b3f660e192	2I9I3MOJw4kyE0iUEeFP	1330	Flat White	Pastries	3	113.21	2024-12-13 16:31:23	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.delacruz	2024-12-13 16:31:23
906ab6b2-84c3-4640-a18c-933a2a947731	ljYG4EzEWD1q0Yon3miE	1331	Cappuccino	Pastries	2	76.25	2025-06-15 19:04:06	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.santos8	2025-06-15 19:04:06
e109651f-4e44-45d6-a84e-52967c800c7d	mczdwFi5SvlbvtbsbMl3	1334	Iced Mocha	Pastries	3	144.00	2025-03-07 11:22:05	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2025-03-07 11:22:05
abce712f-4dbf-4ba4-9cee-d9462a6736c4	xUA4PCtMId8xeSF5zm6u	1339	Cappuccino	Pastries	3	76.25	2025-08-28 08:57:46	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904956297	carlos.mendoza	2025-08-28 08:57:46
03d2167d-6434-4bc9-b756-360a2b792f0f	8ZDb69zInaydrXAv7ngH	1341	Chai Latte	Pastries	2	100.50	2025-04-06 00:33:19	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904968947	gabriela.mendoza	2025-04-06 00:33:19
6e2f7d83-8837-4f8c-905c-0ae197881cd1	Ye1puKevyOT7L1CgfqmZ	1344	Flat White	Pastries	1	113.21	2024-11-28 04:09:09	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904092365	antonio.delacruz10	2024-11-28 04:09:09
f4a2e684-c943-4e19-9c67-1ac5daa8deaf	7Zli5C1hB43cucILWJKJ	1347	Iced Coffee	Beverages	1	107.80	2025-06-09 10:39:33	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	carlos.cruz12	2025-06-09 10:39:33
35473e4f-80ad-43f6-a1ea-0009dd0e42e7	MqnvMPPjBi9e5Jy0Ktyu	1349	Latte	Pastries	1	108.74	2025-07-16 07:23:23	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904650842	sofia.reyes9	2025-07-16 07:23:23
86197d8f-57f2-4173-8f39-df157961c13f	0HAYvwCAcgVt0qr8Io6U	1350	Blueberry Muffin	Pastries	2	185.15	2025-10-02 16:04:46	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	ana.rivera3	2025-10-02 16:04:46
e1bd9f21-ad4a-4713-a060-20b58a9c1168	MCBQ7Drspflz31Qh4z6Q	1352	Flat White	Pastries	2	113.21	2025-10-11 19:50:08	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904496276	carlos.mendoza	2025-10-11 19:50:08
72bd64aa-b7f0-4e0a-8482-b2830783a91c	BfVXBBVSGGk1T67lhGk4	1353	Chai Latte	Pastries	5	100.50	2025-08-29 10:38:27	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	miguel.cruz15	2025-08-29 10:38:27
e283ff21-0817-42b9-818d-373248b903c6	zBWCeuSZlOVVgZphmP7L	1355	Macchiato	Pastries	2	93.97	2025-07-25 23:33:53	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.santos6	2025-07-25 23:33:53
f6e61320-f8cd-42b1-abd8-cea2761bba98	XGMFVsxRPgLCLVclYiFW	1357	Apple Turnover	Pastries	1	154.54	2025-07-18 01:56:02	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carlos.mendoza	2025-07-18 01:56:02
901296ea-5806-4351-bb08-f599aa2e281b	fs1feRrm6UTd6lTgCnPd	1358	Tea	Beverages	2	106.18	2025-07-16 08:17:24	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	antonio.santos6	2025-07-16 08:17:24
a850d1fa-ca7f-4ff0-bd22-6106a38a39c4	UN2cPozDp6MdpYb3f34f	1359	Iced Mocha	Pastries	4	144.00	2025-03-20 15:07:00	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	admin	2025-03-20 15:07:00
88f95d46-1d64-431b-a580-5d1ede55fc91	ontvpHGcyzrY37mIGBuU	1364	Glazed Donut	Pastries	1	148.75	2025-11-18 11:35:55	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.mendoza	2025-11-18 11:35:55
6edcab5b-55ed-4801-8e87-ce81830188fb	ZNxXdOhFWM6gEAWhfHaX	1365	Flat White	Pastries	1	113.21	2025-07-25 02:57:08	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	fernando.santos8	2025-07-25 02:57:08
f52beb5f-d018-43ea-8252-414143e88859	C3DlOZPeGUdGRZhMYTm5	1368	Iced Mocha	Pastries	4	144.00	2025-06-13 14:28:27	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904471734	rosa.rivera7	2025-06-13 14:28:27
5eeff1e1-b129-4701-9e54-d4af757ae5ef	PjugMdg0Dwyt0P6Ua35T	1370	Red Velvet Cake	Pastries	3	187.25	2025-04-20 07:32:33	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.fernandez11	2025-04-20 07:32:33
9f1c19f7-448e-4800-9db8-892310cc49ae	xbz6lhppps5xMMft5FZN	1372	Almond Croissant	Pastries	1	8.42	2025-03-31 12:10:19	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	sofia.bautista5	2025-03-31 12:10:19
3df95a4f-047a-47fc-b3e3-d6b4ec14c39a	Qs97arH0r7OhrHeUYyz9	1373	Iced Mocha	Pastries	1	144.00	2024-12-27 11:50:46	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904522288	rosa.rivera7	2024-12-27 11:50:46
8a5e09d2-f742-42fa-aea1-f473b698eb5f	hoGWlNiYSKwLTi9UT1cA	1376	Apple Turnover	Pastries	3	154.54	2025-05-27 07:02:36	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904006112	sofia.reyes9	2025-05-27 07:02:36
836bb2b0-7752-4f39-a9ee-59d9586bc09b	2PVlTz3wS3034lYZMUPU	1380	Americano	Pastries	3	80.96	2025-03-17 18:19:42	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904729020	carmen.santos1	2025-03-17 18:19:42
764c36e7-19aa-464c-94af-b63af84a1a01	vsKS16Lino7KqeEqJMpa	1383	Baguette	Pastries	4	133.77	2025-08-10 03:33:23	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.reyes9	2025-08-10 03:33:23
82b9b096-8a65-45de-b430-2644df3c3f60	2rLCG00DBlrTfuEDflAl	1385	Apple Turnover	Pastries	2	154.54	2025-03-23 02:58:21	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	isabella.delacruz4	2025-03-23 02:58:21
51f37247-83e7-4716-a6b3-ad8a8ee9f519	Oc8EVIJQBDNrV1Aguc9O	1386	Baguette	Pastries	4	133.77	2025-10-09 07:45:01	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	pedro.cruz14	2025-10-09 07:45:01
9baa9453-7007-4390-8d2f-4fec4bfad38d	4vaL9NP8o8J2MnD1scQV	1391	Flat White	Pastries	5	113.21	2025-04-29 15:07:53	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904297879	pedro.cruz14	2025-04-29 15:07:53
7125d44d-2a50-418f-b87b-5ddb68a6bd3a	avusd5rAhYHelMcVasry	1392	Almonds	Pastries	3	5.59	2025-06-26 23:32:54	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904833576	sofia.reyes9	2025-06-26 23:32:54
191c90e7-f471-4b1b-90a8-248358ed353d	DmQ5BQJwki6ECKvsPRCZ	1396	Mocha	Pastries	3	61.74	2025-04-13 16:35:37	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	elena.torres2	2025-04-13 16:35:37
78e767bb-260b-4ac8-8ef2-4eb2c54a26e7	YOatYmO0crcokd48ecW8	1398	Iced Mocha	Pastries	4	144.00	2025-01-29 23:32:57	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904809953	pedro.cruz14	2025-01-29 23:32:57
5b8d7a4c-2f19-476e-89f5-c4677e91d96e	OZoR6bfC9lyvRcvy3qcI	1399	Almonds	Pastries	5	5.59	2025-08-31 22:21:12	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	pedro.cruz14	2025-08-31 22:21:12
99601731-3ae3-4717-93a2-d8a7485c9366	j6Q3MkbXO6ej6TPwhaLe	1407	Glazed Donut	Pastries	1	148.75	2025-02-21 19:30:49	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.mendoza	2025-02-21 19:30:49
62e96201-3eb6-414a-8858-ef47a83903c0	sGvP7QCQw71kOBo0hdU5	1412	Tea	Beverages	2	106.18	2025-09-07 08:34:59	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904003237	carlos.cruz12	2025-09-07 08:34:59
023219fc-20be-4a1c-9e01-1eb39f565e48	XSm9tePBofV9mmRawl3G	1416	Flat White	Pastries	1	113.21	2025-05-11 23:44:43	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.delacruz	2025-05-11 23:44:43
7e8e1e8a-6e25-4102-ac57-5877544c7dba	dxZXYbsNep8i6L3v9ayf	1420	Baguette	Pastries	1	133.77	2025-03-24 03:26:26	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.torres2	2025-03-24 03:26:26
35124720-d985-4875-9347-78ec43b5b5f3	PsYLMXO5BAcwsHq0TgbH	1423	Glazed Donut	Pastries	1	148.75	2025-01-22 13:09:51	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904227079	carlos.cruz12	2025-01-22 13:09:51
41af73ce-9c66-40f1-b71d-81f0ea46bc67	rnYAx6d10jU03lrd3TB2	1425	Flat White	Pastries	4	113.21	2024-12-02 14:41:14	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	isabella.delacruz4	2024-12-02 14:41:14
c95871ef-7c3e-446f-9ff3-d084ed3c672d	IW0z64IcEdAcapVmW2xU	1435	Flat White	Pastries	4	113.21	2025-02-05 05:01:42	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	antonio.santos6	2025-02-05 05:01:42
3d301052-f693-40dc-8a81-e617caddc39d	g8kRyl32141B751zNZgH	1437	Hot Chocolate	Pastries	2	131.53	2025-05-01 21:40:45	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carmen.santos1	2025-05-01 21:40:45
aed954f9-ef98-4c95-a308-9f27fa646585	XJPpNahqRgsBKKJQ0dHQ	1440	Baguette	Pastries	4	133.77	2025-10-08 18:08:40	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.cruz12	2025-10-08 18:08:40
7866cfb7-452c-4465-a15a-5f6a84bffdf5	MwDBVQboMtMaruETwFiQ	1442	Red Velvet Cake	Pastries	3	187.25	2025-11-16 19:21:07	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	ana.rivera3	2025-11-16 19:21:07
a2d29925-e53b-47db-9cb2-6e70dfbf4c3a	oApEMBsnTWhGCtMeKPzC	1444	Cappuccino	Pastries	3	76.25	2025-08-24 00:55:39	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904223266	carmen.santos1	2025-08-24 00:55:39
b0d0da60-ee7c-4602-b890-fa2da5dacd0e	UCMVkCzoWPubmMOo15cZ	1445	Glazed Donut	Pastries	2	148.75	2025-03-03 12:18:51	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904789299	carmen.santos1	2025-03-03 12:18:51
4bb1743b-5a54-4263-a8fc-7917ae6b065e	UrVzcfXtxQv4eozN3PaW	1446	Latte	Pastries	1	108.74	2025-01-12 14:13:58	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	miguel.cruz15	2025-01-12 14:13:58
5890d84d-5339-483e-9ba4-3e1030ad0b98	UFpd9IQYgYitcRuJRMZn	1458	Latte	Pastries	5	108.74	2025-09-09 20:11:14	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904471284	carlos.cruz12	2025-09-09 20:11:14
b1e7bad2-1608-4ff1-9884-6ef6e41daeb6	oy2X8TFbhrg7PPnKqtc2	1461	Iced Coffee	Beverages	2	107.80	2025-07-05 10:00:54	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.bautista5	2025-07-05 10:00:54
86438d40-8061-48ef-a665-e87fa99df331	pEHkhMJ6Q5pPdEa5SoSa	1463	Mocha	Pastries	4	61.74	2025-02-27 02:16:37	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	isabella.delacruz4	2025-02-27 02:16:37
48a11b7a-0bb6-477e-9f9b-0fb2785036a1	RJry06BAqN9RgTYp6f2h	1464	Chai Latte	Pastries	1	100.50	2025-09-07 17:06:45	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904103770	miguel.cruz15	2025-09-07 17:06:45
7c2cee50-c636-4dc8-8fae-4ce4cdc46517	ylrOGbVLmDF8KDHZHCXn	1466	Iced Coffee	Beverages	4	107.80	2025-08-28 15:46:11	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	miguel.cruz15	2025-08-28 15:46:11
8489411b-4320-435e-81fd-615de5f48e24	Gij4hCUqr1f0zeYAoeSD	1468	Almonds	Pastries	2	5.59	2025-04-01 05:51:01	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904043296	rosa.cruz13	2025-04-01 05:51:01
699a9489-7b99-4173-a6ce-c7ac8cae2886	PzzTDLmfO5BHxdZbrkub	1472	Flat White	Pastries	1	113.21	2025-04-19 03:14:40	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.fernandez11	2025-04-19 03:14:40
a0a41e89-c37e-4a19-ae1a-22cb5c8709e7	adhdcApPMrtalG6YXUd7	1476	Tiramisu	Pastries	3	196.55	2025-04-25 21:19:11	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.cruz12	2025-04-25 21:19:11
48e4a057-335a-456e-9875-c3d3a45499eb	3scmksms8wbMX1rsIhqI	1478	Tea	Beverages	2	106.18	2025-01-05 09:52:29	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	antonio.delacruz10	2025-01-05 09:52:29
7f01ef71-5609-466d-a619-f31e30eff5de	ubMdZPcWlEEnO4pSQmA3	1490	Espresso	Pastries	2	195.76	2024-12-23 17:36:53	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	sofia.bautista5	2024-12-23 17:36:53
a49ec0fb-e889-4a48-be0a-4655c4d688c0	sh0W48JbQMxaXjAsu42g	1492	Apple Turnover	Pastries	4	154.54	2025-03-30 17:07:46	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904768756	pedro.cruz14	2025-03-30 17:07:46
321f7654-3cc5-4a07-8fdd-8b80589c5739	I0BTcu3AfGu7Ibxw4BLU	1497	Iced Mocha	Pastries	4	144.00	2025-03-28 18:17:10	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.cruz12	2025-03-28 18:17:10
ddd2845f-b35a-446b-bcac-91cf64941174	Hfeizz2nl49t8r2SrzlL	1500	Chocolate Chip Muffin	Pastries	3	103.79	2025-01-11 00:06:17	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.cruz13	2025-01-11 00:06:17
dd003a21-0a2b-42e6-b8cf-ef20c384b188	Q8b0wOIub4cYaq2Xm6eu	1504	Hot Chocolate	Pastries	2	131.53	2024-12-13 06:51:10	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904484543	elena.fernandez11	2024-12-13 06:51:10
4caaf86a-4931-4a73-a3bd-cac9aa76f2c1	GuxbmFgchDtETS3VHsHU	1507	Apple Turnover	Pastries	5	154.54	2025-06-22 21:39:56	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carmen.santos1	2025-06-22 21:39:56
1b946ac6-57cc-4d32-9b0e-afd031753017	DnwkxgHuBKgd70xK0twy	1514	Apple Turnover	Pastries	3	154.54	2025-02-17 17:02:22	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	rosa.rivera7	2025-02-17 17:02:22
0fd69696-39a8-47ed-bff2-defe36d94bf5	gMXXarD9qB0WdlZXPBK3	1516	Apple Turnover	Pastries	2	154.54	2024-12-11 09:40:42	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904311335	carlos.delacruz	2024-12-11 09:40:42
8f794acb-96d7-4768-ac80-c76c4d1cac84	quaDDA9vatyUU8ESOcMC	1524	Glazed Donut	Pastries	4	148.75	2025-07-16 20:28:57	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.bautista5	2025-07-16 20:28:57
a1fcfcb8-9313-43f2-ae90-0bfc3fda3183	1GLx3al0kBr1SH4ZJnkp	1530	Macchiato	Pastries	3	93.97	2025-04-23 14:24:19	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	fernando.cruz	2025-04-23 14:24:19
19dff710-4713-482f-ba66-f9dcaa90df7d	ptc3Nrj2iHtTqCws5Cj8	1534	Baguette	Pastries	4	133.77	2025-08-26 05:40:45	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183904593375	miguel.cruz15	2025-08-26 05:40:45
be5389fe-b549-422d-99ec-a6625f2e6518	7biWLzLUy84lTJlezL4S	1537	Iced Mocha	Pastries	2	144.00	2025-07-31 23:17:28	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904947873	elena.fernandez11	2025-07-31 23:17:28
03597d86-e202-4733-9607-a2a341930fd5	98g320ucBXt9LKm3Rmpm	1542	Cappuccino	Pastries	5	76.25	2025-09-12 03:49:32	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.rivera7	2025-09-12 03:49:32
0e057b04-b503-4fe5-978e-8f59619b85e6	uKHsam7nWed9Py3zYMUK	1553	Macchiato	Pastries	4	93.97	2025-01-05 16:47:47	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	rosa.cruz13	2025-01-05 16:47:47
1ff949ca-31d5-45c7-8463-9c3c4032165c	ecdmUnyYuPWB7OjtMKBU	1555	Baguette	Pastries	5	133.77	2024-12-07 20:32:46	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.reyes9	2024-12-07 20:32:46
859c5951-de5c-4a9e-94ba-6c8c1fe6b5bd	zrLsB8yzX6ibriE3y1Or	1557	Baguette	Pastries	1	133.77	2025-09-14 14:36:43	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183904897773	fernando.cruz	2025-09-14 14:36:43
ae742393-ce75-4b8e-bc54-a7b3da66f01c	hYC8BjdWzD57roPE56ar	1561	Baguette	Pastries	4	133.77	2025-10-13 05:53:00	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.reyes9	2025-10-13 05:53:00
bfe3cb38-35cc-4feb-960f-0b29375e0190	JbNtCgpFyWukZnLqrkcx	1562	Chocolate Chip Muffin	Pastries	1	103.79	2025-04-22 02:51:27	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.delacruz	2025-04-22 02:51:27
dfc74ba3-032b-4471-8614-972bc673567c	oaKSgeLDu5CxsYkleJD9	1563	Cappuccino	Pastries	4	76.25	2025-10-05 03:49:01	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carmen.santos1	2025-10-05 03:49:01
90e0c3c3-d9df-46fe-a8ad-fc4a377b5219	JCcrVlzNPynbe7m9WXfP	1564	Latte	Pastries	2	108.74	2025-08-09 23:19:32	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	elena.fernandez11	2025-08-09 23:19:32
aa4655f5-caaf-4a18-9da8-09cc86ced479	raWrXSYWhryjKYbcXOjL	1570	Eclair	Pastries	3	146.12	2025-08-03 06:18:15	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904769155	rosa.rivera7	2025-08-03 06:18:15
74ddf5bd-7d82-4288-86d3-8864a6d2eb5f	\N	\N	Almonds	Pastries	1	5.59	2025-11-25 03:40:45.528145	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2025-11-25 03:40:45.528145
6c70f9e0-144b-4642-af86-79ded6467df8	TDDqu7l1qBCvEnXtgb64	1579	Almond Croissant	Pastries	2	8.42	2025-09-14 04:35:08	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	pedro.cruz14	2025-09-14 04:35:08
51019bec-e741-4d1c-a279-09e6d5a04130	mlE2mMBx0EV0CMHYBLDw	1580	Mocha	Pastries	3	61.74	2025-08-18 09:36:25	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.cruz	2025-08-18 09:36:25
0f0b7d66-f0b0-40fb-a42f-3d295fe1d680	a6beZ8oVymfvHLLiF40x	1581	Eclair	Pastries	2	146.12	2025-04-16 08:47:31	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	carlos.delacruz	2025-04-16 08:47:31
5ffd4426-27fe-4a95-8f21-258f7d1bc6c0	cWhf6mksZ0ISeSVBtFkX	1585	Cappuccino	Pastries	2	76.25	2025-10-10 16:35:04	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904709891	sofia.reyes9	2025-10-10 16:35:04
609c10ab-c057-4728-a071-aa97bbfbc59f	WE3Q4mUVw3f8RbUU6lTh	1586	Hot Chocolate	Pastries	2	131.53	2025-11-09 19:21:16	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	fernando.cruz	2025-11-09 19:21:16
81bebc0f-8de6-408f-acc0-57a25881a936	uT9nQvrrLJgokamoEwHb	1587	Americano	Pastries	2	80.96	2025-08-28 12:31:32	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	carlos.delacruz	2025-08-28 12:31:32
6007c22b-bba4-4339-883c-f062cb4498ad	ypcWW8lchoaDfFuMWDI6	1588	Tea	Beverages	5	106.18	2025-07-26 22:59:42	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	sofia.bautista5	2025-07-26 22:59:42
7e128579-c635-456e-92b9-4465d406cd42	2gP4nsevTb6shqrMAeM4	1590	Eclair	Pastries	3	146.12	2025-04-06 11:42:46	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.cruz12	2025-04-06 11:42:46
57c7e313-835d-4280-9677-1545ef285b88	lvsu5vL3xJu7SMkDnx5T	1593	Tiramisu	Pastries	1	196.55	2025-05-01 06:05:23	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904243185	fernando.santos8	2025-05-01 06:05:23
82a747c7-ee0d-4e87-a6b8-bdb1a6b77d57	f3pA93niq8UlMZmnDYpV	1600	Glazed Donut	Pastries	5	148.75	2025-02-23 06:48:41	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carmen.santos1	2025-02-23 06:48:41
caa3e7d7-4a21-44f6-8710-86ca53eb9407	0yq2sVL6I2kpCs8CswtD	1602	Blueberry Muffin	Pastries	1	185.15	2025-06-11 00:34:59	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904444753	carlos.mendoza	2025-06-11 00:34:59
71d6572c-615b-4660-8c30-b5e1062b3ac2	tXwPQAXI3YImgtxThVK5	1603	Chai Latte	Pastries	4	100.50	2025-02-02 12:40:15	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904194968	sofia.reyes9	2025-02-02 12:40:15
b8d128ff-ea43-44d9-a210-83fadd1a7667	a3HnsAQNqdqlMbNJqs9v	1605	Blueberry Muffin	Pastries	1	185.15	2025-04-04 03:17:09	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	admin	2025-04-04 03:17:09
03eef631-69e7-4b89-98f4-4e962895f6b3	JC4oxtLKqUytDziiy8b9	1606	Chai Latte	Pastries	2	100.50	2025-02-16 14:02:10	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904086105	elena.torres2	2025-02-16 14:02:10
bfa9fdc0-4c60-4d8b-b13b-fe2edd22191b	yL0zmrCxYI9KeoXDCNao	1608	Mocha	Pastries	3	61.74	2025-02-08 23:40:50	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904844439	rosa.rivera7	2025-02-08 23:40:50
6aeb88ab-3d97-4a00-870e-21b63b507b2c	1A648wrbgqpigh8qADg1	1609	Baguette	Pastries	2	133.77	2025-02-01 06:16:39	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	antonio.delacruz10	2025-02-01 06:16:39
540e2a9a-1482-440c-9b4d-79244a422e78	8ywl8OPsgvC71dS8OcL3	1611	Flat White	Pastries	1	113.21	2025-01-04 20:13:04	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904509053	fernando.santos8	2025-01-04 20:13:04
c99d16ea-2a5e-4c26-a101-0d3f001745ff	oE17zEC2PVusGFTKTUlN	1612	Chai Latte	Pastries	3	100.50	2025-09-20 20:31:42	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904363485	isabella.delacruz4	2025-09-20 20:31:42
0e0f0c8f-2a9d-4e02-8831-e7cbcbdacd22	A5DarX54v3ydtNDa2Sle	1614	Chai Latte	Pastries	3	100.50	2025-04-06 21:47:51	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	ana.rivera3	2025-04-06 21:47:51
b94dd805-b06d-42ef-9d94-c0796b4df684	TRuOw9EjWWFsIx5J51o4	1618	Cappuccino	Pastries	5	76.25	2025-09-05 15:01:21	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	rosa.cruz13	2025-09-05 15:01:21
eb24b53e-0aa2-4c62-afb2-36999f1b1581	upAKrm54d0OA1mPqTjQH	1619	Macchiato	Pastries	5	93.97	2025-11-13 00:46:59	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904252529	carlos.mendoza	2025-11-13 00:46:59
5b576f41-2331-4bfd-b5af-a57720a62006	IB21mzdpoWg5nd9JWi7G	1621	Iced Coffee	Beverages	5	107.80	2025-04-11 06:47:04	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904875562	isabella.delacruz4	2025-04-11 06:47:04
109486e0-7e80-461d-9028-16bd6d6f9534	qmGSoHZOdtiwryGrYxzS	1622	Tiramisu	Pastries	5	196.55	2025-04-22 13:50:13	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	rosa.cruz13	2025-04-22 13:50:13
9dfbedc3-5c9e-4666-8227-cf1c504fc1ee	jrY56PwXARbHGijqpIQh	1623	Flat White	Pastries	1	113.21	2024-12-09 15:35:19	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.cruz12	2024-12-09 15:35:19
73f3921b-b19b-471f-a5f3-ef30334e4fa3	sNhRYjkCXcqyGbAwgJ7Q	1629	Espresso	Pastries	1	195.76	2025-01-13 03:42:21	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.delacruz10	2025-01-13 03:42:21
a7ffb456-4caf-4813-9ccf-2237818980da	vMaIQ8u0dTwuw3IIEy0N	1630	Mocha	Pastries	2	61.74	2025-08-02 17:39:05	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	ana.rivera3	2025-08-02 17:39:05
593ade78-8ef4-4b9e-abf5-a91ad0c75425	iWuNwfkf6Jzgf7sKFIWn	1633	Cappuccino	Pastries	2	76.25	2025-04-12 07:13:38	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.santos6	2025-04-12 07:13:38
2bac8300-977c-4696-88f9-35c6a6857066	5QYoxekm5JJpvp3MDGoV	1634	Mocha	Pastries	2	61.74	2025-03-27 07:57:35	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904347034	rosa.cruz13	2025-03-27 07:57:35
6c13ff58-fa5f-4cb2-8c14-a05d2c77b248	Vovh17FzgyMKVpJMwTjy	1636	Flat White	Pastries	3	113.21	2025-08-19 15:35:47	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904470353	antonio.santos6	2025-08-19 15:35:47
3834348c-3cfe-448c-a65e-cd888b748b16	uTCwvT9ddUdhXW9J8zZB	1647	Iced Mocha	Pastries	5	144.00	2025-04-18 03:00:26	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904415447	carmen.santos1	2025-04-18 03:00:26
cdc2cb39-df4d-40c9-ac61-c2412c9219dd	l7ihFEQCJhO4R5R5mxdv	1654	Chai Latte	Pastries	5	100.50	2025-05-18 02:28:22	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	isabella.delacruz4	2025-05-18 02:28:22
92cdf740-d03b-4472-a855-34c7aea37c95	QNPYiyPTWLLW6uDJub7q	1664	Mocha	Pastries	4	61.74	2025-02-23 23:04:07	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904751375	carlos.mendoza	2025-02-23 23:04:07
8f76ebf1-5008-4473-a340-cefc5a79883f	g3PgbbXucrqt1CtoFH7z	1665	Eclair	Pastries	4	146.12	2025-02-13 00:20:34	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904454256	carmen.santos1	2025-02-13 00:20:34
4ba9155e-d780-4cf7-a211-69aa32f9a4e5	jjDPSJn61WmuOwfuBB2v	1667	Espresso	Pastries	2	195.76	2025-08-14 06:57:27	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	isabella.delacruz4	2025-08-14 06:57:27
c7a90c93-88c3-472e-b607-447ca650d75a	iuLf6064zBB5EudfMnjv	1668	Latte	Pastries	3	108.74	2025-09-26 09:40:05	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.cruz	2025-09-26 09:40:05
e32d9aa5-462e-47b7-ba2f-bda39935b408	W8ZptnrUq9uI66FE0qtx	1671	Blueberry Muffin	Pastries	1	185.15	2025-02-16 22:50:54	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.cruz12	2025-02-16 22:50:54
efbed9c6-1684-4e1c-bb56-6d11592ad28c	57SXcWeCJ5hCspqWkM9B	1672	Americano	Pastries	3	80.96	2025-03-09 14:32:00	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carmen.santos1	2025-03-09 14:32:00
516670c5-6589-4723-8538-37000ca7cf63	uRWlVfZ7tX7TnO4XM1p2	1674	Mocha	Pastries	1	61.74	2025-05-15 16:56:42	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904920035	carlos.delacruz	2025-05-15 16:56:42
80d72a24-56c2-4982-80ef-7c94ce6a9ca4	Uzs6Sn2TVEn8UQqaZOk2	1690	Almond Croissant	Pastries	4	8.42	2025-08-07 22:41:56	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	fernando.santos8	2025-08-07 22:41:56
299dcef0-d17a-4a48-a820-f33daf5416c6	FDBJl6zshTgSDYeDdRPk	1691	Iced Mocha	Pastries	4	144.00	2025-07-07 19:44:57	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	miguel.cruz15	2025-07-07 19:44:57
243949e4-48f9-4cec-9716-77068f754a34	HxJ2MuWltLdTn3fALhL7	1692	Glazed Donut	Pastries	2	148.75	2025-08-20 23:11:03	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	rosa.cruz13	2025-08-20 23:11:03
c7d3e5c2-614d-4450-afa9-2a8d1f4d56d7	ukiXIwQGnk6fsg8miblz	1697	Iced Coffee	Beverages	3	107.80	2025-04-18 23:41:08	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904077193	ana.rivera3	2025-04-18 23:41:08
ea37ad0d-6d87-4b97-b1ae-af5cf2c01f9e	vOwqGOPtANeJZv65tDM3	1701	Flat White	Pastries	2	113.21	2025-04-06 01:27:51	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904289319	miguel.cruz15	2025-04-06 01:27:51
2c1c6e9b-67d1-4a0d-9dbe-fbb840dac173	TfyCBcbsHZ2IQlAcT4ML	1710	Espresso	Pastries	1	195.76	2025-06-17 02:54:50	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	isabella.delacruz4	2025-06-17 02:54:50
0b31f77f-0d84-4267-90a5-d951526c3f48	yJbMkQEy42C0wAqwNhDV	1721	Espresso	Pastries	4	195.76	2025-09-22 04:36:42	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904672171	carlos.cruz12	2025-09-22 04:36:42
918f8f22-16da-4a54-aea2-193b190d1db2	NNcGeFxA02I2aRZyjZfc	1731	Apple Turnover	Pastries	1	154.54	2025-05-10 03:47:49	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.torres2	2025-05-10 03:47:49
818aa823-b0fa-456b-a43a-d29fa599f3a9	2XvveVwGvmMM866YeqA3	1732	Tea	Beverages	5	106.18	2025-05-07 21:12:17	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	gabriela.mendoza	2025-05-07 21:12:17
a330d8d4-a79a-4702-9526-d3eb8bd03a41	f8wONXhvHE3q7l2BhW1L	1733	Hot Chocolate	Pastries	2	131.53	2025-08-06 19:45:49	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carmen.santos1	2025-08-06 19:45:49
12a8c4e2-78ab-432f-aa40-82b9ad286c90	qop0bBs8gkhVdL0NN3SZ	1734	Tea	Beverages	4	106.18	2025-05-15 03:42:03	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904652700	fernando.santos8	2025-05-15 03:42:03
f335e372-b745-4acc-b741-ea631d565a44	kyHlUEAS59RYaNqqAgqN	1735	Tea	Beverages	5	106.18	2025-08-17 10:46:19	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904453263	rosa.rivera7	2025-08-17 10:46:19
3249288b-58f5-498b-85ac-8cd43fc1c68f	8FHbtxUlGg41uOvzL4HD	1737	Baguette	Pastries	1	133.77	2025-04-04 21:09:02	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.delacruz	2025-04-04 21:09:02
caa4c428-00f0-45a1-851b-2a17c88ef2ab	1TSCi5PFhrAgOn0kihKF	1739	Glazed Donut	Pastries	2	148.75	2024-11-25 05:58:25	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	pedro.cruz14	2024-11-25 05:58:25
cd905b44-85d7-4ed1-8198-351e26b7f506	k5JrysymRXjPYYAaYU26	1740	Glazed Donut	Pastries	4	148.75	2025-06-23 04:35:37	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.mendoza	2025-06-23 04:35:37
33eaa0a5-bc89-4cfc-8394-eadef3be7f56	iznxFOC2WYxuckoo1rbT	1746	Chai Latte	Pastries	1	100.50	2025-09-06 13:09:07	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.bautista5	2025-09-06 13:09:07
88327ff4-c489-4999-a8e5-f20e96d81508	3NZcJXmrwhI7cI7u778u	1747	Mocha	Pastries	5	61.74	2025-11-23 19:17:42	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	admin	2025-11-23 19:17:42
818a5176-0038-445c-ada4-c59429c55b4b	hiYC0KxfETpR7XIvRqL8	1751	Tiramisu	Pastries	4	196.55	2025-08-09 13:02:54	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	fernando.cruz	2025-08-09 13:02:54
fc96e92c-2bc1-4b6f-ad4d-2bd69c80e39a	H8rWj3hwoaE0I2PupO8h	1752	Hot Chocolate	Pastries	3	131.53	2025-01-24 15:49:24	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	antonio.santos6	2025-01-24 15:49:24
2304186c-85ed-4ea4-8542-0f76ec949a99	IIinNiIhATh68T7TdVzh	1758	Flat White	Pastries	5	113.21	2024-12-25 21:23:23	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904521893	fernando.santos8	2024-12-25 21:23:23
c4561842-a9fe-4d24-9179-e6178ffbf71a	iFcK56RR88GdyA97p1d2	1763	Baguette	Pastries	3	133.77	2025-09-20 07:23:16	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	rosa.cruz13	2025-09-20 07:23:16
0e04682a-6451-4026-b713-4751426f122f	Z1TaBlWkSc2MWjACYcnO	1765	Iced Mocha	Pastries	3	144.00	2025-11-10 11:08:35	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	isabella.delacruz4	2025-11-10 11:08:35
816b72ee-a8a7-4b8e-bc1e-2faeccbd5fad	Dz3XsjyCWczX4bkWp2Va	1768	Blueberry Muffin	Pastries	2	185.15	2025-09-20 23:53:32	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	isabella.delacruz4	2025-09-20 23:53:32
4ab89718-0b24-4158-8738-e73c427e8071	4v3KfgAoX7J8rAWo2PkZ	1770	Iced Mocha	Pastries	5	144.00	2025-03-22 09:40:20	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904413353	antonio.delacruz10	2025-03-22 09:40:20
9da24204-4480-4f0d-82bd-a45ec763ac4f	77J0cfzrnXKDoUAoykXW	1774	Iced Coffee	Beverages	2	107.80	2025-02-06 12:19:49	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carmen.santos1	2025-02-06 12:19:49
f5fc12ba-7dd9-4f07-858a-1c87a200f9a1	gbB6oefF6oM3fe7mzp0g	1775	Chocolate Chip Muffin	Pastries	3	103.79	2025-07-18 06:15:36	996934ff-5758-44b4-ad0e-4ed9d927901e	Card	\N	elena.fernandez11	2025-07-18 06:15:36
24066c7c-a914-402b-a65a-54ee5d1ae627	8BFasFOBhFUCypRbqbyN	1777	Iced Mocha	Pastries	3	144.00	2025-07-23 16:43:25	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.delacruz	2025-07-23 16:43:25
22625482-ace4-4f1b-bb78-0da8e340a3d6	VsN0iEmu9MInGjItLg1M	1779	Hot Chocolate	Pastries	2	131.53	2025-05-23 08:54:39	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	antonio.delacruz10	2025-05-23 08:54:39
4e1b135a-4009-4711-b520-a1cd6213b085	u4OMMRyTBsCDhYl6TrZQ	1781	Glazed Donut	Pastries	1	148.75	2025-05-14 06:04:44	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904112866	carlos.mendoza	2025-05-14 06:04:44
09da99b3-8de9-48a1-b28a-aa275db44028	XTeHSdtiStHNVkxEbAoC	1783	Almond Croissant	Pastries	1	8.42	2025-11-19 22:36:06	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904082179	antonio.santos6	2025-11-19 22:36:06
b920a613-3f6c-4e1f-9613-067a777fa2a5	dRTReQYt8UA1EAeLFEQA	1784	Apple Turnover	Pastries	3	154.54	2025-04-22 00:23:54	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904581106	fernando.santos8	2025-04-22 00:23:54
dc96cfcf-998c-40d1-9ae2-35083e71fe75	TmAoza4cFgiyaUZHjyn0	1786	Eclair	Pastries	3	146.12	2024-12-05 23:29:55	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	sofia.bautista5	2024-12-05 23:29:55
5cb7b1dd-77bb-4603-9362-bf44f7ee2697	cSlxFftkLRCYNfL35Mdd	1787	Eclair	Pastries	2	146.12	2025-03-30 05:17:32	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.santos6	2025-03-30 05:17:32
9eac470b-3be1-4897-be10-f6a6d3afa6d7	1UlQ5NRZRdd9MPpVIi6m	1789	Americano	Pastries	4	80.96	2025-05-06 01:11:29	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904184465	rosa.cruz13	2025-05-06 01:11:29
67518a4a-2b01-42b1-8410-d0f7018ff7b4	Z1k3QWwt66gtc92rKNBl	1790	Red Velvet Cake	Pastries	4	187.25	2025-08-28 14:04:47	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	gabriela.mendoza	2025-08-28 14:04:47
602da327-42c1-4dbe-aa70-de8dd1511b7a	2D8Ud4s4GtF3HrTJpL5o	1794	Cappuccino	Pastries	1	76.25	2025-04-04 12:29:49	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.torres2	2025-04-04 12:29:49
18df88bd-fc8a-4b8c-abfe-9c4dd8e03f3f	UlIOGgnMyl777zScCdZo	1796	Apple Turnover	Pastries	5	154.54	2025-11-10 23:24:33	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.torres2	2025-11-10 23:24:33
d7986fcd-e30c-4cb9-8ba2-095ea43084b3	qaKWGnD4ngLXN8TgPIzG	1800	Espresso	Pastries	3	195.76	2024-11-24 00:11:55	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	sofia.bautista5	2024-11-24 00:11:55
4441eab1-889c-41fc-a29b-fda779bfdb0c	hLEwahKWkukHFlEkmh0q	1802	Almonds	Pastries	2	5.59	2025-05-03 03:01:47	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.mendoza	2025-05-03 03:01:47
8762dd23-997d-47ad-bfe1-51e401933e88	yCidDT1PRxGPWlZwDR9e	1807	Red Velvet Cake	Pastries	1	187.25	2025-09-07 05:21:54	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904788820	ana.rivera3	2025-09-07 05:21:54
571af937-51d6-4150-80d2-aad30c3bd1ea	UoQs6s76UOnfCgoX9asA	1809	Chai Latte	Pastries	4	100.50	2025-11-03 18:19:21	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	elena.torres2	2025-11-03 18:19:21
13abc672-c858-492e-ba6b-430e263af3c1	Zg9ukfgAaBBIFsPJzphQ	1810	Iced Coffee	Beverages	2	107.80	2025-09-08 01:17:22	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904191590	carlos.mendoza	2025-09-08 01:17:22
ff5457ec-b7c9-4273-8015-2308f62ebc7c	BM39OPOaK77CwhLWIMU3	1813	Blueberry Muffin	Pastries	5	185.15	2025-05-23 19:06:21	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904131089	carmen.santos1	2025-05-23 19:06:21
21fff450-cab1-4cfb-8e9b-0e4a3f2e0d35	f90E05A9VXDOCZWBonra	1815	Chocolate Chip Muffin	Pastries	2	103.79	2025-09-07 00:26:18	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	elena.torres2	2025-09-07 00:26:18
33ab20b5-2e86-4856-b029-1631e3c14a5f	SXUpiHWnrZ2O3UcG7ITW	1819	Apple Turnover	Pastries	5	154.54	2025-03-07 18:55:26	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904126177	miguel.cruz15	2025-03-07 18:55:26
96a32b81-264e-4f67-80d0-a90d48bea9d0	vWhbiMKuJBfpr84dIeJO	1824	Almond Croissant	Pastries	5	8.42	2025-02-25 00:47:37	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904212904	antonio.delacruz10	2025-02-25 00:47:37
4b95cd5a-c9fb-4892-9404-6144f1387105	74Y44ay7VGTw3dZkhS4Q	1826	Espresso	Pastries	2	195.76	2025-06-06 08:58:43	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.cruz12	2025-06-06 08:58:43
fb97968e-267b-4d0f-a9aa-9bdcaa6278c4	Kx1iATru45CBZZA8Jpkj	1828	Red Velvet Cake	Pastries	5	187.25	2025-10-03 00:33:08	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904680717	pedro.cruz14	2025-10-03 00:33:08
f77ab6e7-c8d3-472a-9778-681597ce9a4a	gWXp3rmsmcoQNbVLog0y	1830	Blueberry Muffin	Pastries	2	185.15	2025-03-10 22:43:31	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904478529	carlos.mendoza	2025-03-10 22:43:31
15a2e50f-628b-42b0-b3ac-ce34fac6c4d0	7rYxWJQng2rmOYecuiey	1833	Iced Coffee	Beverages	1	107.80	2025-08-08 03:08:33	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904306690	elena.fernandez11	2025-08-08 03:08:33
14cd86b0-6099-44d5-80af-bd138953d073	qBOgvhFCU7Fzg7XoDkKS	1835	Iced Mocha	Pastries	4	144.00	2024-12-19 15:59:52	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	fernando.santos8	2024-12-19 15:59:52
55a877fe-e436-45b6-97dd-1f1002a791b5	1wlhWjo63JwatNvZq8AN	1836	Latte	Pastries	2	108.74	2024-12-06 18:25:00	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	pedro.cruz14	2024-12-06 18:25:00
ea4f8701-8369-4dc6-812e-8bccd406871e	7Zqt0ZZWIqDsiKqf67Vq	1837	Espresso	Pastries	2	195.76	2025-09-01 16:52:12	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	sofia.bautista5	2025-09-01 16:52:12
3add30ce-6b2e-43dc-8ff1-129f950bf953	ThiJB7JJkofIXuHLooOX	1839	Chocolate Chip Muffin	Pastries	2	103.79	2025-09-05 05:18:17	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904386183	sofia.bautista5	2025-09-05 05:18:17
97597b08-0a52-4ece-a32e-644b7342f8c6	jhs9fdtoY3BySAQmop52	1843	Red Velvet Cake	Pastries	1	187.25	2025-07-06 07:52:05	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	gabriela.mendoza	2025-07-06 07:52:05
f4177b11-c989-4e0f-b781-4ec0242e55ff	d5Scd50bWIQCgxMadR1I	1847	Almonds	Pastries	3	5.59	2025-04-02 13:18:01	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	elena.torres2	2025-04-02 13:18:01
5e6beec1-5984-4201-90cf-4122814e4424	jDJcLsFmg0gphA2L39JH	1848	Almonds	Pastries	1	5.59	2025-03-11 13:11:35	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.bautista5	2025-03-11 13:11:35
ab52ea96-4c58-47aa-9fa1-e527b9808323	KUc6kHFp5fTXlkTJIkGQ	1849	Hot Chocolate	Pastries	5	131.53	2025-04-28 05:01:03	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	sofia.reyes9	2025-04-28 05:01:03
0f2730a9-ab25-4bb4-bf2d-6b8914d73f83	hC4kja37JoGUqPmBC4I8	1852	Glazed Donut	Pastries	4	148.75	2025-02-23 13:04:57	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904544365	antonio.santos6	2025-02-23 13:04:57
f9bbda58-1cec-4f94-b24a-19f237d9baf2	WUm6xtVrkd2SWW6S1Pxr	1854	Latte	Pastries	1	108.74	2025-10-17 16:34:22	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.rivera7	2025-10-17 16:34:22
2427cbd2-8288-4bb9-801f-3f716d0115c8	97DBVMLQfhoUVWCwrZWg	1855	Mocha	Pastries	3	61.74	2025-08-31 04:25:53	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carlos.cruz12	2025-08-31 04:25:53
b6ad28eb-07fe-4caf-ac17-7946457ebf5a	7N1fjbhgIqTsDvaaS3cD	1859	Chocolate Chip Muffin	Pastries	5	103.79	2025-05-25 23:46:21	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.cruz12	2025-05-25 23:46:21
1a200e48-7015-489f-b8e9-aea252177ce3	mWtHalLWJc31awy9htzx	1860	Blueberry Muffin	Pastries	3	185.15	2025-05-04 08:49:42	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904705823	gabriela.mendoza	2025-05-04 08:49:42
547359e6-6eff-4b7a-a54e-be035343d505	QIIhNf8QXd2JmnP2EWfO	1861	Americano	Pastries	2	80.96	2025-10-09 01:28:56	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	gabriela.mendoza	2025-10-09 01:28:56
25dce334-d366-4c43-b523-9fb0ed2fbe8b	nSSLyMVxgr9cHvdY0zEw	1863	Apple Turnover	Pastries	5	154.54	2024-11-26 16:43:13	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904204293	fernando.cruz	2024-11-26 16:43:13
7971dd1a-2805-467f-b2c7-70316f8db75e	m6XvblysQLHkwyYRbNtl	1864	Macchiato	Pastries	4	93.97	2025-02-17 04:25:23	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	elena.fernandez11	2025-02-17 04:25:23
a8d12d2a-c33b-471e-85f7-655cbf4ea55b	TajZ7DZn9dffWVzCZuIr	1865	Americano	Pastries	5	80.96	2025-05-15 22:09:20	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904180572	antonio.santos6	2025-05-15 22:09:20
b467a075-1a03-4358-87cf-3acec11b3aa9	aZHr7bwmCwTOSBuIiTfx	1874	Tea	Beverages	2	106.18	2025-02-04 08:28:11	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.fernandez11	2025-02-04 08:28:11
52d1befe-3b97-499f-8dfe-8983241cf110	mjGEX7T7Lf8dy0k1mfnu	1880	Mocha	Pastries	2	61.74	2025-09-09 10:29:57	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carlos.cruz12	2025-09-09 10:29:57
34c203bd-1fdf-46d7-b6aa-101ef48257fa	vtss9GJRV8gcgM8rHQiI	1881	Americano	Pastries	2	80.96	2025-04-12 19:50:36	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.rivera7	2025-04-12 19:50:36
7a360892-9c3d-4505-85b0-39a3f7841ea0	I29dua7fobEmvzUyVFWw	1884	Macchiato	Pastries	3	93.97	2025-07-09 21:46:30	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	ana.rivera3	2025-07-09 21:46:30
9030b683-a27d-4ad8-84f3-dd4e76f23aeb	8IxqEUf63bGh6kfsNmdV	1887	Red Velvet Cake	Pastries	4	187.25	2025-04-06 11:54:04	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904603964	antonio.delacruz10	2025-04-06 11:54:04
344c72d0-661f-4736-a784-73b1da63935a	RCiPQ69Rz8MGUeuJlMJW	1889	Glazed Donut	Pastries	1	148.75	2025-01-19 16:45:34	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	isabella.delacruz4	2025-01-19 16:45:34
c9e00ee0-f94f-4809-8a11-dd10fc936067	BnNXucEPGpC0QmjDKpg7	1893	Macchiato	Pastries	1	93.97	2025-02-07 20:59:41	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904128461	carlos.mendoza	2025-02-07 20:59:41
240386e2-4074-41ed-a691-902ca87fabe2	lmqUSewnITEwF2UDcxfH	1901	Mocha	Pastries	2	61.74	2025-04-10 02:44:34	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	rosa.rivera7	2025-04-10 02:44:34
cd767a5e-20bb-4afc-89cf-79cb41a296b2	DXCYmk4Ful5TEdc86i6B	1905	Cappuccino	Pastries	2	76.25	2025-01-14 04:08:30	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	gabriela.mendoza	2025-01-14 04:08:30
af7944ed-f60c-4437-90fe-bf2055877953	fyukiN5vAYImLXDCNI49	1910	Baguette	Pastries	2	133.77	2025-01-07 02:46:53	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	isabella.delacruz4	2025-01-07 02:46:53
1a1fcb8f-0e89-45b4-9455-238d3f93d3d7	KnJxKDwSyQ9RE8RWhM8t	1913	Almond Croissant	Pastries	5	8.42	2025-03-17 04:02:41	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2025-03-17 04:02:41
6dce96ab-741c-44d0-a77d-0647e1caf3bf	WpYQ4XNJgiMFxpct5CMw	1914	Almond Croissant	Pastries	1	8.42	2025-01-27 23:04:30	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904827358	ana.rivera3	2025-01-27 23:04:30
74693797-6cec-4b41-984b-962d7e748ac5	rYlib6DXkG2IB5yVZxdM	1920	Blueberry Muffin	Pastries	4	185.15	2024-12-30 12:53:52	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	sofia.bautista5	2024-12-30 12:53:52
ede65873-ca2e-47dc-b205-37c1c6b0bb35	730A7HkGURUds3QK75z2	1922	Eclair	Pastries	4	146.12	2025-09-13 13:36:20	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.delacruz10	2025-09-13 13:36:20
30e845ea-a53c-4d86-81ad-cfc1b1f14ded	drBPT6Vba2BbOMvzT2jo	1925	Apple Turnover	Pastries	5	154.54	2025-09-09 03:21:03	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	ana.rivera3	2025-09-09 03:21:03
38dc0bc5-688f-445d-b6f6-29705cce5b91	WINDxBbW89PL2325IDmi	1926	Tea	Beverages	3	106.18	2025-08-14 08:36:21	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	pedro.cruz14	2025-08-14 08:36:21
8027dffe-ec42-4021-96ca-3541794753f2	VpvTYrQLjIsdhi9rWXcH	1927	Almond Croissant	Pastries	1	8.42	2025-11-14 13:07:48	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.mendoza	2025-11-14 13:07:48
e0158baf-0564-42ac-92a9-a72acf5ea133	FPOQIh487YcdAeSRGySi	1929	Mocha	Pastries	4	61.74	2025-07-05 01:49:56	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904983217	carlos.cruz12	2025-07-05 01:49:56
d119b474-8998-443b-a380-9876ec00f935	QpANdPfBIFsg0TM8tQT4	1930	Chocolate Chip Muffin	Pastries	1	103.79	2025-09-01 22:21:29	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904290522	elena.fernandez11	2025-09-01 22:21:29
edae0dd2-c34d-4e51-8827-131fbf276923	qOdB1PacdczBUZe8Oxnc	1931	Almond Croissant	Pastries	1	8.42	2025-08-16 02:40:50	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	sofia.bautista5	2025-08-16 02:40:50
17a31301-81d7-462b-83cd-deddff98dad9	zVOG7pcspSJIvzhqlH9R	1932	Flat White	Pastries	3	113.21	2025-04-22 02:03:51	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	fernando.cruz	2025-04-22 02:03:51
db0f940a-f67b-4018-b2d8-3ddb58fecadf	5HUcWShWSFJKEThNDPNj	1934	Cappuccino	Pastries	4	76.25	2025-04-08 06:47:10	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904178782	admin	2025-04-08 06:47:10
60f868ed-9bad-4b2b-9ef8-bf65096c2a76	zZ2QIMzaPQmpfxbmXCuW	1938	Latte	Pastries	2	108.74	2025-01-26 21:05:57	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.cruz	2025-01-26 21:05:57
338688e0-2c21-4388-a235-9e6c4a74ee14	nvk3saPxUK6fuVmRh6vw	1946	Macchiato	Pastries	3	93.97	2025-08-18 05:40:22	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	elena.torres2	2025-08-18 05:40:22
8f0565f9-7d7d-47ae-9b0a-7a678e007f4f	gWovG8GXCTopZcrV3Rlf	1949	Red Velvet Cake	Pastries	4	187.25	2025-01-29 23:09:00	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	miguel.cruz15	2025-01-29 23:09:00
1fce04b7-70fa-4561-ae9f-250b90ada5ad	cxCzYKceiMYNMCZkb5FA	1956	Baguette	Pastries	4	133.77	2025-11-09 12:19:13	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.fernandez11	2025-11-09 12:19:13
035f35ef-1cca-49b1-ada0-8829512c8b8a	xcRETLUnWzgOe8zewrHt	1960	Latte	Pastries	4	108.74	2025-09-03 10:58:01	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	ana.rivera3	2025-09-03 10:58:01
c7383299-c7d9-4f46-9f83-3ece0d12862b	sQ7ZXmx0Idl2QmMpgQsD	1968	Cappuccino	Pastries	4	76.25	2025-01-10 14:03:03	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.cruz12	2025-01-10 14:03:03
9a5a073f-d0f6-4f4e-8bd9-00378a24f4c2	qqSzpQZEv8Yok64DoB4I	1971	Latte	Pastries	1	108.74	2025-03-30 21:06:09	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	pedro.cruz14	2025-03-30 21:06:09
d3c3165e-0d7b-43d5-9fa7-2eedf6448320	JBIKoM70XSZnE1JEzQFS	1976	Blueberry Muffin	Pastries	3	185.15	2025-07-12 16:38:12	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904604397	elena.fernandez11	2025-07-12 16:38:12
d7002a2c-eb62-45f8-a7d7-fc43430c3879	H9zIfeadq9wqR8qmRfow	1977	Mocha	Pastries	5	61.74	2025-06-18 22:50:42	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	rosa.cruz13	2025-06-18 22:50:42
8da30126-af28-4345-a000-fabc7353339e	ewqxAKTpo50GLZPQG6pI	1978	Eclair	Pastries	4	146.12	2025-11-12 16:02:54	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	fernando.cruz	2025-11-12 16:02:54
18a43437-f9ab-4156-aba5-69618a4d4ec8	rWPB2MAgPOCHZrE9KeKH	1981	Flat White	Pastries	2	113.21	2025-09-04 15:02:35	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	rosa.cruz13	2025-09-04 15:02:35
fd5d3a66-f986-49a9-97b7-ea8f49d7c556	CLKuJj3OmCWecfncZIPD	1985	Cappuccino	Pastries	1	76.25	2024-12-10 23:35:36	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.cruz12	2024-12-10 23:35:36
89dbbcb5-f249-4414-ae26-674b2d746b3c	k64yfoFOHno5KnzAt34O	1986	Almonds	Pastries	1	5.59	2024-12-25 09:15:01	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904228761	antonio.delacruz10	2024-12-25 09:15:01
14dab0fe-b256-4397-ac2e-d38b8ea9124a	P5wX8GZS2MwcfwAzDgTf	1989	Flat White	Pastries	4	113.21	2025-06-21 13:42:30	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	fernando.santos8	2025-06-21 13:42:30
11c852de-0503-4dab-b1eb-2f5e72a7416b	Bonpo8zo7ymkT84RXYgm	1990	Tiramisu	Pastries	5	196.55	2024-12-06 16:14:18	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carmen.santos1	2024-12-06 16:14:18
869f9e80-8d7e-45fe-995c-d0e609c0e41c	GPBt4n2jSRhGFBPCS1oe	1991	Flat White	Pastries	5	113.21	2025-04-16 04:34:07	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	miguel.cruz15	2025-04-16 04:34:07
9b8bdf05-18bb-43b1-b696-bfc5b33d51b3	4M2BSAlIjk9eTgLV4wYJ	1995	Flat White	Pastries	5	113.21	2025-09-21 23:13:26	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904886695	admin	2025-09-21 23:13:26
3d2ff9d5-2607-47ca-9dd2-50f76c2b972d	jATS7zYY6Vebo3Xun278	1999	Apple Turnover	Pastries	4	154.54	2025-01-13 18:26:32	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	rosa.cruz13	2025-01-13 18:26:32
7085c03b-0a8a-4d44-8bfe-46baffa5b099	ypfmrlN3Q2aD7qbeZADF	2002	Hot Chocolate	Pastries	1	131.53	2025-08-08 00:15:24	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.delacruz	2025-08-08 00:15:24
db847f8b-88c6-457d-a2b3-51bd1d2c7519	zplvRcs07FU1qbmHwGm8	2006	Flat White	Pastries	3	113.21	2025-01-23 10:00:06	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	admin	2025-01-23 10:00:06
3983e286-9d1e-4951-97f8-aaca75bb914f	FMWYoxv5ah5nL5bRUnkW	2008	Flat White	Pastries	4	113.21	2024-12-04 00:16:13	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	fernando.santos8	2024-12-04 00:16:13
07b3f3f0-8029-41f4-90fa-db62479a168d	1yNxOBrV03My12FtLanV	2009	Americano	Pastries	4	80.96	2025-08-29 09:44:28	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904542302	pedro.cruz14	2025-08-29 09:44:28
4580ca25-b986-406d-8e7b-62467862bf28	ze423MCRpnoEolGLl7aV	2010	Glazed Donut	Pastries	5	148.75	2025-08-11 07:46:44	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.delacruz	2025-08-11 07:46:44
6a8ce971-78e3-4b35-a820-a1d52ed51f19	ZuxINaD2DhVANAUJtait	2013	Iced Mocha	Pastries	5	144.00	2025-08-10 14:31:25	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	rosa.rivera7	2025-08-10 14:31:25
99fa9252-0598-4b83-afa4-191cc379eb46	jzHGcnCOUppdbVpsBwjw	2016	Tea	Beverages	2	106.18	2025-08-01 14:34:05	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	admin	2025-08-01 14:34:05
918d3711-118f-4d46-9bb3-c59a3d1f5bf4	ClbpPfPG09BDVqgvJwWc	2017	Latte	Pastries	4	108.74	2025-05-23 16:03:30	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.cruz	2025-05-23 16:03:30
fccf60af-b7ca-4e7a-b892-f38f712ce74e	D8v6DuU8H6ARmI0jiBIo	2021	Chai Latte	Pastries	3	100.50	2025-06-01 13:55:18	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904217266	elena.fernandez11	2025-06-01 13:55:18
4e1601da-0033-4f8c-946a-35f36525d43c	CMefT3bYTd3mgLfi10G6	2023	Macchiato	Pastries	2	93.97	2025-02-16 11:39:18	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	rosa.rivera7	2025-02-16 11:39:18
3ef0dee6-c8bf-4dbb-be14-9b1526fe5ff7	NES0CGjltMpyGutN8ngI	2024	Baguette	Pastries	4	133.77	2024-12-05 11:55:23	c8d156d2-b289-439f-90bc-692447063015	Card	\N	carlos.delacruz	2024-12-05 11:55:23
c88f1282-a524-4a97-a24d-5a9e626e229d	Isz0UOD63GsObPMTdOVy	2029	Glazed Donut	Pastries	5	148.75	2025-02-19 22:58:31	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.mendoza	2025-02-19 22:58:31
e4a8d84e-87e7-4e00-853c-877b109a7e80	PS0UNrIC5DlD5FSdOdGq	2034	Espresso	Pastries	5	195.76	2025-02-15 04:41:12	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	elena.fernandez11	2025-02-15 04:41:12
e668ce56-88ae-461a-8148-d5b3c80c985f	XyCBEUUuoSrOViVVyXoG	2041	Apple Turnover	Pastries	4	154.54	2025-06-20 10:58:32	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.torres2	2025-06-20 10:58:32
ed032f2d-ec60-4735-bd28-d9ebfc5cc47d	ku7txBFuWaodmnzRhFFs	2045	Chocolate Chip Muffin	Pastries	4	103.79	2025-09-29 10:19:51	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	pedro.cruz14	2025-09-29 10:19:51
adc929b0-8464-4158-a266-a7884f241ebe	T0a2GPAzpVecabIkyInR	2048	Flat White	Pastries	1	113.21	2024-12-04 07:38:04	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904141760	isabella.delacruz4	2024-12-04 07:38:04
081f0dba-ebda-4b71-a740-a96aeb47412d	iEMiupvmE201SO2FRt8e	2049	Iced Coffee	Beverages	2	107.80	2025-07-06 01:55:01	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904174580	sofia.bautista5	2025-07-06 01:55:01
2b67c974-411f-4b8c-9fe6-797c88099a5f	5ZMMwlnwKLLA6ROdEdaM	2052	Latte	Pastries	1	108.74	2025-01-31 13:21:26	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	isabella.delacruz4	2025-01-31 13:21:26
a3aa1435-9011-4fd6-9ee3-d505f87a3e2a	Ko0ptgBvn0Vre3vxsDWu	2055	Iced Coffee	Beverages	1	107.80	2025-01-07 11:22:24	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904957688	rosa.cruz13	2025-01-07 11:22:24
2ecd35de-4003-450f-8600-210d3b004178	mXWmaxb87P2PoARwWgYC	2057	Espresso	Pastries	2	195.76	2025-04-09 06:26:07	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.delacruz	2025-04-09 06:26:07
d6bb9ebc-ab9a-4de1-9135-81daee90f963	rLHJsPqjGA7xJ4ikjkoW	2062	Flat White	Pastries	3	113.21	2025-05-10 20:03:00	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	rosa.rivera7	2025-05-10 20:03:00
fe195a18-43a2-4a42-8a7a-5be6e04b4245	EdPhd3O0eQ7vKdVKeMSJ	2063	Red Velvet Cake	Pastries	4	187.25	2025-09-24 03:57:42	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904433321	carmen.santos1	2025-09-24 03:57:42
fab44f10-e747-42eb-8dfb-f6462783f3a2	GQb0tWvFFauKFtEz2mJn	2064	Glazed Donut	Pastries	2	148.75	2025-03-31 00:09:37	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904619074	isabella.delacruz4	2025-03-31 00:09:37
cfc7a65e-162d-483c-bf63-5471cd7400b2	mYfJgx4jUtsG76x9Y56N	2067	Blueberry Muffin	Pastries	1	185.15	2025-04-21 02:42:18	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.delacruz10	2025-04-21 02:42:18
55211b98-e35f-498f-9e7d-86d7678d81bc	0utx8jERJrEx5rAbrMIV	2068	Hot Chocolate	Pastries	2	131.53	2025-01-14 17:31:40	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904025033	admin	2025-01-14 17:31:40
d489baa4-e0ff-479a-9be9-1d36bb0c97f7	h3OjFkDxUNlGUCqDhpKz	2072	Glazed Donut	Pastries	3	148.75	2025-11-01 16:54:11	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	fernando.santos8	2025-11-01 16:54:11
3cd0a6e9-f1a4-4dbd-93b2-3977504642db	GO5ZfiyfFCWpfUGXucyz	2073	Espresso	Pastries	3	195.76	2025-01-30 09:44:54	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	sofia.bautista5	2025-01-30 09:44:54
7112504c-1443-4b86-8dd2-1024bee9b6af	yHFA5l4uWqJzXVZf5nQW	2078	Chocolate Chip Muffin	Pastries	1	103.79	2025-10-20 19:24:31	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	ana.rivera3	2025-10-20 19:24:31
26494e13-2d2e-4076-9824-0747cc4d302f	uCsSXUiH3kMLUAbYur3W	2080	Tiramisu	Pastries	3	196.55	2025-08-19 04:31:01	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904324568	sofia.reyes9	2025-08-19 04:31:01
ca0030f1-7ea3-4bf9-b99c-67fca0c87ff4	pquaeEDz6CaTabe0DWXy	2085	Red Velvet Cake	Pastries	2	187.25	2025-06-12 13:45:32	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	sofia.reyes9	2025-06-12 13:45:32
feb5c888-46d6-484c-b9c0-356f57a97b53	63MqtmJjWW5d4ah9hCWo	2087	Iced Coffee	Beverages	5	107.80	2025-04-29 08:40:09	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.santos6	2025-04-29 08:40:09
60d44b65-9eb0-4ffa-9b9c-620c13c0f242	stObtv9v1vSZnQogVK77	2090	Iced Mocha	Pastries	3	144.00	2025-08-22 09:49:21	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	sofia.reyes9	2025-08-22 09:49:21
b45ede35-8eef-4b2f-81b2-a257d311a49d	F7Xh8X8WcUQhUggzUB7J	2093	Chocolate Chip Muffin	Pastries	3	103.79	2025-09-07 19:58:43	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904965002	fernando.santos8	2025-09-07 19:58:43
16999e7c-ed46-4569-a03e-eae46f9d587d	5fstQXi9cygLEAVCfXPC	2095	Baguette	Pastries	1	133.77	2025-10-06 15:49:35	c8d156d2-b289-439f-90bc-692447063015	Card	\N	antonio.santos6	2025-10-06 15:49:35
d3cadd9f-fbc1-4179-ac63-cdeeed8c2751	YMiymgZXsirkke6g0TX2	2096	Latte	Pastries	2	108.74	2025-11-08 04:53:06	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	miguel.cruz15	2025-11-08 04:53:06
63a831b1-7721-448f-9a98-bf05906d4899	CRZijSqfBHiNHh9FC2pv	2097	Espresso	Pastries	3	195.76	2025-01-31 18:02:40	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.mendoza	2025-01-31 18:02:40
e585493b-36a4-47ad-b980-5bb589b979dd	7R2GQfSAa8ZFfTa0DU8q	2098	Macchiato	Pastries	4	93.97	2025-04-01 05:33:38	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	rosa.rivera7	2025-04-01 05:33:38
0237c2e7-920d-43a2-ba82-63b50c8fa5ac	R2YpiuaRsQ7kIWGT5j6T	2102	Mocha	Pastries	4	61.74	2025-10-27 23:48:50	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carlos.delacruz	2025-10-27 23:48:50
1f72aacb-aace-458c-8bf3-eeec46ee288e	PMdV28ifRLjrc8SX3TnE	2103	Macchiato	Pastries	5	93.97	2025-05-15 01:42:49	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904683987	ana.rivera3	2025-05-15 01:42:49
b9502ec8-c356-49b2-8732-0a210ac712e2	s32rjeCzG4raZCZi1rba	2105	Cappuccino	Pastries	1	76.25	2025-09-30 00:27:42	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	isabella.delacruz4	2025-09-30 00:27:42
1bebcc51-4bed-46ed-9d20-eb3c68db5b3f	h8WOI12jMznuxxaLomA6	2106	Blueberry Muffin	Pastries	1	185.15	2025-02-21 02:53:12	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	sofia.reyes9	2025-02-21 02:53:12
f3590a97-7b65-42bc-89a1-a6e75b1a5162	4ChhL59O71TpcB8Nx4e2	2112	Americano	Pastries	3	80.96	2025-05-08 18:39:31	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.rivera7	2025-05-08 18:39:31
dc7e7dd0-98e2-4e92-ac95-e998182de5f8	6KOWBAwN6UKy2dbfFPgb	2115	Baguette	Pastries	1	133.77	2025-04-14 08:49:57	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	antonio.delacruz10	2025-04-14 08:49:57
68be1673-5af4-4d9c-a252-257880f4ef84	MDaHeKTkz1J0OnRfZIvO	2120	Macchiato	Pastries	2	93.97	2025-03-24 23:13:45	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	fernando.santos8	2025-03-24 23:13:45
6507b4dc-0431-4e8b-8274-137de1a58564	55PwAFwWVECWCti6g1PT	2121	Eclair	Pastries	2	146.12	2025-04-25 09:25:28	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904014401	fernando.santos8	2025-04-25 09:25:28
9a95a81a-2d47-4e0a-9870-558707da69e2	tFHkxBJiQy1sk3nAriZp	2123	Mocha	Pastries	4	61.74	2025-09-22 11:25:26	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	admin	2025-09-22 11:25:26
1322ea8e-b5db-42c1-9460-0023308b63ce	O7WwxuuZetWhnI5QVL9P	2125	Almonds	Pastries	1	5.59	2025-07-23 16:55:55	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904913674	antonio.delacruz10	2025-07-23 16:55:55
a9bc7068-480c-496f-bcf8-049f56384945	f4zJ8PlMvJfcZ9YUai3v	2126	Baguette	Pastries	1	133.77	2025-01-03 06:59:12	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	antonio.delacruz10	2025-01-03 06:59:12
e6df463b-c748-472c-b1bd-67835d0f498d	XWS83V8ZIDn8HswgGOc5	2128	Iced Coffee	Beverages	5	107.80	2024-12-01 16:18:01	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.santos8	2024-12-01 16:18:01
6c94c105-0093-46dd-96ac-46a58b3d02b6	EGcOuLnMI1AitHL91Pua	2134	Eclair	Pastries	3	146.12	2025-05-21 06:16:21	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.fernandez11	2025-05-21 06:16:21
8a210d08-fee5-4772-a4b5-7968122d9cb0	zl8c666S2CoAaCVrplf7	2137	Iced Mocha	Pastries	3	144.00	2025-11-23 07:12:35	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	sofia.reyes9	2025-11-23 07:12:35
e9301822-635b-4eee-8f4f-0fdd0131af39	V92cC3YsFva3KhsalQli	2139	Blueberry Muffin	Pastries	2	185.15	2024-12-01 12:00:05	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.mendoza	2024-12-01 12:00:05
b8eeb5af-db46-4eae-8e3c-26f6d3725d25	0jPMB9hzQeo6qHKMc1bE	2140	Apple Turnover	Pastries	1	154.54	2025-09-07 19:56:35	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	rosa.cruz13	2025-09-07 19:56:35
1fcc42e8-5159-4518-aec7-d5cb96b25426	kVVHwBcobMMvio3VaWQg	2143	Cappuccino	Pastries	1	76.25	2024-11-27 14:08:42	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carmen.santos1	2024-11-27 14:08:42
94c98037-972a-4658-a651-d1e355847d7f	z4N7wmz0TQ2hod87V8EG	2148	Iced Coffee	Beverages	4	107.80	2025-06-30 00:54:51	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.cruz12	2025-06-30 00:54:51
03d69363-5a9b-4524-92c3-309a115414e9	hEmbcWrwt9W1OUmeLYUF	2155	Flat White	Pastries	1	113.21	2024-11-28 14:07:43	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904702578	ana.rivera3	2024-11-28 14:07:43
43396594-0ae0-467a-b545-790f5f6289f1	WAn8QlcCwJRMCeqRDB4p	2157	Tiramisu	Pastries	4	196.55	2025-01-20 00:37:54	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.torres2	2025-01-20 00:37:54
e69a7a22-ddcc-42e8-a773-b4c3d243b301	LOfOZBB5ZyjP4Oa7EwTH	2163	Flat White	Pastries	2	113.21	2025-03-13 18:29:15	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904733930	rosa.cruz13	2025-03-13 18:29:15
f1c64cfd-941f-4afb-9503-3c5b3d46a2e3	7WBLulOVrcqD7jECMqvk	2164	Glazed Donut	Pastries	3	148.75	2025-10-01 22:49:37	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	rosa.rivera7	2025-10-01 22:49:37
4a455e10-a1df-4311-89e7-bb0dd569168d	ReKU41zyhK8Ub5Orvk06	2166	Iced Coffee	Beverages	2	107.80	2025-10-26 11:53:10	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.reyes9	2025-10-26 11:53:10
383b67e9-0a36-4c18-a4cb-330bdd7d2708	wvIBkALiHVg9mJAUirYM	2167	Mocha	Pastries	4	61.74	2025-07-16 18:45:19	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.cruz	2025-07-16 18:45:19
555e1622-dc64-45a8-b301-e4da1f3bb773	VHHRRwOPXZhA3MVSOHFm	2171	Tea	Beverages	3	106.18	2025-06-25 04:58:15	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	elena.fernandez11	2025-06-25 04:58:15
88d5f928-4d39-41ce-bea1-bf09f42ded29	adgv7Ic02iHEp2zMLVK9	2172	Blueberry Muffin	Pastries	1	185.15	2025-09-24 05:58:09	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.delacruz	2025-09-24 05:58:09
2d5d93c6-edec-44af-ae99-5063b87b7e5c	J44919w0XhhtNLMBwpMN	2173	Hot Chocolate	Pastries	5	131.53	2025-09-06 17:38:50	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	fernando.santos8	2025-09-06 17:38:50
6be0a95b-8d7b-4d29-a38f-45bd4585e2dd	IRgqotDxxXvrYwI8y7NX	2180	Blueberry Muffin	Pastries	3	185.15	2025-09-20 21:51:48	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	ana.rivera3	2025-09-20 21:51:48
4bd71a81-ff52-403b-a05b-10667ae6b2e7	jAv8EvXi62shKxH6odpl	2181	Red Velvet Cake	Pastries	5	187.25	2025-10-20 03:40:50	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.cruz12	2025-10-20 03:40:50
9976ae50-3c79-4e53-b9f6-eb551130d299	WH3X9qrxeXUBuy3obn7E	2182	Eclair	Pastries	4	146.12	2025-05-02 21:11:20	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904363700	admin	2025-05-02 21:11:20
9e4e092c-1fe2-4daa-b60f-4f340d59967c	3jbcFnIOqFfDgqxomm30	2183	Baguette	Pastries	4	133.77	2024-12-12 04:28:59	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183904377826	carlos.mendoza	2024-12-12 04:28:59
01cab075-29f4-430d-93fe-7f53ac976f6d	4f048aA9JvLLMYJBCJfk	2184	Flat White	Pastries	3	113.21	2024-12-05 22:37:32	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	gabriela.mendoza	2024-12-05 22:37:32
c8921c31-24ac-4b8f-92fc-890101c2266a	1Vg6m8hRhVEjgnRqLrwj	2185	Hot Chocolate	Pastries	5	131.53	2025-02-10 22:41:18	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904640784	carlos.cruz12	2025-02-10 22:41:18
b93cc978-b182-4a73-8959-3fe24dbb0c41	RCkc4y9faPvZyNHrnJyM	2186	Cappuccino	Pastries	1	76.25	2024-12-18 14:55:51	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.cruz12	2024-12-18 14:55:51
51af1426-343f-4847-8e35-a40e2ff3a6ff	\N	\N	Almonds	Pastries	1	5.59	2025-11-25 08:54:28.52718	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2025-11-25 08:54:28.52718
5f61cc04-3beb-4e1a-9b3a-3d278eb3d138	FEWtjLdqg2utGOFeGsBS	2190	Espresso	Pastries	3	195.76	2025-08-01 12:52:16	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	admin	2025-08-01 12:52:16
7f179302-778d-4652-b626-2b59bf69f2ef	59IBfI9ua4KMjqtdUbb1	2193	Americano	Pastries	2	80.96	2025-04-03 04:46:54	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.cruz13	2025-04-03 04:46:54
373fe2f6-e0c6-4805-bccc-b992ffc237bb	0hoqmEDzkEFZfWA9eBnV	2195	Blueberry Muffin	Pastries	3	185.15	2025-09-13 11:26:58	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.cruz13	2025-09-13 11:26:58
ffc23df9-6cda-492f-ae7a-d699ddb78880	gVO5231qSYDPEBN9MVTC	2197	Baguette	Pastries	1	133.77	2024-12-20 07:27:31	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.fernandez11	2024-12-20 07:27:31
4d44090b-defa-41a0-b5b3-e5d8cc4e2686	ldlp88TBEFnKydRSI7pI	2201	Red Velvet Cake	Pastries	4	187.25	2025-09-23 16:10:22	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carmen.santos1	2025-09-23 16:10:22
1cc561f9-b10a-4168-b225-3d7a40602472	mKW2ZxNKE5XdAOs2JuIP	2202	Blueberry Muffin	Pastries	3	185.15	2025-03-31 12:05:00	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.santos6	2025-03-31 12:05:00
cb00df64-c3c6-4fcf-8dfa-5bfe2cb79f77	hNC1znwscCjMQVpg6Les	2207	Cappuccino	Pastries	3	76.25	2025-06-26 10:26:01	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904341181	carlos.delacruz	2025-06-26 10:26:01
9f9b01c2-8dd2-46db-a617-daf5b21648e1	8u3yauHO2z8D5UlWhw1b	2209	Iced Mocha	Pastries	2	144.00	2025-07-21 05:03:54	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.delacruz	2025-07-21 05:03:54
6d1bd597-2fc7-4d97-91ef-236a37a91d8f	ViDbWVpjm0BAHxvAqZ6p	2211	Baguette	Pastries	5	133.77	2025-06-08 18:48:52	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	rosa.rivera7	2025-06-08 18:48:52
7d43e083-f842-41a1-85c0-5881a1773fd0	m7YQCGowjvCqFeaX13FR	2215	Latte	Pastries	2	108.74	2025-09-05 02:28:16	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.santos8	2025-09-05 02:28:16
36b341b6-b629-4c1a-a100-9883cb1a6ffd	wMUeNSR5SU1OUAOPW8Zw	2217	Hot Chocolate	Pastries	1	131.53	2025-05-13 15:15:43	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904788167	elena.fernandez11	2025-05-13 15:15:43
f14b7c4a-f18b-4c01-85df-502ff582896b	Gc69OyxeAHYnquSccdXa	2218	Iced Coffee	Beverages	3	107.80	2025-07-29 21:53:52	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904820290	carlos.cruz12	2025-07-29 21:53:52
8d3e6b1e-6848-4af8-a69e-48cd4049c5cf	7fFRA2IhAzQChV4gXate	2225	Tea	Beverages	1	106.18	2025-11-10 04:48:13	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	sofia.reyes9	2025-11-10 04:48:13
d19436be-7db7-448d-9e61-32b26f0590b2	ME3zGQoQHUGmhR7tOsyj	2226	Tiramisu	Pastries	2	196.55	2025-05-19 17:08:54	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.torres2	2025-05-19 17:08:54
f82754ce-5298-4682-8b53-da51196bbeea	rWuUREAY4Tz2dZyCEwco	2235	Tiramisu	Pastries	1	196.55	2025-02-11 10:33:33	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904903817	miguel.cruz15	2025-02-11 10:33:33
4db90a52-a7c8-47ad-8151-5dae4acfcd4d	9LGxU3tek4jfYqPXTjqw	2238	Latte	Pastries	4	108.74	2025-08-10 18:32:37	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	sofia.bautista5	2025-08-10 18:32:37
1c738291-0f3b-4596-9abe-d05c07d3fe13	B3Qz8KrnLC6p75aEqgAK	2239	Macchiato	Pastries	1	93.97	2025-04-02 08:23:10	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.cruz12	2025-04-02 08:23:10
75099444-afcd-4549-836f-debc1a26dbbe	yEGkvZCFXMjouWWlg2N3	2245	Tiramisu	Pastries	2	196.55	2024-11-30 01:22:40	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	sofia.reyes9	2024-11-30 01:22:40
0ce45ac1-128e-4dc2-8fb3-ba6ae7066d15	xrp9CwmW5ocl8HrjK1VR	2252	Cappuccino	Pastries	3	76.25	2025-03-10 01:29:49	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	sofia.bautista5	2025-03-10 01:29:49
79925175-3564-4cca-a00f-da0bdc374b37	RXqQDr7iUgX7ITuFuF2b	2253	Apple Turnover	Pastries	2	154.54	2025-06-27 21:54:54	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carlos.cruz12	2025-06-27 21:54:54
3d43f4e9-545e-4711-b66b-d4dd6450195d	vcKGc71OoA3lFYBprX0K	2254	Americano	Pastries	3	80.96	2025-07-17 09:51:08	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	isabella.delacruz4	2025-07-17 09:51:08
3b6ba00d-0ecf-43c5-8710-da72cb2a777d	kTnpPsBxWfIlEuSAbhEA	2255	Flat White	Pastries	1	113.21	2025-08-26 22:53:06	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	fernando.santos8	2025-08-26 22:53:06
c65ba79d-8f72-45ca-bbcb-6159a20d8128	fVDEXOM1i5HWyVCPIJnw	2257	Iced Coffee	Beverages	5	107.80	2025-10-22 07:58:43	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.santos8	2025-10-22 07:58:43
769e90e7-f607-4f20-aea6-052a1280edfe	QPQr2IsmWi9jdHF46xIN	2259	Apple Turnover	Pastries	4	154.54	2025-04-09 12:25:38	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904129636	admin	2025-04-09 12:25:38
f3bfdb2b-2674-42a1-bc35-018c8f718a79	G7LfxXNC68HPQ8WRIT5Y	2261	Mocha	Pastries	3	61.74	2025-03-25 01:19:43	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	isabella.delacruz4	2025-03-25 01:19:43
eceb0903-8c5c-4fb8-8d95-04189ce994d2	J1jOJoOp6jvaPZA9jGOZ	2262	Tiramisu	Pastries	2	196.55	2025-08-30 07:24:45	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	sofia.reyes9	2025-08-30 07:24:45
3db5b53a-38c7-44fc-be8c-87a1925f7e36	JPo1wgaeUIen7rOh5Y3W	2266	Flat White	Pastries	5	113.21	2025-04-25 00:03:36	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.delacruz	2025-04-25 00:03:36
e7229af5-55e6-4298-ac76-de6f91e42abf	SAHn9oXc66ZaDRbhbnUF	2271	Glazed Donut	Pastries	3	148.75	2025-11-13 16:21:24	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904215380	sofia.reyes9	2025-11-13 16:21:24
0690a295-d428-451f-bbe5-ec90c29ad42e	\N	\N	Almond Croissant	Pastries	1	8.42	2025-11-25 11:05:21.796339	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	3421576434394	admin	2025-11-25 11:05:21.796339
fc48bd34-b19f-47d4-a3f9-82061bb977b9	clcCjoZ4uQGoZGhFNWyR	2278	Chocolate Chip Muffin	Pastries	5	103.79	2025-03-27 00:15:27	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904287496	fernando.cruz	2025-03-27 00:15:27
25d14cd2-dbb7-4eb3-a439-c903d2096a43	2OexfJs2rwxEDdT0SHVx	2279	Tea	Beverages	3	106.18	2025-06-10 04:08:57	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	admin	2025-06-10 04:08:57
afeaff2a-613a-44ac-9d0a-c41c0fa61ac3	Yac4UZF9PnY9KIO5ck0f	2281	Blueberry Muffin	Pastries	4	185.15	2024-12-08 18:13:55	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904782661	antonio.santos6	2024-12-08 18:13:55
cad56f4d-5ff2-4c0d-90fe-02cfa85bfbb7	3hSfePRdvCGHvIHa687p	2283	Mocha	Pastries	4	61.74	2025-02-24 15:24:27	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.reyes9	2025-02-24 15:24:27
19d4a4b9-f512-4312-b3db-7ff5a01640e4	TJt2BvEQZrnbuieBHWpJ	2284	Cappuccino	Pastries	5	76.25	2025-01-07 12:24:16	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904511508	fernando.cruz	2025-01-07 12:24:16
085bc035-3dea-4a33-b4ab-5481f79ebd43	rOALrOGndCAPXga6JftT	2285	Almond Croissant	Pastries	1	8.42	2025-08-18 04:48:55	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.santos6	2025-08-18 04:48:55
27c142a4-847b-47a0-b588-797f33861061	3ILWEtZPEwKhEoZgCDOr	2286	Americano	Pastries	4	80.96	2024-12-08 20:52:54	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	elena.fernandez11	2024-12-08 20:52:54
f8c36870-5249-41ef-8661-b7805c2a311a	AJ7iwary4JZ9KWO7zI2j	2287	Apple Turnover	Pastries	2	154.54	2025-01-25 08:47:19	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carmen.santos1	2025-01-25 08:47:19
689b3096-a551-4b87-99c7-0cbfc9e8b739	rkXSgilAalxaxkFRnaz2	2290	Baguette	Pastries	5	133.77	2025-10-01 05:07:31	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	antonio.delacruz10	2025-10-01 05:07:31
9478c05f-5561-4485-b21a-58f93bc0208a	bAo6LQNXcIpKAj8842FS	2307	Iced Coffee	Beverages	3	107.80	2025-06-04 05:34:05	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	admin	2025-06-04 05:34:05
86846967-6701-49cb-9e3d-958c5b7334e4	UC4WOlGQS47W14s24OMi	2310	Espresso	Pastries	1	195.76	2024-12-30 23:24:37	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	antonio.santos6	2024-12-30 23:24:37
1a6feb8b-e208-4b11-b2fc-51d4aae3172a	rO9rbWYbt9uw7eGyFhXS	2311	Eclair	Pastries	3	146.12	2025-05-28 18:25:18	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904200366	antonio.delacruz10	2025-05-28 18:25:18
a662f36a-2e4a-4542-be66-578933dbe82b	yXlFtk75UQSeqDKPnjDe	2314	Americano	Pastries	2	80.96	2025-06-04 16:39:25	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904940273	carlos.cruz12	2025-06-04 16:39:25
45b698c3-5685-40e8-8fa9-a426c91bc6f7	0ioy4uZik1QZwlUJx1vu	2315	Hot Chocolate	Pastries	3	131.53	2025-05-07 16:26:10	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	pedro.cruz14	2025-05-07 16:26:10
af92189b-a128-4817-94df-a26b3ac0d17d	rB2uvnYX3Emnw0pfQn3s	2318	Latte	Pastries	1	108.74	2024-12-30 15:30:03	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	pedro.cruz14	2024-12-30 15:30:03
43b4cbb5-3a23-449b-8a82-7a5111463211	bRW9vEiF297DhMr8rGNi	2322	Red Velvet Cake	Pastries	1	187.25	2025-11-19 02:18:30	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904613022	carlos.delacruz	2025-11-19 02:18:30
3130e6ef-04fa-4119-91dd-889aebcdb033	qRP1NK9nyxKVBqZiczRy	2323	Iced Mocha	Pastries	5	144.00	2025-06-11 08:42:24	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904079546	elena.fernandez11	2025-06-11 08:42:24
8b4b3f1e-3fa4-400f-b191-f55cda5b56d0	P9ePbrbRiYwZ4qfkZ5qQ	2329	Blueberry Muffin	Pastries	3	185.15	2025-06-17 14:42:01	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	miguel.cruz15	2025-06-17 14:42:01
01932801-0900-4c60-a765-47e8e35979c3	cMpcfGQjogARBcbEgBVw	2330	Iced Coffee	Beverages	4	107.80	2025-10-15 20:40:14	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	ana.rivera3	2025-10-15 20:40:14
75c50b1f-c6d7-41da-a8ef-2eda9170eb4f	94NjVSTTXlwH3iXZJXUJ	2331	Macchiato	Pastries	3	93.97	2024-12-31 16:23:50	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	pedro.cruz14	2024-12-31 16:23:50
ad2584de-8d85-4058-865c-4b14312c3bc1	bnOADLRfz04hnG7fHi8o	2332	Espresso	Pastries	4	195.76	2025-07-03 08:03:49	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	fernando.cruz	2025-07-03 08:03:49
0b941531-8528-49a1-a124-3a5da9630da6	IlLjmDFnsqe3Ux8y5fqJ	2340	Chocolate Chip Muffin	Pastries	4	103.79	2025-06-15 02:19:42	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	miguel.cruz15	2025-06-15 02:19:42
5c4b81f4-5ae8-4a68-ad20-6a54e1c406a3	LOH9I7QfuPZ63m9qJOre	2345	Latte	Pastries	3	108.74	2025-01-20 00:54:19	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	fernando.santos8	2025-01-20 00:54:19
4ff0f5af-1b40-4ad7-8e0b-b46b54c1955d	3u5w2RqiEnWTTUTE9xgO	2346	Apple Turnover	Pastries	1	154.54	2025-06-02 03:22:27	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	gabriela.mendoza	2025-06-02 03:22:27
637062bd-bffe-4faf-8272-c23beb2034cc	JQUi5eLiSU8omz6gtHHA	2353	Glazed Donut	Pastries	2	148.75	2025-10-01 03:20:21	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904040768	fernando.cruz	2025-10-01 03:20:21
2259513a-b16a-43ba-a1c4-8b07db9c191f	xyCKWYVsWQcHEk772Vzs	2355	Chai Latte	Pastries	5	100.50	2025-02-04 11:20:27	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904965942	rosa.cruz13	2025-02-04 11:20:27
00e7d7df-de79-4de4-a535-7271f07822e4	prhuQCJPDT6w7hLmBi7a	2357	Almond Croissant	Pastries	1	8.42	2025-03-17 07:50:21	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	elena.fernandez11	2025-03-17 07:50:21
06ca4c44-cd5c-4dab-9b6e-a9f4f07532b6	06ZCkR8InJdz4YGimpCn	2362	Americano	Pastries	4	80.96	2024-11-25 17:16:04	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	admin	2024-11-25 17:16:04
1775444d-3279-40dd-a640-bc396e0d1222	kmMw8IZcE1gfpwoFsujF	2365	Hot Chocolate	Pastries	2	131.53	2025-01-06 21:34:20	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	admin	2025-01-06 21:34:20
5fa04675-e97f-4fa5-8733-3adfa5c631cd	Dxr7LL6XnkUCahIqy051	2367	Blueberry Muffin	Pastries	4	185.15	2025-04-10 11:51:37	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.delacruz10	2025-04-10 11:51:37
c5bae02e-db92-4797-954e-c57b165617a2	xQI58CeUqUo4E1dtRZRf	2368	Macchiato	Pastries	2	93.97	2024-11-25 05:08:36	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904704462	pedro.cruz14	2024-11-25 05:08:36
a07d3763-6e04-48d8-aab7-dfecc0a8c7c3	Fb6R7rV2QA7HY5YBTKf1	2369	Iced Coffee	Beverages	5	107.80	2025-05-23 02:47:29	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carmen.santos1	2025-05-23 02:47:29
3caff8fd-8374-4bbd-8b29-374bc745b42f	XiPetiFdOSfr0O7RfD16	2370	Tea	Beverages	5	106.18	2025-10-16 14:33:04	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	ana.rivera3	2025-10-16 14:33:04
4be20391-124d-4925-b48d-9234f9a4a533	3Za66Yr0fACQkv5BCKYp	2371	Mocha	Pastries	3	61.74	2025-11-02 08:53:31	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.reyes9	2025-11-02 08:53:31
6c1a3e7c-103a-43a4-8f9f-0042d81c9dfa	SoLeNMiLbirkxhwPH7ui	2373	Flat White	Pastries	2	113.21	2025-11-08 00:22:05	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	sofia.reyes9	2025-11-08 00:22:05
8cdf9dd6-f060-41fe-aa93-b9d0d83d7b27	oR04usSFzs0eINxt9Vre	2375	Eclair	Pastries	3	146.12	2025-04-19 12:20:38	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904291735	carlos.mendoza	2025-04-19 12:20:38
8bb319c5-9dc1-435a-a780-a177a77d9f7b	KfS3jw10qREluIdRZDe2	2377	Iced Coffee	Beverages	2	107.80	2025-05-21 07:40:37	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carmen.santos1	2025-05-21 07:40:37
40f3bb0b-b837-46a5-a7e6-1288db4cf94f	oyb0ht6A0CygVheMfCZi	2379	Red Velvet Cake	Pastries	3	187.25	2025-02-26 02:58:13	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.delacruz	2025-02-26 02:58:13
b263001b-ced5-4050-8466-d8daa6558c60	9dT2vS54IwY74KtsMIRU	2380	Baguette	Pastries	4	133.77	2025-07-18 07:40:14	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.torres2	2025-07-18 07:40:14
bce1a0c5-f53f-4d98-8103-ae7c585312ae	iPGJEUYreyN5JiUL1ESH	2381	Tiramisu	Pastries	5	196.55	2025-05-31 20:54:02	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904125175	elena.torres2	2025-05-31 20:54:02
08e78003-f989-44d9-9d1d-1c26f14c2ff7	hvHmg1S8Ln8iRBMbbdWj	2385	Chai Latte	Pastries	4	100.50	2025-07-01 22:54:39	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	admin	2025-07-01 22:54:39
9afdcfd3-ec2f-4647-8f41-ff73bf0f0fff	KYHTOH3Ymhe6qO0GKJHa	2386	Espresso	Pastries	1	195.76	2025-10-29 22:47:35	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.cruz12	2025-10-29 22:47:35
010fd486-d452-4b0a-86ce-4cc21833061f	6a4uXOZ1lz4rirqMuB7h	2390	Tiramisu	Pastries	5	196.55	2025-08-11 18:24:48	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.delacruz10	2025-08-11 18:24:48
87a59904-8863-4681-aa3e-10dfa9cdadec	QdwzDT9zTBwNOQ07GnEq	2395	Tea	Beverages	5	106.18	2025-05-14 11:46:03	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	rosa.rivera7	2025-05-14 11:46:03
02ad85d4-0ced-4d6b-9763-fab306245ba1	kO9m7ZpttfAJSDbRNsCn	2396	Chai Latte	Pastries	1	100.50	2025-11-24 00:51:07	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904871548	pedro.cruz14	2025-11-24 00:51:07
8d392d16-a8f1-420d-aa48-65f217819505	pwH2QLzO5RhVm05Cuq5v	2398	Eclair	Pastries	4	146.12	2025-02-21 07:05:38	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	miguel.cruz15	2025-02-21 07:05:38
68e68448-c90c-4338-8902-ac944d7933f4	BvkHOZF18Yjpf4cqFETc	2400	Tea	Beverages	4	106.18	2025-02-26 16:55:28	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	pedro.cruz14	2025-02-26 16:55:28
872d85ce-2e88-48c4-a662-a88ee8730b50	xxn845pfkFDb12yH1CsW	2402	Espresso	Pastries	5	195.76	2025-11-24 18:25:12	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904499735	carlos.mendoza	2025-11-24 18:25:12
cecae145-7178-4458-ac05-4cf96d70092e	vtrd7ancUnmIKfnW7fFv	2403	Espresso	Pastries	5	195.76	2025-08-07 11:49:38	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	fernando.cruz	2025-08-07 11:49:38
1f82c8de-cad7-4b0a-8d68-8eec1ab8399c	VHrYtiozVBruoOLbgfSu	2411	Latte	Pastries	5	108.74	2025-06-29 21:20:28	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.santos8	2025-06-29 21:20:28
2524bf47-a029-48df-9fb3-a9b7c6d8e69a	pYwOdjlyHJP6RdQnO65d	2417	Macchiato	Pastries	5	93.97	2025-11-13 21:18:43	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904181391	carlos.cruz12	2025-11-13 21:18:43
a4a37cb4-5fc6-4163-afda-ffa2ec220c5b	XabngFBB0dJzdUEX9Hme	2423	Iced Mocha	Pastries	4	144.00	2025-10-24 03:43:32	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	gabriela.mendoza	2025-10-24 03:43:32
c1e1ccd0-0d5b-45d4-ad49-cc7e42f78cb1	x3aO7DjGd18noxoyt1aB	2427	Mocha	Pastries	4	61.74	2025-01-03 14:33:32	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.santos8	2025-01-03 14:33:32
9f75a022-2259-4651-b619-9b3648017c5f	s8kLxbu54REK03gQltHc	2429	Mocha	Pastries	2	61.74	2025-10-16 22:26:57	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	fernando.cruz	2025-10-16 22:26:57
a4e0d35a-14eb-4a6d-80db-ed1a0926186c	HY06drcx7DAibzZEHTo5	2433	Tiramisu	Pastries	2	196.55	2025-08-01 01:10:32	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	sofia.bautista5	2025-08-01 01:10:32
f7c9827d-c9bd-4dd0-b83d-8f60a438b668	BJu81qR0kMMjSXseOSRi	2435	Tiramisu	Pastries	5	196.55	2025-11-13 00:53:05	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carmen.santos1	2025-11-13 00:53:05
3307e6be-2e2f-4471-a4df-a260b62861ee	zFfhixceVJJCsDgdCGdU	2436	Espresso	Pastries	4	195.76	2025-02-28 06:37:51	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904811987	antonio.santos6	2025-02-28 06:37:51
7da4309e-066e-49f9-be35-824254a09488	aeHG4spPk9chfCYW6kWa	2442	Latte	Pastries	1	108.74	2025-10-12 19:45:19	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	admin	2025-10-12 19:45:19
c49eb5f8-8402-41d4-9a1f-a2f7de70f7cb	tOtXZLWJG2UBeJOB7HGU	2443	Blueberry Muffin	Pastries	4	185.15	2025-04-27 15:59:54	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.cruz	2025-04-27 15:59:54
31283143-c2ea-4c92-bc0c-d74b9bc46409	wnKxuG7d2apMW7o9WqTj	2448	Chocolate Chip Muffin	Pastries	2	103.79	2025-05-27 15:54:40	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	antonio.delacruz10	2025-05-27 15:54:40
16bfe0ba-3d09-412a-b950-ab7790b6fd3f	JhyTus6jlFtQmOSTWLqg	2450	Iced Mocha	Pastries	3	144.00	2024-12-31 16:41:38	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904957179	carlos.cruz12	2024-12-31 16:41:38
f5b0c8ae-305c-4644-a63b-c058bda131c4	\N	\N	Almonds	Pastries	1	5.59	2025-11-25 11:06:09.130337	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2025-11-25 11:06:09.130337
20f94d9a-e5a1-4ce4-b9ab-a1e001122b8f	vANJAy9fpxAc2ifdzqOj	2451	Mocha	Pastries	1	61.74	2025-06-09 15:01:33	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904055690	rosa.cruz13	2025-06-09 15:01:33
35aa1856-d26d-446a-bb8d-896e741d39c9	sv8X08GjSgk6wRNhCreZ	2453	Almonds	Pastries	1	5.59	2025-07-08 01:28:01	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904256708	antonio.santos6	2025-07-08 01:28:01
932f02ca-c942-402f-8f30-9cdaadeebf94	iEVsel8cfoNwWsE1Fgc5	2461	Flat White	Pastries	5	113.21	2025-07-24 23:06:54	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	antonio.santos6	2025-07-24 23:06:54
9fcfdd2f-311d-43e6-9a03-1d46cadb7ed5	cymeWJ98mOog4STDJ2Fu	2465	Macchiato	Pastries	4	93.97	2025-03-03 03:38:27	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904068268	gabriela.mendoza	2025-03-03 03:38:27
4e82c359-c85e-4a02-a21a-a648cf22d7c1	OKcQMDnMsLdoYUXwDxVT	2466	Hot Chocolate	Pastries	3	131.53	2025-11-11 19:42:24	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.delacruz	2025-11-11 19:42:24
1847e035-3658-4dd4-983c-f828e7f0377c	1BW2zVaTuElLnmjjV3A8	2467	Chocolate Chip Muffin	Pastries	1	103.79	2025-03-22 18:01:29	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	ana.rivera3	2025-03-22 18:01:29
16b75ad6-d431-485d-b491-8658c5cc0c00	tkPsByknlEMM0GcThd41	2468	Hot Chocolate	Pastries	4	131.53	2025-03-16 13:04:06	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	rosa.rivera7	2025-03-16 13:04:06
fc39a395-f995-497d-8648-c53a59f7e10e	PJCkdHxt0LR7EqLVSuZb	2470	Espresso	Pastries	4	195.76	2025-04-29 13:54:53	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.mendoza	2025-04-29 13:54:53
389622d4-4e16-47c6-a5dd-7a1f6dbf3991	LT16qpxYGSMIlfXDIe5X	2473	Iced Coffee	Beverages	4	107.80	2025-02-03 06:34:05	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904482329	admin	2025-02-03 06:34:05
4d0d0a01-5f93-479f-a052-05894d898354	cJQHThyVe5ZGkFCSc8CQ	2480	Hot Chocolate	Pastries	4	131.53	2024-11-27 00:18:41	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904645404	fernando.cruz	2024-11-27 00:18:41
98fcc0e9-aa8b-4c23-b94b-981ed19c01f5	vbthyZ3trnmOcx1ROTqD	2483	Iced Mocha	Pastries	5	144.00	2025-10-04 02:00:42	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	sofia.reyes9	2025-10-04 02:00:42
cda05dc5-0919-4e3a-85fa-aaf60263f8ad	Kcx2A79rUssshDhcp9pT	2484	Latte	Pastries	1	108.74	2024-12-01 03:11:08	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.cruz13	2024-12-01 03:11:08
6ee78734-a589-437f-8e0b-0647697e594e	HrUo5lM5dtx3y8pEdfXk	2485	Almond Croissant	Pastries	3	8.42	2025-08-27 11:06:22	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	miguel.cruz15	2025-08-27 11:06:22
7ffdf948-7936-4e92-b42a-540debfad911	HDKDgOpj0lU6VqgSWI2Z	2486	Iced Coffee	Beverages	3	107.80	2025-10-26 16:46:35	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.delacruz	2025-10-26 16:46:35
00509ab1-7656-4d1b-83f8-06804e480087	xCOkf2Bp5q7B5wruG5HF	2491	Tiramisu	Pastries	4	196.55	2025-09-10 06:48:13	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	gabriela.mendoza	2025-09-10 06:48:13
6a63229e-73fe-4500-b381-06892d39f106	3IUpldWiNv9fVD7NW9Jn	2492	Macchiato	Pastries	3	93.97	2025-01-22 06:30:39	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	rosa.rivera7	2025-01-22 06:30:39
3a062636-7688-4a7e-91b4-cb57511f601d	JDOLDOLc0aHPKBusJcRt	2493	Espresso	Pastries	1	195.76	2025-03-14 09:07:35	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904851705	antonio.delacruz10	2025-03-14 09:07:35
d5fcc81b-2480-48bb-914e-fa6defebaf2f	GgWEXRyF5nj9fp1hA7Qu	2495	Hot Chocolate	Pastries	2	131.53	2025-08-18 22:22:01	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	sofia.reyes9	2025-08-18 22:22:01
0710301f-7d4d-40de-8f03-0a0b0a8f861d	nvtiEISzsQaGH1eRoFlW	2500	Tea	Beverages	4	106.18	2025-09-07 16:50:21	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.delacruz	2025-09-07 16:50:21
a2222f9f-9f5b-4674-a94b-e414893f5cc7	FrYfVDHikvJEjQLZuHNr	2503	Baguette	Pastries	5	133.77	2025-11-01 15:53:22	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	fernando.santos8	2025-11-01 15:53:22
ba2bf168-fe9d-4030-8aaf-eae0dcf09e4c	5bD1HxGfZ4vKj0D5ANBX	2504	Eclair	Pastries	5	146.12	2025-07-20 16:25:04	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	rosa.cruz13	2025-07-20 16:25:04
0f7515b1-81e3-46df-ba75-291f13109eb3	Y5mh8jaW9SGSt3U4r0Id	2507	Almond Croissant	Pastries	4	8.42	2025-06-01 00:38:07	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	isabella.delacruz4	2025-06-01 00:38:07
a242e24b-39a4-479a-b579-bc10c65a4c6f	WMU2Bge8YBuBnJONxCay	2512	Tea	Beverages	2	106.18	2025-06-16 20:05:32	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904101327	sofia.reyes9	2025-06-16 20:05:32
17bab464-c825-41aa-8dac-8ca3966e05b5	ZY9sawjZS2445tZmD2jw	2516	Almond Croissant	Pastries	1	8.42	2024-12-21 00:52:26	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.santos6	2024-12-21 00:52:26
26c045a7-117f-458f-b037-870a508454d6	oecqg674StggBxbik0gL	2517	Iced Mocha	Pastries	4	144.00	2025-09-23 12:30:32	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	admin	2025-09-23 12:30:32
0aadafd7-8ca1-446a-8b5c-7b58fdbcf415	gQS4KxCj3GZdGmGpc8rX	2519	Hot Chocolate	Pastries	2	131.53	2025-05-17 19:04:39	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	elena.torres2	2025-05-17 19:04:39
c07eaeae-4ae4-4360-9c82-84cb89cfd957	jyoepkHN18OHCABptnJR	2520	Hot Chocolate	Pastries	2	131.53	2025-05-14 00:10:54	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904852669	carlos.delacruz	2025-05-14 00:10:54
491d659f-cd36-4d99-8176-d0cbdf5018e9	Qc0fasnSxfnze3yuvWjc	2523	Tiramisu	Pastries	2	196.55	2025-01-27 18:32:06	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	admin	2025-01-27 18:32:06
1b47d4dd-7cd2-4594-9957-6be032491e60	iswpu8tJMU4dk6g4E0Vv	2524	Chai Latte	Pastries	3	100.50	2025-08-30 19:01:44	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904040678	carmen.santos1	2025-08-30 19:01:44
30db90fc-b653-44a3-a0b0-2caa2a90aade	WIYcOwoeFG4mfzyOYTQb	2529	Blueberry Muffin	Pastries	5	185.15	2025-08-08 10:27:05	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904389690	rosa.rivera7	2025-08-08 10:27:05
d5e5cf17-95db-42cc-93b8-3ce644959a83	MSXfOjTkNdWs8GD6hhu0	2533	Almonds	Pastries	1	5.59	2025-08-03 01:05:05	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.reyes9	2025-08-03 01:05:05
6cded441-561e-42bc-a62f-990c25561d24	MnOHGWtCEQ3N7YtdLFNR	2540	Almond Croissant	Pastries	2	8.42	2025-09-04 19:23:57	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904341332	admin	2025-09-04 19:23:57
01164746-fe90-4b96-a283-114dd6e833a8	OEYzdyx30XqISDH77H9e	2542	Americano	Pastries	4	80.96	2025-01-23 15:33:55	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904565487	rosa.rivera7	2025-01-23 15:33:55
62468ccb-81e1-4a58-afc2-44cfa4cc47ef	BDWUJ456yh21BhSwgflD	2544	Macchiato	Pastries	2	93.97	2024-12-24 19:58:42	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	isabella.delacruz4	2024-12-24 19:58:42
0d68f094-4cb3-44af-8cb0-fb032707a16c	H9FGcuCBdGkOFlOB7zTq	2545	Latte	Pastries	5	108.74	2025-11-10 17:22:44	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.cruz12	2025-11-10 17:22:44
2f0f7337-f34c-457b-99d8-a037b24903ab	ffChkm8MH0BH4OFPEJW4	2557	Blueberry Muffin	Pastries	3	185.15	2025-07-30 01:40:49	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	sofia.reyes9	2025-07-30 01:40:49
785e9704-4d2e-40f3-9147-3b2a4a5b1740	bNmsD5lRcw4aQPTIqj0b	2560	Flat White	Pastries	4	113.21	2025-10-01 23:01:10	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904865628	carlos.cruz12	2025-10-01 23:01:10
0a16abd5-ae53-4689-b51b-c3ef060d9af9	k3Ql6jjl1KTjhDe9H4iF	2564	Flat White	Pastries	3	113.21	2025-04-04 06:14:06	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	ana.rivera3	2025-04-04 06:14:06
60a011e8-7ca6-4b54-9e03-0431d08d4efa	vUMS6r5chMBZh68GeDJA	2565	Macchiato	Pastries	5	93.97	2025-01-19 13:19:35	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.delacruz10	2025-01-19 13:19:35
af15e26a-18bd-4bab-8540-72a7d75ef0df	BxWSjlqeXMcoPxlEggzQ	2566	Americano	Pastries	5	80.96	2025-11-05 17:06:26	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904595643	elena.torres2	2025-11-05 17:06:26
e22ef9f8-9fc7-4159-b885-9e90849754e8	YD2ot3stshBfXhilBncG	2568	Espresso	Pastries	3	195.76	2025-02-12 17:00:18	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904691844	fernando.cruz	2025-02-12 17:00:18
1b6cef01-b718-43e4-bbc6-ae498d866d1d	ACuhhUWxnJ0GltBJZjfO	2569	Chai Latte	Pastries	4	100.50	2025-09-24 16:22:10	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	ana.rivera3	2025-09-24 16:22:10
b6631007-002b-4eed-8403-fa63abc36de6	ie6Qwz4PhIYQzieFlxWt	2573	Tiramisu	Pastries	5	196.55	2024-12-07 15:10:51	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	rosa.rivera7	2024-12-07 15:10:51
e7b9c537-9d50-4e8d-a6e9-9b12e8e75997	IK59JGBzV5p1ZkMdAb9p	2576	Apple Turnover	Pastries	1	154.54	2025-02-24 20:15:48	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904916377	antonio.santos6	2025-02-24 20:15:48
a07d2533-59f0-4cb0-a854-2a18da53c9e1	\N	\N	Almond Croissant	Pastries	1	8.42	2025-11-25 11:53:43.009297	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2025-11-25 11:53:43.009297
23c532f7-014b-4bfa-ba6c-14be43e95a3a	AxZNNVdXoSpp24RgjAIi	2582	Almonds	Pastries	2	5.59	2025-11-02 02:53:53	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	miguel.cruz15	2025-11-02 02:53:53
2460c5d4-15f2-4a3d-8eb1-d74d4599fc35	dlV9SxOEQq7AnjWs4kMT	2583	Baguette	Pastries	5	133.77	2025-01-16 20:54:09	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183904166606	carmen.santos1	2025-01-16 20:54:09
e45519c8-28dd-49e7-a6b2-7657d5d533c5	ODH8gMNEjNqLIoOUXL8U	2585	Blueberry Muffin	Pastries	4	185.15	2025-06-04 09:23:06	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904328686	antonio.santos6	2025-06-04 09:23:06
57c689c9-9603-4c28-956e-45fced2366ed	1w0eiKDz2CfUhK2P93hh	2589	Latte	Pastries	2	108.74	2025-03-18 11:35:36	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	antonio.delacruz10	2025-03-18 11:35:36
665da2ed-c071-447d-b27e-cba888edc98e	hQx6ykBOA4sENOSorjJx	2591	Iced Mocha	Pastries	4	144.00	2024-12-30 04:09:29	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	rosa.cruz13	2024-12-30 04:09:29
7999401a-fc90-4763-bcbc-e3a2131684f1	R5tDCB3VPeX8qrOaRJEm	2592	Iced Coffee	Beverages	3	107.80	2025-04-18 20:57:31	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	sofia.reyes9	2025-04-18 20:57:31
c782f38b-09a7-4a74-aae7-803f48447c43	HiuJTzKUqP8w8nLVorVn	2597	Hot Chocolate	Pastries	1	131.53	2025-09-12 21:31:06	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	miguel.cruz15	2025-09-12 21:31:06
6571644d-1136-4ddb-bf9f-4352dd491fac	1vYYiB3DxqnfTMuR1BfT	2600	Flat White	Pastries	3	113.21	2025-09-23 18:45:50	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904434870	rosa.rivera7	2025-09-23 18:45:50
46714569-2481-4f81-8ac8-60685b6cf569	d709IuFZtwUAkb49FR77	2604	Hot Chocolate	Pastries	5	131.53	2025-01-22 21:20:37	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904690154	sofia.bautista5	2025-01-22 21:20:37
bba36ec1-0f42-43c9-ab01-263afa32d867	L8DQSUKHNZaT3KhaacNx	2606	Mocha	Pastries	5	61.74	2025-03-01 15:15:21	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	ana.rivera3	2025-03-01 15:15:21
275f1ae1-2864-424d-a5ff-ea62514c6945	Rnu3dyRSnzdPVB4xLC1J	2607	Cappuccino	Pastries	3	76.25	2025-07-07 20:38:20	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.santos6	2025-07-07 20:38:20
21d4f0a2-5fdf-43ac-9155-20ede9b1cf62	PkTHD0lGrInGqReFL072	2611	Latte	Pastries	4	108.74	2025-04-13 14:35:28	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.cruz13	2025-04-13 14:35:28
3f60e851-0080-42a5-b339-709946ef919f	ms7wS1Q14WzrXw40juhW	2613	Iced Coffee	Beverages	2	107.80	2024-11-28 15:07:14	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	rosa.rivera7	2024-11-28 15:07:14
6bb5171f-d64a-4c55-bd33-92fce30b5f51	wsvU43v61Vi1ccHCs9JM	2615	Hot Chocolate	Pastries	3	131.53	2025-03-27 10:51:10	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	admin	2025-03-27 10:51:10
697307f3-71c3-45c8-b9d0-4225e47528bc	4LndGYoJBQHm9SvjeJVj	2616	Mocha	Pastries	4	61.74	2025-07-06 21:40:27	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.santos8	2025-07-06 21:40:27
2a00bfa3-25a5-429f-ba49-62b30d81d06b	Sjswh9kjJ1gZT4jjQpAf	2618	Almonds	Pastries	3	5.59	2025-04-08 02:17:28	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	sofia.bautista5	2025-04-08 02:17:28
c70b6ef4-85f8-47a2-8ca6-e53708980f52	dJzjcQL9fiXO64btU3JO	2623	Flat White	Pastries	2	113.21	2024-12-01 21:38:38	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.cruz12	2024-12-01 21:38:38
6c47931c-f305-42c1-81f8-c28d3230eba2	e2KV7cHw1NU2NLCqsbnQ	2624	Americano	Pastries	2	80.96	2025-08-11 09:51:01	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	ana.rivera3	2025-08-11 09:51:01
379e858c-fdab-4a5e-b83b-13ce8aec4f4a	2Znrgb3Xw8wJm0ULQ9KP	2625	Chai Latte	Pastries	5	100.50	2025-01-01 05:22:36	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	elena.torres2	2025-01-01 05:22:36
2b266416-78c4-4598-b4d8-4f57392da82b	ZAkfEQjWdJU37CcHsyXM	2627	Cappuccino	Pastries	5	76.25	2025-10-08 21:58:58	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.santos6	2025-10-08 21:58:58
92b484c7-a118-4840-b76e-1c3881d71b33	NX8YcHFsm7CHjfJIMOav	2628	Macchiato	Pastries	1	93.97	2025-02-26 09:22:43	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	pedro.cruz14	2025-02-26 09:22:43
e298d06b-0ede-46e2-817f-b1c733678fe6	g10a92R4ANn1RenqSGBJ	2636	Latte	Pastries	4	108.74	2025-02-13 01:35:06	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	gabriela.mendoza	2025-02-13 01:35:06
132dfd12-91a5-48ac-83ad-712d0121caf7	DAK8b3DYXN1uMmoPQjOX	2639	Latte	Pastries	5	108.74	2025-04-21 17:10:17	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	elena.fernandez11	2025-04-21 17:10:17
29abfebb-7614-4951-964d-a9df4656adca	yL12KcH5zhLiiIolWJOG	2640	Almond Croissant	Pastries	3	8.42	2025-01-21 17:28:31	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	isabella.delacruz4	2025-01-21 17:28:31
f9e174f6-e754-4e60-afba-609895aa7fd5	aBUwHLMVnKVxdik0UKPs	2641	Apple Turnover	Pastries	2	154.54	2025-09-23 06:35:08	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904073903	gabriela.mendoza	2025-09-23 06:35:08
155e6147-6a7f-4fe1-9a99-bb570af19b66	cEaqPYY2vA2DlZCOOj2G	2644	Cappuccino	Pastries	2	76.25	2025-10-12 14:28:21	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.fernandez11	2025-10-12 14:28:21
7993f2ed-ddd4-4482-8787-84ef11e92fff	NgHBp318HXhMqqueRvQf	2646	Macchiato	Pastries	1	93.97	2025-08-01 13:30:17	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904104473	carlos.cruz12	2025-08-01 13:30:17
63ac6b63-5c46-42d9-b4b0-c6cc632f8d7e	5n5f0Hp6WmejzYXAkm0E	2647	Baguette	Pastries	3	133.77	2025-09-15 07:13:08	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	rosa.rivera7	2025-09-15 07:13:08
91625271-cc93-45ce-aa95-be7e9766fe45	PxVAFNMSqTJg5aapLwHD	2650	Chai Latte	Pastries	5	100.50	2025-06-26 09:45:31	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	isabella.delacruz4	2025-06-26 09:45:31
b4a194e3-4a49-45ce-bea7-f7a44b52eef3	hTjNaw4eLgHVuvCo7oE1	2652	Almond Croissant	Pastries	1	8.42	2025-08-12 02:37:53	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	elena.fernandez11	2025-08-12 02:37:53
a36c3ae9-b835-4f57-ab36-ee392a30c29a	MFWNQwuL81IHN6nIrjFY	2657	Iced Mocha	Pastries	4	144.00	2025-10-09 21:10:26	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	ana.rivera3	2025-10-09 21:10:26
5517715f-06ae-4c07-aa5b-e60723587d98	gd05Cc3Nw4w7nfFiBrmO	2658	Iced Mocha	Pastries	4	144.00	2025-05-22 17:50:03	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904051092	carlos.delacruz	2025-05-22 17:50:03
43f132d0-7a28-490d-a204-064df23e35c0	bSxmzJXA47to2MRdtJnN	2661	Chai Latte	Pastries	2	100.50	2025-07-01 02:39:10	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	antonio.delacruz10	2025-07-01 02:39:10
06974273-4e30-4584-a395-a0336b142d2f	rhTUIXg4XNURWxz5sg9z	2663	Chocolate Chip Muffin	Pastries	4	103.79	2025-10-14 05:50:22	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904477558	miguel.cruz15	2025-10-14 05:50:22
bd46c781-564e-4f5d-bc69-24f88eec2fb8	dTAxvfwk3b7QkUAZbKho	2664	Mocha	Pastries	5	61.74	2025-01-27 14:37:15	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	elena.torres2	2025-01-27 14:37:15
7a1c3d82-2129-4c58-ae5a-9a019a9f364f	8C86kyEHApAvkUCfhKMv	2667	Flat White	Pastries	1	113.21	2024-12-23 23:23:28	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904455344	carmen.santos1	2024-12-23 23:23:28
f8d0599c-8c52-418f-831e-e9a42b864b33	\N	\N	Almond Croissant	Pastries	1	8.42	2025-11-25 11:53:55.480319	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2025-11-25 11:53:55.480319
75d69661-d1f0-434d-aac8-bcb2407737f9	wKBKaW2SsWeIZfpb4SKn	2668	Red Velvet Cake	Pastries	4	187.25	2025-08-14 10:00:25	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904145996	sofia.bautista5	2025-08-14 10:00:25
9395cb75-9454-44e7-8396-740573628f6b	UPuJ4iJdscSt83RVFVvM	2672	Tea	Beverages	1	106.18	2024-12-23 18:41:07	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904363949	carlos.cruz12	2024-12-23 18:41:07
598625e4-f0c1-4f77-bbb7-baeb982664a6	3xjH0wiOQE8GrrSh1yZE	2674	Cappuccino	Pastries	2	76.25	2024-12-24 01:46:28	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.delacruz	2024-12-24 01:46:28
049d5205-5ac2-4d9a-b890-184550da0cfb	1NgAP8O7ZPMzriXBwhp4	2676	Chocolate Chip Muffin	Pastries	5	103.79	2025-02-03 14:56:58	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	isabella.delacruz4	2025-02-03 14:56:58
58b95e26-5741-4732-a6b1-29d340ac9234	HFIRDHNdvps4T3UAKKfR	2682	Tea	Beverages	5	106.18	2024-12-20 20:52:49	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904934984	fernando.cruz	2024-12-20 20:52:49
bae1a47b-dd37-4cfe-9069-cc62c289de02	6DBfM7l39VSRLIWN7mz8	2683	Red Velvet Cake	Pastries	1	187.25	2025-11-22 22:24:46	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904138952	antonio.delacruz10	2025-11-22 22:24:46
4d822ca0-ef3b-479f-b323-4e46c106e7ba	Xxu8zxRSkHdja7MBQsvU	2685	Flat White	Pastries	2	113.21	2025-11-21 05:11:29	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carmen.santos1	2025-11-21 05:11:29
61b21b69-8a19-4836-a961-615bb94c3994	4FmIZBhxtUnNchtdyfgE	2686	Americano	Pastries	2	80.96	2025-04-20 04:27:50	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carmen.santos1	2025-04-20 04:27:50
5eb29bbf-2498-41ac-8d8b-f715459dac45	L3UMxf7RBYaFalyWiIDC	2688	Latte	Pastries	4	108.74	2025-10-05 21:03:04	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	sofia.reyes9	2025-10-05 21:03:04
3dd48a4b-21fc-4d02-b41d-b6aaddf55fcf	S87zRVdlFgFOE6Uoz1tO	2689	Flat White	Pastries	3	113.21	2025-06-17 06:37:14	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	miguel.cruz15	2025-06-17 06:37:14
42cc7e21-25f3-4b86-af1d-14243e0b2f32	BdM18n4wRDQ45HymjMhB	2690	Latte	Pastries	2	108.74	2025-01-02 00:36:14	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904094681	miguel.cruz15	2025-01-02 00:36:14
fb5d218b-9ce1-47ef-8930-2cb435d75ca0	3aetoK4MjDSv7QnTqWH4	2694	Chai Latte	Pastries	4	100.50	2024-11-24 22:47:05	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.bautista5	2024-11-24 22:47:05
43c1f835-6998-42b3-aa28-fe12eae42e55	I4H32WAUDI6poZopEc8y	2695	Iced Mocha	Pastries	5	144.00	2025-10-22 18:59:40	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.mendoza	2025-10-22 18:59:40
012044f6-593f-44f2-acc0-23a9bb2d3dc9	LlhDqUKKIbeCEZS0Pmun	2699	Tea	Beverages	1	106.18	2025-09-09 10:53:59	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904937914	carlos.cruz12	2025-09-09 10:53:59
ba44b343-7856-4fdd-b7b0-8c4a978b7071	3fa0PejzlD3FECjzCVWB	2706	Eclair	Pastries	4	146.12	2025-04-18 00:00:52	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	pedro.cruz14	2025-04-18 00:00:52
6a91fd90-bbdd-4901-ba65-72006bfb92b3	SA6baIWsa5aZZb8Lwpnw	2708	Chai Latte	Pastries	2	100.50	2025-08-16 05:39:24	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	rosa.rivera7	2025-08-16 05:39:24
ff18fd6c-47c4-422f-95dd-7797a0806d02	oGOt1a8GnHBWqb31quDo	2710	Almonds	Pastries	3	5.59	2025-03-11 21:11:42	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	gabriela.mendoza	2025-03-11 21:11:42
a6250909-62be-4f4a-878f-b448c43ac97b	JI6TbqsaXvkHNqFX8WXe	2720	Apple Turnover	Pastries	2	154.54	2025-04-05 05:31:14	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.delacruz10	2025-04-05 05:31:14
cf197c2b-def5-4b6e-b89e-ee3369e7e9fa	3vYBvuYhepgomB688inp	2721	Mocha	Pastries	2	61.74	2025-07-03 11:31:28	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	admin	2025-07-03 11:31:28
731d78f0-de35-4766-b35a-fa6d0edc0482	7J2oV3xkeS803PyDnRJJ	2723	Iced Coffee	Beverages	5	107.80	2025-08-05 07:09:34	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.cruz	2025-08-05 07:09:34
feae6e7a-f122-4f47-ac62-9abd3cacc167	FXduDWBIedxa4QF4K0Qm	2732	Macchiato	Pastries	2	93.97	2025-07-13 05:40:53	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904036203	admin	2025-07-13 05:40:53
df6b9c86-5372-4a6a-b118-bc16becd34e9	XNj4kqA1r86Oi0lbAjfl	2744	Glazed Donut	Pastries	1	148.75	2025-03-13 21:49:12	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904237164	pedro.cruz14	2025-03-13 21:49:12
c5dbdc29-a574-4fdb-b06c-025889ff8aee	jVgAvoeCeLE4uspa2mSD	2748	Espresso	Pastries	4	195.76	2025-04-19 06:30:24	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.cruz13	2025-04-19 06:30:24
9bf16582-b5cf-4cdf-add3-19b82bc1f39d	nDZbw5hDYkYs3NCxGhWN	2749	Tiramisu	Pastries	3	196.55	2025-05-02 03:43:11	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	admin	2025-05-02 03:43:11
508cde68-c686-4fe8-8ba7-b3e1e11f8c14	PR9ua9SxIpcFz54vLebG	2752	Red Velvet Cake	Pastries	4	187.25	2025-04-24 07:08:27	22893c15-bd77-4029-b8ca-3bb58becab1f	Card	\N	ana.rivera3	2025-04-24 07:08:27
4c21c2ed-8c61-4b8c-ac09-84a1cbe22c52	ikkTRVi4KpmTLpSHwGdc	2754	Chai Latte	Pastries	1	100.50	2025-03-29 16:27:54	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904428598	rosa.cruz13	2025-03-29 16:27:54
cf45d1c0-31e2-45e7-90d8-ec33c1f81756	lWpqAsnDiT3xx107LLWL	2755	Baguette	Pastries	4	133.77	2025-06-08 16:38:45	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	rosa.rivera7	2025-06-08 16:38:45
0e2598b9-6551-47dc-b820-8e4924c695c0	6Yb9MmwCBjgFOxfewwaN	2758	Eclair	Pastries	4	146.12	2025-03-20 16:34:35	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	miguel.cruz15	2025-03-20 16:34:35
ddf5f496-6604-48d9-a4bd-e6506d0a01cb	0pwfWY3nHs2eDGavSivI	2761	Chocolate Chip Muffin	Pastries	3	103.79	2025-11-04 09:15:05	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.cruz13	2025-11-04 09:15:05
a6a839d0-3a94-40bc-af28-6e38f0171ebc	c2qDYn8ZppTNhKzjEFnp	2764	Almond Croissant	Pastries	1	8.42	2025-11-13 12:27:19	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	elena.fernandez11	2025-11-13 12:27:19
45d3fcf9-523c-4cd0-bd44-51a5b4eef307	SJnRVSx8lAzf16EmXn28	2766	Almonds	Pastries	1	5.59	2025-10-16 14:54:52	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	fernando.santos8	2025-10-16 14:54:52
32b520b1-9af1-447c-a3e5-29c8935a5642	YhQs1tqIyIRoRMHQCN7P	2770	Glazed Donut	Pastries	5	148.75	2025-10-19 23:42:22	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904604418	ana.rivera3	2025-10-19 23:42:22
22fc9024-76b3-41ba-a705-68b7654126fc	fECbmIBlBb2ccrPkXLhH	2771	Iced Mocha	Pastries	5	144.00	2025-10-09 08:33:57	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2025-10-09 08:33:57
0c18e6b9-bcbd-40ac-a532-76fbcda6a12e	sDQVC5XhnVpc6zcPr5vD	2775	Tiramisu	Pastries	5	196.55	2024-12-19 03:40:03	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904204150	rosa.rivera7	2024-12-19 03:40:03
74003d33-c6f3-4eb0-9a81-bc10d341de93	ifLoNcqR0fCKNRmOD29p	2779	Macchiato	Pastries	3	93.97	2024-12-06 19:18:08	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	sofia.bautista5	2024-12-06 19:18:08
8d2818c5-1fa2-475e-939d-548e64925ecd	oAPBMdNhLuncK9esCHz6	2780	Almond Croissant	Pastries	5	8.42	2025-11-19 05:41:34	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	antonio.santos6	2025-11-19 05:41:34
f38c8a17-7b5c-4742-8fae-ebe712f9c420	MzUXyBAKzdvVe1nMfPvv	2781	Iced Coffee	Beverages	1	107.80	2025-05-17 12:56:20	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.cruz	2025-05-17 12:56:20
77e50e80-042a-4db6-ae32-5cd60f0419bd	bcxvb0oXUBl1jlaXNZVx	2782	Latte	Pastries	3	108.74	2025-07-26 19:02:53	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	sofia.reyes9	2025-07-26 19:02:53
14446c5d-f091-4355-aa1e-6502dd0548a6	M0MIW8OHQJTdyDQYMoqs	2785	Glazed Donut	Pastries	4	148.75	2025-08-25 09:33:26	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904578304	isabella.delacruz4	2025-08-25 09:33:26
396b193c-cd2f-47c1-ac70-97ba9e2829fb	s1NbNTTr3uBXmz7dQLqh	2788	Tiramisu	Pastries	3	196.55	2025-04-19 23:11:39	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.cruz12	2025-04-19 23:11:39
77bb35dd-ffb6-412e-82a7-dff6e4136ac0	FbPYTKy4xk1UFQSGP3N9	2790	Blueberry Muffin	Pastries	1	185.15	2025-09-04 22:43:21	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.rivera7	2025-09-04 22:43:21
d7831eab-4648-45ba-8b24-bfa0d37f4426	XMn0r32KLHvCjoiIoh9s	2793	Baguette	Pastries	4	133.77	2025-09-11 06:58:24	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183904763626	isabella.delacruz4	2025-09-11 06:58:24
006cf2ab-8d42-42d0-806a-76705f72c24d	ILOp6JCdpljmcUKesLEt	2802	Americano	Pastries	2	80.96	2025-10-02 10:59:21	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	fernando.cruz	2025-10-02 10:59:21
6c27da91-d83d-4f2d-95a0-86089c4af63e	IXgH4ARbtTe2QTTFVRVN	2804	Macchiato	Pastries	1	93.97	2025-09-28 18:09:39	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.santos6	2025-09-28 18:09:39
d58a75f9-cf58-4ec2-9239-5077a267aaf4	ArJu7kzHf1r9uTXsc9v3	2805	Hot Chocolate	Pastries	2	131.53	2025-06-28 23:02:46	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	fernando.santos8	2025-06-28 23:02:46
807133de-b740-43c4-9a3f-920a6575f386	F96PBn8QgvzPtoLNiIVR	2808	Baguette	Pastries	3	133.77	2025-01-27 05:40:08	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carmen.santos1	2025-01-27 05:40:08
0a0fd6d3-b2cf-4eb4-8056-bcae09b15942	9MMQMr0haHbPYZHP6aaC	2810	Apple Turnover	Pastries	3	154.54	2025-04-22 10:51:23	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904955436	antonio.santos6	2025-04-22 10:51:23
e5e1fc09-baa7-4f1f-a7c7-e15a00b99918	NoprbX4xoV5jleSJvNqw	2811	Chai Latte	Pastries	1	100.50	2025-11-08 02:00:27	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carmen.santos1	2025-11-08 02:00:27
55367bba-fb7b-4409-bd5d-9f677c60ea5e	VFwwS1bfmtgDirvKndvU	2814	Blueberry Muffin	Pastries	2	185.15	2025-03-21 08:24:19	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.cruz12	2025-03-21 08:24:19
2b3f4565-469b-4da5-8af2-2f68b70d3227	US7eF6BxbkE5aUnTZ5yE	2822	Flat White	Pastries	5	113.21	2025-07-18 06:31:09	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.delacruz	2025-07-18 06:31:09
49512a0f-6064-4f0e-85db-463bc1ba93fb	3L4D1uDSzkTYu8mrhxkn	2825	Americano	Pastries	2	80.96	2025-10-06 23:41:19	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	antonio.delacruz10	2025-10-06 23:41:19
5b8e4059-252e-4c39-81f2-746aa1a94c68	OvoAHuDC01dzLbr0naUX	2827	Chocolate Chip Muffin	Pastries	2	103.79	2025-06-18 17:53:24	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904883604	fernando.santos8	2025-06-18 17:53:24
22369e93-4e3a-4b59-a292-d2556b8dce68	07KaJy1BxkgUuGv5fe3Y	2829	Red Velvet Cake	Pastries	5	187.25	2025-08-09 17:16:49	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.delacruz	2025-08-09 17:16:49
15b94803-535b-4f23-b3c4-ca9fdcb7249b	JUAnSJ1bRjOOQ4T9ktfY	2834	Tea	Beverages	2	106.18	2025-07-27 16:05:39	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	rosa.cruz13	2025-07-27 16:05:39
442ad352-864b-4e0d-84de-2979d48d0ebd	1Da9yhCNyrNQvVSezRgw	2836	Chocolate Chip Muffin	Pastries	4	103.79	2025-01-12 19:49:33	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904919802	gabriela.mendoza	2025-01-12 19:49:33
068698d2-6e90-43bb-82e0-719b4dace2ef	MexdxWBn0w5sk9jsL7YR	2846	Mocha	Pastries	2	61.74	2025-09-22 08:42:39	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.bautista5	2025-09-22 08:42:39
5e222489-bdc1-4689-aca6-7cfcca77c445	vNs72av6pHYx4niZ6PDE	2848	Eclair	Pastries	3	146.12	2025-06-08 02:37:35	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904789504	sofia.reyes9	2025-06-08 02:37:35
2158815f-f673-4478-9562-da4298e3a005	iqT88N8YjPPRl1iajq7G	2854	Iced Coffee	Beverages	1	107.80	2025-10-23 19:13:37	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	rosa.rivera7	2025-10-23 19:13:37
326012f8-9d63-47cb-92c1-60a2450ea205	G0UXw2RqLwbGU5In7bKE	2855	Iced Coffee	Beverages	4	107.80	2025-07-25 22:49:38	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.bautista5	2025-07-25 22:49:38
9fb1906f-c29d-45d2-aa47-56e318bd76a2	PJkrGcHZgk7x2urbkdtb	2856	Espresso	Pastries	3	195.76	2025-04-27 00:21:34	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	antonio.santos6	2025-04-27 00:21:34
963db2d8-e63f-4ccf-a3e4-08b8d44ffd01	mmuLGBW4lz3Cf8dT1Rh4	2857	Latte	Pastries	3	108.74	2025-01-31 14:12:11	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904055433	carmen.santos1	2025-01-31 14:12:11
4469be1e-abbe-4a90-9eb3-55c0b7bc55c6	cOUf7F6AT0TFtOBoza03	2859	Almonds	Pastries	1	5.59	2025-10-20 00:32:08	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	rosa.cruz13	2025-10-20 00:32:08
07846c94-f440-4768-b2fe-d50d024c98fe	1fob2ir8eOVuXqFnXOzq	2860	Mocha	Pastries	1	61.74	2025-03-15 02:29:35	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904864186	sofia.reyes9	2025-03-15 02:29:35
fb8f77f0-efc1-457d-be6d-a383a8f6a02c	g6JxTTCQTFeo79sfTUpW	2861	Iced Mocha	Pastries	5	144.00	2025-09-12 21:18:58	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	gabriela.mendoza	2025-09-12 21:18:58
dfaa445b-bff7-47eb-86bd-6e069a154ef7	4y0dBguPOwpjS6B1Uepr	2862	Iced Mocha	Pastries	1	144.00	2025-10-21 17:56:34	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.mendoza	2025-10-21 17:56:34
fd9a984a-960a-4f3b-b45f-8c0bd1bb92e7	pwKBvwuGtn5p02dqaRoI	2869	Americano	Pastries	4	80.96	2025-08-26 13:15:46	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	antonio.santos6	2025-08-26 13:15:46
bb1fe8ad-68e4-4043-8ffb-75e029572908	37QUzLjXQc9BCx0H3IeN	2871	Almond Croissant	Pastries	4	8.42	2025-06-27 04:38:51	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904870633	isabella.delacruz4	2025-06-27 04:38:51
0664c66f-a523-40a3-8039-ed2e0d8e4ed7	A7YzPreCPMhAYuuQC4NJ	2877	Chocolate Chip Muffin	Pastries	5	103.79	2025-03-06 03:54:54	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	antonio.delacruz10	2025-03-06 03:54:54
34be9841-0534-488e-b95f-2f5b45cb4e81	S5kT1hSg5pQb59urEFYb	2879	Chai Latte	Pastries	4	100.50	2025-03-18 13:45:23	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carlos.delacruz	2025-03-18 13:45:23
b1edef1c-cf2f-48aa-8338-41b4e940130e	i2HgTd0ufWoKuYxUZApM	2882	Apple Turnover	Pastries	5	154.54	2025-05-02 17:45:40	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.santos6	2025-05-02 17:45:40
8f456ee5-da0a-4eb7-80b1-893b64dcc939	upjLKWp1srKQ207zgUSB	2886	Tiramisu	Pastries	4	196.55	2025-01-21 15:46:07	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	miguel.cruz15	2025-01-21 15:46:07
85bc1386-76e6-476d-ac21-56a4e4412804	7wyfQ5tRLI3oTe723pZJ	2890	Hot Chocolate	Pastries	5	131.53	2025-11-17 06:45:25	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904059759	isabella.delacruz4	2025-11-17 06:45:25
bdb6f399-1a5d-411d-b95b-e21b6e1b35b3	3GzXtUSbUrENp4FYYP4z	2897	Almond Croissant	Pastries	1	8.42	2025-04-05 07:45:53	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904729692	elena.torres2	2025-04-05 07:45:53
5fdc99e8-fdfb-443e-a91c-4652c17d9f7e	Ulbr7PCuMjr14Ye1FJiK	2900	Flat White	Pastries	1	113.21	2024-12-17 09:06:47	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904723180	gabriela.mendoza	2024-12-17 09:06:47
fe0ab277-7161-48ef-a149-ee5f10837c52	Ecv8vOgMWVXCpjCvlXoQ	2902	Hot Chocolate	Pastries	5	131.53	2024-12-29 09:12:51	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.torres2	2024-12-29 09:12:51
0314392a-c0ce-4619-9f16-15774a90b6f0	XXuG4HLVCNTO1hmNgqTr	2903	Baguette	Pastries	2	133.77	2025-03-27 22:46:11	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.mendoza	2025-03-27 22:46:11
f0499d45-1ffb-4cc4-b70a-b1b287186a26	KBK1jz13K8tKA7fUn7dg	2906	Red Velvet Cake	Pastries	3	187.25	2025-05-05 19:27:55	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904124638	miguel.cruz15	2025-05-05 19:27:55
d732b0b5-dc48-449e-bc60-e748db13cac6	sK3HCYpwu1F4tQvRcHBx	2907	Cappuccino	Pastries	2	76.25	2025-03-20 21:21:38	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.cruz13	2025-03-20 21:21:38
ba886887-0486-423a-9fa9-9f6f86467325	vvtbtnXxxfEyg8Y8dQbo	2908	Cappuccino	Pastries	4	76.25	2025-07-28 18:50:58	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	rosa.rivera7	2025-07-28 18:50:58
949e5a6e-506f-4934-8917-07c637b41265	vfMYaV9LJ2axD79sSQrZ	2912	Almond Croissant	Pastries	4	8.42	2024-12-03 05:08:27	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2024-12-03 05:08:27
54ca836d-a8e8-41b7-ab94-640bc6c1f0d4	8mMimhjbqxtXVLcWBmns	2924	Tea	Beverages	5	106.18	2025-01-14 21:17:04	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904885396	rosa.rivera7	2025-01-14 21:17:04
ec54e3d6-0187-49e0-8a8b-e014806d1532	63510jXb8hpeJ0Q3adpJ	2926	Chocolate Chip Muffin	Pastries	4	103.79	2025-03-27 19:17:57	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904135252	gabriela.mendoza	2025-03-27 19:17:57
7b863d0c-40a1-4ea9-970f-854216d3d0c5	2oqsDkmdG2lcMekPkBAS	2929	Almonds	Pastries	3	5.59	2024-12-02 17:31:40	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	ana.rivera3	2024-12-02 17:31:40
6b43eb58-7051-45d6-bfae-0ad7070381bb	\N	\N	Almond Croissant	Pastries	1	8.42	2025-11-25 11:54:18.077793	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2025-11-25 11:54:18.077793
9f39b157-0b39-4188-9f87-eac4aa5152f9	hC1BSDEAEikTGxL3hGj4	2932	Latte	Pastries	1	108.74	2025-05-16 23:01:23	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	antonio.santos6	2025-05-16 23:01:23
d91b660b-68b9-4145-a991-ec88c392a494	PgpgqmYlt7KG0sGqWSBb	2935	Americano	Pastries	4	80.96	2025-06-15 09:02:53	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904736093	sofia.bautista5	2025-06-15 09:02:53
9ddf9785-a32e-4db3-9042-88d6fc5e50ed	uq2zGZN0f9IX5echGjqK	2937	Latte	Pastries	1	108.74	2025-03-11 13:48:47	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904459710	fernando.santos8	2025-03-11 13:48:47
88180df9-60db-4e6a-8e4d-0575b574bdf1	O50toiqJ0TbNOh1vxjX5	2947	Eclair	Pastries	5	146.12	2025-02-01 07:17:40	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	gabriela.mendoza	2025-02-01 07:17:40
1cb702e3-f5c1-47c7-a609-39cc0bf8938e	LEkr6Asr15qRYjpKQZ0m	2948	Chai Latte	Pastries	2	100.50	2025-07-10 09:09:54	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	fernando.cruz	2025-07-10 09:09:54
75a17389-0ed6-49d7-9c59-c30a192641cc	Rlea1CRcqsZdKDuLL799	2950	Flat White	Pastries	3	113.21	2024-12-10 23:54:24	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904770177	gabriela.mendoza	2024-12-10 23:54:24
1e7d66f0-4e34-452b-9f7c-652a2a574c0d	blFmo29QugxQWrNS7nlL	2951	Iced Coffee	Beverages	5	107.80	2025-01-28 17:36:52	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904920213	carmen.santos1	2025-01-28 17:36:52
2ee3bc84-37c5-468d-875e-f8988f15bf8f	h4RrW0ZJKQ5b91AXZAl8	2952	Chai Latte	Pastries	5	100.50	2025-11-01 03:35:49	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.bautista5	2025-11-01 03:35:49
710f53c7-e71d-485d-948e-a859eaa4d8b6	nfBUMrQ3tYUmVZJe8X6i	2953	Apple Turnover	Pastries	1	154.54	2025-01-07 14:46:48	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carlos.cruz12	2025-01-07 14:46:48
a5fe446c-9624-40dd-88cd-001f220ca589	Yhwk3bwn1y98dCMb8KX2	2958	Apple Turnover	Pastries	3	154.54	2025-05-12 03:46:33	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	fernando.santos8	2025-05-12 03:46:33
8553a74e-31ef-4a08-840b-62f89a6795a7	OlH82W5peMaaaBjO2iOb	2959	Tiramisu	Pastries	1	196.55	2024-12-10 03:39:15	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	miguel.cruz15	2024-12-10 03:39:15
b6abf162-24f5-4c10-aa99-4b211c7a3a14	BaAHyhda8cJDHUueR0Cp	2960	Eclair	Pastries	1	146.12	2025-02-15 16:05:15	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904185525	carlos.mendoza	2025-02-15 16:05:15
b484e05f-1cf4-4b7e-948a-b959cb977ade	XU8AVTkGTEttC0SAYXSS	2961	Cappuccino	Pastries	5	76.25	2025-02-14 23:03:42	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	ana.rivera3	2025-02-14 23:03:42
35b7af80-37e8-4fd9-a46a-64799afa700a	58ki2WNZepcLi5i0bZ25	2969	Almond Croissant	Pastries	1	8.42	2025-10-22 20:27:06	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carmen.santos1	2025-10-22 20:27:06
12d359cf-0032-4103-8556-e4b7ea569e66	0bxmBF4F0vIMDLnYQqgB	2970	Tiramisu	Pastries	3	196.55	2025-06-27 03:17:25	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904732866	miguel.cruz15	2025-06-27 03:17:25
4555d0d3-8e7f-423f-b4bb-02e503aaa1e0	\N	\N	Almond Croissant	Pastries	2	8.42	2025-11-25 11:54:44.55963	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2025-11-25 11:54:44.55963
c17310db-df02-4ecf-838f-f5f83b269d04	S5rCxOLw7vumOlSdQg4q	2976	Iced Mocha	Pastries	5	144.00	2024-11-30 16:35:25	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	admin	2024-11-30 16:35:25
080fa215-9f8e-417e-b114-cde4e36b4f87	ubNRtm95fkACTZhAOCWZ	2978	Chai Latte	Pastries	2	100.50	2025-07-25 17:36:32	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904373880	fernando.cruz	2025-07-25 17:36:32
86edf934-c67d-42b1-aaf3-0e2f9c37e1f2	FBpRJeq1JqffBGZumPgj	2980	Blueberry Muffin	Pastries	3	185.15	2025-05-14 04:42:13	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	gabriela.mendoza	2025-05-14 04:42:13
3dad80cc-33b8-43e7-b170-468fd9a6ff80	FeSAyt5oQX2D0JwSsSfh	2992	Iced Coffee	Beverages	5	107.80	2025-04-10 13:33:44	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	ana.rivera3	2025-04-10 13:33:44
6fd35580-ed5b-4c3f-8318-eeb65aef1ba7	G1JMEoXgT8cHUOIIe2qo	2995	Macchiato	Pastries	4	93.97	2024-11-27 10:41:55	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.cruz12	2024-11-27 10:41:55
1c8c9b61-0874-443f-87f1-5ab4820b6c56	f8ww08cfznRM9AO2J2V6	2997	Cappuccino	Pastries	5	76.25	2025-10-21 10:14:19	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904591706	isabella.delacruz4	2025-10-21 10:14:19
c98d67d1-c87e-4e25-988f-9ecf6523a90e	ny6LMuFesX2yviCCJwwy	2998	Glazed Donut	Pastries	4	148.75	2025-02-08 09:09:52	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	gabriela.mendoza	2025-02-08 09:09:52
5e06923e-563f-4eb6-8daa-fbee4cd6ae9e	1GN3Arb8F71HX4rSZbiq	3002	Iced Coffee	Beverages	3	107.80	2025-09-09 15:42:31	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904480882	elena.fernandez11	2025-09-09 15:42:31
895ab67e-393e-4644-8f23-1838f74798ae	bMUryabhTDitTeLTtBPy	3003	Blueberry Muffin	Pastries	1	185.15	2025-03-29 06:13:02	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.santos6	2025-03-29 06:13:02
5b92daa2-d939-4388-9834-f097a3cae9bb	aDtuEr8hsflSRFJjxvbp	3004	Chocolate Chip Muffin	Pastries	5	103.79	2025-10-15 13:05:18	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904390998	sofia.bautista5	2025-10-15 13:05:18
10367782-3747-40d6-8f76-317b887dcc68	tffd0lFDugSvGkQwKesO	3005	Eclair	Pastries	3	146.12	2025-02-24 21:09:38	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.fernandez11	2025-02-24 21:09:38
7d52acfb-299a-499e-9f09-8f0d91cb22bc	FAN052joqAP3j7cAeFMp	3011	Latte	Pastries	4	108.74	2025-05-02 09:18:51	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904948533	elena.torres2	2025-05-02 09:18:51
eba1ec78-4f8a-498b-9387-d7ae0bcbb877	sWeol4Jya7TeKQowuTQ9	3013	Latte	Pastries	2	108.74	2025-03-20 14:43:57	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.mendoza	2025-03-20 14:43:57
8e709a62-e849-41f5-b2b2-889aac461f6b	Eo9MfCALQ5SaGyYeeoAa	3015	Tiramisu	Pastries	5	196.55	2025-03-12 22:28:17	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	miguel.cruz15	2025-03-12 22:28:17
8cba19d7-23f5-42c6-8c12-52c37c8e31da	\N	\N	Almond Croissant	Pastries	1	8.42	2025-11-25 12:06:41.211597	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2025-11-25 12:06:41.211597
009b8697-9119-4394-b5b8-f904225984f8	OXn0WhozcTyluZJIJrUq	3017	Mocha	Pastries	1	61.74	2025-08-22 00:16:21	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904194172	elena.torres2	2025-08-22 00:16:21
a87ea2a6-a649-4cc8-bb5b-30530536ee12	ypIlUC1ruuFZj3BvXuV0	3018	Chai Latte	Pastries	4	100.50	2025-11-20 02:08:50	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	fernando.santos8	2025-11-20 02:08:50
2b6261cc-6575-4816-9036-02a41d5f2e04	3Aoj2PYwFG6Ko1m91fhk	3021	Red Velvet Cake	Pastries	2	187.25	2025-03-11 17:01:23	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.cruz12	2025-03-11 17:01:23
87b97d2a-d828-4d64-a7d0-72db5bfce6fe	2hPwbHUZWijGhB6d7Ww1	3024	Hot Chocolate	Pastries	5	131.53	2025-06-30 15:22:15	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904403933	fernando.cruz	2025-06-30 15:22:15
e3cd1c2a-40a2-47fd-8107-b10a1a0113f7	GudRUxA7YqNpocg7uyja	3025	Apple Turnover	Pastries	4	154.54	2024-12-16 03:54:45	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carmen.santos1	2024-12-16 03:54:45
636c1116-6c4d-4e58-8250-319c12868ed8	Nw4MerVUvuwZE8cUmeRD	3031	Red Velvet Cake	Pastries	2	187.25	2025-10-04 16:23:16	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.mendoza	2025-10-04 16:23:16
e7550c73-dc0a-42ea-af1c-a2c89e5b35c4	32rgyuUz4J87FotZEAKL	3032	Iced Mocha	Pastries	5	144.00	2025-09-12 10:38:41	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	pedro.cruz14	2025-09-12 10:38:41
ededc0c3-a629-4bd7-bf69-c3ab99c52665	18H2O6GHKOciEfop20qA	3034	Blueberry Muffin	Pastries	1	185.15	2025-07-12 10:06:16	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.rivera7	2025-07-12 10:06:16
af213c98-cad0-4bc8-8579-55b89d4566b6	6oz2myIqY29xQOhh00Pn	3035	Chocolate Chip Muffin	Pastries	5	103.79	2025-05-21 14:07:04	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904065606	elena.fernandez11	2025-05-21 14:07:04
0b90f552-a4dd-449e-bfc9-9f3d677408a2	j7vEcFLFubfGiPzPPebO	3038	Macchiato	Pastries	5	93.97	2025-05-20 20:16:05	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904814733	rosa.rivera7	2025-05-20 20:16:05
240e8093-0121-40ac-862c-a7292c870d1c	jXG4V4KqF1stHKd4b1Ro	3040	Mocha	Pastries	4	61.74	2025-07-04 11:28:53	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	elena.fernandez11	2025-07-04 11:28:53
48dca8b6-9fae-4352-828a-2aa837a8afba	ZgdamkOhEyqTPgTUvxa4	3045	Espresso	Pastries	1	195.76	2025-08-22 09:40:18	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	fernando.santos8	2025-08-22 09:40:18
2360d0a9-ab0e-4626-88e5-9d45355d99db	YSjhbc08Ly5d7hpSZjCO	3047	Tiramisu	Pastries	5	196.55	2024-11-29 00:02:57	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	isabella.delacruz4	2024-11-29 00:02:57
458fa1fd-e210-4b26-8094-dcfd9be030c8	jij2RRavcI4yVPmiveem	3051	Chai Latte	Pastries	4	100.50	2025-06-21 06:17:38	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.reyes9	2025-06-21 06:17:38
e095c025-342a-4437-b90e-d962c979629f	EvSmFz44IBZjnotjfHMw	3052	Hot Chocolate	Pastries	5	131.53	2025-04-03 05:43:38	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904117164	fernando.santos8	2025-04-03 05:43:38
56594ce8-df7e-4b80-bb8d-249589419b9e	EBfv1zHaL1qB6Z743rLy	3055	Espresso	Pastries	5	195.76	2024-12-07 00:55:14	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904426105	elena.fernandez11	2024-12-07 00:55:14
80f892af-a456-4889-9a55-bee5566cf4ac	9FdfNrGKcasgICQoH232	3057	Americano	Pastries	2	80.96	2025-05-06 12:49:45	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904617930	pedro.cruz14	2025-05-06 12:49:45
f25fb506-2302-471d-9be0-cd525c4dc2d7	WmOV0FfP6gJXyq64O7WJ	3063	Eclair	Pastries	5	146.12	2025-09-29 17:56:10	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904539742	elena.fernandez11	2025-09-29 17:56:10
7df7de0b-4da6-44db-bedb-f621eb2a80fb	fmliJkJaWh0fZ6jrwE3D	3067	Espresso	Pastries	1	195.76	2024-11-27 04:06:56	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.delacruz	2024-11-27 04:06:56
c2ed50b6-0ef2-4d6f-9c2b-10e6be561ef4	GUWIzp2xgPCVrZFoe4jg	3068	Almond Croissant	Pastries	5	8.42	2025-02-22 13:27:07	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	rosa.rivera7	2025-02-22 13:27:07
e1909172-a64c-4a57-92c6-2dc034b7af05	36EVc9Q6AXBkgfYfL8o4	3069	Iced Coffee	Beverages	3	107.80	2025-06-05 07:41:57	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.mendoza	2025-06-05 07:41:57
4e42d102-8010-4c72-ac40-0c86d3b44692	QagiAzOjxqj9f2PrZFwZ	3074	Almonds	Pastries	1	5.59	2025-10-24 09:49:03	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	rosa.rivera7	2025-10-24 09:49:03
ff943145-20c2-407c-ba58-782d557b9204	zIfTH5fYHhypNQNMDM8z	3077	Apple Turnover	Pastries	5	154.54	2025-09-27 00:07:37	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904330210	fernando.cruz	2025-09-27 00:07:37
c1e1f57a-616b-4c0e-81a7-8ce969505900	qfuxKBBr9S6SQek1vvxS	3079	Baguette	Pastries	1	133.77	2025-05-28 15:34:58	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.fernandez11	2025-05-28 15:34:58
08494b14-5b7a-4bea-a42e-896abed1b05d	aVhSLEwilufUkhWloCTl	3082	Flat White	Pastries	1	113.21	2025-02-15 00:48:30	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904008123	rosa.rivera7	2025-02-15 00:48:30
372b7192-0bf4-40c2-8213-05b0d94ef2be	95vQQNYFCvShlJSXOMKa	3085	Latte	Pastries	1	108.74	2025-01-01 21:43:58	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.delacruz	2025-01-01 21:43:58
510f3055-9529-455a-9718-80de3e23ab95	hNWBcuR8AXGPB78cdfEb	3086	Americano	Pastries	2	80.96	2025-05-10 17:32:10	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carlos.mendoza	2025-05-10 17:32:10
237f0601-3a06-4d99-8ccd-dd6c8f5d6ffc	VvTQjD8dSVKdbJgVBVbW	3087	Apple Turnover	Pastries	5	154.54	2025-01-10 04:00:47	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	miguel.cruz15	2025-01-10 04:00:47
8082564d-05c3-4dd8-aca8-a66948a1633a	B3HbfrDMVJnhyITnUtZm	3088	Apple Turnover	Pastries	5	154.54	2025-09-20 08:24:53	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.torres2	2025-09-20 08:24:53
c6c2e38f-f82e-457a-904f-325aac93b982	CpkFZYDYoQVXxqeeOMZC	3096	Blueberry Muffin	Pastries	1	185.15	2025-10-29 02:25:04	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904534429	admin	2025-10-29 02:25:04
5a026c9f-422c-452f-a198-1ac1f10cd876	BBuk6nQKUlpS5k3am8KD	3097	Red Velvet Cake	Pastries	3	187.25	2025-01-28 18:33:56	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904433709	rosa.cruz13	2025-01-28 18:33:56
88c9470e-5814-4c5b-8ca7-27c23a2f68af	M3jY3ozysH9lYmQbpEb4	3111	Blueberry Muffin	Pastries	1	185.15	2024-11-29 08:04:24	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.cruz	2024-11-29 08:04:24
d210aa94-7580-4a50-a821-b5ec6572e91d	yiT4i7l4Loz6epxkM7Lo	3121	Chocolate Chip Muffin	Pastries	5	103.79	2024-11-26 22:02:50	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904237665	fernando.santos8	2024-11-26 22:02:50
2f8c33b5-9d63-432f-ab29-6e753427a965	0zceKJXBLraaoKHjMzEj	3123	Iced Mocha	Pastries	5	144.00	2025-09-07 04:05:58	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2025-09-07 04:05:58
8f272f61-c39f-4492-b131-97a9230dc1f7	5b2peMR1FrMZa2y60RrS	3128	Tea	Beverages	2	106.18	2024-12-07 13:16:36	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	pedro.cruz14	2024-12-07 13:16:36
34016c3f-43cd-432a-a72c-55c750097d79	KZh0SJdiBTm5UySur0zU	3134	Macchiato	Pastries	3	93.97	2025-07-25 20:42:15	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	rosa.cruz13	2025-07-25 20:42:15
7064fdf3-fb01-4575-8d84-4dce9041ace0	KhL6hjxZi1Ew8rV6diEk	3136	Almonds	Pastries	4	5.59	2025-10-28 00:14:42	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.bautista5	2025-10-28 00:14:42
d8f59e0f-9efc-48f0-97ba-fd6598e891d3	Oog1uWXx4mj8l8Av68le	3139	Hot Chocolate	Pastries	4	131.53	2025-09-24 12:20:13	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904600915	sofia.reyes9	2025-09-24 12:20:13
3f57d1ea-81ec-4007-86e2-247dae329e5e	cEFbGs7KH8pphe1fmqPo	3140	Americano	Pastries	3	80.96	2025-06-30 07:06:18	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904661414	elena.fernandez11	2025-06-30 07:06:18
c6a39c66-4142-47bb-9da2-c41b55dc0769	nJRUH5tabgBHVNRX6qM8	3143	Cappuccino	Pastries	2	76.25	2025-04-10 01:46:17	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.rivera7	2025-04-10 01:46:17
a45da0e1-3095-4b55-87f9-2dd7bf75390b	abmDzz4lvWz4CWwyobWs	3145	Iced Mocha	Pastries	3	144.00	2025-09-14 20:22:53	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2025-09-14 20:22:53
a725c0f8-8572-4c3c-b562-27dcf0239325	2wW7u3mSp1nkEuL0t6fW	3148	Latte	Pastries	2	108.74	2025-05-30 06:40:57	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904265417	carlos.cruz12	2025-05-30 06:40:57
1c1c588f-c12b-4078-a8c7-fe8fd2da0b47	1TuOocAB3WGYhRVThwpL	3154	Blueberry Muffin	Pastries	5	185.15	2025-05-10 12:37:17	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904973755	sofia.bautista5	2025-05-10 12:37:17
3952e16f-6a93-48e7-bf8f-8d88a38e8b07	rbLg4srQw2z5tHtRfT4Q	3155	Cappuccino	Pastries	3	76.25	2025-09-11 12:32:42	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.rivera7	2025-09-11 12:32:42
40ecc8dd-788c-4627-91c7-e303143478be	RDKsHK8n20gZVdMX2wkZ	3162	Mocha	Pastries	4	61.74	2025-03-22 07:34:45	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.reyes9	2025-03-22 07:34:45
f9f0f848-af07-42bf-a512-96df1b4f56b5	4mPo7KyRuK6RaZQHfI1h	3167	Chocolate Chip Muffin	Pastries	2	103.79	2025-09-19 11:30:21	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	antonio.santos6	2025-09-19 11:30:21
4884bcf1-660d-4d40-85c1-d4a55e1f5379	N0ywncAKk74K1plLcWKc	3168	Eclair	Pastries	5	146.12	2025-03-05 06:39:28	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	sofia.bautista5	2025-03-05 06:39:28
6430a58f-80e8-4714-aa68-081ba2ad2d11	Px0ndPbHYfWMaSU9hRPX	3171	Apple Turnover	Pastries	1	154.54	2025-11-12 15:58:10	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904329948	rosa.rivera7	2025-11-12 15:58:10
9b643948-3ee0-4818-bc77-1203cebac12b	kjd8ZuxcPqMT0bweiJBX	3174	Chai Latte	Pastries	3	100.50	2024-12-28 10:04:42	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	elena.fernandez11	2024-12-28 10:04:42
3cf5bd10-0f6d-490b-a1a6-602f3ada8b24	NUtW7zwrfE1M2ORV9VuN	3176	Espresso	Pastries	3	195.76	2025-11-21 04:51:18	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	elena.fernandez11	2025-11-21 04:51:18
8348bb0b-b888-4958-9da3-77f63fe3988a	XcatqHc2lI1C1ruOkrJy	3177	Hot Chocolate	Pastries	4	131.53	2025-10-09 14:12:50	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.torres2	2025-10-09 14:12:50
38a7916f-6d95-4979-825d-8516118e09e3	hHlpeNWtxYOxgXDhbEiX	3178	Latte	Pastries	4	108.74	2025-08-26 14:19:33	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904305628	fernando.santos8	2025-08-26 14:19:33
289b795f-ebfd-467c-9706-ad3ba92d27bc	RGyWCKbhO8iN12u5t1ic	3183	Americano	Pastries	5	80.96	2025-07-25 12:56:13	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carmen.santos1	2025-07-25 12:56:13
e2f67f51-b3cb-4a91-baba-2076c99ae0bb	NJ4o0VMDN3EPPbGlkKgf	3187	Macchiato	Pastries	1	93.97	2025-09-01 01:11:29	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904941003	carmen.santos1	2025-09-01 01:11:29
c3dfb094-267c-41c5-97e2-8126081214ae	H1DpMfBkVcvpl42rpIRK	3189	Red Velvet Cake	Pastries	3	187.25	2025-09-11 21:54:43	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	fernando.santos8	2025-09-11 21:54:43
58b23f1f-788f-46f6-94ad-1519b8de9caf	F2OSm6oDkIs182Wh1bLe	3191	Blueberry Muffin	Pastries	1	185.15	2025-02-25 23:47:56	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904744107	admin	2025-02-25 23:47:56
08b71250-501d-4c3e-af64-feea75d6c5e5	0iPZAJDg67czsbaypuSu	3192	Hot Chocolate	Pastries	5	131.53	2025-11-05 10:17:07	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904109610	pedro.cruz14	2025-11-05 10:17:07
a6d73690-4401-4555-a10a-3ffddaa8612e	9DX5XJvo1ktIkxuo0T96	3193	Cappuccino	Pastries	2	76.25	2025-11-07 16:32:31	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	sofia.bautista5	2025-11-07 16:32:31
db34e240-e0b4-483d-b6a3-82e5ec0cbccc	HkqmRq7b7zn7pow6ap0w	3195	Latte	Pastries	1	108.74	2025-05-01 07:20:05	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	elena.torres2	2025-05-01 07:20:05
32706b3d-e8d2-4f5f-9ec8-b7f13a4e4728	wyFAkEqvEEKaN5fbM9S6	3199	Chocolate Chip Muffin	Pastries	5	103.79	2025-03-28 17:12:59	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904853902	fernando.cruz	2025-03-28 17:12:59
1ac49cb9-dc75-4be5-8dae-8bfbfa3155b0	7gtwyalyVjf1pHRtp95k	3204	Almond Croissant	Pastries	3	8.42	2025-04-12 16:49:54	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.cruz12	2025-04-12 16:49:54
49209944-6889-4bcb-aac7-a8b05bdfddcb	cmycK4uqjptC5byYxL1p	3208	Flat White	Pastries	1	113.21	2025-02-11 06:41:50	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.torres2	2025-02-11 06:41:50
149736c4-0558-494b-8c5f-fcb611c5f21a	CSbRq0zJoQ69Dt03pz6Z	3210	Mocha	Pastries	5	61.74	2025-10-23 20:28:23	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	isabella.delacruz4	2025-10-23 20:28:23
b1ccaf9d-fc88-4d88-842c-3e9408268770	083AvJQiUZDaDTXitfLZ	3213	Blueberry Muffin	Pastries	3	185.15	2025-06-01 11:08:56	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904665432	fernando.cruz	2025-06-01 11:08:56
c53e2105-e685-4e76-860a-7dce4160081f	vsjST0X5gKlPsFE2voxv	3215	Americano	Pastries	2	80.96	2025-01-21 12:28:48	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	pedro.cruz14	2025-01-21 12:28:48
8acdab8d-8d1a-4bf7-89f9-17585028d005	8L0DOhdZT7wCqSP43JnP	3218	Chai Latte	Pastries	3	100.50	2025-06-24 04:11:18	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	isabella.delacruz4	2025-06-24 04:11:18
aada125f-12f9-4eae-843a-a9f4fd711eca	d3jYrCMfA7ZmiwSuPaHv	3220	Iced Mocha	Pastries	5	144.00	2025-05-05 00:08:56	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904863297	carlos.cruz12	2025-05-05 00:08:56
468db8d5-3850-4de5-bc89-d4dbf10a0111	4fEDCdqrs4phbeuvzrLY	3234	Latte	Pastries	3	108.74	2025-07-18 20:40:48	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.rivera7	2025-07-18 20:40:48
8fedc06f-1dcf-41bf-a4e0-32d231af6116	HQYVe4PJd7HhUTDBgX50	3236	Flat White	Pastries	1	113.21	2025-08-12 22:54:22	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	rosa.rivera7	2025-08-12 22:54:22
9bb71449-92e6-43e9-aab0-5ea42f8680cc	fSt9EHtZ96zWp7c04hvg	3237	Mocha	Pastries	4	61.74	2025-01-03 19:55:34	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.cruz	2025-01-03 19:55:34
b6a9333b-fd32-49e7-82cf-163ca3c2fc61	cmIPJu533x9ErnV1V0lG	3239	Blueberry Muffin	Pastries	5	185.15	2025-07-09 22:17:40	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	miguel.cruz15	2025-07-09 22:17:40
9b3dded3-b5e1-4104-af03-d1336f491d49	etjGMDhLukpxxhJF4L7A	3242	Macchiato	Pastries	5	93.97	2025-02-13 04:25:49	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.mendoza	2025-02-13 04:25:49
e3f95247-7d5b-472e-8932-0fe0573da685	A1KZm3M6k13DCV6WTU4d	3243	Chocolate Chip Muffin	Pastries	1	103.79	2025-10-16 14:26:45	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	pedro.cruz14	2025-10-16 14:26:45
6336ec35-b6fd-48d3-ab6c-fe820c7a8e35	ntng4fxYFp7UiK9d2rfS	3247	Glazed Donut	Pastries	5	148.75	2025-04-27 06:18:48	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	isabella.delacruz4	2025-04-27 06:18:48
c9a36768-4137-4b34-8291-7319b5be30f7	Dpl5JFH69MzbLu53XCOz	3249	Almonds	Pastries	1	5.59	2025-04-16 01:10:40	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2025-04-16 01:10:40
01c13098-f1ce-4e1b-8fab-c5ccebb9fddc	gqfm7tuPcJriqh0wUWNg	3250	Almonds	Pastries	3	5.59	2025-02-17 20:45:42	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	miguel.cruz15	2025-02-17 20:45:42
b117b548-d9eb-4e3d-940f-55692c35e468	uidzVS0CnoEXvgjEViJd	3251	Tea	Beverages	5	106.18	2025-05-15 06:02:04	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carmen.santos1	2025-05-15 06:02:04
76b2a464-12e0-4dee-86c2-dcbb4eefe5d5	kWETHWbdZDwRS7swok9u	3257	Tea	Beverages	3	106.18	2025-07-22 02:09:34	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904968261	pedro.cruz14	2025-07-22 02:09:34
ddc996e1-534f-4c02-b09a-b78055ec7d9b	JM5avMxgVApxfk9ki2N9	3258	Flat White	Pastries	3	113.21	2025-08-09 16:52:44	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	ana.rivera3	2025-08-09 16:52:44
f151a74c-881f-44dc-b0c3-6a6421a408c1	iVFpZwQbjph7nLdxj1Qj	3261	Baguette	Pastries	5	133.77	2025-08-15 08:36:02	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.reyes9	2025-08-15 08:36:02
5a868c88-4f99-42f1-b1e0-f96391ae8397	04jo9RLnCf7zV6c0FIML	3264	Cappuccino	Pastries	3	76.25	2025-04-10 23:22:11	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904999587	carmen.santos1	2025-04-10 23:22:11
c03d48a3-8ca8-4481-89e4-a092e07b4418	sQ8vFgkEmpeMv0cIW2L0	3265	Mocha	Pastries	2	61.74	2025-10-05 12:36:10	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	antonio.santos6	2025-10-05 12:36:10
e81f986c-4a41-4e1b-96e5-b62779fe4d46	RgmXXnEQ34kL1aPyHAdb	3266	Iced Mocha	Pastries	3	144.00	2025-06-28 07:51:33	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carmen.santos1	2025-06-28 07:51:33
2e41069f-7de2-47ee-bf9d-0c8b7721db3d	dEKwbgrBy8gCqDach315	3268	Latte	Pastries	3	108.74	2025-01-19 17:39:50	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904500015	carlos.cruz12	2025-01-19 17:39:50
d3c3bf3d-b529-45cd-a1e8-343bc3f37278	UktqDYZ3Bau2tsI8aebk	3271	Eclair	Pastries	2	146.12	2025-06-25 10:40:54	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904623470	rosa.rivera7	2025-06-25 10:40:54
158132ee-9047-4bc4-917b-002241962040	jCLyZiPaqpX2HFWXXNnV	3273	Chocolate Chip Muffin	Pastries	1	103.79	2025-03-07 18:20:13	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904522132	fernando.cruz	2025-03-07 18:20:13
28cea051-a025-495d-ab76-4c0d85d989aa	kQfz9llW9XoRY7oDa2cZ	3274	Eclair	Pastries	1	146.12	2025-05-22 06:06:34	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.mendoza	2025-05-22 06:06:34
179b2a9b-5b8e-4f64-b596-19bf7afa9e77	usftS5R7mBPIfpw4O3Vf	3277	Tiramisu	Pastries	1	196.55	2024-12-09 17:58:48	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904825450	carmen.santos1	2024-12-09 17:58:48
2107bece-cad6-4f0f-bdb2-e869b52123ea	XJKUC6sghtkiV7jASODH	3281	Apple Turnover	Pastries	5	154.54	2025-11-05 10:57:13	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	sofia.bautista5	2025-11-05 10:57:13
fcc1e2fc-8879-4739-bfc6-8465b14086e0	w6rwEaW1h5lMYrDrIZdW	3283	Espresso	Pastries	3	195.76	2025-05-26 10:38:22	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.cruz12	2025-05-26 10:38:22
32d946b6-8c13-4880-89cb-0cdee3807cc9	3mX0Re7u8o8wzApJQfRH	3284	Apple Turnover	Pastries	4	154.54	2025-11-18 00:17:04	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904401342	sofia.reyes9	2025-11-18 00:17:04
48d6bda1-6eba-4389-b076-f9cd0dc051f0	7xo2N2g21gOmClQlBDqt	3285	Macchiato	Pastries	5	93.97	2025-03-12 07:36:45	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.santos6	2025-03-12 07:36:45
fe8daa83-b95e-4a64-92e5-17ee4da59f46	NKOB1ReFe0kLooT5YTFX	3291	Hot Chocolate	Pastries	4	131.53	2025-09-11 05:14:45	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	ana.rivera3	2025-09-11 05:14:45
4a0608bd-5e2a-4730-bc60-200bf2359c24	RuowvEhBImyAQLrXp4BU	3295	Hot Chocolate	Pastries	2	131.53	2025-02-15 21:45:14	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.mendoza	2025-02-15 21:45:14
a770f9ef-c073-456f-bc1d-879a54881218	oYJB3NbcpfhHFNbT9Zl5	3297	Espresso	Pastries	5	195.76	2025-08-31 00:29:16	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.santos6	2025-08-31 00:29:16
6ce04472-a43d-47d7-91b8-f1fe763f8660	VLZhOLpWsD8t0ZtzsNmF	3301	Chocolate Chip Muffin	Pastries	1	103.79	2025-03-07 07:59:31	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.mendoza	2025-03-07 07:59:31
d859cfa7-8726-4382-bc5e-057daf50b2ae	iTtfUTM3HVqzQRIKlx1i	3302	Chai Latte	Pastries	3	100.50	2025-03-15 03:38:38	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	fernando.cruz	2025-03-15 03:38:38
1bedd2da-51bf-41e7-8b01-f1e6c0328635	byo2X9AI5pgXi7EMW6LG	3307	Hot Chocolate	Pastries	4	131.53	2025-01-20 21:17:13	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	pedro.cruz14	2025-01-20 21:17:13
30de79ff-9bd0-4d72-abed-518f7595e70a	KQKmQUWRJHiYfQn5zI1i	3309	Espresso	Pastries	4	195.76	2025-09-07 13:12:52	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	sofia.bautista5	2025-09-07 13:12:52
935cd942-d977-405e-b30a-6c4fe01e978b	oZ1CZMw7VULF2jBJ0LF0	3315	Chocolate Chip Muffin	Pastries	4	103.79	2025-04-03 17:43:03	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	admin	2025-04-03 17:43:03
b2e58593-c5f5-453c-980f-9eedc377d673	gzTHB2nnIpqqulqlfipb	3321	Macchiato	Pastries	4	93.97	2025-06-06 07:15:30	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	pedro.cruz14	2025-06-06 07:15:30
5a551ef5-df0a-44bb-b302-4b1f0b81d633	bMCVRuZ5bluRv9RNp2VC	3326	Espresso	Pastries	1	195.76	2024-12-09 04:25:55	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.rivera7	2024-12-09 04:25:55
abd9ec90-c064-43dc-987e-950eb76e008e	TeH44Xnxic7MfYrpAKWV	3331	Almonds	Pastries	1	5.59	2025-04-16 08:40:54	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904530800	fernando.cruz	2025-04-16 08:40:54
bc6ccee9-5175-4d30-b242-ec129c67a965	iZkP9RLXOgPuDJmjjS1B	3336	Espresso	Pastries	5	195.76	2025-05-22 23:36:01	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	gabriela.mendoza	2025-05-22 23:36:01
da3863c1-0335-4ad9-bc37-a7f881329fd8	gDU7d9BE5shYuxVQ7UvA	3338	Glazed Donut	Pastries	2	148.75	2025-02-26 00:43:13	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904438609	ana.rivera3	2025-02-26 00:43:13
f45cdfb8-ea59-40e1-904f-bb3302ffa0ec	4IjydhDmbEKTxC3zPYq1	3340	Iced Coffee	Beverages	1	107.80	2025-05-18 20:20:22	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904200616	sofia.reyes9	2025-05-18 20:20:22
7da962cb-42a9-4ca7-aadb-d0994deeda1c	gPlENBhTo07KlDigtEkM	3342	Blueberry Muffin	Pastries	2	185.15	2025-07-31 04:17:02	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.rivera7	2025-07-31 04:17:02
7dc30d78-393f-46cc-8a36-8ea2817b5801	vEJkLnL4WloSuOBWa94h	3343	Iced Mocha	Pastries	2	144.00	2025-03-22 05:21:20	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	miguel.cruz15	2025-03-22 05:21:20
2ce98500-f264-4e93-8fa5-99078c3ba38a	cpdXn1SxE8L3E082SMIb	3344	Tiramisu	Pastries	4	196.55	2025-01-18 04:29:50	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.delacruz	2025-01-18 04:29:50
16cfeb73-875e-4266-96da-a1000147ef1a	uSTNXzFLYJo8APKkextk	3347	Chai Latte	Pastries	4	100.50	2025-04-11 18:50:14	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carlos.mendoza	2025-04-11 18:50:14
c84baccf-f17f-4f7e-9081-7be03647c7c2	1y2cvU0bD15L8exLrkJM	3350	Espresso	Pastries	2	195.76	2025-04-10 08:01:49	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.mendoza	2025-04-10 08:01:49
41d0d5ec-0613-48e8-aabe-9fff8c1c54cb	2q48XtPtnLUVancPbLVq	3351	Macchiato	Pastries	2	93.97	2025-04-25 04:28:25	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904796074	gabriela.mendoza	2025-04-25 04:28:25
708dadb7-e895-4539-a74e-8482875bc52b	6mhwzJqbUgvcf9SYXBPH	3357	Iced Mocha	Pastries	1	144.00	2024-12-09 15:47:57	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	elena.fernandez11	2024-12-09 15:47:57
24a88fa9-a098-4beb-9513-832506e6aa62	keXmoYwaGLb6ztZ6DfLf	3362	Tiramisu	Pastries	3	196.55	2025-03-09 12:40:05	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904780975	miguel.cruz15	2025-03-09 12:40:05
b9d30a7e-f057-4622-b231-d88e42c00646	hDRbYFxEKSillljm3iT6	3363	Tea	Beverages	4	106.18	2025-06-02 16:35:21	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	antonio.santos6	2025-06-02 16:35:21
5efc5692-4209-4012-847e-c3c8d0d7f038	\N	\N	Almonds	Pastries	1	5.59	2025-11-25 16:50:42.095031	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2025-11-25 16:50:42.095031
a1406b79-1b5a-4ddb-87e6-4c45f75801de	PvR4yJfSFJD4POoKABOH	3367	Macchiato	Pastries	4	93.97	2025-09-13 18:46:47	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.santos6	2025-09-13 18:46:47
bbe849d4-18f7-4afd-8c27-07d68255358d	dHxNC8vz1wHUYCBbFxJX	3370	Tiramisu	Pastries	4	196.55	2025-07-10 19:21:16	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	fernando.cruz	2025-07-10 19:21:16
d3c5f44c-a790-4e01-b73e-d1814677eb49	U4mFrW2hGf1O0bNDd9Np	3372	Iced Mocha	Pastries	2	144.00	2025-10-26 21:17:31	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904221065	isabella.delacruz4	2025-10-26 21:17:31
897a3505-5bcf-427a-9807-1002e3f3c151	fWROMTC0qbWp0Z6E5TCU	3373	Cappuccino	Pastries	5	76.25	2025-08-14 19:51:19	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.delacruz10	2025-08-14 19:51:19
00dee7c2-e3e6-4b10-8c4a-433ecbfde834	HsH5T1o8NhmtDSIykw9O	3387	Tiramisu	Pastries	5	196.55	2025-01-28 14:52:33	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	rosa.cruz13	2025-01-28 14:52:33
db04b76a-9318-4790-a2d2-ba974e3a0357	7vSpz9WbEvtkg5W0Bzf7	3389	Hot Chocolate	Pastries	2	131.53	2025-07-16 22:30:18	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	isabella.delacruz4	2025-07-16 22:30:18
ef2b1591-2cef-4174-a053-6e76d01d8653	PSgYbL2UpWWJXQshAb0J	3392	Chocolate Chip Muffin	Pastries	2	103.79	2025-04-11 05:37:30	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.cruz12	2025-04-11 05:37:30
65723963-eac9-444f-b4b1-5806e806f3dc	IoFMLzyEgPVw38cZ2LQe	3396	Red Velvet Cake	Pastries	5	187.25	2025-09-18 23:26:21	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904130783	admin	2025-09-18 23:26:21
72c02ba7-cada-4c95-bad6-66428bf0aaf6	OTbVjNCtS5Yxbz1eVHMA	3398	Blueberry Muffin	Pastries	1	185.15	2025-02-20 18:57:23	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904517069	antonio.delacruz10	2025-02-20 18:57:23
39744ab2-ccf3-43b7-9ee5-e272fc8fe898	K94LS3CieURGq9d4zHiJ	3402	Iced Mocha	Pastries	1	144.00	2025-04-02 23:18:00	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	rosa.rivera7	2025-04-02 23:18:00
3d75f5ff-f89d-4fce-880b-3feb0b3a176c	pSfyoIbLzw6jazxW4ojj	3405	Macchiato	Pastries	4	93.97	2024-12-29 08:52:07	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904793358	carlos.delacruz	2024-12-29 08:52:07
4d0b08fa-f296-40aa-8222-fc7bec7b11c0	PE4oK0Db1E3X2E64zRoz	3416	Latte	Pastries	2	108.74	2024-11-28 11:14:11	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.delacruz	2024-11-28 11:14:11
5daa7c0e-e8cd-431f-af2c-54bdc5f9ab82	DxY4s9uWQXKEVmIDJZ0F	3420	Almonds	Pastries	5	5.59	2025-11-09 22:19:12	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.reyes9	2025-11-09 22:19:12
c0eb2230-88a7-4773-8fcc-c2933511cdbe	MgR6nkOuXvugOMyfTKPZ	3421	Cappuccino	Pastries	2	76.25	2025-08-13 17:02:10	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	sofia.reyes9	2025-08-13 17:02:10
e317d9f1-92f3-4ebd-9bc5-f42e5aee2c5c	HSecaVE3dBz3U7BBscOG	3422	Iced Coffee	Beverages	2	107.80	2025-04-11 15:10:52	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	miguel.cruz15	2025-04-11 15:10:52
8dbab93d-d11e-49e4-a20a-29bca537cb92	JMp5JkZW1w9Ok2dF8IpZ	3423	Macchiato	Pastries	5	93.97	2025-04-22 10:29:52	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904286513	sofia.bautista5	2025-04-22 10:29:52
1f4c11c1-d7af-46eb-ba93-580fa850e244	aal1EyTvE3VCh81wmzZu	3434	Espresso	Pastries	1	195.76	2025-08-11 12:45:27	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183904516970	carmen.santos1	2025-08-11 12:45:27
66a96608-134c-4fe3-9796-406d71414434	g9bVomOrn6rS5yAcOw8z	3435	Americano	Pastries	3	80.96	2025-10-20 10:47:56	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	antonio.delacruz10	2025-10-20 10:47:56
2efa6a81-3827-4e6e-8c6e-e5f3f3c65725	12BDlTuulgxleebpqyrk	3436	Glazed Donut	Pastries	2	148.75	2025-06-08 20:20:40	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904668135	rosa.rivera7	2025-06-08 20:20:40
42c28808-5dd1-4c51-8cdc-c7fca1dd0359	sc1ZerYmR6VDFoAauoPL	3437	Mocha	Pastries	1	61.74	2025-08-30 13:41:11	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carlos.cruz12	2025-08-30 13:41:11
92939606-1174-4fd5-a115-a868b299511e	qNGZ0ouhxtZSsmdu3K1i	3439	Red Velvet Cake	Pastries	1	187.25	2025-01-11 11:29:06	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.torres2	2025-01-11 11:29:06
a16c81db-0144-403d-aa29-f38bbbf6159a	6RVvgVee3SHA9Ek1DR1f	3440	Tea	Beverages	2	106.18	2025-07-10 18:24:14	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904581814	miguel.cruz15	2025-07-10 18:24:14
da585509-e720-430d-9b7b-db2346ec39a7	phprhBGzEDG2LUOYvh6s	3444	Flat White	Pastries	5	113.21	2025-09-28 16:29:16	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	sofia.reyes9	2025-09-28 16:29:16
c608ef85-4383-4280-9b23-9044c2f70dc9	8rO7byRfdlOW2bNV9D4n	3447	Glazed Donut	Pastries	2	148.75	2025-06-09 09:11:17	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	sofia.bautista5	2025-06-09 09:11:17
19a1a582-5f10-4b6a-b7b9-a4c205d93e41	Kbc1KaPh97cZRgVAeCst	3449	Baguette	Pastries	2	133.77	2024-12-26 02:24:28	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.delacruz	2024-12-26 02:24:28
c47c8ba1-3c27-4ab6-9637-1fa2a5700cbd	4bKTpgj8mW19RZpmrvsi	3453	Apple Turnover	Pastries	2	154.54	2025-09-21 21:05:08	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904580456	antonio.santos6	2025-09-21 21:05:08
8ba2d1cf-48f9-4775-b900-324b924df8c4	220CdxG9zojh7LBraInl	3454	Tea	Beverages	5	106.18	2025-02-18 02:40:54	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183904264566	miguel.cruz15	2025-02-18 02:40:54
3b983996-bdc8-40be-a536-733eca6ae9c7	Yw7COGI7fUb1O0ylNWuQ	3458	Almonds	Pastries	4	5.59	2025-03-17 11:08:52	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2025-03-17 11:08:52
1286c6dd-35f0-4c15-9fb0-350e9db58d34	yaS0YrQkzlQGHpblyxSD	3459	Macchiato	Pastries	1	93.97	2024-12-12 21:22:32	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904002876	carlos.delacruz	2024-12-12 21:22:32
d919f046-aa54-478a-967c-80401a850d7e	ZF4b0VPQRnZivKVZXqzQ	3460	Hot Chocolate	Pastries	2	131.53	2025-02-28 16:48:53	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904307983	isabella.delacruz4	2025-02-28 16:48:53
72c3fb09-2d5f-4c1a-87e3-5be10171fd27	3p4SHKk9Yq9i5CqjYXNg	3463	Eclair	Pastries	3	146.12	2025-09-19 08:40:13	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	carlos.cruz12	2025-09-19 08:40:13
841bb7f2-c299-4571-b162-e29374e67e05	7DOul1nPAstNq3BBXNhy	3468	Tiramisu	Pastries	2	196.55	2025-02-19 05:58:01	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.mendoza	2025-02-19 05:58:01
72621908-f0c0-48a9-9dd9-282eb91f0f0a	L2Zaw3jlpCrEwpfbDguj	3469	Baguette	Pastries	5	133.77	2024-12-15 01:09:13	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	rosa.rivera7	2024-12-15 01:09:13
374032dd-99c3-4e73-a9b7-35eb2cc895ba	Lh5ZE5AI746GA7UHCyt5	3474	Flat White	Pastries	4	113.21	2025-01-06 09:33:29	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.torres2	2025-01-06 09:33:29
28c630c6-a239-42c3-8f3b-c1f02ae51b46	mbOCur7oJX2s4f84mE7P	3476	Glazed Donut	Pastries	2	148.75	2025-04-07 07:36:58	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	rosa.cruz13	2025-04-07 07:36:58
cfb76551-65d0-4059-8c64-0b4699f766e5	uz0zim0ukwXtul1VIQrY	3477	Espresso	Pastries	2	195.76	2025-11-06 04:52:38	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	sofia.bautista5	2025-11-06 04:52:38
1e95b127-df84-4530-912c-9e4d907fdc8a	6HyUQSbOvZS3dKDWyvKK	3479	Tiramisu	Pastries	3	196.55	2025-10-17 23:15:51	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	isabella.delacruz4	2025-10-17 23:15:51
13dc61cc-ffd7-4c40-93d6-bfaf600e8f1c	J763ReI9UjWh2JUKPDbk	3484	Hot Chocolate	Pastries	4	131.53	2025-03-26 23:04:30	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904367305	pedro.cruz14	2025-03-26 23:04:30
2dddf226-f0da-4f7d-9886-dc193dc7b3f3	jfTiX3A9YVr0hT0jAJjF	3485	Glazed Donut	Pastries	1	148.75	2025-10-23 02:50:00	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	antonio.santos6	2025-10-23 02:50:00
801674d7-bee1-4584-8d09-05b56a7c6ba3	vDGa3onnTLUCzicw30jL	3487	Chocolate Chip Muffin	Pastries	3	103.79	2025-11-12 00:03:44	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	admin	2025-11-12 00:03:44
89c58ecc-583c-4240-8a14-55988cacbfae	WDrYJWAbmXglgbXJAsVl	3488	Almonds	Pastries	3	5.59	2025-04-08 05:28:48	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904257149	antonio.delacruz10	2025-04-08 05:28:48
e22611e9-4c69-428f-b641-8feadc980ec5	GoQ0kTLJq3uLuqEAs38A	3489	Americano	Pastries	4	80.96	2025-01-06 19:03:16	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	miguel.cruz15	2025-01-06 19:03:16
beba23d1-b79d-4a98-8f30-8ccffbc3a17e	y6O2GoMxObS9X5CsJ0BS	3490	Flat White	Pastries	1	113.21	2025-06-27 05:29:36	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	pedro.cruz14	2025-06-27 05:29:36
94e4a15b-d8a2-4b07-b8fc-a6d90c4475a9	mtYSA3Q347WHmLqQY25E	3491	Iced Coffee	Beverages	3	107.80	2025-05-05 18:48:33	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.reyes9	2025-05-05 18:48:33
75d4e086-b244-4e94-8ddd-d88f790a95a4	GOudnjneI88zc11Tcf75	3492	Iced Mocha	Pastries	2	144.00	2025-10-29 11:03:41	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	elena.torres2	2025-10-29 11:03:41
c8585d56-85e3-4292-ba31-304cb7d66e10	rAhJ31bnGXgTZoWHIJbG	3495	Tea	Beverages	3	106.18	2025-09-11 16:29:27	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	pedro.cruz14	2025-09-11 16:29:27
1349a73e-b0da-49b2-8985-53ff31557441	J68HtDKXl8Q93SclZU8i	3499	Eclair	Pastries	4	146.12	2025-08-20 06:52:14	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904380870	elena.torres2	2025-08-20 06:52:14
10fc9ae3-5a01-4b25-a993-c569f4b2103b	P2pJAhZlT2j9pzNyF5jn	3501	Baguette	Pastries	4	133.77	2025-11-15 00:49:19	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183904554992	rosa.cruz13	2025-11-15 00:49:19
54fb83c0-91cb-4730-a25c-b4a68d04ea07	3VvcYYoapqOXAZLUhQXH	3502	Chai Latte	Pastries	2	100.50	2025-10-12 17:04:50	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904258068	gabriela.mendoza	2025-10-12 17:04:50
87ce0a09-6959-4578-86df-7833748c83d3	xLxMyy6pr42LVghGBLGs	3508	Almonds	Pastries	3	5.59	2025-11-23 10:15:20	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	antonio.santos6	2025-11-23 10:15:20
70b14441-8c49-4101-8e4b-e7273687540d	v4mxO9LEkuDKZxtOJUDg	3509	Almonds	Pastries	1	5.59	2025-03-08 17:20:34	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.cruz12	2025-03-08 17:20:34
91ba71ed-cb8e-4016-91f8-8ac5611061b9	GKlVxVZ4CknRKI8zYYO4	3511	Latte	Pastries	5	108.74	2025-08-02 22:47:53	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904524619	sofia.bautista5	2025-08-02 22:47:53
db3f1e31-e700-4171-8853-3d4fb28b5b9c	xRDi2m3a4rd7JW1auVED	3516	Red Velvet Cake	Pastries	1	187.25	2024-12-28 13:21:29	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904432372	sofia.bautista5	2024-12-28 13:21:29
c7d5bb25-7aa6-46c6-891d-0764691529ec	GLsi38M9XKGQa2yMNJCw	3519	Macchiato	Pastries	3	93.97	2025-03-28 10:41:37	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904210614	elena.fernandez11	2025-03-28 10:41:37
d4e2a1d8-96d8-4c56-bb7c-23e0dc7994dc	xbB5wXoj3BtHzKePUYe6	3520	Chai Latte	Pastries	3	100.50	2025-04-24 13:06:49	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carlos.delacruz	2025-04-24 13:06:49
1bc79ae6-eb42-4124-97f5-d244eccaa2ec	Bi7H0yqyGs4CtG3pF6aW	3523	Hot Chocolate	Pastries	5	131.53	2025-02-11 21:54:17	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	gabriela.mendoza	2025-02-11 21:54:17
9d23f85a-998c-43f4-8f69-0665c850e335	mBrLUxsLPyfQ40teQe7F	3524	Chai Latte	Pastries	4	100.50	2025-07-30 18:21:50	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	elena.torres2	2025-07-30 18:21:50
33e0246f-b81d-431e-9deb-34a149e8fd1f	YLbDn0wipA0vjzruISzi	3543	Eclair	Pastries	3	146.12	2025-10-12 03:23:41	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.fernandez11	2025-10-12 03:23:41
9dd7e489-6892-4e16-aae4-7c060993538a	pHM2yhFTVFuonSeqivxY	3544	Blueberry Muffin	Pastries	5	185.15	2025-05-03 12:08:12	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	elena.fernandez11	2025-05-03 12:08:12
e75d85ae-348b-4bc2-81ae-34bfe5efc1df	enPrGEVL6XsUoFGJx5CY	3545	Espresso	Pastries	5	195.76	2024-11-26 11:46:47	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	gabriela.mendoza	2024-11-26 11:46:47
fc9ab3e4-5f8b-482d-bbed-33fe68535a65	TpKCFjdEdZpKfrx3jtjs	3549	Tiramisu	Pastries	1	196.55	2025-04-15 14:14:04	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carmen.santos1	2025-04-15 14:14:04
9d7e50df-4d65-42c7-bfea-86708c897477	VtwF0QoN61IlCrRwilXp	3556	Tiramisu	Pastries	2	196.55	2025-01-09 21:17:42	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	miguel.cruz15	2025-01-09 21:17:42
3dd46d32-7a97-4f49-9fd7-80da8a59f67d	JEik1Of5YPjMjmdZpPQX	3558	Flat White	Pastries	2	113.21	2024-12-22 20:14:33	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	miguel.cruz15	2024-12-22 20:14:33
2eeece45-7d38-4235-8641-e19d7db26ad0	eOq6O85kaJFUHncE95ln	3563	Almonds	Pastries	1	5.59	2025-06-23 20:06:57	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904695681	rosa.cruz13	2025-06-23 20:06:57
2a9587da-d0fb-4db6-b471-6351f4f04e56	UWlZhFOcvJuxufrLHuEP	3571	Chocolate Chip Muffin	Pastries	2	103.79	2025-07-25 09:12:46	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904540309	rosa.cruz13	2025-07-25 09:12:46
6d0efafc-7935-4a53-96a8-477d16526b0b	7FfM29vgryyiAGFa3xXG	3576	Almond Croissant	Pastries	3	8.42	2025-07-09 04:23:11	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	pedro.cruz14	2025-07-09 04:23:11
33efcbca-dcb2-4217-bf63-b122b1c4cb9a	TMMhQEqTjPVgA3dtOEQR	3577	Tea	Beverages	2	106.18	2025-09-30 22:49:07	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	miguel.cruz15	2025-09-30 22:49:07
315dd4c7-c89f-467a-87b4-1072e62ded61	cgj6alTgCSwvudQxsvC7	3581	Glazed Donut	Pastries	4	148.75	2025-01-08 18:32:38	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904197762	pedro.cruz14	2025-01-08 18:32:38
86c64743-4e4e-4082-8f75-62d73d690de1	kAzRIfAxw3Pzfkb5hlUf	3586	Almond Croissant	Pastries	2	8.42	2025-06-26 07:39:38	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904583536	carlos.cruz12	2025-06-26 07:39:38
53759b91-6777-4d2d-9e93-2f8d31a3abda	G3yMSfvbofYXr28M6eFG	3590	Blueberry Muffin	Pastries	2	185.15	2025-07-23 00:46:33	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	ana.rivera3	2025-07-23 00:46:33
ef782ce3-c2b5-436e-a466-dfc986eccd65	npvK8KL0sNCpfqrs7viq	3591	Hot Chocolate	Pastries	5	131.53	2025-11-21 23:22:39	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904337622	elena.torres2	2025-11-21 23:22:39
6f6ace89-bf51-4e61-b971-882544862aaa	soav8NBrsooeC8zd7udF	3597	Chai Latte	Pastries	3	100.50	2025-10-27 15:05:12	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904089098	rosa.rivera7	2025-10-27 15:05:12
9385607f-cb69-4514-9c70-16d85527df66	3YYHnWihmISSzqQBviLx	3601	Espresso	Pastries	3	195.76	2025-08-20 20:16:28	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	ana.rivera3	2025-08-20 20:16:28
b3a2f64e-6911-4e44-a485-693c4829e217	OUPJhPiYY66Nd7Kleef3	3603	Tiramisu	Pastries	3	196.55	2024-12-20 04:16:53	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	gabriela.mendoza	2024-12-20 04:16:53
59c5c198-ed6b-46c6-8043-4d83acfbe9b7	BgCJ6UXdykw94unlUVPw	3606	Flat White	Pastries	2	113.21	2024-11-30 09:21:44	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	fernando.santos8	2024-11-30 09:21:44
478ea7ec-1a43-47e1-a880-5633ff511ab0	dMJkLHN3XfbXV2qi21pt	3608	Baguette	Pastries	3	133.77	2025-05-14 12:44:25	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	antonio.delacruz10	2025-05-14 12:44:25
1e0d92a0-29c0-48d9-89d7-3ab6405a5873	MQTWdXNFtEzR5kN0FnfY	3609	Eclair	Pastries	4	146.12	2025-06-08 02:25:04	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.delacruz	2025-06-08 02:25:04
1b4f3606-ebac-41af-bc4f-81841b2c52e0	cDomfVUqT2okDsT39KPp	3612	Almond Croissant	Pastries	3	8.42	2025-09-13 23:13:12	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.santos6	2025-09-13 23:13:12
8e11ff79-9c68-48a2-a55e-3065b51b8051	aPlwOIedK4hW4kEGOtaI	3617	Latte	Pastries	4	108.74	2025-01-27 14:26:10	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183904516616	carlos.mendoza	2025-01-27 14:26:10
b687c5b6-f038-4065-a05b-cf1e783a1b5d	eHrq64GH7NrXO03f0eCq	3620	Red Velvet Cake	Pastries	2	187.25	2025-09-23 07:05:31	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carmen.santos1	2025-09-23 07:05:31
10ce0701-e526-4ade-a114-6777333be54b	maTpAMx1UQK1JuNxk4RN	3628	Tea	Beverages	5	106.18	2024-11-25 04:52:51	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	ana.rivera3	2024-11-25 04:52:51
6b1509bf-b108-4d2c-a876-cf355d7531ee	HyoY0yUBu9uuX72KCKYf	3632	Almond Croissant	Pastries	3	8.42	2024-12-02 16:54:10	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.cruz12	2024-12-02 16:54:10
4fec63dd-cc22-4363-bafb-6795bff6344e	QjSCDJ7O1Ml7ly8dONpb	3633	Espresso	Pastries	1	195.76	2025-03-15 02:57:32	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.mendoza	2025-03-15 02:57:32
459bbd62-2099-405f-bf52-d418ab04abd4	swnNC2AyY60s7FEoo38t	3639	Flat White	Pastries	3	113.21	2025-05-14 07:03:05	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904460420	fernando.cruz	2025-05-14 07:03:05
025956e9-7013-4b97-8364-5817f0314fa7	uFQunDMugxJMyLfqQ7C5	3643	Hot Chocolate	Pastries	5	131.53	2025-01-03 13:12:53	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904849495	sofia.bautista5	2025-01-03 13:12:53
9bc7b766-1f97-44a6-89c1-a3227b317db2	fVwLpw7BUfGnmcaypUch	3644	Chocolate Chip Muffin	Pastries	1	103.79	2024-12-09 13:55:07	996934ff-5758-44b4-ad0e-4ed9d927901e	Card	\N	elena.fernandez11	2024-12-09 13:55:07
3bf69f93-c413-4d20-ab57-60a21a1ef890	XldM9KbOxp37zhrXwZba	3651	Macchiato	Pastries	1	93.97	2025-10-03 06:12:48	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904136103	antonio.santos6	2025-10-03 06:12:48
fe9c03ec-80bc-4d3d-bf1a-cf5cb9101985	ofA0633WAyblMMYM4EpK	3653	Tiramisu	Pastries	1	196.55	2025-03-12 12:00:51	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904838736	carlos.delacruz	2025-03-12 12:00:51
a13952bf-35d1-4e12-9d27-2fc54847032b	8oHmhuRw65zBIMjy7W55	3660	Baguette	Pastries	3	133.77	2025-03-11 20:20:58	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.bautista5	2025-03-11 20:20:58
a6afebfd-8b84-4e5c-b1ba-6a23c83c59f0	jrEBr9QgbF6i03lF3RY5	3663	Chai Latte	Pastries	3	100.50	2025-01-18 06:08:39	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	rosa.rivera7	2025-01-18 06:08:39
18ebd140-b176-43d6-a0ac-153b5e43e375	H9AnbkJrtTPrhyGQyopf	3665	Flat White	Pastries	4	113.21	2025-10-07 16:02:29	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.mendoza	2025-10-07 16:02:29
233df94a-a058-4fbe-88b3-42fe2e4ad48b	ZZPtZAJwmYrXGc3j8qtu	3669	Espresso	Pastries	3	195.76	2025-07-15 06:15:44	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	isabella.delacruz4	2025-07-15 06:15:44
682f7db4-2875-44b1-b59f-27842300c4f4	5LiZ2nEYDKCOVvQiroh0	3675	Almonds	Pastries	2	5.59	2025-08-15 07:26:11	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	fernando.cruz	2025-08-15 07:26:11
b5978ed7-edcd-4e02-986c-b7c5a65f2b1d	jjylDDO8jtEwtlgRwxkz	3676	Chai Latte	Pastries	2	100.50	2025-11-16 03:25:21	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904989613	antonio.delacruz10	2025-11-16 03:25:21
7c7d5918-d201-4b23-9614-bd25eb01f05a	5Vfe2Dki1SLoqJZe0GFl	3677	Macchiato	Pastries	3	93.97	2025-11-07 18:19:16	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904716685	carlos.mendoza	2025-11-07 18:19:16
2efafdf7-8144-4380-af70-9e2648c75a19	AODEkFbFXV82vcZtjyLA	3679	Hot Chocolate	Pastries	4	131.53	2024-12-03 14:17:37	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.delacruz	2024-12-03 14:17:37
670e148b-2619-4b4c-8a16-659270d009fb	LafPHYJHjZYJMhKBbTVJ	3684	Glazed Donut	Pastries	1	148.75	2024-11-27 08:41:07	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904869009	sofia.bautista5	2024-11-27 08:41:07
7de68ed9-e1da-4fe4-8240-8771dea99909	Dc5hBlP6RzV9lOl91JHG	6317	Mocha	Pastries	4	61.74	2025-01-20 14:46:03	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	admin	2025-01-20 14:46:03
65101f4f-1627-436d-ac8a-67a0dacc4ec3	QPybFxrmWJTSqaN9Nrtz	3686	Chocolate Chip Muffin	Pastries	1	103.79	2025-07-12 13:50:29	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	miguel.cruz15	2025-07-12 13:50:29
ad3c8b78-c338-4804-ba78-826571931ffe	ICUpb0MPpW4RzkxTFWhG	3687	Cappuccino	Pastries	5	76.25	2025-03-16 22:14:17	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	isabella.delacruz4	2025-03-16 22:14:17
3a709f81-e0d9-4840-81e1-4bfd71d68c03	fUeXQa7XYbnwCYyzTVnp	3692	Espresso	Pastries	1	195.76	2025-11-03 19:07:12	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.cruz12	2025-11-03 19:07:12
b0120c2f-a8a7-4a83-ac7a-aa34ca362b2a	IkW7QFvRAyv55GrAnam7	3693	Almond Croissant	Pastries	4	8.42	2025-10-10 10:45:28	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	ana.rivera3	2025-10-10 10:45:28
148a05a6-0c6c-41a6-8460-171bd2662a22	ZxVXjCe7nHVbPKxaode0	3694	Latte	Pastries	5	108.74	2025-09-25 09:20:11	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.cruz	2025-09-25 09:20:11
7cb424db-558a-45a1-9495-0755f5416467	CNzVOnE9q9sWaecplCuf	3695	Tea	Beverages	3	106.18	2025-03-14 15:45:29	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.torres2	2025-03-14 15:45:29
4e13737b-5ff3-4fc9-98be-0ffdadb2f59d	PXc76RzQMmKQ5ZG016Vf	3697	Iced Mocha	Pastries	3	144.00	2025-08-03 14:05:21	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904585589	sofia.bautista5	2025-08-03 14:05:21
949324e9-4a56-4002-86f8-71336c53fc0e	0UCsJ973uuTocF7O6cml	3698	Tea	Beverages	2	106.18	2024-12-18 14:48:49	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	gabriela.mendoza	2024-12-18 14:48:49
5c442ddf-6d70-455c-8f0d-3a1021273c36	uTUf5zEmQIh78KISEVmM	3706	Glazed Donut	Pastries	5	148.75	2025-05-30 21:08:36	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904026787	elena.fernandez11	2025-05-30 21:08:36
b6489528-418a-4790-989f-d804f75513c4	JQ6R8uQIrqEaVzm1J14g	3709	Mocha	Pastries	4	61.74	2025-07-10 14:29:26	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.santos8	2025-07-10 14:29:26
ddbf4cad-0e9f-4eea-aa66-b5fca396965f	RxEOctgBGyaona6hhTcK	3713	Glazed Donut	Pastries	5	148.75	2025-07-04 17:01:59	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	carlos.cruz12	2025-07-04 17:01:59
810307db-5752-4d8d-a8c2-2db29f84d593	CO155oPbLNL5rtARSaEo	3716	Iced Coffee	Beverages	2	107.80	2025-09-02 13:38:44	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	gabriela.mendoza	2025-09-02 13:38:44
685461bb-dffc-40f0-b85c-0237a3dc9c16	fXbjnJlRoiYetzt7vzka	3718	Latte	Pastries	4	108.74	2025-02-10 17:48:16	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	elena.torres2	2025-02-10 17:48:16
b942712e-5139-43b4-93d6-d309ecb719f8	ftokMzK1taPKAYp4QWdg	3723	Baguette	Pastries	5	133.77	2024-12-24 08:20:08	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183904384135	isabella.delacruz4	2024-12-24 08:20:08
b4ee6554-d66c-44c6-a774-9b42ae00f1c9	WzZEwLWMl35nYufHgDMU	3724	Americano	Pastries	5	80.96	2025-03-10 11:52:27	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	elena.torres2	2025-03-10 11:52:27
822bc675-78e0-41a8-9d83-a49f761acd05	6EoAyuzg2LoVRa4iEUUv	3725	Red Velvet Cake	Pastries	5	187.25	2025-09-09 03:10:14	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904758045	sofia.bautista5	2025-09-09 03:10:14
2cab163c-aa07-4080-8352-f7594bc4d3e3	KglMuVQTlhmqUXKt7Lss	3730	Espresso	Pastries	1	195.76	2025-08-12 21:37:30	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	sofia.bautista5	2025-08-12 21:37:30
c7f9e1d7-60c3-47f9-a3a7-f6fba8df65fb	RhX0bPwAAWp2IxEFabbt	3732	Baguette	Pastries	4	133.77	2025-06-13 18:29:49	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.torres2	2025-06-13 18:29:49
8043bd8a-7122-4a6b-8c8b-8fa7043e73be	nOQ8ad5p7LUe5aXbesos	3736	Cappuccino	Pastries	5	76.25	2025-09-23 08:45:34	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.cruz13	2025-09-23 08:45:34
81c688e2-76b5-49fb-9ca2-1be2c3e38f98	EmYUozXn0HwcBq3PYvjd	3741	Hot Chocolate	Pastries	4	131.53	2025-11-06 21:51:43	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.torres2	2025-11-06 21:51:43
a876f9a2-6567-4cfb-9d82-4efb610cad00	gl3asAPp6py9apvRyZ6l	3742	Red Velvet Cake	Pastries	3	187.25	2025-03-24 12:26:59	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904064228	elena.torres2	2025-03-24 12:26:59
5959f055-ff6a-4332-8bb3-4497cb1e1bf8	KO4m0cQzOJX5kgWrzzBx	3747	Americano	Pastries	4	80.96	2025-08-15 04:05:12	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.cruz13	2025-08-15 04:05:12
fb5b38f4-3a33-4590-8003-85a354b443b7	cxHSzCan6220EtobdHK5	3751	Mocha	Pastries	5	61.74	2025-04-05 07:41:55	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	rosa.rivera7	2025-04-05 07:41:55
535cd48f-a4de-4bec-bc63-6d2804d76050	xBu0gfRU6TMZucfn4yjg	3753	Chocolate Chip Muffin	Pastries	2	103.79	2025-09-29 08:04:41	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	ana.rivera3	2025-09-29 08:04:41
632ad7cc-821b-475b-a64e-bc909e21455f	TgEibhQegTHZHAG83NBu	3755	Cappuccino	Pastries	2	76.25	2024-12-25 10:23:31	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904389081	rosa.rivera7	2024-12-25 10:23:31
0c0299b2-9226-4ca9-b8f3-70021564ffbd	IFpokonTk66VwHMfaYoB	3756	Macchiato	Pastries	2	93.97	2025-02-23 04:46:43	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.mendoza	2025-02-23 04:46:43
fcfd3a2d-f2ce-430f-976f-06897c6fe405	r9tGl8AiR9mUNwnGkejJ	3758	Chocolate Chip Muffin	Pastries	4	103.79	2025-05-28 16:06:13	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	elena.torres2	2025-05-28 16:06:13
75da0efd-2c6b-41eb-b420-6a7852d6fa1f	qUYPVVJcqjqnOb0sGtBS	3759	Flat White	Pastries	3	113.21	2025-07-08 00:40:34	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	sofia.reyes9	2025-07-08 00:40:34
186bbe28-0b16-460c-b549-956c69368787	B5cWjjsbarCX580UV25T	3763	Americano	Pastries	3	80.96	2025-07-11 20:31:37	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	elena.torres2	2025-07-11 20:31:37
a0bc112c-d5b9-41da-b355-67c185f3452c	5UMOfH6Pe3HLF4poEWBO	3766	Americano	Pastries	3	80.96	2024-12-02 03:53:32	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carmen.santos1	2024-12-02 03:53:32
56e172db-f1a7-48c0-8aa8-d30886651f05	VuVClbiJyXcEqrwf3pew	3769	Blueberry Muffin	Pastries	5	185.15	2025-08-12 17:28:35	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	fernando.cruz	2025-08-12 17:28:35
ba2fb7ba-a74e-417f-be59-2d137d12b308	5PLnuy2NJGLPr5aHriQ3	3776	Apple Turnover	Pastries	2	154.54	2025-09-11 00:00:33	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	ana.rivera3	2025-09-11 00:00:33
d9dcf63c-090d-48d4-b610-2bc33d186a3b	cgKxu7awZXBEVOyMx9dZ	3780	Mocha	Pastries	5	61.74	2025-06-30 19:45:01	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904084954	fernando.santos8	2025-06-30 19:45:01
5d7c5635-1888-4a92-b401-1bff9514763f	MOJRQgJtg9l59O9wRkr2	3781	Almond Croissant	Pastries	5	8.42	2025-06-10 09:54:59	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2025-06-10 09:54:59
2aca1c65-0c69-4770-9c70-37078db25287	H6L8WuCP07sqZAYWHWGo	3782	Glazed Donut	Pastries	1	148.75	2025-08-30 23:48:56	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904947205	isabella.delacruz4	2025-08-30 23:48:56
ffdcb036-b267-4ab1-a747-3befc5233cec	zwDt9Zsa09sYRM1JzdmK	3783	Iced Coffee	Beverages	2	107.80	2025-03-18 04:29:17	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	rosa.rivera7	2025-03-18 04:29:17
7f524ffc-ea27-4af4-9ef2-9f777e765c80	I3u4sULhBK5Cz0BNU5Wr	3784	Iced Coffee	Beverages	4	107.80	2025-06-16 03:23:53	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904520538	rosa.cruz13	2025-06-16 03:23:53
b9bd96df-1dbc-4415-9722-fdd721434270	8wgU2aTR0SDCl2JhyxyY	3786	Almond Croissant	Pastries	4	8.42	2025-10-12 22:07:47	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.santos6	2025-10-12 22:07:47
1bea1176-ee01-46d1-a96f-3419e375632c	RnS5GnWquYVOWS4qR55U	3791	Cappuccino	Pastries	4	76.25	2025-10-04 21:54:48	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904052202	sofia.bautista5	2025-10-04 21:54:48
2a572b11-a536-48c9-88b9-9ed0a4f866bd	GXYaV9rcplPnFH5Ro40D	3792	Flat White	Pastries	1	113.21	2025-07-03 20:42:23	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904334777	rosa.rivera7	2025-07-03 20:42:23
84a6b5a0-07de-4ad9-9059-79dc06c7e6f9	paY1b9AgApiGWSTslwyi	3795	Americano	Pastries	5	80.96	2025-06-25 17:41:58	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	fernando.santos8	2025-06-25 17:41:58
1d055f51-99c2-430e-8d88-bf0af23e9946	VdbiTahQdDvErENqDEvU	3798	Americano	Pastries	4	80.96	2025-07-25 01:34:38	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	fernando.cruz	2025-07-25 01:34:38
8887c408-4551-4e17-bb95-d2f1af8a90d2	giEJgLri5egAphbXJh8z	3802	Iced Coffee	Beverages	1	107.80	2024-12-12 00:53:46	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904119983	gabriela.mendoza	2024-12-12 00:53:46
1b42617d-088a-4e1a-9621-7aaced484b8f	MEIwhK0c3gcyFWCOoMcn	3811	Chocolate Chip Muffin	Pastries	5	103.79	2025-05-28 00:37:22	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904897532	admin	2025-05-28 00:37:22
09cd956a-4f59-42ad-8433-2f705953b1d1	u6KM9b0kormoX1iJWaKI	3815	Flat White	Pastries	5	113.21	2025-06-07 03:30:54	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	sofia.reyes9	2025-06-07 03:30:54
55f1b737-e912-4da4-a9a0-1101fcfda5a5	eXba8n6Vgn0FG1G8rtHO	3816	Glazed Donut	Pastries	2	148.75	2025-05-22 07:44:05	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	fernando.cruz	2025-05-22 07:44:05
a83711ae-87ee-4a95-9214-6c39ad917240	WQur5uUyCs8C80DGnaU9	3818	Almond Croissant	Pastries	1	8.42	2024-12-12 03:38:08	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904987102	sofia.bautista5	2024-12-12 03:38:08
1d3bdb4b-556d-499b-8bd6-2e9684af0e75	zVolFF5dAan5N6tCn7Ln	3820	Baguette	Pastries	5	133.77	2025-07-06 17:46:16	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183904499332	carlos.mendoza	2025-07-06 17:46:16
ca5479aa-4518-4710-8e23-33be5286b72b	afSAGu7d1xLqsv5Bgx55	3821	Eclair	Pastries	3	146.12	2025-09-30 07:01:02	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.torres2	2025-09-30 07:01:02
930c515a-1b3a-48e3-b46e-4a4aa82c33f6	D659VYFUJUSnTLdj3Is7	3822	Almonds	Pastries	4	5.59	2025-09-10 05:11:29	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.cruz12	2025-09-10 05:11:29
a217eaaa-0b77-4cd2-839c-74dc7c5d5130	RzbVoRIfMQTYC2jI3ydz	3827	Tiramisu	Pastries	5	196.55	2025-02-28 14:03:32	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.santos6	2025-02-28 14:03:32
f568b1dc-1919-4ae8-9ec3-e0563374d159	1rpy0qdZsl4bra8NAovB	3830	Iced Mocha	Pastries	4	144.00	2025-08-20 22:01:15	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.mendoza	2025-08-20 22:01:15
9175e724-d237-498d-8811-379d512c9700	aDZmzaylW1X0aKwvbeLp	3838	Chai Latte	Pastries	2	100.50	2025-10-04 04:30:50	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904306416	rosa.cruz13	2025-10-04 04:30:50
81319064-012b-4d6b-8183-93d2945a7b80	TMuk4DcetP2LgVWUtHz2	3839	Espresso	Pastries	4	195.76	2025-07-23 10:05:09	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	fernando.cruz	2025-07-23 10:05:09
6386ac4b-b08d-4dfc-98d8-2c08d92229a3	WsMebNP2Ir7O3oFMv1bX	3840	Cappuccino	Pastries	3	76.25	2025-11-18 07:54:37	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	sofia.bautista5	2025-11-18 07:54:37
44b9ee76-f5c5-4699-af06-8af15680f2a4	oSX1uZJYMfj8zmMhBO1s	3841	Americano	Pastries	4	80.96	2025-11-02 03:53:36	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.cruz13	2025-11-02 03:53:36
5b88cf67-947d-4c51-8d4a-ed3a4fbf00ff	yrEcskIyUgOZ0W99Jqam	3843	Eclair	Pastries	1	146.12	2025-04-27 22:36:57	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904192377	carlos.cruz12	2025-04-27 22:36:57
59e71d1b-500b-4589-a00d-63d41c9f0785	FhiJZJYj4l1Vfef18pc4	3844	Cappuccino	Pastries	5	76.25	2025-08-28 09:23:10	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	gabriela.mendoza	2025-08-28 09:23:10
a3b7332a-53f0-40d4-a3e6-9824e60642d4	Osp9Gdf8tauCGbOZsm0v	3845	Apple Turnover	Pastries	5	154.54	2024-12-25 07:23:48	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carlos.mendoza	2024-12-25 07:23:48
d19c71d4-6987-4638-97dd-7f806eb1aeea	QdqedQSnsLiXFg2gFg05	3846	Macchiato	Pastries	3	93.97	2025-03-29 00:05:41	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904605889	isabella.delacruz4	2025-03-29 00:05:41
f0f06184-ff54-4ba3-8303-93a4c9b46c34	hBfkYXpvfwNNLVcMqVaD	3847	Almonds	Pastries	4	5.59	2025-10-02 13:45:35	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	fernando.cruz	2025-10-02 13:45:35
15fde8dd-60f7-4616-8d30-b64acceb0ed1	2GpSCY5yIgLbqrsBHlQn	3851	Apple Turnover	Pastries	2	154.54	2025-08-07 07:33:19	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904639900	carlos.cruz12	2025-08-07 07:33:19
00a380a0-e6ac-4266-b089-cb6c388efdbd	gFoGbqfs36RIUavucAf2	3853	Glazed Donut	Pastries	5	148.75	2025-08-05 12:38:57	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904192691	miguel.cruz15	2025-08-05 12:38:57
7e1e98b5-80c2-4127-965d-9ebc38969545	U99FtWzB64nZRZ0cAevp	3860	Iced Coffee	Beverages	3	107.80	2024-12-25 22:14:20	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183904838345	rosa.cruz13	2024-12-25 22:14:20
6f94d41d-cc6a-4e1f-9d3f-221974786220	My4e7JMpzUGgIF4DFk2T	3861	Macchiato	Pastries	3	93.97	2025-02-23 13:58:22	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.santos6	2025-02-23 13:58:22
c639757a-134c-4f14-9298-48a432171666	bqFdi5bknFBUQcLeKzab	3864	Americano	Pastries	5	80.96	2025-03-11 01:05:05	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	pedro.cruz14	2025-03-11 01:05:05
08f229ec-2ac8-4658-9ff7-bd811467b29e	pwd5tgxjuL9xHfkO2Fgk	3867	Iced Mocha	Pastries	2	144.00	2025-11-07 05:11:47	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	rosa.cruz13	2025-11-07 05:11:47
5d3e267d-1b3f-4b4c-8d44-2e97f0a50dde	vr5UMLWYEaiGyPd64hXH	3868	Espresso	Pastries	1	195.76	2025-03-08 14:36:37	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	gabriela.mendoza	2025-03-08 14:36:37
323c5b5a-8ff9-4f66-a82e-9fe65f02b5b5	jvExr8mZLPmBAUP9PjD6	3869	Flat White	Pastries	3	113.21	2025-11-16 15:26:16	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183904086340	miguel.cruz15	2025-11-16 15:26:16
20c48fe5-b8db-4c73-b8ae-6d928f2b3bee	g5jp8kcXkQ5eNzGIy6CT	3870	Blueberry Muffin	Pastries	1	185.15	2025-06-18 04:51:24	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	gabriela.mendoza	2025-06-18 04:51:24
d9775189-23d2-4554-92da-62a3085b16bb	o4l3snTOL5HIgzzZtk9r	3871	Hot Chocolate	Pastries	3	131.53	2025-02-08 12:04:59	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.cruz12	2025-02-08 12:04:59
ef0c9855-4686-43e9-8529-6f411cf41b1a	5QXTr66cahWa22GXx5FY	3877	Eclair	Pastries	1	146.12	2025-11-02 21:24:28	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	miguel.cruz15	2025-11-02 21:24:28
8b4c14ae-ad47-441e-af9b-ab3a36f19476	AEWJXB79lSC65cRWl5pW	3878	Iced Coffee	Beverages	1	107.80	2025-09-30 12:23:00	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	elena.torres2	2025-09-30 12:23:00
4d47c399-9006-4cfd-a3db-38f67e4bd82c	v9X0MHcqjGk2HRwDsZmO	3880	Chocolate Chip Muffin	Pastries	1	103.79	2025-05-20 16:38:16	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	fernando.santos8	2025-05-20 16:38:16
337c0f32-ffa5-400a-baa1-30391f99cecc	AODvI0LWBeLpk6Z3Kh8t	3882	Macchiato	Pastries	2	93.97	2025-06-01 09:09:53	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904643912	antonio.santos6	2025-06-01 09:09:53
031e7c1e-12d0-452e-ab22-7ebb03239920	YBssdIPcB6pZOi8VsSOd	3886	Tea	Beverages	4	106.18	2025-05-25 20:07:34	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.torres2	2025-05-25 20:07:34
f60780f9-a719-4255-922f-d6195a2c16c4	rwbMzXKS0YvAbCZmflhN	3891	Chai Latte	Pastries	2	100.50	2024-12-31 13:55:25	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904162660	sofia.bautista5	2024-12-31 13:55:25
760f26ee-53f1-41e9-856b-8325ab31c192	\N	\N	Almonds	Pastries	1	5.59	2025-11-26 01:03:17.831524	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2025-11-26 01:03:17.831524
9f608c7b-bc21-4ddb-ab0a-7a606c167d46	VXvJIpRAMK13AYVYJTnj	3900	Apple Turnover	Pastries	5	154.54	2025-07-09 00:29:41	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183904991743	miguel.cruz15	2025-07-09 00:29:41
5cc14197-acb1-4a38-9040-8a131f1bf8d1	pP9AsFqmVZ7uOxQX4yVz	3902	Tiramisu	Pastries	3	196.55	2025-10-03 02:29:16	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183904998267	pedro.cruz14	2025-10-03 02:29:16
ad94189e-cd18-479c-af17-485ce3b026ec	3KL31kul7FET3T9SdSGe	3911	Red Velvet Cake	Pastries	2	187.25	2025-11-24 14:17:00	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	rosa.rivera7	2025-11-24 14:17:00
a2cd2d96-3640-441f-a035-66294c86d4bc	t1jZoR2rrVB9rtU30YpX	3915	Cappuccino	Pastries	4	76.25	2025-03-13 00:34:14	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	gabriela.mendoza	2025-03-13 00:34:14
f10b5f9e-5388-4329-a9f2-9191a241d391	WuxIZwlZBeO9awUi4fsq	3918	Tiramisu	Pastries	2	196.55	2025-01-18 23:29:01	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carmen.santos1	2025-01-18 23:29:01
3b38c959-cb1c-4524-bcd7-051193d99376	M3SKfT6pwr70exBZqui7	3923	Eclair	Pastries	3	146.12	2025-07-08 20:36:29	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904634878	miguel.cruz15	2025-07-08 20:36:29
e50f6cb8-49f8-452d-9633-f7beb1908511	L8nCfYcbezhggK4B21VE	3930	Macchiato	Pastries	3	93.97	2025-03-05 07:13:28	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904693207	gabriela.mendoza	2025-03-05 07:13:28
0ed7144a-0166-4866-96ad-dea5a07111a8	\N	\N	Almond	Pastries	1	5.59	2025-11-26 01:20:03.654692	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2025-11-26 01:20:03.654692
7361a861-4cab-4f28-ad32-0a067b73ae16	X81uWaWaVNcncAeF1UVF	3936	Almond Croissant	Pastries	2	8.42	2025-01-27 18:49:57	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	pedro.cruz14	2025-01-27 18:49:57
6e697856-0d20-456d-b2e8-9224c809f3c5	QC6abmMUTa4jnHjn6U3c	3940	Almond Croissant	Pastries	5	8.42	2024-12-27 16:00:44	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904142253	ana.rivera3	2024-12-27 16:00:44
b13bebe0-b6de-4c72-aba1-27ecbe15993c	SGrVq9cueQHHL7wiJHvP	3943	Macchiato	Pastries	4	93.97	2025-09-22 06:18:32	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.delacruz10	2025-09-22 06:18:32
cd7e1b41-9b95-40ba-924b-c0043153c6c4	NQYPuHUBdD8D8gDiOBy4	3946	Hot Chocolate	Pastries	1	131.53	2025-05-01 12:31:53	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904775241	pedro.cruz14	2025-05-01 12:31:53
f8fc603e-ec72-4b97-b93d-f6c066c6756b	lLezMhLPlF8Hc2BIBqVF	3948	Espresso	Pastries	2	195.76	2025-04-20 19:28:37	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	gabriela.mendoza	2025-04-20 19:28:37
52a25108-ac31-47c0-9888-c40455afd96f	Kt2dAGup8NkyL6DBt17Z	3950	Iced Mocha	Pastries	2	144.00	2025-05-09 02:46:34	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	admin	2025-05-09 02:46:34
e72dc940-1549-4ec4-9a65-8b7c47b19f84	mkNIyjtWi1JmlOYWlrJp	3955	Blueberry Muffin	Pastries	5	185.15	2025-03-18 14:20:18	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	sofia.bautista5	2025-03-18 14:20:18
95e51977-0fbb-471b-8feb-dd58ea61526c	RGSDnQ6PQyiagzYkVyZG	3957	Flat White	Pastries	3	113.21	2025-06-19 08:54:54	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	antonio.santos6	2025-06-19 08:54:54
cb19a654-a8f5-43ce-93d9-1d0e8e4a8e7b	1yU4x2OYbuKiaa6Ch6CY	3958	Eclair	Pastries	3	146.12	2025-08-12 13:14:17	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183904182934	sofia.reyes9	2025-08-12 13:14:17
4ccca486-d94c-4f68-aa1b-c4c2ff79ba69	tSF6dkWVde03z4UgcDPO	3959	Glazed Donut	Pastries	2	148.75	2025-09-16 03:29:32	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carmen.santos1	2025-09-16 03:29:32
3bc26e8f-a3e5-45e8-a3ea-c03480775219	h2pMoipgKBKGUevQR2EQ	3963	Americano	Pastries	1	80.96	2025-08-10 09:18:51	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	admin	2025-08-10 09:18:51
b2801167-dd19-45cb-8224-882ad5af529b	pL74UVWQm81T1A9lwvyQ	3965	Hot Chocolate	Pastries	2	131.53	2025-05-09 07:33:30	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904807280	rosa.cruz13	2025-05-09 07:33:30
5aa1ac72-31d5-48d1-b6cc-4b134820624a	IiIStbiGkKOfORTR47vZ	3970	Apple Turnover	Pastries	1	154.54	2024-12-23 20:22:49	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carmen.santos1	2024-12-23 20:22:49
2cc8794a-8bb9-4094-bf06-a2010f088ccc	uNfmkmGpL19sn0vWv6UQ	3977	Glazed Donut	Pastries	3	148.75	2025-08-04 04:49:40	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183904073003	elena.fernandez11	2025-08-04 04:49:40
db9ae6ac-9959-4b38-b23c-c6e8227e0173	J9adI0nT1a3uw5Y1vgeM	3978	Hot Chocolate	Pastries	3	131.53	2025-01-12 20:05:14	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904532317	carlos.delacruz	2025-01-12 20:05:14
b56bd8b7-acb3-487b-8adb-ef4e28aaa8a9	OtLiqTy3NJNQHqGCMWiS	3979	Mocha	Pastries	2	61.74	2025-11-20 17:26:52	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.bautista5	2025-11-20 17:26:52
261301e4-a9a3-4ed1-b220-403b469943e1	hl6zVWdEcAjeIA8M0QnM	3981	Blueberry Muffin	Pastries	1	185.15	2025-06-09 00:48:12	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904767824	elena.fernandez11	2025-06-09 00:48:12
244f7a45-eac2-4552-be7e-21d33ba77b48	0lLIrGk0dD8tKVJUKXu8	3982	Almonds	Pastries	3	5.59	2025-01-26 09:58:11	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.mendoza	2025-01-26 09:58:11
b8773f6a-7c06-43fe-8b39-149266c1addc	a5A72Rue5Z6pWmLimYDB	3988	Iced Coffee	Beverages	5	107.80	2025-11-03 17:29:39	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	gabriela.mendoza	2025-11-03 17:29:39
7f3eb3c6-6a8e-4e0a-8edb-3c7dec2fbcfe	Kia1soHEVNgchvxDhppP	3990	Almond Croissant	Pastries	3	8.42	2025-04-14 17:19:14	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	rosa.cruz13	2025-04-14 17:19:14
376f9360-f788-4625-a850-55c7fb1e6c65	QY1RWRNJLL2B1z4Utw8T	3992	Hot Chocolate	Pastries	2	131.53	2024-11-29 20:11:18	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183904940095	antonio.santos6	2024-11-29 20:11:18
04d26f60-7d2e-4285-8463-fbeda4e33df3	4YRkMMQGaO5kyU6T9FFf	3994	Hot Chocolate	Pastries	4	131.53	2025-03-15 17:05:58	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.cruz12	2025-03-15 17:05:58
aa8c1b5c-790f-439b-ac00-8bceb637b156	Os2p7bb4m2kBVgO0H262	3998	Eclair	Pastries	4	146.12	2025-03-07 06:39:27	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	miguel.cruz15	2025-03-07 06:39:27
b8a0383b-4fde-4353-be82-b1ac68eab395	unhrntpffksaTDbGCWLi	4002	Iced Mocha	Pastries	4	144.00	2025-06-23 06:43:31	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183904337180	antonio.santos6	2025-06-23 06:43:31
2cab4bb1-f92a-4258-aa2f-2b78838192d0	hqnnSXZK396FiRIEDGGg	4006	Americano	Pastries	5	80.96	2025-01-31 06:20:02	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183904084236	ana.rivera3	2025-01-31 06:20:02
df6b3dd8-a224-4cd8-820b-211e12dd6c12	klxIKp0P3vFjSSb9iXyi	4007	Almonds	Pastries	2	5.59	2025-07-04 00:27:55	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	miguel.cruz15	2025-07-04 00:27:55
5f300f54-4495-471b-b4ac-f48d905d7865	WPdFQryW5OJMNmcgo7pm	4008	Chai Latte	Pastries	1	100.50	2025-04-19 18:38:38	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183904484528	rosa.rivera7	2025-04-19 18:38:38
12ae3381-e509-401d-94c8-114c52804509	T0YuAuPFdsrrWRlsL1li	4011	Almond Croissant	Pastries	3	8.42	2024-12-12 20:20:00	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.mendoza	2024-12-12 20:20:00
5757e411-fd68-4d3c-a9b5-3a13b5c19263	4mNIstUPSVUXVgz3JMMu	4012	Macchiato	Pastries	5	93.97	2025-06-27 02:08:16	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904707642	sofia.reyes9	2025-06-27 02:08:16
05261f28-9a08-4358-ae9e-89ac8b85aca2	hRHU3Bk90q2fb57Ga9lj	4013	Blueberry Muffin	Pastries	4	185.15	2025-03-04 02:50:16	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183904933564	sofia.reyes9	2025-03-04 02:50:16
97e97e08-93c9-437a-8710-d99dddaadedb	hXH8g5QDG6cHxkbzdyTh	4014	Cappuccino	Pastries	2	76.25	2025-05-17 23:24:08	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904525255	rosa.cruz13	2025-05-17 23:24:08
b283fda8-12c6-4bbc-8cb3-d45226bc8952	odWHNmAGqYheEu6M80pS	4015	Chocolate Chip Muffin	Pastries	3	103.79	2025-08-23 12:04:19	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	fernando.santos8	2025-08-23 12:04:19
344de9d0-413c-4257-8223-6955090d3a6b	iAx9avH7BWYIAqj8AZUI	4016	Eclair	Pastries	3	146.12	2025-01-31 00:17:02	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	sofia.reyes9	2025-01-31 00:17:02
f35e0129-c151-4e4c-802c-2cfa7f72b06c	E6aSWT2oC433bm7crWLG	4019	Cappuccino	Pastries	1	76.25	2025-02-18 12:00:35	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904842712	sofia.reyes9	2025-02-18 12:00:35
1fe4134a-dcc9-4320-8c24-22f3f442a27d	3dqVTPSd6CaHEy0USBeq	4020	Almonds	Pastries	1	5.59	2025-09-11 01:39:49	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183904618451	carmen.santos1	2025-09-11 01:39:49
17f1d723-0965-48ad-887a-89e0476af4e5	ycrgpCLDn1pGc1KvZdaQ	4023	Tea	Beverages	2	106.18	2025-09-10 18:53:41	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	rosa.cruz13	2025-09-10 18:53:41
1b74c581-308f-40e1-904b-30ecdeaaa0b4	7frzYZXH5ogPluIA7RDp	4025	Chocolate Chip Muffin	Pastries	2	103.79	2025-07-13 00:50:22	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183904839452	rosa.cruz13	2025-07-13 00:50:22
bb848f14-915a-4734-86d5-c80450ee8acd	clLSvIzvZFR7nLPzxDTb	4027	Almond Croissant	Pastries	2	8.42	2025-03-12 02:37:15	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.cruz12	2025-03-12 02:37:15
bdd66da5-8656-4aa1-8200-03ac478bdb99	REF3mCDIQhK3KwfkDFuP	4030	Macchiato	Pastries	5	93.97	2025-10-06 23:05:34	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	fernando.cruz	2025-10-06 23:05:34
90aacd31-66af-4cac-9214-eb85a343a777	j0Q7FhgGP6OmAhz9jrDS	4032	Tea	Beverages	1	106.18	2025-02-21 12:17:28	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.torres2	2025-02-21 12:17:28
f13af4ce-afd2-4bfd-998a-10ff70f4d3a0	kA68VIkZS51oIsDUcliT	4036	Red Velvet Cake	Pastries	4	187.25	2024-12-13 10:59:22	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	gabriela.mendoza	2024-12-13 10:59:22
8731ac3d-a73a-41e8-9cd3-4718d114ba7e	BA23rCy0rShbo76LI63U	4038	Tiramisu	Pastries	4	196.55	2024-12-02 02:58:12	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	sofia.bautista5	2024-12-02 02:58:12
a0c0405e-914d-4521-9525-993c8d543637	mgmZdHTbylOLTUjF1h6Z	4045	Mocha	Pastries	2	61.74	2025-08-26 01:02:57	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183904042440	gabriela.mendoza	2025-08-26 01:02:57
0f860780-ce88-4f5f-9e8e-908356191980	CKdlIdBGOWRmniqADwyk	4049	Glazed Donut	Pastries	5	148.75	2025-09-09 00:11:31	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.reyes9	2025-09-09 00:11:31
497dafd3-3f0e-4012-b298-f7da6a98498b	DhbEiaviBLO7EmvkAnZp	4053	Iced Mocha	Pastries	5	144.00	2025-03-05 05:32:22	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	carlos.mendoza	2025-03-05 05:32:22
fffec283-598e-4fa4-aa86-8d6ff15c2924	ibmUWzwqdURNrVJkJmer	6601	Mocha	Pastries	2	61.74	2025-07-22 13:00:58	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	admin	2025-07-22 13:00:58
bbc45cc9-3273-47d2-993c-2b991dc153c4	c86X9bMJfFFXZqhPvDij	4054	Red Velvet Cake	Pastries	5	187.25	2024-12-01 13:20:07	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	pedro.cruz14	2024-12-01 13:20:07
d7cbc60d-1fc6-483d-ad4d-20b0b7cb2b3c	h3fRMBQ9nU8lzuM0IVqn	4056	Red Velvet Cake	Pastries	5	187.25	2025-08-01 20:05:14	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183904774265	ana.rivera3	2025-08-01 20:05:14
a225f06a-9a8a-44e3-be3f-28b152fe5dcc	zsT1zMucuLnsmG4dypcN	4057	Blueberry Muffin	Pastries	3	185.15	2025-02-15 07:37:45	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	gabriela.mendoza	2025-02-15 07:37:45
700334b4-8898-451e-84a3-deea5a0f37b6	zp7dEDFPEVSkEyxiWUfq	4060	Tiramisu	Pastries	4	196.55	2025-06-12 05:34:20	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.santos6	2025-06-12 05:34:20
fe85feb5-9f38-41bb-98d3-43035bb85118	oVvUieudubTdORzEVi48	4061	Tea	Beverages	1	106.18	2025-04-05 10:45:32	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.mendoza	2025-04-05 10:45:32
f320dbf7-8ca9-4f0e-b829-000d10e09d38	fIUEWdYIVw4m6PmMahU7	4066	Iced Coffee	Beverages	3	107.80	2025-06-29 10:48:55	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.delacruz10	2025-06-29 10:48:55
27662d74-1c52-4ef6-ac1e-7c6d697a8b12	VEstBuzvrenmv7zj1aRP	4067	Iced Coffee	Beverages	4	107.80	2025-05-10 11:45:25	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.santos6	2025-05-10 11:45:25
d258f284-880a-4cad-b440-b82e7ef10407	MW9PRQsYZ9RahQVKTHHp	4069	Espresso	Pastries	3	195.76	2025-01-18 12:09:29	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	sofia.reyes9	2025-01-18 12:09:29
012b4c5c-8466-4ad7-befd-e38b0085f878	jhixvI3J8lTiROPjNV4X	4073	Chocolate Chip Muffin	Pastries	3	103.79	2025-03-07 23:16:34	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	miguel.cruz15	2025-03-07 23:16:34
514727c4-c353-4eab-86e8-0a00821a7c90	aFU7t9mKcQAP8a0eCggY	4075	Blueberry Muffin	Pastries	3	185.15	2025-10-31 09:23:20	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	miguel.cruz15	2025-10-31 09:23:20
0af0792b-8754-4c93-90b7-21fa67cbb7ff	XMLoKuUkyO4m544LAXGM	4076	Eclair	Pastries	4	146.12	2024-12-21 02:57:57	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.fernandez11	2024-12-21 02:57:57
bbbc8289-367c-435a-b7f9-c6538e244471	xIsz59XXdwAr70t2Vjvn	4084	Macchiato	Pastries	5	93.97	2025-06-17 00:16:44	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	elena.torres2	2025-06-17 00:16:44
c90c1f74-111d-4572-98b1-08a8dfb81682	6POGKxXfjNHHx5RdvAjI	4085	Macchiato	Pastries	2	93.97	2025-03-07 02:43:21	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183904735213	carlos.delacruz	2025-03-07 02:43:21
5a9a608f-d034-44d8-a478-10de8ff2addb	APKRVHb0QVixlF4ZpRNv	4086	Cappuccino	Pastries	4	76.25	2025-06-20 19:38:34	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904134138	carlos.mendoza	2025-06-20 19:38:34
55fe414c-620a-4381-b4f6-6927a023b4a2	Uv7vvfRK0b4QdoVLHIvu	4094	Almond Croissant	Pastries	5	8.42	2025-03-27 03:47:11	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183904425937	carlos.mendoza	2025-03-27 03:47:11
d64db452-2781-41f0-8b09-88c7c9cc4e81	qZxJZnsuIWgjXt957B1k	4097	Glazed Donut	Pastries	4	148.75	2024-12-04 09:10:31	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	miguel.cruz15	2024-12-04 09:10:31
e435242a-ba71-4dad-8148-b94fa083638c	SXNklCElxYSQ0Vna7PGS	4101	Almonds	Pastries	5	5.59	2025-05-14 04:41:58	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.cruz12	2025-05-14 04:41:58
a44fb95c-aef5-4d7e-a65c-c0f06ceec35a	IlWg0rx3twPtU22Flkh6	4104	Iced Coffee	Beverages	5	107.80	2025-11-17 22:56:59	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.cruz12	2025-11-17 22:56:59
b56a2244-c605-483b-bfb3-f86d667ff67e	9oAh8HOmiGOonoMwghbv	4105	Latte	Pastries	5	108.74	2025-04-24 08:55:46	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.cruz12	2025-04-24 08:55:46
057a4ff0-c30d-4ffe-8369-a1c243171e93	T4a6cgnVaPUfyWSxYm4b	4106	Hot Chocolate	Pastries	4	131.53	2025-10-16 00:05:33	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	gabriela.mendoza	2025-10-16 00:05:33
d2cc5b65-38b0-407d-bb89-61aa77b5a2ff	Qodj3Fo3SjzaODyCjrcd	4109	Chai Latte	Pastries	2	100.50	2025-07-06 07:59:07	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	fernando.santos8	2025-07-06 07:59:07
3817568e-bf08-499f-b8c9-5d74b9d34145	D9LzE7j6n2NrUU9uTnf0	4114	Espresso	Pastries	5	195.76	2025-05-23 11:50:22	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carmen.santos1	2025-05-23 11:50:22
ece7d48c-6018-4474-9b72-cc57ec7d8cdb	jT51a7Lj8Z6K3evasUDI	4115	Blueberry Muffin	Pastries	5	185.15	2025-09-27 13:26:27	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carmen.santos1	2025-09-27 13:26:27
b9c806e5-1ed0-4884-bfc2-9fcee230d76f	WNQMovUScxHldh5gKyNo	4119	Cappuccino	Pastries	1	76.25	2025-07-04 08:57:20	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183904928720	carlos.cruz12	2025-07-04 08:57:20
06ca1ec5-79ac-4808-877e-ee2badadb3d8	GXIK0EJlwKq6BIFQPDbm	4120	Almonds	Pastries	5	5.59	2025-11-15 04:34:27	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.reyes9	2025-11-15 04:34:27
f828b1be-08f1-434d-a54b-03d8553020ac	o4ofykjVJC4QLwmnjo3Q	4123	Hot Chocolate	Pastries	2	131.53	2025-07-07 07:43:25	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.mendoza	2025-07-07 07:43:25
5500e24d-a6e3-4af4-9a6b-a38ba9d86a03	xCOHj33LwxhhXz5XZVNV	4125	Eclair	Pastries	5	146.12	2025-08-08 01:53:37	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	elena.torres2	2025-08-08 01:53:37
a6535b8a-fdae-44ba-acd8-0cb73fdcae4b	Ocq5a9wvnFKI81K2w4Vs	4127	Baguette	Pastries	1	133.77	2025-02-01 08:12:17	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.bautista5	2025-02-01 08:12:17
f30d89c0-9f3d-4b8b-a2f2-fa42b8d0cc2c	ZJxLO60Xqk7MW5HkyUus	4128	Mocha	Pastries	3	61.74	2025-10-10 18:53:50	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.reyes9	2025-10-10 18:53:50
d30a6d0d-5495-4568-bf7b-9e82ddbf1ffe	RKMKU4W294kefFBxiVyR	4130	Red Velvet Cake	Pastries	3	187.25	2025-02-09 03:59:31	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.delacruz	2025-02-09 03:59:31
129ec1bd-1acb-4be2-9848-3facc587b70d	642ZW42YTQ5NIK8wxHcE	4133	Hot Chocolate	Pastries	2	131.53	2025-02-19 06:33:24	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	pedro.cruz14	2025-02-19 06:33:24
601d5795-7473-49da-8b3f-cf9c9403ebb6	J6c64PHTsfME2QclBqJD	4145	Blueberry Muffin	Pastries	2	185.15	2024-12-16 15:29:47	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	pedro.cruz14	2024-12-16 15:29:47
3dc7ef49-5862-426f-9d04-cc6216e757ef	o4p89hHU2TIkVkrdD2g4	4146	Mocha	Pastries	5	61.74	2025-03-10 13:21:42	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905009611	pedro.cruz14	2025-03-10 13:21:42
0add13fe-aebe-452f-8440-1e895f200d95	Z0H6W8Vg4O5ZpQj1wQ6L	4149	Latte	Pastries	2	108.74	2025-02-07 21:26:49	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905481461	carlos.cruz12	2025-02-07 21:26:49
7f7e0455-5ad4-4314-a2cf-92a108c67091	2lG6aXt7IBTWpk0nydBB	4150	Almond Croissant	Pastries	1	8.42	2025-08-16 17:53:22	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	pedro.cruz14	2025-08-16 17:53:22
d3587c89-706a-4ca0-8750-3c1a6453d2c6	5nrQPU1AGXq0uIpB8AI7	4151	Chocolate Chip Muffin	Pastries	2	103.79	2025-01-19 10:26:19	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	fernando.cruz	2025-01-19 10:26:19
ce2993da-2fc0-405c-b6aa-616b5b88cff8	lL3BWf4yhUf6eTOu6P6s	4156	Red Velvet Cake	Pastries	4	187.25	2025-06-27 13:51:41	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	isabella.delacruz4	2025-06-27 13:51:41
397bf555-16ae-4880-821f-37a5082a7177	IhDux46KflgHCTF6AeM0	4162	Eclair	Pastries	3	146.12	2025-09-12 08:48:06	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905489692	carlos.mendoza	2025-09-12 08:48:06
fb8e69f1-c9ac-4e60-b302-7c2a72f83e8c	i4irzTNmcs6GDqDfVC4S	4163	Latte	Pastries	1	108.74	2025-10-24 15:23:16	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.santos8	2025-10-24 15:23:16
56a222b7-6fd5-4358-b3f3-65818367ad2c	Q0jww8rvG5THL7WWFrMh	4164	Tea	Beverages	4	106.18	2025-05-17 07:40:02	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905593667	gabriela.mendoza	2025-05-17 07:40:02
febac993-f884-4566-9f72-463ad9813fc8	3sNwfhPuB512iMs4Evc2	4165	Espresso	Pastries	3	195.76	2024-12-27 04:46:06	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.cruz13	2024-12-27 04:46:06
34511728-5c1f-43fa-a870-f25f0e78b371	2H2d55qZlKEEo0jzVEXj	4168	Mocha	Pastries	2	61.74	2025-08-29 01:11:10	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	elena.fernandez11	2025-08-29 01:11:10
edc6f47e-05f8-47d7-8b1f-5fcb253395b8	IfVNmDH3MYQlU4fwUWVI	4170	Cappuccino	Pastries	5	76.25	2025-08-12 11:38:04	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905255942	carlos.delacruz	2025-08-12 11:38:04
2951ddb8-1ad1-4111-babf-4e69935c33c6	T4atzH0Ke4KPdY8UBIEd	4176	Mocha	Pastries	5	61.74	2025-08-18 15:42:25	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	antonio.santos6	2025-08-18 15:42:25
2abcafe3-8103-4a11-ab35-08dac6a93b6f	JP1T06pNFeelQZT4OEAI	4177	Cappuccino	Pastries	3	76.25	2025-07-23 05:25:50	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905008892	carlos.delacruz	2025-07-23 05:25:50
9b562659-f3c4-47b1-a9dd-8297396c2730	glYMKHCfXMXqthZ4GzFg	4181	Iced Coffee	Beverages	3	107.80	2025-11-13 03:07:19	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.santos8	2025-11-13 03:07:19
4385f80a-3de2-4a3d-b1f7-8b7db5285429	RUveMaqD0LF29ZGQW5CM	4183	Blueberry Muffin	Pastries	1	185.15	2025-11-13 05:19:35	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905546198	miguel.cruz15	2025-11-13 05:19:35
e9ba1545-43c9-4e03-bf02-03ebc11e35ad	hVpQrV3MUzfOKhHLQHbR	4184	Latte	Pastries	2	108.74	2025-05-16 12:00:16	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	pedro.cruz14	2025-05-16 12:00:16
f5c9646e-89e3-4d0a-b218-1721206cb8f2	ooojO4eUvuIsoZ5m1CSY	4187	Baguette	Pastries	3	133.77	2025-03-21 02:15:41	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.cruz12	2025-03-21 02:15:41
03cbe3a3-df95-4417-a8cf-b5f4bac5d3e3	jmptvcXBy2hkRrQ8rgv0	4192	Almonds	Pastries	1	5.59	2025-03-20 07:14:08	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	fernando.cruz	2025-03-20 07:14:08
e04951fa-40f3-4e2f-be20-8f5673df6541	SX8FdwJLOmQ6TWJdoG7v	4194	Chocolate Chip Muffin	Pastries	5	103.79	2025-03-02 02:44:35	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905155012	carlos.cruz12	2025-03-02 02:44:35
9b640aeb-fde1-47f8-84a6-8e19bbcd2aaa	hUklKKAFNfEdzwAnHzxr	4195	Chocolate Chip Muffin	Pastries	5	103.79	2025-01-30 18:27:57	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	sofia.bautista5	2025-01-30 18:27:57
64e00a2e-9a89-4b7c-aa06-a77aaecf960b	VuompAKN9HQv99uXwIAg	4196	Blueberry Muffin	Pastries	4	185.15	2025-02-18 07:23:31	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905433789	fernando.cruz	2025-02-18 07:23:31
49f391ed-2d78-4e5c-8d93-ca3fec9e6efd	2bfeeZoDQKlrZrAvTEtV	4199	Glazed Donut	Pastries	2	148.75	2025-07-19 15:05:02	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	gabriela.mendoza	2025-07-19 15:05:02
5d0d2b1b-fc41-4a16-9361-79343cd4eec8	tO14AYbE9GBAnuS2XgY3	4200	Almond Croissant	Pastries	4	8.42	2025-05-08 03:46:38	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2025-05-08 03:46:38
f4d84366-8876-4fbc-8ef8-1200272fcc48	cQoCjyWUbv68sUfJvqIJ	4201	Flat White	Pastries	4	113.21	2025-04-29 01:46:48	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905204281	isabella.delacruz4	2025-04-29 01:46:48
71486fa2-56db-434c-ae22-ee85ce51b791	4XGiIqGp2eLWtbmyGLZB	4202	Flat White	Pastries	5	113.21	2025-05-20 07:29:41	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	antonio.delacruz10	2025-05-20 07:29:41
4a8d03d7-3c22-40ef-9010-fb42e03b94a0	wIDc1166jU241BLlf2aL	4203	Latte	Pastries	1	108.74	2025-05-27 00:37:48	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905827798	sofia.bautista5	2025-05-27 00:37:48
72f19d67-d482-43b4-943e-2d0e68c24e9a	7ogVQ466xhb7kmgVzJ5t	4207	Baguette	Pastries	4	133.77	2025-04-25 12:29:35	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	rosa.cruz13	2025-04-25 12:29:35
a0b063c3-12d7-43c3-9905-0b8762d0e454	0gQxWUgEPxSaALkxDLTR	4211	Tea	Beverages	4	106.18	2025-02-15 05:38:10	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	fernando.cruz	2025-02-15 05:38:10
b86f6a40-e553-44ac-ae03-12f2900bdb88	cAXgV3LwIAWs9bJyz1Eb	4213	Macchiato	Pastries	1	93.97	2025-08-16 00:06:18	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	isabella.delacruz4	2025-08-16 00:06:18
aefbb7c1-3286-465e-88f9-750db81ba96d	Kp6ejhVHFAjQCETfFFjX	4215	Glazed Donut	Pastries	5	148.75	2025-06-25 20:56:07	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905466711	fernando.cruz	2025-06-25 20:56:07
50841df6-d97d-484b-aaf7-65a6584acf6b	VyXjZCpqbIP2f0sLS8xV	4216	Hot Chocolate	Pastries	3	131.53	2025-11-18 09:10:42	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carmen.santos1	2025-11-18 09:10:42
447b3f3d-f8b5-42f8-8fba-16289c19b70d	HtZugqp3sfFxBTjUFoGk	4218	Mocha	Pastries	2	61.74	2025-01-19 11:05:23	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.cruz	2025-01-19 11:05:23
3282dfb5-beee-4c06-a4cb-7f51de323393	ZtI7xWLACvkUTRx1qMya	4219	Baguette	Pastries	4	133.77	2025-04-14 06:08:46	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.torres2	2025-04-14 06:08:46
470f7192-8d6f-4278-9a04-6962c3861212	a3eY4b8n4RNalcmfjazS	4220	Red Velvet Cake	Pastries	1	187.25	2025-01-13 10:31:57	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905464881	admin	2025-01-13 10:31:57
e610ea21-b4da-4dbf-bd15-4d3b6e184ec5	9za03lNT0c7kY53210ra	4221	Flat White	Pastries	2	113.21	2025-01-10 08:24:50	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	rosa.cruz13	2025-01-10 08:24:50
ea2cdd9a-0938-47d1-808c-47553cc1f683	pFXjPWbrjkQ9izBOQcXH	4226	Latte	Pastries	3	108.74	2025-04-16 06:31:16	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	carmen.santos1	2025-04-16 06:31:16
b89b97b2-3152-4c52-9eca-f091a8362438	HVqE0IzDQj0kg4teOq0w	4228	Mocha	Pastries	4	61.74	2025-06-04 18:11:00	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905346669	carmen.santos1	2025-06-04 18:11:00
05d9415e-2c1e-473e-835d-d478ecb9f643	t8ab8gHdWqDt3JnFJC0J	4230	Iced Mocha	Pastries	4	144.00	2025-09-19 03:20:14	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.cruz12	2025-09-19 03:20:14
adb85325-7e2b-45ad-bb51-8c17a7077387	YRdya4TyQq8w1cp6vWye	4231	Macchiato	Pastries	4	93.97	2025-04-28 14:59:51	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.cruz12	2025-04-28 14:59:51
876878d8-cfee-4214-9a9b-422c21d6213a	W6Ady9YYLIRKp9PnCVLs	4232	Almond Croissant	Pastries	2	8.42	2024-12-01 11:18:40	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.delacruz10	2024-12-01 11:18:40
3b72c767-53b3-48b9-9ecf-796338efe703	UwqVx4e6nUOU1nquGcAy	4237	Tea	Beverages	4	106.18	2025-05-06 15:39:23	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.mendoza	2025-05-06 15:39:23
b045fcb4-d0a0-4a7b-8500-12484d232e3c	pq6jUqinV16W7l3pUG94	4238	Mocha	Pastries	1	61.74	2024-12-08 04:29:36	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	gabriela.mendoza	2024-12-08 04:29:36
78c483ed-f183-4998-8344-42b32ba9038f	5tsGwu81wqFDhAaU3uqG	4242	Apple Turnover	Pastries	1	154.54	2025-03-17 09:11:11	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.torres2	2025-03-17 09:11:11
2ab43127-4f18-4d87-b8e6-8839209f569a	ojJLwKtjQyUkHBi2lgJK	4243	Latte	Pastries	3	108.74	2025-04-05 12:41:58	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.delacruz	2025-04-05 12:41:58
97c7b91f-3cb8-4946-8b86-a71181f30749	\N	\N	Almonds Croissant	Pastries	1	179.86	2025-11-26 22:01:34.051564	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2025-11-26 22:01:34.051564
d4f83d75-f76c-44e6-bcd3-eaebbf0fe4b8	AaYQYydQTBEVbRPqtUq0	4244	Apple Turnover	Pastries	3	154.54	2025-10-02 05:22:24	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	admin	2025-10-02 05:22:24
cb368aa5-44a0-4b50-9e85-8f2838c13c23	di8XsSKJPlhxWJ0wudKx	4246	Cappuccino	Pastries	1	76.25	2025-02-19 09:18:01	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.torres2	2025-02-19 09:18:01
2a31014f-1b35-4ec5-a64a-bccdb195211c	nvMD6bxTfoLOH1H8mFcS	4251	Baguette	Pastries	1	133.77	2025-07-17 23:10:13	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.reyes9	2025-07-17 23:10:13
074ec75a-1a79-4ef7-a38d-ee384ed8932d	6XeuTEuSQuNuJU06wzWe	4252	Eclair	Pastries	3	146.12	2024-11-27 12:07:55	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905707896	carlos.cruz12	2024-11-27 12:07:55
12f84e1d-b215-46d7-8b65-d28eddc1e112	mzOvwY0QMirLITtHD5zN	4257	Latte	Pastries	4	108.74	2025-09-26 05:26:56	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	gabriela.mendoza	2025-09-26 05:26:56
9ce318f8-5e9c-4e65-ac43-f659b1967aea	lzKAekmKzYts3oNLXo0K	4258	Chai Latte	Pastries	4	100.50	2025-06-06 15:30:11	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	pedro.cruz14	2025-06-06 15:30:11
d6136f1c-6130-47d9-933a-bacb16150df1	6DQaTl0lspEUJwqVnMcs	4260	Latte	Pastries	3	108.74	2025-01-27 00:46:26	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	carmen.santos1	2025-01-27 00:46:26
ce7fa0d5-339b-41cf-b24c-28eba84e05b7	grvkRfgQk8XGxCFDv08X	4261	Flat White	Pastries	3	113.21	2025-04-26 18:55:32	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905940215	pedro.cruz14	2025-04-26 18:55:32
56522857-f96e-4f20-b065-4f26f0b002a9	RBUFBfjkvZPEEfE2eOX5	4272	Blueberry Muffin	Pastries	4	185.15	2025-07-10 20:17:50	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905603802	admin	2025-07-10 20:17:50
65ce2b46-fbd6-4ada-a0bf-042d91421727	QrcqOLSXh5QoY7jLlUCl	4276	Flat White	Pastries	4	113.21	2025-04-18 16:43:12	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.mendoza	2025-04-18 16:43:12
5aff82dc-d72f-4d8b-87d2-19476d59baa7	ZmneofsbFL7jwsibWamG	4278	Tiramisu	Pastries	3	196.55	2025-08-11 08:58:41	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	pedro.cruz14	2025-08-11 08:58:41
8e798c35-80f5-4025-863e-82e8e3a5a00b	96xt8lxr3AI3BnOazFU5	4280	Red Velvet Cake	Pastries	3	187.25	2025-01-24 14:44:01	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	admin	2025-01-24 14:44:01
cafaf017-6992-4e7b-ae6c-8c6ac9522993	ps2QFW3mdgtHJ1o95q8U	4281	Apple Turnover	Pastries	5	154.54	2025-07-15 21:47:25	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	sofia.reyes9	2025-07-15 21:47:25
0e52718a-9371-433a-abb9-a1c34fa29b9e	OalurBMSpNh0gC0oFiBk	4282	Iced Mocha	Pastries	3	144.00	2025-10-13 02:22:23	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905109873	carmen.santos1	2025-10-13 02:22:23
fa72de75-af6e-475d-984e-10f46a3600ea	5cqU5lcl3PSM90k59S9x	4283	Chocolate Chip Muffin	Pastries	5	103.79	2025-01-17 17:07:57	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905799401	gabriela.mendoza	2025-01-17 17:07:57
e715d609-8775-4ba3-b4a7-a7f7056b6304	0oaogJZuGZD48abPsk9i	4287	Blueberry Muffin	Pastries	5	185.15	2025-09-12 18:51:32	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905596715	antonio.delacruz10	2025-09-12 18:51:32
7832bb44-1a85-4de0-b886-82923cb6d4aa	BK3ghAzNFyVejAdE2djG	4289	Red Velvet Cake	Pastries	1	187.25	2025-11-19 07:04:07	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.fernandez11	2025-11-19 07:04:07
1d4286e9-9bae-43a8-896e-b0e56f722335	ApOFJr9ffPme0AV9ZaVR	4290	Almond Croissant	Pastries	5	8.42	2025-09-25 03:17:27	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2025-09-25 03:17:27
461e37fe-ffdd-4d4b-af2d-1f1120732af3	8s63Xk5V3Jbz6AyUWGkp	4292	Almonds	Pastries	4	5.59	2025-07-17 22:02:55	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	antonio.delacruz10	2025-07-17 22:02:55
f25ac194-3ee0-4141-bf55-91e4851c6976	slOHwMxLSCYxRtIehdlN	4295	Tiramisu	Pastries	5	196.55	2025-05-22 06:55:21	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.delacruz10	2025-05-22 06:55:21
a7328267-0aea-49f4-9d0f-6dc397031682	3K96PHN6F9AxfncG3pQO	4297	Baguette	Pastries	3	133.77	2025-02-14 16:42:10	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carmen.santos1	2025-02-14 16:42:10
c9f01ec6-7a91-41d0-a58e-2af9f69dd332	wr0bqcxF48ivTfkArLm0	4299	Tiramisu	Pastries	4	196.55	2025-04-26 13:01:31	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carmen.santos1	2025-04-26 13:01:31
4352b964-1bc3-459d-aa29-5f6117842cb5	n0Ggmq2gQHwW5K1rLix3	4304	Baguette	Pastries	1	133.77	2024-12-08 13:45:20	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	pedro.cruz14	2024-12-08 13:45:20
81a21e82-6d35-4c1e-bfb8-560250e05e16	QlWVZf2CeataBgmj58w7	4311	Blueberry Muffin	Pastries	4	185.15	2025-09-26 21:04:19	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	rosa.cruz13	2025-09-26 21:04:19
5ace679e-4928-42d7-888e-b78dbc6964dc	dlfioOXGqUIc252iNEqs	4312	Mocha	Pastries	2	61.74	2025-09-19 22:11:05	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carmen.santos1	2025-09-19 22:11:05
d32c4a92-d305-4d39-850e-f99b44430bab	QhdkbXPNFvo6hoWr1aD2	4320	Tea	Beverages	4	106.18	2025-02-07 08:28:58	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	miguel.cruz15	2025-02-07 08:28:58
63df0b74-c17e-42e1-9c10-bce56e925de0	T4c3qfscPFTQXF0jk94k	4324	Espresso	Pastries	4	195.76	2024-11-25 18:39:16	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	fernando.cruz	2024-11-25 18:39:16
b48718bd-e557-4543-98e3-babcf031f91c	sH6DSOSPTBISY3xzyQ3E	4325	Latte	Pastries	4	108.74	2025-03-08 17:02:22	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905941374	fernando.santos8	2025-03-08 17:02:22
e6f200ec-7002-4367-8058-3fc48a8d5cac	JMHQrmeo2b7Gny4YIggp	4326	Iced Mocha	Pastries	2	144.00	2025-11-15 18:26:27	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	elena.torres2	2025-11-15 18:26:27
ff3d570c-3be5-45dd-a825-6356353db2d5	u3eYajl9WiKFixlSVbYu	4332	Blueberry Muffin	Pastries	2	185.15	2025-02-09 03:48:29	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	fernando.santos8	2025-02-09 03:48:29
279c0a44-786b-4291-9185-3ab8bc511a60	cI95YiLsN2dag2EyCxAP	4337	Latte	Pastries	4	108.74	2025-08-13 06:10:05	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905228702	miguel.cruz15	2025-08-13 06:10:05
fcd60c74-955f-4728-83ba-317248bbdcb4	20ddXQil8w7gu4GW2eRx	4339	Espresso	Pastries	3	195.76	2025-07-20 19:07:47	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905363861	carmen.santos1	2025-07-20 19:07:47
6857ec89-8dba-4bfa-9771-57998203108b	Df8oYG5b2eUCIIpy1DVR	4347	Baguette	Pastries	1	133.77	2024-12-01 23:32:00	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905031250	rosa.cruz13	2024-12-01 23:32:00
27d9f635-6f6c-429e-8f85-0d8c80dc8913	IOShi9ibA21eX8KSP3OE	4348	Tiramisu	Pastries	5	196.55	2025-11-07 12:08:14	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	gabriela.mendoza	2025-11-07 12:08:14
3b19872b-b002-472e-b0c1-61678a1577a2	kBPy77oqFdti8OZ8q7sr	4350	Cappuccino	Pastries	1	76.25	2025-08-06 19:58:45	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.mendoza	2025-08-06 19:58:45
b933c406-b8e6-4d0e-a145-31579b49560a	rF8KqWB6zFWju5ql7v7w	4363	Macchiato	Pastries	2	93.97	2025-09-21 17:59:33	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	carlos.cruz12	2025-09-21 17:59:33
c561f34d-3bb6-449a-9a5b-352133472fd5	iPVI5uVhQjIhbQRARlSd	4367	Iced Mocha	Pastries	3	144.00	2025-05-19 10:54:06	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905153492	rosa.cruz13	2025-05-19 10:54:06
5aebc74e-b3fc-4ed4-b5b9-c9afd980a273	FGXXC2Um6s46D9qgK5kX	4368	Chai Latte	Pastries	4	100.50	2025-05-08 22:48:23	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905862570	fernando.cruz	2025-05-08 22:48:23
2518530e-9d0a-4cc0-a257-cd97147f9b31	TD5okRPkO5hB8LfMHYYz	4373	Baguette	Pastries	2	133.77	2025-09-14 10:28:47	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	antonio.santos6	2025-09-14 10:28:47
63d7bf7e-a589-48a0-ba0c-67edc0fe2fc3	CrbKvXhbXCBtETPjivR1	4377	Americano	Pastries	3	80.96	2025-06-07 14:55:47	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905141851	antonio.santos6	2025-06-07 14:55:47
584f1677-7a01-4043-a3bd-d04f0eff63b7	tk9B32TYwJMYKUeyWJYH	4379	Blueberry Muffin	Pastries	1	185.15	2025-10-21 05:15:47	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	sofia.bautista5	2025-10-21 05:15:47
a18f6a29-1fcd-4f66-b581-196bad3275f9	THgBlLUIm8WATzbWtzeO	4380	Baguette	Pastries	3	133.77	2025-07-27 03:29:51	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carmen.santos1	2025-07-27 03:29:51
7c5f896b-6716-4b8e-a10e-2880b51886ed	0DI0If2ezorpczlClkLA	4383	Hot Chocolate	Pastries	3	131.53	2025-10-11 13:43:41	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	sofia.bautista5	2025-10-11 13:43:41
60c04b2e-35c7-4fbc-87ce-ecc465d66779	vYJJ2Vfg9HCzLMD7RJbR	4386	Cappuccino	Pastries	1	76.25	2025-08-09 11:00:14	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	pedro.cruz14	2025-08-09 11:00:14
1dba39fb-9ad7-400c-9140-553be26bafea	jok3ZDOmzfvuShyrUuA9	4388	Latte	Pastries	1	108.74	2024-11-29 23:55:20	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.cruz13	2024-11-29 23:55:20
507db967-368a-4fda-9f75-662c2a489821	0dMc7Fndb6zbhIp1nwt9	4390	Baguette	Pastries	5	133.77	2025-10-03 16:37:05	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	admin	2025-10-03 16:37:05
526ddf0b-dd3f-42fb-a898-052d5289c993	lO1hYU7ZjJywULSm9ddR	4392	Macchiato	Pastries	1	93.97	2025-07-16 22:12:24	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	isabella.delacruz4	2025-07-16 22:12:24
abc12a42-2b8a-4f95-adc4-f4eb1f4b5632	GL1Maf8d6KcCOIGQ5Uay	4393	Blueberry Muffin	Pastries	5	185.15	2025-07-04 00:38:20	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905671371	elena.torres2	2025-07-04 00:38:20
17774864-ac11-426c-b4f6-9b2e56cbb2f5	nBkLakD63YBy7wgBUGUz	4396	Flat White	Pastries	4	113.21	2025-05-25 12:42:17	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905305378	isabella.delacruz4	2025-05-25 12:42:17
acc9686b-a669-4a9c-a080-d6c3fb4fe8c9	ZqjZwhovxRnqjAXt0ZVQ	4397	Flat White	Pastries	3	113.21	2025-05-02 08:29:27	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carmen.santos1	2025-05-02 08:29:27
44476295-714c-4f09-93f2-24e368b5e85a	F8Nb9uDiyDwrqhClyA0A	4400	Apple Turnover	Pastries	2	154.54	2025-03-05 04:32:47	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.santos6	2025-03-05 04:32:47
bf147fd6-2a57-4e0e-8a96-1c92b0174c6f	RGJW6mlDMOdii37W7gFl	4401	Almonds	Pastries	3	5.59	2025-02-23 14:56:37	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.delacruz	2025-02-23 14:56:37
aff86f56-46cf-4bb7-8c52-26e3fdd22300	1TeaCJ7wQVcXTZIqFrRL	4409	Glazed Donut	Pastries	4	148.75	2025-04-29 21:46:48	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.reyes9	2025-04-29 21:46:48
c7448581-2e8f-44d0-a139-48392db3f2dd	YQpoIbAIBjoKLqF7iewx	4410	Red Velvet Cake	Pastries	5	187.25	2025-05-28 05:15:19	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	rosa.rivera7	2025-05-28 05:15:19
4b7323f9-1b1d-4520-a554-9d944e95817c	iSe84BdNdCCRQmouT33M	4414	Red Velvet Cake	Pastries	1	187.25	2025-02-27 16:41:54	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905309562	sofia.reyes9	2025-02-27 16:41:54
e2b4ee86-9359-4b23-8d41-224816bb48e8	hT6XLYMwXXhQSr5LOZDJ	4415	Red Velvet Cake	Pastries	4	187.25	2025-08-11 18:49:21	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905263814	sofia.bautista5	2025-08-11 18:49:21
f182d989-9221-4b5f-9007-19e70435532f	oitfmW808DnfR85xylEV	4417	Glazed Donut	Pastries	4	148.75	2025-03-15 05:56:41	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	admin	2025-03-15 05:56:41
2f48f41c-a375-4718-bd69-6a0dbfc1bf57	Edt4PX2vtx1vUCpSBihc	4419	Tiramisu	Pastries	3	196.55	2025-07-22 03:51:09	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carmen.santos1	2025-07-22 03:51:09
cd1c5170-ca19-4e99-92f7-167ef2124e96	mW93gfqaR6N0TmrsYRzw	4420	Baguette	Pastries	4	133.77	2024-12-01 00:36:12	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	pedro.cruz14	2024-12-01 00:36:12
c8f65c8a-5e73-4f47-baa8-f2a71b22a297	sVWh85jfiVwdQgDn0X27	4421	Chai Latte	Pastries	2	100.50	2025-09-03 21:37:29	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	ana.rivera3	2025-09-03 21:37:29
7eb26bf5-86f2-4444-aee9-871eefeb046b	ffUZlODkHTTuLyQIvtDV	4422	Macchiato	Pastries	3	93.97	2025-06-13 08:34:27	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.cruz12	2025-06-13 08:34:27
fd5a9909-f39e-4cdd-b712-230d86632ae5	4jydQWRchxZI2LFXyx0A	4430	Espresso	Pastries	5	195.76	2024-11-25 03:38:13	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	elena.torres2	2024-11-25 03:38:13
bcefe5ce-a8d2-4931-a0db-aa47d507418e	eezR09mIFAdc5xZeFDky	4431	Chocolate Chip Muffin	Pastries	4	103.79	2025-03-12 20:31:37	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	miguel.cruz15	2025-03-12 20:31:37
4df5437c-e6c8-4904-98e8-88b9f8baeaef	2MjigKomKWfN8F2VJwju	4438	Espresso	Pastries	2	195.76	2025-04-26 08:54:06	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	miguel.cruz15	2025-04-26 08:54:06
cd91020a-d0f3-4536-aa09-0d678d90f130	7V4NDZa1qVSMTlwEmDj3	4441	Cappuccino	Pastries	1	76.25	2025-09-05 23:24:24	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	elena.torres2	2025-09-05 23:24:24
ac14cefc-a5bd-45bc-9774-5da234cdefd7	ORTfHU18pr07iAW9wddm	4448	Mocha	Pastries	5	61.74	2025-11-14 03:28:24	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	ana.rivera3	2025-11-14 03:28:24
09c02b44-8266-402f-8c8f-a32575f581e5	rCNdOi52ZWi1YQSsKHGH	4452	Americano	Pastries	1	80.96	2025-01-02 10:13:18	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905655538	gabriela.mendoza	2025-01-02 10:13:18
baae7c83-f068-4fda-b701-ae3203097bb9	ZI4u9Qt7Qx5hT1onyfoo	4453	Apple Turnover	Pastries	2	154.54	2024-11-28 06:14:36	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905412099	sofia.reyes9	2024-11-28 06:14:36
83c7791e-5869-43b5-a195-81d4a073b5ae	ogu647gY3qSR1lP6uTg0	4457	Apple Turnover	Pastries	2	154.54	2025-11-08 09:17:40	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905556918	ana.rivera3	2025-11-08 09:17:40
9c72951a-8105-488c-a616-f6215ce1b032	3j6vTJo6TxY0kQ7zpUGM	4461	Hot Chocolate	Pastries	3	131.53	2025-06-17 00:49:27	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	fernando.cruz	2025-06-17 00:49:27
ed4ba76b-4124-432b-aa79-af44784542b6	77nz9Ddm8IAhJhxMA8o6	4473	Tea	Beverages	1	106.18	2024-12-25 10:20:08	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	sofia.bautista5	2024-12-25 10:20:08
2c115357-bd27-4398-a857-0d55c759ed0a	bTclPWX5DBju0zsIs4Jh	4479	Almonds	Pastries	3	5.59	2025-04-11 17:38:53	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carmen.santos1	2025-04-11 17:38:53
8330a546-a06b-4ff5-af44-83bea45e60b7	rAqunfsX4tCTyeJIL2ZX	4481	Almond Croissant	Pastries	3	8.42	2025-08-09 23:15:21	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905870998	carmen.santos1	2025-08-09 23:15:21
af7cc4c1-02ee-4603-a2bd-50cd2360804c	1EOiZtHx8kQpwpIccvFt	4482	Hot Chocolate	Pastries	3	131.53	2025-04-08 03:30:37	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	miguel.cruz15	2025-04-08 03:30:37
1de5aa42-6861-4496-9393-0d2f6148b14d	BqS6G7kPvBhiRI5DXxyg	4484	Flat White	Pastries	1	113.21	2025-06-24 22:09:52	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905729176	gabriela.mendoza	2025-06-24 22:09:52
fbb050f1-1e69-4fe8-9528-637cd85e8e23	iUo0mTPlMfjO08DhCY2l	4485	Cappuccino	Pastries	2	76.25	2025-03-27 07:38:09	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.cruz12	2025-03-27 07:38:09
5c89c948-babd-4d0b-b33c-106f14a03101	oHttnapcePLhOMSQMUCX	4488	Mocha	Pastries	4	61.74	2025-04-11 18:41:31	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905062828	fernando.santos8	2025-04-11 18:41:31
1069fab9-784c-4aa2-bf9c-0c9ec2257087	vbrCd82g0RLpDmRv7Bd8	4490	Apple Turnover	Pastries	4	154.54	2025-05-20 10:12:50	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905126566	isabella.delacruz4	2025-05-20 10:12:50
e47b6e1a-9e9b-46b1-b914-f2730dbc690f	yfSNfoPdrAmv9EJXyDuv	4495	Chocolate Chip Muffin	Pastries	5	103.79	2025-03-20 16:18:25	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.mendoza	2025-03-20 16:18:25
5b197635-c641-4b77-8a2f-ca85b597deb3	lcH8t2N6oX308S9XEHgx	4497	Hot Chocolate	Pastries	4	131.53	2025-09-15 18:39:41	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905686729	antonio.santos6	2025-09-15 18:39:41
ce50de05-d0bc-4f9e-a8e0-fa71bc159a33	iNLk9t2Fkjrunos3Yazd	4499	Red Velvet Cake	Pastries	4	187.25	2025-09-13 06:00:01	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905373014	antonio.santos6	2025-09-13 06:00:01
fa5f9803-1080-4133-9d02-04c850353256	N3acicTPOHBxZXEANnUI	4503	Iced Coffee	Beverages	5	107.80	2025-06-30 18:05:44	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	ana.rivera3	2025-06-30 18:05:44
ca33a6df-03ba-4d6c-8599-d5847bc9c23a	ODkHrlNJFr3C4085rlIF	4509	Blueberry Muffin	Pastries	3	185.15	2025-03-02 06:25:15	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	admin	2025-03-02 06:25:15
1cff8ee5-9c05-4050-a349-8f45fcdc8b1f	MAI1eNwI9CChyxets2Vs	4515	Eclair	Pastries	3	146.12	2024-12-27 14:43:10	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	isabella.delacruz4	2024-12-27 14:43:10
d0f77629-db00-41e6-b0af-4eb0e9028a64	xG0vq60UaZOAABM3NlC6	4517	Eclair	Pastries	1	146.12	2025-08-04 07:03:49	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	carmen.santos1	2025-08-04 07:03:49
3da68285-5c9d-443a-9d05-ec7c55e2d3c1	YXbBY352JKpvTMP5Wrgc	4534	Iced Coffee	Beverages	2	107.80	2025-01-16 20:31:55	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.reyes9	2025-01-16 20:31:55
812435a1-98d2-425c-9b14-52a77966d91e	fK6LgixbUG1K1cG5uU5b	4535	Tea	Beverages	1	106.18	2025-01-19 18:06:24	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	fernando.cruz	2025-01-19 18:06:24
0a835e82-f9dc-4c96-a64e-f9672765d0c4	uHkwUB1PPFVJiJT9JYSl	4536	Tiramisu	Pastries	3	196.55	2025-04-20 09:57:03	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	miguel.cruz15	2025-04-20 09:57:03
710c98b1-d8e6-49be-aa26-c9e793d7b1f7	iBF414yjY5llwbjVBLkL	4537	Tiramisu	Pastries	3	196.55	2025-06-12 15:09:06	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.fernandez11	2025-06-12 15:09:06
773a0a55-e51f-48ff-82f4-b0f0eedd1622	zG1xuH25oaxyWS4hUK7m	4540	Iced Coffee	Beverages	4	107.80	2025-09-28 11:33:26	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.cruz	2025-09-28 11:33:26
230a575d-6170-403e-8a61-fa794ad896f3	tKu2VeciTip188dkjYtV	4541	Tea	Beverages	5	106.18	2025-11-06 23:10:56	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905199548	carlos.delacruz	2025-11-06 23:10:56
86dafd1b-1e45-48a0-8bf4-d6a9bc9262ea	0M8TJ9vwlgrFy6dHMx3J	4546	Americano	Pastries	4	80.96	2025-11-19 20:51:22	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	ana.rivera3	2025-11-19 20:51:22
e953d3eb-7081-443f-8efd-63d5f53901f6	N7qodtCQzrgEdcGqBV7c	4547	Americano	Pastries	2	80.96	2025-11-10 11:13:45	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	isabella.delacruz4	2025-11-10 11:13:45
8263fcec-a851-4d25-9681-edfaf55ca9a6	HfYXzuGapuoRVyY98uO5	4548	Latte	Pastries	2	108.74	2025-03-25 06:23:54	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.santos8	2025-03-25 06:23:54
0e1ff8ef-fdae-4587-9b48-d5f832b2a46a	vf93QlE1HLFSNnwBGygq	4554	Cappuccino	Pastries	5	76.25	2025-02-09 11:15:24	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.fernandez11	2025-02-09 11:15:24
48dd166b-6dc5-4942-9389-3b79e381ac00	qhc27LnyCpTKezQbfrph	4555	Chai Latte	Pastries	5	100.50	2025-03-23 21:08:27	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.reyes9	2025-03-23 21:08:27
8a49a7c9-a8bb-4181-bc8e-1aef9a29e123	cCUyFWsAfSXrDprUGKJm	4558	Cappuccino	Pastries	4	76.25	2025-06-26 03:07:28	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.santos6	2025-06-26 03:07:28
82f5b983-36b8-4490-8662-77356fb6f81f	RWnvSRmB8oWbNtPoUYse	4563	Tea	Beverages	5	106.18	2025-08-15 21:01:36	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	fernando.santos8	2025-08-15 21:01:36
ac234bb2-7978-46aa-9a11-1a062c6f341c	5Ic1uNlbm1moNUiX9AQQ	4565	Eclair	Pastries	3	146.12	2024-11-26 05:13:07	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	sofia.reyes9	2024-11-26 05:13:07
f9ea679b-6bcd-403d-92e4-142e5e861407	jhbZ9ZOjqXkEpKdEpRhb	4566	Almond Croissant	Pastries	5	8.42	2025-03-22 09:50:16	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	miguel.cruz15	2025-03-22 09:50:16
807c1012-3096-4cf2-b245-728bbda1cf92	HTyDJCcLitik1kuRWckf	4571	Chai Latte	Pastries	3	100.50	2025-01-27 03:01:05	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	gabriela.mendoza	2025-01-27 03:01:05
3f1a91d6-406c-4fcc-b847-9e9e3a87cb3b	JKUdccnkkmx00tL5sZ4P	4573	Red Velvet Cake	Pastries	3	187.25	2025-03-30 13:36:45	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905485997	pedro.cruz14	2025-03-30 13:36:45
dfc2d1ff-348d-45bf-a089-a95e5df310fe	2MJtC3Gub1utobj7smo4	4574	Latte	Pastries	2	108.74	2025-08-03 20:26:01	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	admin	2025-08-03 20:26:01
66cd476a-d433-436e-a8c5-2ec66e805409	N8IWjjFKp6vtndYKSdlM	4575	Espresso	Pastries	3	195.76	2025-03-17 14:24:25	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.rivera7	2025-03-17 14:24:25
8a872ff3-afe7-46f3-bbeb-aafb6753f53e	pfDAZpzvZVpQIJlb8jzR	4578	Almonds	Pastries	4	5.59	2025-02-07 13:03:33	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905610887	fernando.santos8	2025-02-07 13:03:33
b2517714-334f-422c-b677-69aa3840aacc	Mf8mJTFjbuW6hlEErq6k	4579	Glazed Donut	Pastries	4	148.75	2025-04-01 23:56:19	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905844741	sofia.bautista5	2025-04-01 23:56:19
a2472998-8a5c-4eb7-ad41-6f7c0d55c126	ECTkuXsxr4LO5WTC3w2j	4580	Macchiato	Pastries	5	93.97	2025-11-16 05:47:35	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.delacruz	2025-11-16 05:47:35
55d96fcd-0831-4139-8735-00032a4bd1a2	SifDYLdvaBjLdpJVAIc7	4585	Hot Chocolate	Pastries	4	131.53	2025-10-27 05:57:08	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	antonio.delacruz10	2025-10-27 05:57:08
c3fa7405-0b18-46d1-a9bb-ca44b88de8f4	gol3tO9D3XbogoQa6jXl	4586	Cappuccino	Pastries	5	76.25	2025-04-08 18:01:47	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	gabriela.mendoza	2025-04-08 18:01:47
456a5d09-3380-400d-805a-8755a91ebe2e	9L1xmfua8bCXQa8turg6	4588	Espresso	Pastries	2	195.76	2024-12-03 05:55:42	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.rivera7	2024-12-03 05:55:42
712cf5c6-2551-4458-a290-c91984ea5317	ftVgH1JimndHGBF6fzR6	4592	Cappuccino	Pastries	2	76.25	2024-12-22 08:36:34	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905303317	admin	2024-12-22 08:36:34
fa3ecd91-f041-459c-8eb8-a5e7a82346b2	2GCsj3MtpHzeMXleDUdc	4593	Espresso	Pastries	1	195.76	2025-05-09 04:22:37	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carmen.santos1	2025-05-09 04:22:37
42a858e7-1987-44a7-9745-3bad1764bd39	hFBqZvIJT6lRmy2O1AQj	4609	Almonds	Pastries	1	5.59	2025-01-17 10:49:32	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	fernando.santos8	2025-01-17 10:49:32
f6cc3fb7-4e9a-4a9e-bf59-2a4542e4456e	vsfQveJ7a7UfHzcsUNCx	4617	Apple Turnover	Pastries	1	154.54	2025-08-29 11:08:02	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	ana.rivera3	2025-08-29 11:08:02
44394d19-d291-4d8b-b568-93505e3a7a66	6aZgub9WokNQZYw28Uh5	4621	Blueberry Muffin	Pastries	4	185.15	2025-10-11 14:37:01	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.cruz12	2025-10-11 14:37:01
b06b486c-f742-4156-8012-3f00f61501c6	L6kDdtd5C8mwvbthKdYA	4626	Mocha	Pastries	1	61.74	2025-04-29 10:24:05	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	rosa.cruz13	2025-04-29 10:24:05
9094161c-862c-4f01-aac1-992a2188d9ef	dXLwtXnWaXcbNUCxprxx	4631	Latte	Pastries	2	108.74	2025-10-20 20:27:39	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	antonio.santos6	2025-10-20 20:27:39
fcf8c2e2-efbd-4d71-8b71-d57fcd90d369	prP1FBWIfYGJiKqxCgB4	4632	Iced Coffee	Beverages	3	107.80	2025-02-17 07:04:12	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	admin	2025-02-17 07:04:12
ddba0b99-f17b-41ff-9b39-498a7200a428	zefXeg43WxVd5qmtl9Uf	4633	Flat White	Pastries	3	113.21	2025-08-08 07:22:55	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.delacruz	2025-08-08 07:22:55
99ce1f09-3672-4727-8416-5851224a0758	cbakVmFsMGjBQzWIJ8wM	4634	Tiramisu	Pastries	5	196.55	2025-07-20 10:27:20	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	carlos.cruz12	2025-07-20 10:27:20
f8e12af1-6f23-4a4d-aaf6-c01840159d04	9fSWsrHF6icTVHNks9Hz	4636	Espresso	Pastries	1	195.76	2025-09-20 07:58:26	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	miguel.cruz15	2025-09-20 07:58:26
0ac9eca3-437d-43e6-9935-6f14aab36448	UFb94MtULGFdIzomCgss	4637	Apple Turnover	Pastries	4	154.54	2025-01-26 15:44:44	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	sofia.bautista5	2025-01-26 15:44:44
bd8dc459-e289-4ede-8d90-09d42d780a61	nZTi6r5HLYEb5ahglKPK	4639	Hot Chocolate	Pastries	3	131.53	2025-07-25 11:49:30	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	pedro.cruz14	2025-07-25 11:49:30
7d39c6af-1f16-4e8f-aecf-dab853a8226d	AeELiSVKZY6PG0SXlQz5	4640	Iced Coffee	Beverages	1	107.80	2025-08-15 06:54:27	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.cruz12	2025-08-15 06:54:27
78a7e80a-803e-4d1f-a4c8-3e4a5b392e52	4QO5mT0k8jXx5l9Sbrmx	4648	Cappuccino	Pastries	2	76.25	2025-09-23 00:48:01	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	miguel.cruz15	2025-09-23 00:48:01
066a297f-76db-4a60-99f8-ccc0f7365021	rFXrXontGOccF6iuo0Cg	4650	Flat White	Pastries	2	113.21	2025-11-08 12:05:12	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carmen.santos1	2025-11-08 12:05:12
31e8e515-5b48-4ed0-af50-66876a28628e	OaxP30pTp2p4IDL9LO3O	4653	Chai Latte	Pastries	4	100.50	2025-04-12 13:15:37	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	fernando.santos8	2025-04-12 13:15:37
a88dc62f-67af-4d76-9450-8453b14e36a2	EkT43PQ5EfyNZouGlniZ	4654	Tea	Beverages	3	106.18	2025-07-28 19:06:58	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905667013	rosa.cruz13	2025-07-28 19:06:58
cfbede81-9d42-4eb0-80c4-4eec10aeaaec	03z1C1TpeZeZSKRECTnF	4658	Macchiato	Pastries	4	93.97	2025-04-09 12:14:06	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	elena.fernandez11	2025-04-09 12:14:06
7de44fa8-317b-46ec-8c25-2357b39c2882	FMo2OHwvH0GlzxioeywB	4660	Cappuccino	Pastries	1	76.25	2025-11-03 16:27:40	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.santos8	2025-11-03 16:27:40
d872475a-bf80-4795-83c1-6e4a99412b1e	WjQqZCnBqJfmf1kySEtY	4663	Eclair	Pastries	4	146.12	2025-08-25 06:56:43	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905056888	carlos.cruz12	2025-08-25 06:56:43
e3f269f9-66c8-435e-844d-e5d62d311e2e	sIrpH17SQge4qnC6vz56	4674	Iced Mocha	Pastries	5	144.00	2025-10-24 03:33:09	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	sofia.reyes9	2025-10-24 03:33:09
5620830e-a397-44d4-8179-32dc6484a983	WyFS3ZnygTjheZxCatTM	4677	Apple Turnover	Pastries	1	154.54	2024-11-25 13:50:01	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905070540	fernando.santos8	2024-11-25 13:50:01
6373973e-bb47-4f5c-8f75-045b44008a59	PIcxRgSNqaHd4b202yrU	4679	Americano	Pastries	2	80.96	2025-05-13 06:39:49	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	antonio.delacruz10	2025-05-13 06:39:49
8db83015-ee23-4af6-a5e1-f7e7d854f5e3	t9QPGzA5odhUCGdJdNdR	4680	Latte	Pastries	3	108.74	2025-06-21 00:33:53	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	antonio.delacruz10	2025-06-21 00:33:53
b8910c1f-1f7c-4f83-894a-f81f42c72deb	urFdZLbMfejDIYDdVD4i	4683	Tiramisu	Pastries	1	196.55	2025-10-03 03:21:18	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	sofia.reyes9	2025-10-03 03:21:18
ec465be3-9b78-46a8-8842-64a2aea26110	4cVUGNEPImBH8RtIn3DQ	4687	Hot Chocolate	Pastries	1	131.53	2025-05-02 12:36:10	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.cruz12	2025-05-02 12:36:10
c236f6db-5f83-4ddd-bd18-f959d83e8563	zGZCWGd3DssOyDHnrKIW	4688	Apple Turnover	Pastries	2	154.54	2025-10-09 16:05:50	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	pedro.cruz14	2025-10-09 16:05:50
d04eab6a-211c-493a-ab76-e086ffdaa0a2	fm9SpL4PzJYxr8nUNAxe	4691	Tiramisu	Pastries	2	196.55	2025-10-09 05:43:12	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905014695	ana.rivera3	2025-10-09 05:43:12
a1bb7603-d824-4852-915d-a202f2527780	n7VTT3KKdvNtqjOEhTOn	4699	Chai Latte	Pastries	1	100.50	2025-05-22 14:10:16	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carlos.delacruz	2025-05-22 14:10:16
b2fa482d-c446-411a-9034-ec39d6a51238	cmEcIO20D3CQtKy7fSFW	4704	Mocha	Pastries	1	61.74	2025-11-15 04:40:03	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905435264	miguel.cruz15	2025-11-15 04:40:03
86811cf9-a62a-40b6-9e16-5e983f9efbd3	WiepTj6dwKZ7v1SOt6p7	4707	Tea	Beverages	4	106.18	2025-01-30 17:22:16	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905660624	elena.torres2	2025-01-30 17:22:16
cc03b241-a462-4641-8373-8242702a0900	HO3Ab38f0NfNauqHcaV8	4710	Baguette	Pastries	5	133.77	2025-04-09 08:50:13	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905440989	isabella.delacruz4	2025-04-09 08:50:13
ddc5dd49-32a5-4966-be1e-79a1a5dadc58	62fObOE2sSgqfh42mUS2	4713	Cappuccino	Pastries	5	76.25	2024-12-16 05:33:54	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	miguel.cruz15	2024-12-16 05:33:54
c32dbd7d-9441-4fe0-be88-cf850f6ef5ab	EzLos1k6uLBb8im4A4PD	4715	Espresso	Pastries	2	195.76	2025-06-22 18:05:24	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.delacruz	2025-06-22 18:05:24
85ea48e2-7bb3-4d57-8fb7-c3e1d6e656b0	Y3RwpyeeVCSgC4eQdbTi	4723	Iced Coffee	Beverages	3	107.80	2025-05-13 00:41:58	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.delacruz10	2025-05-13 00:41:58
fbdad089-a3ed-4c9f-9f41-d4984b599ef7	\N	\N	Almonds Croissant	Pastries	1	179.86	2025-11-26 10:41:44.590319	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	8654485522588	admin	2025-11-26 10:41:44.590319
4b46a5de-cd3d-4bab-b754-6c7dc0e17d64	u0g2ChQrg9oRKxkZ4MNw	4727	Latte	Pastries	3	108.74	2025-10-27 09:58:11	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905537551	antonio.delacruz10	2025-10-27 09:58:11
2d1b2fa2-6320-43ce-aacb-a62d014f7a06	j6esezQQ6puGbziYf4pl	4730	Apple Turnover	Pastries	4	154.54	2025-05-09 04:20:18	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	carlos.mendoza	2025-05-09 04:20:18
bab70205-b269-4b1c-9514-da919d2fda01	oW02jBxS99aeMlvT3flg	4735	Cappuccino	Pastries	2	76.25	2025-05-29 15:26:36	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.cruz	2025-05-29 15:26:36
96320821-75d1-4289-87ae-8c2479d752c2	ploS0oRo0dmCjyFpHvFW	4736	Baguette	Pastries	1	133.77	2025-09-30 18:08:01	c8d156d2-b289-439f-90bc-692447063015	Card	\N	gabriela.mendoza	2025-09-30 18:08:01
644ab81f-69a8-423d-b3e7-5bd771a1d4dd	fl9mFHcN1ItK6gKBpwER	4737	Macchiato	Pastries	4	93.97	2025-08-28 08:00:18	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	ana.rivera3	2025-08-28 08:00:18
4427cdfb-6d9f-4909-b4da-124d268fcab6	A2weqAamDPqhlHR5AEyM	4739	Almond Croissant	Pastries	1	8.42	2025-03-18 15:03:56	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905000141	ana.rivera3	2025-03-18 15:03:56
b3ecc64c-29b1-4593-95bd-85977cd5e930	jIjjphO8VYOEYO9BlLFF	4743	Tiramisu	Pastries	4	196.55	2025-01-10 08:59:19	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905203693	antonio.delacruz10	2025-01-10 08:59:19
9d497e36-b6f6-4f95-9f0b-e543bbea0428	A7UXOTyHpXW8g66ArU2c	4744	Glazed Donut	Pastries	2	148.75	2025-02-28 00:16:22	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	carlos.cruz12	2025-02-28 00:16:22
7bf5bd06-dfca-4599-b5b5-bd40f0d3936d	0h1HnYK66EggHqYHJJZe	4748	Baguette	Pastries	2	133.77	2025-03-07 23:32:17	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	rosa.cruz13	2025-03-07 23:32:17
5799eab4-0bf3-44e8-a397-acce8dc28442	tIb2QmFaH3NvEiqJgKAp	4750	Tiramisu	Pastries	4	196.55	2025-06-01 12:47:20	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905323852	isabella.delacruz4	2025-06-01 12:47:20
20a1d7e6-904d-4c0d-9051-8ccc43363e45	Bvcu7QSZLywwe2o9bTLq	4752	Tiramisu	Pastries	1	196.55	2025-04-13 02:43:57	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.cruz12	2025-04-13 02:43:57
12c5c775-95cc-4ab9-836b-0cfd4b91c4e9	VQ3zuGjQ1OPRLikeE54C	4753	Almond Croissant	Pastries	1	8.42	2025-10-08 13:09:59	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.cruz12	2025-10-08 13:09:59
52eea13b-5dbf-4aae-bd8c-a7469d30db3b	3ZCPK6IriioFF3KIjmq1	4758	Almond Croissant	Pastries	2	8.42	2025-08-24 07:26:21	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905384695	rosa.cruz13	2025-08-24 07:26:21
5cb4efad-0761-4be8-9d04-03d270a384c9	tsoICKgdC0zs60DiMTn8	4768	Macchiato	Pastries	2	93.97	2025-11-04 14:04:44	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	pedro.cruz14	2025-11-04 14:04:44
77b4dcc3-01c6-4d06-b7de-5864552d73ac	VByunQrOG5SpIpLYqDei	4774	Americano	Pastries	2	80.96	2025-05-31 02:38:42	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	fernando.santos8	2025-05-31 02:38:42
ae4a163c-cab7-45c5-abc1-0ddee4f33224	DojDDEdO7EsvRjVAt3eN	4779	Tiramisu	Pastries	4	196.55	2025-08-30 19:22:05	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.delacruz10	2025-08-30 19:22:05
d5d04799-0e8e-48ad-9877-62c2e9e571f9	GTrvmZvL02mSJrTYpnEr	4780	Glazed Donut	Pastries	4	148.75	2025-04-24 23:32:26	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carmen.santos1	2025-04-24 23:32:26
602607a5-a740-41d2-a10c-dfc46d847653	EDFVoh2AzsIDZCoNwJen	4785	Espresso	Pastries	1	195.76	2025-01-15 13:34:10	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905157599	gabriela.mendoza	2025-01-15 13:34:10
a46f574c-0a46-4e38-bfba-715e6335c01d	sSMwth6tbVakon6ed8m1	4793	Iced Mocha	Pastries	3	144.00	2025-06-16 16:59:02	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905108397	sofia.bautista5	2025-06-16 16:59:02
4f9402a4-d605-489a-847d-12625e6b2db8	X5Ec4RqZyJWTEUxpKrv6	4795	Flat White	Pastries	4	113.21	2025-01-31 05:17:11	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905319599	elena.fernandez11	2025-01-31 05:17:11
1ad4beb7-369b-4949-b935-8e820b803c9e	UnLtZVpDg6Tb8rIbwqnQ	4796	Hot Chocolate	Pastries	3	131.53	2025-09-17 04:28:51	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	fernando.santos8	2025-09-17 04:28:51
f43583f6-fc23-49c7-a46d-bf38b9011419	8ksYtFMfqdiObYeaIliU	4799	Eclair	Pastries	4	146.12	2025-09-21 00:23:20	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905943350	carlos.cruz12	2025-09-21 00:23:20
19341503-a446-4c2a-a36c-f13cda0405bc	TxYEshfF3ec2wxZfX9xH	4801	Flat White	Pastries	1	113.21	2025-07-29 07:54:59	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.delacruz	2025-07-29 07:54:59
9bca04df-0c5f-47dd-b12a-377bb730e93f	tONqqXfr0jbbXjLFaVgf	4802	Blueberry Muffin	Pastries	3	185.15	2025-07-16 19:49:09	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905007885	pedro.cruz14	2025-07-16 19:49:09
8b3b40e9-89c3-47eb-ba7c-547c0d0cf646	44Nz801Pe7nkcfE5vlBm	4804	Almond Croissant	Pastries	3	8.42	2025-05-13 19:16:50	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.delacruz10	2025-05-13 19:16:50
dc4d8536-2a8a-4a9e-9977-64c0085cb513	4VmHYMAvuDaec7xKyTnM	4811	Hot Chocolate	Pastries	3	131.53	2025-05-22 20:31:30	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	rosa.cruz13	2025-05-22 20:31:30
0e62eac1-393e-4490-a9f7-e1a5ab9ea5fd	iU5PxmaMmPx5woJd5LQj	4812	Red Velvet Cake	Pastries	5	187.25	2025-01-20 21:02:35	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	antonio.delacruz10	2025-01-20 21:02:35
8edfdd34-9e62-4997-8759-457ffaeeb5a7	\N	\N	Almonds Croissant	Pastries	1	179.86	2025-11-26 11:47:37.48671	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2025-11-26 11:47:37.48671
9f1db39d-dcbf-4554-9335-494039407c5f	KniHvTkDSPqJqiXoDKOf	4816	Macchiato	Pastries	5	93.97	2025-02-12 09:58:35	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	fernando.cruz	2025-02-12 09:58:35
eeb0e273-edda-4ef1-a778-ed584a643597	gR3SWI0BcPMOVX6HxGmH	4818	Eclair	Pastries	5	146.12	2025-08-24 01:02:02	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	isabella.delacruz4	2025-08-24 01:02:02
9c05282d-fa4a-406b-aa17-d82864fc9242	CcT4x5RbxZ8woe9Myaig	4824	Baguette	Pastries	5	133.77	2025-05-18 23:22:25	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	gabriela.mendoza	2025-05-18 23:22:25
510e1190-6cfe-4277-97d4-a9d6dc6017c2	hiw0YsJxIHizInSVabQx	4825	Latte	Pastries	3	108.74	2025-07-07 05:18:07	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905687240	fernando.cruz	2025-07-07 05:18:07
7ea0510b-12a2-456f-a243-56311b0ff666	UsiAQWfVFeUvjTCyX1pO	4829	Iced Mocha	Pastries	3	144.00	2025-06-10 07:47:48	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905610061	ana.rivera3	2025-06-10 07:47:48
4e0e3628-960f-4c7f-9e09-2ee391bbbbf3	zHqXMQra7D5dv1tFm66D	4830	Cappuccino	Pastries	3	76.25	2025-01-08 00:08:55	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.fernandez11	2025-01-08 00:08:55
b69f4c8b-5a1b-43d1-8014-90a3b2961c94	XLuUs39cLSLlNfSruocF	4842	Espresso	Pastries	3	195.76	2025-03-03 01:27:42	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	admin	2025-03-03 01:27:42
e9c80db3-363b-4d64-843d-e395eb41f03a	zTwoX5uhMjrNlOO80xZE	4844	Chai Latte	Pastries	5	100.50	2025-10-13 07:58:51	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.reyes9	2025-10-13 07:58:51
356891ad-5b06-4c6f-97dd-4ec3225919ee	5aY0z0bE6wRw9b2V22zz	4848	Iced Mocha	Pastries	1	144.00	2025-03-20 10:02:03	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.santos6	2025-03-20 10:02:03
31113418-c18a-43bc-8d47-ce70130a924e	M9Tfm4D0qYXcVU8TXVjD	4849	Almonds	Pastries	5	5.59	2025-05-13 03:56:32	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	miguel.cruz15	2025-05-13 03:56:32
5908e871-f15d-4eba-af5f-237f015df062	JlAw1C2epwJGQ6kGhh6L	4850	Iced Mocha	Pastries	3	144.00	2025-07-27 20:33:20	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	miguel.cruz15	2025-07-27 20:33:20
9af94fcc-76ab-494a-b55e-396eda94beeb	jf6a2iwPvd4gkeOE6fgw	4853	Blueberry Muffin	Pastries	4	185.15	2025-04-03 06:41:45	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.cruz	2025-04-03 06:41:45
661f2395-2513-472f-840a-3c1033794730	7821UGDF0V0ChjJrjjOm	4856	Apple Turnover	Pastries	2	154.54	2025-03-02 06:22:37	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	antonio.delacruz10	2025-03-02 06:22:37
1e578bb6-1e35-4fc9-aced-112e15e30e62	HCJylSYG5B9oehLV7L1Y	4857	Almonds	Pastries	4	5.59	2025-10-24 09:34:53	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	antonio.santos6	2025-10-24 09:34:53
1d5be981-1b9e-46a0-93bb-bb8e89f77a6f	YM7Y4ccaZJhu8qPcCHAJ	4858	Espresso	Pastries	2	195.76	2025-01-06 07:37:12	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905166629	carlos.delacruz	2025-01-06 07:37:12
85097ada-4775-49be-8a3b-fca3e3c752de	q30r5ocUfHcbuqVg8YaY	4861	Blueberry Muffin	Pastries	1	185.15	2024-11-30 10:22:51	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	gabriela.mendoza	2024-11-30 10:22:51
a725f194-b9e8-415e-9b53-8670085e3762	pdsXEBfFpKyYKeVXPNnx	4863	Latte	Pastries	2	108.74	2025-10-12 12:22:58	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.cruz13	2025-10-12 12:22:58
f0ba2dec-ff57-48ca-916c-e29448fbc76b	7WCxema6lzirodlPlBu1	4872	Latte	Pastries	2	108.74	2025-03-31 00:26:02	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	miguel.cruz15	2025-03-31 00:26:02
78ced4ea-8243-4ce2-9074-247849cfab69	Z4vCAwJWjjBHgmFMXwsc	4874	Hot Chocolate	Pastries	3	131.53	2025-05-09 17:23:52	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	carlos.cruz12	2025-05-09 17:23:52
8450a668-0986-4013-90ce-0b9f6f4c79e0	yycftutxUlftBSVqVsym	4877	Latte	Pastries	3	108.74	2025-08-26 00:07:41	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	miguel.cruz15	2025-08-26 00:07:41
f0f4a56a-5fca-4e5a-be27-1b07e5394e5b	nowZOSvFShA8MGeUZjb6	4882	Almond Croissant	Pastries	1	8.42	2025-09-24 23:02:38	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2025-09-24 23:02:38
b51d4d78-9100-4848-a55b-40b4fa91a15b	c972E6TKfyo1Ef5Ps0E8	4884	Macchiato	Pastries	2	93.97	2025-07-31 09:59:47	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	miguel.cruz15	2025-07-31 09:59:47
621feacb-3bb0-4f63-b806-dfad0dbe3d00	DiILWdlDoJc7DGxQbtjg	4890	Tea	Beverages	4	106.18	2025-07-30 02:40:31	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.delacruz	2025-07-30 02:40:31
10178845-baec-4346-847c-2e8c4c550149	m4jf6L2mtG5uIlUJQnIn	4892	Baguette	Pastries	3	133.77	2025-01-17 04:52:04	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.mendoza	2025-01-17 04:52:04
3efd67a0-640c-441d-aa0c-eb957b758b09	liReYl5SyJmxQM99Ehp4	4895	Baguette	Pastries	1	133.77	2025-05-16 22:43:38	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	pedro.cruz14	2025-05-16 22:43:38
b63db9ac-4cd0-46a5-864d-ee9557177ff4	gl9tjVw46SQyaMbxB4hq	4896	Iced Mocha	Pastries	1	144.00	2025-04-14 23:25:14	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	fernando.cruz	2025-04-14 23:25:14
6627ab34-b9a9-4231-b598-4f5f64462153	t7sEJKvWJDXQyKTt5jsb	4906	Macchiato	Pastries	1	93.97	2025-08-28 06:29:45	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	isabella.delacruz4	2025-08-28 06:29:45
7aa25907-f1ee-4b68-83fa-d8fa3deaa494	WTqLB6RnM17tfN6lgF7a	4916	Mocha	Pastries	2	61.74	2024-12-23 09:58:43	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	rosa.rivera7	2024-12-23 09:58:43
6e1dbc65-08b7-4e96-8ccf-8e4302a1db0a	vJmTIzeghKTalp1Nm4xy	4918	Chai Latte	Pastries	4	100.50	2024-12-10 08:16:01	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905901801	sofia.reyes9	2024-12-10 08:16:01
292e8a03-b040-4a24-a669-0e32081a0503	4nUi7jLAf3dYuRnJtKnz	4919	Almond Croissant	Pastries	2	8.42	2025-01-02 13:35:45	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	carmen.santos1	2025-01-02 13:35:45
2d128c42-1dee-45c6-93b6-5d223192fcaf	iV3suORtAXQF8xYpZs5P	4928	Macchiato	Pastries	3	93.97	2025-05-18 09:48:26	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	gabriela.mendoza	2025-05-18 09:48:26
97c1163d-5ee5-4539-bfcc-f9afc18b929d	VulmD48XFC5QZ9HoZyLn	4929	Tea	Beverages	1	106.18	2025-10-29 06:28:21	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905702464	elena.torres2	2025-10-29 06:28:21
62480de0-51f5-44af-ad7b-05e596c228b1	RsguARbU4efYHMIZGTvv	4931	Chai Latte	Pastries	4	100.50	2025-06-10 18:04:06	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905103853	rosa.rivera7	2025-06-10 18:04:06
fecb5796-bba9-4771-9d60-87ff316cefee	5dOXdvA0cDJJtMGpemkm	4932	Almonds	Pastries	2	5.59	2025-05-19 22:52:09	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	ana.rivera3	2025-05-19 22:52:09
5084f461-a45d-4198-a543-97bd8ac9e5f6	dvQsbCxLcsNQYBlWqtJT	4936	Almond Croissant	Pastries	3	8.42	2024-12-04 04:35:06	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	elena.torres2	2024-12-04 04:35:06
e9989a0b-42b2-4f7b-be92-2c351c2e202b	4BCQin8IYTjrOi2PKwD3	4938	Iced Mocha	Pastries	3	144.00	2025-11-23 05:45:15	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	carlos.cruz12	2025-11-23 05:45:15
001369bc-e7ec-4328-b4a6-8cfb72e807fe	ytPTPd527aRQzmrCV9IR	4941	Apple Turnover	Pastries	3	154.54	2025-03-31 05:05:38	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905781433	antonio.delacruz10	2025-03-31 05:05:38
d53db8d0-8bae-4ece-89db-f2a55156421f	\N	\N	Americano	Beverages	1	80.96	2025-11-26 11:47:37.497138	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	admin	2025-11-26 11:47:37.497138
0f369c7d-7a2b-4622-b015-cefcdd46190d	jDPPBZ2BUo86Bt2f4bM4	4945	Hot Chocolate	Pastries	3	131.53	2025-01-31 00:31:05	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	ana.rivera3	2025-01-31 00:31:05
dd16515f-21af-42c7-bdb9-5064dba85833	thxQR0ogOIKexwB8zk7I	4948	Tea	Beverages	4	106.18	2024-12-30 17:46:17	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carmen.santos1	2024-12-30 17:46:17
a363cb5f-39da-4b68-a893-83379d8c7fdc	zZBwT1cflSMpBIHZz0hM	4949	Tiramisu	Pastries	5	196.55	2024-12-27 18:43:03	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.cruz12	2024-12-27 18:43:03
32e048f6-01d6-4a4f-b980-daef33093175	YUUlNDrYu1gRay2DVzvM	4950	Almond Croissant	Pastries	5	8.42	2025-04-14 20:45:29	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905285668	carlos.delacruz	2025-04-14 20:45:29
40c8e35e-9bb7-42c0-9ffc-4652672805d2	txTr7ztPRlxccnOruRAF	4953	Eclair	Pastries	2	146.12	2025-03-06 21:24:52	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	carlos.cruz12	2025-03-06 21:24:52
a91d804f-e3f6-4122-ac5e-e26b6d09e1aa	4yAeb1thcStLFC6T9leZ	4954	Iced Coffee	Beverages	5	107.80	2025-06-13 07:00:00	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	elena.fernandez11	2025-06-13 07:00:00
271c341c-a905-4478-9333-bb050a6a1eaf	I2fkajt6OcSrMfRA7K4a	4958	Baguette	Pastries	5	133.77	2025-01-26 16:44:18	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.delacruz	2025-01-26 16:44:18
29a5bdd7-95fb-4f71-a666-a1cb6fdb0a68	kXqzWf8fD8C4YYz9si81	4960	Macchiato	Pastries	1	93.97	2025-07-26 13:35:10	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905585652	ana.rivera3	2025-07-26 13:35:10
7a5f35f6-c058-40e6-8476-0e2c24d479f3	qW8ump092hgiBE4EhVCY	4964	Blueberry Muffin	Pastries	3	185.15	2025-08-20 06:11:30	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	sofia.bautista5	2025-08-20 06:11:30
83ba6a18-eda1-468e-b125-48f7bd2eb9fe	CmGo2Xz4k8fXyJe4zjVr	4967	Macchiato	Pastries	1	93.97	2025-09-24 03:13:37	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	sofia.reyes9	2025-09-24 03:13:37
4fe48102-3c5e-4467-a876-1a1528bbd996	FC7p3FAt10ihu9IpbkXV	4973	Iced Mocha	Pastries	3	144.00	2025-05-04 14:59:24	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	fernando.santos8	2025-05-04 14:59:24
e0fca327-2343-4592-a249-4bf3c7f4014c	3ZwfSaC9bW5ADJYFwlpc	4980	Mocha	Pastries	5	61.74	2024-11-28 05:38:44	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905708155	miguel.cruz15	2024-11-28 05:38:44
58ca1a68-ee11-4a66-bdd4-df434d9e9281	g8JVMME2QLVFMKZKiMq4	4983	Baguette	Pastries	3	133.77	2025-01-13 20:47:53	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.cruz12	2025-01-13 20:47:53
6d8015fd-3b52-420d-80bd-21d1a98ba0ad	bYg6U9ev5v5SPdFu34Lr	4985	Cappuccino	Pastries	4	76.25	2025-04-12 06:50:07	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.cruz13	2025-04-12 06:50:07
7a91f297-7c35-4d5e-91a0-eebe0917556a	Wpy2QGaIXmkG3aMo8EvR	4988	Macchiato	Pastries	5	93.97	2025-11-17 06:41:37	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.cruz12	2025-11-17 06:41:37
31629651-dc3f-43db-81dd-f8027e51e4cc	xS8EHf0NKICN8xWtdB29	4990	Red Velvet Cake	Pastries	5	187.25	2025-05-09 23:33:06	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905226414	pedro.cruz14	2025-05-09 23:33:06
3d5bcce3-7d52-43ed-98d4-e0952332e055	9L9EXa8nL3cyzD0bPvlC	4993	Baguette	Pastries	4	133.77	2025-03-26 13:03:07	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905994307	antonio.santos6	2025-03-26 13:03:07
fdea9159-c590-4762-b621-2775ef89a142	7exTbEf4c3I4g8OzeQMW	4997	Macchiato	Pastries	2	93.97	2025-10-05 23:01:40	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905857487	carlos.cruz12	2025-10-05 23:01:40
6827b7f8-48e2-4490-b8fc-3eba6f6946ad	LYYzAksFRe5tt096IOkd	9004	Eclair	Pastries	5	146.12	2025-04-25 13:10:38	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	admin	2025-04-25 13:10:38
5c126c4b-8e27-4b37-98ca-3a99b4cc843c	4M4yd8WBdLVyUbUE1cro	4998	Flat White	Pastries	1	113.21	2025-02-18 14:04:44	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905407087	miguel.cruz15	2025-02-18 14:04:44
8062db1a-5919-47fe-a2c9-3da6a7c83477	Tr7isTl3gIB2JTSTp6iS	5002	Iced Coffee	Beverages	4	107.80	2025-04-20 16:31:17	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	miguel.cruz15	2025-04-20 16:31:17
77bec7a6-79a5-4362-a686-70568c9bccb5	ETKFK5EHsEbl0HRmcgtX	5003	Tiramisu	Pastries	5	196.55	2025-01-13 21:37:14	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.mendoza	2025-01-13 21:37:14
59363a14-ed58-4eef-ad88-86d44d77d9ab	0XF2PUyV9D9HiqKmMsFT	5004	Iced Coffee	Beverages	4	107.80	2025-06-23 09:38:10	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.reyes9	2025-06-23 09:38:10
370474fa-1c3a-4311-8d71-3d06eab0971c	xfCRhAjoIORBM1oN3xs1	5005	Baguette	Pastries	5	133.77	2025-07-15 08:17:57	c8d156d2-b289-439f-90bc-692447063015	Card	\N	rosa.rivera7	2025-07-15 08:17:57
459f9dfa-be1d-428b-a97f-013c76d67566	BCM10t7JXMLukCBjZIVB	5007	Tiramisu	Pastries	5	196.55	2024-12-15 16:53:45	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	ana.rivera3	2024-12-15 16:53:45
60a586bb-0eea-4514-a4f3-5d96006aade6	5PnYUQLbYMEWs3UAkrUP	5012	Latte	Pastries	3	108.74	2025-02-23 18:17:30	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905643891	isabella.delacruz4	2025-02-23 18:17:30
4b659a46-0c3c-4904-b72d-8aff417a4598	Vgx8MEsVQhbGqZtOvPLW	5013	Almonds	Pastries	1	5.59	2025-08-05 19:46:40	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	rosa.rivera7	2025-08-05 19:46:40
2979ed7a-f027-49bd-9115-414d2f735434	rXJyfa7es7MBtApSW1xN	5018	Chocolate Chip Muffin	Pastries	3	103.79	2025-09-12 11:53:20	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905845738	fernando.cruz	2025-09-12 11:53:20
7365090b-3230-4c80-917d-c3e2da4a50ad	MLUuSvXjZOInVa4J79PO	5020	Macchiato	Pastries	2	93.97	2025-08-28 21:33:12	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	elena.torres2	2025-08-28 21:33:12
4f279730-b104-4234-8c6b-7f29972e2e9a	nZvDqKAjJx96m7kKnoFn	5021	Iced Coffee	Beverages	4	107.80	2025-09-04 02:15:18	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.delacruz	2025-09-04 02:15:18
5608e8ab-b929-442b-92d7-bcf1f708dc13	nqoseXCSJUrHAyR2mlRH	5022	Blueberry Muffin	Pastries	4	185.15	2025-07-09 16:30:58	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.delacruz10	2025-07-09 16:30:58
3a81a64f-794b-482a-a177-1e7a0e9aecc8	Ys5FbcYiEBW3NkBFEoin	5025	Chocolate Chip Muffin	Pastries	1	103.79	2025-04-01 16:14:27	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905099588	admin	2025-04-01 16:14:27
ec3eda54-ff8e-450b-9272-e46d03d75d5e	AbRHEt5AvLFMFhU1Prdi	5030	Americano	Pastries	1	80.96	2025-05-02 22:32:25	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905617466	antonio.delacruz10	2025-05-02 22:32:25
c478a071-f1c3-49cf-9625-1f4277a522f5	\N	\N	Almonds Croissant	Pastries	1	179.86	2025-11-26 14:31:51.573254	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	admin	2025-11-26 14:31:51.573254
e14e8634-3da7-4aca-bdf6-ee2ccaf7f330	THE7JSeF0VmhM6reZ2bu	5035	Iced Coffee	Beverages	3	107.80	2025-07-14 22:23:50	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	elena.torres2	2025-07-14 22:23:50
f32fbb34-311c-423c-8610-3e1a5a2a3dc7	2bSmlOyMttfQtUumDcYM	5038	Red Velvet Cake	Pastries	2	187.25	2025-03-30 21:10:44	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905962674	pedro.cruz14	2025-03-30 21:10:44
d02446ec-cb36-4d1d-b72c-f5fcfd8014cb	ycCmHadLvlpMPJyMN9fI	5041	Chai Latte	Pastries	2	100.50	2025-02-08 06:29:20	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.bautista5	2025-02-08 06:29:20
e0a03b20-05b6-49c4-9b8f-abd1cf5b0903	vVIVYTpQxKASYB4kM8GX	5043	Cappuccino	Pastries	4	76.25	2025-04-21 02:59:19	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.delacruz	2025-04-21 02:59:19
1e5d15db-8ad3-4850-bdf4-ae6907fa010b	n1UKAHxLuajLw9VhPBMK	5044	Iced Mocha	Pastries	5	144.00	2024-11-26 16:33:07	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905025497	antonio.delacruz10	2024-11-26 16:33:07
4f8fc4e6-36a9-462f-b15c-3d29ca68b290	T7zkliW6dIjSs2OGEbt9	5045	Mocha	Pastries	5	61.74	2025-06-11 21:10:17	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	admin	2025-06-11 21:10:17
4cb5c7a8-c976-4956-aec1-14ac2e63f5f4	Kncc7Hv9GCfWhWju5KsX	5049	Chocolate Chip Muffin	Pastries	3	103.79	2025-11-15 16:24:35	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carmen.santos1	2025-11-15 16:24:35
ce073ee2-1e91-420a-9181-2439c412958f	QjHy3nEXr3eVqwwQfkt5	5052	Tiramisu	Pastries	5	196.55	2025-07-14 13:12:02	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905927896	sofia.bautista5	2025-07-14 13:12:02
8ee975dd-ac93-4254-9cac-e89ceaf5aace	LJNKeTHSEegjlsHdQDCb	5056	Almond Croissant	Pastries	5	8.42	2025-10-28 08:35:11	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.santos8	2025-10-28 08:35:11
c11e2fe5-8199-40c4-aa70-89e47de66650	OfPHCfgNL0KpEQwqo3wh	5057	Cappuccino	Pastries	2	76.25	2025-09-12 10:32:09	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	ana.rivera3	2025-09-12 10:32:09
93b63abe-da1b-475a-97be-4fe0a62a4d02	ZQ6maPpsV491TJIIFeHQ	5058	Iced Coffee	Beverages	1	107.80	2025-02-07 14:07:27	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	elena.torres2	2025-02-07 14:07:27
0445bff0-d908-413e-9586-4eb02d985fa9	B3a6evfHvKlxLl8gM46J	5059	Eclair	Pastries	5	146.12	2025-06-06 11:53:21	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905043573	carmen.santos1	2025-06-06 11:53:21
b49def47-f642-4f42-9ec9-6275e36fb2d4	dncneOa2s7AYclJXc4LT	5062	Hot Chocolate	Pastries	2	131.53	2025-11-18 15:10:58	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	miguel.cruz15	2025-11-18 15:10:58
82bff536-376e-4a81-845d-c41a11d7efd4	uLEIi1TdvDXhovRvrfk2	5071	Americano	Pastries	3	80.96	2025-08-05 03:42:41	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905730222	carmen.santos1	2025-08-05 03:42:41
7307cb4c-bd02-4987-9d38-c607c3424987	6WdRLPRKfEoomw4ppdtH	5074	Mocha	Pastries	3	61.74	2025-02-11 21:39:11	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carmen.santos1	2025-02-11 21:39:11
84d74f42-1606-44a9-80da-c41b0621050b	UCDZCSS7vR3W2JBHRdqR	5075	Iced Mocha	Pastries	3	144.00	2025-03-17 11:10:27	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	elena.fernandez11	2025-03-17 11:10:27
607f8636-02d3-4fd5-8f29-3e0d44c2033a	2xLVTSuzeNvCSFMUh0Az	5078	Iced Mocha	Pastries	1	144.00	2025-03-09 04:03:10	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	pedro.cruz14	2025-03-09 04:03:10
aaa8ff26-659f-46c6-b0d4-68f62493166b	yA2WjwyPgvDbdvSyyR84	5080	Chocolate Chip Muffin	Pastries	4	103.79	2025-07-22 16:01:57	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	ana.rivera3	2025-07-22 16:01:57
c5602145-44c1-4abf-8819-4180e7d15562	dInmYK3B7wFqlhPWmVDK	5087	Tiramisu	Pastries	3	196.55	2025-01-25 18:09:19	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905558607	carlos.cruz12	2025-01-25 18:09:19
4e750810-e35a-4ef5-b1fc-67b3d91f1884	hK0ikzRMCaun3ycGKCut	5091	Iced Coffee	Beverages	2	107.80	2025-08-30 16:47:54	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	elena.fernandez11	2025-08-30 16:47:54
f0466951-290b-478b-b596-b3b0ac4067ce	2f4AdQdaNcuGUuUGUwsC	5094	Cappuccino	Pastries	2	76.25	2025-08-06 15:37:17	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905150353	miguel.cruz15	2025-08-06 15:37:17
efcb9657-c03a-4e66-b8bc-8e97d02f6615	CMV4wKC18vSTLUSCgVk0	5098	Almond Croissant	Pastries	4	8.42	2025-10-22 12:31:53	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.delacruz10	2025-10-22 12:31:53
d4ba4d12-8474-4deb-9bbd-e63fbc93f3b1	y7J9zdSqPGl033DeGgbn	5099	Glazed Donut	Pastries	4	148.75	2024-11-26 02:57:32	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905235080	antonio.santos6	2024-11-26 02:57:32
f701fee8-c5aa-4094-851a-8604b0292fb2	ebDO6yv1GJl8RrjYjadh	5104	Mocha	Pastries	2	61.74	2025-01-09 09:46:21	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905986974	miguel.cruz15	2025-01-09 09:46:21
b69cc53b-e734-4e79-88a6-9e0214a5df42	Nq6HJDJGW6fXTTStZb4d	5113	Espresso	Pastries	4	195.76	2025-07-30 19:37:30	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.delacruz10	2025-07-30 19:37:30
d2cecc04-db83-4dca-a555-4f728000c1c1	2J4fnmRLMYoED4g62gQL	5114	Macchiato	Pastries	2	93.97	2025-10-30 16:22:40	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905990856	admin	2025-10-30 16:22:40
37c34a38-004c-4be6-aea9-cc7743b00586	1Dl3ZgT3vgMx99MygVcx	5118	Chocolate Chip Muffin	Pastries	2	103.79	2025-07-03 02:00:38	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	sofia.bautista5	2025-07-03 02:00:38
c3aa272d-22f0-4df8-a7b3-c52c1f709cbc	BUqzHX0YtipE668R6Vc6	5121	Eclair	Pastries	4	146.12	2025-04-27 06:11:20	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	sofia.bautista5	2025-04-27 06:11:20
4d27f797-0af2-4e37-a3ab-75426d04dd3f	jCvJCG55nDSJHdXljAxN	5123	Macchiato	Pastries	1	93.97	2025-01-17 22:24:58	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carmen.santos1	2025-01-17 22:24:58
15551460-194c-4ee0-b2b4-33f9533e43a7	rkWTIkGobhTBvV6fOfrJ	5125	Cappuccino	Pastries	1	76.25	2025-04-01 10:01:21	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.delacruz	2025-04-01 10:01:21
4f4bcc1a-0ac6-48e0-b19c-e3dd91df500b	BKvMl4tmXHD5GtKXOKVM	5126	Hot Chocolate	Pastries	1	131.53	2025-10-14 22:19:34	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	admin	2025-10-14 22:19:34
e2056da8-804f-4b40-9e28-d59a5f155c7f	BILSWSHSCzHHXItdgOk8	5127	Flat White	Pastries	2	113.21	2025-02-07 02:11:57	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905630099	admin	2025-02-07 02:11:57
89d89efd-673b-438c-b9bb-6d12abc3c675	GD12BVgtPc49bUBhkOEw	5128	Baguette	Pastries	4	133.77	2025-11-08 21:02:57	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	admin	2025-11-08 21:02:57
07fda817-42d2-4d16-a6a0-c67f8dc3ed7a	Ak268lVeejiyVoS7jDsH	5132	Tea	Beverages	2	106.18	2024-12-30 22:56:57	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	carmen.santos1	2024-12-30 22:56:57
ed2e6c27-fd52-4278-bd85-3d83bbd1418b	GDEeR6MTzGycZsM0DSXN	5138	Americano	Pastries	4	80.96	2024-12-24 18:11:14	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carlos.cruz12	2024-12-24 18:11:14
a75011f2-422b-4afe-9ce5-16e50cd9b80a	H6fBWKfBGqz1GmX8huiK	5140	Iced Coffee	Beverages	2	107.80	2025-08-20 14:24:27	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	elena.torres2	2025-08-20 14:24:27
c7c9de02-4744-485f-864c-c4b98150a0b4	pEIh0oT5DgRO3di9tEBA	5143	Apple Turnover	Pastries	3	154.54	2025-03-10 10:42:32	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905602232	elena.fernandez11	2025-03-10 10:42:32
3f401947-6b31-4d13-9d1f-d2da90245640	3IKY3GBqc5LpaGZs9vqH	5144	Tea	Beverages	3	106.18	2025-07-12 22:46:33	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.cruz12	2025-07-12 22:46:33
d1f5e944-d6dc-458d-b005-1d8e8ee6a7b1	Obw89XqeextvXYAuUWDt	5147	Almond Croissant	Pastries	5	8.42	2025-01-08 23:11:48	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	elena.fernandez11	2025-01-08 23:11:48
61f2c58d-0cef-4ce8-9160-8bdaf5f9660d	8XCC0VblZfZ38vUprlUm	5148	Eclair	Pastries	3	146.12	2025-05-08 02:44:52	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.fernandez11	2025-05-08 02:44:52
e2966a39-c233-47e3-8815-d34663dfcc3b	XtmMlFD19dmfIrg39EVA	5151	Cappuccino	Pastries	3	76.25	2025-04-16 23:46:44	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.fernandez11	2025-04-16 23:46:44
b53fa7cc-9222-40ee-a5f1-4013f2f3310a	qaG8E70idMQvs9UQSKOO	5153	Red Velvet Cake	Pastries	1	187.25	2025-02-18 08:17:32	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	sofia.bautista5	2025-02-18 08:17:32
95196082-a543-45ec-9409-f8dbf20fc624	JikOSV4xjbHsXW6pKCVM	5156	Blueberry Muffin	Pastries	1	185.15	2025-05-27 11:58:42	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	ana.rivera3	2025-05-27 11:58:42
bf10aa7f-b0dc-49f2-98ae-1128ab214790	IPPWPPSiGV2sVQq9TTpR	5164	Macchiato	Pastries	4	93.97	2025-11-06 13:21:02	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905640455	miguel.cruz15	2025-11-06 13:21:02
34587637-1092-4cff-965f-ccb4830c26d9	bqHsWC6TDwpJC02pCus6	5165	Chocolate Chip Muffin	Pastries	5	103.79	2025-05-23 09:38:43	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.delacruz	2025-05-23 09:38:43
b73d4bfa-ce52-4061-8356-1c07a74404d7	zjfuHN3ZJg0CFwaDR50q	5168	Chocolate Chip Muffin	Pastries	4	103.79	2025-01-12 22:16:51	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905699896	fernando.cruz	2025-01-12 22:16:51
485a84b0-5696-4bf7-ab5d-574ced53da5d	JJWPxO1i5SJAgcKXRGfA	5172	Mocha	Pastries	1	61.74	2025-07-01 17:31:29	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	pedro.cruz14	2025-07-01 17:31:29
77035e59-3b07-451a-827c-144d0e9e09b3	XY6db15xMoRlkRCgJF2T	5178	Latte	Pastries	3	108.74	2025-03-03 09:58:07	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	ana.rivera3	2025-03-03 09:58:07
9cd1296d-eeef-4391-bbe4-6c9023c964d0	YWI21FbjOT81bt5qfLDE	5186	Red Velvet Cake	Pastries	5	187.25	2025-04-07 18:38:28	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.delacruz	2025-04-07 18:38:28
47797590-e047-4467-86dd-7935a11cb3b0	6uV2Ws9eSASY8eJCyR9W	5187	Apple Turnover	Pastries	1	154.54	2024-12-24 10:18:33	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	miguel.cruz15	2024-12-24 10:18:33
df1b1337-330a-472c-84ef-7f8f8069ca5f	V06XmOB42PKG95AHMc9J	5188	Americano	Pastries	3	80.96	2025-06-08 21:42:16	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carlos.delacruz	2025-06-08 21:42:16
ac25c57b-dee8-4d4d-a744-fc81d5c5f6bd	VmQyc4qAWVQhjAbU3HJ2	5191	Cappuccino	Pastries	3	76.25	2025-03-30 10:38:48	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905502112	pedro.cruz14	2025-03-30 10:38:48
de67c834-0883-4a88-a1f4-c7ecfdf7abbf	Tt6bOOkEGrkGRVWfUgew	5194	Cappuccino	Pastries	3	76.25	2024-12-11 23:59:36	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905321308	fernando.cruz	2024-12-11 23:59:36
e34a082a-8266-44d5-bc40-ab91db677671	0UfUh02vIpmZmiFZjSmn	5197	Tea	Beverages	4	106.18	2025-05-27 16:44:42	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905327424	carmen.santos1	2025-05-27 16:44:42
ebaeb41b-e86d-41e2-89c8-4a73e7f1b2f4	6swoCLvVSKhAcGSvWRmP	5201	Iced Mocha	Pastries	2	144.00	2025-11-16 01:23:21	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905852013	sofia.reyes9	2025-11-16 01:23:21
3aad8086-71a0-4038-92ca-5327b15b0cf3	PTQhl1MBI43tiXwx3oz2	5203	Flat White	Pastries	4	113.21	2025-07-23 01:24:36	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	elena.fernandez11	2025-07-23 01:24:36
0b6e1ece-851b-42dc-a7c0-2be653b4b80b	0d6QaSlf5JzrVD8bBNx0	5207	Tiramisu	Pastries	3	196.55	2025-03-30 23:43:40	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905144079	sofia.reyes9	2025-03-30 23:43:40
e7a19615-57dd-4362-89fa-2fb05550abe3	LtSHq1m5JL2VLbe7iN4B	5208	Apple Turnover	Pastries	1	154.54	2025-05-30 21:53:00	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	sofia.bautista5	2025-05-30 21:53:00
c604f055-27b0-402b-a9bb-c5fa77b03014	UvsrTGlrvSWdsnPiWz95	5209	Americano	Pastries	1	80.96	2025-07-13 14:07:31	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	pedro.cruz14	2025-07-13 14:07:31
09665f22-5531-4ca2-bc58-9f4f4d510179	NGyDr36ghxdueC24JYbJ	5213	Americano	Pastries	2	80.96	2025-02-28 15:00:09	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905895214	fernando.santos8	2025-02-28 15:00:09
f6c5ba4e-b658-440f-93cc-ef55729e7ec2	SdZwcCgEpZl6Qx1Z9jRF	5219	Eclair	Pastries	3	146.12	2025-08-15 17:36:49	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	miguel.cruz15	2025-08-15 17:36:49
e056aae5-1e02-4f0d-a161-26741a54435a	RsZYyc0u0FtEhb9ONNGp	5221	Flat White	Pastries	3	113.21	2025-06-28 22:33:38	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	rosa.cruz13	2025-06-28 22:33:38
9d781e1a-57f2-430e-9b6e-2dbce0d757e8	ggxKzvgaaR9ah3gzvL3F	5222	Macchiato	Pastries	4	93.97	2025-02-17 09:45:08	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	isabella.delacruz4	2025-02-17 09:45:08
610ab62f-9ec0-4a00-9454-525d81e04712	A0DNHzT4bHoWvOV6wxHm	5229	Almond Croissant	Pastries	5	8.42	2025-09-29 20:48:08	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.delacruz10	2025-09-29 20:48:08
d37c7dd2-b3ec-4a4e-9916-c0d165923125	VfKo5ZXNcVNRiZlzV8Q0	5230	Latte	Pastries	4	108.74	2025-01-12 07:16:18	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	elena.fernandez11	2025-01-12 07:16:18
1965dde1-ee77-498d-b409-c47818c42e50	yQCe9LNjvI4gWIP5T16j	5231	Hot Chocolate	Pastries	2	131.53	2025-10-30 08:51:06	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	rosa.rivera7	2025-10-30 08:51:06
a4e61d41-5eca-4657-8505-75fae66de9cc	jzKkR9h2m54uP1RvhyX6	5233	Macchiato	Pastries	4	93.97	2025-05-02 13:06:47	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	rosa.cruz13	2025-05-02 13:06:47
b39e64c2-4e35-481c-a613-dc2a1c2d05c8	l9MxGAyKPgZE49q0msF5	5234	Macchiato	Pastries	4	93.97	2025-06-22 18:49:58	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	elena.fernandez11	2025-06-22 18:49:58
aa5399e9-6e37-4f13-9216-74cbe17d0f6f	fqQQuOxkt5Bens0X27tw	5236	Baguette	Pastries	5	133.77	2024-12-07 21:44:14	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.reyes9	2024-12-07 21:44:14
5390c08b-49ba-42d8-ae5b-72284e9b5a61	ZbM971mqHCat1kG6o6rD	5237	Hot Chocolate	Pastries	2	131.53	2025-09-24 15:39:28	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905109798	carmen.santos1	2025-09-24 15:39:28
1c40ec99-4ed8-4ed5-a020-0c3122119ab6	zXTJxn078FbAvgpVdoG3	5238	Glazed Donut	Pastries	3	148.75	2025-05-26 07:47:43	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905719055	sofia.reyes9	2025-05-26 07:47:43
8ee3d203-4233-4542-9598-099d9dd812fe	jZIMNRe6HXngHfL1vvBi	5239	Latte	Pastries	2	108.74	2025-02-17 11:57:31	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	elena.torres2	2025-02-17 11:57:31
ff2ee7f1-fcdb-40a8-9bb9-e9fbbb29e0e9	rX8qZmnoA8oAnZpAf0WJ	5241	Cappuccino	Pastries	5	76.25	2025-10-20 12:28:50	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.cruz12	2025-10-20 12:28:50
ae7256ea-428c-4509-8be2-bb3219212488	XXIebKzSTK8yxIkzX8hm	5242	Cappuccino	Pastries	2	76.25	2025-07-26 07:50:53	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	miguel.cruz15	2025-07-26 07:50:53
f0fd1cf7-3062-4c1e-8271-37318ee1c077	PQOmcTat5pXtNswZOout	5244	Glazed Donut	Pastries	1	148.75	2025-04-22 22:28:29	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	isabella.delacruz4	2025-04-22 22:28:29
15f69931-c6dc-46d0-a00d-21a0cfe29ef9	QM6BJPctD2VzVeNB71GZ	5246	Almonds	Pastries	4	5.59	2025-04-18 08:20:35	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.delacruz	2025-04-18 08:20:35
2ff961d6-ec65-42d3-ac0a-fc489c348061	JZmXpByEkirREmRtnYHN	5247	Glazed Donut	Pastries	1	148.75	2025-06-14 18:38:04	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	ana.rivera3	2025-06-14 18:38:04
2081720e-1608-42a7-9a79-6a48a2593417	jzz0juGH9vIzq5ghxuNM	5249	Espresso	Pastries	2	195.76	2025-03-27 12:42:27	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	isabella.delacruz4	2025-03-27 12:42:27
fab2b6e3-6195-4ebc-8f14-81be6319decb	YKIliYRCcHjBujtKC6ZE	5251	Hot Chocolate	Pastries	3	131.53	2025-04-23 11:41:28	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	sofia.bautista5	2025-04-23 11:41:28
02955c92-f105-4979-bdde-c616f1ee7e9d	TqoZoE8Y40cJsWbadxXr	5255	Latte	Pastries	5	108.74	2025-03-29 00:42:54	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905665455	antonio.santos6	2025-03-29 00:42:54
4e7865c0-0d3d-4956-8979-3edc0014a08a	LSWwa71mExROBOySqiHD	5260	Tea	Beverages	5	106.18	2025-01-25 13:35:29	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	rosa.cruz13	2025-01-25 13:35:29
8a638655-41aa-4c75-bd84-079946a73e79	aj6kwickejdQBbWMcDNQ	5265	Cappuccino	Pastries	5	76.25	2025-04-11 08:33:21	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.torres2	2025-04-11 08:33:21
18086d34-7909-4b92-93ae-7bb62c2c993d	WSnNekQbIFbeHMA2ZtZ6	5269	Espresso	Pastries	4	195.76	2025-07-18 23:01:00	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	admin	2025-07-18 23:01:00
6a23c61e-7250-45dc-a3c3-0ec38b3bfe50	gImQEXgAPUQLgD48mqV3	5272	Blueberry Muffin	Pastries	4	185.15	2025-10-08 23:19:27	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905618741	carlos.mendoza	2025-10-08 23:19:27
71575616-2dd1-426b-a7c0-62649d135445	NImTigsMxYC577OIOLY8	5275	Iced Mocha	Pastries	1	144.00	2025-01-03 02:24:59	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905314403	sofia.reyes9	2025-01-03 02:24:59
fe116849-a05d-4e03-8b1c-6fcb6cd0d270	lTq1V3GP0q5pCeDud3u0	5276	Baguette	Pastries	3	133.77	2025-11-23 08:43:32	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.fernandez11	2025-11-23 08:43:32
486942f1-2b66-41e3-8ddb-0ddd6b9ca634	1bBMwqbnGkH3t88RmhDJ	5277	Latte	Pastries	5	108.74	2025-06-22 05:20:37	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905813026	rosa.rivera7	2025-06-22 05:20:37
46fa01a4-d8e0-4af3-bdc3-f78bda1ea01a	t6TIcnHKj4mUPWH5b569	5285	Apple Turnover	Pastries	3	154.54	2025-09-24 19:40:45	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.santos6	2025-09-24 19:40:45
493938df-3b3f-4d59-a910-7b5cb38fc0fa	KOCb58IbvdL96kAhhLd0	5286	Eclair	Pastries	1	146.12	2025-08-04 19:05:31	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	fernando.cruz	2025-08-04 19:05:31
e6ae1216-9ba8-4e90-b6b5-5b489d9a4210	CSvb2L8u3npWmIH0zpmU	5290	Iced Mocha	Pastries	3	144.00	2025-08-08 04:55:14	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carmen.santos1	2025-08-08 04:55:14
da1b5374-dff2-4bed-9a52-c438db74c27a	arSq5nVvK3TZyyn7GNiW	5291	Red Velvet Cake	Pastries	2	187.25	2025-03-23 12:57:53	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905637512	pedro.cruz14	2025-03-23 12:57:53
4f56cafd-235d-410e-a730-428e870fff4f	DICjgAmFgyAR4YKfvPLd	5301	Macchiato	Pastries	5	93.97	2024-12-27 05:06:08	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905839692	carlos.delacruz	2024-12-27 05:06:08
7e89a277-8d64-41ba-871a-3d3adfa9b6a8	x45W5bkXGHRsFGLFvAHW	5302	Mocha	Pastries	3	61.74	2025-05-30 00:38:46	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905588755	carlos.delacruz	2025-05-30 00:38:46
1e8416d9-fe75-4cf0-9a1c-4451272240e6	13PYpThULnsW77b2hpwe	5303	Macchiato	Pastries	3	93.97	2025-08-10 20:46:28	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	miguel.cruz15	2025-08-10 20:46:28
dfa7af54-3668-492f-988a-a98aa9f9ea97	sQNKR1AmKMEVMWaAmLWs	5306	Flat White	Pastries	4	113.21	2025-06-23 20:18:44	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	fernando.cruz	2025-06-23 20:18:44
50baa225-b562-4558-9c6b-992cce61ca7c	jYuWZBUehtoJUVCev1Ow	5315	Tiramisu	Pastries	4	196.55	2025-02-18 15:45:13	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905946816	carmen.santos1	2025-02-18 15:45:13
eda55f88-0460-4905-b487-3d60157e5896	KTyB0e1AZijO63rnaVrm	5318	Cappuccino	Pastries	1	76.25	2025-04-18 03:56:42	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.santos8	2025-04-18 03:56:42
c9508581-258d-4567-9a81-668559d0239d	NJMHmFXKJvpkkKkU5cJi	5326	Chocolate Chip Muffin	Pastries	3	103.79	2024-11-29 16:18:46	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905248029	pedro.cruz14	2024-11-29 16:18:46
f6a43917-7bb3-4978-96ff-4d6d4cd7088d	Px70hDgh5jip1Hdc0Gl9	5327	Tea	Beverages	1	106.18	2025-04-16 06:46:56	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	admin	2025-04-16 06:46:56
4da2cb7a-e2da-48db-8f89-edff09cc9b71	rRTevv5cZDd7jTOUjfPK	5329	Glazed Donut	Pastries	4	148.75	2025-06-28 17:12:29	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905261296	gabriela.mendoza	2025-06-28 17:12:29
4213940e-83db-4e48-a65a-f0420a3edf57	fhwJYwMiblbbimDach6h	5334	Latte	Pastries	1	108.74	2025-04-16 01:16:38	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	isabella.delacruz4	2025-04-16 01:16:38
55ea5e67-99c4-45be-80a6-dafb38fcbfbd	dMEvg7xHJEQsVFAkyNyj	5335	Blueberry Muffin	Pastries	3	185.15	2025-04-16 12:18:39	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	carmen.santos1	2025-04-16 12:18:39
86702984-7123-4c1c-91e0-a015ac1891b3	zKqgPXUp6IsU8BZJZtNq	5340	Cappuccino	Pastries	2	76.25	2025-02-20 11:39:07	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.fernandez11	2025-02-20 11:39:07
057df2b3-7842-49ce-b4b3-3efe56889cb0	Jus9JGjJD4J8gJBd9MfG	5341	Hot Chocolate	Pastries	2	131.53	2025-04-03 00:48:29	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	carlos.mendoza	2025-04-03 00:48:29
cbb1da76-a7b5-4092-8f87-06d3d644f539	N1WestZosdxegXVjCJwA	5344	Espresso	Pastries	4	195.76	2025-02-01 23:16:11	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	ana.rivera3	2025-02-01 23:16:11
78a9303e-5b16-4419-8dbb-37e6e011512a	9ZW8LckLgwu1Gc4tSxQP	5350	Americano	Pastries	3	80.96	2024-12-21 11:55:16	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905347503	sofia.bautista5	2024-12-21 11:55:16
021fa1ee-c15a-4445-a881-43ca9cd6d427	3A31PHMUpXu4aRje5XX9	5351	Tiramisu	Pastries	4	196.55	2025-02-22 15:15:08	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	miguel.cruz15	2025-02-22 15:15:08
42b60c2d-acd8-4c62-b603-3578c266b38d	iH6WcXQesGXxnDOgA6kQ	5352	Hot Chocolate	Pastries	4	131.53	2025-01-04 21:39:21	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	rosa.rivera7	2025-01-04 21:39:21
15341a4d-4d81-4956-9e76-52e1b407f3eb	DqzFcquvjszuTnSzAQah	5357	Latte	Pastries	5	108.74	2025-04-21 04:20:23	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	gabriela.mendoza	2025-04-21 04:20:23
66ea1539-74b5-4741-8f03-f30162aae291	5qTLuQUKgE01uYRJfsV7	5359	Blueberry Muffin	Pastries	2	185.15	2025-06-20 02:15:04	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	isabella.delacruz4	2025-06-20 02:15:04
a220eaed-3e26-4c58-b3f6-cabb6c83330c	eRNKqPBx3YEWo1IpXm3G	5364	Eclair	Pastries	3	146.12	2025-10-15 23:31:27	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905882028	miguel.cruz15	2025-10-15 23:31:27
251cb65b-c1e9-42ea-bef7-d958490285d9	tUFimfthrQkeShnLG7i2	5366	Hot Chocolate	Pastries	1	131.53	2025-11-13 07:50:08	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.fernandez11	2025-11-13 07:50:08
4ca1ee86-c9cb-4fa4-9fc3-24f1cc92c019	H7NjbTEa8b5Hs3GDf9gS	5370	Almond Croissant	Pastries	4	8.42	2025-07-11 08:55:48	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905002100	gabriela.mendoza	2025-07-11 08:55:48
5465cec2-59ab-4775-8f9f-e1138b2c15a9	sAM1pXiNE091dN0hpk2K	5374	Red Velvet Cake	Pastries	1	187.25	2025-04-19 13:17:47	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	rosa.rivera7	2025-04-19 13:17:47
7e735047-8a23-4d11-9fb4-47b03efff2db	icJmzgfZrjeDr28hp0DW	5379	Tiramisu	Pastries	5	196.55	2024-12-04 11:37:14	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.santos6	2024-12-04 11:37:14
f96a671d-c619-4e28-8bb4-0d7a95f61a59	\N	\N	Apple Turnover	Pastries	1	154.54	2025-11-26 22:02:15.267833	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	admin	2025-11-26 22:02:15.267833
cdaf0fe1-fa14-4e27-a5e1-1c169ad50f11	c8Ed1rpll3oEr9tzIEn8	5384	Espresso	Pastries	1	195.76	2025-10-04 11:09:36	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.santos6	2025-10-04 11:09:36
4f8d826c-a4a2-4b71-a3e1-86270ef7d352	rVDpqL9Qi3HSf7pEPLWq	5385	Hot Chocolate	Pastries	3	131.53	2025-05-15 23:42:50	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	pedro.cruz14	2025-05-15 23:42:50
7262874a-3e30-47e5-b86f-da3f525dec25	pPPCJ4ya77UiWc2SamF3	5390	Iced Mocha	Pastries	5	144.00	2024-11-26 20:26:58	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	admin	2024-11-26 20:26:58
13a961ad-6aae-4784-9e53-925f29db70ad	w5XFSY45R15ZIAmussIA	5393	Chai Latte	Pastries	5	100.50	2025-11-23 13:17:44	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	sofia.reyes9	2025-11-23 13:17:44
151329de-25e3-41c8-83e8-bee4bde7b89c	bpCOmIW1GBrL5snccWtZ	5397	Americano	Pastries	1	80.96	2024-12-10 10:57:53	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	isabella.delacruz4	2024-12-10 10:57:53
a8a9740d-6259-43dc-97d6-f1d2ec69259e	TkL3R7xWyWtuc2ExKz2j	5399	Latte	Pastries	1	108.74	2025-07-24 02:13:59	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.mendoza	2025-07-24 02:13:59
956958af-72ce-4ae7-9398-9df97cd6ec9d	lbUPWfWbU2lOmvvewtnH	5400	Chai Latte	Pastries	1	100.50	2025-02-16 16:58:42	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	carlos.cruz12	2025-02-16 16:58:42
5ed6aba4-d41e-41fb-81d8-4a5a8d959cbe	GNKX34s0oLT6hwnp7BID	5402	Iced Coffee	Beverages	1	107.80	2025-04-17 12:08:46	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.santos6	2025-04-17 12:08:46
6ef5f669-146d-4aa5-91c8-bf16902fafcd	GuMVwxnTmKXS7VGsHvRM	5404	Apple Turnover	Pastries	2	154.54	2025-02-24 01:43:39	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905270592	fernando.santos8	2025-02-24 01:43:39
86205a67-7193-4d9a-9a85-7ce30713592d	SdW4HR7ldAPkMdgq3F80	5405	Flat White	Pastries	3	113.21	2025-11-23 13:22:46	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	sofia.bautista5	2025-11-23 13:22:46
ebade1da-61f1-41d4-b75d-6bbba39aba2f	xRCsKOOxjub56mMlmnvE	5407	Hot Chocolate	Pastries	4	131.53	2025-02-12 06:43:15	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905621477	fernando.cruz	2025-02-12 06:43:15
1a9c61cc-e8c1-4167-b332-a246566b5b49	NlkMEPsoY4yeSO4miwai	5409	Tiramisu	Pastries	1	196.55	2025-08-01 00:13:23	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.fernandez11	2025-08-01 00:13:23
5d642a29-9940-4ed7-94c9-b8042d386223	xu9s60vFieElVpa1yK55	5423	Chocolate Chip Muffin	Pastries	5	103.79	2025-10-22 13:41:17	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	elena.torres2	2025-10-22 13:41:17
a7d15770-68c8-42db-91eb-1ce635e049fb	Imv7xeV9SoAsQtgLqoUp	5425	Tea	Beverages	4	106.18	2025-05-07 05:46:28	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	admin	2025-05-07 05:46:28
31dddc7d-6db3-4824-b0f1-8bfa7d20deb9	73X4QC5FMwhUdI78kgtV	5432	Cappuccino	Pastries	1	76.25	2025-03-05 04:16:13	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	isabella.delacruz4	2025-03-05 04:16:13
14916bc4-a40b-45d0-9b3f-8cb302eddb5f	pjjO1CT0tACtMbEIqOZ2	5437	Baguette	Pastries	2	133.77	2025-05-07 15:06:49	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905152697	elena.torres2	2025-05-07 15:06:49
db803001-a74d-461c-8389-1a229c3a6a39	Hho2m4jFE6LiERKKbnLY	5441	Almond Croissant	Pastries	5	8.42	2025-04-27 17:58:02	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905332010	carlos.mendoza	2025-04-27 17:58:02
f6a31d15-996d-4e9a-b866-a583943e3cd4	OZIFtiR2vrMiYAy0R17B	5453	Iced Coffee	Beverages	5	107.80	2025-10-03 00:06:43	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905702773	sofia.reyes9	2025-10-03 00:06:43
a89047fc-b728-4c7b-8a01-e8a3765abc95	jdcATFfWWgRWkPM61kJn	5454	Macchiato	Pastries	3	93.97	2025-05-11 02:07:01	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	elena.fernandez11	2025-05-11 02:07:01
e5f3f775-2737-4d23-94f4-38366f0de3f0	LoBGe8K8jxro2aQQpyMG	5455	Chocolate Chip Muffin	Pastries	5	103.79	2025-07-08 19:51:12	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carmen.santos1	2025-07-08 19:51:12
b0e5429d-597b-4ffb-9bd6-93757bc0c166	c20RpBwj5Z1uYH1xJJDO	5459	Apple Turnover	Pastries	1	154.54	2025-06-12 22:18:16	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	rosa.cruz13	2025-06-12 22:18:16
ee1d61f9-8847-4f90-afe7-7141d469b475	bjyilbs6EIWt5GaZnRz8	5460	Iced Mocha	Pastries	1	144.00	2025-04-25 09:03:38	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905186579	elena.torres2	2025-04-25 09:03:38
fe016601-0c88-499d-aa66-f5df6ed77d59	vPvOXNeSVfFoCijZ8faD	5461	Iced Coffee	Beverages	1	107.80	2025-11-01 01:54:56	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.delacruz10	2025-11-01 01:54:56
551a9e18-3864-4ea4-8563-6e5687994294	4Kw6SlyqpUULs6YdJ7aT	5463	Americano	Pastries	2	80.96	2024-11-25 12:42:50	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	isabella.delacruz4	2024-11-25 12:42:50
75e3e1fa-9449-4e2b-b5c8-eca18bb2e2fe	Bg5lDBdQj635HLCFjMpC	5464	Americano	Pastries	3	80.96	2025-08-15 23:50:20	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905387254	fernando.santos8	2025-08-15 23:50:20
d59171c2-93fb-4144-9919-00209618c960	YUJ90CvH4Wsqic6Txwaj	5473	Baguette	Pastries	5	133.77	2025-09-22 12:53:09	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.delacruz	2025-09-22 12:53:09
da1d1043-2a2e-4dc3-a888-8c96a5628493	tZ4bXPwmrZsWfOkYtAPN	5477	Macchiato	Pastries	5	93.97	2025-07-22 06:07:36	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	sofia.bautista5	2025-07-22 06:07:36
fde67504-9a4c-4da8-9cbd-4406a40daf2a	yg9DJtRsQQzCQVuphV3N	5486	Cappuccino	Pastries	5	76.25	2024-12-08 19:43:30	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.delacruz10	2024-12-08 19:43:30
cd74df35-9361-4246-8bb4-81be2296fbd0	xFvkMJy78QXvbtTqM6bN	5491	Chai Latte	Pastries	5	100.50	2025-11-08 06:00:58	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	fernando.santos8	2025-11-08 06:00:58
533307ab-3ade-43a9-87c1-1ae21c22e386	UkQXdTRlbsrKEyeiKEWD	5495	Apple Turnover	Pastries	5	154.54	2025-09-12 07:28:32	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	pedro.cruz14	2025-09-12 07:28:32
3ba1a37c-b869-43e6-bf26-26a513cf5f9f	KLrKcCJKiHiyah87wh2a	5497	Eclair	Pastries	1	146.12	2025-07-17 02:06:18	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	admin	2025-07-17 02:06:18
645d2dab-7dcb-4820-9d87-ac9e35e06a23	e8fNYhsfspjdvhefIO3b	5505	Espresso	Pastries	2	195.76	2025-09-22 10:34:25	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.rivera7	2025-09-22 10:34:25
381a3f0b-8eef-4ab8-9ec1-bcac720a3e22	Y4cLNiigKa0nBuZIb5V2	5506	Apple Turnover	Pastries	1	154.54	2024-12-12 12:32:13	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.santos6	2024-12-12 12:32:13
b5fa4e00-9943-4adc-b4b7-05df200f2b8c	SdQ4QLLmdTy1AUR0oUuT	5508	Apple Turnover	Pastries	3	154.54	2025-11-18 06:01:31	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905667323	carlos.delacruz	2025-11-18 06:01:31
e77b6eab-9e5e-42dc-9003-778f0a1f1010	9I3SDOluPd031YPAex1E	5510	Tiramisu	Pastries	5	196.55	2025-07-17 03:39:31	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.delacruz10	2025-07-17 03:39:31
40911721-5253-468c-abd5-070c18720127	FLg7OLKckYEGW0dv5bvD	5515	Tea	Beverages	3	106.18	2025-07-28 19:44:22	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	rosa.rivera7	2025-07-28 19:44:22
4a94f778-351f-4515-b5c0-6dd3683edda5	YspR1OYGUZCqzexCtc0v	5519	Americano	Pastries	3	80.96	2025-08-30 17:31:26	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905432496	fernando.santos8	2025-08-30 17:31:26
61de1ada-7972-4a72-8226-3281d16fa83e	503iguWiR64wbwyQpgwM	5521	Americano	Pastries	4	80.96	2025-10-22 02:50:41	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	sofia.reyes9	2025-10-22 02:50:41
d9c49e28-4003-4ff2-a606-d8d25124b8a8	eUfsMYMuzxCs8oivo6IU	5524	Glazed Donut	Pastries	2	148.75	2025-02-13 00:38:49	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905507651	isabella.delacruz4	2025-02-13 00:38:49
5611e8b6-3aeb-4377-bb04-eb7f8c4e474d	N7gHw8pFqVwQSAsxbvcL	5531	Cappuccino	Pastries	2	76.25	2025-09-28 15:59:11	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	admin	2025-09-28 15:59:11
f1ac7796-d674-4239-9399-1e10236f0340	djuUJ4TrGxpHE72XwJOQ	5536	Flat White	Pastries	2	113.21	2025-04-26 18:11:18	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	ana.rivera3	2025-04-26 18:11:18
1011ab68-b82b-4457-9991-e825e4700011	86eaL7UcNvoL5drayJip	5538	Cappuccino	Pastries	4	76.25	2025-03-20 14:31:05	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905914806	rosa.rivera7	2025-03-20 14:31:05
f2dabaaf-4683-47c1-9a7d-1d15467cb108	A1wFJqfz2gXCiyBBm1d2	5551	Mocha	Pastries	3	61.74	2025-02-06 01:12:20	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905544750	sofia.reyes9	2025-02-06 01:12:20
fad7580e-ec69-4975-80cf-2316af2084e6	awFe4jF2m80aNwTiTNo7	5556	Eclair	Pastries	1	146.12	2025-07-26 05:23:27	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.delacruz	2025-07-26 05:23:27
677f33c7-b578-475d-a183-29037e0c833c	fX8jNssj4k8ShKudiQEu	5566	Latte	Pastries	1	108.74	2025-03-13 04:19:52	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	antonio.santos6	2025-03-13 04:19:52
8ea4a12c-5b40-4daa-901a-74557e07010f	6bdj2Ilx1CHgAokJsB11	5568	Iced Mocha	Pastries	2	144.00	2025-05-14 13:48:52	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905114670	gabriela.mendoza	2025-05-14 13:48:52
970a7246-815b-44cf-a327-a56beb39150f	B15NKQDpQ5fagm10lJd4	5569	Iced Mocha	Pastries	1	144.00	2025-08-23 02:13:38	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carmen.santos1	2025-08-23 02:13:38
2f373dc4-d33d-4571-b056-f4b60a1d7145	Ee73kneynBraidj6T14Z	5573	Almonds	Pastries	3	5.59	2025-07-15 18:38:10	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905827975	carmen.santos1	2025-07-15 18:38:10
7f955eed-b4e5-4706-8d41-af452e63b06e	eMqRCV6wriEG3Lg7lKK0	5574	Apple Turnover	Pastries	2	154.54	2025-07-23 11:27:02	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carlos.delacruz	2025-07-23 11:27:02
10cbf620-973f-4e94-a438-855460aea203	wkvVp6WxyyTdTH07UhMz	5583	Mocha	Pastries	3	61.74	2025-11-20 10:07:11	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	rosa.cruz13	2025-11-20 10:07:11
87b34d5b-4521-4daf-945f-df504863c4e0	zXYJ8QjStq5i69r5h9BB	5584	Almonds	Pastries	2	5.59	2025-05-29 10:31:30	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	sofia.reyes9	2025-05-29 10:31:30
eea97589-489f-4a97-a0c6-31677285106c	YLyTdt71CSiIqiLyJFsS	5585	Hot Chocolate	Pastries	3	131.53	2025-01-14 00:04:30	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	antonio.santos6	2025-01-14 00:04:30
377767a6-8135-4fb6-a4ee-9b8b25793d5f	D3e9xqFAloeQ9V180l0L	5588	Almonds	Pastries	3	5.59	2025-03-09 20:37:35	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905465623	antonio.delacruz10	2025-03-09 20:37:35
b9f5c4a6-cbca-4b6f-b3d2-1f35e8b570fc	kRuSBk0VPpLV568hA91c	5590	Apple Turnover	Pastries	2	154.54	2025-02-11 21:50:13	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	isabella.delacruz4	2025-02-11 21:50:13
27440928-c2db-4af4-97bb-d6b34df40caf	2YcAJu1ctgFwo9GBB2gF	5596	Tea	Beverages	3	106.18	2025-10-21 20:55:36	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	fernando.cruz	2025-10-21 20:55:36
60ec68a8-c66e-48ba-b72a-e23546dad8a1	\N	\N	Americano	Beverages	1	80.96	2025-12-16 04:03:02.69975	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	admin	2025-12-16 04:03:02.69975
a38ec051-e387-4a34-ac62-01829e22dff9	fRnpNRZDyPfu7kHZlhWv	5600	Americano	Pastries	3	80.96	2025-05-21 10:25:11	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905859020	isabella.delacruz4	2025-05-21 10:25:11
15b32aa1-347b-4943-80c3-70b7bf54af03	LtJYDXAshQJG8xRy422t	5601	Latte	Pastries	3	108.74	2025-11-15 21:38:32	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905689370	pedro.cruz14	2025-11-15 21:38:32
f0c574bb-a2d7-4fa4-aba5-a75abc291d94	gs2zAZR9ERewJNWxlx6t	5603	Macchiato	Pastries	4	93.97	2025-07-17 04:44:01	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	fernando.santos8	2025-07-17 04:44:01
98f9e4f9-480f-4516-9d89-4202e358e90d	FkwA90xtY8McqYHherdG	5607	Baguette	Pastries	1	133.77	2024-12-27 20:41:13	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	admin	2024-12-27 20:41:13
0a897deb-d5bf-4565-af09-59ea952a5307	BytNK7Q0zRhAdyjroUKy	5608	Latte	Pastries	5	108.74	2025-01-02 19:13:27	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	pedro.cruz14	2025-01-02 19:13:27
1acb8293-b614-4fe4-9131-d08d992ad21d	CQoQNjTF3Qftps3IFC1T	5611	Tea	Beverages	1	106.18	2025-10-21 16:30:35	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	pedro.cruz14	2025-10-21 16:30:35
5f522504-7d55-4ba5-844e-4a14c1c049e9	leQDhJfJmKupLVmX884r	5612	Iced Mocha	Pastries	4	144.00	2025-07-27 09:06:32	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	gabriela.mendoza	2025-07-27 09:06:32
22e2a544-98d2-490c-80a5-0eead5968985	AA83PFQsPNCOYVWq76x0	5617	Cappuccino	Pastries	2	76.25	2025-10-20 02:19:02	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.torres2	2025-10-20 02:19:02
5c2bb645-4148-492e-92ee-5b8843137ebf	5Bae2Cvi3SjiDvpiy3uz	5620	Macchiato	Pastries	2	93.97	2025-07-13 15:40:11	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905928173	pedro.cruz14	2025-07-13 15:40:11
702e3d64-bf87-455f-a855-924485c447f3	AE2ATFUezES97iVyZVnR	5625	Tea	Beverages	5	106.18	2025-03-27 07:19:45	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.delacruz	2025-03-27 07:19:45
026f5eac-f088-4cff-81cb-e2cd1a7524da	6jBM39A9LJ4yAQcEkCWw	5626	Hot Chocolate	Pastries	5	131.53	2025-04-01 22:26:26	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	gabriela.mendoza	2025-04-01 22:26:26
f92b6823-6439-46da-b395-fea1b0ac8a0c	yZU1jAm1dCSzxvtgjje0	5627	Espresso	Pastries	1	195.76	2025-07-09 04:18:00	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	miguel.cruz15	2025-07-09 04:18:00
228a91c3-43d3-4818-b9ff-8d870927cb0a	yzoMPEJxHq1y4mS0erI0	5629	Chocolate Chip Muffin	Pastries	2	103.79	2025-11-01 17:50:58	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.rivera7	2025-11-01 17:50:58
aad0419d-cecb-41ab-a910-14a1d6c7ba3d	I0W51TvNVL55olzIJGM0	5632	Red Velvet Cake	Pastries	2	187.25	2025-04-16 19:38:56	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905543143	elena.fernandez11	2025-04-16 19:38:56
2f6b8cbb-48c2-4914-9481-aba069bbfeeb	Ywb15w6evZe6wIc8RQp6	5634	Chocolate Chip Muffin	Pastries	2	103.79	2025-06-06 16:08:24	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.cruz12	2025-06-06 16:08:24
d1671565-9ea3-4362-9df3-c9c20631ba0b	wmyYTZIPAxL2AM1s8Oli	5644	Macchiato	Pastries	2	93.97	2025-02-10 13:12:57	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.delacruz	2025-02-10 13:12:57
4b662406-a0e2-4716-9035-80540883c9ca	F1JEwDTyF71VDMU8Q3pF	5647	Tea	Beverages	3	106.18	2025-07-16 14:27:04	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905307220	gabriela.mendoza	2025-07-16 14:27:04
4606ff5f-359b-4ac1-99a2-0fa1458a33d7	yZ0HPuePKaR46gMEwGBK	5648	Macchiato	Pastries	5	93.97	2025-04-16 13:00:55	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	sofia.bautista5	2025-04-16 13:00:55
06fd2a40-61ca-4c1e-9b4b-499eee4cf95f	nVsHmCaFGkfRLZuB2hpU	5649	Blueberry Muffin	Pastries	3	185.15	2025-01-25 21:53:38	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carmen.santos1	2025-01-25 21:53:38
2d1676f1-85ff-4ba0-8a26-307ecdaa0e23	LFOkUlR6CfRdHJpZVEEa	5653	Espresso	Pastries	4	195.76	2025-09-29 15:07:30	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.mendoza	2025-09-29 15:07:30
09b0381e-17fc-4aa8-904b-e6672529accc	JI7E1D0hHDZwPlmvZVeH	5654	Mocha	Pastries	3	61.74	2025-08-23 09:03:29	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905067777	fernando.cruz	2025-08-23 09:03:29
0e5c7ac1-a20f-4df1-b2e0-13eafdfb99c0	XGIDMDS0tHqXPysMkJgj	5655	Tea	Beverages	3	106.18	2025-08-02 07:46:38	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	gabriela.mendoza	2025-08-02 07:46:38
082bb13f-0b4f-494d-8d11-41139f56f963	uTeMyssVJ47ZNArGYETe	5660	Americano	Pastries	5	80.96	2024-12-04 12:40:07	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905584517	antonio.santos6	2024-12-04 12:40:07
22830826-36e1-446d-ac1a-59761b5ef14d	uxamYeN4ZRnHWlvKgvy1	5664	Macchiato	Pastries	5	93.97	2025-04-03 01:16:32	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	admin	2025-04-03 01:16:32
25b8dd90-421c-4afb-a871-af239f0fd550	MVb8adEpC1yG176jWNfk	5666	Hot Chocolate	Pastries	5	131.53	2025-06-03 20:55:25	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.delacruz	2025-06-03 20:55:25
c74dd9e9-87a7-44c4-b4ec-640553a712fb	iZyuZyf7NE4jGHbackif	5670	Glazed Donut	Pastries	1	148.75	2024-12-16 13:40:09	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carmen.santos1	2024-12-16 13:40:09
494ea4be-ace7-4839-b43c-a44ae495fb01	A0w9Qml1x2cgrkyjS8mq	5671	Iced Mocha	Pastries	4	144.00	2025-01-10 22:27:06	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905006724	isabella.delacruz4	2025-01-10 22:27:06
56e22a9b-e904-4025-9e47-e7fda06f4f9f	KrwhzRK9kKnVIYMg0Eud	5677	Almond Croissant	Pastries	5	8.42	2025-02-09 20:01:48	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905967593	rosa.rivera7	2025-02-09 20:01:48
259ab814-859f-41cd-91f5-1431616d872a	bqWyq2SWtlXu8OGs77hY	5684	Tiramisu	Pastries	2	196.55	2025-06-06 20:02:55	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	fernando.cruz	2025-06-06 20:02:55
abcd3654-1874-4bb0-a383-6d8303e9d366	mwtYoujkRo6g8lBLrBaW	5693	Tiramisu	Pastries	3	196.55	2025-08-08 13:54:49	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905374330	antonio.delacruz10	2025-08-08 13:54:49
caf6c5be-4aa6-4342-8c9e-1f244f6341e2	qtCDOZg4EXbkvfloe3mc	5695	Hot Chocolate	Pastries	1	131.53	2025-04-19 19:02:45	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905274229	elena.fernandez11	2025-04-19 19:02:45
e36b7400-7c95-431c-a16c-4498e1413493	0xXD4WWiRXSvUAJaxpPV	5696	Macchiato	Pastries	3	93.97	2025-04-28 05:39:01	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	sofia.bautista5	2025-04-28 05:39:01
70ff55e4-986c-463a-a15f-5d76de000e1c	hU50z3dcN03PcmuRe7NM	5699	Flat White	Pastries	5	113.21	2025-05-06 10:26:42	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	fernando.santos8	2025-05-06 10:26:42
9dac347f-82e7-45e8-955a-b832c52c5d6f	ljg3rrFPVu2nuan6xXN5	5701	Red Velvet Cake	Pastries	3	187.25	2025-03-26 19:05:24	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905586545	ana.rivera3	2025-03-26 19:05:24
51647da4-c4f8-47cf-84b0-fcc8970a88ac	bM5R9zW0DEKZ92ZjawDV	5708	Iced Mocha	Pastries	3	144.00	2025-02-02 19:08:56	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.cruz12	2025-02-02 19:08:56
30bcfc2b-2be1-4306-9106-644835e9519f	jBxGmkYF0hoDHChc8nis	5710	Iced Mocha	Pastries	4	144.00	2025-08-19 17:51:58	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	fernando.cruz	2025-08-19 17:51:58
28fac455-03cb-4107-b6ef-864b8e6a92b8	9hB4zZm3ohS2za0Rr7iT	5711	Tiramisu	Pastries	4	196.55	2025-02-23 21:30:25	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.delacruz10	2025-02-23 21:30:25
4ef3eaf1-935c-4cdd-a872-4092700aaba1	wnIu2Xtai14VzVHzIpuD	5715	Tiramisu	Pastries	4	196.55	2025-08-23 14:13:10	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	sofia.reyes9	2025-08-23 14:13:10
9c472c38-510a-4a6d-a636-b34988cac26c	qYBqYFafPGJpXCRyRK7U	5719	Eclair	Pastries	4	146.12	2025-10-12 01:28:01	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905459557	carmen.santos1	2025-10-12 01:28:01
acb24ac0-a0d3-47d5-a6f6-f26d0a9d5e5c	e3rTWDfRS5CvR2LJz0JA	5721	Macchiato	Pastries	4	93.97	2025-09-14 19:48:21	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.delacruz10	2025-09-14 19:48:21
a6203653-fcd8-4168-bcc5-58a8aad44a27	A0EoCA0mfxqefTBEHsXk	5722	Macchiato	Pastries	5	93.97	2025-02-28 06:31:48	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carmen.santos1	2025-02-28 06:31:48
5b2c70d2-13d3-4f5c-9778-27d5767faf1b	k7LA8hCiL59fEl4rnG6J	5723	Almonds	Pastries	2	5.59	2025-01-06 05:58:53	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905275406	pedro.cruz14	2025-01-06 05:58:53
fded0b2c-f87b-4bf1-a285-8a83a6796e3f	bSjlpEQcQVgO8NBqeGNa	5725	Glazed Donut	Pastries	2	148.75	2025-02-02 06:35:30	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905564582	carlos.cruz12	2025-02-02 06:35:30
e1dcc59e-86eb-41ea-8a43-db7749394a46	RKgVKTJDpzTTFRMFh40D	5726	Flat White	Pastries	1	113.21	2025-07-28 16:16:48	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905723189	pedro.cruz14	2025-07-28 16:16:48
ae8bcdd9-e141-4cee-81ca-1272624eb517	v66wsvHaWNwIknhXZ7wY	5729	Tea	Beverages	4	106.18	2025-01-28 22:01:24	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.cruz12	2025-01-28 22:01:24
6a2f906f-e9e3-4ef5-a556-d127a53f3d7a	tCJwirFaLp1vskDwbtIn	5732	Eclair	Pastries	2	146.12	2025-04-25 16:35:15	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905639065	isabella.delacruz4	2025-04-25 16:35:15
dd728a3d-30f1-4dab-a7c1-095d5a636c08	QUj6eq15Numpvq9MEa5M	5733	Glazed Donut	Pastries	5	148.75	2025-10-26 10:35:01	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905489688	sofia.bautista5	2025-10-26 10:35:01
b5f0f9f1-029b-47a2-9f49-f99aaca2ef2b	XVovPwqdv12Iw2qMjXzD	5734	Chocolate Chip Muffin	Pastries	2	103.79	2025-07-23 22:02:16	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	antonio.delacruz10	2025-07-23 22:02:16
6f5b3260-13fb-45af-bd24-97e219a9fae8	ljv4OorwVgJPakiUg9iE	5735	Chocolate Chip Muffin	Pastries	1	103.79	2025-03-15 01:53:01	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	pedro.cruz14	2025-03-15 01:53:01
13cc530d-1e01-488f-b450-4bebb7ab1041	sH0GVQQBNakcVVGUweK1	5737	Flat White	Pastries	3	113.21	2024-12-31 09:52:59	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	isabella.delacruz4	2024-12-31 09:52:59
66d81f29-d427-43dd-ab16-84431a6cfef4	khbCxV3xM9iH7vIHqGBz	5739	Mocha	Pastries	1	61.74	2025-05-27 05:21:15	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905785911	carmen.santos1	2025-05-27 05:21:15
9115a6fe-1733-4794-a1b2-12b7ed6cf11f	ziIXSsfMvJR7J9J6cHWq	5740	Mocha	Pastries	5	61.74	2025-09-09 12:58:12	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905282925	antonio.santos6	2025-09-09 12:58:12
93bc72fb-3fe3-448e-81b3-37c9c504c9aa	LsiVaniw8rTSshtN0iRR	5741	Latte	Pastries	1	108.74	2025-04-06 14:14:08	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.rivera7	2025-04-06 14:14:08
85262960-4a9c-4c3e-b5d5-29c5f1b9bfb3	Ad2dWS9vnCMQKZT2tucZ	5743	Glazed Donut	Pastries	5	148.75	2025-01-22 04:42:00	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	gabriela.mendoza	2025-01-22 04:42:00
93688a46-bb7a-4438-908d-95a1676772f2	BtntKbP00rMuzMpdTgvZ	5745	Cappuccino	Pastries	4	76.25	2025-10-07 14:32:47	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.santos8	2025-10-07 14:32:47
2b0fd81e-a616-4eba-8184-6006c5277069	v2Q2onjPHTgBeHrEJEAr	5746	Iced Coffee	Beverages	4	107.80	2025-01-19 10:20:24	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carmen.santos1	2025-01-19 10:20:24
304df540-932a-4c7b-ad55-5db19299dc33	hs6rNX0gRhH9HVcYSv7P	5748	Tiramisu	Pastries	3	196.55	2025-07-01 04:58:18	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.fernandez11	2025-07-01 04:58:18
dcd8b957-a6c6-4419-918d-ca7582e0f5c9	5CbreeZfDqaxLGJyGViq	5749	Almonds	Pastries	1	5.59	2025-10-30 07:50:43	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905793826	pedro.cruz14	2025-10-30 07:50:43
3d30660a-5151-4e97-a744-8916389bab52	KRRvb3flDyR9CIYZC3FC	5750	Almonds	Pastries	1	5.59	2025-02-20 06:16:20	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905873962	sofia.bautista5	2025-02-20 06:16:20
190ed425-3ce1-46f8-b83c-f7fc136d1428	mMqNeOUGvICgbANATk96	5751	Eclair	Pastries	5	146.12	2025-07-24 22:07:12	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905325909	carmen.santos1	2025-07-24 22:07:12
948da795-b345-477e-b7bf-0093a2c879ff	xFUKyKQTjQzRnOgtmvZx	5752	Blueberry Muffin	Pastries	5	185.15	2025-03-30 08:13:56	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	admin	2025-03-30 08:13:56
c82c3040-2c08-4846-b17f-e64e4391fd83	bQEXjn38wufBJiY2CMh4	5755	Almond Croissant	Pastries	2	8.42	2025-02-28 00:53:54	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	elena.torres2	2025-02-28 00:53:54
e420b33f-b338-4be4-835d-c344323234b5	sk35cKD3hC699lnCDnVg	5756	Chai Latte	Pastries	1	100.50	2025-07-16 01:00:25	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carmen.santos1	2025-07-16 01:00:25
2a6c035d-d5fe-4bcc-9324-4df6b0746abc	PI6ltCWG8JMMVP3tPeLV	5757	Almonds	Pastries	3	5.59	2025-03-23 10:02:50	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2025-03-23 10:02:50
f3fbf2a0-040d-4aed-bcbb-2e30b471df20	DkyjxVn1ErsbABfHAtvb	5765	Latte	Pastries	3	108.74	2025-05-13 18:12:53	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905956905	fernando.cruz	2025-05-13 18:12:53
a8bd96bb-0a16-4a07-950e-3ea703d4d956	o3EUdHa0UP1bfOF7CFpJ	5766	Red Velvet Cake	Pastries	4	187.25	2025-02-04 23:52:56	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.torres2	2025-02-04 23:52:56
0900ea24-d1b3-4bd7-9857-98ff71a8ebbd	cpzAZetNtq1rgRKRxK9C	5769	Red Velvet Cake	Pastries	3	187.25	2025-04-02 22:04:01	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	admin	2025-04-02 22:04:01
9c6e0d6d-4930-40af-8cf6-c90960116de3	m0DnOSILc7SyRyaoPdnH	5770	Cappuccino	Pastries	5	76.25	2025-02-09 03:09:19	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.fernandez11	2025-02-09 03:09:19
72874eba-5349-4bb9-9cee-311044225db1	oQWI4V0syI40YxYLsA69	5772	Blueberry Muffin	Pastries	1	185.15	2025-10-20 23:58:20	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	elena.fernandez11	2025-10-20 23:58:20
3c1d0d9d-0be2-4503-97f3-014f9b73f475	3H1MVhQiCbSv2iCALqXn	5774	Iced Coffee	Beverages	1	107.80	2025-04-30 14:44:09	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	rosa.rivera7	2025-04-30 14:44:09
31a291bb-5a2c-4880-a7f0-6f5e01f8a9db	QbZNnKgGr7yFouzbnFsY	5775	Espresso	Pastries	5	195.76	2025-07-21 00:15:11	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905077738	elena.fernandez11	2025-07-21 00:15:11
b267a5ea-90ef-4a65-a2aa-a02855c7956e	sVo0OZ3TKqodIuFtUzAB	5776	Macchiato	Pastries	2	93.97	2025-05-01 10:04:58	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	elena.torres2	2025-05-01 10:04:58
a2abb94c-2d7d-499c-a9e1-564bbe17ab35	UDktmk274FmWE1b3AqYe	5777	Macchiato	Pastries	1	93.97	2025-02-28 01:31:29	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905693603	carlos.cruz12	2025-02-28 01:31:29
e1508272-1333-4e41-af1f-2c6bc25e7d6f	f0Ak4qRbaxkmB9f6LVx7	5778	Red Velvet Cake	Pastries	1	187.25	2025-03-19 15:56:31	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carmen.santos1	2025-03-19 15:56:31
065b94d1-097a-4d9d-ac2b-425938dc1c07	YAhGuJP0bFCXxsM7omh0	5782	Blueberry Muffin	Pastries	5	185.15	2025-03-10 18:40:40	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905503528	carlos.mendoza	2025-03-10 18:40:40
6aaab138-67a8-4b2c-bcfc-02e0e353c75e	k847RjvzHg037A7ylczY	5783	Tea	Beverages	4	106.18	2025-08-29 04:06:30	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	rosa.rivera7	2025-08-29 04:06:30
2d6d8808-ba23-4a1a-8da9-1a7e0471b7f1	KBTZYAmt7syqQsPfJz0m	5787	Iced Coffee	Beverages	4	107.80	2025-02-23 21:08:23	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.delacruz	2025-02-23 21:08:23
78b5d468-28ae-46ab-9af7-b40157035aee	O7WAy7Kqwzqr3ErBuEOh	5797	Red Velvet Cake	Pastries	5	187.25	2025-04-17 18:15:33	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905100102	fernando.santos8	2025-04-17 18:15:33
a1eaaad5-4e87-4e11-be57-d6ca819f2807	Sq77BThLBxspp4p98glR	5805	Latte	Pastries	3	108.74	2024-12-13 03:16:18	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.delacruz	2024-12-13 03:16:18
21c35265-add2-4f00-8cfb-5ce03c4dd880	BOhGBgwXstCcAiY6vVF5	5809	Americano	Pastries	4	80.96	2024-12-05 00:04:42	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carlos.cruz12	2024-12-05 00:04:42
0bb0c4bf-9b06-4eaa-87e2-350e999622f9	JMNnDlmgrho4p0cUPG0U	5813	Espresso	Pastries	1	195.76	2025-07-18 01:29:54	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905349993	rosa.cruz13	2025-07-18 01:29:54
c3ff0427-16d0-4b89-bfd2-c2e91305182e	Gq0QTW4zaVxrvbjZGRWC	5815	Red Velvet Cake	Pastries	3	187.25	2024-12-19 18:36:08	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	sofia.reyes9	2024-12-19 18:36:08
c5a8a234-85e1-4354-8a38-8b6cd168e5f4	B58NJrI0US1euMK8LOYm	5816	Iced Mocha	Pastries	1	144.00	2025-04-18 23:05:36	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carmen.santos1	2025-04-18 23:05:36
428c4324-cd38-4605-acb0-796ed22a9d5d	oU5V2YtCFJnkipFVzboj	5817	Eclair	Pastries	5	146.12	2025-05-12 16:33:37	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carmen.santos1	2025-05-12 16:33:37
cf2eae95-b44e-4a76-9041-7e3e6f3c72b0	LVAy9pM50F4mrKE0hV6W	5820	Iced Coffee	Beverages	5	107.80	2025-03-01 09:35:50	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.delacruz10	2025-03-01 09:35:50
25da4528-acc7-4e24-b199-f39845bc38bc	FFCkuV0hauQeY0fxPOBv	5823	Apple Turnover	Pastries	3	154.54	2025-04-19 09:53:14	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	admin	2025-04-19 09:53:14
fb4fdcfd-966d-49ed-b9c4-4915c9e2926b	uBB3Bh2FTOVa3GJphQlA	5824	Hot Chocolate	Pastries	2	131.53	2024-12-20 01:35:47	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	isabella.delacruz4	2024-12-20 01:35:47
c4e3857a-02de-43c6-9f9c-b2937601cb52	uFK4LcubUAtmqZ7Ihc4U	5826	Americano	Pastries	5	80.96	2025-08-02 00:35:45	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905400274	carmen.santos1	2025-08-02 00:35:45
adaa1e82-d2c0-43c6-865b-9148e857cfd9	8prwT0eqS7gTCoGl101v	5828	Iced Mocha	Pastries	3	144.00	2025-05-15 20:26:47	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905529605	antonio.delacruz10	2025-05-15 20:26:47
e56502b4-ca9e-440c-9ae8-cc1e3682226c	CemoOibhPX0nm59uEKe5	5829	Macchiato	Pastries	2	93.97	2025-02-09 02:01:58	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.cruz12	2025-02-09 02:01:58
6920d4c5-a05e-4ba5-961a-114f72a85532	PRLuAwZVXJdJ0U5yuURJ	5838	Iced Coffee	Beverages	3	107.80	2025-04-19 13:00:01	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	ana.rivera3	2025-04-19 13:00:01
20926720-ef81-4d9d-865f-14b8f246ac01	ZPsRgsAW5iFgSyy4yshW	5840	Red Velvet Cake	Pastries	3	187.25	2025-01-03 14:54:53	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.delacruz	2025-01-03 14:54:53
da7c8afc-1c05-45ae-8474-a73a504d4d17	ltYoCSmRsua52cRVJwCF	5841	Almond Croissant	Pastries	5	8.42	2025-08-25 13:10:17	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905415081	sofia.bautista5	2025-08-25 13:10:17
98d17d59-74b8-4db7-b4bb-a6e53ae78fed	pMN81dWqOJ0fvSer64j0	5842	Almonds	Pastries	1	5.59	2025-05-13 09:00:17	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.mendoza	2025-05-13 09:00:17
42c977bc-e2d4-4d9c-9150-aaa93e7d74f6	pbQdoykpLxpAplCbQS7O	5843	Cappuccino	Pastries	4	76.25	2025-01-13 14:12:07	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	isabella.delacruz4	2025-01-13 14:12:07
b61219d3-bb09-45f7-b0d4-acfaa565c3a5	0LIruutHGsolgWpG27gY	5846	Hot Chocolate	Pastries	1	131.53	2024-11-24 23:37:54	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	pedro.cruz14	2024-11-24 23:37:54
fe647ca9-f5e1-4821-9699-96c7c20cc01b	YMlnPe7xZJLH7JsqGhxv	5847	Eclair	Pastries	3	146.12	2024-11-30 00:09:24	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905476865	rosa.rivera7	2024-11-30 00:09:24
00f64200-aef3-4cb1-a833-1de03243cc90	X1VQyXk2bBOKJy9IVaVW	5848	Latte	Pastries	2	108.74	2025-02-06 02:52:54	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.rivera7	2025-02-06 02:52:54
2a0462e9-23b5-4b01-b7f3-40df516d2435	Daki8onDKGhz2bFgBDWR	5851	Hot Chocolate	Pastries	4	131.53	2025-10-13 04:18:11	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905991897	antonio.santos6	2025-10-13 04:18:11
4b239ed9-c1b9-402c-88e5-f3bbb570f8e7	Z6vuZYk2uTKZhrKHAprU	5856	Iced Coffee	Beverages	5	107.80	2025-01-14 15:29:48	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.santos8	2025-01-14 15:29:48
b5c97770-231e-48ec-b04c-dc39b47a3880	Ol4kofwehjqQ6MmFTSog	5857	Apple Turnover	Pastries	2	154.54	2025-04-22 20:05:01	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	miguel.cruz15	2025-04-22 20:05:01
26f9a7a6-e69c-4e35-b9f9-224a9b89f912	pF83qzuhA3mHNSkgbwsm	5858	Baguette	Pastries	4	133.77	2025-08-21 17:19:11	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905526460	antonio.delacruz10	2025-08-21 17:19:11
c9e789dd-6a0e-48b4-9397-ea3e09686e4a	XSM1aUun8uSPPy5Ch8cS	5862	Macchiato	Pastries	3	93.97	2025-10-22 15:22:20	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	gabriela.mendoza	2025-10-22 15:22:20
c19aa115-b1e8-4dbe-93d1-7d3c4c8721bd	bqMETKPqd0tT5I0fDIb6	5863	Flat White	Pastries	3	113.21	2025-05-15 14:05:54	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	fernando.santos8	2025-05-15 14:05:54
22a5bf2b-20dc-4861-b72c-364a733712f7	Qmc65wE8EZaBDrkzyfEG	5867	Chai Latte	Pastries	4	100.50	2025-04-06 22:18:04	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carmen.santos1	2025-04-06 22:18:04
8de78d74-b60f-41d0-a894-172d0ae20293	KGgGz37tWWru8ZQp4ZRK	5868	Eclair	Pastries	1	146.12	2025-09-02 02:22:53	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	rosa.cruz13	2025-09-02 02:22:53
4efde438-26c7-42d7-9fb1-36485633d712	U7RWAwZo8YBSC1RZve7N	5871	Hot Chocolate	Pastries	1	131.53	2024-11-26 22:49:51	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	rosa.cruz13	2024-11-26 22:49:51
59d95937-b504-4b8b-8714-8452b992374f	f9A1Adx79JrgDNAnO8SP	5876	Americano	Pastries	1	80.96	2025-09-01 17:25:53	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	fernando.cruz	2025-09-01 17:25:53
ec6a0732-8f05-44be-8b53-a668dcfad28b	JJrqSjSjb0yUn1mVorBr	5877	Apple Turnover	Pastries	5	154.54	2025-10-02 15:07:58	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carlos.cruz12	2025-10-02 15:07:58
c11773e5-9dd2-4524-acb7-b769d837619f	0hIKz74IuJ5eOQuxiu7o	5886	Chai Latte	Pastries	4	100.50	2024-12-27 18:38:01	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	admin	2024-12-27 18:38:01
4a50e84f-24cb-44d2-b47e-0f5193b88067	hdVyPw5ao5b5NepVk25s	5887	Almonds	Pastries	3	5.59	2025-09-09 19:00:10	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	antonio.santos6	2025-09-09 19:00:10
4171dd21-bdd7-4a07-8c9c-5f5128693d1f	8c8MknJtQ1jlgG15VhQ8	5888	Blueberry Muffin	Pastries	2	185.15	2025-03-17 22:19:31	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	ana.rivera3	2025-03-17 22:19:31
bf016397-cb40-4388-937d-cfc3b10946e3	pG0vD0K4Zg5C1aWIs02N	5891	Almond Croissant	Pastries	2	8.42	2025-06-29 05:50:05	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905535584	pedro.cruz14	2025-06-29 05:50:05
4160489c-ff8d-46ba-9530-8820cea7463e	FZ3ha6IWqcDSPQrT4juh	5893	Almonds	Pastries	3	5.59	2025-11-21 10:09:41	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.cruz12	2025-11-21 10:09:41
3b1f5f14-dab4-4c25-a604-a37abf36f743	LQya786GBN7SEECDyjm2	5895	Chai Latte	Pastries	4	100.50	2025-08-24 09:14:25	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905583266	rosa.rivera7	2025-08-24 09:14:25
b0bd68de-d1ae-40ed-80fa-b5b3a2691ca6	toozqynLlZevnl67WOOI	5898	Americano	Pastries	4	80.96	2024-12-27 02:42:28	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	antonio.delacruz10	2024-12-27 02:42:28
41542492-352b-424f-9b64-8a38348dbd89	nyVEi402q6j5EfCdp90J	5899	Americano	Pastries	5	80.96	2025-03-04 07:52:19	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	gabriela.mendoza	2025-03-04 07:52:19
20305938-a317-4f41-9dac-ff0f4cd75716	kOKu9q0n7i5BWHasPEsr	5906	Glazed Donut	Pastries	5	148.75	2025-05-28 13:44:22	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	isabella.delacruz4	2025-05-28 13:44:22
f9f50495-347f-4acd-bc20-d4029d7b64e1	2Z93dJz7WMfeNBQB0ASB	5907	Blueberry Muffin	Pastries	3	185.15	2025-04-23 00:53:50	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	elena.torres2	2025-04-23 00:53:50
c0adb63b-cdd8-4828-810a-ac90f53cc46b	SBieSUelce6YoKR7IYWe	5909	Apple Turnover	Pastries	1	154.54	2025-04-25 12:34:41	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	ana.rivera3	2025-04-25 12:34:41
510ff800-4593-432a-b174-80a17bf305d3	keurC5Syh26kV3vXGLCn	5911	Blueberry Muffin	Pastries	5	185.15	2025-10-08 08:49:30	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905490385	carlos.mendoza	2025-10-08 08:49:30
283dd2e3-ac7e-4989-9967-3c4b042e7868	neGl5MJrgSpZjs8zRayY	5914	Red Velvet Cake	Pastries	5	187.25	2025-10-26 07:53:19	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905581884	miguel.cruz15	2025-10-26 07:53:19
742707a8-f616-473b-96db-8796f8bc13cf	13dvqgioc6naitMPvsVX	5915	Tiramisu	Pastries	1	196.55	2025-10-17 10:41:13	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	sofia.bautista5	2025-10-17 10:41:13
86d666d8-5f8b-4398-9e76-b4a595da9a51	FGn1Q6GGx7kpE1zVtC04	5916	Glazed Donut	Pastries	4	148.75	2025-03-05 02:20:42	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905270071	gabriela.mendoza	2025-03-05 02:20:42
b2e07c7e-600d-41e6-ab59-7fb6d3d61a8a	zGNP4Du8x9x0LnWDnuMH	5918	Blueberry Muffin	Pastries	2	185.15	2025-07-24 07:28:46	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905668272	carlos.mendoza	2025-07-24 07:28:46
4ad06fdd-6182-4aac-8544-94cb430058af	TW3yOpmzvfYn2OH1NxqA	5919	Mocha	Pastries	2	61.74	2025-09-14 21:41:03	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905824545	fernando.cruz	2025-09-14 21:41:03
eb909bd4-7b91-47a5-928d-927b222cc1c6	Qj3Uxse7VdwBurnWBxQI	5921	Baguette	Pastries	3	133.77	2025-03-21 02:59:24	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	ana.rivera3	2025-03-21 02:59:24
ffc06b01-32ae-4d3a-82ac-0924d5b5eb92	XaHkVKLcN5SRqBxuBuxE	5923	Apple Turnover	Pastries	4	154.54	2025-07-17 07:32:42	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905785610	elena.torres2	2025-07-17 07:32:42
d76c89e1-fbfd-4022-a4df-1ee30de99d9f	NUbFi3R4a1IKg5oPF6Wm	5924	Almond Croissant	Pastries	2	8.42	2025-09-15 03:30:48	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.mendoza	2025-09-15 03:30:48
576e12b1-50ab-4941-a540-53ce94e136f2	0OgVVmh8ErQZkUlrgrcy	5927	Apple Turnover	Pastries	4	154.54	2025-01-16 05:15:10	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	sofia.reyes9	2025-01-16 05:15:10
e1c34cb7-77d0-4dc4-90ea-a506536bc302	ebuE8R2Ue6BR35QiIarW	5928	Macchiato	Pastries	1	93.97	2025-01-10 06:44:57	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905747442	sofia.bautista5	2025-01-10 06:44:57
625d7691-127e-4257-af31-924a9fe8a0e7	evTgkybV0YULGdeCl2T8	5929	Baguette	Pastries	3	133.77	2025-01-26 20:06:26	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905910251	miguel.cruz15	2025-01-26 20:06:26
2d91f402-dc41-4370-8a0e-fafe2de03dba	kd6hC0r821nuJwEHkd3U	5932	Hot Chocolate	Pastries	1	131.53	2025-09-25 08:43:29	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	sofia.bautista5	2025-09-25 08:43:29
ec90575e-c2c0-4ee1-8e14-23f64fa308f7	6xbcO5KpFLk3aMAW9KyB	5935	Almonds	Pastries	3	5.59	2025-08-26 14:45:09	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	antonio.santos6	2025-08-26 14:45:09
c028a214-86a6-4a71-bdea-c98ec7917687	cGAKicDzDEwaegPkGoRz	5938	Chocolate Chip Muffin	Pastries	4	103.79	2025-10-16 04:34:19	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	fernando.santos8	2025-10-16 04:34:19
6eaa7e9b-4d89-4c19-8c1c-a829099d952e	Cdwcda8IXPYfD8l4QrI1	5939	Chocolate Chip Muffin	Pastries	1	103.79	2025-10-30 14:43:48	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905197446	carlos.delacruz	2025-10-30 14:43:48
3af0b7bc-387e-4343-bdb2-5080bf801949	zQmiwsjCesmMyOTbx62t	5940	Tiramisu	Pastries	5	196.55	2025-07-31 10:51:24	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	rosa.cruz13	2025-07-31 10:51:24
003be883-24da-47c9-b9d9-d783bcaf21bd	uff4fsUqwLwYN6doZHBh	5941	Tiramisu	Pastries	2	196.55	2025-08-22 01:29:00	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.mendoza	2025-08-22 01:29:00
90218bc8-648c-4908-831a-ffc9297f3e8c	tuNueVPYBAOztmCgRqfm	5946	Chai Latte	Pastries	1	100.50	2025-03-01 21:42:44	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	admin	2025-03-01 21:42:44
48e372e5-a767-4ff8-b8d5-701bf844cece	GxZEc2h59Kfex61FmQUC	5948	Apple Turnover	Pastries	2	154.54	2025-01-24 00:16:44	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.santos6	2025-01-24 00:16:44
b34729ac-8b37-4a61-8c71-1a0d501829f7	7fOYWorf1l1Thi0rpe2J	5950	Chai Latte	Pastries	4	100.50	2025-08-30 18:31:46	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carlos.cruz12	2025-08-30 18:31:46
72c6aba5-7df8-4311-b8f7-7d7e35f1a50c	bSFfMagaaJCwlVa5HP5p	5951	Tea	Beverages	2	106.18	2025-05-31 16:13:33	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	pedro.cruz14	2025-05-31 16:13:33
c25d35b1-8a4d-4197-8941-ba6c5f800e3d	FcIOQdJHUWaqtzdNizaR	5952	Chocolate Chip Muffin	Pastries	4	103.79	2025-03-25 17:23:00	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	antonio.delacruz10	2025-03-25 17:23:00
db75e803-f110-447d-aa6f-591facfa50b7	BMz0pVf3pIQaPDp180oC	5954	Latte	Pastries	3	108.74	2025-05-02 22:40:38	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.rivera7	2025-05-02 22:40:38
3eaeafe1-0322-4441-84e6-143598df32bf	aEgnTbu7TRdBTELybeEM	5959	Mocha	Pastries	5	61.74	2025-06-05 12:44:00	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905339012	admin	2025-06-05 12:44:00
7c333422-3361-4b86-8e8b-0c1de5e669e6	I8ume0SwMyI7MyAw2exL	5960	Tea	Beverages	3	106.18	2025-01-28 07:00:54	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	miguel.cruz15	2025-01-28 07:00:54
8de8d6dd-a7bb-4197-b2a1-3bd33c773ca8	krIhDQlnas4l06qCAgeZ	5961	Iced Mocha	Pastries	2	144.00	2025-05-22 19:41:46	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	sofia.reyes9	2025-05-22 19:41:46
76cd0f2c-dbd0-4bba-ac19-310ab34f9294	SMNT1KTSpgA6qF7J8nzu	5964	Iced Coffee	Beverages	2	107.80	2025-03-28 23:51:39	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	miguel.cruz15	2025-03-28 23:51:39
53b362b3-3749-4e42-b731-806077f58865	mhPbT2I71qO4NIoE4nG7	5969	Latte	Pastries	5	108.74	2025-01-29 07:33:54	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	antonio.santos6	2025-01-29 07:33:54
5874f192-a4fd-495a-a51e-08e4d490b161	SZ5yxeOD6XNlV4aPWN2k	5970	Tiramisu	Pastries	2	196.55	2025-07-23 09:41:07	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	rosa.rivera7	2025-07-23 09:41:07
10de2dd1-6b34-4e95-83cd-d7c587116f3e	JIX6t9nW3pcatjIsxayj	5971	Hot Chocolate	Pastries	2	131.53	2025-02-11 19:59:44	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905575374	pedro.cruz14	2025-02-11 19:59:44
fe63e60c-7bda-4067-8455-cde2f2c6b92f	fMYSTG8GyidlqwFLFoVi	5972	Cappuccino	Pastries	4	76.25	2025-01-27 15:00:31	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905447342	ana.rivera3	2025-01-27 15:00:31
dd2d26fd-ed39-4312-b0c1-9826803d75e5	P02q9CIUsnX71EYWvjTW	5975	Chai Latte	Pastries	4	100.50	2025-10-31 00:57:53	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carlos.delacruz	2025-10-31 00:57:53
8bd9a587-b700-4484-bbfb-e3a4ac00c0bb	r33BWA4iepaycbY1ISX2	5983	Tea	Beverages	4	106.18	2025-09-13 10:25:45	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carmen.santos1	2025-09-13 10:25:45
48b83cd3-e98d-4abc-898c-a8d5f1cdde7b	Syo015j3Hx9pfO9oB1Je	5984	Chocolate Chip Muffin	Pastries	3	103.79	2025-06-30 15:21:04	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	sofia.reyes9	2025-06-30 15:21:04
39ca88a7-8111-4212-a38a-17d349362d8e	elfSQ7bKsmRPI9Q0hOV9	5985	Almonds	Pastries	2	5.59	2025-01-24 14:59:44	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	carmen.santos1	2025-01-24 14:59:44
90230d42-1101-46ee-b6cb-199086a05dff	oV87PORz422RCxwDmKcg	5987	Apple Turnover	Pastries	2	154.54	2025-03-22 19:13:47	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.delacruz10	2025-03-22 19:13:47
1534473c-2d31-44b0-bb58-8323160ef933	n6eGGdAlZr0MKSOAupEM	5992	Iced Mocha	Pastries	1	144.00	2025-06-28 12:03:50	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905018553	miguel.cruz15	2025-06-28 12:03:50
c282d058-23da-4f63-9de7-1c68d36eb186	Dztx7wYWQbWHMYXsa6X9	5995	Blueberry Muffin	Pastries	3	185.15	2025-10-27 18:13:17	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.santos6	2025-10-27 18:13:17
d7226137-f263-4568-b98c-9825771aed1e	OQ6dYZ2Ja4zaXesLtfjI	5998	Cappuccino	Pastries	3	76.25	2024-11-30 13:49:40	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905719795	sofia.reyes9	2024-11-30 13:49:40
c0602373-1bd4-4699-a141-5754a81b8324	iQX8YNwcIEzdHijgqc9d	6008	Baguette	Pastries	4	133.77	2025-07-19 10:37:30	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905070885	elena.torres2	2025-07-19 10:37:30
e29f51c3-1594-4ba9-8342-ea02ab45e41c	42pkwAY7PCrYh6RQy7aU	6009	Espresso	Pastries	3	195.76	2025-04-26 01:34:30	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.cruz13	2025-04-26 01:34:30
27cd7fef-88c8-45e7-b268-a831c77dcb1e	Cw7HJgQHKqptVpqV6q0V	6011	Iced Mocha	Pastries	4	144.00	2025-03-21 05:56:24	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905455069	fernando.santos8	2025-03-21 05:56:24
09ff63cd-3bbe-4e51-b060-2632758e556b	mtLivuIz1QS1lWvZeOWl	6017	Tea	Beverages	2	106.18	2025-02-25 22:39:00	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	ana.rivera3	2025-02-25 22:39:00
84b21e79-bb74-4b1e-84da-9ba47138f58c	pvz9mBm5tDwdm4DIi3at	6019	Chai Latte	Pastries	2	100.50	2025-09-14 21:40:49	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905482502	rosa.rivera7	2025-09-14 21:40:49
ba4bec93-2efc-469a-8cfa-c3c94f980f54	JzERkhWqPvQoDUkFPEuP	6021	Espresso	Pastries	5	195.76	2025-10-07 04:04:59	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	pedro.cruz14	2025-10-07 04:04:59
c94e8a5a-870f-469f-b528-e9426e9cd4fd	hxfYXNXofCE62ELtSvGj	6029	Glazed Donut	Pastries	1	148.75	2025-05-04 11:42:42	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	antonio.santos6	2025-05-04 11:42:42
d3643f50-202d-4beb-ae01-81ee571450fe	yKPisrSWB38EUyU4DL2T	6033	Latte	Pastries	4	108.74	2025-05-23 10:49:01	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carmen.santos1	2025-05-23 10:49:01
413eb78d-1bf8-477c-a118-642bec6c82da	zaNCQe5PkE6m1RiDG6Ii	6037	Espresso	Pastries	3	195.76	2025-05-15 15:28:28	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	gabriela.mendoza	2025-05-15 15:28:28
0146686b-a276-4149-8b6d-ae4f323266bd	4tKWw42kKcgFYsup4LaF	6042	Latte	Pastries	3	108.74	2025-03-02 19:13:50	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905718457	isabella.delacruz4	2025-03-02 19:13:50
14e0476d-5a61-4eca-a6e2-5a272c98a5b3	07SthTT7YOwmm9K06qj0	6045	Flat White	Pastries	3	113.21	2025-04-01 02:35:12	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.mendoza	2025-04-01 02:35:12
ba754164-5e5e-4947-ba64-c1249ef22781	T4cAS7ZOoAtcT82C1NjY	6049	Blueberry Muffin	Pastries	1	185.15	2025-03-04 02:45:47	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905991698	carmen.santos1	2025-03-04 02:45:47
fd5c1e66-f71e-4e37-8b56-3e5c1183eea7	TmtjyMVMK7aJiY7rZJtw	6051	Tiramisu	Pastries	1	196.55	2025-02-05 04:49:44	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.santos6	2025-02-05 04:49:44
9a8c4cc2-8bde-45fb-bfc3-956de4dff5e0	i01MM6KT4EL6KSnOBbas	6052	Glazed Donut	Pastries	3	148.75	2025-04-16 13:20:13	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.bautista5	2025-04-16 13:20:13
f188e525-12c1-4c47-b01e-32815aed1406	SMhqk4YgD5uYNoe6VVOv	6053	Flat White	Pastries	2	113.21	2025-11-05 18:11:03	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carmen.santos1	2025-11-05 18:11:03
22af425d-a2b0-4300-99a6-3de2ef07616c	ZyVgUMg67iIbPBEVOE3j	6055	Blueberry Muffin	Pastries	4	185.15	2025-07-29 13:55:58	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.delacruz10	2025-07-29 13:55:58
53455f99-c868-417d-be1a-8aa2fd087075	Pl0qWrm6stCl7e94nhJX	6057	Americano	Pastries	4	80.96	2025-01-09 14:12:03	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	antonio.santos6	2025-01-09 14:12:03
9320c865-a344-4b60-a23a-8403429b6c10	R8rghAtnxMS9HR1eTZh8	6058	Macchiato	Pastries	4	93.97	2025-10-31 01:54:51	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905762418	rosa.rivera7	2025-10-31 01:54:51
fc4d65da-7810-41d2-a463-530d4c3cdef7	Ek27l07UDDXUYNt6oHmG	6061	Blueberry Muffin	Pastries	3	185.15	2025-07-10 10:45:07	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.santos8	2025-07-10 10:45:07
e18c3c13-7473-4447-a870-f56bcdc82365	sgkQ6ogfQ9uMlNFQga3j	6066	Almond Croissant	Pastries	3	8.42	2024-12-17 21:00:52	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	gabriela.mendoza	2024-12-17 21:00:52
ce4b6720-63f4-4342-887e-29bc35d42b6f	dxmWSwHq4JrhhMDf5HVH	6070	Latte	Pastries	2	108.74	2025-05-13 23:56:10	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905122885	antonio.santos6	2025-05-13 23:56:10
c6c719cd-d7f0-4955-a887-ae28ade09b01	xsi2vpMBy1VcoGlUlhtZ	6072	Tea	Beverages	2	106.18	2025-09-26 02:50:37	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	antonio.delacruz10	2025-09-26 02:50:37
d3c07358-c324-4f8e-97b3-6a18ebad6d23	uIfVLmwPoQpCZD1lDqwR	6077	Hot Chocolate	Pastries	1	131.53	2025-03-27 20:30:19	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.fernandez11	2025-03-27 20:30:19
21f99143-4296-4d4d-8152-951a60b8168d	9247oDmHV4BR5Noc8SkV	6078	Iced Coffee	Beverages	4	107.80	2024-12-31 06:20:28	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	pedro.cruz14	2024-12-31 06:20:28
98deda84-8727-4e69-9708-924ddeb9fbc5	tbd4hZafGj7Fg3iJNjjG	6079	Mocha	Pastries	4	61.74	2025-01-06 23:44:16	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	pedro.cruz14	2025-01-06 23:44:16
1a07f64f-2224-4a8b-8185-e151a8357a96	YPPxKt9JnMiClI8cMNUE	6080	Almond Croissant	Pastries	2	8.42	2025-11-07 10:53:57	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905769461	carmen.santos1	2025-11-07 10:53:57
530bedca-8fed-47ef-a9e6-8bfec0c99b66	W7EXdWsgimo2VRHgjByy	6081	Apple Turnover	Pastries	3	154.54	2025-01-29 19:29:08	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905789515	pedro.cruz14	2025-01-29 19:29:08
b31c9ee1-05c0-4796-8d59-1b44649584d7	wA8pWLiXjDsRWEkxDzH3	6087	Chai Latte	Pastries	2	100.50	2025-11-12 03:19:06	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	fernando.cruz	2025-11-12 03:19:06
42feecca-7608-4220-87bc-1aeb1836d221	C7fECk8xALh5hxdDiIuq	6091	Flat White	Pastries	1	113.21	2025-10-26 06:47:34	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	ana.rivera3	2025-10-26 06:47:34
bdd54e02-9bd4-439f-bc4d-8c5dcf7c63ea	DunQsI5JIKQJoMYV5gkr	6093	Glazed Donut	Pastries	4	148.75	2025-03-12 05:08:35	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.delacruz	2025-03-12 05:08:35
c9814e1b-fec5-48e3-9975-44e3f5dd2b91	hQ3GGMClEa62DqmhcC3H	6095	Latte	Pastries	2	108.74	2025-06-07 06:35:27	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carmen.santos1	2025-06-07 06:35:27
3a147cc4-2632-456b-b89e-22d3ef0e4419	GKShj1QajZ03u4iRTKRd	6096	Tiramisu	Pastries	2	196.55	2025-03-13 19:29:00	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905459409	antonio.delacruz10	2025-03-13 19:29:00
7c7cdf66-6525-4e3b-8d0d-1d5cfb480a14	5T5TpKYGwrX6vmmpC1vj	6102	Hot Chocolate	Pastries	1	131.53	2025-10-21 03:51:23	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	rosa.rivera7	2025-10-21 03:51:23
47382343-f6a6-4082-8140-2f2317d4d6ae	zi2NOQStEi8sW15hRCxU	6103	Apple Turnover	Pastries	5	154.54	2025-02-24 00:55:55	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.fernandez11	2025-02-24 00:55:55
eed37212-01c4-4d94-8ecb-60247043f86d	qHYp8qjS1xdgeOUZnNdj	6106	Chocolate Chip Muffin	Pastries	4	103.79	2025-08-20 01:20:55	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	ana.rivera3	2025-08-20 01:20:55
bfc4331a-13fa-4b5f-a0ad-fcd0b6ee6399	41nyRBZPk4WyE8F3gqQv	6108	Tea	Beverages	4	106.18	2025-01-14 22:53:59	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.fernandez11	2025-01-14 22:53:59
cf0d262b-18f1-4873-9d65-0c3e8e0cbb72	ExwsbKrH88D38komBv6M	6111	Hot Chocolate	Pastries	3	131.53	2025-08-28 16:37:18	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905430495	elena.fernandez11	2025-08-28 16:37:18
2a8c90d4-c137-49bc-8de8-03cb9f3c1eda	Evhxka18fBXjX7M2iZl5	6118	Tea	Beverages	5	106.18	2025-06-09 03:06:53	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.fernandez11	2025-06-09 03:06:53
459442a9-cec0-450c-a9d1-5ff804735c40	Rej1hBrXEcaeb7cDwya9	6120	Eclair	Pastries	5	146.12	2025-04-15 13:34:53	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	rosa.rivera7	2025-04-15 13:34:53
6b24cda1-3d76-4709-84a0-b63366d7e95c	F0FpAER2LjT4xw6BUrOJ	6121	Hot Chocolate	Pastries	3	131.53	2025-01-18 13:25:31	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905770763	gabriela.mendoza	2025-01-18 13:25:31
c3edd36f-a242-436d-b0a5-a7fcaf0ce72a	zSpgGQjxRWzxoZO8VCBO	6123	Flat White	Pastries	4	113.21	2025-02-08 10:52:49	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	miguel.cruz15	2025-02-08 10:52:49
f4dfa5cb-5fd4-4796-81ab-67f997b641fd	n3hmF4TDrGEh0lgxH0pq	6128	Chai Latte	Pastries	4	100.50	2024-12-23 02:09:35	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	admin	2024-12-23 02:09:35
0e7d6fc8-601d-470b-a7c5-df78c870a219	XpX4eH9Y3D13qq19B7E7	6130	Macchiato	Pastries	5	93.97	2025-09-08 03:23:59	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905330186	sofia.reyes9	2025-09-08 03:23:59
74f23911-b1d8-440a-a878-c8d27b8be1f9	F1MITb2jFurcHByTXbi5	6137	Tiramisu	Pastries	3	196.55	2025-02-23 04:10:28	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905586262	fernando.cruz	2025-02-23 04:10:28
9a939b7a-dd21-4e2d-a172-74ec6c2e6519	N3qWaPkZVYAnE5ZVFcU3	6142	Cappuccino	Pastries	1	76.25	2025-05-07 01:24:12	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	sofia.reyes9	2025-05-07 01:24:12
61c1459a-a2b3-4ff9-881b-1e6f2c360146	rTKVoBIKqPta2XRR9em3	6143	Iced Mocha	Pastries	3	144.00	2025-11-10 13:36:10	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	miguel.cruz15	2025-11-10 13:36:10
0cbad7e6-08ec-4255-ae06-b0a8778fe5fb	5pHezmhXw1g3qwl8B4gX	6150	Hot Chocolate	Pastries	3	131.53	2025-02-15 14:28:17	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.fernandez11	2025-02-15 14:28:17
101218ec-d55a-4013-bcb1-2929a47370be	SSQE26w7uaMlYkdkseZX	6158	Apple Turnover	Pastries	2	154.54	2025-10-17 08:08:00	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.fernandez11	2025-10-17 08:08:00
3865fa9a-b3e0-4c47-ad13-72cb23e787e1	qotkRlmhnKtVkbJdj1Gs	6162	Almond Croissant	Pastries	3	8.42	2025-06-27 00:26:24	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	elena.fernandez11	2025-06-27 00:26:24
c8f13e8d-321c-43cf-bea6-e96ee9feb753	5ZUHj49zKYs8uWmBJZfq	6163	Macchiato	Pastries	1	93.97	2025-05-22 07:18:02	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	pedro.cruz14	2025-05-22 07:18:02
08c0ea13-08b0-4a69-9e82-f2d71524ad28	Jr2BY1MYY32SKW4xOFJp	6166	Glazed Donut	Pastries	2	148.75	2024-12-28 22:32:03	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	fernando.cruz	2024-12-28 22:32:03
c86464a6-6da5-44e9-9701-3e071ce248e6	wFVvZHC6W0M2dP8xA4G4	6171	Tiramisu	Pastries	4	196.55	2025-01-12 15:50:42	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905021926	fernando.cruz	2025-01-12 15:50:42
bb8631a1-d9a7-45d5-9107-c4502e536aec	SHfN39FXSkxbOoFqzBCl	6174	Iced Mocha	Pastries	5	144.00	2025-08-07 13:10:03	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905586077	carlos.delacruz	2025-08-07 13:10:03
e07465f5-980c-4a88-a3ad-d5f49f23d3a2	FUygz6HerSDdb70VSZOS	6181	Almonds	Pastries	1	5.59	2025-05-20 22:36:53	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905250716	sofia.bautista5	2025-05-20 22:36:53
74fee900-b45a-4053-a7c1-7c600089ed0c	Mlb5mgVxfVH4v3LXAbE5	6182	Red Velvet Cake	Pastries	4	187.25	2025-02-19 12:46:33	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	gabriela.mendoza	2025-02-19 12:46:33
f2f887e1-844b-46f6-8be0-327c0e544ca0	oAv5WgMwqLGMtiWKUXjx	6183	Flat White	Pastries	5	113.21	2025-04-11 04:12:27	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	fernando.cruz	2025-04-11 04:12:27
7760fb10-c370-4e68-9e28-4224ba6def0e	QY4WdSqhyDjk5pOdzqIl	6184	Iced Mocha	Pastries	4	144.00	2024-12-30 17:17:34	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	gabriela.mendoza	2024-12-30 17:17:34
ebed680e-1d82-46b1-a4d1-4cc66715521f	LE7z4Wh5eHbP5oLjPTUP	6185	Almond Croissant	Pastries	3	8.42	2025-01-06 14:25:04	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	pedro.cruz14	2025-01-06 14:25:04
c3df60ec-5442-49af-9eb2-f2c9da9da687	j7S05u7fQU7Xk0r69WrZ	6186	Iced Mocha	Pastries	5	144.00	2025-02-17 16:28:18	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2025-02-17 16:28:18
890c0312-e5cd-48a1-bdf8-bbc33c2b5c09	IMZLQbvpPXs0fvu6GNNp	6188	Latte	Pastries	1	108.74	2025-08-14 08:51:00	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905540792	elena.fernandez11	2025-08-14 08:51:00
7ca1072e-e15c-492e-b102-f10f21400ed3	ZWwsoN2wTB2bji17cqvv	6190	Eclair	Pastries	5	146.12	2025-02-03 23:34:31	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.fernandez11	2025-02-03 23:34:31
d65384f7-9b52-4e13-85d7-0868d0344b7c	1gW4QFkupJAKvyPHorzm	6199	Glazed Donut	Pastries	1	148.75	2025-06-28 22:25:00	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	pedro.cruz14	2025-06-28 22:25:00
43a8a343-5526-474f-9af0-c1972ed521d8	JOhC3hsDZP5zx4YoN8RZ	6202	Flat White	Pastries	4	113.21	2025-09-21 07:09:51	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	antonio.delacruz10	2025-09-21 07:09:51
a58d7a0b-e42c-4e6b-a55a-e8cbc96a7de5	vjQuYH7Wwo5RAlan7npA	6204	Mocha	Pastries	3	61.74	2025-05-25 21:56:58	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905361845	rosa.rivera7	2025-05-25 21:56:58
a4374d0b-4644-48cb-9532-7be7dce95a55	5PKA5xgXMJIWpcNrDeE7	6208	Cappuccino	Pastries	1	76.25	2025-11-24 07:14:47	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905921126	fernando.santos8	2025-11-24 07:14:47
84df37a1-9f3d-4699-86f4-ebee4ee8de30	lhsOYven7mVI3rzyTPJi	6222	Eclair	Pastries	3	146.12	2025-08-07 19:28:56	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	sofia.bautista5	2025-08-07 19:28:56
5313b133-d17c-4154-9d85-79ae8efce138	BApMFxInqJDwiUMPLLaT	6225	Macchiato	Pastries	4	93.97	2025-09-23 12:08:36	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.delacruz	2025-09-23 12:08:36
036a5ecf-6da4-442f-a548-03732cdb1ddb	dZWIk2591GncQxvUqwXj	6227	Baguette	Pastries	3	133.77	2025-11-11 22:11:13	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	fernando.santos8	2025-11-11 22:11:13
942a4137-2963-4a7e-848e-2b164dd1bdd0	lvXTofIFyeVzWMQX8hAj	6228	Glazed Donut	Pastries	1	148.75	2025-09-13 18:04:25	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	admin	2025-09-13 18:04:25
5b9d7fe9-af0b-4f8d-bb91-7b6c7549c573	BCKHGs3d5P4Ayr1Wv4Sl	6229	Almond Croissant	Pastries	4	8.42	2025-08-10 15:06:51	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	antonio.santos6	2025-08-10 15:06:51
4410018c-83cf-44ee-b074-2f74d2d03100	PtMkhW4HB1LgSbdphKl0	6231	Almonds	Pastries	3	5.59	2024-12-10 18:26:28	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	miguel.cruz15	2024-12-10 18:26:28
f9f2bf73-dc1e-4881-a4da-d7a8e519c564	DKHOmjATw4ZUrRITye3Q	6240	Espresso	Pastries	5	195.76	2025-05-24 09:37:41	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905464130	admin	2025-05-24 09:37:41
b5a64718-4fca-443a-b662-4770d4a35c69	EVYjhIFfCScWiei4zhCW	6241	Eclair	Pastries	2	146.12	2025-06-06 13:51:22	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	ana.rivera3	2025-06-06 13:51:22
5f3e5547-3b41-4ada-b1c7-822ed74009d9	KtRPhpcYxDuJYO46DHVf	6243	Apple Turnover	Pastries	5	154.54	2025-09-20 19:44:34	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.delacruz10	2025-09-20 19:44:34
3c9949e0-a052-4267-84ce-d150e6604e6c	sKskajBiK1R4cvYoQPh6	6244	Iced Coffee	Beverages	1	107.80	2025-03-29 17:10:06	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	pedro.cruz14	2025-03-29 17:10:06
d721e639-7ae7-446d-89bc-4f853a893a02	x5rcP0EsTTHZmwf4QSno	6245	Apple Turnover	Pastries	5	154.54	2025-06-15 11:44:43	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905022845	isabella.delacruz4	2025-06-15 11:44:43
225c99f4-3b8b-4079-8397-8e1836bcf627	1CkwtKv1qcRDKu9tL0rl	6248	Eclair	Pastries	4	146.12	2025-09-18 04:14:15	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.delacruz10	2025-09-18 04:14:15
676c2140-c55a-47ba-870b-23c9e904017a	TlrvEypLWnW7n1PCnfJK	6249	Baguette	Pastries	1	133.77	2025-03-04 17:32:05	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905707301	rosa.cruz13	2025-03-04 17:32:05
d047b740-9b10-4989-83c3-f8c6cd1f6fea	Rlb2IXeEPMt1AezUkfJ6	6253	Almond Croissant	Pastries	4	8.42	2025-11-17 16:09:48	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905630900	fernando.santos8	2025-11-17 16:09:48
49523b05-2540-416c-8dfe-443672dd0dbe	SZyzr2ttKmO6H8WSW0uz	6255	Espresso	Pastries	1	195.76	2025-04-26 03:44:12	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.cruz13	2025-04-26 03:44:12
d22c1cb3-4e75-4f70-a62d-4f96683dcb4c	TaBwNGDgpayEZOKLQDpp	6256	Apple Turnover	Pastries	3	154.54	2025-09-15 22:51:08	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905303494	isabella.delacruz4	2025-09-15 22:51:08
828303cd-f38a-4552-bb43-897bbb1350c5	is9yvzcThJbEQaqyI385	6258	Chocolate Chip Muffin	Pastries	4	103.79	2025-04-21 06:12:49	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905701993	elena.torres2	2025-04-21 06:12:49
40cae9ad-aa24-4053-9850-45862d724fa7	GVSSMjvqAjDSOKLTXR4N	6260	Chocolate Chip Muffin	Pastries	2	103.79	2025-05-18 20:19:52	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.cruz12	2025-05-18 20:19:52
95902067-4c3a-4072-905f-3a97fb784dd0	IVI9253JQof8ZFmGdOHc	6262	Almonds	Pastries	3	5.59	2025-06-21 14:25:29	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905170413	rosa.rivera7	2025-06-21 14:25:29
7d9a82a3-2c86-40cb-aa6a-2ddc32e14d8d	NQ5yrAUTac46VlLMnCmR	6263	Baguette	Pastries	3	133.77	2025-03-25 17:49:44	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	pedro.cruz14	2025-03-25 17:49:44
2351719d-8a83-442d-920e-db954a450b72	FDb5MKKHnF7i0SipjJV9	6269	Hot Chocolate	Pastries	1	131.53	2025-04-26 08:51:08	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	sofia.reyes9	2025-04-26 08:51:08
d199668d-5f95-4ff3-8878-8eb00dbf6ec5	tPVhKiz48x1YhtL8aD86	6272	Iced Mocha	Pastries	4	144.00	2025-08-31 09:22:19	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	gabriela.mendoza	2025-08-31 09:22:19
d28813f9-cc32-420f-9609-0e8cd90cea1e	Z0i6EwFzSsjiDKHwJKmY	6273	Chai Latte	Pastries	5	100.50	2025-08-08 13:48:34	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	ana.rivera3	2025-08-08 13:48:34
4e032e93-86f6-4b81-8168-c504d3643ac0	lV2GcUeV4V9GynJ1NkFJ	6278	Apple Turnover	Pastries	5	154.54	2025-01-31 23:19:09	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	carlos.delacruz	2025-01-31 23:19:09
295de215-62be-4773-b917-6ebe78ce4e36	FLtDmlcuXCRrCK2WBtUJ	6280	Hot Chocolate	Pastries	1	131.53	2025-04-06 21:35:15	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905616844	fernando.cruz	2025-04-06 21:35:15
40d08d05-cda1-4e1c-819c-233aee153375	2MkkCcK0xJJoI4g6mZRr	6294	Almonds	Pastries	1	5.59	2025-09-07 19:20:03	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	isabella.delacruz4	2025-09-07 19:20:03
f16debaa-58df-443c-99c6-1db0ec6aeaad	Z2DfY2G2eGU5AZIyA6AS	6300	Baguette	Pastries	1	133.77	2025-02-08 05:13:49	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	antonio.santos6	2025-02-08 05:13:49
f950d7c6-6966-41ac-8684-ff935102c6fd	V9ohPokNSXoNF2lSvsAl	6310	Almond Croissant	Pastries	3	8.42	2025-02-03 14:04:17	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	sofia.bautista5	2025-02-03 14:04:17
d08e76bb-16f5-4dcd-af38-3d4823b9b4d7	gd25y0eXOZbBpR4CqQaW	6324	Iced Coffee	Beverages	1	107.80	2024-12-09 22:53:49	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.delacruz	2024-12-09 22:53:49
d459f559-1578-44ae-9b85-7468398b726b	aCWkYPpy190yj6uIwlJd	6328	Blueberry Muffin	Pastries	1	185.15	2025-02-28 12:46:11	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	pedro.cruz14	2025-02-28 12:46:11
90054fbe-6d47-46d6-984d-ec7cc042d7a6	XZWb2L9lJBqvvyGBRjxL	6330	Blueberry Muffin	Pastries	3	185.15	2025-05-07 17:56:20	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905859580	carlos.cruz12	2025-05-07 17:56:20
aac30340-a8a2-4119-ac74-65bc3c81daa8	ld4MACRLvexRkY6IvHw9	6331	Hot Chocolate	Pastries	3	131.53	2025-05-30 01:16:42	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.fernandez11	2025-05-30 01:16:42
6d65db37-b5c9-4852-b0f0-396c8baa06f4	Ne8ymITrSgIbFMaj1XIY	6332	Chai Latte	Pastries	5	100.50	2024-12-03 16:58:30	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	elena.torres2	2024-12-03 16:58:30
3b2378db-5456-40a1-9c4f-64f9501afe99	tCVAEe56zqQdJu6VNFTC	6336	Cappuccino	Pastries	5	76.25	2025-10-27 21:22:51	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	rosa.rivera7	2025-10-27 21:22:51
df1da646-3803-4109-a151-c023161e32d8	bPpbSZDof46oektfWRBV	6341	Cappuccino	Pastries	1	76.25	2025-05-15 05:49:24	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	miguel.cruz15	2025-05-15 05:49:24
75588946-50b0-4c3f-93d0-c32995e64536	eqCGxeUmUDaKCCfVBdaN	6342	Almonds	Pastries	2	5.59	2025-08-21 01:21:38	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.bautista5	2025-08-21 01:21:38
1132349c-7498-40de-8f80-a07218d30040	MS3d19M0qeTyFD9OBu2R	6343	Apple Turnover	Pastries	1	154.54	2025-08-03 14:39:00	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	pedro.cruz14	2025-08-03 14:39:00
ba8d0e3b-1c38-4076-bfaa-7e0542d453dc	EF3Q8HExC5UMuGtl1UN7	6344	Tiramisu	Pastries	4	196.55	2025-10-01 19:08:13	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.torres2	2025-10-01 19:08:13
6528d449-b98a-4eda-97df-2f99f8f24b93	1OpQYdeN4JWdxPtwquDB	6345	Apple Turnover	Pastries	2	154.54	2025-02-17 21:09:59	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905655080	sofia.bautista5	2025-02-17 21:09:59
94c46145-5a07-4e3f-8db1-83092c3539de	BnpwN6MY4bjPj6HRJUc1	6347	Almonds	Pastries	4	5.59	2024-12-18 10:11:06	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	admin	2024-12-18 10:11:06
75ff6e02-6cd0-4d32-9bab-89faef9d9a91	YVgEYVVJoa3NkoZeFQqe	6348	Hot Chocolate	Pastries	5	131.53	2025-11-08 12:41:12	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.torres2	2025-11-08 12:41:12
c6d4ecd0-7a6f-4927-b8dc-347a296e6eb7	1ExhDAw9viT8AI9MYlQ0	6350	Iced Coffee	Beverages	4	107.80	2025-11-20 11:09:06	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905600924	carlos.delacruz	2025-11-20 11:09:06
4574c878-65f0-465b-9aad-50dd54766219	V3lwpMlE417agY3ogc8E	6351	Hot Chocolate	Pastries	2	131.53	2024-12-30 23:40:39	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.cruz12	2024-12-30 23:40:39
5df5ded6-bbc2-4ede-9277-72ee0ac49568	UEEJhwoK7mX9nV1TfTLm	6352	Almonds	Pastries	5	5.59	2025-05-21 11:52:13	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.reyes9	2025-05-21 11:52:13
5ba6c498-3b20-4b99-bffc-01ce987a4638	zzKWE9auwwKJ4rO5NFdw	6353	Iced Mocha	Pastries	1	144.00	2025-07-07 00:51:53	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	fernando.cruz	2025-07-07 00:51:53
800fae3a-f109-40cc-b2b4-7191107bbbba	xaj5GdovTpBcdqtldfwu	6360	Apple Turnover	Pastries	1	154.54	2025-09-30 14:51:47	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905342086	antonio.delacruz10	2025-09-30 14:51:47
33888e32-8eda-4634-93e8-9587f5eb217d	wpaJiG292D0lHB8Uvlbb	6362	Chai Latte	Pastries	2	100.50	2024-12-03 21:18:28	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905229251	sofia.bautista5	2024-12-03 21:18:28
18ce3a64-60ba-441b-862b-9247b57bda8b	309PRbP2tPkrLggoSkXl	6365	Iced Coffee	Beverages	1	107.80	2025-08-15 20:56:01	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905598101	rosa.cruz13	2025-08-15 20:56:01
1a2a576e-c550-4ca3-971c-d262028110d5	6MS4FToczSo3YXDSFYol	6368	Macchiato	Pastries	2	93.97	2025-07-02 01:18:16	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905002763	rosa.rivera7	2025-07-02 01:18:16
993d0736-6b4a-48f8-913c-7ee9c0c40d9f	hwbcvNI5ZpEiCxUBgdpU	6373	Almond Croissant	Pastries	3	8.42	2025-07-31 18:10:25	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905291408	fernando.santos8	2025-07-31 18:10:25
9dcc397e-a4f6-4050-97b6-68afbddd08c4	4vZ3l2a399m2vIPUXJHJ	6374	Blueberry Muffin	Pastries	2	185.15	2024-12-03 06:55:16	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	antonio.santos6	2024-12-03 06:55:16
eafbd039-9fbb-4684-9670-4b7d6d407db5	plF2d97c9oKWzO9cAgce	6377	Hot Chocolate	Pastries	4	131.53	2025-06-18 01:30:45	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	fernando.santos8	2025-06-18 01:30:45
8fd2adab-43b7-4d2e-91d5-7065da75a6c7	5gfhoA2ICrqwB8alfITb	6378	Hot Chocolate	Pastries	5	131.53	2025-06-28 03:26:35	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.mendoza	2025-06-28 03:26:35
7bc221e8-32a8-4cc9-89a0-803852a98964	9icu2buP01h2scqNXZHP	6379	Hot Chocolate	Pastries	1	131.53	2025-05-24 19:34:05	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	fernando.cruz	2025-05-24 19:34:05
69c90417-f31b-4c6a-8e71-c9bb3a7fdbab	GNF51H3VkPeSwk5oiKom	6381	Apple Turnover	Pastries	1	154.54	2024-12-20 15:17:21	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905143954	gabriela.mendoza	2024-12-20 15:17:21
369b22eb-6a4b-4cbb-ba64-942134532e2e	LBHGOMAHzwhgUyz1aH8N	6384	Chocolate Chip Muffin	Pastries	5	103.79	2025-08-23 21:01:11	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.cruz12	2025-08-23 21:01:11
068b28ce-eb68-4b0f-9efe-4652c03ec522	iK39MpgmXxe3ECKxrghf	6389	Chocolate Chip Muffin	Pastries	2	103.79	2025-10-26 15:34:35	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.cruz12	2025-10-26 15:34:35
654b8045-53f8-4b31-931b-e80a7750daa6	Nh0pGLoR9isdhwGDkmrJ	6397	Tiramisu	Pastries	2	196.55	2025-01-25 07:13:30	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	gabriela.mendoza	2025-01-25 07:13:30
9a836a41-f1de-4bd2-aff6-c3400db1acd3	QDcOCg6PwNNav5LjrSDb	6400	Espresso	Pastries	1	195.76	2025-08-29 18:25:02	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.delacruz10	2025-08-29 18:25:02
44f55105-e113-459a-8017-9d325a3bb6b6	4ABHjnz5E81ADKTG6tNM	6407	Glazed Donut	Pastries	3	148.75	2025-11-23 21:56:55	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	fernando.santos8	2025-11-23 21:56:55
14054a8e-45f0-4bf6-8d80-313ede0524e8	e3BwEKrTjUydBbQDDTpy	6408	Flat White	Pastries	1	113.21	2025-10-11 16:15:32	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	antonio.santos6	2025-10-11 16:15:32
2bbfebb7-7d8e-4869-8b99-849b9edb2585	O5eJKBNqeCkjISBWOlYD	6409	Almonds	Pastries	3	5.59	2025-08-12 13:53:18	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905584441	gabriela.mendoza	2025-08-12 13:53:18
b6323898-de9c-4bf7-bce8-2e835196a885	TlSnoYxbN61ACNhZ1BtU	6411	Red Velvet Cake	Pastries	5	187.25	2025-01-19 02:24:54	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.cruz12	2025-01-19 02:24:54
84bd238e-1ec1-4d0b-bfba-0b8ef4ae5754	PLoWr0sjxkRzwJsehdTl	6412	Chocolate Chip Muffin	Pastries	1	103.79	2025-07-07 17:41:25	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	gabriela.mendoza	2025-07-07 17:41:25
60f0481d-2ad6-4fee-ab61-818376c6c0bc	OPlvRGKIWV3wf35rBmTt	6413	Almond Croissant	Pastries	5	8.42	2025-02-14 20:56:54	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	miguel.cruz15	2025-02-14 20:56:54
e5c44ba0-e116-44e7-84de-984c7e360a92	W806ZdEBIKSqYjEv4FPu	6414	Iced Mocha	Pastries	3	144.00	2025-04-07 02:30:56	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	rosa.rivera7	2025-04-07 02:30:56
429c1035-d04e-4e38-9426-0ef651d9ea5c	qhDzSmS6dnJc0Yv6SyTJ	6417	Baguette	Pastries	5	133.77	2025-02-01 16:34:02	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.cruz12	2025-02-01 16:34:02
ef66192d-4507-487b-816f-7d8766881078	68GSkkFWz5VCjlbja0Dp	6421	Americano	Pastries	5	80.96	2025-01-05 09:10:41	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905713061	fernando.cruz	2025-01-05 09:10:41
de65662d-18c9-40bf-8129-e9a1d92da291	Bul8g2HnnsVVuwYGQ1EP	6424	Iced Coffee	Beverages	3	107.80	2025-03-30 21:34:54	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905207468	fernando.santos8	2025-03-30 21:34:54
438a4d1a-ac1c-4e36-aa56-b55e86110441	bvLYPh3GP9JJ9sn6mf26	6425	Mocha	Pastries	2	61.74	2024-12-31 02:54:37	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905791044	carlos.delacruz	2024-12-31 02:54:37
e13412a5-15da-4c8f-a59c-df9d51d433bf	DS3sEYxLtpcBifqrqFMm	6431	Iced Mocha	Pastries	2	144.00	2025-05-03 19:52:48	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905238590	fernando.santos8	2025-05-03 19:52:48
32ffd0ac-8008-4f06-a6ec-5606d4491a48	42m3G55OZGHuvgtdamd3	6437	Espresso	Pastries	1	195.76	2025-05-12 01:40:13	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.cruz13	2025-05-12 01:40:13
ca95725f-cdb2-461f-a6ac-02174e799a71	PgpaU34IddnvPpTyyDhT	6438	Latte	Pastries	1	108.74	2025-06-14 03:56:29	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.mendoza	2025-06-14 03:56:29
3902ac67-1185-485a-af6d-eb3acb32e593	mjOQIbaLz3wJADpop4fu	6450	Eclair	Pastries	1	146.12	2025-04-30 06:39:50	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	isabella.delacruz4	2025-04-30 06:39:50
f5ef0be9-9912-4be8-adaf-bba70334a68f	I038bkdP43GbACJjw4kH	6456	Almonds	Pastries	4	5.59	2025-07-27 02:35:10	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905013056	isabella.delacruz4	2025-07-27 02:35:10
cfa9b1f2-09e3-4eaf-ab50-97da227c62e3	m2m3eQWmiZVjFWS32mf1	6468	Espresso	Pastries	4	195.76	2025-10-28 05:20:06	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	pedro.cruz14	2025-10-28 05:20:06
8ba12e14-3a9e-41a6-803e-b913fac45e61	X1z6xyWyRNkW07jqT8sn	6469	Iced Coffee	Beverages	2	107.80	2025-08-31 07:48:42	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	pedro.cruz14	2025-08-31 07:48:42
4aa05035-429c-4bf7-8380-c7bf4a904eb5	jyVdqiDvIr38SR8W01pJ	6476	Espresso	Pastries	3	195.76	2025-09-09 04:58:34	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.cruz13	2025-09-09 04:58:34
df69c791-9ec9-46e4-80db-14e883b472b5	U2haOi02idrC6qsVKqnR	6477	Hot Chocolate	Pastries	3	131.53	2025-06-14 09:17:48	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	isabella.delacruz4	2025-06-14 09:17:48
667eb14f-a3b2-49f4-9bb8-1af84236b000	Xz85kB6VVj158l251Fmb	6478	Macchiato	Pastries	3	93.97	2024-11-26 15:44:59	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	admin	2024-11-26 15:44:59
f2fcd935-b0da-4a52-917c-867b123ec76a	63zHxECwY5MdO56RXemI	6479	Flat White	Pastries	2	113.21	2025-11-01 16:00:29	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	pedro.cruz14	2025-11-01 16:00:29
1f2cf29d-7cc3-4a7c-952b-75931deb1fcd	OSJHr7NTtOl6cLC3nuJD	6481	Baguette	Pastries	4	133.77	2025-01-30 18:37:59	c8d156d2-b289-439f-90bc-692447063015	Card	\N	antonio.santos6	2025-01-30 18:37:59
d81e3933-bbd7-4379-ab60-a5c417339df3	L8CSD7Ka9ltqNXSq3I8X	6482	Glazed Donut	Pastries	3	148.75	2025-07-15 09:41:34	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905129366	antonio.santos6	2025-07-15 09:41:34
169b01ee-ca42-4441-8f81-a5e75f915d88	xA0u8WNTFLHPsy42NfMV	6483	Tea	Beverages	5	106.18	2024-11-27 00:06:05	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	miguel.cruz15	2024-11-27 00:06:05
f92c25bb-09f8-4718-aec9-44ab90404997	2eP69fWOdrBDQ3FtqtPX	6494	Almonds	Pastries	4	5.59	2025-08-31 19:17:12	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905855314	antonio.santos6	2025-08-31 19:17:12
e3ae00f7-a95b-42ab-9899-fafb29ca0e36	gEakrFrA7ZloBRp9C2fz	6499	Chai Latte	Pastries	4	100.50	2025-07-26 01:02:15	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	rosa.rivera7	2025-07-26 01:02:15
1f9b4bbc-70af-4ff9-9c78-a1d3aa9a0660	TpA8ml2zQvXRR4Cwzc3h	6501	Eclair	Pastries	5	146.12	2025-02-19 17:45:50	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	sofia.bautista5	2025-02-19 17:45:50
fbba0220-1476-4aa2-9997-b837d7187452	49jOl669amBRXCCQALEr	6502	Tiramisu	Pastries	5	196.55	2025-04-01 18:22:52	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	sofia.bautista5	2025-04-01 18:22:52
bb932ad3-71b5-4ee2-b8ec-88b8f04eea36	CsrJfbtsW7EKEIsTj6ib	6504	Blueberry Muffin	Pastries	2	185.15	2025-03-30 15:43:21	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905828236	elena.fernandez11	2025-03-30 15:43:21
64fb1fd2-375f-42fb-9f9d-5a141a74c298	LGK02rEdI1B0O2nq30uH	6506	Iced Mocha	Pastries	1	144.00	2025-04-07 15:27:57	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.delacruz	2025-04-07 15:27:57
edc08267-fc9a-4d3d-b235-9bb50c9baefe	v2OnYfPhtX4DyLYud5uy	6507	Baguette	Pastries	5	133.77	2025-07-15 06:55:46	c8d156d2-b289-439f-90bc-692447063015	Card	\N	sofia.bautista5	2025-07-15 06:55:46
59f6f0b9-dab7-4cc0-a423-9ed09d059a4a	DrqiQLS2v8HnuePkilPJ	6516	Baguette	Pastries	3	133.77	2025-07-27 07:53:40	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.delacruz	2025-07-27 07:53:40
ab758072-f2f8-4a66-8824-ee4a7040bbb2	URtkzcTCtcmv8DS87mOt	6517	Red Velvet Cake	Pastries	1	187.25	2025-10-18 00:41:57	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905418606	antonio.delacruz10	2025-10-18 00:41:57
ff6e005d-222a-4f27-8614-52941231612a	fjTUQj2tR1PO2ZNXodwr	6520	Almonds	Pastries	5	5.59	2025-02-09 17:57:36	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	elena.fernandez11	2025-02-09 17:57:36
8a0aaf7f-9d6d-4400-8d41-6d97ec00a599	VqisZLscPZ9dvaR0gikq	6521	Chai Latte	Pastries	2	100.50	2025-03-08 11:13:24	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	elena.torres2	2025-03-08 11:13:24
02693d5a-bb0a-411b-a533-b3a4855c8cc6	fl1vyIqG1kz958wPTlgT	6525	Chocolate Chip Muffin	Pastries	4	103.79	2025-08-01 12:13:59	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	pedro.cruz14	2025-08-01 12:13:59
fb2af086-99d6-4249-b82a-e34d3bc78e08	8mKAes1aiDbyA5RZSY8I	6529	Glazed Donut	Pastries	3	148.75	2025-08-01 16:18:08	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	antonio.santos6	2025-08-01 16:18:08
0c45437a-d76c-489e-b4cb-3f0de5fa4d01	J9aRXUAraOTG5lv2eGL2	6540	Mocha	Pastries	3	61.74	2025-10-17 07:09:25	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carlos.cruz12	2025-10-17 07:09:25
498f9ebf-a637-4586-b214-fe7c34886571	ldBiKc2TuhYYFbRjRBeu	6542	Apple Turnover	Pastries	3	154.54	2025-06-21 11:45:59	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.santos6	2025-06-21 11:45:59
4e40f3b1-ec32-4f7e-9715-3d73bb32f97b	zWiakfdG4QFxnzznX9Tq	6548	Glazed Donut	Pastries	5	148.75	2025-04-19 11:44:28	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905908896	miguel.cruz15	2025-04-19 11:44:28
786a1bad-39c7-48fd-a4a0-d5f0bd95d959	zgoNTM90J6icvkyxuxxi	6549	Flat White	Pastries	3	113.21	2025-09-23 21:38:09	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905317308	antonio.santos6	2025-09-23 21:38:09
df74e6b4-67f3-4b9d-85e1-60daef7687ad	Q7QtFl1UenLz8qa6KkdM	6554	Tea	Beverages	4	106.18	2025-09-08 04:53:20	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	antonio.santos6	2025-09-08 04:53:20
6fe3602d-a876-4497-b583-56ccb5f14eab	GtcUXDR8yjMU5iaONbOR	6555	Tea	Beverages	3	106.18	2025-06-05 06:46:52	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	sofia.reyes9	2025-06-05 06:46:52
34449266-548e-4ec8-b0e8-df7bbbaefa4f	QhEnjtHNvpmR3U4Pi9uh	6556	Macchiato	Pastries	4	93.97	2025-06-29 16:00:10	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905345257	fernando.santos8	2025-06-29 16:00:10
0a4839f2-3906-4c4d-a42f-96c37b1501e1	DUAxlhv3B0SdcVpp59jc	6567	Blueberry Muffin	Pastries	2	185.15	2025-04-26 03:41:02	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905421798	pedro.cruz14	2025-04-26 03:41:02
f9f28bc9-f386-4ea6-8194-77c7931d7d55	gbDblkkXWbvOsBkjq81B	6568	Apple Turnover	Pastries	2	154.54	2025-08-16 17:51:43	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905594074	rosa.cruz13	2025-08-16 17:51:43
ce98cf57-88fe-46ce-9c78-840368d094f7	pcGRsuXK044QGhxlOpgB	6578	Chai Latte	Pastries	3	100.50	2025-10-06 18:37:16	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carmen.santos1	2025-10-06 18:37:16
69dcb8c4-2efe-44cd-8222-16f88897b17c	vRoK4QkcTRxvkcQu1GHK	6582	Blueberry Muffin	Pastries	5	185.15	2025-09-08 10:13:59	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	isabella.delacruz4	2025-09-08 10:13:59
ea5d55a7-b4c7-4239-99ff-4559d34b5ba8	TGRL4UXlShUlUaaRKX0C	6583	Espresso	Pastries	2	195.76	2025-04-03 16:54:42	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.delacruz10	2025-04-03 16:54:42
133fb602-1613-47df-abab-e3d8c86983c3	WqygWmDW6CSzXruvM0TO	6584	Mocha	Pastries	4	61.74	2025-07-15 16:58:41	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carlos.mendoza	2025-07-15 16:58:41
b83fc54a-7769-4858-998e-f87c9aa50ada	2bDctEdqTF4K0r4FlPWq	6594	Latte	Pastries	2	108.74	2025-03-17 12:34:58	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905226972	ana.rivera3	2025-03-17 12:34:58
e8c6f81a-3a6c-4e5c-bba2-b0411074a879	bGi8vfNPdWpGBaB5huBX	6595	Baguette	Pastries	1	133.77	2025-01-15 14:19:23	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905800304	admin	2025-01-15 14:19:23
acae6f27-67c8-4548-a4fc-3a4524397227	Ynw1Jkhc9fEgkl4waY5v	6596	Mocha	Pastries	3	61.74	2025-01-12 07:04:05	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	admin	2025-01-12 07:04:05
da3c8ebb-d59d-41cd-9f26-709a0e565a10	dTgAuY14zcQHJkcVP9Zz	6597	Espresso	Pastries	5	195.76	2025-04-24 19:21:10	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.cruz13	2025-04-24 19:21:10
b5974c13-91da-44fa-9cce-5c1c0c86a776	q1bKySk1u4CDmpb47uvH	6600	Latte	Pastries	5	108.74	2025-09-06 12:46:56	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	isabella.delacruz4	2025-09-06 12:46:56
50da2abe-8ca8-4eed-a082-b26a8b8ddf9c	eTX7KHlOjxHweHLVSbrX	6602	Red Velvet Cake	Pastries	4	187.25	2025-07-11 09:00:07	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	miguel.cruz15	2025-07-11 09:00:07
f242a7ce-9105-4f22-ad5e-6717e88aae42	EVPCk63qkly5OmzVE5DH	6603	Flat White	Pastries	2	113.21	2025-01-22 00:49:51	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	rosa.rivera7	2025-01-22 00:49:51
04ff77f8-81af-4647-b88f-6b3f9a1b32cf	5Tawg1Dgv5q2SK98NKDd	6604	Latte	Pastries	3	108.74	2025-07-18 09:41:39	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.cruz12	2025-07-18 09:41:39
af2853c8-4852-44bf-9d51-ce3ee87202e3	1uOxvUSa62ONy1G3f0uS	6616	Iced Coffee	Beverages	5	107.80	2024-12-12 12:33:36	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905835890	sofia.bautista5	2024-12-12 12:33:36
d2ec6406-cc2d-4a2a-a14b-023748440e5a	V86gZDtw035ntIIEHPY5	6617	Baguette	Pastries	5	133.77	2025-06-24 23:50:23	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905873847	carmen.santos1	2025-06-24 23:50:23
13cfa40a-4d01-4fc5-ad2c-8289ce51ee18	prR10HmRNsJOSByNHfGo	6618	Iced Coffee	Beverages	2	107.80	2025-10-06 17:16:52	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	ana.rivera3	2025-10-06 17:16:52
35f85387-69d1-4d1c-b942-532cf702efff	bwP4PHo9mzW5k89p6l9c	6619	Red Velvet Cake	Pastries	2	187.25	2025-07-02 02:47:50	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.delacruz	2025-07-02 02:47:50
90b74799-dd44-4001-844b-a7bf4157d5ba	ZBs2HVK3tvAmUGkI7Hl3	6620	Americano	Pastries	1	80.96	2025-02-07 10:10:08	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	isabella.delacruz4	2025-02-07 10:10:08
7cffa65f-db29-43b9-a395-13f318489c8f	6FWdGopawQHo4kE3IUgh	6626	Americano	Pastries	2	80.96	2025-04-06 15:31:49	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	elena.torres2	2025-04-06 15:31:49
90465f0e-5299-432a-ae06-7b6af11c951c	cJu8X7piJE6vqnEr4xrn	6628	Latte	Pastries	5	108.74	2025-04-26 06:36:22	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905352710	fernando.santos8	2025-04-26 06:36:22
11e71e1b-5253-463e-b0e3-445d01e1a5a5	C2YfdrNHVB5HStcmCHug	6629	Baguette	Pastries	4	133.77	2025-08-29 05:18:27	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905144686	elena.torres2	2025-08-29 05:18:27
62d6ca95-28b1-4b32-aea7-f81fd02c4981	hrQ52KOYmDvpTn2r8ZOL	6630	Glazed Donut	Pastries	5	148.75	2025-09-08 18:11:28	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	gabriela.mendoza	2025-09-08 18:11:28
8e30250f-5569-4dea-97ae-273e9413bf80	WR5v8krDQgdQxlhMNyqN	6631	Almond Croissant	Pastries	5	8.42	2025-06-10 13:41:05	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	carlos.delacruz	2025-06-10 13:41:05
14c200d5-1f63-49e9-afe7-b7738cbb502c	U3TgSwjzOr6J4xg13DXp	6632	Apple Turnover	Pastries	4	154.54	2025-08-16 00:03:45	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	fernando.cruz	2025-08-16 00:03:45
02ec1d3b-a6dc-4433-8fe5-f10558013d0e	Prjle05dxHCWn2ZsEoZW	6633	Espresso	Pastries	2	195.76	2025-06-22 03:31:30	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	gabriela.mendoza	2025-06-22 03:31:30
1c2befc1-b5d5-4ada-bd0f-18d86b40da45	a4rSZjdG1eItSa4AcELi	6635	Macchiato	Pastries	4	93.97	2025-09-15 21:36:26	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	isabella.delacruz4	2025-09-15 21:36:26
fb15ac1e-7170-40e1-86d6-8cd2942bc561	coJN33JNZ7RYJi8qsLuh	6641	Americano	Pastries	3	80.96	2025-08-01 14:46:29	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	elena.fernandez11	2025-08-01 14:46:29
b91b6f4a-2634-4062-9f38-4a8d045138dc	mOA1TGH4wVmXvujsE2pd	6642	Mocha	Pastries	4	61.74	2024-12-06 10:33:53	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905506185	fernando.cruz	2024-12-06 10:33:53
3dd59d02-2c9c-4473-bf86-bc53761ba08d	IHYi6DL2m1bgiR3I8Hjf	6643	Macchiato	Pastries	5	93.97	2025-11-02 09:37:53	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	sofia.reyes9	2025-11-02 09:37:53
d8aa9b34-01cc-40d8-9b3a-28e533194df8	LywtC5HdOK3kTG8jpZjh	6644	Iced Coffee	Beverages	5	107.80	2024-12-26 08:10:34	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.reyes9	2024-12-26 08:10:34
ea5fb5a4-ee83-4de3-af68-4af93e7c7d44	jsSegm4lOxH7LsiEjZZr	6658	Flat White	Pastries	2	113.21	2025-08-15 00:49:34	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	sofia.reyes9	2025-08-15 00:49:34
070569bc-312a-4411-afca-2a5772165be9	fTjziECBBx3ek1yqlXqM	6664	Flat White	Pastries	3	113.21	2025-10-10 07:45:40	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	fernando.santos8	2025-10-10 07:45:40
ff49195c-6cb1-41d4-8aae-3231cd2e6348	LvdoA9dG4LAu6QIgkK6i	6671	Flat White	Pastries	4	113.21	2025-03-19 10:49:08	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.torres2	2025-03-19 10:49:08
dea969ed-1e91-4c28-8175-9de41460ecc6	Aktymbv2f0hSNy1AdTNW	6673	Flat White	Pastries	1	113.21	2025-11-17 05:31:44	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905534215	elena.torres2	2025-11-17 05:31:44
9a1c2976-17a8-4221-8797-2854038c0ac5	LksnmR8i6a6cngtYrFxT	6677	Apple Turnover	Pastries	3	154.54	2025-05-30 15:20:24	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905691617	rosa.cruz13	2025-05-30 15:20:24
42e15b1a-6305-46d8-81cc-a148737651b5	WWi43qIXT1zIoL8uGDaO	6679	Cappuccino	Pastries	4	76.25	2025-07-30 13:56:46	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905737180	fernando.cruz	2025-07-30 13:56:46
800f05f6-fc50-4c60-b9d1-340f6c322dfe	V5fIqxagdcYPxthQTWGA	6681	Iced Coffee	Beverages	4	107.80	2025-08-29 17:30:48	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905934913	rosa.rivera7	2025-08-29 17:30:48
d0c52cc7-8d0d-4de7-80f5-584b9ba71da6	IpvHnso8VIQquoFgyamR	6685	Eclair	Pastries	4	146.12	2025-07-14 23:34:44	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.delacruz	2025-07-14 23:34:44
b6403781-27c9-4358-931c-23000e84b3f1	supln90ct71QYQYia3C7	6687	Chai Latte	Pastries	4	100.50	2024-12-09 07:22:23	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905142695	admin	2024-12-09 07:22:23
86709521-4918-4e2d-973a-0303e7d1876b	vVQYXTzzJZbg13QyHNJK	6688	Chai Latte	Pastries	3	100.50	2025-03-08 06:37:58	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905808020	carlos.delacruz	2025-03-08 06:37:58
8f5c230a-8d5a-48eb-ba70-516e99b31ace	Lj8OhjZTIb6Za9QPFOxc	6691	Blueberry Muffin	Pastries	3	185.15	2025-01-18 14:07:10	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	elena.torres2	2025-01-18 14:07:10
e5439d0a-6d6b-4d00-a689-9e008ff24e22	fMBD3aKSKq0FQwqWmOFm	6693	Apple Turnover	Pastries	1	154.54	2024-12-13 12:06:48	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	fernando.santos8	2024-12-13 12:06:48
ae78cadd-98ca-4d17-8012-aea705c06cb7	HlK0bvmZM7sPBq5aZLCN	6694	Tea	Beverages	2	106.18	2025-11-09 22:08:13	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	elena.torres2	2025-11-09 22:08:13
0fb81bec-fefa-44d2-9f5c-b487caa881f0	OKeDmgTC8rJOK1J8Kv5u	6699	Espresso	Pastries	5	195.76	2025-11-05 15:01:09	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905097582	carlos.delacruz	2025-11-05 15:01:09
16f800d8-5e5b-4399-9c3b-e5da8c357951	QQ87cVffQ8Y8jutIFKKK	6700	Baguette	Pastries	2	133.77	2025-05-18 17:11:33	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905998323	carlos.cruz12	2025-05-18 17:11:33
e6ffca5d-7633-41c9-9d47-cd6af564e862	N5h4O8K5Ym0vA4ZsxrwO	6702	Tiramisu	Pastries	4	196.55	2025-01-23 07:38:26	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	sofia.reyes9	2025-01-23 07:38:26
2ceede0c-982d-42be-b97c-17271bb0b074	f0r1L1bYVuoCLkbdj8eJ	6703	Apple Turnover	Pastries	1	154.54	2025-05-22 19:00:12	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.santos6	2025-05-22 19:00:12
4fe10ac9-68dd-4ba1-bcd9-ccf5c051c100	lMeRUjbpVpSDU4zqNRHp	6708	Latte	Pastries	4	108.74	2024-12-10 15:33:03	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	ana.rivera3	2024-12-10 15:33:03
86572f96-a1b9-40aa-b996-94b79f15521e	DMKjo0pAAoHPXimZkQrM	6709	Chai Latte	Pastries	1	100.50	2025-03-13 21:38:57	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	admin	2025-03-13 21:38:57
7a9590ba-6ff5-4437-a4c1-019be33953fd	QD4ha4pjKeHM7qXrv2eW	6712	Latte	Pastries	4	108.74	2025-10-08 04:01:14	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	isabella.delacruz4	2025-10-08 04:01:14
0f29019f-bc7a-4aa0-aa56-dc40ff732013	Vr4o2Br2KnnT8EsSB6ri	6713	Tiramisu	Pastries	5	196.55	2025-10-28 20:11:29	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	fernando.santos8	2025-10-28 20:11:29
11ebc9f7-a020-48a7-add4-fc1dad5eee54	GnVRQTYMX4VBf0ZdwSMa	6714	Mocha	Pastries	4	61.74	2025-07-03 22:55:10	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.santos8	2025-07-03 22:55:10
a1daf1ea-7d30-4416-ac7a-9a1d277613b8	PZlg0fXzJc5qnNCiKnCv	6716	Chai Latte	Pastries	4	100.50	2025-07-17 15:57:22	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	carlos.cruz12	2025-07-17 15:57:22
38e88b2c-6e78-4cd4-90dc-e80bef0f97ff	IdEQ7WKZcAqip6aMNiRc	6721	Apple Turnover	Pastries	3	154.54	2025-06-17 03:22:10	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	admin	2025-06-17 03:22:10
0d255aeb-3060-411f-b2f7-e216bc6fc5b0	UTnqeeSddGC88rdbgkNE	6724	Blueberry Muffin	Pastries	5	185.15	2024-12-15 17:12:36	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905353063	miguel.cruz15	2024-12-15 17:12:36
64a93902-253b-420c-bd90-f543381bd5d7	kUYlqdpl0G9HcdHp3eYP	6725	Americano	Pastries	1	80.96	2024-12-18 14:36:39	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	sofia.reyes9	2024-12-18 14:36:39
152c0692-d91a-47fe-99de-0c38a8494620	3EmZ9cHkW1eSc6xFob7f	6733	Chocolate Chip Muffin	Pastries	2	103.79	2025-09-11 09:28:54	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.rivera7	2025-09-11 09:28:54
96c088b3-3916-4780-9c9b-7dcb4b44476d	v6fHY358VnNSrnnxP444	6735	Iced Mocha	Pastries	1	144.00	2024-12-11 23:12:59	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	admin	2024-12-11 23:12:59
c81da39f-2c8c-4783-b967-0f37fbaa331d	dSZAwtmWY1AWGAfybOtX	6738	Espresso	Pastries	3	195.76	2025-09-19 11:38:56	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.mendoza	2025-09-19 11:38:56
15469874-d83b-4ed4-8e0d-d281c0467b64	0vbfDA6TEhtROtlQg4x8	6747	Mocha	Pastries	5	61.74	2025-09-21 23:20:39	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	antonio.delacruz10	2025-09-21 23:20:39
58ae3b75-c738-41ab-afe7-f9b01c8c50e8	WmSENEMG8Gf1edjAj2DW	6749	Red Velvet Cake	Pastries	4	187.25	2025-02-11 06:08:42	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	sofia.reyes9	2025-02-11 06:08:42
23cd0869-0edc-44fb-8144-e2269dbce14d	auwlvgdaW9HJPyCWrhv4	6750	Eclair	Pastries	4	146.12	2025-09-10 13:17:05	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	rosa.rivera7	2025-09-10 13:17:05
0122078d-8f13-4200-9ccb-c8933214625a	poXMIFgyq50qSEN9VgLs	6751	Almonds	Pastries	5	5.59	2025-08-19 13:14:35	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905056260	isabella.delacruz4	2025-08-19 13:14:35
5ba091be-2533-4d66-b7a1-1b46662bb9d6	CkmZrB41tCQmXCZrc0dQ	6752	Espresso	Pastries	1	195.76	2025-09-04 19:11:19	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905174967	sofia.bautista5	2025-09-04 19:11:19
f088a912-a372-4423-8841-b870f96166e1	iebVe2QGAD6rWNHurU4F	6753	Red Velvet Cake	Pastries	3	187.25	2025-03-01 22:02:36	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905064813	carlos.mendoza	2025-03-01 22:02:36
fe6ff4f8-d533-4500-9e3c-5bf438114288	x8OIky3i4oooRbXr1bNS	6754	Cappuccino	Pastries	5	76.25	2025-05-25 06:52:56	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.santos8	2025-05-25 06:52:56
1af30c68-985e-466b-ab14-ea9e88957314	efIWqNVmCF61a7HVUfuN	6759	Baguette	Pastries	2	133.77	2025-09-19 12:42:18	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.cruz12	2025-09-19 12:42:18
42ff8fb9-5f50-42c5-9e4f-8994cca1ac9d	CTDz5sOA3BczVwFyl9qP	6761	Flat White	Pastries	1	113.21	2024-12-10 20:26:51	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.torres2	2024-12-10 20:26:51
31286aba-3175-4a22-8466-8d4b3b734b0a	BvyRu9hXPuri2B4nauHT	6765	Iced Coffee	Beverages	4	107.80	2025-06-11 14:34:53	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	ana.rivera3	2025-06-11 14:34:53
28f87f60-c062-409e-8657-a58f28680018	9AAFx9pJ0UaYeUzc6BLe	6768	Eclair	Pastries	3	146.12	2025-08-16 06:14:01	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	sofia.reyes9	2025-08-16 06:14:01
856701be-fceb-4e03-a46b-5e7a6c6d2f9e	3g2LOuHMlQiPyMfBJM9m	6769	Almonds	Pastries	2	5.59	2025-03-30 21:05:15	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	sofia.bautista5	2025-03-30 21:05:15
63961a04-8940-4a56-aa09-e5b84dbf6e17	m0s2OYyucDtBsdA3RMvx	6781	Mocha	Pastries	1	61.74	2025-01-05 23:58:21	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	isabella.delacruz4	2025-01-05 23:58:21
1a11bbc5-140d-4374-a44d-1dac56ebf1f8	sTiUH5UNvpAdT5oBOjwi	6783	Flat White	Pastries	1	113.21	2025-03-16 16:03:51	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	fernando.santos8	2025-03-16 16:03:51
aeec8685-ba7d-47a3-830a-7fabc193ac15	kINZuWpLTKDaaRDDcb0E	6787	Latte	Pastries	3	108.74	2025-05-07 10:46:34	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	ana.rivera3	2025-05-07 10:46:34
aaf7daa2-acb3-4974-8895-6e4f1e9bf827	fo8EmyRK0iceNbpdk4Kp	6794	Iced Mocha	Pastries	5	144.00	2025-10-20 01:46:13	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	elena.fernandez11	2025-10-20 01:46:13
2041bdf7-a274-4a27-b3da-44dcb8f96ab4	pus56CZThZxD4sBGuAu6	6795	Latte	Pastries	3	108.74	2025-10-07 21:25:19	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.cruz13	2025-10-07 21:25:19
c8402487-b9d3-43f4-8f8a-4ff928e52aeb	16QpwBhilT02jZJO87lK	6798	Chai Latte	Pastries	1	100.50	2024-12-11 23:13:45	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	elena.torres2	2024-12-11 23:13:45
96314797-307c-49aa-bdf9-3597ebf00339	6lWSacO5pVnr8afbfDbZ	6799	Baguette	Pastries	2	133.77	2025-02-05 20:40:58	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.bautista5	2025-02-05 20:40:58
3a8e4c0e-afe7-4638-b142-430a11a75ad3	o4eul5dIdk3SuzK5MsKj	6804	Almonds	Pastries	5	5.59	2025-04-17 18:25:52	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905471439	sofia.reyes9	2025-04-17 18:25:52
313fa750-6dbf-4a62-8563-a3d85777905b	rdDUaf7UUURb89cwJPjL	6805	Red Velvet Cake	Pastries	1	187.25	2025-08-01 15:56:32	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.fernandez11	2025-08-01 15:56:32
4b85410d-e0cf-43f9-bee5-16fbb3c2b201	oSmU0D2A4kBabGvcUjAw	6806	Hot Chocolate	Pastries	2	131.53	2025-02-05 08:55:32	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	fernando.cruz	2025-02-05 08:55:32
ff091e55-edcd-4c71-87d0-5b43cb6a3dbc	0eEsVaXRatZuuaNPW2LP	6807	Chai Latte	Pastries	2	100.50	2025-02-19 03:53:15	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carlos.mendoza	2025-02-19 03:53:15
758639a3-d46e-492d-b4f6-63e1db9505b6	FUOSDCLBXg98VJNAg4NO	6809	Mocha	Pastries	5	61.74	2024-12-23 04:47:48	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	elena.torres2	2024-12-23 04:47:48
f037388f-a740-4f4c-b7e4-013c4de714f0	8l3MLnMwxeg7PRVK3aDw	6813	Americano	Pastries	4	80.96	2025-10-05 10:23:08	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.rivera7	2025-10-05 10:23:08
58227db8-4e1d-474b-97ab-e6ede5fec324	UnHr89mP8YGtdaYfKGgt	6815	Almonds	Pastries	1	5.59	2025-07-19 19:36:47	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	elena.torres2	2025-07-19 19:36:47
393043a7-3c55-4336-83a1-044ee788e858	tryTz3B4Fd6vukN3WkXd	6823	Mocha	Pastries	1	61.74	2025-11-08 09:28:40	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	isabella.delacruz4	2025-11-08 09:28:40
d00efb3c-f57c-473c-8b77-70dac91fb5db	EiPIXAl8FfTJmCiYXlPD	6824	Iced Mocha	Pastries	1	144.00	2025-02-21 09:23:09	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	elena.fernandez11	2025-02-21 09:23:09
9150dfb3-9e46-4ebb-b922-1199c4c84669	3cfFGbH9LSGj4DU3knWH	6825	Blueberry Muffin	Pastries	4	185.15	2025-07-02 11:35:23	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.cruz	2025-07-02 11:35:23
ddec2019-e876-483a-be2e-540e17ea00ac	IeNvkuBesbTeByKMRMVV	6827	Latte	Pastries	5	108.74	2025-01-03 18:50:55	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.cruz12	2025-01-03 18:50:55
ac58a216-603a-46b8-96f0-dc48b30d0464	y9XDrlyWWkSe3kAoq8nF	6838	Tea	Beverages	3	106.18	2025-02-14 05:31:59	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	miguel.cruz15	2025-02-14 05:31:59
129d5c0c-a5dd-4824-a064-98207b933d74	KZ9ad76RESH4jmjX7IoD	6841	Almond Croissant	Pastries	2	8.42	2025-09-10 03:40:19	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.mendoza	2025-09-10 03:40:19
37099019-f928-4389-94cd-03ca6d28e355	V9nA90X9qZBGxhAOPGMt	6844	Tea	Beverages	3	106.18	2025-09-24 16:02:04	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	fernando.santos8	2025-09-24 16:02:04
a948c253-23e3-47f2-abfd-a958d62ded4d	CwcFtiKbmNtL0vTvRDLV	6845	Iced Coffee	Beverages	2	107.80	2025-09-14 11:43:08	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	elena.torres2	2025-09-14 11:43:08
efcf9316-04a4-41a4-b1d3-a1ba6bc87e1e	gBIxcttMzl90Hn3P0mOS	6847	Cappuccino	Pastries	4	76.25	2025-05-18 02:50:45	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	gabriela.mendoza	2025-05-18 02:50:45
f62a0872-8d15-4ff5-a482-860932807317	TNy9uLmJKV62fLEeOJ4P	6851	Flat White	Pastries	5	113.21	2024-12-04 14:23:04	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905546495	antonio.santos6	2024-12-04 14:23:04
cde9d009-046b-469a-a95a-73509ac9c892	L96afboYGOwP6buKHg0J	6852	Blueberry Muffin	Pastries	5	185.15	2025-09-24 06:18:34	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905439110	elena.fernandez11	2025-09-24 06:18:34
0fbc0797-cab3-43b3-90d7-f1c3d16a5383	S1e19SOVz1kypVh7LxDN	6855	Almond Croissant	Pastries	5	8.42	2025-01-15 01:40:18	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	antonio.santos6	2025-01-15 01:40:18
6cd3e02d-9cdc-4872-9cfb-49d08520e6b9	UcPTtPC1GqcnDyjnozon	6861	Blueberry Muffin	Pastries	2	185.15	2025-07-02 06:56:12	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carmen.santos1	2025-07-02 06:56:12
292a8d0a-d3de-4cee-a033-d3fac14f8890	vuDT2KYYR6MzI6vwIUUM	6863	Iced Mocha	Pastries	5	144.00	2025-10-13 12:01:40	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2025-10-13 12:01:40
a2bd0866-f55f-49d9-b441-6987b2e8ba14	Oz8mBFkwkk4Jv0EnUIMl	6865	Tea	Beverages	3	106.18	2025-01-08 01:02:11	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905970905	gabriela.mendoza	2025-01-08 01:02:11
a70c4234-f4cf-462b-aaae-26c5d1b206be	sM2VeSbvhamKDnvIxEan	6868	Macchiato	Pastries	3	93.97	2025-10-23 21:42:15	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	fernando.cruz	2025-10-23 21:42:15
35cc2c96-a2bc-4a9b-877c-8e5a3925bf18	tRqGEl948UX1dIypWQYG	6869	Almonds	Pastries	4	5.59	2025-01-07 14:30:44	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	rosa.rivera7	2025-01-07 14:30:44
386e1205-0f31-433e-9dd4-af580d9bec2e	f62XRv2hkydcqH90Ddos	6870	Iced Coffee	Beverages	4	107.80	2025-06-06 18:51:14	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905923494	fernando.santos8	2025-06-06 18:51:14
5a57af49-3b75-4c14-ab4b-1824300ce6e4	yBHaaa2xQO41kJcoYNFI	6871	Americano	Pastries	4	80.96	2025-09-20 18:20:04	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	pedro.cruz14	2025-09-20 18:20:04
213e068f-c92e-4a08-8e1e-9784e5b64c59	iaBgLl2flP4bfYX4bIRZ	6872	Americano	Pastries	2	80.96	2025-01-17 21:11:18	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905925235	isabella.delacruz4	2025-01-17 21:11:18
648bfa2e-aa84-467b-a8b1-be3ff0e02de7	CkPtFTdBwWN2bMQA1NLn	6873	Tiramisu	Pastries	1	196.55	2024-12-07 05:17:01	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	pedro.cruz14	2024-12-07 05:17:01
6acd7644-a802-4312-b33f-9f4e1589039f	6pllVlB7TEG4SmTitOhe	6874	Blueberry Muffin	Pastries	4	185.15	2025-10-21 11:52:12	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.cruz13	2025-10-21 11:52:12
b9669767-9707-400a-855c-99e1aabaf855	KvuadUlVP8ghojEsyudF	6875	Americano	Pastries	5	80.96	2025-07-25 19:42:47	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905451731	fernando.cruz	2025-07-25 19:42:47
fe09b604-a0e1-41a6-a46d-d0b5a7e8a140	Ql9iNCVPQPtFHiBordIu	6876	Mocha	Pastries	4	61.74	2025-07-26 12:15:45	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	miguel.cruz15	2025-07-26 12:15:45
d89cc617-d069-4ef1-af8d-4dfc3da98173	P9yFb40bX2AzhEcs149T	6878	Hot Chocolate	Pastries	5	131.53	2025-09-09 22:32:49	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	carmen.santos1	2025-09-09 22:32:49
90a64234-4b59-4fd0-8c72-81977cbbcc24	Raqt0bmaZiH4Qn93YvpJ	6881	Chai Latte	Pastries	4	100.50	2025-10-17 12:01:12	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	antonio.santos6	2025-10-17 12:01:12
6f2676bd-6e4f-4736-814d-f8e2d1affcd9	BTLjmQi3XmA8Z2qo4oO1	6887	Flat White	Pastries	4	113.21	2025-04-30 20:00:02	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905543916	carlos.mendoza	2025-04-30 20:00:02
0c800d47-d976-4313-b832-d022c82c9f47	vFOw5O9S16n2RhgLQ91V	6888	Hot Chocolate	Pastries	2	131.53	2025-11-03 01:44:13	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	rosa.rivera7	2025-11-03 01:44:13
a773b2b5-4f17-4284-8ada-bae425ecdad3	z5Gx3OqivfDbH8wqIQND	6893	Almonds	Pastries	2	5.59	2025-05-01 07:45:51	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carmen.santos1	2025-05-01 07:45:51
a05786cc-6ace-403a-aa94-66a31ca1ca1a	vIGdfhz634CM1F978OTx	6896	Tea	Beverages	3	106.18	2025-07-25 14:29:56	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	fernando.cruz	2025-07-25 14:29:56
795206a7-0211-41d2-82ee-a4f678f65d9f	TIBVXRtdIQJvOQUj4Zh0	6899	Iced Mocha	Pastries	1	144.00	2025-11-12 09:50:21	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	sofia.reyes9	2025-11-12 09:50:21
7f4b7593-ec52-4298-b8d7-c36d3ec65015	YfFXUovBFAo8aJV9hvuN	6902	Iced Coffee	Beverages	1	107.80	2025-03-30 04:17:46	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	miguel.cruz15	2025-03-30 04:17:46
155a122e-ad21-4914-86b6-a64b0393f720	Ap3jLu6LEWwVgB5KlV40	6903	Hot Chocolate	Pastries	1	131.53	2024-11-30 04:23:00	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905716312	elena.fernandez11	2024-11-30 04:23:00
a21de648-39f2-4e53-a720-cd1681f7cd4b	iATbCTc7wvZYEHa0j9Lt	6905	Red Velvet Cake	Pastries	4	187.25	2025-05-04 04:39:22	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905465923	rosa.rivera7	2025-05-04 04:39:22
2df959ef-1c74-4341-a868-af0ec85f0d45	UOOEcH9cU0GmZicjzlh3	6907	Iced Coffee	Beverages	5	107.80	2025-05-11 02:17:37	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	admin	2025-05-11 02:17:37
720df96e-84ff-484f-be2c-7a9869026b63	BYlargHBv4zRxL7AQhaw	6912	Hot Chocolate	Pastries	5	131.53	2025-01-31 03:09:15	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.torres2	2025-01-31 03:09:15
9aaf4965-56d0-4d61-bfbc-a952f40a9eaa	Fqv50XVd8w5NFimNBtUX	6915	Apple Turnover	Pastries	5	154.54	2025-08-25 10:40:08	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	gabriela.mendoza	2025-08-25 10:40:08
7770b7c3-9569-46a9-98eb-a41af9dfc223	L5YSPM5zYNhmc0bDwxsd	6923	Hot Chocolate	Pastries	2	131.53	2025-06-30 14:04:58	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	elena.fernandez11	2025-06-30 14:04:58
f0e13cff-db68-480c-8056-d3b77fc4b301	zsnAlT7EvWfMJJszjxST	6930	Hot Chocolate	Pastries	5	131.53	2025-07-01 19:47:24	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	fernando.cruz	2025-07-01 19:47:24
37985f55-9450-4c4b-a990-c40d856b82c8	RI0iH19cG3IXJhlN0xj4	6932	Flat White	Pastries	3	113.21	2025-07-16 05:25:19	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	antonio.santos6	2025-07-16 05:25:19
ed681198-3747-4f2f-942c-6d8ef4f055b8	46yzYFWJTHTi32F3oylX	6934	Flat White	Pastries	1	113.21	2025-11-23 10:18:22	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905646623	miguel.cruz15	2025-11-23 10:18:22
92e41e34-bd89-4a64-a631-a946a3437bcf	aUkr2GYl1k34gsVKLOzn	6936	Almond Croissant	Pastries	3	8.42	2025-11-04 11:09:23	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.mendoza	2025-11-04 11:09:23
2267aedc-df91-431e-92c3-fde9a0442bf7	Ui0uKX8On3uJOmbCcdlH	6938	Latte	Pastries	3	108.74	2025-08-22 20:11:11	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	gabriela.mendoza	2025-08-22 20:11:11
1077bded-ad4f-4f27-b619-c0be696d06df	c01O2Mwpm0EMx3Tu0PSv	6941	Blueberry Muffin	Pastries	1	185.15	2025-05-17 10:59:43	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.cruz13	2025-05-17 10:59:43
bffdaed2-e40c-4a65-951f-4905df021990	AJUEVBkoRBCPoIEJLWI2	6942	Eclair	Pastries	5	146.12	2025-09-25 06:39:53	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.delacruz	2025-09-25 06:39:53
4ec64b5d-e351-404d-9756-c37eff7954b0	DEnjGpyvhCCIyiWsQWSo	6944	Macchiato	Pastries	1	93.97	2025-07-08 16:36:12	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905962432	antonio.santos6	2025-07-08 16:36:12
83f87956-8549-4fa0-831d-23a6b5586df2	sohkchHACUgsAzXxcRQd	6953	Almond Croissant	Pastries	1	8.42	2025-06-19 08:54:50	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905147411	ana.rivera3	2025-06-19 08:54:50
a6460d89-d4a5-4974-ac99-4776a9c06b39	geO4oksTx3Av1G8la6tA	6956	Espresso	Pastries	4	195.76	2025-01-11 09:32:18	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905553766	fernando.santos8	2025-01-11 09:32:18
8d7d30a5-66f1-4b2d-b77a-83a56753ddcd	FWwrWr82MbArgczatjUz	6957	Red Velvet Cake	Pastries	5	187.25	2025-05-22 12:49:07	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905401917	gabriela.mendoza	2025-05-22 12:49:07
2adfc369-b611-45b1-9f1d-3da5f10dd840	U1RiWyh0PzY4RhniGu5F	6964	Blueberry Muffin	Pastries	3	185.15	2025-08-02 17:27:10	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carmen.santos1	2025-08-02 17:27:10
96595ff5-c196-4043-8add-c2e6eca6a669	HiGzQagtqCK8OaozYfRJ	6966	Espresso	Pastries	3	195.76	2025-01-15 04:58:15	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	fernando.santos8	2025-01-15 04:58:15
7fd6f3f6-2727-4260-814e-70442d511a1d	wYUNxttvNVqiyNBWIxmU	6969	Apple Turnover	Pastries	2	154.54	2025-09-29 15:42:32	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.delacruz10	2025-09-29 15:42:32
afec5557-7918-44a4-bdf9-cd45a194fead	EBYv7l28u1n2Ts0b4mkl	6971	Tea	Beverages	1	106.18	2025-08-23 05:35:34	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905492401	sofia.bautista5	2025-08-23 05:35:34
1a4e1c62-c294-4154-bdd0-769840434588	eTUc604DSFbKy7oSlNmL	6980	Blueberry Muffin	Pastries	2	185.15	2025-10-14 10:18:28	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	rosa.rivera7	2025-10-14 10:18:28
2bc70c27-3945-4d74-97b7-8919dae4b1f3	LTwJmBbhPjCZMJS3Qakr	6987	Almonds	Pastries	4	5.59	2025-08-07 08:17:10	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905944423	carlos.mendoza	2025-08-07 08:17:10
0b968e1f-0872-4335-aa9b-41d2c6950f3e	ESa4k7nPs9eobodFVZZT	6988	Baguette	Pastries	4	133.77	2025-06-30 03:58:40	c8d156d2-b289-439f-90bc-692447063015	Card	\N	carlos.delacruz	2025-06-30 03:58:40
1c353f9c-f618-41b3-99d5-936a5c1b8999	fHVMzKsFXOciW7OESkJC	6989	Iced Coffee	Beverages	4	107.80	2025-04-19 23:40:13	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.reyes9	2025-04-19 23:40:13
a1bc60fb-c7b7-4e2e-b961-a3628f0a6cfe	5uR3MJQK23YhHlyDVSRg	6994	Americano	Pastries	4	80.96	2025-10-30 05:14:58	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	pedro.cruz14	2025-10-30 05:14:58
d9a77a27-c402-483d-a518-43ca3aa6de8c	29fYGCcsw1eRMZAgVBhz	6996	Espresso	Pastries	4	195.76	2025-07-23 14:54:40	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	ana.rivera3	2025-07-23 14:54:40
3f98247c-0930-4a32-9e92-7f21c5e01083	kp3v59rBb3RJmU2vqF0d	7004	Glazed Donut	Pastries	5	148.75	2025-05-06 20:51:37	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.bautista5	2025-05-06 20:51:37
d8b6d250-c72f-4b1f-80ea-be491ee6f279	1DkTmgwfTXJUSG6OxwLU	7016	Tea	Beverages	2	106.18	2024-11-28 19:10:30	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	isabella.delacruz4	2024-11-28 19:10:30
c8d5b093-7f9d-4c23-bb11-b95b592327e9	XTdfp2dgXLPBkNCWMIHJ	7017	Cappuccino	Pastries	2	76.25	2025-09-23 04:34:16	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905372712	pedro.cruz14	2025-09-23 04:34:16
cfd453e7-ec42-4272-9cba-a47cd2c441aa	Uqy3pRe0A4fyjmAtlNfe	7023	Latte	Pastries	2	108.74	2025-07-21 08:16:54	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	pedro.cruz14	2025-07-21 08:16:54
000399ff-1361-46b9-97dc-49866ad5f873	M3aVvb7d4TTKNy6v02x5	7027	Glazed Donut	Pastries	1	148.75	2024-12-15 23:01:46	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.delacruz	2024-12-15 23:01:46
a23646ca-d290-41be-9c34-89062cc37d38	mXPeOSEfCiOwKcq9LHUe	7028	Iced Coffee	Beverages	5	107.80	2025-10-12 20:54:09	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	antonio.delacruz10	2025-10-12 20:54:09
b1f8787d-7151-4f3f-a8de-f756cca763ce	8FefEr35N77IL1Bd88Go	7029	Eclair	Pastries	3	146.12	2024-12-31 05:18:54	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	rosa.cruz13	2024-12-31 05:18:54
12021dc7-accd-4924-877b-aa8a126e0fbe	6EPbV83oFsaRA0K50lCU	7030	Almonds	Pastries	1	5.59	2025-11-14 23:17:22	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905515851	antonio.santos6	2025-11-14 23:17:22
51960e0c-6ded-48a6-9c94-32c2b71f7242	InktLk3RSlemCkOAwFny	7031	Hot Chocolate	Pastries	2	131.53	2024-12-14 11:58:16	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.mendoza	2024-12-14 11:58:16
b9b54479-8915-4d43-86fc-4ccdf0301d17	6XW3Jn9gwl7Ge7A4VeRQ	7032	Tiramisu	Pastries	4	196.55	2024-12-29 16:57:59	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	admin	2024-12-29 16:57:59
029a4b58-47b7-4bd2-9985-1938df5e49ca	H9j74GyD3eQSpSo9NnSl	7034	Macchiato	Pastries	5	93.97	2024-12-08 13:24:10	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	pedro.cruz14	2024-12-08 13:24:10
ae7febf8-beff-40aa-8d18-3d98b9dd1cb0	cSiW2wrYrgUH4AhS9Ugw	7035	Iced Mocha	Pastries	3	144.00	2025-01-29 22:39:46	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.santos6	2025-01-29 22:39:46
c9682f2c-1331-410f-9d48-509525e11305	XO8zHpavLL2sphTnLXWj	7042	Mocha	Pastries	5	61.74	2025-09-19 01:33:57	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	elena.torres2	2025-09-19 01:33:57
10affc3f-ac87-4758-88e8-a52f210bf7f4	WN9pIXGsdEDz2NXD7hWY	7044	Mocha	Pastries	2	61.74	2025-07-09 06:26:46	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carmen.santos1	2025-07-09 06:26:46
20e1f830-bea1-442b-a957-362188c89039	okj1uGRZ4PXRlbUdsQbI	7053	Almonds	Pastries	4	5.59	2025-05-28 23:29:44	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	elena.torres2	2025-05-28 23:29:44
0aaca97b-86ab-447a-a1b4-da6f575fad04	WYDVuwQqBvwmUtjDBCWu	7055	Latte	Pastries	1	108.74	2025-03-20 17:11:52	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	antonio.santos6	2025-03-20 17:11:52
2ff08fbd-5186-4f66-8866-af99ba2da0b4	bIemQArONQrKeS2ydm3h	7059	Tea	Beverages	3	106.18	2025-01-23 02:37:22	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	fernando.santos8	2025-01-23 02:37:22
8bfd0cb5-73ee-4a70-af69-43ad34548c4a	P3S5nFa4lpVilFFXnkeb	7061	Americano	Pastries	4	80.96	2025-04-12 07:08:15	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	fernando.cruz	2025-04-12 07:08:15
31d0f7e9-82f5-4457-8f4c-8618c7e6e71c	ArCigcW2VwtEHr6cdiyR	7062	Eclair	Pastries	3	146.12	2025-06-08 10:36:23	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	admin	2025-06-08 10:36:23
11dd745b-9778-4dde-a293-b4ef3c96c674	cc7z5K5oc1FkoCrNzIhF	7063	Iced Coffee	Beverages	3	107.80	2025-08-25 13:32:34	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905209770	carlos.delacruz	2025-08-25 13:32:34
22c2bf5b-1c13-42e5-8ecf-66c444aa32e8	wmfszFMba0YOy28kky3K	7065	Chai Latte	Pastries	2	100.50	2025-08-03 23:34:14	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	gabriela.mendoza	2025-08-03 23:34:14
027d837a-1118-445b-be41-1993497bb27e	QTd0H4QRyZerlaxHpRs5	7069	Eclair	Pastries	4	146.12	2025-10-02 02:59:37	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905675346	carlos.mendoza	2025-10-02 02:59:37
5bdced92-d3b5-482f-b214-b21d0c754efa	NmiLWfxkLWv5N6RAAzAe	7070	Iced Coffee	Beverages	4	107.80	2025-05-14 10:37:41	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	antonio.santos6	2025-05-14 10:37:41
2020ab54-c97f-44f6-8938-53401f33431f	IMYxRryVr4IcSFZjBqe0	7074	Iced Mocha	Pastries	4	144.00	2025-08-29 20:50:16	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	sofia.reyes9	2025-08-29 20:50:16
0eb617ae-82ec-49f7-bf5c-24d30ecdd648	DAmxrLJVyOFwTMytRAfc	7076	Americano	Pastries	4	80.96	2025-02-08 04:51:59	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	sofia.reyes9	2025-02-08 04:51:59
2470bd0f-fab2-4128-9038-9f17b60008d7	lGjYCkzo6o1gmw5hXoCh	7079	Eclair	Pastries	4	146.12	2025-08-16 01:12:12	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.torres2	2025-08-16 01:12:12
d781a397-4922-4e37-b065-389fa39da47d	L3QqCCo27bZEhnDG27tF	7081	Hot Chocolate	Pastries	2	131.53	2025-04-17 19:51:42	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	rosa.cruz13	2025-04-17 19:51:42
ddee1efc-fa0b-42d6-9a2c-2427846ad514	XXMPerpYkv2X08mjjnLP	7083	Chai Latte	Pastries	3	100.50	2025-02-20 11:51:43	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	gabriela.mendoza	2025-02-20 11:51:43
048d1bc2-d37e-4f2a-bd3e-093fcd09adc1	sI5nxuqea75GTpkyFjcj	7084	Chocolate Chip Muffin	Pastries	1	103.79	2025-08-01 21:53:11	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	pedro.cruz14	2025-08-01 21:53:11
27bdda80-e207-4ff5-b116-7a3f7a927856	RulhcI8GOCHTEoVbtLzw	7086	Flat White	Pastries	3	113.21	2024-12-02 11:25:44	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.delacruz	2024-12-02 11:25:44
45380fc8-7b93-4af4-96e2-748be985097d	tmYdAenxCdjTUWVtVZTx	7087	Latte	Pastries	5	108.74	2025-03-23 14:04:40	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.cruz	2025-03-23 14:04:40
65acd40f-e8c9-476a-8864-f9d8800877d6	fm0PvPTkqkcyfqo325vN	7088	Baguette	Pastries	4	133.77	2025-04-21 16:03:36	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.bautista5	2025-04-21 16:03:36
5c411f15-0dc6-4750-91d1-8d4d06b67168	hRYdC1w3PskXqDWEj3KP	7089	Flat White	Pastries	1	113.21	2025-11-14 07:43:49	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.fernandez11	2025-11-14 07:43:49
ddaf6c73-6bad-49a4-98ae-8ef5f9e71fec	9a5MZAb2Pldw7X9fNTTF	7094	Chocolate Chip Muffin	Pastries	4	103.79	2025-08-08 00:37:00	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	elena.fernandez11	2025-08-08 00:37:00
8ecb3ef4-b634-4462-b3e6-322025a0c00d	BoGGoJ6XYgdZcyet3Q6g	7098	Americano	Pastries	1	80.96	2025-04-11 14:46:49	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	elena.torres2	2025-04-11 14:46:49
61301a93-96b0-4032-8c3e-7aa721b505e9	eTULZA0KZHgqFxxSxVhT	7101	Mocha	Pastries	4	61.74	2025-06-06 22:55:46	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905136679	fernando.cruz	2025-06-06 22:55:46
3981d1cc-1fdf-49ad-9f1e-38032c82bffa	E0gmEAXlXXZSDPe0RKrk	7103	Chai Latte	Pastries	3	100.50	2025-05-31 21:39:40	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905744145	carlos.delacruz	2025-05-31 21:39:40
bf0b25bd-ad1b-4efd-b0d1-6a4b452985ee	Ti4dlsNT0l1UcaJbGV01	7104	Cappuccino	Pastries	4	76.25	2025-11-07 18:39:42	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	admin	2025-11-07 18:39:42
9e2b6324-1a1d-4d8f-9bc8-4b8d63e187e9	FjxZyYqtuPcnSWkNgaE5	7106	Flat White	Pastries	5	113.21	2025-05-20 19:17:05	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	fernando.santos8	2025-05-20 19:17:05
84b2116a-a7d7-4570-82f9-d46a7aabec54	nDLzsb2xSE32G9PlXUXV	7111	Macchiato	Pastries	5	93.97	2025-08-18 23:35:24	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	pedro.cruz14	2025-08-18 23:35:24
b4117a0f-b280-4ab3-8350-036518c312df	9b2VJ5kLLS2s2nZK91ou	7114	Espresso	Pastries	2	195.76	2025-03-13 21:26:04	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905961119	gabriela.mendoza	2025-03-13 21:26:04
b7db34c1-065c-41bf-a2d7-55d7a091259e	dekSpiCGz6h8gzzlkpkL	7118	Espresso	Pastries	2	195.76	2025-10-26 09:38:21	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.delacruz10	2025-10-26 09:38:21
55b01bee-1a05-4e5a-8c19-c6ab59d7e609	PkLMAQN7XGvtKn1LQS5n	7130	Flat White	Pastries	1	113.21	2025-07-03 17:58:56	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	rosa.rivera7	2025-07-03 17:58:56
8a3eae06-79db-4084-84f3-0fd8b289b412	76NvxjBaqy3sqNsly8wN	7131	Americano	Pastries	4	80.96	2025-11-05 06:46:05	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	fernando.cruz	2025-11-05 06:46:05
63c16ae8-ab66-40bd-adad-88443d77cca3	pY2ccPDjw7qotDbKHWhf	7134	Blueberry Muffin	Pastries	1	185.15	2025-07-22 17:00:52	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905182339	admin	2025-07-22 17:00:52
cc6a6b51-fc1d-46ce-8086-b811fa897b29	fbjOhKJ8uSm9N4CvKkwP	7135	Almond Croissant	Pastries	3	8.42	2025-06-13 09:53:18	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905552301	fernando.cruz	2025-06-13 09:53:18
12224a34-8e22-4d5e-a340-60045178913c	xAl3PzWmuVzx3ZJatljc	7136	Blueberry Muffin	Pastries	4	185.15	2025-01-01 12:22:40	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	antonio.delacruz10	2025-01-01 12:22:40
975a6adb-9d35-4936-bcab-04413f1f3004	CobntPqTiukAA394L3or	7140	Glazed Donut	Pastries	1	148.75	2025-01-08 21:28:24	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.mendoza	2025-01-08 21:28:24
55235d26-af8e-41c8-9129-8fd7f13f6b6a	8QcsIi6UmxQf7L1cFKVI	7141	Blueberry Muffin	Pastries	5	185.15	2025-04-29 21:37:52	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	sofia.reyes9	2025-04-29 21:37:52
685882af-3e6d-44c2-b144-0d3f4d4b7992	Pb8WrP8XwKSDzi1gf6kf	7153	Red Velvet Cake	Pastries	5	187.25	2025-11-15 09:59:41	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905529871	rosa.rivera7	2025-11-15 09:59:41
83165ae4-7f62-4f61-95aa-4ee3e5aa33bf	oiVD2JueXr5j9G2MTW1M	7157	Iced Coffee	Beverages	1	107.80	2025-10-28 16:01:17	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	rosa.rivera7	2025-10-28 16:01:17
baaabb51-9980-4854-828c-b2a9237bf97a	I1Dbj2E2nn9fF6jKNHhP	7159	Americano	Pastries	2	80.96	2025-02-04 13:19:54	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carlos.delacruz	2025-02-04 13:19:54
de31477e-da5d-4f61-a080-1c8d79121a78	pUaPlFusEQLqwZ7cy6hf	7161	Almonds	Pastries	1	5.59	2024-12-18 06:45:54	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905340077	admin	2024-12-18 06:45:54
cb3e3c78-fb35-4a3d-814f-062d856bc34a	eYV64rFbQwgU5lpyuSVO	7162	Hot Chocolate	Pastries	3	131.53	2025-10-28 01:35:46	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.cruz12	2025-10-28 01:35:46
0e03ba87-2032-4620-8723-258fdb350201	JM7XUud6BxJ2pN9PXruq	7165	Flat White	Pastries	2	113.21	2025-10-07 21:43:01	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.fernandez11	2025-10-07 21:43:01
9f29ec48-f352-440f-abbf-102076a6e130	QkTeHVNjirPQsUr3DDNS	7170	Americano	Pastries	2	80.96	2025-06-15 15:23:25	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	sofia.bautista5	2025-06-15 15:23:25
57d2fe6b-60d2-4617-8fdb-2a944e3d464f	ULk0RzaMz3hOG04rb9Xe	7175	Hot Chocolate	Pastries	5	131.53	2025-04-21 09:07:55	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905618253	gabriela.mendoza	2025-04-21 09:07:55
d7eb5ccd-d1f0-44e4-bf66-690bf26e3efc	aeIKkPUOLZF2auiOn7eF	7177	Tea	Beverages	2	106.18	2025-05-25 05:50:29	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	rosa.rivera7	2025-05-25 05:50:29
8d8c50cb-1ffb-4f55-b234-bd55696c2690	QBVNd0dF8jAsfcc7WuIf	7181	Chocolate Chip Muffin	Pastries	5	103.79	2025-10-01 12:01:14	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	elena.torres2	2025-10-01 12:01:14
869b0bc7-f17c-40f0-a517-288f3e443649	7Ttyq5LzfxtBNS1KOHgO	7183	Apple Turnover	Pastries	3	154.54	2025-03-01 14:17:16	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	fernando.santos8	2025-03-01 14:17:16
2861c7d4-d410-4b55-971a-e89575c94ce3	rtHOC8JbqaGccd64IJ5y	7184	Chai Latte	Pastries	4	100.50	2025-01-01 14:43:56	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905240868	gabriela.mendoza	2025-01-01 14:43:56
00cce4e7-984c-455d-90e2-200799d6b8aa	BgewbMMQixpmVXWPmDbA	7186	Iced Coffee	Beverages	3	107.80	2025-09-01 10:07:37	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	elena.torres2	2025-09-01 10:07:37
7c7face2-1b56-430f-871e-2486ce7b5e91	vcdym51lau3s1k0ddQxA	7189	Iced Coffee	Beverages	3	107.80	2024-12-28 10:59:27	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905057729	rosa.rivera7	2024-12-28 10:59:27
7edb9e66-9591-4fc9-bd16-048f817e1d5b	yOwMApwMza9Xfj8f1WHp	7190	Hot Chocolate	Pastries	1	131.53	2025-05-29 17:33:23	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905579532	rosa.cruz13	2025-05-29 17:33:23
c41d5109-b400-49e3-8119-2d16301181cb	lCmk3TuMLSR0VTpeV26I	7195	Macchiato	Pastries	2	93.97	2024-12-12 13:45:32	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	admin	2024-12-12 13:45:32
7e6e68fe-9d2a-4af4-8087-d7ec1b8a9c34	iHIF9YF7XJIH8EuFCY7K	7197	Americano	Pastries	4	80.96	2024-12-03 02:50:56	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	antonio.santos6	2024-12-03 02:50:56
32ce123d-2685-44b8-bf4b-625d6bea18a6	doUaZ7No7E1n6WQD5ObB	7202	Iced Mocha	Pastries	5	144.00	2025-02-24 15:28:39	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.delacruz	2025-02-24 15:28:39
30ec8f04-9d9a-4047-92a9-7d5122a228cd	NeIlfqOOWx5NOjN3NYYn	7203	Blueberry Muffin	Pastries	4	185.15	2025-03-19 17:55:15	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	carmen.santos1	2025-03-19 17:55:15
ad4fa90e-626c-4f1e-bc69-d4e6f446a737	0PJ5TuW5Bv7JMG2uZ2sR	7207	Macchiato	Pastries	2	93.97	2024-12-14 00:01:32	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905354590	admin	2024-12-14 00:01:32
b101b70c-0c73-4daa-b5e6-48d4135c72c0	AXbpHGcvqWgZM6Rzm8gE	7209	Eclair	Pastries	2	146.12	2025-08-30 22:41:01	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	ana.rivera3	2025-08-30 22:41:01
b63e9dcf-31fc-4706-b4ee-0f1f9a2026d8	FyUatkgQBgqkNeN1kpUe	7214	Mocha	Pastries	2	61.74	2025-04-06 03:30:53	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carmen.santos1	2025-04-06 03:30:53
1805819d-acff-4f70-ad2c-926d68955fb6	6HmY5Z8fLOwt0DXQ4gL2	7221	Flat White	Pastries	2	113.21	2025-07-20 23:50:19	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.cruz12	2025-07-20 23:50:19
496454ec-ad4f-46cf-bf5a-d4ec36383f17	lFGpN9LES2mBKItZSU51	7224	Baguette	Pastries	2	133.77	2025-03-08 13:00:50	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905653700	admin	2025-03-08 13:00:50
9d5648dd-8167-440e-bde8-093aa39ee613	G2jgLQhchbWVYLmTTYGT	7226	Tiramisu	Pastries	1	196.55	2025-10-25 06:07:57	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.fernandez11	2025-10-25 06:07:57
96a56c50-fcd1-4645-a104-f09b6ed58393	wuLOVkFL9VFegL9xlOGR	7228	Almond Croissant	Pastries	2	8.42	2025-09-18 12:44:27	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905257002	carmen.santos1	2025-09-18 12:44:27
86b36d38-7885-4992-b6f3-814b45499452	uNLrSSkf0ZJ41UjFBdtd	7230	Americano	Pastries	3	80.96	2025-06-30 13:41:05	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	isabella.delacruz4	2025-06-30 13:41:05
695ccde2-5793-47fd-8ebb-e2794f0627dd	oUFXeRCnWEfTn5ciZfs2	7231	Chocolate Chip Muffin	Pastries	5	103.79	2025-04-23 16:35:49	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	gabriela.mendoza	2025-04-23 16:35:49
b221d9e2-3a0a-47af-8680-37b7a5ea64a9	j6YumGz3miCeyzZpErXd	7234	Blueberry Muffin	Pastries	5	185.15	2025-01-24 17:43:27	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905626493	miguel.cruz15	2025-01-24 17:43:27
81067cf8-f9a4-4c16-9431-94008e97ed65	ewmimogm8dWPtwgMc0Ru	7241	Apple Turnover	Pastries	4	154.54	2025-02-04 09:10:10	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	sofia.bautista5	2025-02-04 09:10:10
8544d0dc-602d-40aa-9c08-71e663430d8b	P0D8lHknZJ4uijIiO6pW	7243	Almond Croissant	Pastries	4	8.42	2025-11-06 04:15:55	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	gabriela.mendoza	2025-11-06 04:15:55
c1bbbc67-4488-4083-b8c2-f129697fc718	I5WZFkOSIe99SdG4rdpE	7246	Chocolate Chip Muffin	Pastries	1	103.79	2025-02-17 07:55:06	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	elena.torres2	2025-02-17 07:55:06
46994066-4a98-4b60-872e-4f482c64375a	quJPpxwwjbAdC8aDnThS	7250	Hot Chocolate	Pastries	4	131.53	2025-10-05 23:47:53	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	antonio.santos6	2025-10-05 23:47:53
7384b603-bf9d-4bb5-b4bf-8c4b1677ad41	vP0YhSVT3v7AMoG4rtLJ	7252	Espresso	Pastries	4	195.76	2025-11-07 13:42:04	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	miguel.cruz15	2025-11-07 13:42:04
45e7feed-79a1-4200-9718-151871a37cbe	tDRstFGDiTVoPK43cTjI	7259	Baguette	Pastries	5	133.77	2025-02-12 00:16:14	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	fernando.cruz	2025-02-12 00:16:14
8c791140-0167-412d-aab6-55a9f35b71d7	p7DUKyoEKnhor5QfVC3r	7261	Americano	Pastries	4	80.96	2025-10-10 18:57:42	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	fernando.santos8	2025-10-10 18:57:42
0346a0a2-9690-4ff2-ad77-ecb0172b4263	VUkvmddH2GAeXEYS5KFO	7268	Chai Latte	Pastries	1	100.50	2025-07-05 04:48:24	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	rosa.rivera7	2025-07-05 04:48:24
c285c359-ffc4-4b86-93ab-17a97386e29f	4RtHmqC5KJY2vuhiuuni	7270	Baguette	Pastries	2	133.77	2025-10-28 07:38:48	c8d156d2-b289-439f-90bc-692447063015	Card	\N	pedro.cruz14	2025-10-28 07:38:48
ec34aec8-a0ac-4e2a-bc9c-2b266d86e37d	2xupSYuwLafKFsk1aZCc	7272	Apple Turnover	Pastries	4	154.54	2025-06-16 18:55:18	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	miguel.cruz15	2025-06-16 18:55:18
345a0656-86ce-477b-b7bd-a76bb6bddb7a	TkfAc2awMJN8wMVn65jw	7277	Almonds	Pastries	1	5.59	2025-01-15 11:22:12	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905616616	fernando.cruz	2025-01-15 11:22:12
9052cd23-1c0f-49da-bb52-42caf0a21942	wYX5T9GRq849uuTbl4GU	7285	Cappuccino	Pastries	5	76.25	2025-03-21 07:24:03	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905252945	elena.torres2	2025-03-21 07:24:03
d9f1fd05-66d6-4819-a45f-0050b6c6af3c	dIACJezkn01xqTGQihob	7287	Eclair	Pastries	2	146.12	2025-05-05 14:14:57	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.fernandez11	2025-05-05 14:14:57
8c0f840b-67d7-4dcb-88a7-6d2a64777ab0	lglCP5tfYCTu8x6CJ8PG	7290	Apple Turnover	Pastries	4	154.54	2025-03-24 04:35:20	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	sofia.reyes9	2025-03-24 04:35:20
e46b021c-7f50-4dce-a32a-1cef6fdd83bf	5KNB80ItoQ8YYXqEjpHB	7299	Cappuccino	Pastries	2	76.25	2025-06-09 20:04:22	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.rivera7	2025-06-09 20:04:22
385c806b-19e3-4a6b-8de8-5393edac3045	qdJs2Lif4QffZhuPuile	7300	Eclair	Pastries	4	146.12	2024-12-07 13:31:17	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	gabriela.mendoza	2024-12-07 13:31:17
427d62c0-fcdd-4cb3-a0c2-440082ca023b	Kl7nLCZUDS4n7E0PZ5Jn	7301	Tiramisu	Pastries	3	196.55	2025-10-26 13:35:37	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	sofia.bautista5	2025-10-26 13:35:37
ba85af3a-9b26-4047-8f0e-de46925f3e75	4r0E2tWKf5o71RQfRrOL	7303	Red Velvet Cake	Pastries	3	187.25	2025-05-26 09:49:10	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carmen.santos1	2025-05-26 09:49:10
b9ca2848-f4d7-4825-9c1d-873c3e7f2e79	sXFhHeBHmHZZjHQdZf6v	7306	Tea	Beverages	1	106.18	2025-08-03 13:27:28	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	pedro.cruz14	2025-08-03 13:27:28
184bab04-5633-4651-8de7-0b6bd7528911	dJgLsoiJmYgFdUJVnI4X	7312	Cappuccino	Pastries	5	76.25	2025-06-13 00:01:54	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905113932	fernando.santos8	2025-06-13 00:01:54
c9b8c927-f436-4663-9e41-51d9b34b8bac	tCrRkCLoHwl6MwRwEODR	7313	Blueberry Muffin	Pastries	4	185.15	2025-05-04 18:09:02	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.santos6	2025-05-04 18:09:02
160cb113-7007-4726-844e-eb59f3108c1e	E0j8E5j0JMHez8hxCaSW	7315	Flat White	Pastries	5	113.21	2025-05-31 11:51:53	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	isabella.delacruz4	2025-05-31 11:51:53
8068cc73-a40c-444d-8fe8-03257d734e76	tZ5MvULgPaEoCzvOJLw9	7318	Macchiato	Pastries	1	93.97	2025-09-16 07:53:29	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	elena.torres2	2025-09-16 07:53:29
026dc79d-37a2-4271-9ed6-c6874e6ce0b3	cxO6mFXdWVi2XObCnodh	7319	Iced Mocha	Pastries	1	144.00	2024-11-29 18:25:25	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	fernando.santos8	2024-11-29 18:25:25
cbdec607-668e-49e9-b759-b3dfba0188d0	7XClaH9Hn598MAS4nSc2	7327	Almond Croissant	Pastries	4	8.42	2025-10-23 23:04:58	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	sofia.bautista5	2025-10-23 23:04:58
2207a706-541d-472f-b549-859313461c42	xTctFtEHILgW5O02YBbM	7329	Chocolate Chip Muffin	Pastries	1	103.79	2025-08-27 23:50:47	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905445896	gabriela.mendoza	2025-08-27 23:50:47
1772293a-63b7-4b6e-bef6-0f808a84b205	2QUQlBUOmBI8fNYjwgLl	7330	Almonds	Pastries	4	5.59	2025-04-15 07:28:45	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	miguel.cruz15	2025-04-15 07:28:45
44ae815a-c338-4619-8012-4c06b542b644	FfeQ7aAJGS1VyR09q9Gh	7331	Iced Coffee	Beverages	4	107.80	2024-12-22 13:15:52	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905810518	elena.fernandez11	2024-12-22 13:15:52
be55231c-a059-453b-a02e-3c4cb84ccc40	TCPf77DTiS5KnPCL4nSb	7332	Apple Turnover	Pastries	5	154.54	2024-12-08 01:36:05	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	elena.torres2	2024-12-08 01:36:05
12f1f1ff-5368-45ef-b8dd-5adf24985152	MWyPAVK4ixl4FtoSHWxA	7333	Apple Turnover	Pastries	4	154.54	2025-11-06 19:23:14	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905261735	antonio.delacruz10	2025-11-06 19:23:14
cd25dbbb-d822-4158-a235-99764871de4f	J1QhfdwOBrvBl7SwKYzQ	7339	Almond Croissant	Pastries	4	8.42	2024-12-13 23:40:07	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	miguel.cruz15	2024-12-13 23:40:07
d02575b3-e7df-4b2f-a337-66bffb8c6c7b	H0W3RLlj6NE4pSsj5JSL	7340	Latte	Pastries	2	108.74	2025-08-18 08:54:00	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.mendoza	2025-08-18 08:54:00
81524e9b-0a59-4d7e-b858-ee220f639dfe	ekxT9X8KvEIiu9KFPsOy	7342	Almonds	Pastries	2	5.59	2025-02-27 17:49:45	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	antonio.delacruz10	2025-02-27 17:49:45
0a39267d-95b0-4501-b04c-0316231a8e95	Mbhop2U6vFLmajUdhUoe	7343	Baguette	Pastries	2	133.77	2025-02-05 16:02:53	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905710084	admin	2025-02-05 16:02:53
227f6453-37f4-49cd-8aa0-1ab5495d323d	asDucFfy7Yy91dMUz2yv	7346	Latte	Pastries	2	108.74	2025-04-01 11:29:45	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905285369	antonio.delacruz10	2025-04-01 11:29:45
00771364-1bb6-433c-9508-5819f2aabdc8	AxTaZiR4bQu6ZRW5ySl8	7348	Americano	Pastries	1	80.96	2025-02-24 03:55:17	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	miguel.cruz15	2025-02-24 03:55:17
16a60d95-b559-41a7-8a03-8f99ccb82bc0	BLLPNUhH7BFpa0zl4R8v	7349	Hot Chocolate	Pastries	3	131.53	2024-11-25 17:54:50	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.delacruz	2024-11-25 17:54:50
ae34439a-5d72-438f-8c6a-4b868eb52d8d	ZXKWfGV5r1gGGWwe9bBh	7353	Blueberry Muffin	Pastries	3	185.15	2025-03-05 16:44:50	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	sofia.bautista5	2025-03-05 16:44:50
ac800ddd-6ef5-4aad-a6a1-16b4faa5e403	1viEkLsRHqlTlT8yxhcg	7361	Apple Turnover	Pastries	3	154.54	2025-01-04 07:49:50	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	gabriela.mendoza	2025-01-04 07:49:50
01fd8c26-4206-4e3d-8adc-dfef78e29186	v15G14VA4yLO8BW70oUn	7364	Chai Latte	Pastries	5	100.50	2024-11-24 06:50:43	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905405478	rosa.rivera7	2024-11-24 06:50:43
196c9f8f-ab90-4093-b9e8-13afc7a2ff09	BaVAyz9fX6kBylrTWMIg	7365	Blueberry Muffin	Pastries	1	185.15	2024-12-12 07:35:45	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	ana.rivera3	2024-12-12 07:35:45
2301e910-a38e-41c0-a7df-de9117ae306e	lzpb0Io1jPXWnQiGyEv0	7366	Espresso	Pastries	1	195.76	2025-09-19 23:37:19	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	gabriela.mendoza	2025-09-19 23:37:19
904705ab-28de-4952-bd02-2d271a988636	X3HnlmdhBru58WLrrbhX	7374	Almond Croissant	Pastries	1	8.42	2025-10-04 09:30:17	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	miguel.cruz15	2025-10-04 09:30:17
2b980dd4-9570-4d65-b4ae-ecd20ee4f3f9	uMdRMTjbgtuQqVhnpnjC	7375	Chocolate Chip Muffin	Pastries	1	103.79	2025-06-18 18:37:42	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	elena.fernandez11	2025-06-18 18:37:42
f6d82ae4-ab17-47f7-a887-dfcd776b4ccd	238xmMRT1AmM1rXlilta	7378	Iced Mocha	Pastries	5	144.00	2025-09-03 16:44:15	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905377639	rosa.rivera7	2025-09-03 16:44:15
556516df-a7e0-443f-aae6-250e35a24f66	8wN976eGQNFIAK28NI9h	7380	Almonds	Pastries	5	5.59	2025-09-09 16:56:19	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905016277	antonio.delacruz10	2025-09-09 16:56:19
d92ac153-5cb2-48f6-80e5-6471be6cb7ac	8AJTZYpqK765OhiDL2mA	7381	Chocolate Chip Muffin	Pastries	1	103.79	2024-12-28 14:14:07	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.delacruz	2024-12-28 14:14:07
90e4d207-13c4-45e5-83c5-22739111f3f1	9281Qpn63Evtf8CqHDh2	7390	Almonds	Pastries	3	5.59	2025-10-21 01:12:02	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	pedro.cruz14	2025-10-21 01:12:02
8c6ae0a7-8abf-438a-be11-4fe6a5b30358	APR1RBgT48ZuUs2drLho	7395	Apple Turnover	Pastries	1	154.54	2025-04-16 12:31:02	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905488866	elena.torres2	2025-04-16 12:31:02
cbb98ec2-9a65-4b66-8cc1-cb587f3bb3a8	vKY6Dsb9PRuYdN7VPrsC	7397	Chai Latte	Pastries	5	100.50	2025-01-08 19:16:12	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905898390	fernando.cruz	2025-01-08 19:16:12
752540ec-ae08-48b5-9cd8-7355303d1e82	Jx8v2WrO8Hw5NkH3V4en	7399	Espresso	Pastries	4	195.76	2025-02-18 20:59:36	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	admin	2025-02-18 20:59:36
5ddd8ceb-3582-4cd6-987f-4c7fcf860fda	moFgeJZ5UpokHCbQCs35	7401	Glazed Donut	Pastries	4	148.75	2025-06-23 08:16:14	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905564101	pedro.cruz14	2025-06-23 08:16:14
89140a1f-2ae2-4aa5-bea4-092313ad3b2c	tKFhXETTyr9XWJ953ZJC	7402	Apple Turnover	Pastries	2	154.54	2025-01-01 11:58:31	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carlos.cruz12	2025-01-01 11:58:31
237e536d-0dd7-44cc-8ea2-b7bf11aaad23	b8TG1BOeHFIMnn3baWB0	7406	Latte	Pastries	1	108.74	2025-07-16 14:19:44	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905357036	carlos.mendoza	2025-07-16 14:19:44
ed24c918-e98c-4270-8d9d-2c8d1e6e31bf	JDSKOGElNkxewuQv9VoT	7408	Macchiato	Pastries	2	93.97	2025-10-09 08:21:27	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	miguel.cruz15	2025-10-09 08:21:27
bcf06088-04d3-41bb-9ce2-20f34804b7d5	DdHbCWsBhbyQxowo1jbe	7409	Macchiato	Pastries	5	93.97	2025-05-23 09:17:23	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905846637	admin	2025-05-23 09:17:23
baa3cb11-77cf-4af1-91c1-7a5b7257e000	yrIJMJfyXVQYjvB3YjWP	7410	Chocolate Chip Muffin	Pastries	2	103.79	2025-11-13 21:40:53	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.cruz13	2025-11-13 21:40:53
0f1f030c-fff8-4ecd-9ef1-e995c1fe52fe	zmLOcFezDJi1oHBgvCyw	7411	Tiramisu	Pastries	3	196.55	2025-06-26 14:16:02	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	pedro.cruz14	2025-06-26 14:16:02
775870b0-5fc8-4fed-9c04-a579484d133a	zuSz9yyyE3BxGvG1P427	7414	Chai Latte	Pastries	3	100.50	2025-10-04 13:14:08	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	carlos.delacruz	2025-10-04 13:14:08
f9a59ba5-58e2-4aa7-9bac-7b265d49a388	GSph4NdjJk4VUErDvDGr	7419	Cappuccino	Pastries	5	76.25	2025-10-06 20:53:26	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.cruz	2025-10-06 20:53:26
93df5c8b-ee64-4af7-b830-5b24afa86397	CN7lOmy4kcrYIO21Hosi	7420	Tea	Beverages	5	106.18	2025-02-23 00:24:08	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.delacruz	2025-02-23 00:24:08
19de493a-9ba4-47be-8fc7-6a7a247d0497	y756y44NIRiXJ8xSiDMU	7426	Tea	Beverages	2	106.18	2025-07-28 14:28:28	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905427971	fernando.santos8	2025-07-28 14:28:28
d549e3b0-c404-4b09-aad0-3114ca392f47	oyuqX9IFrG6LnceeAhqg	7430	Iced Coffee	Beverages	1	107.80	2025-09-28 15:09:45	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905558617	antonio.santos6	2025-09-28 15:09:45
8ed17805-9459-4aa5-bbf3-5c6a68491377	ezKMabSBSPXSWe8EATHO	7432	Chocolate Chip Muffin	Pastries	3	103.79	2025-01-06 06:33:08	996934ff-5758-44b4-ad0e-4ed9d927901e	Card	\N	miguel.cruz15	2025-01-06 06:33:08
d200c9bc-ee05-4ae4-b7ec-65d7645c938c	1gtwKGmVxyjO0KEjTGvF	7439	Iced Coffee	Beverages	3	107.80	2025-04-23 06:56:56	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905565622	ana.rivera3	2025-04-23 06:56:56
0bab6661-813d-4c9b-9c1a-236997228302	KOdTPi2ls8DlhazJMoUs	7445	Mocha	Pastries	5	61.74	2025-04-04 03:51:06	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	ana.rivera3	2025-04-04 03:51:06
fa7a0316-f742-49d5-9c8a-1c506ba5e0d5	gwtoCTZVUnCVOUUy9aUY	7453	Chai Latte	Pastries	4	100.50	2025-01-08 14:23:08	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	elena.torres2	2025-01-08 14:23:08
a054dc91-2cc2-4ffb-86da-acc7a12f0727	9hmgHDAsN7epjyz4ZSvK	7456	Espresso	Pastries	1	195.76	2025-11-04 12:28:58	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	elena.fernandez11	2025-11-04 12:28:58
24baa66b-6989-4b9a-ac18-5a0f0471b87e	0Bc8sin4n7J5tiMApb2m	7457	Hot Chocolate	Pastries	3	131.53	2025-07-21 05:59:52	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	rosa.cruz13	2025-07-21 05:59:52
81bb3353-15c0-494c-902e-a5747c5e5b5b	GbRDk97JnU8uGallrP3D	7459	Blueberry Muffin	Pastries	5	185.15	2025-07-11 22:56:23	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905679041	antonio.delacruz10	2025-07-11 22:56:23
3b542ac7-deb1-4a36-923a-97964efb4109	vDf65VekPS7rXVZB4ZXP	7461	Red Velvet Cake	Pastries	1	187.25	2025-10-19 05:54:47	22893c15-bd77-4029-b8ca-3bb58becab1f	Card	\N	antonio.delacruz10	2025-10-19 05:54:47
83413d44-5df3-49ad-9b21-a61ed8c94872	svgyeUUiORpJLdKdeyMC	7462	Mocha	Pastries	2	61.74	2025-06-23 22:03:53	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	rosa.cruz13	2025-06-23 22:03:53
bde72553-ed5b-4c14-a291-9cfb15d4ef80	PDjQaZLAicGP1aDkQw9c	7469	Almonds	Pastries	4	5.59	2025-11-06 19:42:56	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.delacruz	2025-11-06 19:42:56
755790bc-5515-476e-9cae-17f8f983d3c5	hh7ZlE7U1eJv3w65OpnL	7470	Glazed Donut	Pastries	5	148.75	2024-12-02 11:03:04	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.bautista5	2024-12-02 11:03:04
f2cb9fb0-8d42-459e-82b7-91ec7502385b	JStG4l0EQgSZAxkGq9YM	7472	Latte	Pastries	5	108.74	2025-10-12 14:56:45	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	isabella.delacruz4	2025-10-12 14:56:45
07b09f6a-37ef-4a19-9c8d-1412d009ebdb	cbghH67ORDc5x4Y6rgJT	7473	Cappuccino	Pastries	4	76.25	2025-10-06 17:11:59	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	gabriela.mendoza	2025-10-06 17:11:59
6b9a874a-f557-43b9-ad31-67f15f11333a	gYF77X0LWyNyPlvGR36P	7476	Glazed Donut	Pastries	5	148.75	2025-01-25 18:09:26	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905619526	isabella.delacruz4	2025-01-25 18:09:26
0981a58b-cd72-4e6e-beab-86901d0f6677	Pq3zILWOeAG1Ugewwgsv	7477	Apple Turnover	Pastries	3	154.54	2025-01-06 05:18:19	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.santos6	2025-01-06 05:18:19
30e97877-20cd-4278-8e23-41f9d6169c1a	tm6h6K5c0RMibxI41EFm	7482	Tea	Beverages	1	106.18	2025-09-09 18:07:21	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	isabella.delacruz4	2025-09-09 18:07:21
110203c3-0818-45c7-be61-f6c330a84797	RDjAlUhENz5Ou1q4SoKq	7488	Chai Latte	Pastries	3	100.50	2025-02-12 22:57:17	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905150421	sofia.reyes9	2025-02-12 22:57:17
12b0080d-20df-4d22-a527-125d0442d8da	HKzeznh29gyTbGvsuRrZ	7495	Iced Coffee	Beverages	3	107.80	2025-06-22 08:49:07	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.delacruz	2025-06-22 08:49:07
c0b269dd-8a0f-464a-857d-11affa0892a3	TEczAAUcmeo8Mu67WeZN	7500	Almond Croissant	Pastries	1	8.42	2025-06-26 14:11:13	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2025-06-26 14:11:13
efe85f85-c083-49a5-851c-613c9b5b5e84	ocI3rr7FmkRTmE4kQfQx	7503	Tea	Beverages	2	106.18	2025-05-22 17:09:22	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.cruz12	2025-05-22 17:09:22
b3cf38e9-ad91-4364-84c2-bd303d58f5bc	WkEaVGZsEdPHGVSD3bDZ	7504	Flat White	Pastries	4	113.21	2025-10-24 18:12:09	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.delacruz	2025-10-24 18:12:09
8fa32978-dddf-4bf2-bfc3-bc1c88502370	TEgCde3R3sadHwEkuqOC	7506	Hot Chocolate	Pastries	2	131.53	2025-11-24 05:24:41	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	isabella.delacruz4	2025-11-24 05:24:41
afd19a6a-30c9-47da-bb87-b9fcf08cc0ee	ApxOPa16QHW0dgwBR5ul	7508	Tiramisu	Pastries	1	196.55	2024-12-20 09:38:14	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.fernandez11	2024-12-20 09:38:14
8380e242-696f-450c-9753-74e495018551	N2aXEmGhjo2kb46MLbSS	7512	Almonds	Pastries	3	5.59	2025-09-02 06:59:03	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905852710	elena.torres2	2025-09-02 06:59:03
216cdccc-29c0-495b-8816-b3084055b0b7	eytVK7HgTMa2tLx6kngY	7513	Baguette	Pastries	5	133.77	2025-09-04 04:36:45	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	admin	2025-09-04 04:36:45
62f17766-cdc5-4e7b-baf9-01b8a5541cac	DzDx8XbsKEuUifjQldQn	7517	Chocolate Chip Muffin	Pastries	5	103.79	2025-07-12 11:19:09	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905182203	miguel.cruz15	2025-07-12 11:19:09
0d33185f-dce1-4e52-88a0-cba370bac6f6	ZHrHbag9rmSc1qaPQnfm	7524	Almond Croissant	Pastries	4	8.42	2025-07-13 07:29:44	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	rosa.cruz13	2025-07-13 07:29:44
b71479e3-344a-46da-935e-d8434b173d6b	Ux3fgicDPrWzEL0BPrFM	7531	Hot Chocolate	Pastries	4	131.53	2025-03-21 04:35:48	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905950372	fernando.santos8	2025-03-21 04:35:48
c560c399-e82f-40e3-a50f-bd5226351396	f5JbFqCEizklEpiYxC9m	7532	Tiramisu	Pastries	3	196.55	2025-08-30 20:55:10	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.fernandez11	2025-08-30 20:55:10
21076b54-bf5c-4ce0-ac53-0440ff20a5ef	i2a2lEvrzJvR1nRphW48	7538	Flat White	Pastries	1	113.21	2025-07-01 01:13:12	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905831816	antonio.santos6	2025-07-01 01:13:12
4a0961da-d847-4ba8-984e-525a81ea9b61	SXMS3QfRJufiQfQKVaFA	7544	Hot Chocolate	Pastries	5	131.53	2025-09-13 02:25:45	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	gabriela.mendoza	2025-09-13 02:25:45
df9396ed-142e-467c-8212-948f8d4d9e5d	UAxj3rstzuFYISZeQ71p	7547	Glazed Donut	Pastries	5	148.75	2025-07-17 12:52:30	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	miguel.cruz15	2025-07-17 12:52:30
04ff71fa-e8cd-4ae0-b940-0698e3d2d0b0	0zSMaJM0mWHTKXieu6FH	7549	Almonds	Pastries	3	5.59	2024-12-02 16:27:41	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905919634	rosa.cruz13	2024-12-02 16:27:41
241596ec-c806-404d-97d3-8cc9427551ae	h7sBDueAa9LLAUZ30CDf	7551	Mocha	Pastries	5	61.74	2025-04-08 10:27:21	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	ana.rivera3	2025-04-08 10:27:21
03a5901e-6a9c-41e0-9f1b-64d1fa3e1894	bGWMkyxqOaSqu32ym7mF	7554	Baguette	Pastries	1	133.77	2025-06-22 00:18:29	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905272637	carlos.cruz12	2025-06-22 00:18:29
0ee23995-877c-4d4f-8f51-9055e2bbb0fc	2Cq14EzlpgY7HztMpGId	7555	Almond Croissant	Pastries	5	8.42	2025-06-04 02:19:45	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2025-06-04 02:19:45
bd88efa2-92e6-4ad5-9358-ce423cd3d312	OcB3xDOP5VzIXjWWXvab	7556	Flat White	Pastries	4	113.21	2024-12-15 14:54:34	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	carlos.delacruz	2024-12-15 14:54:34
fba64dad-1e82-4c08-af2c-b9f35befd3a0	s8rtnU5BQktOZysjpB2M	7558	Red Velvet Cake	Pastries	3	187.25	2025-05-02 03:04:46	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	rosa.rivera7	2025-05-02 03:04:46
8d8b8cbc-0e50-466d-b06f-397b24fc6fc4	596RHr2FukwzIO5WCdTd	7559	Cappuccino	Pastries	2	76.25	2025-10-14 11:12:13	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905344872	carmen.santos1	2025-10-14 11:12:13
04ab348b-047d-44b1-9f50-d3899547892a	6Tbjq6J9HzTWWXpnRWi2	7562	Latte	Pastries	1	108.74	2025-01-01 17:58:40	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905859523	elena.fernandez11	2025-01-01 17:58:40
f91daddb-56cb-4f15-9d34-4c90f4cbad38	YWviQPRjK5NJQSIbDZCD	7563	Tiramisu	Pastries	4	196.55	2025-04-30 05:28:03	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905040091	ana.rivera3	2025-04-30 05:28:03
e799459e-2e7e-4a2a-9a63-b570cb816b32	BiceFfkqA3TSj8hYSjQw	7567	Tiramisu	Pastries	3	196.55	2024-11-26 02:07:20	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	rosa.rivera7	2024-11-26 02:07:20
d9801468-1e47-47ea-91f4-7ee9a6b1736a	xhcLIFfLvgqAkW5584AI	7568	Macchiato	Pastries	2	93.97	2025-06-23 19:30:13	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	rosa.cruz13	2025-06-23 19:30:13
33a26245-ae09-4a8a-95cc-f2afe3a487db	pQGlhJ9nr1YlJjcsym7C	7570	Americano	Pastries	3	80.96	2025-09-20 14:10:46	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carmen.santos1	2025-09-20 14:10:46
4578c4bc-9ada-44e2-be6d-9094afd40b31	4ZuCBa4kripBfOJpeQOk	7571	Iced Mocha	Pastries	5	144.00	2025-08-22 18:41:50	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905153746	fernando.cruz	2025-08-22 18:41:50
8913ec15-a73f-4a8a-b19a-b8e3a69a681d	RL9IbEBLx1aH8X6OE1o0	7576	Almond Croissant	Pastries	4	8.42	2025-07-03 01:50:59	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.mendoza	2025-07-03 01:50:59
ffe2c90a-7a8c-4c9d-8de2-1dce7db984a5	BXZA4NmUWfXXgi4XmpvQ	7579	Eclair	Pastries	4	146.12	2025-02-20 09:33:05	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	fernando.santos8	2025-02-20 09:33:05
334754c6-37c6-4001-a7b2-14b7abe82da7	iKjUDlEmR1RMdrxMQAJT	7580	Tea	Beverages	5	106.18	2025-09-15 05:30:15	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	sofia.reyes9	2025-09-15 05:30:15
15e85f86-b7c0-4539-8fa7-90e8860e5a12	xCf9xrrCRcCCnFfLSdHf	7581	Red Velvet Cake	Pastries	2	187.25	2025-04-14 22:51:49	22893c15-bd77-4029-b8ca-3bb58becab1f	Card	\N	admin	2025-04-14 22:51:49
77e3fc5f-282d-4c44-9872-709b14980202	Ibpyj7bE5cP350CWdN46	7589	Red Velvet Cake	Pastries	5	187.25	2025-08-05 11:16:44	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	ana.rivera3	2025-08-05 11:16:44
b94742e3-3520-4775-bb87-8e0ea7fdcbc2	QwMZR9lMvgZnEdNfkRKY	7591	Espresso	Pastries	2	195.76	2024-12-27 11:25:00	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905412458	admin	2024-12-27 11:25:00
6c535880-383f-4142-9574-b9987c3169ab	a8VFqwpMIaA4hoY17t54	7592	Americano	Pastries	4	80.96	2025-05-19 05:55:20	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	fernando.santos8	2025-05-19 05:55:20
b6008ea3-4f18-41dc-bd55-262b850ac834	yK7c9Q427c2nPrV9VNHU	7594	Iced Mocha	Pastries	3	144.00	2025-06-04 23:49:26	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	sofia.bautista5	2025-06-04 23:49:26
3153218e-1e27-40ce-b26c-16d31774250d	Dpf7h0TqmksAXOU6gES0	7600	Chai Latte	Pastries	3	100.50	2025-09-01 18:46:27	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905406940	carlos.mendoza	2025-09-01 18:46:27
45abcf9d-b6d0-4df6-a272-ce44dde6b85e	vG65nqkpX3JyfVYMM0CJ	7604	Cappuccino	Pastries	2	76.25	2025-03-01 23:53:53	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	sofia.bautista5	2025-03-01 23:53:53
9a0228b1-c089-47d3-8e6d-e0d880221c4f	WAqL76LpEDupzBcPwNg7	7605	Iced Coffee	Beverages	1	107.80	2025-09-14 10:29:45	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	gabriela.mendoza	2025-09-14 10:29:45
755e5faf-e0c9-4731-a1a3-d67b2a877f18	EGkhFlM2UGf2mvh3Ip61	7606	Baguette	Pastries	3	133.77	2025-10-09 15:58:26	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.delacruz	2025-10-09 15:58:26
b32d3ec7-17e2-4b16-b31c-f140fbdac6c9	AUxdq8iTDdo3jWAFthgi	7610	Chai Latte	Pastries	5	100.50	2025-02-03 12:27:55	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905529625	antonio.delacruz10	2025-02-03 12:27:55
18c7eb58-2ef2-4dd9-86a5-6b86ae9f3fc0	pxscuIFNQ6ChbrcKpgBc	7611	Iced Coffee	Beverages	3	107.80	2025-05-17 01:58:19	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.mendoza	2025-05-17 01:58:19
02050d77-0195-4012-bef4-36a940874bb6	crH5XumoLOBGmJS3WITP	7625	Iced Mocha	Pastries	1	144.00	2025-11-04 10:08:04	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	ana.rivera3	2025-11-04 10:08:04
8869ca90-27a2-49a2-910b-c36398f47ea2	yLdYw9n4HxY0VYDX8Am4	7629	Hot Chocolate	Pastries	3	131.53	2025-09-15 17:26:00	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905541291	isabella.delacruz4	2025-09-15 17:26:00
2428a2d4-107d-49bb-9316-c11ef7b0f587	CQFPwrBt1l5gQfWpDgyB	7632	Americano	Pastries	2	80.96	2024-12-31 11:32:17	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	sofia.reyes9	2024-12-31 11:32:17
aebd9871-7607-479b-836f-15b8bdad12fe	PFyoOKrCRXiRg02vkWEk	7633	Baguette	Pastries	3	133.77	2025-02-10 19:02:01	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.torres2	2025-02-10 19:02:01
9dd9c451-03a0-4769-aae4-33300afe3af3	jV8WgJxCpfh71080TcYC	7635	Cappuccino	Pastries	1	76.25	2025-07-20 17:05:18	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905581458	elena.fernandez11	2025-07-20 17:05:18
ff77c7d0-aa81-473c-af1b-edf8d5be40bf	A9cZol6Niiiy8uM85rjO	7637	Tea	Beverages	2	106.18	2024-12-07 07:48:15	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	rosa.rivera7	2024-12-07 07:48:15
2dca768e-a935-47d1-95d6-025a7d196092	hLy5j7aAft3Bp04f4Vzi	7640	Macchiato	Pastries	1	93.97	2025-06-09 20:19:17	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	sofia.bautista5	2025-06-09 20:19:17
d724e05f-563a-4305-84a1-110a911144d0	mXNsQO4V69TsAiak9PfE	7643	Baguette	Pastries	4	133.77	2025-10-15 21:27:00	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905500548	isabella.delacruz4	2025-10-15 21:27:00
9ae65961-556d-4e51-88b0-9e36b042d29f	O4Hd1zI8ZvT6XhSVquUt	7644	Chai Latte	Pastries	4	100.50	2025-01-14 18:32:46	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905589443	gabriela.mendoza	2025-01-14 18:32:46
9b06b633-9f8d-4436-aecc-d502d3026ea9	e0TcnbmUeupiD1vm1G6L	7650	Tea	Beverages	1	106.18	2025-03-21 14:05:45	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.torres2	2025-03-21 14:05:45
60e620be-663e-40f3-86b6-d473c316ae94	6JOEQFUN3kHLr3qC5tA7	7658	Cappuccino	Pastries	1	76.25	2025-10-22 22:33:30	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	pedro.cruz14	2025-10-22 22:33:30
45223dac-37f9-4ac1-9508-43d3d3e4b11b	Lke1lRvm4T0iRdSdfpR2	7659	Red Velvet Cake	Pastries	1	187.25	2025-07-07 01:10:44	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carmen.santos1	2025-07-07 01:10:44
df44fd57-e508-44ae-bda5-e6bf376163d5	lBzocl16PWSxQC1BCAHG	7662	Red Velvet Cake	Pastries	4	187.25	2025-02-24 00:44:51	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	pedro.cruz14	2025-02-24 00:44:51
8b5933b8-de84-4a57-8f7e-2b7189ddc9bf	i8BXmzZo45ViorZon6oO	7663	Chocolate Chip Muffin	Pastries	5	103.79	2025-03-18 19:01:47	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905166335	isabella.delacruz4	2025-03-18 19:01:47
066af063-12de-41dd-a0ff-caef5783264a	ioX2Mkde7wx0emCApfK5	7664	Iced Mocha	Pastries	3	144.00	2025-09-05 13:08:19	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	sofia.reyes9	2025-09-05 13:08:19
c0a12b3e-05d5-484b-9eae-db8bc8f2894b	AXzHVplgWLFJSdQpky2b	7670	Cappuccino	Pastries	4	76.25	2025-11-04 12:15:41	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905930241	carlos.delacruz	2025-11-04 12:15:41
294af48a-eb4c-47cc-98f6-0a0ff4e141bf	9Tf7YGLGRTFzqTDK8KBS	7673	Cappuccino	Pastries	1	76.25	2025-08-02 11:11:52	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.santos8	2025-08-02 11:11:52
c4132317-a1eb-44b0-a8b8-5ff0502763ca	PgJVb9JB4N6YLWqFkjLP	7675	Latte	Pastries	4	108.74	2025-02-18 15:00:56	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	antonio.santos6	2025-02-18 15:00:56
4a8bfebc-6217-4f1e-94a9-26151e2d448e	reqh3zuKubDRMm69GJAn	7691	Glazed Donut	Pastries	5	148.75	2025-11-24 03:04:09	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	fernando.cruz	2025-11-24 03:04:09
2926ee23-f136-4f15-b3d5-0a10e826fc3c	G6BkneTSCoeugq09aS2I	7695	Flat White	Pastries	2	113.21	2025-11-19 03:48:07	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	elena.torres2	2025-11-19 03:48:07
b0aab7ef-19b1-471f-9ff7-73fa1da61e91	Q9zwjwonvrWkq5da1B1w	7696	Almond Croissant	Pastries	1	8.42	2025-04-13 09:01:59	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	isabella.delacruz4	2025-04-13 09:01:59
332984aa-0c9d-485b-b0d6-56926bba117c	TM3XiWrDeHaaFJlDqQgC	7700	Cappuccino	Pastries	5	76.25	2024-11-30 08:53:25	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	elena.torres2	2024-11-30 08:53:25
234c632a-21e2-4c98-ab4a-63e502869cfd	FwnWPQzLCsJDZtXBczjW	7703	Blueberry Muffin	Pastries	3	185.15	2025-03-25 07:53:35	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	sofia.bautista5	2025-03-25 07:53:35
a41258ce-73be-4f9a-9695-c3abeb862494	xBaAMkao6Ub3DA531KoR	7705	Baguette	Pastries	3	133.77	2025-03-25 11:21:38	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	antonio.delacruz10	2025-03-25 11:21:38
383d4430-a081-4b37-9aba-042b23c36282	8s9ZQ2aCYMhuwhMw2ey9	7706	Glazed Donut	Pastries	3	148.75	2025-03-13 08:54:11	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	antonio.santos6	2025-03-13 08:54:11
e0f500ad-a49d-4047-b1a5-23c9252a99ca	7ooZG37ilAgVyOUaFiJ5	7709	Blueberry Muffin	Pastries	5	185.15	2025-08-30 13:02:45	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.delacruz	2025-08-30 13:02:45
bdb9cd44-4605-46ed-9f91-1ec7f1343cdc	mj04hdNErL4kl0RKPSxJ	7713	Almond Croissant	Pastries	3	8.42	2025-04-10 00:57:07	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905016467	fernando.cruz	2025-04-10 00:57:07
6ef52fb6-a4f9-4946-8579-c4f01ab76d9c	SY7DTq1YcfTIYSpNJMA1	7717	Tiramisu	Pastries	4	196.55	2024-12-14 18:00:44	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905169169	fernando.cruz	2024-12-14 18:00:44
224f42e7-ed79-4fd5-9212-6f827fffb607	dRtRQ36GajuegXuXpNNX	7720	Tiramisu	Pastries	1	196.55	2025-03-13 01:49:31	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	fernando.cruz	2025-03-13 01:49:31
75d5cd09-5d1e-440f-8d51-567fb70fb27d	wUMzGHbStKl6Dl9WFizW	7722	Iced Mocha	Pastries	3	144.00	2025-06-28 20:07:15	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905973998	rosa.cruz13	2025-06-28 20:07:15
c0951c42-5983-4ea6-86df-a1e99c7ac801	VemhwLfSWmQZeEw3SCAS	7723	Eclair	Pastries	4	146.12	2025-06-28 11:05:58	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.cruz12	2025-06-28 11:05:58
6554b087-8dc2-4382-b447-db92b1e804c5	dJLOXkdOqWNxPBa4KAur	7727	Espresso	Pastries	3	195.76	2025-05-10 01:07:13	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905217141	gabriela.mendoza	2025-05-10 01:07:13
cee0707a-21f5-4239-a48d-069fc438c3f1	jqT17sCwOOYzLm27WM2y	7732	Almond Croissant	Pastries	5	8.42	2025-02-24 08:38:31	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	elena.fernandez11	2025-02-24 08:38:31
6e940aa1-d696-4223-934f-23c3f63892d1	Bh8bo74WivZFuIt39yJh	7734	Flat White	Pastries	2	113.21	2025-07-05 18:53:34	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	elena.torres2	2025-07-05 18:53:34
74890542-24af-4c63-9266-96316d59dc2e	rJXWXveWNFrDslXseLFD	7737	Blueberry Muffin	Pastries	1	185.15	2025-05-20 19:35:42	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	miguel.cruz15	2025-05-20 19:35:42
b98429cb-586e-4630-a3db-9e0c394a1e40	Zw4DJ18bwMRsSE5j4mHJ	7739	Latte	Pastries	4	108.74	2025-03-17 16:28:46	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905538372	admin	2025-03-17 16:28:46
2ac0f66f-2605-4364-953e-9e42bad17bb4	5AC2712kOUpHmD75EDB3	7743	Mocha	Pastries	5	61.74	2025-07-27 08:29:34	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905402074	carlos.cruz12	2025-07-27 08:29:34
34b42c2f-0938-42cb-abaa-2d0d0a8f36d0	SyhTYakMxIdMmgEKC60w	7744	Almond Croissant	Pastries	2	8.42	2025-04-05 07:05:36	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905565569	fernando.santos8	2025-04-05 07:05:36
5c81d002-5001-49ad-a6ac-2de1b502e447	rPScKtBRUCQpwqu5AQxa	7755	Cappuccino	Pastries	2	76.25	2024-12-08 13:00:50	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905288215	sofia.reyes9	2024-12-08 13:00:50
3f6f680c-0b4e-4dae-9ac9-d61cf2c05055	tWpp482vLzOkW8jN9ENG	7757	Tea	Beverages	5	106.18	2025-02-28 18:30:28	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905214717	elena.fernandez11	2025-02-28 18:30:28
e150d877-18cf-4594-b60f-2456b8362cd4	f7xqtodONL2seil3A9r7	7758	Hot Chocolate	Pastries	3	131.53	2024-12-24 03:50:05	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905030621	elena.fernandez11	2024-12-24 03:50:05
e88b3b41-be4c-4195-bf89-53666dee7b1e	YvfEWhEOAn47hnGvJs09	7759	Apple Turnover	Pastries	4	154.54	2025-05-20 22:26:43	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.torres2	2025-05-20 22:26:43
afe114a1-6e09-4441-aae3-02a402051c00	N2zv2SejzaRk5U5MilwI	7760	Tiramisu	Pastries	4	196.55	2025-01-09 03:02:56	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	fernando.santos8	2025-01-09 03:02:56
43e17eb9-d75a-42b5-b201-9058f46e6fed	RZm3yI8GekH5rvlj20ba	7761	Americano	Pastries	1	80.96	2025-03-08 14:49:14	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905798078	fernando.cruz	2025-03-08 14:49:14
058ee523-cd1a-4be7-b7ed-2c8986b34069	FNEGNW9IVasmfhHoF0At	7762	Eclair	Pastries	4	146.12	2025-03-01 22:11:53	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	carlos.mendoza	2025-03-01 22:11:53
54b9d319-691b-4e47-a7fb-5d85bb8cb029	hF99kwgPgIPvh58p2gFX	7764	Iced Mocha	Pastries	5	144.00	2025-01-18 17:49:12	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.cruz12	2025-01-18 17:49:12
69fb22bc-386e-4e9a-815d-145f54af57da	fg26SFKvfrjut0htPnky	7767	Blueberry Muffin	Pastries	2	185.15	2025-09-29 23:46:28	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	antonio.delacruz10	2025-09-29 23:46:28
f2a4895d-d679-4715-89f6-04c904d04e79	LK5SPQI9rZ2U1UwJcwVp	7768	Tea	Beverages	4	106.18	2025-11-11 07:53:12	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905217556	carlos.delacruz	2025-11-11 07:53:12
07143f4e-0f77-406a-b2ab-51af2ff74e5e	lR7G4PNvziztKcSn5Lic	7771	Baguette	Pastries	3	133.77	2025-02-09 10:41:37	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905744432	rosa.cruz13	2025-02-09 10:41:37
6826fa08-3313-4c22-8ff1-7183748ccd05	ThOJsMZahpL32T8Aqona	7772	Chai Latte	Pastries	4	100.50	2025-11-05 17:27:36	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905000776	fernando.cruz	2025-11-05 17:27:36
9a3c0b5f-7b98-4a7b-b956-44680027814a	e5eRJAAKroKqFfnULfHw	7773	Hot Chocolate	Pastries	1	131.53	2025-05-19 22:12:57	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.mendoza	2025-05-19 22:12:57
3e711c42-15a2-4a9d-8a33-743b2cc98763	WWMMC7sUa9Sgh1qopEui	7774	Iced Mocha	Pastries	4	144.00	2025-11-03 19:49:10	1ff9c549-6c45-45f4-a524-c429c13a8aed	Card	\N	antonio.santos6	2025-11-03 19:49:10
a7b2b688-df69-4015-923f-776d0eafb54a	g1n5exZHz7nC4W4y22FT	7775	Almonds	Pastries	5	5.59	2025-07-13 01:42:47	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905640582	fernando.santos8	2025-07-13 01:42:47
87a1396b-9cf5-4453-bee0-7d2e02e1d56f	o1xfeJKVARGSnKs0fxAO	7781	Chai Latte	Pastries	3	100.50	2024-12-26 15:55:00	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	fernando.santos8	2024-12-26 15:55:00
8858ede6-d716-4dad-bbdc-a855a141ab74	rET9qL0XUt4dEXfXGhBz	7786	Red Velvet Cake	Pastries	1	187.25	2025-10-25 13:59:22	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	fernando.santos8	2025-10-25 13:59:22
3535fd9d-cf5b-4c42-93be-c7f96f296774	NBMbKEldlNg7KmKJIDq1	7796	Macchiato	Pastries	4	93.97	2025-08-16 10:05:08	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	fernando.santos8	2025-08-16 10:05:08
e47093de-679b-47f0-9d19-de60017c2e90	emgi8riAnOviDKAAlrcc	7798	Iced Mocha	Pastries	3	144.00	2025-06-22 17:23:45	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905725951	pedro.cruz14	2025-06-22 17:23:45
839d9603-7f50-4c2c-9148-9b928c3923ce	FMULMkvyuectVogjst17	7800	Latte	Pastries	5	108.74	2025-08-21 05:05:37	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	ana.rivera3	2025-08-21 05:05:37
eaa72577-d42b-471d-8e8d-05876e30f150	1UT54pDLsfEVDkmmu6D1	7802	Flat White	Pastries	3	113.21	2025-02-10 04:10:16	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	sofia.bautista5	2025-02-10 04:10:16
d0201555-d6ad-4dea-b2a5-8acc52da7084	2jd7EuSf0jZMWBlstQBv	7809	Iced Coffee	Beverages	5	107.80	2025-08-19 08:02:09	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	gabriela.mendoza	2025-08-19 08:02:09
b44f40a9-7723-455e-8f21-b999b8b6f1ca	PU4JcKOhJH0b6ezyQwj7	7810	Eclair	Pastries	2	146.12	2025-03-21 09:21:29	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.cruz12	2025-03-21 09:21:29
3f5cec6a-085b-40cb-8d9c-c1eae7973f18	sEZWqDHHhdlljhaZ12ze	7811	Macchiato	Pastries	4	93.97	2025-01-26 08:02:26	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.cruz12	2025-01-26 08:02:26
e9f4d393-3306-4f1a-886e-4d5859113de2	fS5yoYXVxFhfzJEFr8P7	7813	Glazed Donut	Pastries	4	148.75	2024-12-14 06:56:13	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	ana.rivera3	2024-12-14 06:56:13
21f30d55-450b-4980-b274-2699736cc54d	E4Cpj5JxsLlvBgTpnZKu	7817	Baguette	Pastries	1	133.77	2025-08-20 10:56:10	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905700684	carlos.delacruz	2025-08-20 10:56:10
94489e34-263e-4238-8e9d-bc732668ed43	UVZPMUOl1UKEcvoUo6bq	7818	Chai Latte	Pastries	4	100.50	2025-03-02 07:28:32	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905265112	antonio.delacruz10	2025-03-02 07:28:32
1489bf26-b0d5-4dfc-a8d8-3d1e5c08dc5e	z1ngxDcGtMtanFtULCGp	7820	Iced Coffee	Beverages	1	107.80	2025-05-14 00:46:27	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	antonio.santos6	2025-05-14 00:46:27
eea58098-ec88-4abe-a5b7-b1324ee04691	cUEMfrQvpKgeBRuJoSDJ	7822	Almonds	Pastries	5	5.59	2025-08-27 15:12:28	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	gabriela.mendoza	2025-08-27 15:12:28
15e8598f-6dfd-4489-8984-eb25c74f42a5	nI42wVn99ZS0RO9tMbRS	7829	Almonds	Pastries	3	5.59	2025-06-28 04:03:56	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	elena.fernandez11	2025-06-28 04:03:56
1323127d-7bef-4ef7-8f47-fd6eefbecfe5	vZIDe0mbGWWyepPatLcG	7830	Almond Croissant	Pastries	3	8.42	2025-09-25 14:51:19	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905931364	antonio.delacruz10	2025-09-25 14:51:19
6534863a-cb4d-45d7-a6c5-a0ca3f7a1271	sXpWq1jPJeRjcn7jmRLM	7831	Baguette	Pastries	3	133.77	2025-09-21 15:23:14	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	rosa.cruz13	2025-09-21 15:23:14
82dbaf9f-4dfb-4f55-9977-431bfc484492	YgeKSpiVHuFH9Dng3YnH	7833	Americano	Pastries	1	80.96	2025-05-23 13:05:43	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	admin	2025-05-23 13:05:43
24804ef3-7a56-460f-8093-b00576075873	IrrNEvw41Kc3GTCBujRe	7834	Tiramisu	Pastries	2	196.55	2025-01-16 09:14:33	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	ana.rivera3	2025-01-16 09:14:33
dead9dba-0fa8-484a-8117-d1696e4a4521	xc8S1cJpHh943zKIm8dU	7836	Mocha	Pastries	3	61.74	2025-03-09 09:50:15	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	ana.rivera3	2025-03-09 09:50:15
da3102db-e7e6-46e8-89f5-e00e1474cfdd	VkMYIZzuVEDwiYY7Y0GX	7845	Red Velvet Cake	Pastries	1	187.25	2025-06-18 10:14:58	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905256835	isabella.delacruz4	2025-06-18 10:14:58
ddad9966-21ac-4263-9514-082a8bda6a57	XV4RZIZTALB5HO281Sjn	7846	Tea	Beverages	2	106.18	2025-08-27 01:49:02	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905056468	sofia.bautista5	2025-08-27 01:49:02
3d711a4b-65dc-4a60-8d35-64ca51c7538e	fvUVIqucynxSnDVUo2CT	7847	Baguette	Pastries	1	133.77	2025-01-11 00:21:49	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905169305	miguel.cruz15	2025-01-11 00:21:49
d078d994-cf6b-482d-b992-e10c4badb4f5	OBbmBw2iJVcRrzLDub7L	7850	Iced Coffee	Beverages	1	107.80	2025-03-31 20:54:10	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	ana.rivera3	2025-03-31 20:54:10
ce6653b2-81cc-4035-9ec6-0b0c1e4d3fda	EBjk4E3YWLfJT7yiRuGs	7854	Macchiato	Pastries	4	93.97	2025-03-06 03:38:39	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	miguel.cruz15	2025-03-06 03:38:39
b1a17ad6-11af-4504-a1dd-cc03a59d72d2	DqWZtlQlXlgKQYxULqWO	7860	Eclair	Pastries	5	146.12	2025-09-14 01:45:59	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.mendoza	2025-09-14 01:45:59
71bee829-949f-424a-b9d2-fe9cdd2ec3bf	ib7mPV7YPCDlnVYKWvL8	7861	Cappuccino	Pastries	3	76.25	2025-07-31 03:30:21	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905929338	admin	2025-07-31 03:30:21
64ecb8a1-ecc0-4750-9882-71f5aceb4ad4	1Rh3KnZFULhSZJa39v6A	7862	Baguette	Pastries	2	133.77	2025-07-18 22:15:24	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.mendoza	2025-07-18 22:15:24
d9c1861e-cdee-4005-addf-ca06d313e237	r1rAGcVIub6JZ68RXViM	7869	Almond Croissant	Pastries	5	8.42	2025-05-29 23:29:51	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	elena.torres2	2025-05-29 23:29:51
e9aeb33e-89b7-4da7-9fb1-f7af2a2c9b70	FRpfdnDLVZcT9CBBG6o3	7870	Latte	Pastries	3	108.74	2025-02-16 17:37:16	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	gabriela.mendoza	2025-02-16 17:37:16
e460e4ae-4405-4e03-8649-ed174c1071a0	0kEmSZUCcbwKWadA9t8D	7871	Hot Chocolate	Pastries	4	131.53	2025-08-01 19:19:56	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905605645	carlos.cruz12	2025-08-01 19:19:56
c9df47ce-8554-4965-a36f-95f121290d43	gbM1An48DKvBxmJB6Jg9	7879	Chocolate Chip Muffin	Pastries	1	103.79	2025-02-10 07:19:47	996934ff-5758-44b4-ad0e-4ed9d927901e	Card	\N	antonio.delacruz10	2025-02-10 07:19:47
f4767923-37cc-4e56-9f8d-0582695debbb	JLCKFsUNCOZxASMGmHSa	7881	Glazed Donut	Pastries	3	148.75	2024-12-17 08:32:27	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	rosa.rivera7	2024-12-17 08:32:27
9d88a51a-8fe2-4f62-b7ee-aad2a09edad8	vQaKVWiDbYs7u8QFRJpS	7886	Hot Chocolate	Pastries	1	131.53	2025-09-07 02:57:49	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.mendoza	2025-09-07 02:57:49
00eb2bd3-6697-4d82-8c87-f773e352e9e7	ZZzx9xDj3Jukl9H2YZxb	7889	Cappuccino	Pastries	4	76.25	2025-05-26 03:47:54	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.delacruz10	2025-05-26 03:47:54
9d4cc392-9ce2-4fdf-9ae5-3e220995cdfe	wpNmGBhq0U5BtWSi2AnS	7897	Eclair	Pastries	4	146.12	2025-04-01 20:00:04	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	rosa.cruz13	2025-04-01 20:00:04
cb8107f3-dfc9-45af-a4f9-38d21595e17b	IPsMFPfreBSV7Ni16AU0	7898	Blueberry Muffin	Pastries	1	185.15	2025-10-07 21:47:02	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.cruz13	2025-10-07 21:47:02
b827479f-0618-4ce2-a057-8f1e3d889b25	5X3Tj4qKqfbUnX9ukOhu	7903	Blueberry Muffin	Pastries	3	185.15	2025-06-16 14:07:23	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.rivera7	2025-06-16 14:07:23
3b8ea6f2-b107-483b-815b-61cd259848bf	BbuO7JZ9AlGdYnOZfIMR	7904	Red Velvet Cake	Pastries	3	187.25	2025-04-19 18:23:31	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	fernando.cruz	2025-04-19 18:23:31
a96b1ada-1404-4713-b341-c06a0df9bd62	qcyHXBmB5OsLQsLDDwt1	7908	Americano	Pastries	4	80.96	2025-11-23 23:45:18	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905093378	miguel.cruz15	2025-11-23 23:45:18
bfd5db76-db7a-4690-818f-b933a934db9a	n6jgobsoZGJ8Q8RUL2dy	7914	Iced Coffee	Beverages	2	107.80	2025-09-01 15:22:54	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905939413	carlos.mendoza	2025-09-01 15:22:54
4ba705a5-bda5-460d-9800-030b39ec5f1f	yyGX2LhweiZjhYnfkzji	7916	Espresso	Pastries	2	195.76	2025-11-05 07:39:32	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	antonio.delacruz10	2025-11-05 07:39:32
8af599a3-7e9c-4058-aaac-803e3279b3d9	Ia1cCYQH1JiaejDzy2es	7918	Apple Turnover	Pastries	4	154.54	2025-09-18 04:46:56	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905708004	rosa.cruz13	2025-09-18 04:46:56
e88f073e-3829-4227-9ac2-e3b1afaf0282	hhRzLZQiRk3uZxstoXED	7919	Chocolate Chip Muffin	Pastries	1	103.79	2025-10-23 08:42:10	996934ff-5758-44b4-ad0e-4ed9d927901e	Card	\N	gabriela.mendoza	2025-10-23 08:42:10
03fc7311-48ca-4197-b2aa-10570a2ea0e8	lXMuC5aB2iV02kgJg41q	7921	Iced Mocha	Pastries	5	144.00	2025-03-24 22:28:20	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905002162	miguel.cruz15	2025-03-24 22:28:20
069bd53c-cbce-4be3-a306-462923ccf708	jj9MenRNNUz2su3R9gcw	7923	Baguette	Pastries	3	133.77	2025-03-09 17:58:57	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	ana.rivera3	2025-03-09 17:58:57
62ab0134-0322-4855-ade1-81b59ae8ef4a	ksxT0qdVolioWrNzWEnc	7928	Almond Croissant	Pastries	3	8.42	2025-06-10 04:26:28	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	elena.torres2	2025-06-10 04:26:28
bae58fda-4760-4131-a8a1-e18327305e9b	o7GPfJnvdlQeKnb8Xif6	7930	Iced Coffee	Beverages	3	107.80	2025-04-27 19:51:04	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	miguel.cruz15	2025-04-27 19:51:04
bbd0fe60-c8f9-4e2b-9ede-f30e14050207	lNOTz9DwdyrOqtIHRerr	7932	Blueberry Muffin	Pastries	3	185.15	2025-01-22 20:38:23	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.cruz13	2025-01-22 20:38:23
f84d109c-5413-4dc9-a7da-9648e1065c2c	nocRUYy5cjlqLSbmw4XS	7933	Glazed Donut	Pastries	4	148.75	2025-03-29 06:27:25	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	fernando.cruz	2025-03-29 06:27:25
55c52a1f-0a99-4727-a4c0-f1a636f9340d	7RhaOyG0bcCzqX2AiCFR	7934	Eclair	Pastries	1	146.12	2025-01-07 16:49:41	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905663744	miguel.cruz15	2025-01-07 16:49:41
d678ab0b-1c97-48c0-bdd2-1fce7c327110	3kwgqfFWBlNC2GhuJfEF	7935	Iced Coffee	Beverages	2	107.80	2025-05-09 01:22:13	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carmen.santos1	2025-05-09 01:22:13
aae5a053-562a-440a-bf14-740f6c7d9ae6	4JZZfpf7j9QnqFloKRDY	7937	Mocha	Pastries	3	61.74	2025-03-02 15:42:28	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	pedro.cruz14	2025-03-02 15:42:28
7be78e76-bb63-43d9-82b1-3cc395dcd374	6MocVbyiCqeGg3oYacHu	7940	Iced Coffee	Beverages	1	107.80	2025-04-26 12:37:27	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905807339	pedro.cruz14	2025-04-26 12:37:27
2934505e-ea12-481b-895f-be10cabb8a33	69TyOPzjC5iJAV8mGgfS	7941	Iced Mocha	Pastries	4	144.00	2025-05-08 13:19:16	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2025-05-08 13:19:16
1035a0dd-41d5-4f7e-9aea-a0f244059173	2q44nB4Avs9ozaMHcN8M	7943	Glazed Donut	Pastries	5	148.75	2025-06-14 07:58:35	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	elena.fernandez11	2025-06-14 07:58:35
a6a0b537-386c-4274-8c75-668b0687f593	zmWKJYuFCGtzub4mBtXV	7944	Mocha	Pastries	4	61.74	2025-11-17 07:36:59	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905542651	fernando.cruz	2025-11-17 07:36:59
7f139325-9838-4b50-ba2b-cf32c59715e1	I9idYtztonQNpT3LbYWp	7949	Almond Croissant	Pastries	5	8.42	2025-01-05 19:02:12	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	pedro.cruz14	2025-01-05 19:02:12
b22cb58a-34c3-43a4-8779-e4ee8f739983	M6QM1I1Dk62lh1ac0OHK	7953	Iced Coffee	Beverages	5	107.80	2024-12-01 23:13:06	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	elena.fernandez11	2024-12-01 23:13:06
ebcaa8fd-40fa-4b23-ae11-f9dc4208f9b6	wuvQpxyUuFfKaVEgFziP	7954	Glazed Donut	Pastries	5	148.75	2025-04-22 10:48:51	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905770208	carmen.santos1	2025-04-22 10:48:51
c6e5987b-6c4a-4c1c-a459-ade707969f78	OXauYydnehlZ9Yho6SJz	7956	Tiramisu	Pastries	2	196.55	2025-06-15 06:13:46	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	carlos.mendoza	2025-06-15 06:13:46
3888e823-fe9c-408d-a4c0-7b8b219593bd	AfrSBASAtCbkVMbi1tqh	7958	Mocha	Pastries	3	61.74	2025-03-31 01:06:55	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	pedro.cruz14	2025-03-31 01:06:55
57c3b198-83ee-42a9-97fc-dfdba7ca4e1b	VKS0fLKFV2lkUznHXdWM	7961	Cappuccino	Pastries	1	76.25	2025-07-16 07:22:15	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905904047	carlos.cruz12	2025-07-16 07:22:15
5d72ee7b-ff3a-45a5-adcf-c06fc437b82f	GOAq0P6YsU4MkXyomePN	7968	Blueberry Muffin	Pastries	1	185.15	2025-07-15 12:38:46	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905350819	antonio.santos6	2025-07-15 12:38:46
d3cd5cb1-c74e-40b9-813a-4dfddf3ce9cc	4r5nGtvfamEDs64PEYNK	7977	Americano	Pastries	5	80.96	2024-12-22 23:20:11	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	admin	2024-12-22 23:20:11
93a2d945-3eaf-493f-8fa1-c5eab7baf66d	YAXeJeG0Ae4DkWAkK7vG	7983	Macchiato	Pastries	2	93.97	2025-04-15 12:03:52	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.santos6	2025-04-15 12:03:52
718d1e8d-2f76-473f-a510-509fa50caf62	dg3LYwGIxDnGCzBOIvD6	7985	Blueberry Muffin	Pastries	2	185.15	2024-11-26 02:52:18	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905666609	antonio.santos6	2024-11-26 02:52:18
839a7bfe-6b05-4e91-8428-70a8345bb21d	3AWlAHrYoMFTdmSaiPVG	7987	Chai Latte	Pastries	1	100.50	2025-07-30 05:53:42	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.bautista5	2025-07-30 05:53:42
7e544625-c665-4dc2-9ee2-aafbb77278b2	Fom27LeKjhLRqAlRTvdR	7994	Apple Turnover	Pastries	1	154.54	2025-01-06 05:08:39	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	miguel.cruz15	2025-01-06 05:08:39
3374e61b-ea03-491c-8a28-ffe2c10ac6c1	OxScrBK0atcGeS8cvzaD	7996	Espresso	Pastries	3	195.76	2025-03-07 04:05:28	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	ana.rivera3	2025-03-07 04:05:28
84fab446-5e02-4f4f-b8e7-c1ce9baa94e7	HrLGyIzriC85JHmFLG9u	8001	Baguette	Pastries	4	133.77	2025-03-17 01:20:39	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	fernando.santos8	2025-03-17 01:20:39
52f1768f-8849-4e77-8fe1-3cdb7a811386	HcKl8dyFPc8UXqdSzCbw	8010	Tea	Beverages	2	106.18	2025-03-13 08:58:44	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905434765	fernando.cruz	2025-03-13 08:58:44
b6de9a7c-292a-4a8b-83dc-b1bced237d71	r8mu1Y1zb8DcoGRfezAt	8015	Iced Coffee	Beverages	1	107.80	2025-06-18 10:50:05	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905082856	carlos.mendoza	2025-06-18 10:50:05
e89a33a0-9c6b-45ad-9cad-eb7b8df5c44d	qjmZJ80L6fp0ZrIzfQfv	8016	Latte	Pastries	4	108.74	2024-12-19 22:21:23	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	carlos.mendoza	2024-12-19 22:21:23
7de9fc6b-0a8c-430d-8f26-95266a595a58	UHNgIkMVhDSr3ngectqp	8019	Macchiato	Pastries	2	93.97	2025-10-17 18:22:14	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	pedro.cruz14	2025-10-17 18:22:14
59468d73-de63-4335-85bf-4035abf15192	hBTXRrTBjdCNeChGaYm3	8027	Eclair	Pastries	5	146.12	2025-10-13 07:33:29	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	rosa.rivera7	2025-10-13 07:33:29
5ab0990c-8182-49bb-80cd-6481e5c0e441	rRAHz0aR7b7kgjuT2bS2	8032	Glazed Donut	Pastries	5	148.75	2025-08-11 11:44:57	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	fernando.santos8	2025-08-11 11:44:57
9cc18648-4608-44f3-ae1e-126cfe80b589	nQxIO4cUf5cEkkKSNIcy	8035	Latte	Pastries	2	108.74	2025-02-17 22:03:39	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.cruz12	2025-02-17 22:03:39
28770232-9601-442d-94b1-d3049867ba45	CYTM4o3Yi9WY9Zl9oymx	8041	Almond Croissant	Pastries	3	8.42	2025-03-07 04:03:43	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	ana.rivera3	2025-03-07 04:03:43
c019c15b-60a3-41c4-97d0-b90c23f4c3de	ia64F8Rf3FByw6BJv4GW	8042	Chai Latte	Pastries	1	100.50	2025-02-24 16:09:20	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	pedro.cruz14	2025-02-24 16:09:20
7feaa574-463a-4a27-8c89-cf530cc33d04	YPjmZLgNmJNe1Qvm88Iq	8050	Glazed Donut	Pastries	1	148.75	2025-01-17 10:17:48	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	antonio.delacruz10	2025-01-17 10:17:48
7e3e46ef-0cdf-43c6-89d8-b07346f36ffa	mItQ7uw5QmxIJBq7qVlP	8053	Eclair	Pastries	3	146.12	2025-08-09 04:35:44	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carmen.santos1	2025-08-09 04:35:44
6964e0fd-b7e8-44c3-973c-3a5b3285929a	9UtHOhgMUyvtmXPVRahO	8057	Chai Latte	Pastries	5	100.50	2025-02-28 00:33:34	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.reyes9	2025-02-28 00:33:34
8bad43af-ff74-40ce-ac12-3e46a178e030	LWme84VHbTYBqewcbULo	8058	Apple Turnover	Pastries	3	154.54	2025-01-28 02:46:15	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	pedro.cruz14	2025-01-28 02:46:15
8c7184ea-cfba-4290-83d1-4acf7de23374	dvPgr5n8T1u83jTTNnEz	8061	Almond Croissant	Pastries	3	8.42	2025-03-31 01:36:33	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	sofia.reyes9	2025-03-31 01:36:33
3243de04-967d-40aa-90de-3a4a3147e9bc	g4NjfKD89Mug582RIjZn	8062	Iced Mocha	Pastries	1	144.00	2025-10-10 00:58:13	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carmen.santos1	2025-10-10 00:58:13
9e661dbd-162e-47e0-814f-27fd5abd4118	q4i8KqAf799J5neQ9knI	8067	Iced Coffee	Beverages	4	107.80	2025-03-10 07:20:00	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.delacruz	2025-03-10 07:20:00
71e20cc3-49aa-42b8-9734-5cdc7184d333	cf5uVIMlTUwCJzhWHFZR	8069	Mocha	Pastries	4	61.74	2025-04-14 23:10:41	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	gabriela.mendoza	2025-04-14 23:10:41
5a823aec-39ad-4c9c-8c43-f9f1f600f174	VsFPAiQFeO03SjEUdqyN	8073	Americano	Pastries	1	80.96	2025-01-22 16:22:09	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905028714	isabella.delacruz4	2025-01-22 16:22:09
d49b2b83-ee0f-4be2-bcab-0b5b9d188e1e	1mc1fJ8P58T6ANPX9GzM	8074	Mocha	Pastries	3	61.74	2025-02-17 23:51:57	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.reyes9	2025-02-17 23:51:57
c40b5633-e11d-4638-8f14-110f7607ecd4	W4LjRGrg7SZyY2lqdZuO	8075	Almond Croissant	Pastries	5	8.42	2025-01-19 13:50:55	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905972744	rosa.rivera7	2025-01-19 13:50:55
e78b7324-6fc6-4a18-90b3-f82b518341a2	Y6H6zN1exyZArAQaZjV8	8078	Iced Coffee	Beverages	2	107.80	2025-01-13 05:05:06	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	elena.torres2	2025-01-13 05:05:06
0a04b2e2-75c4-4d78-92e5-ca1eeeb62c63	C7wLm7gMqqyas8nzq7fl	8080	Chocolate Chip Muffin	Pastries	3	103.79	2025-05-21 23:41:01	996934ff-5758-44b4-ad0e-4ed9d927901e	Card	\N	carlos.cruz12	2025-05-21 23:41:01
81044c58-1dcd-42fc-a8e4-f609239f6588	yNc0ZoP7GmFoK7nl5yEc	8081	Red Velvet Cake	Pastries	5	187.25	2025-08-21 18:19:55	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carmen.santos1	2025-08-21 18:19:55
50c98b6c-dec3-4f11-a259-564e5a4df2b1	Ld276b9ZppQNKiUY5SIz	8083	Eclair	Pastries	2	146.12	2025-03-06 13:20:11	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	sofia.bautista5	2025-03-06 13:20:11
edfff866-ba34-4568-9958-a528edef9fdc	1rzSlPAon6cpdUTByJk2	8087	Chocolate Chip Muffin	Pastries	4	103.79	2025-06-19 06:57:11	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.rivera7	2025-06-19 06:57:11
9c87ee69-7da1-426b-8836-33423e581530	HCXIFiTFVguDs0L6Yehn	8088	Blueberry Muffin	Pastries	2	185.15	2025-04-12 10:26:45	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905573127	rosa.rivera7	2025-04-12 10:26:45
31f871d0-9647-4ea8-8b99-5efbb69c309e	gMvsg8KqEWOISdWXATXs	8089	Espresso	Pastries	4	195.76	2025-09-29 13:43:08	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	gabriela.mendoza	2025-09-29 13:43:08
c34a3430-5274-40f7-bb6a-cc17fb3fe05d	OxOdskJHoCwj0kyiWaQA	8091	Flat White	Pastries	4	113.21	2025-03-10 21:09:50	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	admin	2025-03-10 21:09:50
d634798f-dec5-44e7-b7c1-2e39cff64e75	4Q15EGV0hhDYHnlYhB7c	8094	Americano	Pastries	5	80.96	2025-10-25 09:00:18	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905577084	pedro.cruz14	2025-10-25 09:00:18
aba407dc-4b59-4cb4-8849-ac0fc98b70ae	Vr21BXT4b636HjzoKqcl	8098	Iced Coffee	Beverages	2	107.80	2025-04-16 05:39:04	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carmen.santos1	2025-04-16 05:39:04
729c141f-b75d-4ea8-b807-54e8311cbb22	cLTQ97HSO4YCo3fdy52s	8100	Eclair	Pastries	5	146.12	2025-09-13 18:35:51	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	fernando.cruz	2025-09-13 18:35:51
34a96572-64e0-4890-8f4b-4371f05e663d	PRIZqY7RqALCpAQAquSX	8108	Iced Mocha	Pastries	2	144.00	2025-02-27 06:12:07	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	rosa.cruz13	2025-02-27 06:12:07
b5e7ab63-ec2f-4a5e-bea8-9b87a87d0404	opxu17m6RTgIoKWuggm7	8111	Almonds	Pastries	2	5.59	2025-10-06 17:59:57	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905353183	antonio.delacruz10	2025-10-06 17:59:57
3d6e4011-a926-473e-be03-1a52a64fb463	lCMEUaTPLpGVNfpGpRhs	8112	Almonds	Pastries	1	5.59	2025-09-15 01:06:45	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	isabella.delacruz4	2025-09-15 01:06:45
151120d3-6c94-4166-b590-c8ee4b2baee7	L256EBrd33ftRBZeZoAI	8113	Flat White	Pastries	1	113.21	2025-11-08 11:50:35	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	rosa.cruz13	2025-11-08 11:50:35
d9119270-e49e-478d-845b-136a84454c81	mCm9FO3h4JaDgu8oGaOI	8114	Almond Croissant	Pastries	4	8.42	2025-03-03 13:50:28	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	carlos.mendoza	2025-03-03 13:50:28
a19b8475-7e82-4546-96c4-ce3d33c5dcad	dIrWUn4MjbU4plmvLxuQ	8116	Iced Coffee	Beverages	4	107.80	2025-04-26 02:20:13	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.santos8	2025-04-26 02:20:13
2587f9f0-fa8a-4b83-b417-6d40e2e4ace8	3GGzXy7fm6TlWt443izh	8119	Blueberry Muffin	Pastries	4	185.15	2025-05-03 09:42:19	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	miguel.cruz15	2025-05-03 09:42:19
fcc383e5-43a2-40e5-b393-aa3957432575	wo0Xc2aT2EtmzeIwtsyG	8123	Iced Coffee	Beverages	1	107.80	2024-12-25 19:27:59	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	rosa.cruz13	2024-12-25 19:27:59
4ad7e282-fc0d-4ad0-96cc-3a28a80945cf	mgRne9gpjsvpysJ6Kn6j	8127	Tiramisu	Pastries	2	196.55	2025-10-22 10:38:37	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carmen.santos1	2025-10-22 10:38:37
662aca5f-57ab-4f15-bb85-b823d4013414	tuYQlYW5jPVqM59OMbvM	8128	Flat White	Pastries	1	113.21	2024-12-13 02:21:02	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	antonio.delacruz10	2024-12-13 02:21:02
b9e34d2b-d826-44da-8cb2-6e8ea167ebb1	jiW4MgXoQhB0ypdJma6j	8129	Iced Coffee	Beverages	1	107.80	2025-10-24 07:10:54	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905333639	rosa.rivera7	2025-10-24 07:10:54
823edc6c-32b4-4381-8b4b-211dd7d5d22f	lowHgjsbeWU3BSgtnKav	8130	Tea	Beverages	1	106.18	2025-03-22 09:24:01	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	rosa.cruz13	2025-03-22 09:24:01
9a1469bf-4afc-4033-924a-810f4c4ac1e0	KhZcNmkQP0cqGqW07jp8	8134	Red Velvet Cake	Pastries	2	187.25	2025-02-09 11:07:38	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	rosa.rivera7	2025-02-09 11:07:38
1c7b389d-8087-4844-99d3-67a2ec3cd4f8	gX7inTEOaWit1Mpm9NQu	8135	Americano	Pastries	1	80.96	2025-10-16 13:21:26	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	fernando.santos8	2025-10-16 13:21:26
6f6c9879-3689-49e8-ae5a-a6f1cc7f074b	Rl5t6ILHHVSwDQofdWtR	8136	Hot Chocolate	Pastries	2	131.53	2025-06-02 06:01:39	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905328448	miguel.cruz15	2025-06-02 06:01:39
315ea092-90b2-4e3e-81bc-03746b32d800	xZ7VXQ5BTuB4wi1DmE8w	8139	Espresso	Pastries	4	195.76	2025-02-22 03:07:22	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.cruz13	2025-02-22 03:07:22
a3f874ea-403d-4923-8fd1-0eb5786f0078	gaOlXLY2J1eUcSBhG6uR	8140	Apple Turnover	Pastries	5	154.54	2025-08-24 03:54:18	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.fernandez11	2025-08-24 03:54:18
a0960eac-99ac-43cb-b9e3-1e43203400bb	0Bann9I76Qx4QiEiSv2o	8143	Almonds	Pastries	4	5.59	2025-08-11 05:55:58	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905250956	fernando.santos8	2025-08-11 05:55:58
a314cb10-c66d-4e7e-b89b-53f0f409a766	BwAwzQKjU69vGAIYV1MQ	8148	Glazed Donut	Pastries	1	148.75	2025-07-30 08:41:27	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	elena.torres2	2025-07-30 08:41:27
cdb107aa-fbd1-4fc4-8f20-8dea8f37172a	GyKA6Ca4Nj2TN21ph5W9	8149	Cappuccino	Pastries	3	76.25	2025-01-29 12:46:51	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.mendoza	2025-01-29 12:46:51
34520bee-cab9-46a8-8f8e-e76a51561e27	AssXYLfHOK9UwFs05tCY	8151	Apple Turnover	Pastries	4	154.54	2025-10-03 08:26:21	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.torres2	2025-10-03 08:26:21
04295a56-68dd-41b3-a86f-beaab0267040	yg244eup5slwBVJixPed	8160	Blueberry Muffin	Pastries	1	185.15	2025-06-17 06:57:23	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905064941	carmen.santos1	2025-06-17 06:57:23
da243cb5-d0c3-4f62-bba5-a4f51751a279	OQwHRJMMMQGw5ddKiuLX	8164	Blueberry Muffin	Pastries	1	185.15	2025-01-01 10:42:47	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.rivera7	2025-01-01 10:42:47
ab24eb71-50fd-457b-b44f-2e1fddf64d9d	L8bwgCFFF1RxYXyn3Jay	8167	Blueberry Muffin	Pastries	4	185.15	2025-01-13 03:10:28	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905949042	isabella.delacruz4	2025-01-13 03:10:28
189aba45-3dd6-4475-980c-2a86fa424e30	VvNm6lFGsT2EzQkbRHTF	8169	Baguette	Pastries	3	133.77	2025-09-01 03:55:27	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905992972	isabella.delacruz4	2025-09-01 03:55:27
776306af-3d18-41da-8e8c-e6117dc27c0e	kGIKGETicLOcqHDuhHJv	8176	Almond Croissant	Pastries	4	8.42	2025-05-13 08:35:13	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carmen.santos1	2025-05-13 08:35:13
52760a53-f8b5-4954-a73c-13c5df2bd29c	dDsWKY3MnnE7IndcUhAT	8178	Espresso	Pastries	3	195.76	2025-01-07 23:16:52	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	pedro.cruz14	2025-01-07 23:16:52
7e424738-9f56-429e-b55b-5735e63ee608	0KaEsNMws0ItLuZs1AKi	8179	Latte	Pastries	3	108.74	2024-12-27 17:09:38	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	elena.fernandez11	2024-12-27 17:09:38
d9f3ccee-37e5-40b8-9420-3d92ed6a4c2b	DGSogrzwPilEzT0cnEnW	8186	Flat White	Pastries	4	113.21	2024-12-31 10:16:20	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905883085	isabella.delacruz4	2024-12-31 10:16:20
cd1e1bc7-0dca-4ce6-8b5d-379e3c9136eb	jmtrJErx4KSaVK9moIuE	8187	Chai Latte	Pastries	5	100.50	2025-11-09 04:04:01	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	carlos.mendoza	2025-11-09 04:04:01
2246fe81-c209-49dc-81e4-fc54a0767036	XPghKWWHAzK5lW9louMW	8188	Glazed Donut	Pastries	5	148.75	2025-03-27 23:51:59	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905064386	gabriela.mendoza	2025-03-27 23:51:59
67863321-0d4e-408a-ba38-b85105836a76	DXkjf11Sd1oqPFZ3dg4z	8189	Baguette	Pastries	5	133.77	2025-03-21 15:43:16	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905837773	carmen.santos1	2025-03-21 15:43:16
2b2abf3b-e264-4e7d-af0d-529f7d40cf54	Z5vk4YJL0jhMxsqUJqnV	8190	Espresso	Pastries	5	195.76	2025-09-13 19:09:50	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905912890	rosa.cruz13	2025-09-13 19:09:50
0374a32d-493b-4592-9678-954c8347429c	GA55Y4KtnWp530U7B2Sk	8191	Glazed Donut	Pastries	3	148.75	2025-06-29 22:07:50	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	fernando.cruz	2025-06-29 22:07:50
64d49307-0906-4512-a088-a43d1d58abd8	WH7DEH5W6gq58fsaIRMR	8194	Red Velvet Cake	Pastries	5	187.25	2025-04-07 15:02:28	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	rosa.rivera7	2025-04-07 15:02:28
29e846fb-5707-4e56-a64d-046627b41b29	wO0ESjaAMbmlIG0wi2UF	8202	Tiramisu	Pastries	2	196.55	2024-12-26 16:15:55	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	pedro.cruz14	2024-12-26 16:15:55
ca59d3ec-f866-4692-ba3e-9d2c09037b3c	GM5KKLsSNTD1cVEU6VJ0	8208	Red Velvet Cake	Pastries	2	187.25	2025-10-23 23:50:35	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905485094	sofia.reyes9	2025-10-23 23:50:35
5febe08a-2225-4cf8-8b3c-bf5cf164015c	y9qpyE9ux4MM9nKcH0Kh	8209	Red Velvet Cake	Pastries	4	187.25	2025-09-06 13:14:09	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	rosa.rivera7	2025-09-06 13:14:09
f376b776-1604-4b1d-a150-6672981c3802	17k0ZdonjNEMHF1BFQeM	8210	Hot Chocolate	Pastries	1	131.53	2025-07-21 06:41:43	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905758290	sofia.bautista5	2025-07-21 06:41:43
25d5736f-99cc-4086-a5b4-8c076ee18804	KgmfzRria1dXnkwtCMgm	8214	Chai Latte	Pastries	3	100.50	2025-03-28 19:39:10	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905372619	antonio.delacruz10	2025-03-28 19:39:10
f3c368cd-4e08-4236-b86d-09253d5354c1	pGbsWploQx8CupNMuvRH	8216	Latte	Pastries	2	108.74	2024-11-29 09:04:04	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	admin	2024-11-29 09:04:04
7d11dd4c-b351-4849-b193-29e074fbb751	heGejAAzD8nbto78lqNd	8217	Tiramisu	Pastries	1	196.55	2025-04-07 03:02:12	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905353269	rosa.rivera7	2025-04-07 03:02:12
7ad54202-242b-4c9c-a264-a620efced991	OPABiso4NduZxzBnuXdO	8218	Tea	Beverages	3	106.18	2025-02-24 04:35:10	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	rosa.rivera7	2025-02-24 04:35:10
0703f827-6212-4644-bd5f-1b488ecc9857	UFSiaDyAr0hq3JP6h8Y0	8220	Eclair	Pastries	3	146.12	2025-09-05 09:25:08	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	sofia.reyes9	2025-09-05 09:25:08
13848ea4-c57a-4bbf-964f-425d1ac4487f	7cNaL8FwcugfkSuK1OH0	8223	Iced Mocha	Pastries	3	144.00	2025-11-19 09:27:08	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	elena.fernandez11	2025-11-19 09:27:08
922dc4a7-d7ab-4c09-8ad1-3c0744134630	8KXI3yg2QDZ6HIu41oQS	8229	Almond Croissant	Pastries	4	8.42	2025-04-12 04:39:33	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.delacruz	2025-04-12 04:39:33
66900f49-de87-48aa-ac0b-547ebba70c24	wIlhLfurWONHkwTZj09h	8232	Tea	Beverages	5	106.18	2025-11-01 00:39:22	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.torres2	2025-11-01 00:39:22
f8dc75eb-998a-4043-bb60-f6f3b78f07be	wXSeK1RiBr2kjUPYCyx4	8234	Hot Chocolate	Pastries	4	131.53	2025-04-16 20:24:08	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905948165	rosa.rivera7	2025-04-16 20:24:08
1b3e5419-c3f3-400f-b23b-9af327791497	6BtX5sp4rqBzpyFQWBXe	8236	Red Velvet Cake	Pastries	4	187.25	2025-01-25 04:47:32	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.fernandez11	2025-01-25 04:47:32
e0cb164f-9871-4b00-be11-4d121653da53	NgZlJhwT38umwMlKCpdW	8253	Mocha	Pastries	2	61.74	2025-06-26 18:14:15	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.cruz	2025-06-26 18:14:15
eb1347ea-489b-4370-b799-26682349467b	WLrPMUoQW9gZ2cy2eSBa	8256	Espresso	Pastries	3	195.76	2024-12-27 14:31:02	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.cruz13	2024-12-27 14:31:02
637ca363-7d1f-4937-bd5c-ae876df7dff0	wRcnUqwtFi1PsSd1VGfV	8261	Red Velvet Cake	Pastries	5	187.25	2025-01-05 14:56:23	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905062214	elena.torres2	2025-01-05 14:56:23
545ecf36-351f-4363-b4a3-056bfc74d5c9	NiMxtzB4GWlAavBpb1vJ	8264	Tea	Beverages	1	106.18	2025-01-26 12:12:22	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	sofia.reyes9	2025-01-26 12:12:22
c8c5e371-8151-4448-870d-a0416c687782	AeJw4OBgOrrAdKfrOYJS	8265	Tea	Beverages	2	106.18	2025-02-22 18:50:19	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	rosa.rivera7	2025-02-22 18:50:19
c97ae08d-7215-4f1f-a1c6-f5d2df1fd076	BjLGuEoGQeExAfGLQbsa	8269	Apple Turnover	Pastries	3	154.54	2025-10-03 02:12:50	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carlos.cruz12	2025-10-03 02:12:50
22fad2ad-225c-48dd-921f-71c509b213c6	pKYEhBUfG2tHNqfRfpqe	8271	Espresso	Pastries	2	195.76	2025-04-29 11:57:43	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.delacruz10	2025-04-29 11:57:43
63c06790-8e84-4b39-b27c-54ad328104c4	0BaGdoQgE2GuZNGUGlJz	8274	Blueberry Muffin	Pastries	1	185.15	2025-05-14 08:17:02	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905801389	isabella.delacruz4	2025-05-14 08:17:02
cb4954bf-a0ef-4f7d-9a4d-b3cea3beff48	H5OEbC4OmkyOdpzVgIaY	8277	Latte	Pastries	5	108.74	2025-08-23 09:34:40	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carmen.santos1	2025-08-23 09:34:40
1f73ac1e-331a-4ac4-bb29-5bc5e2111aec	ziumcf2g0Iq1LpmFuMx7	8279	Glazed Donut	Pastries	1	148.75	2025-01-05 11:07:09	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.reyes9	2025-01-05 11:07:09
042cfb5d-a4c4-4f2d-8632-9e5e15fcd196	X2d3ic8hjE58BrhvG6OZ	8280	Americano	Pastries	3	80.96	2025-03-29 11:06:56	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.cruz13	2025-03-29 11:06:56
ffffa0d4-001a-4de5-abab-ba92969e0de1	NCGyN1QwpO8VeM2yRvZW	8286	Red Velvet Cake	Pastries	3	187.25	2025-02-14 04:55:00	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.cruz12	2025-02-14 04:55:00
75f216df-513d-47e2-8b43-d110cbd65d26	xLb1CxWmCV63yhrPnwZy	8288	Americano	Pastries	2	80.96	2025-08-21 03:51:12	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905808263	carlos.delacruz	2025-08-21 03:51:12
44d80d5f-df20-48b3-abb2-cc8abad21fa5	KbObE006BaCBMuQknkSX	8294	Flat White	Pastries	2	113.21	2025-03-08 18:40:37	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	admin	2025-03-08 18:40:37
66ccd10e-a09e-4631-bd88-6a9627cf4b81	eEmoUWHVouzJhl5ZovtY	8296	Chocolate Chip Muffin	Pastries	3	103.79	2025-05-18 22:10:28	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	fernando.cruz	2025-05-18 22:10:28
a75e11d6-ffa8-48a9-ba49-76513fa2ec23	8Dg8N9Ml0HJ10I7JXVNx	8305	Latte	Pastries	3	108.74	2025-08-27 04:11:58	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.cruz	2025-08-27 04:11:58
b65877aa-aec6-48d4-9a68-306085346165	xsL43fgkN2Z1anTaLs3A	8307	Hot Chocolate	Pastries	5	131.53	2025-02-22 01:44:17	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905859034	rosa.cruz13	2025-02-22 01:44:17
13e019c6-722d-49c8-b621-cdfd81d47d9f	141FCSpK61bDjeuSZAOS	8308	Apple Turnover	Pastries	1	154.54	2025-06-27 05:16:57	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905704043	antonio.santos6	2025-06-27 05:16:57
957e378a-33d6-4673-8b00-5fbbcf464e58	3a0iGogRnQOntRw5CPpr	8310	Chai Latte	Pastries	1	100.50	2025-10-21 08:08:28	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.bautista5	2025-10-21 08:08:28
86b40dd0-6734-49f4-b32d-2875d87af75d	oil16P9H2ENlNlhUP7HC	8313	Apple Turnover	Pastries	2	154.54	2025-04-08 07:33:41	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	sofia.bautista5	2025-04-08 07:33:41
a6798150-39e4-4668-90bf-c47356070530	YwKP8MVhnj4UW9YutYGk	8314	Macchiato	Pastries	5	93.97	2025-03-21 18:53:01	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.delacruz10	2025-03-21 18:53:01
8f662c00-15bf-49e8-882b-544938ab1249	1b8CzeKls62qHoyMDYQ7	8316	Chocolate Chip Muffin	Pastries	2	103.79	2025-04-02 15:34:05	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	admin	2025-04-02 15:34:05
44d8d0de-a9a0-4bc2-b0d0-e30b16d8eb3f	mRgNTXGWtC9ivyKd9QAN	8322	Espresso	Pastries	3	195.76	2025-01-11 08:46:07	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	gabriela.mendoza	2025-01-11 08:46:07
8227a526-d338-4b65-aa74-0683663febf5	fkymkjusb9iDRWKNFppJ	8324	Espresso	Pastries	2	195.76	2025-07-01 23:06:46	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.delacruz	2025-07-01 23:06:46
950fbca1-ae91-4fbd-b9e5-75cb4c10b3a8	AgalUEA7LPLfK94LQZeo	8333	Mocha	Pastries	1	61.74	2025-10-09 13:00:08	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183905817439	carlos.mendoza	2025-10-09 13:00:08
d40fef6d-d77a-44a2-93ce-862ef021a8bb	rmXZ9NKU31aWVzz1WDzv	8334	Espresso	Pastries	5	195.76	2025-08-21 08:12:18	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905550136	carmen.santos1	2025-08-21 08:12:18
a1e07b36-479a-4e75-b85d-80f71bbb2fbe	53v5gFVtLsAmTBlPuHhe	8335	Cappuccino	Pastries	3	76.25	2025-01-02 05:45:51	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.santos8	2025-01-02 05:45:51
78c0a47c-6a40-47e5-b371-19ca4cfed713	vPEN45D70EqIWR5S2Clt	8339	Latte	Pastries	5	108.74	2024-11-28 13:56:16	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.mendoza	2024-11-28 13:56:16
383b036d-b8a3-4eef-8e99-c5839e8a14b7	HqEDUP1BoGEvQz92irss	8340	Baguette	Pastries	5	133.77	2025-08-13 06:57:39	c8d156d2-b289-439f-90bc-692447063015	Card	\N	fernando.santos8	2025-08-13 06:57:39
4384aa54-5b93-4af5-9820-7c0da41199c5	HUAabLccXqsCsEzj5Pbn	8348	Iced Mocha	Pastries	2	144.00	2025-05-05 11:45:07	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	fernando.santos8	2025-05-05 11:45:07
baa749ab-b7d5-407f-911c-5b9f20d3515a	cxeD2NzZBHwcZPOeZ6ss	8349	Flat White	Pastries	1	113.21	2025-11-06 02:45:52	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	sofia.bautista5	2025-11-06 02:45:52
ea9fb0a1-1e22-4495-aa98-b84454a52043	Wqv9qOarWfZDJ3XXpnRV	8350	Chocolate Chip Muffin	Pastries	1	103.79	2025-03-15 11:11:33	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	miguel.cruz15	2025-03-15 11:11:33
8eab456d-96eb-4f2f-b88c-fa8bacdae1c0	UhYRqVxgea8Orbt65fiO	8351	Almond Croissant	Pastries	3	8.42	2025-01-26 00:43:12	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905277819	fernando.cruz	2025-01-26 00:43:12
760c3d18-5fa0-42a1-9e3d-00b9d90ba115	gz3lkklOuvk9vFxzugh8	8352	Tea	Beverages	1	106.18	2025-09-18 11:47:02	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.fernandez11	2025-09-18 11:47:02
0da5e1ff-aec0-404a-bfad-321140014288	UaqgLM5qD5M0dlWfpcEl	8353	Almonds	Pastries	3	5.59	2025-09-20 11:36:53	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	rosa.rivera7	2025-09-20 11:36:53
e1933b55-ad3a-4f67-8f24-6b79d8eb57ff	VgG2PPWBiUCg1jZJAOXN	8355	Chocolate Chip Muffin	Pastries	2	103.79	2025-10-09 09:47:08	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.delacruz	2025-10-09 09:47:08
c0fbca0c-6014-4e54-b177-715303722614	iw48O1HD5CdMphwt4G42	8356	Apple Turnover	Pastries	4	154.54	2025-02-27 22:53:28	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	rosa.cruz13	2025-02-27 22:53:28
234b0a31-5958-4749-a257-c4901304c73b	Fyzfnli9dEYMSyMmDwku	8359	Cappuccino	Pastries	1	76.25	2025-04-09 12:21:38	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.rivera7	2025-04-09 12:21:38
368ea22a-b48f-489a-8fbf-7d3f0b385ce4	YKWdUgBKmmnsY7XC02ak	8360	Tea	Beverages	3	106.18	2025-02-02 17:07:00	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	antonio.santos6	2025-02-02 17:07:00
a86486ad-96d0-48fa-95c6-b2a16ebd2522	bVVUA6UpqY2Qt6VvydOv	8363	Americano	Pastries	2	80.96	2025-11-23 08:14:15	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	fernando.cruz	2025-11-23 08:14:15
2ce968fb-e0a3-45c7-b8d9-1275159ac9cc	gvDBK1QWIMp6WxAi0GfQ	8366	Blueberry Muffin	Pastries	2	185.15	2025-03-13 10:47:50	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905591155	pedro.cruz14	2025-03-13 10:47:50
c4b5590a-55cf-4103-ac06-774fa60d9a35	PzvvBF49YJIVlq2niU8d	8371	Tiramisu	Pastries	2	196.55	2025-01-12 11:09:48	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183905611342	carlos.delacruz	2025-01-12 11:09:48
5f151003-f0f2-4e14-a053-e98695708a5f	owro9n4Ay1d9hapBmG4C	8372	Red Velvet Cake	Pastries	1	187.25	2025-01-14 06:10:52	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.cruz12	2025-01-14 06:10:52
89c5505d-f5be-43a5-8a93-d2b2ccb59596	SHyc4vdtQq8cdvqzErKb	8375	Chocolate Chip Muffin	Pastries	1	103.79	2025-09-14 22:41:09	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	sofia.reyes9	2025-09-14 22:41:09
a44ba262-987c-47c6-8ee3-0f2bdf27b694	o3YYy29XaYni7LeqCGrw	8377	Chai Latte	Pastries	2	100.50	2025-09-24 04:04:29	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	carlos.mendoza	2025-09-24 04:04:29
59f92c84-2198-4f08-bddc-69eeb3499581	wDIJKjrSFW4aJnXuycrD	8380	Blueberry Muffin	Pastries	2	185.15	2025-04-27 07:05:24	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.mendoza	2025-04-27 07:05:24
c4396f40-e544-44f0-bf5d-50bc165dd483	qY07vufMSlWQQEPM4Ua0	8383	Iced Coffee	Beverages	4	107.80	2025-06-16 06:10:22	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.cruz12	2025-06-16 06:10:22
0a117aa6-c1fd-4715-9639-d310660a88b5	ktE6XRfHTaX40YFekqnL	8389	Baguette	Pastries	2	133.77	2025-08-01 19:24:00	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.reyes9	2025-08-01 19:24:00
de0bfcd9-8718-4a22-8cd6-b847492f8f8a	buGrVZsUGXlqe8vI7EkI	8397	Red Velvet Cake	Pastries	5	187.25	2025-05-13 21:20:06	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.torres2	2025-05-13 21:20:06
8ecc7d2e-3a42-49c4-8cc5-afd8cb2bd78f	q5NAILArEs8QnzbfdcGk	8398	Hot Chocolate	Pastries	2	131.53	2025-10-31 15:07:11	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	admin	2025-10-31 15:07:11
95398c73-4a52-4d92-895c-4ee5699d5e53	3IcozXQjlvCey23d0gZp	8400	Glazed Donut	Pastries	5	148.75	2024-12-21 02:53:40	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.reyes9	2024-12-21 02:53:40
e3492871-57bb-45a5-b6b5-7c95c282a913	sl3PZXNaP7QWcquPmtuJ	8402	Flat White	Pastries	4	113.21	2025-05-11 04:06:05	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	antonio.delacruz10	2025-05-11 04:06:05
fcd9ebac-4bc1-4cd8-981c-7009fcf96d26	CAS28i6RHRW0dbcXnBiR	8403	Cappuccino	Pastries	3	76.25	2025-07-30 08:45:00	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905475921	admin	2025-07-30 08:45:00
086525aa-c03a-44bc-b805-5f5ee7fd53e9	DoBIIVKWl8IBzqu9APeH	8416	Blueberry Muffin	Pastries	1	185.15	2025-01-07 16:21:45	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905592499	ana.rivera3	2025-01-07 16:21:45
18a6351d-356b-4a9d-9ace-160305e6bc6e	pO3gP7AwIj3fyLs4rNKF	8421	Americano	Pastries	1	80.96	2025-01-12 20:41:40	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905203737	fernando.santos8	2025-01-12 20:41:40
0e8689dc-d11e-4313-9f45-5e89b1198df1	vrt6JV2u5zy9IkAlZTXC	8426	Eclair	Pastries	3	146.12	2024-12-08 02:17:56	d822e322-66a9-432e-aca0-2adc5fbb656a	Card	\N	carlos.cruz12	2024-12-08 02:17:56
dbe04706-cf8b-4096-8bf1-69d7b142be1e	MmpDmCHp5izJtEusKID2	8427	Iced Coffee	Beverages	1	107.80	2025-09-25 12:27:31	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	rosa.rivera7	2025-09-25 12:27:31
9157ccbd-432e-46f7-ba21-8199a7b8e707	oILtrdXqObeiDUBV4uX3	8428	Almond Croissant	Pastries	4	8.42	2025-09-23 16:12:11	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	isabella.delacruz4	2025-09-23 16:12:11
39a99e74-e3f7-4e7e-9a73-ff19b313513e	MLLB1kUuhFQDBEUyQa9v	8431	Almond Croissant	Pastries	4	8.42	2025-05-23 13:46:18	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	ana.rivera3	2025-05-23 13:46:18
d50c0b0e-1a68-4649-bed1-c72f0e20e1ef	mhe7ry8kaAv423Fv5rUm	8435	Chocolate Chip Muffin	Pastries	2	103.79	2025-07-17 11:03:23	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905538719	carlos.mendoza	2025-07-17 11:03:23
975b5664-0795-4495-9507-d313b60d55f9	VUVQkkU9JbVxX5BX2aR1	8436	Hot Chocolate	Pastries	5	131.53	2024-12-16 01:21:17	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	carmen.santos1	2024-12-16 01:21:17
671e7fb1-6c7c-4a3b-8626-1b56a18d21c2	DfritGMbCl5cQXSB1lbn	8439	Tea	Beverages	1	106.18	2025-01-08 16:02:28	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	sofia.bautista5	2025-01-08 16:02:28
c4ab8fd6-15f6-4cfe-88cc-9827d8b2d503	uSePhMWaFDehaSa5fDJk	8441	Cappuccino	Pastries	3	76.25	2025-02-07 08:15:58	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905015520	elena.fernandez11	2025-02-07 08:15:58
d992d1cd-d47c-4fd7-a6c2-beeba0ee0a3a	j1VRZCgZpbiTqgHAlvy1	8444	Chocolate Chip Muffin	Pastries	3	103.79	2025-05-15 07:37:41	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	miguel.cruz15	2025-05-15 07:37:41
8466c40d-adb9-4980-beca-5fd20967b2ab	3fvH7cBF9yOCv81q3LaE	8447	Iced Mocha	Pastries	2	144.00	2025-01-16 22:29:34	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905648197	rosa.cruz13	2025-01-16 22:29:34
70f6aaab-ab99-4bf7-8616-fcc1d9261ef8	xmYzQymZUW9UvktaEd8x	8450	Flat White	Pastries	4	113.21	2025-09-14 14:57:33	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	miguel.cruz15	2025-09-14 14:57:33
02338815-8e29-4ff4-97f9-ea531157402f	oEW7wrzz8lOtMYNZbHIB	8454	Chai Latte	Pastries	1	100.50	2025-05-02 13:19:23	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	miguel.cruz15	2025-05-02 13:19:23
f9f26420-b9ab-4135-be7a-b96fba383a4a	gAvxePktrvNP5Eqnbb37	8455	Red Velvet Cake	Pastries	3	187.25	2025-08-04 05:38:11	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905798900	carmen.santos1	2025-08-04 05:38:11
38ad411e-8e12-49f5-bb76-d5156aac270d	l69TIknA1rNShLoDj5cW	8460	Red Velvet Cake	Pastries	4	187.25	2025-03-09 00:27:37	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	antonio.delacruz10	2025-03-09 00:27:37
67a4ceb4-cbe3-4fd1-aee6-2ac3a3218923	ksqtNiglqpXKDqro3hBR	8461	Chai Latte	Pastries	1	100.50	2025-11-14 04:37:57	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905683465	sofia.reyes9	2025-11-14 04:37:57
7014ba69-96c0-4d73-908b-32738aabc33d	rcVcZyISV5bJwGAwIj9E	8465	Hot Chocolate	Pastries	1	131.53	2025-06-19 05:44:37	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905243147	admin	2025-06-19 05:44:37
84ee5f5d-e048-46a7-a4b3-58e9a0284015	o1GsyOS9sV6OseATOA8Q	8469	Iced Coffee	Beverages	1	107.80	2025-09-22 17:56:38	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905380014	carlos.delacruz	2025-09-22 17:56:38
affeee69-1e9f-40ae-bcf3-20af296b15df	uYEYnhnK2vriBg6pRISl	8470	Chocolate Chip Muffin	Pastries	4	103.79	2025-04-16 11:28:59	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	miguel.cruz15	2025-04-16 11:28:59
e5e40f9f-1528-42d9-9982-18d60540c34c	hVT0EDqTW5R2V0A6omIo	8474	Almond Croissant	Pastries	3	8.42	2025-11-11 06:50:12	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.delacruz	2025-11-11 06:50:12
6d0e1ba1-8635-4c24-8912-4b75e6691eff	tTMLJG2hHUpyH0uCzDYO	8479	Macchiato	Pastries	1	93.97	2025-11-01 01:15:35	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.santos6	2025-11-01 01:15:35
bd6179b5-a283-441b-871d-d4ca82a0ce55	rEYj1yBrhJirPCKNBt2F	8480	Baguette	Pastries	5	133.77	2025-09-08 11:24:02	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	pedro.cruz14	2025-09-08 11:24:02
1833c504-4511-4f2b-ad23-9f8274babea6	7Db60AK8bxNFawJcFqYj	8481	Blueberry Muffin	Pastries	3	185.15	2025-04-10 20:49:14	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905462104	gabriela.mendoza	2025-04-10 20:49:14
68c08d3c-2b99-4974-8440-f8b0239b6a76	imp9JeQgeKQKoxoNMj68	8484	Red Velvet Cake	Pastries	2	187.25	2025-06-28 10:50:32	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	sofia.reyes9	2025-06-28 10:50:32
8d1c536f-0625-4a00-aca6-e947d1d7d3bc	8eerQS46iaRSvbKf5USK	8489	Macchiato	Pastries	1	93.97	2025-08-18 12:00:05	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	carlos.cruz12	2025-08-18 12:00:05
3d1fca55-6b66-4787-9712-91fd930d1c02	DSyHypbTWlXwBfa71BP0	8494	Baguette	Pastries	5	133.77	2025-09-14 02:14:43	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905547279	elena.torres2	2025-09-14 02:14:43
e1c139f3-ec12-4261-aac1-bf4e39eff68d	zPsiPVuGLWNpWzCHhfma	8496	Tiramisu	Pastries	3	196.55	2025-04-06 04:23:48	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	isabella.delacruz4	2025-04-06 04:23:48
e0ec53ad-815e-4bb7-a9cb-afe2a8460851	iRbF3TRy8V9FXvgeEqMc	8503	Mocha	Pastries	1	61.74	2025-10-27 01:10:55	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.bautista5	2025-10-27 01:10:55
4b70e809-233b-4070-8c1c-b4678780823a	8r6TCAj1zoxVx0G4kGjP	8508	Americano	Pastries	1	80.96	2025-01-05 01:43:52	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	elena.torres2	2025-01-05 01:43:52
0716e9de-2dd6-4d93-a92a-51b699d86086	rtPRbgbUzQV4wiHoaRq8	8515	Americano	Pastries	2	80.96	2025-02-21 11:47:23	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	elena.fernandez11	2025-02-21 11:47:23
69ea5e18-28a4-4cab-a0f7-e3c8e2ef8c38	9KgQPZYtWQLtZbQtnaXf	8519	Espresso	Pastries	4	195.76	2024-12-26 14:38:29	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carmen.santos1	2024-12-26 14:38:29
a09bd585-e9c0-47db-85e1-32d4b4d511d8	h23Rp1yDMvwKahXqbdYc	8520	Iced Coffee	Beverages	4	107.80	2025-03-30 15:31:20	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.santos8	2025-03-30 15:31:20
57874fd0-c895-4188-9e11-1734026a05f0	o8lkdG5vq3sLHdyGxrxB	8525	Espresso	Pastries	4	195.76	2025-11-03 09:56:53	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	gabriela.mendoza	2025-11-03 09:56:53
733b5ce1-5dc0-4676-aee7-1d2b992d09a3	Rq9lr2e95Xw3XHm34sed	8528	Chocolate Chip Muffin	Pastries	2	103.79	2025-02-04 12:15:53	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905087783	sofia.bautista5	2025-02-04 12:15:53
8ff1688e-f68a-4e34-9d87-9ac869f30255	h9XbGLb1dM0YxoPsJCr7	8533	Almonds	Pastries	3	5.59	2025-02-25 18:01:28	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	fernando.cruz	2025-02-25 18:01:28
5c9d749d-90b8-4220-906f-7ea3f2f74f34	qjkrYqBfFiDjcPtSHI0B	8536	Tea	Beverages	3	106.18	2025-06-17 23:58:56	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	sofia.reyes9	2025-06-17 23:58:56
cc004a90-7a4a-402c-b4d2-82e38809e788	H9RJ0Wxbof5TzUMq7gEp	8537	Iced Coffee	Beverages	2	107.80	2025-08-06 08:18:03	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	fernando.santos8	2025-08-06 08:18:03
d63d482f-e8b5-434e-856c-b6c91789e437	NKOvsyhExjWaMbz8jPBA	8539	Flat White	Pastries	2	113.21	2025-11-03 21:18:28	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	sofia.reyes9	2025-11-03 21:18:28
9ca2f07e-7612-48dd-ba0f-85e666ef20d0	iiCosfF3noKIvrKaBRiS	8541	Iced Mocha	Pastries	4	144.00	2024-12-01 12:28:18	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905481053	elena.torres2	2024-12-01 12:28:18
4fe8aea6-8ad1-4cba-9395-3cce5ea399e4	Fo3QJVy6MVDrArTkARYU	8547	Blueberry Muffin	Pastries	1	185.15	2024-12-07 06:29:09	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905886769	isabella.delacruz4	2024-12-07 06:29:09
a93c22dc-4164-4123-89da-2e518c87110e	L3FHe3Chpu1jeFgyvjnl	8550	Flat White	Pastries	3	113.21	2025-03-01 04:13:01	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	gabriela.mendoza	2025-03-01 04:13:01
9ff3cbc6-18c1-48f0-9933-a973f9a67d03	fY9HGUQiDoaWHbGkGr5u	8554	Flat White	Pastries	2	113.21	2025-10-20 16:41:57	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905534241	sofia.reyes9	2025-10-20 16:41:57
5575b211-32ba-466d-b643-960a0f58951a	DojCXtQ3CQHsIak5nl1u	8556	Flat White	Pastries	5	113.21	2025-06-17 05:10:12	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	antonio.santos6	2025-06-17 05:10:12
381d89f1-1ad4-42aa-a004-f6bb63d6713d	1TRivKo5BJJx2DyKJuuG	8559	Latte	Pastries	5	108.74	2024-12-04 14:32:33	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905488691	gabriela.mendoza	2024-12-04 14:32:33
be52db6e-ba86-4e1b-9b90-6f68e9977d27	UBNioZS3khbPGDzHSwSS	8568	Hot Chocolate	Pastries	5	131.53	2025-10-25 11:08:07	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	antonio.delacruz10	2025-10-25 11:08:07
c6b68dc3-de6d-4e6e-ae57-537d4532e080	hf5RfDeFyfMHrQwiaH7w	8570	Latte	Pastries	4	108.74	2025-11-09 20:19:46	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905445366	elena.fernandez11	2025-11-09 20:19:46
75349008-d4ba-4c83-89ff-d92bd75b8e4f	UIOnZ0Q8lp0svF3JK0Y1	8572	Flat White	Pastries	5	113.21	2025-09-28 18:42:39	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	ana.rivera3	2025-09-28 18:42:39
d0dc23eb-8781-45f9-8cfc-20035a4dcbd4	UkkGFm3SNkXwERRcu8Yi	8573	Iced Mocha	Pastries	3	144.00	2025-09-30 14:13:02	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905210381	ana.rivera3	2025-09-30 14:13:02
8701143e-100d-48b3-b1d9-2373e5d5dda2	rhrmTF2COj2JVBUPLS2n	8574	Baguette	Pastries	4	133.77	2024-12-25 16:57:35	c8d156d2-b289-439f-90bc-692447063015	Card	\N	fernando.santos8	2024-12-25 16:57:35
207fef7b-c82c-47bd-801b-f48d6e48afbe	TjdYl5G7oM2l5oXHiu2L	8578	Tiramisu	Pastries	1	196.55	2025-05-17 21:55:55	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	pedro.cruz14	2025-05-17 21:55:55
271d8358-9e52-4bac-840e-b57f4e738c18	jHkGeeKJ54t4lgcqU7Df	8582	Hot Chocolate	Pastries	1	131.53	2025-07-04 12:07:30	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905864187	antonio.santos6	2025-07-04 12:07:30
5504e814-a737-42d9-8d24-b3becabcba98	aO2HPUA78Tiu5ItaZAHk	8587	Blueberry Muffin	Pastries	5	185.15	2025-11-23 19:14:23	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	gabriela.mendoza	2025-11-23 19:14:23
fa1144be-c2ce-433c-b5a8-3c34bfd0a0c6	SDZRxaLF3B7xV7UEulOC	8591	Almonds	Pastries	1	5.59	2025-05-13 21:03:19	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	ana.rivera3	2025-05-13 21:03:19
8c623731-68b3-45c1-8d47-8a4a62708cfb	zwlCXBeriZRpUhcfoKKM	8600	Macchiato	Pastries	4	93.97	2025-03-08 15:56:59	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	miguel.cruz15	2025-03-08 15:56:59
c97475ac-499b-48ea-941e-27f5502aad9d	CAQym9VZPPT2620iIUzH	8605	Cappuccino	Pastries	2	76.25	2025-11-16 19:31:42	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.torres2	2025-11-16 19:31:42
367abef5-6fc2-435c-af03-daf437074883	HpsMNUvcpK0KF6XUuTcb	8609	Apple Turnover	Pastries	4	154.54	2025-04-14 21:21:58	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905957497	elena.fernandez11	2025-04-14 21:21:58
73269bd8-b211-4c02-978d-6a4ba267af6e	nAGhme2xX5ilntYB14c1	8611	Iced Mocha	Pastries	2	144.00	2025-02-06 06:03:51	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905067152	carlos.mendoza	2025-02-06 06:03:51
f76a8eed-e4d2-45cd-a2e5-461775c228c3	TPo5sKmzWdKMGMzvJR8u	8612	Iced Coffee	Beverages	5	107.80	2025-02-27 09:37:22	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905826235	elena.torres2	2025-02-27 09:37:22
91f5b1f6-4168-4196-bc6b-44d7a4ccbae5	dsXVh6PC6tv9sbRTIyvl	8614	Red Velvet Cake	Pastries	1	187.25	2025-08-29 15:10:12	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	rosa.rivera7	2025-08-29 15:10:12
24d83c0e-d569-4aae-a48e-089d855d16ed	EPjOxIcGdc1FAdoxU0VB	8617	Baguette	Pastries	4	133.77	2025-04-24 10:00:47	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.fernandez11	2025-04-24 10:00:47
8c57003c-e334-4076-bd4d-87dd16e140fd	W3ThClpH9IxHRge0Mbmq	8623	Almond Croissant	Pastries	3	8.42	2024-12-23 04:48:03	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.delacruz	2024-12-23 04:48:03
d4eddf61-703a-44ec-b367-4edb8eaeec4a	wTnYxLV1O05exPjmWGXn	8624	Flat White	Pastries	5	113.21	2025-10-25 00:32:22	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905863306	sofia.bautista5	2025-10-25 00:32:22
d55f42f3-8afe-421f-95b7-9e20de4324fa	O8eOY3bxNpOW62i7vPm5	8626	Latte	Pastries	5	108.74	2025-06-25 03:55:35	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	sofia.reyes9	2025-06-25 03:55:35
921d4a9e-a6e0-4890-b62c-5abbf894bf86	NaaAqpLcVN1BzdZReCT8	8628	Chai Latte	Pastries	2	100.50	2025-03-15 10:38:59	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905832867	elena.torres2	2025-03-15 10:38:59
237d57e0-02e0-4d10-9c73-61e7347b73b5	uckav8xj4sCmALaG26Pj	8629	Macchiato	Pastries	5	93.97	2025-04-22 20:25:05	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.santos6	2025-04-22 20:25:05
cc7f2c78-1122-430c-abee-d213237e8754	QKNHtojKclcUZKVltv7L	8633	Chocolate Chip Muffin	Pastries	2	103.79	2025-07-16 23:33:10	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.rivera7	2025-07-16 23:33:10
9273ad68-20a0-4c07-bb25-00cf938ac3da	INjnXaUecZGJwYE3cd9j	8638	Eclair	Pastries	5	146.12	2025-09-26 07:10:32	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.delacruz10	2025-09-26 07:10:32
24e87049-fe56-44d8-8bd8-59e6da4139f5	jATlhibemOd1TaZYNDNZ	8646	Cappuccino	Pastries	4	76.25	2025-09-01 06:07:21	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	miguel.cruz15	2025-09-01 06:07:21
b6d62571-4e8b-49a9-a2b8-078df0cb9183	UyelV5VAuhGHq7MsGaek	8647	Blueberry Muffin	Pastries	1	185.15	2025-01-13 18:47:22	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.cruz	2025-01-13 18:47:22
b6b25840-3cfb-4686-af59-ec4dce858677	2dhQsiROS8cQOZd0lvNw	8650	Cappuccino	Pastries	4	76.25	2025-08-20 03:19:19	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	elena.fernandez11	2025-08-20 03:19:19
fc8bdf5b-a94b-4f65-bea2-9895025932c3	45Paqj4xeRReJf9JTmk3	8651	Chocolate Chip Muffin	Pastries	2	103.79	2025-04-28 02:35:55	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	admin	2025-04-28 02:35:55
d7200644-b00a-4d93-8800-214a413b5837	l88yEw6UdKRr5WfbEfbq	8652	Apple Turnover	Pastries	3	154.54	2025-08-24 14:30:54	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905815748	rosa.cruz13	2025-08-24 14:30:54
77641d72-04cf-4d4c-80f6-1c20c69a801a	pcWaHGgNvcuU4dDmdB2o	8655	Tea	Beverages	2	106.18	2025-08-02 17:15:16	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Card	\N	isabella.delacruz4	2025-08-02 17:15:16
bc998439-d7fc-476f-9b78-2ea2443699bd	yjioYaj35HL3sNB0xOtS	8658	Baguette	Pastries	5	133.77	2025-07-19 14:53:08	c8d156d2-b289-439f-90bc-692447063015	Card	\N	fernando.cruz	2025-07-19 14:53:08
a0d83e25-9460-41ff-84f2-2e9df5cfdb06	jhATWUBRiA9rl6lffMIt	8662	Latte	Pastries	5	108.74	2025-06-21 00:31:07	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905776926	rosa.cruz13	2025-06-21 00:31:07
6f802669-053b-4876-af9a-55f68cd17f83	TQU20akpNP2tIsiyBraw	8663	Chocolate Chip Muffin	Pastries	5	103.79	2025-02-01 22:26:30	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	sofia.bautista5	2025-02-01 22:26:30
c91bca21-ca28-45e8-a97b-f83406dffb30	lK8deh38HImERdRLz5z8	8674	Tea	Beverages	5	106.18	2024-11-29 21:56:33	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	rosa.cruz13	2024-11-29 21:56:33
5627c1c7-5502-4417-ad2e-71079596b7bb	k6q8KSZbv3LBDzkIUpB3	8677	Tiramisu	Pastries	2	196.55	2024-12-18 18:31:57	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.delacruz10	2024-12-18 18:31:57
d0ff7836-23b0-47ca-aa41-0d2df59ca922	n6uACjLTVxovKtolGaEy	8678	Cappuccino	Pastries	2	76.25	2025-08-06 09:29:04	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.cruz	2025-08-06 09:29:04
0243d9ca-c861-4a8d-9511-4eacf71b7429	0d2PK82IPkgAMInyarBg	8679	Cappuccino	Pastries	4	76.25	2024-12-03 16:58:27	60701303-6f07-449f-8055-ceb7711b168b	Card	\N	carlos.delacruz	2024-12-03 16:58:27
29826569-fa21-43c8-a051-653d2db8366e	h9XrX1qwqz8LAOkW3nC1	8688	Latte	Pastries	4	108.74	2025-06-20 02:22:12	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.cruz	2025-06-20 02:22:12
370ba0b0-8d01-4d3c-a496-053df622f57b	pAXMoFgGlVhJsa4CTrYw	8692	Cappuccino	Pastries	1	76.25	2025-08-31 08:42:37	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	sofia.reyes9	2025-08-31 08:42:37
65118812-0337-4c2f-b13f-9615a6ade413	aJqmNkoKhdztrLviLdjR	8693	Chai Latte	Pastries	2	100.50	2025-11-09 11:30:59	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.bautista5	2025-11-09 11:30:59
223bf92d-18db-49e3-97b1-3a1a90ff6606	1SuZBT7hWZYCgbxHzwK6	8695	Espresso	Pastries	2	195.76	2025-11-15 00:07:31	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	elena.torres2	2025-11-15 00:07:31
9ce42a73-65ca-453d-8b37-049fe8eb3e09	GYKCQor3L4PSkHt6UtRc	8698	Red Velvet Cake	Pastries	2	187.25	2025-09-13 05:22:56	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.mendoza	2025-09-13 05:22:56
dba63f19-9e2b-4a26-9f3a-876172797c04	HohovOyURnGD3HSWrdB0	8703	Glazed Donut	Pastries	1	148.75	2025-01-21 00:14:30	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.bautista5	2025-01-21 00:14:30
3a3e99a7-fcde-46d2-8b2a-bbc338b9104f	LaLsKBeeB8QbfSI0zX0M	8704	Glazed Donut	Pastries	3	148.75	2025-09-09 12:51:33	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carmen.santos1	2025-09-09 12:51:33
b0519c61-1b48-4391-9ace-a8135caf9d1d	dU2gv7Df4DLTH0i8s0Y1	8708	Iced Coffee	Beverages	3	107.80	2025-07-07 06:10:31	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.reyes9	2025-07-07 06:10:31
16c6011c-8e63-4f53-9d65-631811555d45	zww20s5zLSEw5f0hjNUW	8709	Macchiato	Pastries	3	93.97	2025-03-17 12:53:07	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.delacruz10	2025-03-17 12:53:07
ee4ce457-a852-4163-a5cc-f5bd986f2b90	PR37cLFSisYBQVkvWfHZ	8712	Chai Latte	Pastries	5	100.50	2025-05-22 18:26:53	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	isabella.delacruz4	2025-05-22 18:26:53
09da9339-de8f-4405-b101-a0da1a0b1cb3	N8qjd2KVzouPsQqKvdux	8714	Mocha	Pastries	5	61.74	2025-05-13 09:35:09	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.cruz	2025-05-13 09:35:09
5f8a3c42-7740-42bc-b01a-61a7eb12e72d	HKSuKGaiOW095cenPH13	8715	Espresso	Pastries	5	195.76	2025-09-30 23:40:56	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	isabella.delacruz4	2025-09-30 23:40:56
e78f6f95-e810-4e82-8c1b-596ec9f2af30	BzZkvA85yOP7vzRMeQ0w	8717	Almond Croissant	Pastries	4	8.42	2025-07-03 08:35:00	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905703957	isabella.delacruz4	2025-07-03 08:35:00
fe3137fd-eca9-4cb4-b28e-3800a465c986	x2jXKY0jGBHEcJ2V72zE	8718	Glazed Donut	Pastries	5	148.75	2025-06-04 10:40:56	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	elena.fernandez11	2025-06-04 10:40:56
db4c9332-b7dc-476c-a1b5-63fd74dec494	C5p0mwY888TGuolGjUCI	8723	Chocolate Chip Muffin	Pastries	5	103.79	2025-11-22 00:53:36	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	antonio.delacruz10	2025-11-22 00:53:36
556d89fa-a1fc-4327-b29c-97fdb9ebefe4	GMufmnltTKEj7AtAKvBO	8727	Glazed Donut	Pastries	3	148.75	2025-09-26 02:36:23	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	antonio.delacruz10	2025-09-26 02:36:23
7aa67044-cf7e-49ac-a094-a03db323f6c7	hgiASHpK3CEWmMzQ6Y8e	8728	Blueberry Muffin	Pastries	2	185.15	2025-08-22 00:51:07	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.delacruz10	2025-08-22 00:51:07
03063bf8-663d-40b4-bd9c-1f6140939e53	wicIKdJeK1XXqbv7nokE	8731	Espresso	Pastries	1	195.76	2025-02-25 12:39:06	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	isabella.delacruz4	2025-02-25 12:39:06
bf5b998c-8300-43c3-aaea-368ff2619cd8	l30qqSaOfha4g80GRxWH	8732	Blueberry Muffin	Pastries	1	185.15	2025-11-08 12:05:04	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	admin	2025-11-08 12:05:04
860714ae-a877-4fe4-8681-6d633b08813a	OkfpgEut8Iypmg6lxJc8	8734	Hot Chocolate	Pastries	1	131.53	2025-02-20 20:11:17	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	antonio.santos6	2025-02-20 20:11:17
c5f3ec7f-f92e-4971-97e5-edc67bd464f4	53srVpLTbdS7FFsyGm73	8736	Americano	Pastries	4	80.96	2025-04-25 08:00:03	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	fernando.santos8	2025-04-25 08:00:03
d13dea0e-6978-46f4-88d0-f1c71481d64c	5CzAvBUrurWiWmntQG4c	8739	Almonds	Pastries	5	5.59	2025-05-21 06:43:54	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905255436	antonio.santos6	2025-05-21 06:43:54
abed2a0f-cab4-4e28-8ad1-70b3a7a39503	Q9v9Rxj2jB4U1SJ9BIfg	8740	Americano	Pastries	2	80.96	2025-08-10 12:02:46	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905253040	rosa.cruz13	2025-08-10 12:02:46
c0289660-07bc-41f9-bb2c-88d1468f5197	CiuyS5eQSQVmF5lBOZEN	8741	Blueberry Muffin	Pastries	3	185.15	2025-07-18 03:42:54	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	miguel.cruz15	2025-07-18 03:42:54
b6fcb585-8912-4772-99ba-6057b8d47fba	s9OGEkUCcnXbRzG9vvr0	8743	Chocolate Chip Muffin	Pastries	2	103.79	2025-11-16 18:03:55	996934ff-5758-44b4-ad0e-4ed9d927901e	Card	\N	antonio.santos6	2025-11-16 18:03:55
0bca9ef5-d64d-4d75-98fe-a8df85def113	d1lhKMMu5n3o9hK6RzGO	8747	Almond Croissant	Pastries	2	8.42	2025-07-27 23:01:42	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905176310	sofia.bautista5	2025-07-27 23:01:42
0afce4a9-0750-448b-829f-426b4cf96499	T2taP7yXbsFth2I2fUxh	8748	Tea	Beverages	5	106.18	2025-08-02 22:03:34	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	ana.rivera3	2025-08-02 22:03:34
8ece4737-c0fd-4ebb-84f9-1aab49ad26ea	AuWdrCbrfBjHSDUdv5Q8	8753	Tea	Beverages	5	106.18	2025-09-25 11:14:20	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.fernandez11	2025-09-25 11:14:20
356ffe4b-4474-4c6f-bd71-148f6c17bb7b	GKcLv5kThlcagkcs6RLw	8755	Iced Coffee	Beverages	1	107.80	2025-02-10 01:46:34	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905912503	carmen.santos1	2025-02-10 01:46:34
997adfd4-709a-4ceb-82d4-08c8b122ceed	esIF0Nho0NxtZmgsjABE	8757	Baguette	Pastries	5	133.77	2025-02-24 23:57:22	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.mendoza	2025-02-24 23:57:22
a3ada421-a028-4cc5-8a00-b03039f9455a	XCg0sMeLoH2J1ZGHri1w	8764	Baguette	Pastries	5	133.77	2025-03-10 08:14:54	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.fernandez11	2025-03-10 08:14:54
6e26118a-fa7d-47da-8c0e-878ae6536c5f	bDT38FzRv8oKfH88wTde	8765	Glazed Donut	Pastries	3	148.75	2025-11-19 04:34:22	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	sofia.reyes9	2025-11-19 04:34:22
94550e3b-8f45-4baf-be1e-9bc988b2c5ec	SYf9PhQswbMTvy3bEqCM	8767	Chai Latte	Pastries	5	100.50	2025-02-21 19:38:08	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	elena.fernandez11	2025-02-21 19:38:08
db93b108-ed8d-4633-9408-5829151b43ac	7IkO1PjTYq4CXcB9duF0	8774	Eclair	Pastries	5	146.12	2025-11-08 00:14:44	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905029588	miguel.cruz15	2025-11-08 00:14:44
cf776bcf-8377-4e04-99b5-b89c97e5b4f8	cXESdskibBFrdBsQ05nx	8780	Iced Mocha	Pastries	2	144.00	2025-08-15 16:43:43	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	fernando.cruz	2025-08-15 16:43:43
e1cd5960-2996-4437-ad80-b988acd7aca9	fNR16nG3LJteHqXJ72EF	8782	Tiramisu	Pastries	5	196.55	2025-05-05 00:58:20	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	ana.rivera3	2025-05-05 00:58:20
01ae6cc2-3392-4014-b079-24c9333f2720	tqlnPr7k9dtMHJImZeuB	8785	Latte	Pastries	1	108.74	2025-09-21 23:54:23	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905220435	miguel.cruz15	2025-09-21 23:54:23
40394497-f55c-4daf-ad43-a25a4ce361f8	OSdjdT2p5zNxMW2Nl2iF	8788	Eclair	Pastries	1	146.12	2025-09-25 14:38:07	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.cruz12	2025-09-25 14:38:07
c64d0813-d667-4a92-939b-98a0c2a47257	VVTieOf1MQmLf4Lhly7s	8794	Glazed Donut	Pastries	1	148.75	2025-01-17 06:24:58	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	elena.torres2	2025-01-17 06:24:58
871cecd0-c4ff-4d95-b824-f42ce071cea0	1NbPdLDdTykc5LJWpMO1	8796	Blueberry Muffin	Pastries	3	185.15	2025-11-08 11:16:35	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905745042	antonio.santos6	2025-11-08 11:16:35
9a1e47cf-8e91-4879-b3ec-2ea6de823da3	1J6PvTEQEE106X61hRMy	8797	Baguette	Pastries	5	133.77	2025-08-03 16:49:46	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.cruz12	2025-08-03 16:49:46
65929d47-6970-4496-903b-f50b03f4386f	pNOIIdFKCJBySx6zaGRX	8798	Chai Latte	Pastries	2	100.50	2025-04-28 04:12:41	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	elena.fernandez11	2025-04-28 04:12:41
9ca1d64d-54c6-43f0-b837-682d5bef1da2	TZebTcgQp8hHbh5n6txl	8799	Apple Turnover	Pastries	5	154.54	2025-09-10 21:58:27	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	pedro.cruz14	2025-09-10 21:58:27
ab98b3bc-fc51-49e2-9742-7e89f3eaf4c8	8LWYU61w6sded3VTXlyp	8800	Apple Turnover	Pastries	5	154.54	2025-03-18 14:01:40	5be3f24c-3995-4c70-8197-04b96e82fdaa	Card	\N	carlos.delacruz	2025-03-18 14:01:40
941fa772-dd47-417b-867b-f7a15842e644	cBfYBVupXlPDwKcyJR89	8803	Cappuccino	Pastries	4	76.25	2025-01-30 00:08:16	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	admin	2025-01-30 00:08:16
1a6e7859-2f24-444a-a5be-82c9214a6f4d	aFsUXSjuqh09ymO5xvWT	8805	Red Velvet Cake	Pastries	3	187.25	2025-11-17 04:08:54	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	fernando.santos8	2025-11-17 04:08:54
0db40500-6e36-48f3-8868-ece905a8a2e6	BQ3Iw6yuJFo1Vpm1WEri	8809	Americano	Pastries	1	80.96	2025-02-20 10:22:45	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.cruz13	2025-02-20 10:22:45
3eb56bf8-a908-4dd1-aeb5-681e10f2186e	J6PqshsI4yGJ9Wqcvz6c	8814	Glazed Donut	Pastries	3	148.75	2025-02-11 15:28:47	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carmen.santos1	2025-02-11 15:28:47
07c10935-4339-4e7a-b74f-aae491808f4a	F3EVltOj6vHocn2rWcER	8817	Iced Mocha	Pastries	3	144.00	2025-05-14 05:08:06	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905360856	antonio.santos6	2025-05-14 05:08:06
c42bd367-f4e3-4eed-b39b-e67319be2320	Gro62opuWeRJbZEdOCBk	8818	Chai Latte	Pastries	4	100.50	2025-08-03 23:09:34	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carmen.santos1	2025-08-03 23:09:34
191e5da4-0367-41b8-972a-51190b8e50c6	eCkNGrlUPdTVtVLOG4IZ	8823	Iced Coffee	Beverages	2	107.80	2025-09-29 00:41:47	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	miguel.cruz15	2025-09-29 00:41:47
95b9c82b-7ff7-4f44-80bb-0d8b34761527	StBQRTogbA08ItO4pqiX	8825	Almond Croissant	Pastries	3	8.42	2024-12-14 17:40:20	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.mendoza	2024-12-14 17:40:20
11bf572c-3d8e-4347-acc6-6ffa1237067d	OLpmwmj0UDB9S8fKsfvv	8832	Glazed Donut	Pastries	1	148.75	2025-05-04 03:26:11	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	pedro.cruz14	2025-05-04 03:26:11
190c2493-0a04-46a8-935a-f0a83107f0e0	dgv4mRReAUcrsLcxNjH7	8834	Almonds	Pastries	2	5.59	2024-12-12 06:01:28	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	ana.rivera3	2024-12-12 06:01:28
5fcc2518-e4f6-4d00-894d-55838c38091f	kJw21kPxRp7cNtPEBXXu	8835	Iced Coffee	Beverages	3	107.80	2025-10-31 12:22:57	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905822121	carmen.santos1	2025-10-31 12:22:57
b92d2b4f-a0f6-428b-bcba-0fc27aa02235	OGmzkExvpmrQlRjH7AhT	8837	Iced Mocha	Pastries	3	144.00	2025-02-03 00:29:35	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905151119	carlos.delacruz	2025-02-03 00:29:35
59e58cdf-6f10-42b8-aae0-21d28722c01e	Vq0M5UfNUlmPSkvNsK2g	8838	Tea	Beverages	5	106.18	2025-08-11 00:51:15	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	gabriela.mendoza	2025-08-11 00:51:15
3ccd39ca-0839-4964-8aec-3852d24b78f1	XyeI9CdQ0OCZsUt8Dgbe	8844	Blueberry Muffin	Pastries	5	185.15	2025-05-16 11:26:29	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905523187	fernando.cruz	2025-05-16 11:26:29
14e1f863-6cc3-45df-acb9-98b7be0905b6	aE2sMBzVoOTTMAivmOBo	8848	Eclair	Pastries	5	146.12	2025-07-29 03:47:52	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	ana.rivera3	2025-07-29 03:47:52
7307f9b4-a994-4baf-a158-c3c42e0c4b01	PcNjlEf4aYYQCsknTpFp	8852	Apple Turnover	Pastries	4	154.54	2025-07-15 13:51:48	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905681801	rosa.rivera7	2025-07-15 13:51:48
a9d94c3e-44e7-4486-ad01-3dffacc0efbb	jhM4dh1zj94Wb2OTTcle	8855	Eclair	Pastries	3	146.12	2025-10-17 02:24:21	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	elena.fernandez11	2025-10-17 02:24:21
e8f37f48-37cb-485b-bb4e-d9250ebe3489	DqQXBirVyvHBZRcOlVau	8862	Tiramisu	Pastries	2	196.55	2025-08-03 01:50:55	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	sofia.bautista5	2025-08-03 01:50:55
df4d8e62-b887-4da3-ae45-09e82a4db610	BpSPSRahWfZgf8ZBxw6X	8865	Americano	Pastries	4	80.96	2024-12-01 02:28:13	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carlos.mendoza	2024-12-01 02:28:13
f33ee00b-5f7a-41c6-b0c0-c52da77cf1ad	qQaWRIiFBAJMuJiEHTTq	8867	Blueberry Muffin	Pastries	3	185.15	2025-03-14 11:54:42	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.mendoza	2025-03-14 11:54:42
f3f263c7-474f-4b7f-91d3-584037821ea1	xznRtErZVYtY9HPjEMpH	8868	Eclair	Pastries	1	146.12	2025-07-18 20:05:29	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.santos6	2025-07-18 20:05:29
8e648e55-964a-4a3a-a84d-8c9d52c8c630	pcKgnDJ1k00uqrEUC1lF	8870	Baguette	Pastries	3	133.77	2025-10-25 23:26:55	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	fernando.santos8	2025-10-25 23:26:55
3fc9b7df-2703-4421-ae7d-a6832705bbf7	mNb6VmPxz602lkmkIhNA	8871	Baguette	Pastries	1	133.77	2025-06-07 11:53:18	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.delacruz	2025-06-07 11:53:18
46d74bc2-6028-4cbf-a12c-d89dd06336f4	OSpLX4uJK0ubKrnAikB1	8873	Mocha	Pastries	4	61.74	2025-06-29 20:17:18	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	ana.rivera3	2025-06-29 20:17:18
358a284a-95d6-448c-a488-9accb36450c5	EQ2crLgBYLHXYQge8x5I	8874	Americano	Pastries	2	80.96	2025-04-19 00:59:36	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	gabriela.mendoza	2025-04-19 00:59:36
777dbafb-c25c-484b-930e-87f1ca740de4	egl8DppIvnsC5JdnE2kB	8880	Americano	Pastries	1	80.96	2025-05-03 17:40:04	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	carlos.delacruz	2025-05-03 17:40:04
b6f477eb-ed09-4dfe-9b97-cf7e2b22c958	FcXXIXvttGBWzr8Tlp8P	8883	Almonds	Pastries	5	5.59	2025-10-12 23:59:04	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.delacruz	2025-10-12 23:59:04
32aef60f-fa59-42b4-a851-d04439a57635	RTCYmiubc3RC6BpYytYL	8885	Espresso	Pastries	4	195.76	2025-11-06 21:10:10	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.santos6	2025-11-06 21:10:10
886bbc49-9015-40f3-96fb-9c668eede01e	m8I097QvyjXlQILJzZwI	8888	Tiramisu	Pastries	2	196.55	2024-12-19 08:40:21	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	isabella.delacruz4	2024-12-19 08:40:21
74c2a5c0-b64c-4c47-92c0-3da6e050d568	6yqPUp7oDw3V9whOYIXl	8891	Chai Latte	Pastries	4	100.50	2025-03-02 17:25:37	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	gabriela.mendoza	2025-03-02 17:25:37
bb8eed6d-a16f-4cc0-af05-32d82256506c	lKgeuH0d9t2oVSWo4Kwa	8892	Flat White	Pastries	3	113.21	2025-05-23 03:55:09	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905617233	antonio.santos6	2025-05-23 03:55:09
6c7dce65-8c28-42ec-8df6-26c723baf30e	v7BSNBpr7MlQ1hj3SSRn	8893	Tea	Beverages	4	106.18	2025-08-31 03:55:44	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	gabriela.mendoza	2025-08-31 03:55:44
9c423833-0ebd-4aed-91cf-d2af86d4bc07	2P5n9d9cP7Z0CC3dcgD5	8895	Hot Chocolate	Pastries	2	131.53	2025-03-16 16:56:58	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	sofia.bautista5	2025-03-16 16:56:58
1181cab8-1cc1-4238-b199-6c38453895bc	mYBIajRKMFVK2UNX1AW8	8896	Iced Coffee	Beverages	2	107.80	2025-02-13 11:21:27	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.cruz12	2025-02-13 11:21:27
a6f20aac-25bb-4d28-81c1-870aa0bdf446	76cxE1ysJhwyT6rmudLX	8897	Macchiato	Pastries	2	93.97	2025-07-22 02:17:15	21aaf26a-f4eb-47fe-857f-6050044e5a51	Card	\N	rosa.cruz13	2025-07-22 02:17:15
8bf78a25-adb3-4bf9-a802-8b2dc93a1605	TCP406qgRhjDDXpZmv5W	8898	Almonds	Pastries	1	5.59	2025-10-15 12:02:32	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183905144796	elena.torres2	2025-10-15 12:02:32
f689ff95-968e-4fc3-856c-75add6cef09d	R3n8QNWy6SFaNcMgcY1m	8901	Tea	Beverages	2	106.18	2025-09-10 10:15:22	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905532709	carmen.santos1	2025-09-10 10:15:22
e05a7da0-118d-4c6e-b5d2-b9069ef51679	R3Cyrwzxo4UeJtDXogj9	8903	Chai Latte	Pastries	4	100.50	2025-02-26 15:01:42	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905108632	antonio.delacruz10	2025-02-26 15:01:42
a5fab692-3760-407c-a850-635b52bea9d9	B8hL0N5kymzL4IbovPhy	8905	Almond Croissant	Pastries	5	8.42	2025-10-02 22:15:29	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	sofia.reyes9	2025-10-02 22:15:29
e48f420c-bbda-4114-8445-27ea4235f5f3	m2niXTdgIlLuTvY2R36w	8906	Blueberry Muffin	Pastries	2	185.15	2025-11-15 14:56:00	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905144340	sofia.bautista5	2025-11-15 14:56:00
c514d79f-e648-41b4-8ca9-b76fba32f2d5	ZNxB3UpsihpYIpps6LzD	8907	Eclair	Pastries	5	146.12	2025-03-24 14:14:33	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	miguel.cruz15	2025-03-24 14:14:33
34049b17-4a5e-4932-b684-0ddf2323cfd5	Zbz7rZORyihY5DcVCEf7	8908	Iced Coffee	Beverages	5	107.80	2024-11-29 01:45:31	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	rosa.cruz13	2024-11-29 01:45:31
d80fe881-d3ea-4eca-bfe2-0e5088b35fdc	IHVXqshkuwXLlK9vOXdJ	8913	Espresso	Pastries	4	195.76	2025-03-17 00:16:18	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905096668	sofia.reyes9	2025-03-17 00:16:18
fa83fb67-2f79-4f60-a253-242033abd888	bvZhDrDxXq1l5XXcERoc	8914	Tiramisu	Pastries	1	196.55	2025-08-09 17:05:33	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.delacruz	2025-08-09 17:05:33
fa484e59-a984-4420-89a7-a71ccec18847	lSx0sTOBCE7M1IBhex3m	8920	Latte	Pastries	3	108.74	2025-08-18 04:54:27	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.santos8	2025-08-18 04:54:27
50c0f32b-6e13-48e1-9b0b-ee343cf9192b	1WmAsAGre6gdKk6vxKH8	8921	Almond Croissant	Pastries	4	8.42	2025-04-12 09:44:56	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905102106	antonio.santos6	2025-04-12 09:44:56
ef338d33-ea04-4694-9273-a7d02e140feb	aUBLe2z5CpPWHr0nmD94	8923	Latte	Pastries	1	108.74	2025-03-09 05:24:39	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	antonio.santos6	2025-03-09 05:24:39
832971bc-34b0-4669-98ed-13aea40e2a69	Q8wXENaWs9TmU0NGvFln	8925	Baguette	Pastries	2	133.77	2025-09-24 22:17:12	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905340148	carlos.mendoza	2025-09-24 22:17:12
bf70547b-8d9c-4a81-8f6f-f517e1a8cdf2	u1ZSVYW1Z2Pbo97k2K0f	8928	Apple Turnover	Pastries	5	154.54	2025-01-19 04:11:00	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905335620	carlos.delacruz	2025-01-19 04:11:00
bdb371da-141e-4838-9cb0-1521fdc91fa9	f42CpY44NAYRlEglPoSH	8931	Macchiato	Pastries	3	93.97	2025-07-28 11:16:27	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	sofia.bautista5	2025-07-28 11:16:27
194b445d-ca45-4dd0-bf39-fef4f6ff4b96	nh5C20H3VT5xSHhaV50f	8932	Chocolate Chip Muffin	Pastries	4	103.79	2025-07-10 00:25:39	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.rivera7	2025-07-10 00:25:39
5e215182-2edc-4aa5-8e44-c214da9b66b5	tSDMdXS9YlqaLx19A2jE	8933	Iced Coffee	Beverages	1	107.80	2025-10-05 03:03:31	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905605003	sofia.bautista5	2025-10-05 03:03:31
e1b98f49-813e-4e77-a4a2-d076c9576f13	goTeM6YyUDH4JpHMcRZL	8935	Almond Croissant	Pastries	1	8.42	2025-06-29 21:42:18	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	rosa.cruz13	2025-06-29 21:42:18
7409123f-d2cb-41fa-9d0c-eeb9ffe7309b	Llo772gHvrXYCpIxGcpD	8938	Tiramisu	Pastries	5	196.55	2025-04-29 22:30:06	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	fernando.cruz	2025-04-29 22:30:06
38e9fe96-08f1-4c1c-8d53-5ea4756ec99f	ATfLlKiD4egEzuCtmv5R	8939	Blueberry Muffin	Pastries	4	185.15	2024-12-10 05:52:36	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	carlos.delacruz	2024-12-10 05:52:36
2c7a601d-5e99-4ebc-86af-32778a22a5d7	V5ZWUkGp6ajHp81CK6Cz	8942	Blueberry Muffin	Pastries	3	185.15	2025-10-16 14:52:53	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	fernando.santos8	2025-10-16 14:52:53
57d335a7-5ef1-4bc1-bd4e-91e1f1b9f5ef	hg64YkiCGGZMGI4v0I6G	8955	Cappuccino	Pastries	2	76.25	2025-09-29 01:55:46	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.cruz	2025-09-29 01:55:46
145a5381-7015-4573-b388-3914064c276d	xe8Dym2RKHh5gHWHU4Ze	8961	Cappuccino	Pastries	5	76.25	2025-08-27 10:10:34	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905354576	miguel.cruz15	2025-08-27 10:10:34
29fc4400-a428-4fd6-8e16-addd4d29bc67	sBlbrtoP0NaY9o5XUUV0	8965	Espresso	Pastries	1	195.76	2024-12-20 22:42:44	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	sofia.reyes9	2024-12-20 22:42:44
5af7d1db-ee33-440a-97cf-25bbe780b120	QvNkAxyaipux2UfWCiVA	8970	Blueberry Muffin	Pastries	2	185.15	2025-08-01 14:07:20	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.delacruz10	2025-08-01 14:07:20
2a42285f-7af6-48bf-81aa-4b60c8832c51	bvevfTEyJWcn96F2YEtj	8972	Latte	Pastries	5	108.74	2025-09-01 02:27:52	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905598456	sofia.reyes9	2025-09-01 02:27:52
e63e51a9-e74f-4f39-afe1-9fa706fc0c74	TK45ufrfWf1lNS9iCDRP	8973	Tiramisu	Pastries	4	196.55	2025-05-19 06:22:33	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	miguel.cruz15	2025-05-19 06:22:33
d9a20f0a-daad-4555-b2d0-99ead83fb289	VWgh99IcFaYeXVsIUHOn	8976	Iced Mocha	Pastries	5	144.00	2025-01-10 03:47:48	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905550210	elena.fernandez11	2025-01-10 03:47:48
05104112-544f-47d6-afb8-869bfdbd2fca	f63E1NXuggKqO0rNyERC	8977	Almond Croissant	Pastries	1	8.42	2025-09-14 17:34:29	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	miguel.cruz15	2025-09-14 17:34:29
8239a239-56f5-48a5-b4a1-70b78b109032	88XJL3GQ5Avn6Fvth1u3	8978	Espresso	Pastries	3	195.76	2025-01-04 20:00:01	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183905891206	rosa.rivera7	2025-01-04 20:00:01
707d783b-367e-4c4c-981a-20b06cf98cdc	DDacS3bDWqcah5IqyJEO	8985	Chai Latte	Pastries	5	100.50	2025-06-15 20:18:07	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183905709722	carmen.santos1	2025-06-15 20:18:07
01d82836-c057-42e6-8de6-88929871b10f	13wlYwzZYDECdn263BHb	8987	Latte	Pastries	3	108.74	2025-10-10 12:19:41	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.rivera7	2025-10-10 12:19:41
5726e917-b91d-4b61-9b23-ca7c60bfaf1f	a1YfclNITEj3DgGcYLkt	8990	Hot Chocolate	Pastries	2	131.53	2025-11-18 23:08:24	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	antonio.delacruz10	2025-11-18 23:08:24
ba152314-bbad-41f3-bf51-4198dad51930	CWUN51naQOqxJ0G3SBxT	8991	Iced Coffee	Beverages	4	107.80	2025-03-02 23:19:58	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183905187723	carlos.cruz12	2025-03-02 23:19:58
73d6a1ad-752b-46cb-9142-47a204cb6f0c	q6NN0tK0CnqlkDGeTRXH	8993	Flat White	Pastries	3	113.21	2025-11-12 06:54:10	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183905920436	elena.torres2	2025-11-12 06:54:10
d7bdd2ee-f4eb-43f8-b0d6-2e2c12b19bc2	XsjFarsWi37a9fLkNwQl	8998	Iced Coffee	Beverages	5	107.80	2025-01-26 12:33:32	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.delacruz	2025-01-26 12:33:32
caa1f849-4e6c-48af-b1ee-6660bb39f788	525UFBLAuXEn5jKfZ0td	9002	Cappuccino	Pastries	2	76.25	2025-09-29 06:50:30	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.delacruz	2025-09-29 06:50:30
0a621d2e-ce62-4c95-8475-36ed4f106828	hxKEZUVBlJw49b2Y8YO6	9005	Almond Croissant	Pastries	5	8.42	2025-09-30 22:06:45	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.cruz	2025-09-30 22:06:45
255df4d5-7164-4a5c-abb0-845fb414ef01	Mon9MbUbr9NblYRwydJG	9007	Baguette	Pastries	1	133.77	2025-11-24 14:26:17	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183905840163	carmen.santos1	2025-11-24 14:26:17
7871dc1d-997c-496f-98eb-d6853fbbcb7f	fT8YWDa7NLSWtqY7I9qS	9009	Macchiato	Pastries	2	93.97	2025-08-15 15:01:27	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905174088	antonio.santos6	2025-08-15 15:01:27
39a70e7f-4000-49d2-b6b4-769b8bf126c5	Crb5zRSnNmBKxlKlccNS	9011	Iced Coffee	Beverages	3	107.80	2024-12-26 07:16:03	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	ana.rivera3	2024-12-26 07:16:03
d94fcd44-3145-4327-90eb-ddb52e455e96	E5l8pZxyJR8W77rMI3Zq	9013	Latte	Pastries	5	108.74	2025-11-13 06:06:59	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	sofia.reyes9	2025-11-13 06:06:59
d07f5389-82b6-4469-be07-57c57f9d1259	uEnbE6noi2y7k4DoBA0Q	9019	Mocha	Pastries	4	61.74	2025-10-10 16:24:18	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	gabriela.mendoza	2025-10-10 16:24:18
197c523c-1e8a-4db6-b9b7-278f7a46eb09	RslEKTUY7AokzTSemM3e	9021	Iced Mocha	Pastries	2	144.00	2025-05-04 04:08:54	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905384657	rosa.rivera7	2025-05-04 04:08:54
3d0983b4-e7b5-4bda-b7d7-f10c57ad7313	INcxvRLMd3qhpS3spf20	9024	Latte	Pastries	2	108.74	2025-07-31 21:35:24	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	rosa.cruz13	2025-07-31 21:35:24
09023904-b843-442b-a3a8-f174f61bce72	c1XIeiKlMlEOxvQmybyJ	9027	Glazed Donut	Pastries	3	148.75	2025-03-02 22:44:27	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.cruz12	2025-03-02 22:44:27
8e99c643-96d4-4da2-bb22-4eb6844d713c	xzG2PYNzIbnR51UXxeu2	9033	Tea	Beverages	2	106.18	2025-08-03 02:16:29	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	rosa.rivera7	2025-08-03 02:16:29
8c0c2d6d-0628-4e9b-b516-1146290c1d67	4SV4qM5dXcza0Ya7DL0e	9035	Apple Turnover	Pastries	3	154.54	2024-12-14 17:03:10	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183905729747	pedro.cruz14	2024-12-14 17:03:10
6a12026f-712e-433e-a6eb-781a7cbb2842	zEtESiW9F4XsJFN2xfhb	9036	Cappuccino	Pastries	3	76.25	2025-09-06 05:05:15	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.santos6	2025-09-06 05:05:15
b24e644c-7beb-4b81-8e9a-30b9c97948c7	rqf6y9WsUB9Se2wphWvB	9037	Blueberry Muffin	Pastries	1	185.15	2025-09-01 00:49:28	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	gabriela.mendoza	2025-09-01 00:49:28
9f8d6f6a-d1fe-4807-8a96-bb03ddb5a307	KawBtoC3OtkPTlpwxsh1	9038	Almond Croissant	Pastries	3	8.42	2025-06-09 02:48:21	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	rosa.rivera7	2025-06-09 02:48:21
0e89b522-7dd2-44fe-a8eb-fec13fb369ef	l7knzrhhh4RFjLoDuGPV	9039	Tea	Beverages	5	106.18	2025-10-03 17:39:02	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	pedro.cruz14	2025-10-03 17:39:02
3d1bea6a-4c56-4d5c-b2e9-cab1880cb619	n0B3LUjw65ISNLwlw6B8	9040	Glazed Donut	Pastries	1	148.75	2025-10-26 15:49:22	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	ana.rivera3	2025-10-26 15:49:22
9783f8ae-912e-4965-b851-39481868f4cf	nBL7WSQ33gChryGl6Vj8	9042	Almonds	Pastries	4	5.59	2025-05-26 18:28:16	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	miguel.cruz15	2025-05-26 18:28:16
d181e1b3-f90b-454b-886d-e509a6a50e99	zXaCt6c6HSmXAZP2NJ0G	9048	Baguette	Pastries	1	133.77	2025-06-29 05:05:59	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	miguel.cruz15	2025-06-29 05:05:59
fb091e6f-1272-431c-823a-3c85c4e4e47a	rwj4vHbzTPCL876TfGVa	9050	Glazed Donut	Pastries	1	148.75	2025-08-13 08:49:29	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	ana.rivera3	2025-08-13 08:49:29
71b33749-72e3-4336-ad99-e1d2705f064f	cbVClQUDJrMznsnOubaN	9057	Hot Chocolate	Pastries	2	131.53	2025-05-10 00:17:16	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905704141	ana.rivera3	2025-05-10 00:17:16
c21d5294-b68a-43ea-b9fd-8287854a981c	nj8HbpMWMmhkVXtg31wX	9059	Latte	Pastries	5	108.74	2025-10-11 06:01:40	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905742359	ana.rivera3	2025-10-11 06:01:40
40f7f03c-9339-4886-afea-9bdf9c4759d8	swGfs0760Js42XXEkPw5	9061	Tea	Beverages	5	106.18	2025-08-16 23:03:02	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.cruz12	2025-08-16 23:03:02
5f21bef9-0381-4670-b01b-383b7cd6e6fa	WoafuMUaAFraPBvLuyjw	9064	Blueberry Muffin	Pastries	4	185.15	2025-09-28 11:51:32	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905843293	gabriela.mendoza	2025-09-28 11:51:32
dd8bd41d-6e33-4a59-a14a-2e9682da2633	DTFw7hsVbSDUjOtbUMre	9065	Chai Latte	Pastries	5	100.50	2025-09-04 13:12:57	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.reyes9	2025-09-04 13:12:57
e3186520-b17e-4462-9367-a6047f6c2aff	Xj0PjZlvfEqJ8nRwliPe	9068	Latte	Pastries	4	108.74	2025-02-08 20:02:03	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183905896486	sofia.bautista5	2025-02-08 20:02:03
15abfbc2-d618-46dc-b0ea-3b9c7e132af4	PRYOgCJMpMbYzmXHTnXM	9073	Americano	Pastries	1	80.96	2024-12-02 19:23:32	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183905374665	gabriela.mendoza	2024-12-02 19:23:32
4e909e5c-ca9a-4394-8694-8b58a695244b	KCIaJxmm3XCpyXlhvGOg	9078	Blueberry Muffin	Pastries	1	185.15	2025-09-05 14:24:26	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183905854582	antonio.delacruz10	2025-09-05 14:24:26
48baebe5-6f35-4330-9ea6-f41d26be50b5	GzmXdAcZofhGRMg8OsBx	9080	Red Velvet Cake	Pastries	3	187.25	2025-06-22 00:24:44	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	sofia.bautista5	2025-06-22 00:24:44
3ddea312-fb35-4249-8f5d-7c790b21b517	8t3otVAwxEmIVx6NtKwQ	9083	Glazed Donut	Pastries	1	148.75	2025-10-16 09:24:29	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	miguel.cruz15	2025-10-16 09:24:29
9080cd04-a756-4f83-81fa-f3b64902b505	ABHt9FICJoHUDol0WCaw	9085	Iced Mocha	Pastries	1	144.00	2025-05-17 16:28:16	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.delacruz	2025-05-17 16:28:16
036cf5bb-173d-4509-b208-fc0609973a9f	yhch2Vs5BurlR2BftkrH	9086	Chocolate Chip Muffin	Pastries	5	103.79	2025-06-10 17:02:11	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183905744391	carmen.santos1	2025-06-10 17:02:11
d6770928-8534-4603-8dbc-dca0e126a536	PZe4PmcgeKVwcnNao3iA	9087	Almonds	Pastries	5	5.59	2025-10-14 20:29:26	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	antonio.delacruz10	2025-10-14 20:29:26
04927f9a-b063-4906-ad03-dc63f227a743	6VdZaWLid3bl0mCcZsIx	9090	Latte	Pastries	3	108.74	2025-08-03 12:18:50	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	elena.torres2	2025-08-03 12:18:50
0bf9456c-82a9-4649-8745-f230b389d8e1	Cs78Nhq3koXZd05uycye	9092	Cappuccino	Pastries	1	76.25	2024-12-04 17:30:53	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183905167689	carlos.mendoza	2024-12-04 17:30:53
5b7f14f3-6415-42a1-a949-4010ff66afd5	lS0LOF1TCgYZfjL0nCfE	9096	Tea	Beverages	2	106.18	2025-11-14 09:53:43	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	antonio.delacruz10	2025-11-14 09:53:43
972f73b4-6bb8-4bff-9023-abe8092cd52c	RjTF00tMbI3Z3oqE7v7N	9097	Almond Croissant	Pastries	2	8.42	2025-01-17 10:26:39	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183905346463	isabella.delacruz4	2025-01-17 10:26:39
ad7a4e7a-b234-48cc-bb8b-a7d36de22fb4	apWkEvpq9Sv326sY7Thh	9099	Cappuccino	Pastries	1	76.25	2025-09-14 17:19:34	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.mendoza	2025-09-14 17:19:34
a7a0331f-8b64-44eb-abe6-e5df47667f5d	weXrhAPLdifkKrY7gA0i	9101	Glazed Donut	Pastries	4	148.75	2025-10-25 12:01:01	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183905662852	fernando.cruz	2025-10-25 12:01:01
39164585-12e0-4b48-a364-cb355d6bdb0c	mI0JExdEqsqe13BKS0L3	9102	Iced Mocha	Pastries	5	144.00	2025-03-13 22:21:04	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905193874	pedro.cruz14	2025-03-13 22:21:04
619d85f2-c45e-42d8-afc8-dcdd836fcaf0	Oa1rrHgUsQ5ejdfZLtYK	9106	Tiramisu	Pastries	4	196.55	2025-05-11 14:25:15	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.santos6	2025-05-11 14:25:15
156160c3-32c4-4743-b0a8-b34929cfd72f	Vqmp9QtrxbSSzKkyen01	9111	Blueberry Muffin	Pastries	4	185.15	2025-07-13 11:46:48	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.santos8	2025-07-13 11:46:48
12b85aec-0552-434e-96e7-c97d358cdfa9	0Fs8DVRb75GI7gsyQCQt	9117	Hot Chocolate	Pastries	5	131.53	2025-01-02 06:12:35	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905221330	rosa.cruz13	2025-01-02 06:12:35
b02544e0-3c08-437f-9c99-1fbbfc1e4107	Ru2i4ZnqQPy9jPFCv4RA	9120	Macchiato	Pastries	4	93.97	2025-10-05 19:51:42	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905270639	antonio.santos6	2025-10-05 19:51:42
e496d28e-e646-4d6e-b4c3-3b789f3a1de8	YmDFhJJuZFA7PUhbWYWB	9123	Espresso	Pastries	3	195.76	2025-07-27 23:26:09	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	elena.fernandez11	2025-07-27 23:26:09
06683692-d554-4943-bb9d-0a3f129fc664	dqu0kXNm8nXkXhS7XXRJ	9125	Iced Mocha	Pastries	5	144.00	2025-03-09 00:01:08	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183905293042	sofia.bautista5	2025-03-09 00:01:08
7692a59f-e056-4430-bd1d-e12d757826c7	jBw6t9pChwqyHnlPdyrq	9131	Latte	Pastries	2	108.74	2025-02-17 10:19:07	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.delacruz	2025-02-17 10:19:07
133ed161-708b-4898-9817-de98699bbbd6	JE7KPlOaMwPzzff4lc5C	9141	Almond Croissant	Pastries	5	8.42	2025-04-17 19:03:46	19cc259c-1551-4177-b5ac-a513d5575c9b	Card	\N	pedro.cruz14	2025-04-17 19:03:46
935439c2-d5c2-4014-9484-dc20eea1b54d	1Ti8EufP5RYU0F5pYkZV	9142	Tea	Beverages	5	106.18	2025-09-09 11:14:50	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	fernando.cruz	2025-09-09 11:14:50
2d5428f7-4637-4c0e-8c45-739a7c2cfa77	XlMK9bBpB9OI1CXT1RfK	9143	Eclair	Pastries	2	146.12	2025-09-15 22:02:05	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.santos6	2025-09-15 22:02:05
9f1d4843-a4de-4e83-bdf9-25d60ebd5d5c	79OQLDeC04rv19w62Jyp	9146	Almonds	Pastries	1	5.59	2024-11-28 08:08:10	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	gabriela.mendoza	2024-11-28 08:08:10
6797380d-da28-444f-bb25-134df9cfdae6	eubPzRPQCQt1VNERe5Gt	9151	Tea	Beverages	4	106.18	2024-12-28 12:46:46	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183905326185	carmen.santos1	2024-12-28 12:46:46
a10f4998-ccb6-49a6-9df0-2b5d39750b57	kQz1wu1TvNtqr6iaEh28	9153	Hot Chocolate	Pastries	5	131.53	2024-12-26 15:28:49	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183905773504	fernando.cruz	2024-12-26 15:28:49
baf008fa-7823-480b-af27-d74cf1ec6cde	vi4t645fsP5vjFN07Wn0	9154	Glazed Donut	Pastries	3	148.75	2025-01-29 23:43:46	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	gabriela.mendoza	2025-01-29 23:43:46
cf5e4490-8093-4080-a1d3-8609fffadf7a	QmH6be8pm1aM7xA1bC3z	9157	Iced Mocha	Pastries	3	144.00	2025-10-01 13:16:24	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	miguel.cruz15	2025-10-01 13:16:24
1ba0d6cf-b93e-4134-a18f-04236b420e2f	y0PzuRuGaWqANmwT2vDM	9158	Blueberry Muffin	Pastries	4	185.15	2025-11-01 03:16:23	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	carlos.cruz12	2025-11-01 03:16:23
a8ab2fdf-691a-4886-bc18-039c7cecda73	rtPpCmXxkut16IyzOCBq	9160	Red Velvet Cake	Pastries	5	187.25	2025-04-22 22:00:21	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.delacruz	2025-04-22 22:00:21
1530b4a4-62dc-49a9-93e6-f3bb78332a94	YZXJ6w91Fhb4Wj1tcA7l	9161	Almond Croissant	Pastries	3	8.42	2025-02-16 12:25:15	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carlos.mendoza	2025-02-16 12:25:15
f0941c54-ac75-454b-be95-4a8a68642b50	L5IphKVOhISv27OByA2f	9162	Almond Croissant	Pastries	2	8.42	2025-05-29 08:07:49	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	fernando.santos8	2025-05-29 08:07:49
bfa357a9-556a-4db8-9cec-9dc439927701	SgJNbMub378zNpwmXsM8	9168	Glazed Donut	Pastries	5	148.75	2025-01-02 15:21:57	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	antonio.delacruz10	2025-01-02 15:21:57
18876b55-006a-4231-bb3f-b649f91a4bf6	I13NcosdlCaLubA9yhDd	9176	Iced Coffee	Beverages	5	107.80	2025-07-30 14:50:57	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carmen.santos1	2025-07-30 14:50:57
7d41b14b-2d5d-419a-9f89-082a75d6cbc4	RCbOW9hWK4HqJUScBQcE	9177	Flat White	Pastries	3	113.21	2025-06-08 03:08:14	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	carmen.santos1	2025-06-08 03:08:14
7dac76b3-a09c-4159-b3a9-9cee5e8e2da4	37pfnXdB9cLA2ss7VaYW	9181	Red Velvet Cake	Pastries	5	187.25	2025-07-05 07:17:57	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183905012273	carlos.delacruz	2025-07-05 07:17:57
2f8b1186-ed0e-4a70-b915-229f623d0b49	EPAdnsm0LSvDZ0pW7L4m	9185	Eclair	Pastries	5	146.12	2025-07-07 00:16:24	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183905722369	carlos.delacruz	2025-07-07 00:16:24
8bcdefe8-5647-4631-b587-4e61a410d5e8	V2Q8rXZwClD8iV0HNQNy	9189	Macchiato	Pastries	5	93.97	2025-02-10 08:33:43	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183905373700	elena.fernandez11	2025-02-10 08:33:43
011df6dd-71fe-43fa-a621-bac38dc85668	0BrfuEuM0dKcR1oTMpyC	9194	Macchiato	Pastries	2	93.97	2025-02-10 07:15:20	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	isabella.delacruz4	2025-02-10 07:15:20
bb1be916-c472-4e09-ac45-76c0b28aaebd	5IUSySZxLMfK4PGtVu8w	9195	Hot Chocolate	Pastries	1	131.53	2025-07-31 06:24:14	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carlos.cruz12	2025-07-31 06:24:14
441ec3c2-8bd8-4cb7-be39-c949979e4efe	ZpV7vKOb2Ls9krtNz8ee	9200	Blueberry Muffin	Pastries	4	185.15	2025-04-23 18:19:01	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	antonio.delacruz10	2025-04-23 18:19:01
7f80b06d-2208-40a9-a0df-38940371e57a	syIL9SSkeDhXhscIRCac	9201	Eclair	Pastries	3	146.12	2025-01-26 10:14:53	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183906600410	antonio.delacruz10	2025-01-26 10:14:53
7752e6b5-1db7-4edf-9b8a-b8966c74c5f2	kTChO1PYY0vl0NbEKrMs	9204	Americano	Pastries	2	80.96	2025-11-05 00:59:07	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.cruz13	2025-11-05 00:59:07
a8b9b3a8-fc05-44d9-8827-6f090e3d854e	YwUrCPhP9jhwfTrlSv3M	9205	Glazed Donut	Pastries	1	148.75	2025-02-17 15:54:18	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	elena.fernandez11	2025-02-17 15:54:18
2ffbc649-8c5d-47a7-a038-b261a752790a	9EYqTZKFUsko9Geiqma9	9206	Blueberry Muffin	Pastries	5	185.15	2025-10-31 11:43:52	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.santos8	2025-10-31 11:43:52
19e00dd8-1574-4dd8-bdc8-05a2913bd206	p16W6fv6GgKClhcup2Cx	9212	Iced Coffee	Beverages	4	107.80	2025-09-16 19:35:01	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183906317570	fernando.santos8	2025-09-16 19:35:01
b1206e4d-6680-47c3-a23b-d961d77d8c34	F51m4SLVQYhatOFMyanl	9213	Latte	Pastries	5	108.74	2025-09-29 03:14:39	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	fernando.santos8	2025-09-29 03:14:39
2a2faf0d-b8fc-4089-b861-b8cd71ca77a5	xNFl3rUNwmwJaUsferwU	9219	Iced Mocha	Pastries	2	144.00	2025-01-30 20:21:18	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	pedro.cruz14	2025-01-30 20:21:18
a7f500c8-5fc6-4cd6-aab5-baa4fee3a640	HpVfqrmtP55yrJUsZqvF	9220	Cappuccino	Pastries	4	76.25	2025-03-19 01:22:06	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	antonio.delacruz10	2025-03-19 01:22:06
f77921b6-0844-49ed-b889-cf4191034db7	dbmWvUN8xhSllo4nS5OZ	9231	Iced Coffee	Beverages	5	107.80	2025-08-19 12:02:05	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183906907716	elena.fernandez11	2025-08-19 12:02:05
f70d5c5f-59fa-468f-b2ca-5768f5e87ce7	c0x5zv7Po1RblFZ6XjNI	9232	Americano	Pastries	5	80.96	2025-08-11 17:22:52	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	elena.torres2	2025-08-11 17:22:52
d7cc74b7-00cc-4cf1-bcb9-81252a090806	8mVieZ8CwZVckp6KP5jh	9234	Mocha	Pastries	4	61.74	2025-01-30 06:01:56	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carlos.cruz12	2025-01-30 06:01:56
2cce1d63-317a-462e-86f3-85da7b8c4394	Dzap1eg7vm4Prs5T5hsC	9239	Mocha	Pastries	1	61.74	2025-09-15 12:36:48	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183906492868	sofia.bautista5	2025-09-15 12:36:48
e60c9bd1-c048-4927-be07-7aa891f2fca9	LACs3OdYcfqS7hRdx55O	9241	Americano	Pastries	4	80.96	2025-03-05 10:07:12	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	gabriela.mendoza	2025-03-05 10:07:12
63d723c5-d306-4806-b07b-01c4592b156f	UMog4Fi5UHE8Ta1IaOqe	9242	Iced Coffee	Beverages	4	107.80	2024-12-03 06:17:56	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	ana.rivera3	2024-12-03 06:17:56
749840bf-8dfb-4522-a047-855627b0a634	AkTaCOuSVAQj5aNCbIFn	9244	Apple Turnover	Pastries	3	154.54	2025-09-27 10:26:25	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.fernandez11	2025-09-27 10:26:25
25bcc096-6f5e-4950-b7b6-dff6d26364fc	qarkQDkKpycnn48FkT7d	9248	Macchiato	Pastries	3	93.97	2025-01-05 20:25:27	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	antonio.delacruz10	2025-01-05 20:25:27
c4e59a8b-7a2b-44c3-b1b4-cbff1e939acd	ISWIgTN64IDasYLOrTnr	9250	Tiramisu	Pastries	2	196.55	2025-06-17 22:44:13	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.delacruz10	2025-06-17 22:44:13
db06a23b-6504-419d-94cd-9edf5c162243	nkzV7RuZAEFUFicC0ro4	9253	Mocha	Pastries	3	61.74	2025-02-09 21:47:42	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	fernando.santos8	2025-02-09 21:47:42
e61e9029-252f-4c3b-8d61-b10ac0b936bf	zm6IEuiknhobzjRBz7v2	9256	Apple Turnover	Pastries	1	154.54	2025-03-02 11:35:26	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	fernando.cruz	2025-03-02 11:35:26
b636c39c-3196-475f-9175-ac7a9583a77c	JYR8nPgGUnSIxHJJerfe	9257	Blueberry Muffin	Pastries	5	185.15	2025-03-18 11:06:53	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183906831726	carlos.mendoza	2025-03-18 11:06:53
17327728-bcff-4809-a9f2-e9e43f269d34	V2PoGpg13X3SWQmJcwTl	9266	Glazed Donut	Pastries	3	148.75	2025-06-17 05:12:01	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.cruz12	2025-06-17 05:12:01
3005eba7-9a51-43bb-bba1-aedc01412bbb	S07MEnfj4ufVXk2U1Ls3	9268	Almonds	Pastries	1	5.59	2025-02-28 11:24:33	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	pedro.cruz14	2025-02-28 11:24:33
7d08b29c-3804-4695-9488-46d0f7b5afa7	aCGscShkHSYC0lSONRq5	9269	Chocolate Chip Muffin	Pastries	1	103.79	2025-06-28 02:58:11	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	carlos.delacruz	2025-06-28 02:58:11
164e70dd-73c5-41b2-9096-0327e4ead834	2vvrFe4JmuwbkUDgmRDW	9272	Blueberry Muffin	Pastries	5	185.15	2025-08-19 06:49:54	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	fernando.cruz	2025-08-19 06:49:54
2cfdc254-1576-48d7-b6b2-89964107b7ff	CJk1xsCb348WlHYgUMzH	9284	Almond Croissant	Pastries	5	8.42	2025-09-12 19:37:04	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183906167322	fernando.santos8	2025-09-12 19:37:04
bbc61413-3b34-48e0-8e8d-ae22afb3bfbc	MvZ7ywO6VNu6R2jhLq5L	9285	Cappuccino	Pastries	1	76.25	2025-07-03 05:02:35	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183906457432	ana.rivera3	2025-07-03 05:02:35
d14f0d7f-3acb-430a-9910-8e2acb6e3474	cmu0sdp3IIUjUVRwxuAZ	9291	Cappuccino	Pastries	3	76.25	2025-04-04 00:17:07	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	fernando.cruz	2025-04-04 00:17:07
d1b49948-3eac-4ab3-a8cf-4639240a7715	dyG3LO9e4xuLaxIw0BQ0	9293	Chai Latte	Pastries	1	100.50	2025-04-09 08:05:08	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	isabella.delacruz4	2025-04-09 08:05:08
1db71e4d-88e0-4940-824c-fe290a942f05	RyLl602tK2wweEoypj7F	9296	Eclair	Pastries	3	146.12	2025-03-19 05:42:16	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	rosa.cruz13	2025-03-19 05:42:16
2761781f-7d9c-421e-95a4-00c6623e3340	SHgVej5Z4hI67kIiRBCk	9298	Americano	Pastries	1	80.96	2025-01-31 19:54:23	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	ana.rivera3	2025-01-31 19:54:23
3258049a-a033-469e-8c15-94eeb3ac06c4	i6MPqTmrUr29RnT9moZk	9299	Almond Croissant	Pastries	4	8.42	2025-08-02 08:43:49	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	isabella.delacruz4	2025-08-02 08:43:49
78230425-1674-4c46-b75f-73c28d3f08a0	01t2YiigDSjckMQ0b4CH	9301	Chocolate Chip Muffin	Pastries	1	103.79	2025-02-25 08:24:14	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.cruz13	2025-02-25 08:24:14
288e4fc0-2759-4b7e-aa6c-a5bccf4ffe86	Ue8Y5yOVIwYye2KX93PG	9302	Blueberry Muffin	Pastries	3	185.15	2025-04-03 21:10:42	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	elena.torres2	2025-04-03 21:10:42
57f72bca-1963-4e3a-a035-c9af7c7950c5	DgdipBOoLxzw2WfDIniY	9305	Tiramisu	Pastries	2	196.55	2025-09-09 05:45:58	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.delacruz	2025-09-09 05:45:58
0eb7827a-ba45-414c-882b-034a2362117c	YKhWTmJUIn49kmFCQpix	9306	Red Velvet Cake	Pastries	4	187.25	2025-01-25 00:40:23	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	carlos.mendoza	2025-01-25 00:40:23
df95c80e-339e-4c1d-af66-162fe51d4b98	jFS9ut2sGeHr7LBv7BrH	9307	Eclair	Pastries	2	146.12	2025-06-25 23:55:19	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carlos.mendoza	2025-06-25 23:55:19
7123ea32-728b-45fb-9e43-f75eda684e72	iRjAZ8t4YDfxDBhYxmTB	9309	Almond Croissant	Pastries	1	8.42	2025-09-19 02:56:58	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183906468725	carlos.delacruz	2025-09-19 02:56:58
9073dbd0-cb84-4b46-b5da-02031f6878de	yHYzKaFBlPFzBeTmzBQC	9314	Latte	Pastries	3	108.74	2024-12-23 20:38:43	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183906104801	fernando.cruz	2024-12-23 20:38:43
3b73cf92-35e7-4b7d-ad5b-8f235b0af822	apzR3WqIJPfrEAVt9G5s	9318	Apple Turnover	Pastries	4	154.54	2025-10-01 13:55:29	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183906631094	sofia.bautista5	2025-10-01 13:55:29
996d575d-ae39-430d-b00b-c610302be00c	wmrlmR68hsNtJlEMQxS7	9324	Americano	Pastries	1	80.96	2024-11-24 18:24:27	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	elena.fernandez11	2024-11-24 18:24:27
34f51028-efda-4ca3-85ca-303623baf2a4	SNqsBuep4FWH1jFyu9sM	9330	Almonds	Pastries	4	5.59	2025-02-07 01:42:24	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183906239821	carlos.delacruz	2025-02-07 01:42:24
bce120aa-95ae-4872-a4c2-c5c91e1905f0	y2cGn4WmjlMgVbnDaylS	9338	Blueberry Muffin	Pastries	3	185.15	2025-03-08 13:11:51	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183906380877	admin	2025-03-08 13:11:51
07420c77-c3ca-43a7-9a9a-3b9a9574eed6	X6QJRKb3dUWtVJf8i3Vv	9339	Mocha	Pastries	3	61.74	2025-01-16 22:36:09	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	miguel.cruz15	2025-01-16 22:36:09
5eeeed0f-3bbc-4908-b9ae-b55c9ed0a6d1	eSfxEsg8G2cQioLgtoln	9341	Baguette	Pastries	3	133.77	2025-07-15 00:19:34	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.torres2	2025-07-15 00:19:34
6b466d01-e8e8-4800-8648-3d8a366ec27d	SCb4DlewepZbzdWn8sP8	9342	Eclair	Pastries	1	146.12	2024-12-19 00:53:57	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183906075802	carlos.delacruz	2024-12-19 00:53:57
fae2ecf7-973b-4935-b42d-6c3214b93d9d	0neTMlfXkyypQLgorZfQ	9343	Tea	Beverages	1	106.18	2025-10-18 02:29:14	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	pedro.cruz14	2025-10-18 02:29:14
da0c6814-1f4a-481f-9fb8-ed8ee1b3962f	VtXnxKTYBHkHXH9Ddxzd	9348	Mocha	Pastries	3	61.74	2025-10-23 22:46:26	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	elena.fernandez11	2025-10-23 22:46:26
dd450929-dc2c-4ca7-aa8d-f6fc579b60d3	4pp0wdrawSZf3JDHoTFq	9356	Chai Latte	Pastries	2	100.50	2025-09-27 03:13:38	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	ana.rivera3	2025-09-27 03:13:38
320c9508-03d0-4bec-b3b8-81a58d72d025	xp6rzAUlzVAgqV83cx4g	9359	Almonds	Pastries	3	5.59	2025-09-13 09:28:24	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	rosa.cruz13	2025-09-13 09:28:24
f0820cbc-a6c4-4ac0-b23c-9b1eb89b48c7	Urt4Qrx2OiyxXXV53G08	9362	Tiramisu	Pastries	4	196.55	2025-04-05 17:31:43	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183906671079	carlos.delacruz	2025-04-05 17:31:43
da588402-8116-40cd-9541-162b0e8214a4	6cstpfOo3LC5qM0AVhiH	9368	Eclair	Pastries	2	146.12	2025-06-19 11:55:11	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183906305285	sofia.bautista5	2025-06-19 11:55:11
315ffd2b-5014-453a-8171-da1b7b742758	jL5kjDi0HBPHmo5AdEZd	9373	Espresso	Pastries	4	195.76	2025-07-13 17:19:46	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	antonio.delacruz10	2025-07-13 17:19:46
7909df74-3f09-4cab-b14c-bcd46c23e54d	14po5PyRnUtrPR9SmN1A	9374	Glazed Donut	Pastries	2	148.75	2025-09-23 09:36:50	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183906899506	miguel.cruz15	2025-09-23 09:36:50
08cc6d44-f970-4ba7-b4ee-10bfd9bdb65a	xSJqf6zEL6XrlnoDg0aT	9375	Apple Turnover	Pastries	2	154.54	2025-10-13 03:19:41	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	carmen.santos1	2025-10-13 03:19:41
0e829f7f-8571-4da2-8416-285af22bb85b	HHl7vNXZtA0vtvos4jP7	9377	Flat White	Pastries	2	113.21	2025-11-03 01:35:30	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183906973298	fernando.santos8	2025-11-03 01:35:30
c5bb4940-f00f-437f-90e1-9c564cfb9846	Sr6avHqiXCzvy2cmZ2c5	9383	Almonds	Pastries	5	5.59	2024-12-29 04:31:25	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	rosa.rivera7	2024-12-29 04:31:25
99e27698-11de-4e45-b30b-343763d9c7bf	KstxbcptyNMZUBNzUCBY	9385	Baguette	Pastries	3	133.77	2024-12-13 18:39:16	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	carlos.cruz12	2024-12-13 18:39:16
dd0e0dbd-f1fd-47c5-a831-7de28048e026	w0JnQ6WypIreCE0blLPW	9389	Glazed Donut	Pastries	3	148.75	2025-09-06 13:52:33	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183906343707	ana.rivera3	2025-09-06 13:52:33
dab682a4-f7f6-454c-9e3b-c9b354560e0d	UfFNdQi4THfDJixSEqbM	9392	Tiramisu	Pastries	2	196.55	2025-11-16 14:03:51	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.torres2	2025-11-16 14:03:51
04139ab1-84a2-41db-afde-280dbc58acd6	dHYMmXgRLCuxelc7dsI6	9393	Tiramisu	Pastries	4	196.55	2025-06-08 14:37:06	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.delacruz10	2025-06-08 14:37:06
22dfa4c5-572f-4c60-a3d3-677d379226a3	FOQxrC5i3huaKnqIcrZt	9395	Almonds	Pastries	4	5.59	2025-07-21 19:40:39	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	gabriela.mendoza	2025-07-21 19:40:39
21e643d5-5022-42ad-b7d1-241acd17eee0	qtxBffpjwCKlcuCtqYX7	9396	Espresso	Pastries	3	195.76	2025-08-25 05:43:35	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	rosa.rivera7	2025-08-25 05:43:35
6ea82a05-5b78-49ef-becc-e681b30bece0	iAw1OC7NN5ESMAtFwMWa	9402	Tea	Beverages	1	106.18	2025-03-21 01:12:53	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.torres2	2025-03-21 01:12:53
33662617-71e6-4b7b-8639-2c4c580120ef	qvzTWTot3J3yE87BJuQh	9404	Iced Mocha	Pastries	1	144.00	2025-08-13 15:44:04	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	carlos.delacruz	2025-08-13 15:44:04
e71594ed-2bdf-41ce-baa1-6b0d32e7e14f	FQJ1xfJsSU1PSNGjqD15	9405	Mocha	Pastries	3	61.74	2024-12-31 05:50:46	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	sofia.bautista5	2024-12-31 05:50:46
b86e01ad-35c2-49ae-b726-594c5867a97f	qlDlHUoSVgoAN9lDXNpU	9406	Tea	Beverages	4	106.18	2025-08-06 01:05:04	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183906119409	carlos.mendoza	2025-08-06 01:05:04
939098e6-8277-49b8-a394-d932356ce64f	S12A4EAgJuz6WXvMfpFu	9409	Red Velvet Cake	Pastries	2	187.25	2025-05-07 07:10:46	22893c15-bd77-4029-b8ca-3bb58becab1f	Card	\N	pedro.cruz14	2025-05-07 07:10:46
5c445112-f3ee-40d4-98b6-da30423c8f5e	ohRFrODsfCr487x6wPQH	9410	Iced Coffee	Beverages	1	107.80	2025-05-31 18:29:04	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.reyes9	2025-05-31 18:29:04
3b88bc30-0893-4037-ac6b-f4c2ae89c3df	fGVJb6tBM6imBhAwKxrY	9412	Espresso	Pastries	3	195.76	2025-08-18 13:00:54	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	fernando.cruz	2025-08-18 13:00:54
b2660710-023f-4f19-8c58-bfd0015e0a9c	cTLVJgvmzWqHlULiRguP	9414	Iced Coffee	Beverages	3	107.80	2025-03-27 19:41:32	bec7fed4-7e88-468a-8552-bfb53bd6b47e	GCash	GCASH20251123183906960949	carlos.cruz12	2025-03-27 19:41:32
c2ddfb10-e268-48f4-99e1-df9a40c19e88	ZjWiP6iAYjNv0xH0IodG	9417	Blueberry Muffin	Pastries	3	185.15	2025-08-15 20:15:43	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.cruz13	2025-08-15 20:15:43
4f3d8d86-9cda-47f7-b2ea-5ac4255b62fb	Nouodys5B3EAxnqIVxHC	9418	Chocolate Chip Muffin	Pastries	2	103.79	2025-02-22 07:16:41	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183906815227	carmen.santos1	2025-02-22 07:16:41
7196e686-3e42-4853-8cb2-d9f488b2f4ac	3Hg4Xy4Hp3DUxiLKvyxo	9419	Baguette	Pastries	3	133.77	2025-04-01 04:59:39	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183906371634	carlos.cruz12	2025-04-01 04:59:39
b840882c-b434-4ae7-8540-54999db2743c	kRG5ErCHg4HYRKPF62jH	9422	Baguette	Pastries	1	133.77	2025-01-11 21:08:16	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	gabriela.mendoza	2025-01-11 21:08:16
ce912ba9-d2ad-4a53-9911-1a391d75c3e7	n7n1iPimxUw0wbCul9PK	9426	Glazed Donut	Pastries	3	148.75	2025-04-12 04:03:44	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183906065234	sofia.bautista5	2025-04-12 04:03:44
9ed4d041-8015-46ce-8c99-fbc12df9d6ec	e8kRIZrLU753k8P1iN96	9428	Iced Mocha	Pastries	3	144.00	2025-03-27 03:48:35	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	admin	2025-03-27 03:48:35
1b4bade6-9828-4cd6-9a66-f7b474341102	K6PivT9ppXUlV2lXwt1X	9429	Tea	Beverages	5	106.18	2025-06-29 20:04:08	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	rosa.cruz13	2025-06-29 20:04:08
4b49ee59-d2d0-47be-8493-00c07add1f1d	EwkPCWz8wDnsUyH8UmyR	9430	Macchiato	Pastries	2	93.97	2024-12-28 19:24:53	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	fernando.santos8	2024-12-28 19:24:53
2f38940f-42cb-4a1d-98b3-a29899298293	GCTT3o1vrvWsGhynXYTQ	9431	Blueberry Muffin	Pastries	2	185.15	2025-07-20 17:40:42	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	pedro.cruz14	2025-07-20 17:40:42
2ee0da02-ed7e-4d9b-a656-31f45436422f	2AWfXKA7qUjLVLjo4Uyb	9435	Blueberry Muffin	Pastries	5	185.15	2025-11-18 20:11:24	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183906016521	ana.rivera3	2025-11-18 20:11:24
c872c426-3eae-41fb-abec-b0c800c9bd55	snXCyocGU2bs3uoKj86a	9442	Cappuccino	Pastries	2	76.25	2025-01-11 10:24:39	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183906046544	antonio.santos6	2025-01-11 10:24:39
5beb132a-1234-4b8b-a023-e389dfdb4833	98Eykq66XB8zFgP6VzU6	9456	Hot Chocolate	Pastries	1	131.53	2025-09-30 23:49:38	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	rosa.cruz13	2025-09-30 23:49:38
2b02563e-c900-4197-a37a-b4669e9b51c4	ehDcXZXX8Vcj4QqFsOLl	9458	Almond Croissant	Pastries	2	8.42	2025-10-21 13:34:31	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	rosa.cruz13	2025-10-21 13:34:31
a0a867bc-6b7a-4a78-9441-8161db1bf351	RiMW2CoowYKEQacNHTDH	9459	Tiramisu	Pastries	1	196.55	2025-07-01 07:40:30	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	antonio.delacruz10	2025-07-01 07:40:30
69292a02-d36e-4bc3-8cc1-ddf59dc6b5f3	zyUUTF8jn3PXWhgIEUcM	9462	Apple Turnover	Pastries	1	154.54	2025-09-18 20:48:13	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	rosa.cruz13	2025-09-18 20:48:13
5204647d-427f-47be-a301-797abd4aa151	WiiSyYVSc6YuoJImWSbH	9466	Cappuccino	Pastries	1	76.25	2025-11-07 07:37:58	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.rivera7	2025-11-07 07:37:58
a238e9f5-4444-4c5e-9dc3-7f4dd63480f2	DPXToc1ymVAluVQjikhs	9469	Glazed Donut	Pastries	3	148.75	2024-12-28 05:39:49	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183906534595	elena.torres2	2024-12-28 05:39:49
c6a7768c-a923-4963-be3b-21655c8fe183	A9BEAtsLQOqZcoFGMyjg	9471	Flat White	Pastries	2	113.21	2025-10-30 09:40:33	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	sofia.reyes9	2025-10-30 09:40:33
50292f70-edad-422e-8fcc-88a0f02cc9d0	YM2zXiZ74NFErduJyFP1	9472	Eclair	Pastries	5	146.12	2024-11-26 18:30:05	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	carmen.santos1	2024-11-26 18:30:05
4fb62d0e-415e-45c0-bb1f-4b89a98792c2	A9Y66Po8H7QPxOLfNcCO	9473	Tiramisu	Pastries	5	196.55	2025-11-14 20:39:01	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183906307418	elena.fernandez11	2025-11-14 20:39:01
7080eaf8-cca2-4caf-a241-f890f7cb828b	SMFAV58JHkEONtMEkGAA	9475	Almond Croissant	Pastries	1	8.42	2025-02-10 02:49:22	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183906439242	fernando.cruz	2025-02-10 02:49:22
cf4f9078-dadf-4156-8410-59f094fa0b14	xzzaDpzayZxHI9odxAF7	9476	Almonds	Pastries	5	5.59	2025-11-13 18:06:53	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183906516351	carlos.delacruz	2025-11-13 18:06:53
c50599d1-03c1-4112-80a1-94e3727d538a	TeNLHZMvUCCkZAYskCYa	9480	Almond Croissant	Pastries	4	8.42	2025-03-07 02:21:36	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	gabriela.mendoza	2025-03-07 02:21:36
f5d40ee6-8240-451f-8dc8-d5fe205b2bc7	B38NznGqWG0pNQMeLOli	9486	Iced Coffee	Beverages	5	107.80	2025-08-25 08:30:05	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	carlos.delacruz	2025-08-25 08:30:05
bfee60a6-4b41-43cd-b20f-facdcd2d4daf	BQi4FSHl1m37swEEotAx	9487	Tiramisu	Pastries	4	196.55	2025-09-02 09:23:06	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	fernando.cruz	2025-09-02 09:23:06
07454aef-0667-4b4b-94c8-c2c48af4880c	eGZzgCIHYC67a6Cf0d8h	9489	Tiramisu	Pastries	5	196.55	2025-05-02 00:18:15	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183906089807	antonio.santos6	2025-05-02 00:18:15
d37e7e40-ebea-49d0-a374-05d1d398abd4	RpK5pahq85aKvrSsSFhS	9490	Eclair	Pastries	5	146.12	2025-01-06 07:22:55	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183906115566	carlos.mendoza	2025-01-06 07:22:55
bca64dac-18f5-414c-b433-e4a516d1f7e9	gMTJ49AC9t0OLPAUJfHp	9492	Chai Latte	Pastries	2	100.50	2025-01-01 18:18:31	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183906738935	elena.fernandez11	2025-01-01 18:18:31
8b73d612-629d-4958-93e7-3e8b51a87ccd	qVUJARaPx0q1eS8FKOdu	9493	Tiramisu	Pastries	3	196.55	2025-02-15 20:10:47	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	miguel.cruz15	2025-02-15 20:10:47
b7dcf499-5f9b-4cd9-ab92-ec78d543cf29	aYa0lcijNYD9BFJYNCYB	9496	Iced Mocha	Pastries	3	144.00	2025-05-22 14:58:25	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	elena.torres2	2025-05-22 14:58:25
13c9dd89-66ad-4d4a-accf-7d5f88d33449	5ia9VzumiMB2pLXLicpF	9498	Chai Latte	Pastries	2	100.50	2025-06-25 09:23:21	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.reyes9	2025-06-25 09:23:21
0254c267-dd69-4dc9-bf31-d1cd7927c92a	XR5XR6WMPgnjqVVVhjrt	9501	Almonds	Pastries	4	5.59	2025-03-31 10:16:35	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	elena.torres2	2025-03-31 10:16:35
8aaa7d01-cfef-40b5-bbd7-59ce4a86c3ad	eXn1kS8dNy4MXFSupCAK	9503	Apple Turnover	Pastries	5	154.54	2025-04-09 15:00:10	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.delacruz10	2025-04-09 15:00:10
7d6b6222-8dc6-484a-8b1f-821729598965	aKAVxiOA2seEr3OvIkMI	9504	Latte	Pastries	3	108.74	2025-03-30 09:32:01	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183906972237	antonio.delacruz10	2025-03-30 09:32:01
7972a5f3-8128-425e-a7a1-51e9fc57bb86	OJLNun8UvB2doJEqmnzE	9508	Eclair	Pastries	1	146.12	2024-11-24 04:49:27	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183906832284	carmen.santos1	2024-11-24 04:49:27
3ac12ce3-35dd-424a-9a85-261485ad5df3	m6aqGZsopN7oJ0UB4dLg	9511	Latte	Pastries	5	108.74	2025-08-23 07:05:16	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Card	\N	miguel.cruz15	2025-08-23 07:05:16
d290c3c1-710e-48f8-b5bc-c0976ef6204b	Sd20QXeYBWzVH8cbJqRz	9514	Cappuccino	Pastries	1	76.25	2025-06-15 19:24:37	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	carlos.delacruz	2025-06-15 19:24:37
41ccb7f1-f2d1-4e2f-be85-ba11ff5369fd	KagGteBUx258SEoNLXQk	9518	Chai Latte	Pastries	5	100.50	2025-03-26 18:22:52	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	sofia.bautista5	2025-03-26 18:22:52
16f790b1-83cc-4cf1-b801-24924b43b31b	Sc5KulrF7rIUWZYXmiCZ	9520	Cappuccino	Pastries	1	76.25	2025-06-25 01:40:41	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183906873020	sofia.reyes9	2025-06-25 01:40:41
a9814a4c-f9b1-403e-a05c-12386480ec90	ljRJJ80ZuKwcbFCwIF7Q	9521	Almond Croissant	Pastries	4	8.42	2025-07-23 13:32:48	19cc259c-1551-4177-b5ac-a513d5575c9b	GCash	GCASH20251123183906454312	carmen.santos1	2025-07-23 13:32:48
216eea54-2f3c-477d-8b66-a07a1d449e27	4DBP7H3RUJR3oxRdcvGr	9524	Glazed Donut	Pastries	4	148.75	2025-10-19 01:41:26	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	elena.torres2	2025-10-19 01:41:26
f7cfb354-382b-4659-918b-5dc0db01fc1d	PmqDTTGjLiWE85F1mIF2	9547	Eclair	Pastries	2	146.12	2025-02-04 18:39:47	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	rosa.rivera7	2025-02-04 18:39:47
3bbbb6d8-b59f-43c5-b9fb-04a65fa98569	AGOBxosJrG5gJg6OfpkH	9549	Latte	Pastries	2	108.74	2025-02-05 13:10:20	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	ana.rivera3	2025-02-05 13:10:20
0c20fc07-0cac-45bf-b79e-756e2addaaa3	GlUbJE1GtrT8jI7Hvu58	9550	Chocolate Chip Muffin	Pastries	5	103.79	2025-09-24 04:26:38	996934ff-5758-44b4-ad0e-4ed9d927901e	GCash	GCASH20251123183906452005	admin	2025-09-24 04:26:38
9bf862a2-6cab-491e-94f4-21547e480125	7GGyh33z8hNNJnb61WlI	9551	Baguette	Pastries	2	133.77	2024-12-24 11:41:17	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	sofia.reyes9	2024-12-24 11:41:17
98681bae-a7d5-44d3-a653-fc04310847cb	BhSvUAaek1jVmh4dPmYd	9554	Tiramisu	Pastries	3	196.55	2025-03-20 20:51:19	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183906110753	elena.fernandez11	2025-03-20 20:51:19
8fd7bba6-f609-46f1-8ca5-d1388c84233e	RJWqveaLIqGACuIYjvhF	9556	Almonds	Pastries	2	5.59	2025-10-12 07:17:17	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183906798921	ana.rivera3	2025-10-12 07:17:17
9cd2c5ee-0816-42aa-ad11-f44325b59615	Qfte2uw3UTWb6O4zigRz	9560	Eclair	Pastries	5	146.12	2025-04-07 14:34:12	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183906031114	fernando.cruz	2025-04-07 14:34:12
ed77f777-51a6-464b-ae72-f7550e134718	H29Wm03dio4lIOWfAQuV	9565	Cappuccino	Pastries	2	76.25	2025-11-15 11:39:19	60701303-6f07-449f-8055-ceb7711b168b	Cash	\N	rosa.rivera7	2025-11-15 11:39:19
8df841e8-60bd-4506-8e91-8e884019031e	1YqwR2Mh1bGPSZJb8pwI	9566	Apple Turnover	Pastries	2	154.54	2025-07-31 10:15:32	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	elena.torres2	2025-07-31 10:15:32
6c215e46-5b36-437b-b32d-66fc05040ac7	0xXOsAWj29ep2PlKIicW	9570	Mocha	Pastries	2	61.74	2025-10-22 23:55:48	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183906256091	carmen.santos1	2025-10-22 23:55:48
11fb65e2-6a09-4b45-abec-8fc4deb3b2a7	GUy5Fy6SWeyOlefYPyoW	9572	Macchiato	Pastries	3	93.97	2025-08-23 03:12:40	21aaf26a-f4eb-47fe-857f-6050044e5a51	GCash	GCASH20251123183906357877	sofia.reyes9	2025-08-23 03:12:40
f040bce2-a220-4544-81a1-978f823d039a	UFvMuxABXtHqIVh1cFgR	9576	Iced Mocha	Pastries	1	144.00	2025-10-16 06:00:27	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183906990017	antonio.santos6	2025-10-16 06:00:27
9970c8f7-d9e9-4b1c-8fb3-97f501ebdb50	QmyKXVMiUrowPf0BHA2C	9585	Chai Latte	Pastries	4	100.50	2025-08-18 19:11:36	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183906984784	miguel.cruz15	2025-08-18 19:11:36
4462d8b2-8f71-4cd1-a19d-d860a04e492e	R3ISy5BH27zeyN8HSCmu	9589	Tiramisu	Pastries	5	196.55	2025-08-10 20:06:45	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	rosa.cruz13	2025-08-10 20:06:45
9b80fec3-819f-4918-8107-5c4c739772c0	G6Ayuu7iuthlbuxMp7WC	9594	Espresso	Pastries	3	195.76	2025-03-13 19:36:53	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	sofia.reyes9	2025-03-13 19:36:53
fb6348fc-7418-405d-8ca4-9028b9ad619e	PRW3gpMDSiOulXpwjepq	9596	Iced Mocha	Pastries	5	144.00	2025-03-28 09:09:39	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	gabriela.mendoza	2025-03-28 09:09:39
6474781e-8215-430f-ba09-715a177837df	EtvUqLcwUxybArT38Jy0	9610	Eclair	Pastries	3	146.12	2025-07-09 22:06:21	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.delacruz10	2025-07-09 22:06:21
b4087bf5-2e66-4d26-aafc-521829f04f0e	OQ4EBACVXcbsVONSnvDf	9612	Chocolate Chip Muffin	Pastries	1	103.79	2025-01-11 05:28:43	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	rosa.cruz13	2025-01-11 05:28:43
2a553100-c030-4b43-ad16-6f76156da636	4m3lDkwOFOyWm04pLLq3	9621	Mocha	Pastries	4	61.74	2025-10-02 06:09:58	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183906806870	pedro.cruz14	2025-10-02 06:09:58
3507b827-6be2-4fd3-b2d0-dbd28e94e92d	N7mRtz5EIPSguYeyFH1N	9624	Flat White	Pastries	3	113.21	2025-08-27 06:14:13	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	fernando.cruz	2025-08-27 06:14:13
5793f508-7a79-4da9-b1ce-623f50555564	e6aWGYGxSLn3tqg1bYRC	9628	Latte	Pastries	5	108.74	2025-11-09 14:16:27	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	GCash	GCASH20251123183906466104	carlos.mendoza	2025-11-09 14:16:27
b5e7cc28-f9cc-4775-a1dc-f990af8d7fb2	ih8uGWqHEfAS1XfrnBmi	9630	Chocolate Chip Muffin	Pastries	1	103.79	2024-12-08 01:45:46	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	fernando.santos8	2024-12-08 01:45:46
d8a15684-d84a-4207-be57-e68e8316a4ba	epIrLSeRkxzLoKEynKtP	9634	Glazed Donut	Pastries	5	148.75	2025-03-28 12:37:43	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	gabriela.mendoza	2025-03-28 12:37:43
bb02698f-abc3-415f-9a5c-64b849917db8	C6R2E7RO6ZM12GsWwBKE	9635	Flat White	Pastries	1	113.21	2025-11-07 22:51:54	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183906550656	elena.torres2	2025-11-07 22:51:54
73945912-742a-42fc-8790-a36baa106bac	pxOCQNPzz1ziNmsz92h5	9640	Eclair	Pastries	2	146.12	2024-12-31 10:02:35	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183906192715	antonio.delacruz10	2024-12-31 10:02:35
7ce381c1-b67d-4f69-8f12-429767c66da4	H3sKPAIOrCsIsxIwOWku	9641	Apple Turnover	Pastries	5	154.54	2025-01-29 16:42:08	5be3f24c-3995-4c70-8197-04b96e82fdaa	GCash	GCASH20251123183906529031	antonio.delacruz10	2025-01-29 16:42:08
e2d51570-6dfb-499c-8ec2-4bce762facd7	8YnertinZoIbOL1Ea9ci	9642	Glazed Donut	Pastries	2	148.75	2025-11-18 12:16:07	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183906798690	fernando.cruz	2025-11-18 12:16:07
0b373b1a-ce5d-4c30-a0d3-e2ae425f25d4	ASIXYRT9yMcoJRUnT8dO	9649	Iced Mocha	Pastries	4	144.00	2025-09-22 14:03:43	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	isabella.delacruz4	2025-09-22 14:03:43
ca3574c8-0242-4c59-96f9-b3ce6bb79a74	Xubvxft0Zuc21830VmCf	9651	Glazed Donut	Pastries	5	148.75	2025-06-02 15:51:35	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Cash	\N	carlos.delacruz	2025-06-02 15:51:35
8d103081-4bc0-448c-ab1b-53a3f1d2fc86	hnXHinUGiXIZLdrasTff	9656	Red Velvet Cake	Pastries	2	187.25	2025-02-19 03:42:02	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.fernandez11	2025-02-19 03:42:02
2b52125c-89d7-4091-8080-87a8185c22c0	NnL8sHbUrPIDLhNTanZa	9661	Tiramisu	Pastries	4	196.55	2025-04-27 23:37:00	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	antonio.delacruz10	2025-04-27 23:37:00
9ba210df-6883-48c3-b843-e6febcc1925e	bGQUwayYgwrQFNuiS7EN	9666	Eclair	Pastries	1	146.12	2024-12-11 20:25:07	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183906119050	rosa.cruz13	2024-12-11 20:25:07
c042791d-b464-4c13-a1cf-a29eada988d6	ibF4ZpGIWkNwjsxOjg2J	9674	Blueberry Muffin	Pastries	1	185.15	2025-02-06 13:26:42	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183906555822	elena.torres2	2025-02-06 13:26:42
8c7a7a98-1b2d-4d4b-b74f-ef52050ca524	d9DVDN4tMOqLdiZnmVRd	9683	Macchiato	Pastries	2	93.97	2025-03-27 01:04:36	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	gabriela.mendoza	2025-03-27 01:04:36
b7b5fb8e-726b-4663-96d2-d775aee42e8d	rcaczbX4sWw8fVuFmraH	9692	Iced Mocha	Pastries	3	144.00	2024-12-13 03:38:29	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	gabriela.mendoza	2024-12-13 03:38:29
f9dfa115-c861-4fba-9878-f6e475856e82	oWSy4aG3bpuRx14VMgwU	9694	Flat White	Pastries	4	113.21	2025-02-02 19:53:30	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	GCash	GCASH20251123183906281118	miguel.cruz15	2025-02-02 19:53:30
ce977b70-d427-4b0a-b911-6164420d81c4	mnMqEdck3l6PZhuuczYv	9695	Red Velvet Cake	Pastries	5	187.25	2025-11-21 16:48:05	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183906261847	antonio.delacruz10	2025-11-21 16:48:05
36291ac1-faa0-4272-ae89-85c9c5522b6c	CCpqIHCSCn5DA6dCGkAz	9696	Chocolate Chip Muffin	Pastries	5	103.79	2025-03-06 15:14:45	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	fernando.cruz	2025-03-06 15:14:45
af38536f-a713-41b0-9c55-c43f010a2c0b	LjL3L2hcjxfJJfYZslkh	9702	Latte	Pastries	5	108.74	2025-09-03 16:54:29	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	sofia.reyes9	2025-09-03 16:54:29
15cc2840-3b2c-43b0-baae-90933f873169	TSSuzn5LJycSopl8LuqG	9705	Tea	Beverages	3	106.18	2025-01-13 16:18:29	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	elena.fernandez11	2025-01-13 16:18:29
f2a73a74-441b-4a38-b214-5c0600252000	BtNeWhMBvgnR189vx6bT	9706	Flat White	Pastries	2	113.21	2025-07-28 20:39:45	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Card	\N	fernando.santos8	2025-07-28 20:39:45
05526bf7-428d-4fbe-ab54-0d63bfd2efc5	aElMtOOQy9TCiSH74WQ7	9710	Baguette	Pastries	4	133.77	2025-07-26 04:32:42	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	pedro.cruz14	2025-07-26 04:32:42
847ba8c3-33ae-4ce5-9f50-7f94248bf4eb	dOAeMDtIezCSWgPSuwbS	9711	Chocolate Chip Muffin	Pastries	4	103.79	2025-04-29 19:52:18	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	isabella.delacruz4	2025-04-29 19:52:18
a0b3f8cd-a7a9-4af8-837f-cdddacf1b3dd	tMv6xWyFrh6w1v68S2rm	9714	Tiramisu	Pastries	3	196.55	2024-11-24 02:24:59	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	gabriela.mendoza	2024-11-24 02:24:59
785f2893-966e-4702-9251-6820f88bc32d	UdT9hVcNlkIupbTmI0Pd	9716	Mocha	Pastries	1	61.74	2025-08-03 13:37:16	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Cash	\N	carlos.cruz12	2025-08-03 13:37:16
01f13146-6afe-4eeb-b75e-13dbf3354de3	f0laERgz1n47206nVgTi	9718	Almonds	Pastries	4	5.59	2025-05-29 13:03:01	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	fernando.cruz	2025-05-29 13:03:01
72bd4cbc-f4fb-4505-8188-78476ff27ca0	zGgMZyXR3ZEhi8rLfKqU	9719	Tiramisu	Pastries	5	196.55	2025-01-29 04:25:37	b8fd7179-60d8-4c84-aeef-92abb02a984e	Card	\N	elena.fernandez11	2025-01-29 04:25:37
dfd5aa33-7e67-420a-85f5-e4493b98f6fb	L2UdSVTLaNahz76A28Gb	9722	Espresso	Pastries	2	195.76	2025-02-11 12:01:15	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	pedro.cruz14	2025-02-11 12:01:15
d4f7a27e-b03a-4df4-a6f2-aaf80bbf3374	z7STgx8YnKg0YDmzgFYK	9731	Red Velvet Cake	Pastries	3	187.25	2025-03-29 22:31:08	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	fernando.santos8	2025-03-29 22:31:08
b5fe6bf4-7c2a-4522-9236-266c35248662	s1trqdwayd2TqZ4Co6cH	9733	Red Velvet Cake	Pastries	3	187.25	2025-05-20 15:52:55	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	admin	2025-05-20 15:52:55
e02e1ed0-3f98-4af1-802e-fe1bb9fd434a	4I1WNXl0FxEQ5u1bxQaO	9737	Eclair	Pastries	5	146.12	2025-06-07 11:29:23	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	antonio.santos6	2025-06-07 11:29:23
fa17d907-4064-4cac-91d2-24e1942ff2dd	A0gGViI2znJaRcQhlw6j	9741	Eclair	Pastries	2	146.12	2025-11-23 02:47:47	d822e322-66a9-432e-aca0-2adc5fbb656a	Cash	\N	pedro.cruz14	2025-11-23 02:47:47
18d7e90e-211c-4cf9-9b62-4b0e1608b084	oL8UBsarladAEImJRA4Z	9743	Baguette	Pastries	1	133.77	2025-05-19 12:22:13	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	gabriela.mendoza	2025-05-19 12:22:13
b4d861d6-12e2-474f-b07d-ea2b6fbb9f99	3CRLlCWZ2eUzhwLd7ioh	9744	Baguette	Pastries	5	133.77	2025-11-02 09:07:43	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183906676682	ana.rivera3	2025-11-02 09:07:43
969b2c31-c0a2-44bc-ac9a-1b255ed6d9a8	SsgfAlgQEEKn5rWhTnnq	9745	Cappuccino	Pastries	1	76.25	2025-03-07 11:27:30	60701303-6f07-449f-8055-ceb7711b168b	GCash	GCASH20251123183906479920	antonio.delacruz10	2025-03-07 11:27:30
21a0f23e-0f53-493f-a39b-a0ec1b1e24f7	8vg3DphjVOCyuHJPnMXj	9746	Chai Latte	Pastries	3	100.50	2025-11-11 08:11:55	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	carlos.delacruz	2025-11-11 08:11:55
141bd203-29d7-4fdd-a8a3-dfb244589e81	EUEMQZ63bTIEMxPD16v5	9765	Baguette	Pastries	2	133.77	2025-10-26 20:29:33	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	elena.torres2	2025-10-26 20:29:33
b6461c75-ee0f-49d5-9cba-1fe62e73ce08	cyLexys2sbFGW0MnAwCk	9766	Tiramisu	Pastries	5	196.55	2025-01-13 15:55:33	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	pedro.cruz14	2025-01-13 15:55:33
d2528037-fb0d-424e-920a-34b457a9c48e	unkNx2gP7xHviy8GXQTR	9767	Americano	Pastries	4	80.96	2025-04-16 20:57:23	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	miguel.cruz15	2025-04-16 20:57:23
a578f64f-6bd9-4ccd-86ee-5bf60321fc91	l9qjsUgDhxGKsUhP1ErX	9769	Baguette	Pastries	5	133.77	2025-08-26 02:35:22	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183906533970	gabriela.mendoza	2025-08-26 02:35:22
29fd4e4c-b2f4-4f0a-9b46-84c25fab4428	PRUX1lZEWqla7JGYFzKB	9770	Baguette	Pastries	1	133.77	2025-09-03 16:57:38	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	antonio.delacruz10	2025-09-03 16:57:38
00ce400c-7f60-470e-abee-1f478cc74f43	aPE5AOzMkOXXKMqDRO5m	9771	Latte	Pastries	1	108.74	2025-08-05 18:34:27	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.delacruz	2025-08-05 18:34:27
e87d3c08-54a8-486f-8e4d-813f9c26cd1e	dmpigiqNsqzr2KVusUmf	9777	Tiramisu	Pastries	2	196.55	2025-07-07 21:28:45	b8fd7179-60d8-4c84-aeef-92abb02a984e	GCash	GCASH20251123183906756962	miguel.cruz15	2025-07-07 21:28:45
60a179aa-008e-4e6f-886e-e490b4e8b481	UqeaOf0SSEc9mtq4eCSL	9780	Tiramisu	Pastries	2	196.55	2025-08-14 07:02:55	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	sofia.reyes9	2025-08-14 07:02:55
a012a3cb-ab29-4156-a870-6ce902b78c58	W4nSRjlFBsqyW8Wt6qoc	9787	Blueberry Muffin	Pastries	2	185.15	2025-02-25 15:31:34	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183906053533	elena.fernandez11	2025-02-25 15:31:34
55f0b8ef-31d6-47ad-98d1-5738d952f0c6	1HOnvHwUkWEYAJsqHMer	9788	Almonds	Pastries	3	5.59	2025-08-04 17:43:41	b11b106d-a33e-4517-b9c2-6489ed3adc64	Card	\N	sofia.bautista5	2025-08-04 17:43:41
3f5d6ff7-35a5-4734-b628-68d5cee7f5f2	owDCtF9rnRjVvPVTS5Ng	9791	Espresso	Pastries	2	195.76	2025-06-11 10:54:30	942e8c8b-f8ad-451b-9ae4-826a25894c24	Card	\N	miguel.cruz15	2025-06-11 10:54:30
a5cd24a9-1017-482d-8f4d-9aeb76b094bd	FTt7l2EeQ8Maaoqq91cr	9793	Iced Mocha	Pastries	1	144.00	2025-09-20 07:11:49	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183906049273	carmen.santos1	2025-09-20 07:11:49
b53db070-69de-4525-9c85-36d6e95e9213	Zsbb3oAnn0LWgCmceEKT	9800	Iced Mocha	Pastries	4	144.00	2025-07-25 01:31:35	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	sofia.bautista5	2025-07-25 01:31:35
fe36a496-de92-4717-be06-4eeddfb7cbe9	8o6wr8fuPL51brMZikoR	9802	Americano	Pastries	1	80.96	2025-07-27 01:33:37	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183906619050	carmen.santos1	2025-07-27 01:33:37
332325c9-5f48-4b89-bd2c-43bc3f2a7c58	tFrvwGtcga49hLCqrdN7	9803	Eclair	Pastries	4	146.12	2024-11-24 02:00:25	d822e322-66a9-432e-aca0-2adc5fbb656a	GCash	GCASH20251123183906673138	gabriela.mendoza	2024-11-24 02:00:25
80640dfd-c4d5-406a-b405-81eea0be1f50	eZD6GDDV4VgdRsTHt3Fk	9804	Espresso	Pastries	1	195.76	2025-10-12 18:05:14	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.mendoza	2025-10-12 18:05:14
1c5d8de8-9802-46e9-ae55-c9d9f40c0d5f	0iToojL5GGYlMzXwuTn2	9810	Latte	Pastries	2	108.74	2024-11-29 02:31:01	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	carlos.cruz12	2024-11-29 02:31:01
bf25d9cf-9716-44d2-9517-efd2c264e24e	iUhdTNZVdQevOszwxlv7	9812	Mocha	Pastries	3	61.74	2025-07-23 13:15:33	3b8d24bc-c2db-46f2-855a-57c85685ad5b	GCash	GCASH20251123183906730642	gabriela.mendoza	2025-07-23 13:15:33
7d6017b8-581f-43bf-8082-f674fd1761d6	bqWRsKwn9xy9mlpLPfYd	9813	Espresso	Pastries	2	195.76	2025-02-05 08:49:41	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.cruz12	2025-02-05 08:49:41
124e198d-d8b9-4270-93ed-646b7081760c	8FNS5jcWf5tDhAxfpscH	9817	Tiramisu	Pastries	2	196.55	2025-08-20 17:24:15	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	pedro.cruz14	2025-08-20 17:24:15
2000e9a1-c36a-4a63-8593-efc86cbdcfd0	tnz8RV4uHsoaKnArpqP1	9820	Americano	Pastries	1	80.96	2025-10-22 00:35:12	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183906046679	gabriela.mendoza	2025-10-22 00:35:12
83f6f8b6-d2ee-4384-b87c-258461cffe88	1xBSQZ0nVhSDvAtwY7Lv	9821	Latte	Pastries	5	108.74	2024-12-14 00:17:35	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	elena.fernandez11	2024-12-14 00:17:35
3fb9c218-a5d2-4e82-8fee-af8623488f19	oMjJnZX1b1Po3P0WIDPW	9823	Americano	Pastries	3	80.96	2025-05-15 20:52:03	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	rosa.cruz13	2025-05-15 20:52:03
de27f80d-6276-4c08-ae99-ea4724c351aa	kznTNSCWCxkNVuO3icnr	9825	Almonds	Pastries	4	5.59	2025-03-13 19:54:34	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	carlos.mendoza	2025-03-13 19:54:34
9abdbd5d-375c-4cee-9414-95526c67bc14	n9E4UfjcIuRzksdMX4AH	9830	Iced Coffee	Beverages	2	107.80	2025-11-24 13:33:12	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Card	\N	pedro.cruz14	2025-11-24 13:33:12
e9716a04-a92e-4463-8ce4-e45f0efc8631	O4I54e3tjWqr06iZUh75	9832	Blueberry Muffin	Pastries	5	185.15	2025-05-06 03:02:03	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183906615959	rosa.rivera7	2025-05-06 03:02:03
1c478ec2-f85e-426f-8d94-5f7b876ef245	9liuAu4YIzaYWJO9xE6h	9835	Iced Mocha	Pastries	4	144.00	2025-11-06 15:02:59	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	isabella.delacruz4	2025-11-06 15:02:59
9254dd05-0d58-4c6e-82b1-5bccc53d4562	tRZ3YVn9OzdjFDgcFYAd	9836	Americano	Pastries	3	80.96	2025-10-20 12:33:28	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	admin	2025-10-20 12:33:28
75c54a06-ea10-4597-8a44-c3f4da54b44a	QJBtvYvBFzTnLY1TNswL	9838	Baguette	Pastries	1	133.77	2025-04-21 23:59:58	c8d156d2-b289-439f-90bc-692447063015	GCash	GCASH20251123183906255843	admin	2025-04-21 23:59:58
9add230c-b819-457d-9e4e-eaef26a7abd2	Ch6jJCDVF0mjmLoV5Y4a	9839	Chai Latte	Pastries	1	100.50	2025-01-08 21:47:38	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	sofia.bautista5	2025-01-08 21:47:38
fd3d235d-1284-4d41-a9c5-5a829c1d61ac	HDsmqOrRUBbxFCEYT1Ky	9840	Americano	Pastries	5	80.96	2025-03-19 22:30:02	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	fernando.santos8	2025-03-19 22:30:02
f515a201-61d9-4c5d-aec5-390105257baf	HBL4JqeJyE0QE4iLA9Qf	9841	Iced Mocha	Pastries	3	144.00	2025-05-21 07:17:07	1ff9c549-6c45-45f4-a524-c429c13a8aed	GCash	GCASH20251123183906182309	fernando.santos8	2025-05-21 07:17:07
3e148e7e-38bc-4324-b1d7-95b76cd3b15c	ylzX5Jf30sfoDs9Ga8jJ	9842	Glazed Donut	Pastries	4	148.75	2025-02-14 05:25:19	f3a81863-06ba-4093-b4ee-8f5ae8a29426	Card	\N	rosa.cruz13	2025-02-14 05:25:19
be4943f1-75bb-4d30-9493-0ab0e7e0a6fa	4oRNaH2v0RHajtjvaTiw	9847	Hot Chocolate	Pastries	3	131.53	2025-05-02 11:11:25	cecbc121-708f-4757-9c5e-694b09c7f7ea	GCash	GCASH20251123183906206388	pedro.cruz14	2025-05-02 11:11:25
cfe7831d-872a-4f2f-94a1-f6f8a2da6fb9	mLQRQRHnHzPag05P4DCZ	9850	Americano	Pastries	4	80.96	2025-01-02 09:55:25	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183906455205	carlos.delacruz	2025-01-02 09:55:25
1a6db061-37df-48ac-91c8-21fc8aa12e66	TPufQbze4mwqsqn4Y8OW	9851	Espresso	Pastries	3	195.76	2025-01-23 19:36:55	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	admin	2025-01-23 19:36:55
24a6fbac-2f8e-4ae4-9d9b-77abe4466b79	2YZovmbvK376HDHywiYt	9855	Mocha	Pastries	3	61.74	2025-06-02 03:22:49	3b8d24bc-c2db-46f2-855a-57c85685ad5b	Card	\N	fernando.cruz	2025-06-02 03:22:49
08009244-f079-4fbb-bf57-b7d8f04b61ab	zCeSOuXJ9tGfy0OuuqCJ	9861	Chocolate Chip Muffin	Pastries	3	103.79	2025-10-14 02:11:46	996934ff-5758-44b4-ad0e-4ed9d927901e	Cash	\N	sofia.reyes9	2025-10-14 02:11:46
e92362e1-c0e0-4ff3-a010-b55562780caf	wmS8ukPm81DI6DHJFgvx	9863	Chocolate Chip Muffin	Pastries	2	103.79	2025-08-20 15:41:24	996934ff-5758-44b4-ad0e-4ed9d927901e	Card	\N	antonio.delacruz10	2025-08-20 15:41:24
61c83d4d-3f2d-43ad-aaa7-b89468e6fabd	Jup4K7MqNih8D7q2BQ96	9870	Tea	Beverages	5	106.18	2025-06-15 19:15:01	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	carlos.delacruz	2025-06-15 19:15:01
d4d5ea58-1a45-4ce1-a532-19c2b66f2559	7FzuVAtCOflsXdRnkKf0	9875	Iced Mocha	Pastries	5	144.00	2025-11-17 22:43:35	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	fernando.santos8	2025-11-17 22:43:35
e9d76cf0-ccc7-4f1a-a6b9-9dad4e387aa7	l3BbrSzni1WutVi5MzRK	9877	Espresso	Pastries	1	195.76	2025-04-07 01:15:39	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	gabriela.mendoza	2025-04-07 01:15:39
f3820576-0140-4453-8d7e-7a9c0ee6a5e6	7q4UmuCirzLLLN5b8RLl	9878	Latte	Pastries	3	108.74	2025-08-17 08:21:00	2da4dd39-a67f-42e6-9b3e-fcaf8cd0e200	Cash	\N	ana.rivera3	2025-08-17 08:21:00
1ac0a110-ee7a-498e-acf9-2b6e64549528	KBeKbMAGpCZsnYJDEGOp	9880	Blueberry Muffin	Pastries	2	185.15	2025-05-16 20:04:37	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.cruz13	2025-05-16 20:04:37
b70c97d6-bb6d-45f7-91ab-d6aca395e76f	jgUl8EG6ePKqeAwoXv5e	9885	Macchiato	Pastries	1	93.97	2025-03-22 16:27:21	21aaf26a-f4eb-47fe-857f-6050044e5a51	Cash	\N	sofia.reyes9	2025-03-22 16:27:21
9c2ecfb4-fd6d-48d6-bcc3-6331b0d19789	96qTfFVwRaX5I1y4E2w1	9890	Hot Chocolate	Pastries	2	131.53	2024-12-20 11:22:55	cecbc121-708f-4757-9c5e-694b09c7f7ea	Cash	\N	carmen.santos1	2024-12-20 11:22:55
0952223a-728b-44ac-b6f7-3d20f7a470ce	Gb1QXI8ZXxdfzC32nfFb	9899	Red Velvet Cake	Pastries	2	187.25	2025-07-29 01:00:21	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	elena.fernandez11	2025-07-29 01:00:21
664fb821-a977-47ca-b8b5-e217f8ad5e24	GqVYhmnF5uEvTdgjndif	9900	Blueberry Muffin	Pastries	3	185.15	2025-10-07 09:08:10	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	rosa.rivera7	2025-10-07 09:08:10
8ac93791-857d-4631-9569-75503c3ddcb6	j2WGgq0HHJ3LfYQ7FXZS	9902	Red Velvet Cake	Pastries	3	187.25	2025-11-07 17:38:41	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	sofia.bautista5	2025-11-07 17:38:41
31033018-b81e-4f2d-a365-64397d925163	DKHTGLbxb8KI5kTIiaJ7	9905	Almonds	Pastries	2	5.59	2024-12-09 22:45:14	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	fernando.cruz	2024-12-09 22:45:14
5f3d0771-70e1-4642-9b57-c94351c18505	lmShFfWeA3EFbZyONJaf	9906	Blueberry Muffin	Pastries	4	185.15	2025-07-06 18:48:04	f3223b50-a7af-43cf-a233-4b8cab7e3b35	GCash	GCASH20251123183906170908	gabriela.mendoza	2025-07-06 18:48:04
1b8b88c2-19e4-4bef-a5fc-409ece48fd2d	sfGjGDsM0JYbp2PiMU2e	9907	Tea	Beverages	1	106.18	2025-04-27 16:55:23	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	GCash	GCASH20251123183906644108	antonio.santos6	2025-04-27 16:55:23
e7254418-ef46-448e-84a0-88ffc1357346	2sBTwHXnpitpuHIOhMcP	9908	Almond Croissant	Pastries	4	8.42	2024-12-08 12:07:22	19cc259c-1551-4177-b5ac-a513d5575c9b	Cash	\N	carmen.santos1	2024-12-08 12:07:22
5aef863e-34d7-4cf5-b18d-bb7d94deb831	avFgbSqplrCz6tLw9G9f	9914	Glazed Donut	Pastries	3	148.75	2025-11-16 19:57:52	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183906329100	rosa.cruz13	2025-11-16 19:57:52
a30c69e6-ccb2-4836-91fd-f1927a2643fe	XhdLizprHLc97MZwhwuX	9915	Red Velvet Cake	Pastries	1	187.25	2025-07-03 00:58:35	22893c15-bd77-4029-b8ca-3bb58becab1f	Cash	\N	pedro.cruz14	2025-07-03 00:58:35
b57c4b8b-fb56-4def-87a4-5a7bc33eefdd	tutGHkWBOcGGfJJujrSM	9916	Iced Coffee	Beverages	2	107.80	2025-01-31 09:50:34	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	sofia.reyes9	2025-01-31 09:50:34
d5e45cad-20e3-40e1-ae46-60f1887b86fd	WF3ZC5VlfufBDkSF1DxO	9918	Almonds	Pastries	5	5.59	2025-07-28 10:48:33	b11b106d-a33e-4517-b9c2-6489ed3adc64	GCash	GCASH20251123183906941924	miguel.cruz15	2025-07-28 10:48:33
0d7251c3-5291-4408-a581-b2d5236b6176	BndxrcvwtB68ngWLeoWh	9920	Red Velvet Cake	Pastries	5	187.25	2025-08-25 13:25:06	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183906422009	admin	2025-08-25 13:25:06
5f10356a-6044-4fc1-89a3-eee46e00c931	2DLrDu8esgo7IMfDS29A	9926	Tiramisu	Pastries	2	196.55	2025-05-02 03:33:09	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	elena.fernandez11	2025-05-02 03:33:09
3c60addd-5b73-412e-b90b-ede7d911223c	VjlkaqXBkccn9FK9Tzwx	9928	Hot Chocolate	Pastries	2	131.53	2025-05-11 04:38:26	cecbc121-708f-4757-9c5e-694b09c7f7ea	Card	\N	sofia.bautista5	2025-05-11 04:38:26
4d8bcba0-616b-4bd1-ae8f-3da973a612fb	b3Bx7pUTszZy0FjXZNbo	9929	Espresso	Pastries	2	195.76	2025-08-04 19:17:19	942e8c8b-f8ad-451b-9ae4-826a25894c24	GCash	GCASH20251123183906974531	sofia.bautista5	2025-08-04 19:17:19
0de09809-eb92-45a9-b6c6-1188d77acca3	8jOPPaR0gMxBxy3N1mNl	9936	Americano	Pastries	2	80.96	2025-02-04 02:39:55	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Card	\N	carlos.cruz12	2025-02-04 02:39:55
c8925640-b0d5-46ef-9528-2a67a4c879a1	Q5D2e8o8yGTmwDLC0Qpr	9938	Baguette	Pastries	1	133.77	2025-10-15 12:34:40	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	gabriela.mendoza	2025-10-15 12:34:40
a318a13f-cdac-425f-bc40-f54b18063b91	rdlbyEFTfy7HVB1MXxSY	9943	Tea	Beverages	5	106.18	2025-08-19 20:48:13	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	antonio.delacruz10	2025-08-19 20:48:13
434ac4f4-d48d-4c5e-89f4-cec1184b7893	4zb5eFCaHEMXXDwPJjm2	9952	Espresso	Pastries	3	195.76	2025-03-23 13:09:02	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	carlos.delacruz	2025-03-23 13:09:02
cd52ef59-bef5-4464-8776-6a4e68015023	V5ePzozvdMVn898Fhhc0	9954	Tiramisu	Pastries	2	196.55	2025-06-15 02:04:34	b8fd7179-60d8-4c84-aeef-92abb02a984e	Cash	\N	carlos.delacruz	2025-06-15 02:04:34
6ca3873b-c613-49e1-82b7-91f77e3e8dfb	ZXemQa85EW9mvfKFopJY	9956	Flat White	Pastries	1	113.21	2025-02-08 07:14:50	0ad8eb10-cfa2-48be-8a6c-bfdd15f80173	Cash	\N	gabriela.mendoza	2025-02-08 07:14:50
2b966682-bb4a-49ef-a15a-6ef41f17e77d	jUOxmAyqPVKWT5ZjzkR7	9958	Tea	Beverages	4	106.18	2025-10-23 20:50:27	fcaf4097-4610-42cb-a135-1bbe61f5d9b2	Cash	\N	gabriela.mendoza	2025-10-23 20:50:27
bbc02d99-e4db-4d16-ab72-fe3899298b77	qAUtoCLJ04m80Pq7dR4K	9959	Red Velvet Cake	Pastries	1	187.25	2025-03-08 16:47:58	22893c15-bd77-4029-b8ca-3bb58becab1f	GCash	GCASH20251123183906539011	admin	2025-03-08 16:47:58
731960d7-b76b-4d77-8c3b-52fe3bdac0cf	X9igRG1Bl9XrzfLd8Y29	9965	Blueberry Muffin	Pastries	4	185.15	2025-05-10 01:41:23	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Cash	\N	sofia.reyes9	2025-05-10 01:41:23
9d281c29-ad0f-4bdf-ae21-19fb0177af9d	a2A8yl2tOWBM4EG35DH7	9967	Iced Coffee	Beverages	3	107.80	2025-10-22 15:16:44	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	miguel.cruz15	2025-10-22 15:16:44
4addcb32-f52c-424c-b695-48c99b3f8fbf	ytcElYvJghPZDMZmdbNE	9969	Chai Latte	Pastries	2	100.50	2024-11-29 07:13:58	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Cash	\N	antonio.santos6	2024-11-29 07:13:58
bc07dd18-fecb-48c1-96d6-cece6a010191	fxBsb7UlY8PCm8NtXmFI	9971	Apple Turnover	Pastries	5	154.54	2025-08-24 19:36:21	5be3f24c-3995-4c70-8197-04b96e82fdaa	Cash	\N	antonio.santos6	2025-08-24 19:36:21
ee1b1028-5094-4988-8a66-14cf6fc78274	kjto6o5iblG3M68P6H4B	9972	Espresso	Pastries	5	195.76	2024-11-29 03:52:54	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	fernando.santos8	2024-11-29 03:52:54
5e06fd69-911e-4151-937c-d8ceaa59bb68	dgVODnfRRc7h0JO833v6	9974	Chai Latte	Pastries	4	100.50	2024-12-01 09:07:02	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183906869918	ana.rivera3	2024-12-01 09:07:02
687175b1-031f-41f0-8e73-f12ad5487aec	3Bfj29PJmj2dYT1sv0Vl	9975	Espresso	Pastries	5	195.76	2025-01-27 16:38:03	942e8c8b-f8ad-451b-9ae4-826a25894c24	Cash	\N	admin	2025-01-27 16:38:03
eea8970c-7933-4390-9480-5dd19e3e82af	O6NH0l1bl0CPR11ILdRL	9976	Almonds	Pastries	2	5.59	2025-03-25 01:48:53	b11b106d-a33e-4517-b9c2-6489ed3adc64	Cash	\N	elena.fernandez11	2025-03-25 01:48:53
4161f977-ee98-4f26-b514-06828848cc00	xy4vRA7M6X0KdNiIpiHX	9981	Iced Mocha	Pastries	1	144.00	2025-05-19 10:00:59	1ff9c549-6c45-45f4-a524-c429c13a8aed	Cash	\N	antonio.delacruz10	2025-05-19 10:00:59
07231c96-832e-46c3-bcc1-56bb285ea6ba	703RsWXuzeNOmikIvUT1	9982	Americano	Pastries	3	80.96	2025-08-13 10:07:23	a1b648d8-6a39-4107-9f5e-da1e2f171cde	GCash	GCASH20251123183906217306	antonio.santos6	2025-08-13 10:07:23
6866a06a-06a9-472b-b4f1-e04c3b3d1681	fULlWdwGDWLVecSB5KTh	9983	Baguette	Pastries	3	133.77	2025-03-06 12:37:34	c8d156d2-b289-439f-90bc-692447063015	Cash	\N	antonio.santos6	2025-03-06 12:37:34
6aa2db50-36ee-4a4c-b74f-39f86812f06b	Td2FvaWi4OPq4sn7fqKQ	9984	Blueberry Muffin	Pastries	3	185.15	2025-03-15 17:55:43	f3223b50-a7af-43cf-a233-4b8cab7e3b35	Card	\N	isabella.delacruz4	2025-03-15 17:55:43
504a3a32-fd3b-4b40-b1cf-ae19d3dd746e	Lrz3AmHXmx7Pk7pMnBn3	9986	Chai Latte	Pastries	1	100.50	2025-03-21 17:57:00	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	Card	\N	carlos.cruz12	2025-03-21 17:57:00
35376e6f-e897-44bd-8568-c13460ae9179	vmohmeTyproDVm3NgWI3	9993	Americano	Pastries	1	80.96	2025-09-06 09:09:08	a1b648d8-6a39-4107-9f5e-da1e2f171cde	Cash	\N	fernando.santos8	2025-09-06 09:09:08
8a57db5e-e97e-488b-9378-182fd0984bb5	qGUWAE3ss6UC7EX8QZCB	9994	Chai Latte	Pastries	5	100.50	2025-03-14 21:03:13	5c8ad7bf-1d93-4845-82ef-8f9c5682e852	GCash	GCASH20251123183906332660	fernando.cruz	2025-03-14 21:03:13
dece0977-16d8-4c09-9c39-1de5e216e4aa	WBW1z3w3TpjC5BMkPE6d	9995	Glazed Donut	Pastries	1	148.75	2025-05-02 01:40:59	f3a81863-06ba-4093-b4ee-8f5ae8a29426	GCash	GCASH20251123183906681547	admin	2025-05-02 01:40:59
c5fae4a7-d1b0-43e7-9529-f9410e527fec	MAdttkknZrY1wnGJX4p9	9996	Iced Coffee	Beverages	1	107.80	2025-01-17 01:46:09	bec7fed4-7e88-468a-8552-bfb53bd6b47e	Cash	\N	isabella.delacruz4	2025-01-17 01:46:09
\.


--
-- TOC entry 3312 (class 2606 OID 16561)
-- Name: sales sales_firebase_id_key; Type: CONSTRAINT; Schema: public; Owner: banelo_db_user
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_firebase_id_key UNIQUE (firebase_id);


--
-- TOC entry 3314 (class 2606 OID 16563)
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: banelo_db_user
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- TOC entry 3306 (class 1259 OID 16586)
-- Name: idx_sales_cashier; Type: INDEX; Schema: public; Owner: banelo_db_user
--

CREATE INDEX idx_sales_cashier ON public.sales USING btree (cashier_username);


--
-- TOC entry 3307 (class 1259 OID 16587)
-- Name: idx_sales_category; Type: INDEX; Schema: public; Owner: banelo_db_user
--

CREATE INDEX idx_sales_category ON public.sales USING btree (category);


--
-- TOC entry 3308 (class 1259 OID 16588)
-- Name: idx_sales_order_date; Type: INDEX; Schema: public; Owner: banelo_db_user
--

CREATE INDEX idx_sales_order_date ON public.sales USING btree (order_date);


--
-- TOC entry 3309 (class 1259 OID 16589)
-- Name: idx_sales_payment_mode; Type: INDEX; Schema: public; Owner: banelo_db_user
--

CREATE INDEX idx_sales_payment_mode ON public.sales USING btree (payment_mode);


--
-- TOC entry 3310 (class 1259 OID 16590)
-- Name: idx_sales_product_id; Type: INDEX; Schema: public; Owner: banelo_db_user
--

CREATE INDEX idx_sales_product_id ON public.sales USING btree (product_firebase_id);


--
-- TOC entry 3315 (class 2606 OID 16699)
-- Name: sales sales_product_firebase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: banelo_db_user
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_product_firebase_id_fkey FOREIGN KEY (product_firebase_id) REFERENCES public.products(id);


-- Completed on 2025-12-22 12:39:05

--
-- PostgreSQL database dump complete
--

\unrestrict OJc6ctZbv6boxj4DxdJc7icvSFKYq0KcQajxrDAparjIf6BW6CEKzXHNnb4vYc1

