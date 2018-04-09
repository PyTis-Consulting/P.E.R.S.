
-- pycrypt u cash -L96


CREATE USER tip_u_cash WITH PASSWORD 'eb333e45b2f5b831a7860e58b193f60a5a7aff4b4b97a353db38c3a5d5ec3a9e3ef85e594a5c937a40990dc82f8341d2';

CREATE DATABASE tip_ucash;

GRANT ALL PRIVILEGES ON DATABASE tip_ucash TO tip_u_cash;

ALTER DATABASE tip_ucash OWNER TO tip_u_cash;

CREATE TABLE public.currency (
  id SERIAL,
  name VARCHAR(255),
  symbol VARCHAR(255),
  code VARCHAR(255),
  CONSTRAINT currency_pkey PRIMARY KEY(id)
) 
WITH (oids = true);


CREATE TABLE public.exchange_rate_lookup_source (
  id SERIAL NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  website VARCHAR(1096),
  module VARCHAR(255)
) 
WITH (oids = false);

COMMENT ON COLUMN public.exchange_rate_lookup_source.name
IS 'Human Readable Name for management';

COMMENT ON COLUMN public.exchange_rate_lookup_source.website
IS 'Again, for management';


CREATE TABLE public.exchange_rate (
  id SERIAL,
  time_period TIMESTAMP WITHOUT TIME ZONE,
  source_currency INTEGER,
  target_currency INTEGER,
  rate DOUBLE PRECISION,
  last_updated_on TIMESTAMP WITHOUT TIME ZONE,
  rate_lookup_source INTEGER,
  CONSTRAINT exchange_rate_fk FOREIGN KEY (rate_lookup_source)
    REFERENCES public.exchange_rate_lookup_source(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    NOT DEFERRABLE,
  CONSTRAINT source_currency_fkey FOREIGN KEY (source_currency)
    REFERENCES public.currency(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT target_currency_fkey FOREIGN KEY (target_currency)
    REFERENCES public.currency(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) 
WITH (oids = true);

CREATE OR REPLACE VIEW public.latest_exchange_rate(
  rate,
  source_currency,
  target_currency)
AS
  SELECT foo.rate,
     foo.source_currency,
     foo.target_currency
  FROM (
     SELECT DISTINCT ON (exchange_rate.source_currency,
       exchange_rate.target_currency) exchange_rate.time_period,
        exchange_rate.rate,
        exchange_rate.source_currency,
        exchange_rate.target_currency
     FROM exchange_rate
     ORDER BY exchange_rate.source_currency,
          exchange_rate.target_currency,
          exchange_rate.time_period DESC
     ) foo
  UNION (
      SELECT DISTINCT 1 AS rate,
         exchange_rate.source_currency,
         exchange_rate.source_currency AS target_currency
      FROM exchange_rate
      ORDER BY 1::integer,
           exchange_rate.source_currency
);










