CREATE TABLE person (
    person_id uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    name text
);

INSERT INTO person(name) VALUES ('pepe'),('luis')