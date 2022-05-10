-- Database: DAS-014

-- DROP DATABASE IF EXISTS "DAS-014";

CREATE DATABASE "DAS-014"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
-- Table: public.MovieReleases

-- DROP TABLE IF EXISTS public."MovieReleases";

CREATE TABLE IF NOT EXISTS public."MovieReleases"
(
    "Id" bigint NOT NULL DEFAULT nextval('"MovieReleases_Id_seq"'::regclass),
    "MovieId" bigint NOT NULL,
    "PlatformId" bigint NOT NULL,
    "Date" timestamp without time zone NOT NULL,
    CONSTRAINT "MovieReleases_pkey" PRIMARY KEY ("Id"),
    CONSTRAINT "Movie" FOREIGN KEY ("MovieId")
        REFERENCES public."Movies" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "Platform" FOREIGN KEY ("PlatformId")
        REFERENCES public."Platforms" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."MovieReleases"
    OWNER to postgres;	
	
-- Table: public.Movies

-- DROP TABLE IF EXISTS public."Movies";

CREATE TABLE IF NOT EXISTS public."Movies"
(
    "Id" bigint NOT NULL DEFAULT nextval('"Movies_Id_seq"'::regclass),
    "Title" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Movies_pkey" PRIMARY KEY ("Id")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Movies"
    OWNER to postgres;
	
-- Table: public.Platforms

-- DROP TABLE IF EXISTS public."Platforms";

CREATE TABLE IF NOT EXISTS public."Platforms"
(
    "Id" bigint NOT NULL DEFAULT nextval('"Platforms_Id_seq"'::regclass),
    "Name" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Platforms_pkey" PRIMARY KEY ("Id")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Platforms"
    OWNER to postgres;
	
-- Table: public.Sentiments

-- DROP TABLE IF EXISTS public."Sentiments";

CREATE TABLE IF NOT EXISTS public."Sentiments"
(
    "Id" bigint NOT NULL DEFAULT nextval('"Sentiments_Id_seq"'::regclass),
    "Date" timestamp without time zone NOT NULL,
    "Anger" bigint NOT NULL,
    "Anticipation" bigint NOT NULL,
    "Disgust" bigint NOT NULL,
    "Fear" bigint NOT NULL,
    "Joy" bigint NOT NULL,
    "Sadness" bigint NOT NULL,
    "Surprise" bigint NOT NULL,
    "Trust" bigint NOT NULL,
    "Negative" bigint NOT NULL,
    "Positive" bigint NOT NULL,
    "MovieId" bigint NOT NULL,
    CONSTRAINT "Sentiments_pkey" PRIMARY KEY ("Id"),
    CONSTRAINT "Movie" FOREIGN KEY ("MovieId")
        REFERENCES public."Movies" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Sentiments"
    OWNER to postgres;
	
-- Table: public.Tweets

-- DROP TABLE IF EXISTS public."Tweets";

CREATE TABLE IF NOT EXISTS public."Tweets"
(
    "Id" bigint NOT NULL DEFAULT nextval('"Tweets_Id_seq"'::regclass),
    "Text" character varying COLLATE pg_catalog."default" NOT NULL,
    "Favorited" boolean NOT NULL,
    "FavoriteCount" bigint NOT NULL,
    "Created" timestamp without time zone NOT NULL,
    "ScreenName" character varying COLLATE pg_catalog."default" NOT NULL,
    "RetweetCount" bigint NOT NULL,
    "IsRetweet" boolean NOT NULL,
    "Language" character varying COLLATE pg_catalog."default" NOT NULL,
    "MovieId" bigint NOT NULL,
    CONSTRAINT "Tweets_pkey" PRIMARY KEY ("Id"),
    CONSTRAINT "Movie" FOREIGN KEY ("MovieId")
        REFERENCES public."Movies" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Tweets"
    OWNER to postgres;
