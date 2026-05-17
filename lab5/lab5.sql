CREATE TYPE status AS ENUM ('lesser', 'greater', 'supreme');

CREATE TABLE layer (
    Numerical_order SERIAL PRIMARY KEY,
    Amount_of_souls_inside BIGINT NOT NULL
);

CREATE TABLE demon (
    ID SERIAL PRIMARY KEY,
    Full_name VARCHAR(32) NOT NULL,
    Age INTEGER NOT NULL,
    Status_a status NOT NULL
);

CREATE TABLE soul (
    ID BIGINT PRIMARY KEY, 
    Full_name VARCHAR(32) NOT NULL,
    Date_of_arrival DATE NOT NULL
);

CREATE TABLE sin (
    ID SERIAL PRIMARY KEY,
    Name VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE soul_sin (
    soul_id BIGINT REFERENCES soul(ID),
    sin_id INTEGER REFERENCES sin(ID),
    PRIMARY KEY (soul_id, sin_id)
);

CREATE TABLE punishment (
    ID SERIAL PRIMARY KEY,
    name_of_punishment VARCHAR(50) NOT NULL,
    sin_id INTEGER REFERENCES sin(ID),
    performing_demon INTEGER REFERENCES demon(ID)
);