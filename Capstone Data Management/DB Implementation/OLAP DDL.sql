CREATE TABLE IF NOT EXISTS finproDimDate
(
    date date,
	datekey character varying,
    year integer,
    quarter integer,
    month integer,
    day integer,
    dayof_week integer,
    day_name character varying,
    month_name character varying,
    is_weekend boolean,
    weekof_year integer,
    dayof_year integer,
    isleap_year boolean,
    fiscal_year integer,
    fiscal_quarter integer,
    PRIMARY KEY (datekey)
);

CREATE TABLE IF NOT EXISTS finproDimBranches
(
    branch_id integer,
    branch_code character varying,
    branch_name character varying,
    PRIMARY KEY (branch_code)
);

CREATE TABLE IF NOT EXISTS finproDimCities
(
    city_id integer NOT NULL,
    city_code character varying,
    city_name character varying,
    PRIMARY KEY (city_id)
);

CREATE TABLE IF NOT EXISTS finproDimCountries
(
    country_id integer,
    country_name character varying,
    country_code character varying,
    continent character varying,
    PRIMARY KEY (country_name)
);

CREATE TABLE IF NOT EXISTS finproDimAccountTypes
(
    type_id bigint,
    type_name character varying,
    PRIMARY KEY (type_name)
);

CREATE TABLE IF NOT EXISTS finproDimCustomers
(
    cust_id integer,
    cust_name character varying,
    email character varying,
    dateofbirth date,
    account_id character varying,
    account_type character varying,
    branch_code character varying,
    country character varying,
    date_joined date,
    balance numeric,
    PRIMARY KEY (account_id)
);

CREATE TABLE IF NOT EXISTS finproFactTransactions
(
    transaction_id integer,
    account_id character varying,
    date_id character varying,
    transaction_type_id character varying,
    amount numeric,
    us_cities_id integer,
    PRIMARY KEY (transaction_id)
);

ALTER TABLE IF EXISTS finproDimCustomers
    ADD FOREIGN KEY (account_type)
    REFERENCES finproDimAccountTypes (type_name) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS finproDimCustomers
    ADD FOREIGN KEY (branch_code)
    REFERENCES finproDimBranches (branch_code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS finproDimCustomers
    ADD FOREIGN KEY (country)
    REFERENCES finproDimCountries(country_name) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS finproFactTransactions
    ADD FOREIGN KEY (date_id)
    REFERENCES finproDimDate (datekey) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS finproFactTransactions
    ADD FOREIGN KEY (us_cities_id)
    REFERENCES finproDimCities (city_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS finproFactTransactions
    ADD FOREIGN KEY (account_id)
    REFERENCES finproDimCustomers (account_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;