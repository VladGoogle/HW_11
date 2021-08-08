drop table if exists cars;
drop table if exists  company;
CREATE TABLE IF NOT EXISTS cars  (name varchar(100), price_usa float,price_ukr float, model varchar(50), year int);


CREATE TABLE if not exists company (name varchar(50) PRIMARY KEY unique, country varchar(100), year_est int);

INSERT INTO company (name, country, year_est) values ('hyundai', 'South Korea', 1967),  ('Toyota', 'Japan', 1937);


CREATE OR REPLACE FUNCTION set_price() RETURNS TRIGGER AS $$
BEGIN
NEW.price_ukr := NEW.price_usa * 27;
RETURN NEW;
end;
$$ LANGUAGE plpgsql;

create trigger ukr_price
    before insert or update on cars
                         for each row
                         execute procedure set_price();

INSERT INTO cars (name, price_usa, model, year) values ('santa fe', 20000, 'hyundai', 2018);

INSERT INTO cars (name, price_usa, model, year) values ('i30', 15000, 'hyundai', 2019),
                                                       ('i20', 12000, 'hyundai', 2018),
                                                       ('Tucson', 20000, 'hyundai', 2013),
                                                       ('Accent', 18000, 'hyundai', 2020),
                                                       ('Camry', 24000, 'Toyota', 2017),
                                                       ('RAV4', 22000, 'Toyota', 2015),
                                                       ('Land Cruiser', 30000, 'Toyota', 2014);


select * from cars;