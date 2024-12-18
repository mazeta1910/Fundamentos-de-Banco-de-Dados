DROP TABLE IF EXISTS dbo.customer;
CREATE TABLE dbo.customer (
    customer_id integer IDENTITY NOT NULL PRIMARY KEY,
    store_id integer NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    email character varying(50),
    address_id integer NOT NULL,
    activebool bit DEFAULT 1 NOT NULL,
    create_date date DEFAULT GETDATE() NOT NULL,
    last_update datetime2 DEFAULT GETDATE(),
    active integer
);

DROP TABLE IF EXISTS dbo.actor;
CREATE TABLE dbo.actor (
    actor_id integer IDENTITY NOT NULL PRIMARY KEY,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.category;
CREATE TABLE dbo.category (
    category_id integer IDENTITY NOT NULL PRIMARY KEY,
    name character varying(25) NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.film;
CREATE TABLE dbo.film (
    film_id integer IDENTITY NOT NULL PRIMARY KEY,
    title character varying(255) NOT NULL,
    description text,
    release_year integer CHECK ((release_year >= 1901) AND (release_year <= 2155)),
    language_id integer NOT NULL,
    rental_duration integer DEFAULT 3 NOT NULL,
    rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
    length integer,
    replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
    rating char(5) DEFAULT 'G',
    last_update datetime2 DEFAULT GETDATE() NOT NULL,
    special_features text,
    special_fields text NOT NULL
);

DROP TABLE IF EXISTS dbo.film_actor;
CREATE TABLE dbo.film_actor (
    actor_id integer NOT NULL,
    film_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL,
    CONSTRAINT pk_film_actor PRIMARY KEY(actor_id,film_id)
);

DROP TABLE IF EXISTS dbo.film_category;
CREATE TABLE dbo.film_category (
    film_id integer NOT NULL,
    category_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL,
    CONSTRAINT pk_film_category PRIMARY KEY(film_id,category_id)
);

DROP TABLE IF EXISTS dbo.address;
CREATE TABLE dbo.address (
    address_id integer IDENTITY NOT NULL PRIMARY KEY,
    address character varying(50) NOT NULL,
    address2 character varying(50),
    district character varying(20) NOT NULL,
    city_id integer NOT NULL,
    postal_code character varying(10),
    phone character varying(20) NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.city;
CREATE TABLE dbo.city (
    city_id integer IDENTITY NOT NULL PRIMARY KEY,
    city character varying(50) NOT NULL,
    country_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.country;
CREATE TABLE dbo.country (
    country_id integer IDENTITY NOT NULL PRIMARY KEY,
    country character varying(50) NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.inventory;
CREATE TABLE dbo.inventory (
    inventory_id integer IDENTITY NOT NULL PRIMARY KEY,
    film_id integer NOT NULL,
    store_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.language;
CREATE TABLE dbo.language (
    language_id integer IDENTITY NOT NULL PRIMARY KEY,
    name character(20) NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.payment;
CREATE TABLE dbo.payment (
    payment_id integer IDENTITY NOT NULL PRIMARY KEY,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date datetime2 NOT NULL
);

DROP TABLE IF EXISTS dbo.rental;
CREATE TABLE dbo.rental (
    rental_id integer IDENTITY NOT NULL PRIMARY KEY,
    rental_date datetime2 NOT NULL,
    inventory_id integer NOT NULL,
    customer_id integer NOT NULL,
    return_date datetime2,
    staff_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.staff;
CREATE TABLE dbo.staff (
    staff_id integer IDENTITY NOT NULL PRIMARY KEY,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    address_id integer NOT NULL,
    email character varying(50),
    store_id integer NOT NULL,
    active bit DEFAULT 1 NOT NULL,
    username character varying(16) NOT NULL,
    password character varying(40),
    last_update datetime2 DEFAULT GETDATE() NOT NULL,
    picture image
);

DROP TABLE IF EXISTS dbo.store;
CREATE TABLE dbo.store (
    store_id integer IDENTITY NOT NULL PRIMARY KEY,
    manager_staff_id integer NOT NULL,
    address_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);
GO

DROP TABLE IF EXISTS dbo.customer;
CREATE TABLE dbo.customer (
    customer_id integer IDENTITY NOT NULL PRIMARY KEY,
    store_id integer NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    email character varying(50),
    address_id integer NOT NULL,
    activebool bit DEFAULT 1 NOT NULL,
    create_date date DEFAULT GETDATE() NOT NULL,
    last_update datetime2 DEFAULT GETDATE(),
    active integer
);

DROP TABLE IF EXISTS dbo.actor;
CREATE TABLE dbo.actor (
    actor_id integer IDENTITY NOT NULL PRIMARY KEY,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.category;
CREATE TABLE dbo.category (
    category_id integer IDENTITY NOT NULL PRIMARY KEY,
    name character varying(25) NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.film;
CREATE TABLE dbo.film (
    film_id integer IDENTITY NOT NULL PRIMARY KEY,
    title character varying(255) NOT NULL,
    description text,
    release_year integer CHECK ((release_year >= 1901) AND (release_year <= 2155)),
    language_id integer NOT NULL,
    rental_duration integer DEFAULT 3 NOT NULL,
    rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
    length integer,
    replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
    rating char(5) DEFAULT 'G',
    last_update datetime2 DEFAULT GETDATE() NOT NULL,
    special_features text,
    special_fields text NOT NULL
);

DROP TABLE IF EXISTS dbo.film_actor;
CREATE TABLE dbo.film_actor (
    actor_id integer NOT NULL,
    film_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL,
    CONSTRAINT pk_film_actor PRIMARY KEY(actor_id,film_id)
);

DROP TABLE IF EXISTS dbo.film_category;
CREATE TABLE dbo.film_category (
    film_id integer NOT NULL,
    category_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL,
    CONSTRAINT pk_film_category PRIMARY KEY(film_id,category_id)
);

DROP TABLE IF EXISTS dbo.address;
CREATE TABLE dbo.address (
    address_id integer IDENTITY NOT NULL PRIMARY KEY,
    address character varying(50) NOT NULL,
    address2 character varying(50),
    district character varying(20) NOT NULL,
    city_id integer NOT NULL,
    postal_code character varying(10),
    phone character varying(20) NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.city;
CREATE TABLE dbo.city (
    city_id integer IDENTITY NOT NULL PRIMARY KEY,
    city character varying(50) NOT NULL,
    country_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.country;
CREATE TABLE dbo.country (
    country_id integer IDENTITY NOT NULL PRIMARY KEY,
    country character varying(50) NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.inventory;
CREATE TABLE dbo.inventory (
    inventory_id integer IDENTITY NOT NULL PRIMARY KEY,
    film_id integer NOT NULL,
    store_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.language;
CREATE TABLE dbo.language (
    language_id integer IDENTITY NOT NULL PRIMARY KEY,
    name character(20) NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.payment;
CREATE TABLE dbo.payment (
    payment_id integer IDENTITY NOT NULL PRIMARY KEY,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date datetime2 NOT NULL
);

DROP TABLE IF EXISTS dbo.rental;
CREATE TABLE dbo.rental (
    rental_id integer IDENTITY NOT NULL PRIMARY KEY,
    rental_date datetime2 NOT NULL,
    inventory_id integer NOT NULL,
    customer_id integer NOT NULL,
    return_date datetime2,
    staff_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);

DROP TABLE IF EXISTS dbo.staff;
CREATE TABLE dbo.staff (
    staff_id integer IDENTITY NOT NULL PRIMARY KEY,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    address_id integer NOT NULL,
    email character varying(50),
    store_id integer NOT NULL,
    active bit DEFAULT 1 NOT NULL,
    username character varying(16) NOT NULL,
    password character varying(40),
    last_update datetime2 DEFAULT GETDATE() NOT NULL,
    picture image
);

DROP TABLE IF EXISTS dbo.store;
CREATE TABLE dbo.store (
    store_id integer IDENTITY NOT NULL PRIMARY KEY,
    manager_staff_id integer NOT NULL,
    address_id integer NOT NULL,
    last_update datetime2 DEFAULT GETDATE() NOT NULL
);
GO

ALTER TABLE  dbo.customer
    ADD CONSTRAINT customer_address_id_fkey FOREIGN KEY (address_id) REFERENCES dbo.address(address_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.film_actor
    ADD CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES dbo.actor(actor_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.film_actor
    ADD CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (film_id) REFERENCES dbo.film(film_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.film_category
    ADD CONSTRAINT film_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES dbo.category(category_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.film_category
    ADD CONSTRAINT film_category_film_id_fkey FOREIGN KEY (film_id) REFERENCES dbo.film(film_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.film
    ADD CONSTRAINT film_language_id_fkey FOREIGN KEY (language_id) REFERENCES dbo.language(language_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.address
    ADD CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES dbo.city(city_id);

ALTER TABLE  dbo.city
    ADD CONSTRAINT fk_city FOREIGN KEY (country_id) REFERENCES dbo.country(country_id);

ALTER TABLE  dbo.inventory
    ADD CONSTRAINT inventory_film_id_fkey FOREIGN KEY (film_id) REFERENCES dbo.film(film_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.payment
    ADD CONSTRAINT payment_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES dbo.customer(customer_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.payment
    ADD CONSTRAINT payment_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES dbo.rental(rental_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.payment
    ADD CONSTRAINT payment_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES dbo.staff(staff_id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE  dbo.rental
    ADD CONSTRAINT rental_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES dbo.customer(customer_id) ON UPDATE CASCADE ON DELETE NO ACTION;
GO
ALTER TABLE  dbo.rental
    ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES dbo.inventory(inventory_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.rental
    ADD CONSTRAINT rental_staff_id_key FOREIGN KEY (staff_id) REFERENCES dbo.staff(staff_id);

ALTER TABLE  dbo.staff
    ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id) REFERENCES dbo.address(address_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.store
    ADD CONSTRAINT store_address_id_fkey FOREIGN KEY (address_id) REFERENCES dbo.address(address_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE  dbo.store
    ADD CONSTRAINT store_manager_staff_id_fkey FOREIGN KEY (manager_staff_id) REFERENCES dbo.staff(staff_id) ON UPDATE NO ACTION ON DELETE NO ACTION;
GO