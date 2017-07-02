--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

-- Started on 2017-07-02 22:25:46 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE starwars;
--
-- TOC entry 2181 (class 1262 OID 41300)
-- Name: starwars; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE starwars WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


\connect starwars

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12395)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2183 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 187 (class 1255 OID 41376)
-- Name: update_modified_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.modified = now();
    RETURN NEW;	
END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 41358)
-- Name: mjkwnf_planet_votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mjkwnf_planet_votes (
    id integer NOT NULL,
    planet_id integer NOT NULL,
    user_id integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 185 (class 1259 OID 41356)
-- Name: mjkwnf_planet_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mjkwnf_planet_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 185
-- Name: mjkwnf_planet_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mjkwnf_planet_votes_id_seq OWNED BY mjkwnf_planet_votes.id;


--
-- TOC entry 182 (class 1259 OID 41315)
-- Name: mjkwnf_planets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mjkwnf_planets (
    id integer NOT NULL,
    planet_name character varying(255) NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 181 (class 1259 OID 41313)
-- Name: mjkwnf_planets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mjkwnf_planets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 181
-- Name: mjkwnf_planets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mjkwnf_planets_id_seq OWNED BY mjkwnf_planets.id;


--
-- TOC entry 184 (class 1259 OID 41344)
-- Name: mjkwnf_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mjkwnf_users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    enabled integer DEFAULT 1 NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 183 (class 1259 OID 41342)
-- Name: mjkwnf_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mjkwnf_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 183
-- Name: mjkwnf_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mjkwnf_users_id_seq OWNED BY mjkwnf_users.id;


--
-- TOC entry 2039 (class 2604 OID 41361)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mjkwnf_planet_votes ALTER COLUMN id SET DEFAULT nextval('mjkwnf_planet_votes_id_seq'::regclass);


--
-- TOC entry 2032 (class 2604 OID 41318)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mjkwnf_planets ALTER COLUMN id SET DEFAULT nextval('mjkwnf_planets_id_seq'::regclass);


--
-- TOC entry 2034 (class 2604 OID 41347)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mjkwnf_users ALTER COLUMN id SET DEFAULT nextval('mjkwnf_users_id_seq'::regclass);


--
-- TOC entry 2176 (class 0 OID 41358)
-- Dependencies: 186
-- Data for Name: mjkwnf_planet_votes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (2, 5, 1, '2017-07-02 03:47:51.574788', '2017-07-02 03:47:51.574788');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (4, 15, 1, '2017-07-02 03:47:51.574788', '2017-07-02 03:47:51.574788');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (5, 25, 1, '2017-07-02 03:47:51.574788', '2017-07-02 03:47:51.574788');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (6, 35, 1, '2017-07-02 03:47:51.574788', '2017-07-02 03:47:51.574788');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (7, 45, 1, '2017-07-02 03:47:51.574788', '2017-07-02 03:47:51.574788');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (8, 55, 1, '2017-07-02 03:47:51.574788', '2017-07-02 03:47:51.574788');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (9, 53, 1, '2017-07-02 03:47:51.574788', '2017-07-02 03:47:51.574788');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (10, 57, 1, '2017-07-02 03:47:51.574788', '2017-07-02 03:47:51.574788');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (11, 5, 2, '2017-07-02 03:47:51.574788', '2017-07-02 03:47:51.574788');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (18, 10, 1, '2017-07-02 17:45:44.767208', '2017-07-02 17:45:44.767208');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (22, 3, 1, '2017-07-02 19:44:49.394924', '2017-07-02 19:44:49.394924');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (23, 7, 1, '2017-07-02 19:44:54.384364', '2017-07-02 19:44:54.384364');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (24, 4, 1, '2017-07-02 19:44:56.178067', '2017-07-02 19:44:56.178067');
INSERT INTO mjkwnf_planet_votes (id, planet_id, user_id, created, modified) VALUES (25, 1, 1, '2017-07-02 19:53:57.917053', '2017-07-02 19:53:57.917053');


--
-- TOC entry 2187 (class 0 OID 0)
-- Dependencies: 185
-- Name: mjkwnf_planet_votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mjkwnf_planet_votes_id_seq', 25, true);


--
-- TOC entry 2172 (class 0 OID 41315)
-- Dependencies: 182
-- Data for Name: mjkwnf_planets; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (1, 'Alderaan', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (2, 'Yavin IV', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (3, 'Hoth', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (4, 'Dagobah', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (5, 'Bespin', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (6, 'Endor', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (7, 'Naboo', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (8, 'Coruscant', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (9, 'Kamino', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (10, 'Geonosis', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (11, 'Utapau', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (12, 'Mustafar', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (13, 'Kashyyyk', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (14, 'Polis Massa', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (15, 'Mygeeto', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (16, 'Felucia', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (17, 'Cato Neimoidia', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (18, 'Saleucami', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (19, 'Stewjon', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (20, 'Eriadu', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (21, 'Corellia', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (22, 'Rodia', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (23, 'Nal Hutta', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (24, 'Dantooine', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (25, 'Bestine IV', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (26, 'Ord Mantell', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (27, 'unknown', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (28, 'Trandosha', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (29, 'Socorro', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (30, 'Mon Cala', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (31, 'Chandrila', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (32, 'Sullust', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (33, 'Toydaria', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (34, 'Malastare', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (35, 'Dathomir', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (36, 'Ryloth', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (37, 'Aleen Minor', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (38, 'Vulpter', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (39, 'Troiken', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (40, 'Tund', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (41, 'Haruun Kal', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (42, 'Cerea', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (43, 'Glee Anselm', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (44, 'Iridonia', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (45, 'Tholoth', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (46, 'Iktotch', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (47, 'Quermia', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (48, 'Dorin', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (49, 'Champala', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (50, 'Mirial', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (51, 'Serenno', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (52, 'Concord Dawn', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (53, 'Zolan', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (54, 'Ojom', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (55, 'Skako', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (56, 'Muunilinst', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (57, 'Shili', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (58, 'Kalee', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (59, 'Umbara', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (60, 'Tatooine', '2017-06-30 23:32:09.916564');
INSERT INTO mjkwnf_planets (id, planet_name, created) VALUES (61, 'Jakku', '2017-06-30 23:32:09.916564');


--
-- TOC entry 2188 (class 0 OID 0)
-- Dependencies: 181
-- Name: mjkwnf_planets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mjkwnf_planets_id_seq', 61, true);


--
-- TOC entry 2174 (class 0 OID 41344)
-- Dependencies: 184
-- Data for Name: mjkwnf_users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mjkwnf_users (id, username, password, enabled, deleted, created, modified) VALUES (1, 'jpeter82', 'pbkdf2:sha512:20000$tgiW5rKG$cc5a8dea00fc9b3793482459004c40c3c0a6f46db3184490271fb73f7b1ce6424baab43304b5d9c3ed33317e3dbbc29a987d65a3c6c7d63603fd3b1740d13acb', 1, 0, '2017-07-01 19:12:55.712267', '2017-07-01 19:12:55.712267');
INSERT INTO mjkwnf_users (id, username, password, enabled, deleted, created, modified) VALUES (2, 'nemtom99', 'pbkdf2:sha512:20000$nqb6QgZB$c8fb99ef7fb7bf195c5427edbd322ed1760c9f6ff977c0847e46d56f42801b04b29110faa3eec434c41cca053f96d01741193902aef313e9e09eaa6a0807d903', 1, 0, '2017-07-01 19:25:48.874538', '2017-07-01 19:25:48.874538');
INSERT INTO mjkwnf_users (id, username, password, enabled, deleted, created, modified) VALUES (3, 'testuser23', 'pbkdf2:sha512:20000$P4RP1mS3$3027751a80b22ccf4ebff94cb7153c7e1f84fdca9555a7aacd51783a85841ec158b60051a058063ca099d472a2cb2cbbf4a6ac5d6786f7973001e7f4664d7f40', 1, 0, '2017-07-01 19:51:29.505289', '2017-07-01 19:51:29.505289');
INSERT INTO mjkwnf_users (id, username, password, enabled, deleted, created, modified) VALUES (4, 'tesztuser', 'pbkdf2:sha512:20000$XaPbxFbC$b495664ad45b3a14caa077e439d07a1951a39d012eba5f64148bacd23e73471c4902e66b994f5926736c524cc31b2a4330289a629c720b622f6814f54370a376', 1, 0, '2017-07-01 20:03:38.708101', '2017-07-01 20:03:38.708101');
INSERT INTO mjkwnf_users (id, username, password, enabled, deleted, created, modified) VALUES (5, 'cnwjnmcjw', 'pbkdf2:sha512:20000$b6UHJLbR$652d30330702fd013f5be14afcb27e8c11315e9fcea4ec846df6e3d2663e33c79fe5ac87a1cac302b6dc734a5fbc637c0993d078127db1b790d6ae88fdc90362', 1, 0, '2017-07-01 20:08:42.023968', '2017-07-01 20:08:42.023968');
INSERT INTO mjkwnf_users (id, username, password, enabled, deleted, created, modified) VALUES (6, 'nvjwnvw-fwrf', 'pbkdf2:sha512:20000$hviE78ly$13517626f94b15240df4bcba5cc7fd16bf5d6c5a8cd8f1b6e3ed0bfc50ff82d8fce01ad435eb04b140f86e365d2e61658c6f70caf174a905c5a6430f8565270d', 1, 0, '2017-07-01 20:10:49.487611', '2017-07-01 20:10:49.487611');
INSERT INTO mjkwnf_users (id, username, password, enabled, deleted, created, modified) VALUES (7, 'nfwjfnjwnfj_wrmkf', 'pbkdf2:sha512:20000$0UXrb4l6$04000ff6868fd35f5347bc6845400fecd25484e403b03f0e147defcac9f9b642bc2eeca7a944df6b5526b4ae361d18192747600c64f7d2a9002aa0be09f5908a', 1, 0, '2017-07-01 20:23:15.395813', '2017-07-01 20:23:15.395813');
INSERT INTO mjkwnf_users (id, username, password, enabled, deleted, created, modified) VALUES (8, 'moewkgjmekw', 'pbkdf2:sha512:20000$s6JPG8Hc$38bb8bcc6914d37788207f25c7d8cd7d7fbb3c61b7745a3b1a5319e2a4e830f121aafe473bbff69b26ac3d1ad2e667b56e502cae4eaaa8b42bbe33886d1cb738', 1, 0, '2017-07-01 20:56:17.980906', '2017-07-01 20:56:17.980906');
INSERT INTO mjkwnf_users (id, username, password, enabled, deleted, created, modified) VALUES (9, 'nmfkwfjewfke', 'pbkdf2:sha512:20000$4GimCp4M$29b41e33062a238c970d4181e911a95323ca0193796240f53f7bd4b947d272c9b1211b334bba96f5e7a13f72b0395eee91b88bbae71f8653012a5c3b9ace0898', 1, 0, '2017-07-01 20:57:39.661472', '2017-07-01 20:57:39.661472');
INSERT INTO mjkwnf_users (id, username, password, enabled, deleted, created, modified) VALUES (10, 'nvjkwgnwrkm', 'pbkdf2:sha512:20000$eg0wrcvP$467fdd4d4b03a0aca1b0c96cc90297d7c44b6ba7911a7ff0d18fc2b83084c2ccc71c63f6b3db5b4c6586582056b4db71c5d7b099beb82dc6425f6666828e458e', 1, 0, '2017-07-01 21:04:40.357513', '2017-07-01 21:04:40.357513');


--
-- TOC entry 2189 (class 0 OID 0)
-- Dependencies: 183
-- Name: mjkwnf_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mjkwnf_users_id_seq', 10, true);


--
-- TOC entry 2050 (class 2606 OID 41365)
-- Name: mjkwnf_planet_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mjkwnf_planet_votes
    ADD CONSTRAINT mjkwnf_planet_votes_pkey PRIMARY KEY (id);


--
-- TOC entry 2043 (class 2606 OID 41321)
-- Name: mjkwnf_planets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mjkwnf_planets
    ADD CONSTRAINT mjkwnf_planets_pkey PRIMARY KEY (id);


--
-- TOC entry 2045 (class 2606 OID 41353)
-- Name: mjkwnf_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mjkwnf_users
    ADD CONSTRAINT mjkwnf_users_pkey PRIMARY KEY (id);


--
-- TOC entry 2047 (class 2606 OID 41355)
-- Name: mjkwnf_users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mjkwnf_users
    ADD CONSTRAINT mjkwnf_users_username_key UNIQUE (username);


--
-- TOC entry 2052 (class 2606 OID 41386)
-- Name: unique_planet_vote_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mjkwnf_planet_votes
    ADD CONSTRAINT unique_planet_vote_key UNIQUE (planet_id, user_id);


--
-- TOC entry 2048 (class 1259 OID 41387)
-- Name: users_username_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_username_idx ON mjkwnf_users USING btree (username);


--
-- TOC entry 2056 (class 2620 OID 41378)
-- Name: update_planet_votes_modtime; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_planet_votes_modtime BEFORE UPDATE ON mjkwnf_planet_votes FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- TOC entry 2055 (class 2620 OID 41377)
-- Name: update_users_modtime; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_users_modtime BEFORE UPDATE ON mjkwnf_users FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


--
-- TOC entry 2053 (class 2606 OID 41366)
-- Name: mjkwnf_planet_votes_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mjkwnf_planet_votes
    ADD CONSTRAINT mjkwnf_planet_votes_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES mjkwnf_planets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2054 (class 2606 OID 41371)
-- Name: mjkwnf_planet_votes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mjkwnf_planet_votes
    ADD CONSTRAINT mjkwnf_planet_votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES mjkwnf_users(id) ON UPDATE CASCADE;


-- Completed on 2017-07-02 22:25:46 CEST

--
-- PostgreSQL database dump complete
--

