CREATE TYPE status as ENUM ('lesser', "greater", "supreme")

CREATE TABLE layer(
    Numerical_order SERIAL PRIMARY KEY
    Amount_of_souls_inside INT NOT NULL 
)

CREATE TABLE demon(
    ID SERiAL PRIMARY KEY 
    Full_name VARCHAR(32) NOT NULL
    Age DATE NOT NULL
    Status_a NOT NUll status
)

CREATE TABLE soul(
    ID SERIAL PRIMARY KEY
    Full_name VARCHAR(32) NOT NULL
    Sin VARCHAR(32) NOT NULL
    Date_of_arrival DATE NOT NULL
)

CREATE TABLE punisment(
    ID SERIAL PRIMARY KEY
    name_of_punishment VARCHAR(25) NOT NUll
    required_sin varchar(16) NOT NULL
    performing_demon INTEGER REFERENCES demon(ID)
)
