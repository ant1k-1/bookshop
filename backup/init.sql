--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-04-19 21:05:44

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
-- TOC entry 215 (class 1259 OID 16396)
-- Name: book_genre; Type: TABLE; Schema: public; Owner: bookshop
--

CREATE TABLE public.book_genre (
    book_id bigint NOT NULL,
    genres character varying(255)
);


ALTER TABLE public.book_genre OWNER TO bookshop;

--
-- TOC entry 216 (class 1259 OID 16399)
-- Name: books; Type: TABLE; Schema: public; Owner: bookshop
--

CREATE TABLE public.books (
    id bigint NOT NULL,
    isbn character varying(255),
    age_restriction integer,
    amount integer,
    category smallint,
    description text,
    final_price double precision,
    image character varying(255),
    price double precision,
    publisher character varying(255),
    rating double precision,
    sale integer,
    title character varying(255),
    year integer,
    sold_amount integer,
    author character varying(255)
);


ALTER TABLE public.books OWNER TO bookshop;

--
-- TOC entry 217 (class 1259 OID 16404)
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: bookshop
--

CREATE SEQUENCE public.books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_id_seq OWNER TO bookshop;

--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 217
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bookshop
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- TOC entry 218 (class 1259 OID 16405)
-- Name: comments; Type: TABLE; Schema: public; Owner: bookshop
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    creation_date timestamp(6) without time zone,
    is_moderated boolean,
    rate integer,
    text text,
    title character varying(255),
    book_id bigint,
    user_id bigint
);


ALTER TABLE public.comments OWNER TO bookshop;

--
-- TOC entry 219 (class 1259 OID 16410)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: bookshop
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO bookshop;

--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 219
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bookshop
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- TOC entry 220 (class 1259 OID 16411)
-- Name: order_books; Type: TABLE; Schema: public; Owner: bookshop
--

CREATE TABLE public.order_books (
    order_id bigint NOT NULL,
    books integer,
    books_key bigint NOT NULL
);


ALTER TABLE public.order_books OWNER TO bookshop;

--
-- TOC entry 221 (class 1259 OID 16414)
-- Name: orders; Type: TABLE; Schema: public; Owner: bookshop
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    address character varying(255),
    creation_date timestamp(6) without time zone,
    deliver_date timestamp(6) without time zone,
    final_price double precision,
    is_delivered boolean,
    price double precision,
    user_id bigint
);


ALTER TABLE public.orders OWNER TO bookshop;

--
-- TOC entry 222 (class 1259 OID 16417)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: bookshop
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO bookshop;

--
-- TOC entry 4862 (class 0 OID 0)
-- Dependencies: 222
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bookshop
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 223 (class 1259 OID 16418)
-- Name: rates_of_book; Type: TABLE; Schema: public; Owner: bookshop
--

CREATE TABLE public.rates_of_book (
    book_id bigint NOT NULL,
    rates integer
);


ALTER TABLE public.rates_of_book OWNER TO bookshop;

--
-- TOC entry 224 (class 1259 OID 16421)
-- Name: user_bookmarks; Type: TABLE; Schema: public; Owner: bookshop
--

CREATE TABLE public.user_bookmarks (
    user_id bigint NOT NULL,
    bookmarks bigint
);


ALTER TABLE public.user_bookmarks OWNER TO bookshop;

--
-- TOC entry 225 (class 1259 OID 16424)
-- Name: user_cart; Type: TABLE; Schema: public; Owner: bookshop
--

CREATE TABLE public.user_cart (
    user_id bigint NOT NULL,
    cart integer,
    cart_key bigint NOT NULL
);


ALTER TABLE public.user_cart OWNER TO bookshop;

--
-- TOC entry 226 (class 1259 OID 16427)
-- Name: user_role; Type: TABLE; Schema: public; Owner: bookshop
--

CREATE TABLE public.user_role (
    user_id bigint NOT NULL,
    roles character varying(255)
);


ALTER TABLE public.user_role OWNER TO bookshop;

--
-- TOC entry 227 (class 1259 OID 16430)
-- Name: users; Type: TABLE; Schema: public; Owner: bookshop
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    birth_date date,
    creation_date timestamp(6) without time zone,
    email character varying(255),
    is_active_status boolean,
    is_comments_allowed boolean,
    name character varying(255),
    password character varying(255),
    username character varying(255)
);


ALTER TABLE public.users OWNER TO bookshop;

--
-- TOC entry 228 (class 1259 OID 16435)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: bookshop
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO bookshop;

--
-- TOC entry 4863 (class 0 OID 0)
-- Dependencies: 228
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bookshop
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4673 (class 2604 OID 16436)
-- Name: books id; Type: DEFAULT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- TOC entry 4674 (class 2604 OID 16437)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 4675 (class 2604 OID 16438)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4676 (class 2604 OID 16439)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4841 (class 0 OID 16396)
-- Dependencies: 215
-- Data for Name: book_genre; Type: TABLE DATA; Schema: public; Owner: bookshop
--

COPY public.book_genre (book_id, genres) FROM stdin;
1	GENRE_DRAMA
1	GENRE_COMEDY
2	GENRE_DRAMA
2	GENRE_THRILLER
2	GENRE_SCIENCE_FICTION
3	GENRE_DRAMA
3	GENRE_COMEDY
3	GENRE_THRILLER
4	GENRE_DETECTIVE
4	GENRE_DRAMA
6	GENRE_COMEDY
6	GENRE_DRAMA
9	GENRE_DRAMA
10	GENRE_COMEDY
10	GENRE_DRAMA
11	GENRE_DRAMA
11	GENRE_THRILLER
13	GENRE_THRILLER
13	GENRE_FANTASY
13	GENRE_DRAMA
\.


--
-- TOC entry 4842 (class 0 OID 16399)
-- Dependencies: 216
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: bookshop
--

COPY public.books (id, isbn, age_restriction, amount, category, description, final_price, image, price, publisher, rating, sale, title, year, sold_amount, author) FROM stdin;
3	978-5-389-22716-3	18	5	0	Аса Митака — одинокая и молчаливая школьница, которая испытывает трудности в общении со своими одноклассниками. Ее жизнь ничем не примечательна. Но Аса даже не подозревает, что у нее есть враг, желающий ей смерти... Однажды ночью Аса оказывается лицом к лицу со своим недоброжелателем — и даже опомниться не успевает, как он ее убивает. Однако буквально за мгновение до смерти перед Асой появляется загадочное создание, которое предлагает девушке сделку. Все, что ей нужно, чтобы жить дальше, так это позволить незнакомцу вселиться в ее тело. Аса даже представить себе не могла, что, согласившись, накрепко связала свою жизнь с сильным демоном, преследующим единственную цель — победить Человека-Бензопилу... В книгу вошли главы 98–103.	650	8c032842-94e2-4493-bb6c-d20f025cd8bb_2971238.webp	650	Азбука	5	0	Человек-бензопила 7. Книга 12. Птица и война	2023	5	Тацуки Фудзимото
1	978-5-389-22163-5	16	9	0	Рождество уже не за горами! Повсюду сверкают гирлянды, люди бегают по магазинам в поисках подарков, а влюбленные готовятся к свиданию мечты, ведь для них этот праздник — один из самых романтичных в году. И вдруг за несколько дней до сочельника Кагуя внезапно охладевает к Миюки. Хотя, казалось бы, после событий на фестивале культуры молодые люди уж точно должны были стать парой. Теперь нашим героям предстоит сбросить маски и полностью открыться друг другу. Однако президенту Сироганэ, который больше всего боится показаться кому угодно в невыгодном свете, сделать это будет ой как непросто! В книгу вошли главы 142–161.	864	90f52999-d388-4df5-8415-9d21e651eb16_2960133.webp	960	Азбука	4.428571428571429	10	Госпожа Кагуя: В любви как на войне: Любовная битва двух гениев 8	2022	11	Ака Акасака
2	978-5-389-22841-2	18	10	0	Освоив азы ведения боя, Агни вновь прибывает в Бехемдолг. На этот раз охваченный пламенем юноша собирается довести дело до конца и убить Дому. Однако огненный человек не в курсе, что его новая знакомая Тогата плетет интриги у него за спиной. Цель эксцентричной девушки-режиссера — снять фильм с Агни в главной роли, и, чтобы сделать свое кино по-настоящему увлекательным, Тогата вступает в сговор с Иудой, главой Бехемдолга. Ничего не подозревающего Агни уже поджидает целая армия вооруженных солдат, а также трое заключенных-смертников, наделенных мощными благословениями. Свет, камера, мотор?.. В книгу вошли главы 19–39.	960	809a1e6f-f0a3-4f42-9391-8760f9c3e5fd_2975882.webp	960	Азбука	-1	0	Огненный удар 2	2023	0	Тацуки Фудзимото
13	978-5-389-22224-3	18	9	0	Во время миссии по защите Рико Аманай молодые заклинатели Сатору Годзё и Сугуру Гэто сталкиваются с Тодзи Фусигуро, безжалостным наемником, ловко орудующим проклятыми артефактами. Он намерен любым способом достичь своей цели и убить девочку, и Тодзи нисколько не пугает, что против него выступают двое сильнейших студентов Токийского колледжа. Противник непрост, и все же Годзё и Гэто не собираются сдаваться, ведь на кону стоит невинная жизнь. Правда, друзья еще не знают, что в магическом мире Тодзи известен как Убийца Магов. И он получил это прозвище неспроста... В книгу вошли главы 71–88.	842	8295a610-a55d-4588-a54b-e42ef1bdf35a_2968296.webp	842	Азбука	-1	0	Магическая битва. Книга 5. Таланты умирают молодыми. В преддверии праздника	2023	1	Гэгэ Акутами
4	978-5-17-120419-8	12	3	4	"Преступление и наказание" (1866) — одно из самых значительных произведений в истории мировой литературы. Это и глубокий филососфский роман, и тонкая психологическая драма, и захватывающий детектив, и величественная картина мрачного города, в недрах которого герои грешат и ищут прощения, жертвуют собой и отрекаются от себя ради ближних и находят успокоение в смирении, покаянии, вере. Главный герой романа Родион Раскольников решается на убийство, чтобы доказать себе и миру, что он не "тварь дрожащая", а "право имеет". Главным предметом исследования писателя становится процесс превращения добропорядочного, умного и доброго юноши в убийцу, а также то, как совершивший преступление Раскольников может искупить свою вину.	650	8ed7121a-f66b-4abd-ab77-ae3fed528f50_2772940.webp	650	 АСТ	-1	0	Преступление и наказание	2022	0	Федор Достоевский
6	978-5-17-112130-3	12	5	4	Бессмертное, загадочное и остроумное «Евангелие от Сатаны» Михаила Булгакова.\r\nРоман, уникальный в российской литературе ХХ столетия. Трудно себе представить, какое влияние он оказал на мировую культуру.\r\nНа основе «Мастера и Маргариты» снимались и продолжают сниматься фильмы и телесериалы, это произведение легло в основу оперы, симфонии, рок-оперы, его иллюстрировали самые знаменитые художники и фотографы.\r\nДостаточно перечислить лишь немногих создателей произведений, посвященных шедевру Булгакова и им вдохновленных: Анджей Вайда, Эннио Морриконе, Мик Джаггер, Дэвид Боуи.\r\nЧем же заворожила столь разных творческих личностей история о дьяволе и его свите, почтивших своим присутствием Москву 1930-х, о прокураторе Иудеи всаднике Понтии Пилате и нищем философе Иешуа Га-Ноцри, о талантливом и несчастном Мастере и его прекрасной и верной возлюбленной Маргарите?..	580	ba5807b4-abdb-46f4-8e0f-3a9ea9f75335_2689727.webp	580	АСТ	-1	0	Мастер и Маргарита	2022	0	Михаил Булгаков
7	978-5-4461-3942-2	16	3	2	Spring Boot, который скачивают более 75 миллионов раз в месяц, — наиболее широко используемый фреймворк Java. Его удобство и возможности совершили революцию в разработке приложений, от монолитных до микросервисов. Тем не менее простота Spring Boot может привести в замешательство. Что именно разработчику нужно изучить, чтобы сразу же выдавать результат? Это практическое руководство научит вас писать успешные приложения для критически важных задач.\r\nМарк Хеклер из VMware, компании, создавшей Spring, проведет вас по всей архитектуре Spring Boot, охватив такие вопросы, как отладка, тестирование и развертывание. Если вы хотите быстро и эффективно разрабатывать нативные облачные приложения Java или Kotlin на базе Spring Boot с помощью реактивного программирования, создания API и доступа к разнообразным базам данных — эта книга для вас.	2375	6b973b05-198c-4226-b054-c6ecf27e6b95_2927043.webp	2500	Питер	-1	5	Spring Boot по-быстрому. Создаем облачные приложения на Java и Kotlin	2022	0	Марк Хеклер
8	978-5-9775-1689-1	12	4	2	Книга о современном состоянии языка Java, векторе его развития, а также о грамотном программировании в духе паттернов GoF. Книга дает базовое представление о фреймворке Spring, контейнерах Docker, принципах ООП, затрагивая, в частности, переход к облачным решениям, обращение с IDE. Также освещены темы из enterprise-разработки: файловый ввод/вывод NIO2, многопоточность, локализация, интеграция и оптимизация производительности. В книге отражено состояние языка по состоянию на версию Java 17 с разбором некоторых аспектов Java 18.\r\nБудет интересна специалистам, возвращающимся к работе с Java после перерыва, бэкенд-разработчикам, читателям, готовящимся к сертификационным экзаменам.	875	438ccb37-a894-4fb4-bb7e-7ef699f0562a_2968338.webp	1250	BHV-CПб	-1	30	Java. Состояние языка и его перспективы. Развитие языка и его версий	2023	0	Федор Урванов
9	978-5-00180-336-2	16	7	4	Роман «Война и мир», одно из величайших произведений русской и мировой литературы, создавался Л.Н. Толстым на протяжении шести лет, восемь раз переписывался, а отдельные эпизоды — более двадцати раз. Исследователи насчитывают пятнадцать вариантов одного только начала романа. В данной книге использована вторая редакция «Войны и мира» (1873 год), наиболее полная и удобная для чтения, поскольку Толстой перевел на русский язык весь французский текст романа.\r\nКнига снабжена большим количеством иллюстраций, показывающих прототипов главных героев, исторических персонажей, а также хронику нашествия Наполеона на Россию.\r\nВ книге приводятся развернутые комментарии к иллюстрациям. Из этих комментариев можно узнать много интересных и неожиданных подробностей об исторической канве романа «Война и мир».	3400	22885bff-f7e0-418a-96ff-6cb43ba81490_2893406.webp	3400	Алгоритм	-1	0	Война и мир	2021	0	Лев Толстой
10	978-5-17-149467-4	12	10	4	Поэма "Мертвые души" еще при жизни автора была переведена на множество других языков. Она имела невероятный успех. Никому до Гоголя и после него не удавалось так ярко и остро описать пороки и слабости русского человека, так живо и правдиво отразить важнейшие для России проблемы. Прошло 160 лет, и поэма звучит как только что написанная. Чичиковы, Коробочки, Ноздревы, Плюшкины, Собакевичи — их стремления, чувства, поступки не кажутся нам отголосками прошлого. Современное и острое звучание эти персонажи обретают, когда мы смотрим все новые и новые спектакли и фильмы по этой бессмертной поэме.\r\n\r\nНиколай Васильевич Гоголь (1809-1852) – признанный классик русской литературы, знаменитый на весь мир прозаик и драматург. Гоголя читают, любят и знают многие поколения читателей – от мала до велика: с детства мы погружаемся в волшебный, чарующий мир «Вечеров на хуторе близ Диканьки», с замиранием сердца открываем для себя «Вия» – наш первый «ужастик» с элементами мистики. Когда становимся старше – читаем «Ревизора», и для многих знакомство с театром начинается именно с этой пьесы. Говорят, что нет другого такого образа в русской литературе, который имел бы столько сценических интерпритаций, как образ мастерского лгуна и выдумщика Хлестакова. А могучий характер запорожского казака Тараса Бульбы из одноименной повести знаком нам со школьной скамьи. Кто из нас не читал «Петербургских повестей» гоголя, вызывающих и смех, и слезы, и легкую грусть, и легкое недоумение: а кто же этот «маленький человек»? Может тот, кого мы видим каждый день и не замечаем… Ну и, наконец, «Мертвые души» – самое великое произведение Гоголя, в котором ставятся важнейшие для России вопросы, так до сих пор и не разрешенные: «Русь, куда ж несешься ты? Дай ответ.» Гоголь и на сегодняшний день остается одним из самых актуальных писателей.	516.2	364ba36a-b6aa-46f5-9c39-88cd6ecfb1bd_2921940.webp	580	АСТ	-1	11	Мертвые души	2022	0	Николай Гоголь
11	978-5-389-13083-8	18	15	0	Райнер и Бертольт, оказавшиеся, ни много ни мало, бронированным титаном и титаном-колоссом, попытались похитить Эрена, и забрать его, а заодно и Имир, на свою загадочную «родину». Разведкорпус бросается в отчаянную погоню и ценой невероятных усилий и огромных жертв возвращает Эрена. А Имир принимает неожиданное решение...\r\nВскоре после этих событий в солдатских казармах происходит жестокое преступление и разведкорпус оказывается втянут в противостояние с военной полицией. А тем временем люди в пределах стен чувствуют себя все более уязвимыми, особенно после того, как обитатели целой деревни необъяснимым образом превратились в титанов…	800	43c64099-a6b1-4830-bf86-63a8313b466d_2608120.webp	800	Азбука	-1	0	Атака на Титанов. Книга 7	2022	0	Хадзимэ Исаяма
5	978-5-4461-0923-4	16	0	2	Иллюстрированное пособие для програмистов и любопытствующих.\r\nАлгоритмы - это всего лишь пошаговые алгоритмы решения задач, и большинство таких задач уже были кем-то решены, протестированы и проверены. Можно, конечно, погрузится в глубокую философию гениального Кнута, изучить многостраничные фолианты с доказательствами и обоснованиями, но хотите ли вы тратить на это свое время?\r\nОткройте великолепно иллюстрированную книгу и вы сразу поймете, что алгоритмы - это просто.\r\nА грокать алгоритмы - это веселое и увлекательное занятие.	1275	040c3d60-69f3-444a-8731-76e12c0af87a_2576389.webp	1500	Питер	5	15	Грокаем алгоритмы	2017	3	Адитья Бхаргава
12	978-5-9706-0959-0	12	2	2	Технологии и протоколы, лежащие в основе интернет-связи, позволяют передавать данные между миллиардами устройств по всему миру. Эта книга снимает завесу тайны с удивительной архитектуры и протоколов, благодаря которым устройства могут обмениваться данными по сети. Несмотря на всю свою сложность, интернет фактически основан на нескольких относительно простых концепциях, с которыми может ознакомиться каждый желающий.\r\nСегодня сети и сетевые приложения стали неотъемлемой частью нашей жизни, поэтому понимать, как работают эти технологии, исключительно важно. Для изучения книги читателю не потребуются технические знания – она написана в расчете на рядового пользователя интернета, интересующегося устройством Глобальной Сети.	1600	a385e5fa-f650-4aa0-b7f8-3cc72295e5c0_2862753.webp	1600	ДМК Пресс	-1	0	Как работают компьютерные сети и интернет	2021	0	Чарльз Р. Северанс
\.


--
-- TOC entry 4844 (class 0 OID 16405)
-- Dependencies: 218
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: bookshop
--

COPY public.comments (id, creation_date, is_moderated, rate, text, title, book_id, user_id) FROM stdin;
1	2023-05-10 11:44:43.566728	t	5	До выхода второй части история казалась вполне завершенной, однако, из этого продолжения может выйти новая интересная арка или вроде того. По стилистике и в целом все выглядит как прежде, радует что повествование не рвется на два разных варианта той реальности.	Понравилось	3	2
6	2023-05-14 00:15:53.191363	t	5	Это тестовый отзыв	Тестовый отзыв	1	2
7	2023-05-14 00:18:50.633715	t	4	Тестовый отзыв	Тестовый отзыв	1	4
13	2023-05-18 23:11:27.21228	t	5	Отлично подходит для базового изучения алгоритмов!	Хорошая книга	5	2
14	2023-05-19 14:06:04.212344	t	4	Хорошее чтиво, всё понравилось! Самый раз занять себя чем-то вечером.	Хорошая книга	1	6
\.


--
-- TOC entry 4846 (class 0 OID 16411)
-- Dependencies: 220
-- Data for Name: order_books; Type: TABLE DATA; Schema: public; Owner: bookshop
--

COPY public.order_books (order_id, books, books_key) FROM stdin;
12	1	1
12	1	2
12	1	3
13	5	3
14	1	1
15	1	1
16	1	1
17	8	1
18	1	5
19	1	1
20	2	5
21	1	13
\.


--
-- TOC entry 4847 (class 0 OID 16414)
-- Dependencies: 221
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: bookshop
--

COPY public.orders (id, address, creation_date, deliver_date, final_price, is_delivered, price, user_id) FROM stdin;
12	ул. Ферсмана, д13к1	2023-05-14 18:04:34.142535	2023-05-21 18:04:34.142535	2570	t	2570	4
13	ул. Ферсмана, д13к1	2023-05-14 19:28:20.676658	2023-05-21 19:28:20.676658	3250	f	3250	4
17	ул. Ферсмана, д13к1	2023-05-14 19:41:23.125586	2023-05-21 19:41:23.125586	7680	f	7680	4
15	ул. Ферсмана, д13к1	2023-05-14 19:35:14.069934	2023-05-21 19:35:14.069934	960	t	960	4
16	ул. Ферсмана, д13к1	2023-05-14 19:36:23.777053	2023-05-21 19:36:23.777053	960	t	960	4
14	ул. Ферсмана, д13к1	2023-05-14 19:33:37.96123	2023-05-21 19:33:37.96123	960	t	960	4
18	г. Москва, ул. Ферсмана д13к1	2023-05-17 00:25:17.647767	2023-05-24 00:25:17.647767	1500	f	1500	5
20	г. Москва, улица такая-то, дом такой-то, кв. X	2023-05-19 11:57:29.241652	2023-05-26 11:57:29.241652	3000	t	3000	6
21	г. Москва, ул. Ферсмана д13к1	2023-05-28 00:29:03.444248	2023-06-04 00:29:03.444248	842	f	842	2
19	ул. Ферсмана, д13к1	2023-05-17 12:59:32.802461	2023-05-24 12:59:32.802461	960	t	960	2
\.


--
-- TOC entry 4849 (class 0 OID 16418)
-- Dependencies: 223
-- Data for Name: rates_of_book; Type: TABLE DATA; Schema: public; Owner: bookshop
--

COPY public.rates_of_book (book_id, rates) FROM stdin;
3	5
5	5
1	4
1	5
1	4
1	5
1	5
1	4
1	4
\.


--
-- TOC entry 4850 (class 0 OID 16421)
-- Dependencies: 224
-- Data for Name: user_bookmarks; Type: TABLE DATA; Schema: public; Owner: bookshop
--

COPY public.user_bookmarks (user_id, bookmarks) FROM stdin;
4	1
5	1
6	4
\.


--
-- TOC entry 4851 (class 0 OID 16424)
-- Dependencies: 225
-- Data for Name: user_cart; Type: TABLE DATA; Schema: public; Owner: bookshop
--

COPY public.user_cart (user_id, cart, cart_key) FROM stdin;
4	1	2
\.


--
-- TOC entry 4852 (class 0 OID 16427)
-- Dependencies: 226
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: bookshop
--

COPY public.user_role (user_id, roles) FROM stdin;
2	ROLE_ADMIN
2	ROLE_CUSTOMER
3	ROLE_MODERATOR
3	ROLE_CUSTOMER
4	ROLE_CUSTOMER
2	ROLE_MODERATOR
5	ROLE_CUSTOMER
6	ROLE_CUSTOMER
\.


--
-- TOC entry 4853 (class 0 OID 16430)
-- Dependencies: 227
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: bookshop
--

COPY public.users (id, birth_date, creation_date, email, is_active_status, is_comments_allowed, name, password, username) FROM stdin;
2	\N	2023-05-08 12:04:00.910297	\N	t	t	\N	$2a$10$bfWz8XZZOWTL52Svcactc.wRaQk0hdi1/A.E5AcGyU/M01w3Xq8CC	admin
3	\N	2023-05-08 12:04:51.242393	\N	t	t	\N	$2a$10$7juGhjiBo545jQTYhkNRj.cCDa.L0VRllFMYUK8EvYVZVNz6pH9zC	Moder
4	2003-02-19	2023-05-08 19:28:12.459617	anton.mail1902@yandex.ru	t	t	Антон	$2a$10$H5fVjBaiRJeTFcXIobtVz.eq1AACF9IBcEzzLOBIB5Q.9qCXNdS8W	customer
5	2003-02-19	2023-05-17 00:14:53.256297	anton@mail.com	t	t	Антон	$2a$10$e0.3kAklgWDzJ.3a2TnNwe5O9Zb1oEAVSnpnCLE7WW/PohY6jfOx.	antik
6	2003-02-19	2023-05-19 11:31:33.461031	new.email@gmail.com	t	f	Антон	$2a$10$c1GlF/mvJjgvnvTlwj0Yfu7oswrmqkiDr6pantgaviT5X66HaEv.6	anton
\.


--
-- TOC entry 4864 (class 0 OID 0)
-- Dependencies: 217
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bookshop
--

SELECT pg_catalog.setval('public.books_id_seq', 13, true);


--
-- TOC entry 4865 (class 0 OID 0)
-- Dependencies: 219
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bookshop
--

SELECT pg_catalog.setval('public.comments_id_seq', 15, true);


--
-- TOC entry 4866 (class 0 OID 0)
-- Dependencies: 222
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bookshop
--

SELECT pg_catalog.setval('public.orders_id_seq', 21, true);


--
-- TOC entry 4867 (class 0 OID 0)
-- Dependencies: 228
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bookshop
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- TOC entry 4678 (class 2606 OID 16441)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- TOC entry 4680 (class 2606 OID 16443)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 4682 (class 2606 OID 16445)
-- Name: order_books order_books_pkey; Type: CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.order_books
    ADD CONSTRAINT order_books_pkey PRIMARY KEY (order_id, books_key);


--
-- TOC entry 4684 (class 2606 OID 16447)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4686 (class 2606 OID 16449)
-- Name: user_cart user_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.user_cart
    ADD CONSTRAINT user_cart_pkey PRIMARY KEY (user_id, cart_key);


--
-- TOC entry 4688 (class 2606 OID 16451)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4690 (class 2606 OID 16452)
-- Name: comments fk1ey8gegnanvybix5a025vepf4; Type: FK CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk1ey8gegnanvybix5a025vepf4 FOREIGN KEY (book_id) REFERENCES public.books(id);


--
-- TOC entry 4693 (class 2606 OID 16457)
-- Name: orders fk32ql8ubntj5uh44ph9659tiih; Type: FK CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk32ql8ubntj5uh44ph9659tiih FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4691 (class 2606 OID 16462)
-- Name: comments fk8omq0tc18jd43bu5tjh6jvraq; Type: FK CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk8omq0tc18jd43bu5tjh6jvraq FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4692 (class 2606 OID 16467)
-- Name: order_books fk9ai8wib7jbokb4njnkwb8cy5i; Type: FK CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.order_books
    ADD CONSTRAINT fk9ai8wib7jbokb4njnkwb8cy5i FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 4695 (class 2606 OID 16472)
-- Name: user_bookmarks fkhn6ih0jygj6jcsa8e59sbmvnn; Type: FK CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.user_bookmarks
    ADD CONSTRAINT fkhn6ih0jygj6jcsa8e59sbmvnn FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4697 (class 2606 OID 16477)
-- Name: user_role fkj345gk1bovqvfame88rcx7yyx; Type: FK CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT fkj345gk1bovqvfame88rcx7yyx FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4696 (class 2606 OID 16482)
-- Name: user_cart fkjnc3hqv2aeg4rb38ghsrp561; Type: FK CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.user_cart
    ADD CONSTRAINT fkjnc3hqv2aeg4rb38ghsrp561 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4689 (class 2606 OID 16487)
-- Name: book_genre fkq0f88ptislu8lv230mvgonssl; Type: FK CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.book_genre
    ADD CONSTRAINT fkq0f88ptislu8lv230mvgonssl FOREIGN KEY (book_id) REFERENCES public.books(id);


--
-- TOC entry 4694 (class 2606 OID 16492)
-- Name: rates_of_book fkrdkx14qs3x53ri084q85lbo6; Type: FK CONSTRAINT; Schema: public; Owner: bookshop
--

ALTER TABLE ONLY public.rates_of_book
    ADD CONSTRAINT fkrdkx14qs3x53ri084q85lbo6 FOREIGN KEY (book_id) REFERENCES public.books(id);


-- Completed on 2024-04-19 21:05:44

--
-- PostgreSQL database dump complete
--

