--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE guessing_game;
--
-- Name: guessing_game; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE guessing_game WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE guessing_game OWNER TO freecodecamp;

\connect guessing_game

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer NOT NULL,
    score integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 9);
INSERT INTO public.games VALUES (2, 1, 9);
INSERT INTO public.games VALUES (3, 1, 9);
INSERT INTO public.games VALUES (4, 1, 10);
INSERT INTO public.games VALUES (5, 2, 713);
INSERT INTO public.games VALUES (6, 2, 846);
INSERT INTO public.games VALUES (7, 3, 508);
INSERT INTO public.games VALUES (8, 3, 362);
INSERT INTO public.games VALUES (9, 2, 659);
INSERT INTO public.games VALUES (10, 2, 846);
INSERT INTO public.games VALUES (11, 2, 876);
INSERT INTO public.games VALUES (12, 4, 377);
INSERT INTO public.games VALUES (13, 4, 288);
INSERT INTO public.games VALUES (14, 5, 586);
INSERT INTO public.games VALUES (15, 5, 840);
INSERT INTO public.games VALUES (16, 4, 10);
INSERT INTO public.games VALUES (17, 4, 937);
INSERT INTO public.games VALUES (18, 4, 687);
INSERT INTO public.games VALUES (19, 7, 834);
INSERT INTO public.games VALUES (20, 7, 42);
INSERT INTO public.games VALUES (21, 8, 111);
INSERT INTO public.games VALUES (22, 8, 3);
INSERT INTO public.games VALUES (23, 7, 717);
INSERT INTO public.games VALUES (24, 7, 520);
INSERT INTO public.games VALUES (25, 7, 101);
INSERT INTO public.games VALUES (26, 9, 486);
INSERT INTO public.games VALUES (27, 9, 725);
INSERT INTO public.games VALUES (28, 10, 334);
INSERT INTO public.games VALUES (29, 10, 69);
INSERT INTO public.games VALUES (30, 9, 622);
INSERT INTO public.games VALUES (31, 9, 629);
INSERT INTO public.games VALUES (32, 9, 636);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'abcde');
INSERT INTO public.users VALUES (2, 'user_1767755023686');
INSERT INTO public.users VALUES (3, 'user_1767755023685');
INSERT INTO public.users VALUES (4, 'user_1767755135359');
INSERT INTO public.users VALUES (5, 'user_1767755135358');
INSERT INTO public.users VALUES (6, 'new');
INSERT INTO public.users VALUES (7, 'user_1767755206479');
INSERT INTO public.users VALUES (8, 'user_1767755206478');
INSERT INTO public.users VALUES (9, 'user_1767755220584');
INSERT INTO public.users VALUES (10, 'user_1767755220583');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 32, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 10, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

