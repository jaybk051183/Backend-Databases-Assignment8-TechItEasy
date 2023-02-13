DROP TABLE IF EXISTS televisions CASCADE;
DROP TABLE IF EXISTS remote_controllers CASCADE;
DROP TABLE IF EXISTS cimodules CASCADE;
DROP TABLE IF EXISTS wallbrackets CASCADE;
DROP TABLE IF EXISTS televisions_wallbrackets CASCADE;

CREATE TABLE televisions (
                             id serial,
                             name varchar (255),
                             brand varchar (255),
                             price double precision,
                             type varchar (255) NOT NULL UNIQUE,
                             available double precision DEFAULT 0,
                             sold int,
                             refresh_rate double precision,
                             screen_type varchar(255),
                             PRIMARY KEY(id)
);

CREATE TABLE remote_controllers (
                                    id serial,
                                    name varchar (255),
                                    brand varchar (255),
                                    price double precision,
                                    available double precision DEFAULT 0,
                                    sold int,
                                    compatible_with varchar (255),
                                    battery_type varchar(255),
    --Omdat de foreign key van remote_controllers (compatible_with) een andere datatype is dan television id, dus int vs varchar, maken we een nieuwe kolom aan genaamd television_id van het datatype int.
                                    television_id int,
                                    PRIMARY KEY(id),
                                    FOREIGN KEY(television_id) REFERENCES televisions(id)
);

CREATE TABLE cimodules(
                          id serial,
                          name varchar (255) NOT NULL UNIQUE,
                          brand varchar (255),
                          price double precision,
                          available double precision DEFAULT 0,
                          sold int,
                          television_id int,
                          PRIMARY KEY(id),
                          FOREIGN KEY(television_id) REFERENCES televisions(id)
);

CREATE TABLE wallbrackets(
                             id serial,
                             name varchar (255) NOT NULL UNIQUE,
                             brand varchar (255),
                             price double precision,
                             available double precision DEFAULT 0,
                             sold int,
                             adjustable boolean,
                             PRIMARY KEY(id)
);

CREATE TABLE televisions_wallbrackets(
                                         television_id int,
                                         wallbracket_id int,
                                         FOREIGN KEY (television_id) REFERENCES televisions(id),
                                         FOREIGN KEY (wallbracket_id) REFERENCES wallbrackets(id)
);

INSERT INTO wallbrackets (id, name, adjustable, brand, price) VALUES (1001, 'LG small', false, 'LG bracket', 32.23);
INSERT INTO wallbrackets (id, name, adjustable, brand, price) VALUES (1002, 'LG big', true, 'LG bracket', 32.23);
INSERT INTO wallbrackets (id, name, adjustable, brand, price) VALUES (1003, 'Philips small', false, 'Philips bracket', 32.23);
INSERT INTO wallbrackets (id, name, adjustable, brand, price) VALUES (1004, 'Nikkei big', true, 'Nikkei bracket', 32.23);
INSERT INTO wallbrackets (id, name, adjustable, brand, price) VALUES (1005, 'Nikkei small', false, 'Nikkei bracket', 32.23);

INSERT INTO cimodules (name, price) VALUES ('universal CI-module', 32.5);

INSERT INTO remote_controllers (compatible_with, battery_type, name, brand, price, available,television_id) VALUES ('NH3216SMART', 'AAA', 'Nikkei HD smart TV controller', 'Nikkei', 12.99, 235885,1005);
INSERT INTO remote_controllers (compatible_with, battery_type, name, brand, price, available,television_id) VALUES ('43PUS6504/12/L', 'AA', 'Philips smart TV controller', 'Philips', 12.99, 235885,1002);
INSERT INTO remote_controllers (compatible_with, battery_type, name, brand, price, available,television_id) VALUES ('OLED55C16LA', 'AAA', 'OLED55C16LA TV controller', 'LG', 12.99, 235885,1003);

INSERT INTO televisions (id, type, brand, name, price, available, sold, refresh_rate, screen_type)
VALUES (1005,'NH3216SMART','Nikkei','HD smart TV',159,100,50,50,'HD');
INSERT INTO televisions (id, type, brand, name, price, available, sold, refresh_rate, screen_type)
VALUES (1002,'NH3200LED','LG','LED TV',250,150,51,55,'LED');
INSERT INTO televisions (id, type, brand, name, price, available, sold, refresh_rate, screen_type)
VALUES (1003,'NB6160OLED','Samsung','OLED TV',1500,50,10,110,'OLED');
INSERT INTO televisions (id, type, brand, name, price, available, sold, refresh_rate, screen_type)
VALUES (1004,'NH3277SMART','HP','smart TV',200,100,50,25,'normal');
INSERT INTO televisions (id, type, brand, name, price, available, sold, refresh_rate, screen_type)
VALUES (1001,'ND3212SMART','Toshiba','HD smart TV',300,100,50,45,'HD');

INSERT INTO televisions_wallbrackets(television_id, wallbracket_id) values (1005, 1001);
INSERT INTO televisions_wallbrackets(television_id, wallbracket_id) values (1005, 1002);
INSERT INTO televisions_wallbrackets(television_id, wallbracket_id) values (1002, 1003);
INSERT INTO televisions_wallbrackets(television_id, wallbracket_id) values (1003, 1003);
INSERT INTO televisions_wallbrackets(television_id, wallbracket_id) values (1004, 1003);
INSERT INTO televisions_wallbrackets(television_id, wallbracket_id) values (1001, 1004);
INSERT INTO televisions_wallbrackets(television_id, wallbracket_id) values (1001, 1005);

SELECT televisions.*, wallbrackets.*
FROM televisions
         INNER JOIN televisions_wallbrackets
                    ON televisions.id = televisions_wallbrackets.television_id
         INNER JOIN wallbrackets
                    ON televisions_wallbrackets.wallbracket_id = wallbrackets.id;

SELECT televisions.*, remote_controllers.*
FROM televisions
         INNER JOIN remote_controllers
                    ON televisions.id = remote_controllers.television_id;

SELECT televisions.*, cimodules.*
FROM televisions
         LEFT JOIN cimodules
                   ON televisions.id = cimodules.television_id;

SELECT televisions.*, wallbrackets.*, remote_controllers.*
FROM televisions
         INNER JOIN televisions_wallbrackets
                    ON televisions.id = televisions_wallbrackets.television_id
         INNER JOIN wallbrackets
                    ON televisions_wallbrackets.wallbracket_id = wallbrackets.id
         INNER JOIN remote_controllers
                    ON televisions.id = remote_controllers.television_id;



