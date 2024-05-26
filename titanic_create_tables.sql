-- Drop existing tables if they exist to ensure a clean slate (optional)
DROP TABLE IF EXISTS people CASCADE;
DROP TABLE IF EXISTS lifeboats CASCADE;

-- Create the 'people' table
CREATE TABLE IF NOT EXISTS people (
    id SERIAL PRIMARY KEY,
    fam_name VARCHAR(100) NOT NULL,
    given_name VARCHAR(100) NOT NULL,
    age INT,
    class VARCHAR(20),
    sex VARCHAR(10),
    survived BOOLEAN,
    ticket VARCHAR(20),
    embarkation_port VARCHAR(20),
    profession VARCHAR(100),
    job_on_board VARCHAR(100),
    lifeboat VARCHAR(10),
    certain_on_lifeboat BOOLEAN,
    recovered_body BOOLEAN
);

-- Create the 'lifeboats' table
CREATE TABLE IF NOT EXISTS lifeboats (
    lifeboat_id SERIAL PRIMARY KEY,
    boat_name VARCHAR(50) NOT NULL,
    boat_info TEXT
);

-- Import data into the 'people' table
COPY people(fam_name, given_name, age, class, sex, survived, ticket, embarkation_port, profession, job_on_board, lifeboat, certain_on_lifeboat, recovered_body)
FROM 'C:\Users\user\Documents\titanic-for-data-eng-and-vis\titanic\people.csv'
WITH CSV HEADER;

-- Import data into the 'lifeboats' table
COPY lifeboats(boat_name, boat_info)
FROM 'C:\Users\user\Documents\titanic-for-data-eng-and-vis\titanic\lifeboats.csv'
WITH CSV HEADER;

-- Add FOREIGN KEY constraint for lifeboat if applicable
ALTER TABLE people
ADD CONSTRAINT fk_boat
FOREIGN KEY (lifeboat) REFERENCES lifeboats(boat_name);

-- Ensure SQLFluff compliance
-- SQLFluff configuration and checks should be done separately in your environment or CI/CD pipeline

-- Close the connection to the database
\q
