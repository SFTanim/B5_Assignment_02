-- Active: 1747407668856@@127.0.0.1@5432@conservation_db

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY UNIQUE,
    name VARCHAR(100),
    region VARCHAR(100)
);
INSERT INTO rangers (name, region) VALUES
('Mary Livingston', 'Whitehaven'),
('Kenneth Wilson', 'West Madison'),
('Julie Hicks', 'Lake Elizabeth'),
('Kevin Robinson', 'Grimesbury'),
('Amanda Murphy', 'East Amy'),
('Angela Ford', 'Paultown'),
('Tara Marshall', 'Williammouth'),
('Peter Rodriguez', 'Evansmouth'),
('James Jenkins', 'Lake Nicole'),
('Patricia Crawford', 'Lake Christopher');

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY UNIQUE,
    common_name VARCHAR(100), 
    scientific_name VARCHAR(100),
    discovery_date DATE,
    conservation_status VARCHAR(50) 
);
INSERT INTO species (
    common_name,
    scientific_name,
    discovery_date,
    conservation_status
) 
VALUES 
('Green Sea Turtle', 'Chelonia mydas', '1894-02-07', 'Vulnerable'),
('Asian Elephant', 'Elephas maximus', '1954-06-16', 'Endangered'),
('Grey Wolf', 'Canis lupus', '1999-11-06', 'Endangered'),
('Blue Whale', 'Balaenoptera musculus', '1891-01-05', 'Endangered'),
('Brown Bear', 'Ursus arctos', '1906-06-14', 'Critically Endangered'),
('Cheetah', 'Acinonyx jubatus', '1896-12-07', 'Vulnerable'),
('Snow Leopard', 'Panthera uncia', '1983-04-10', 'Critically Endangered'),
('Red Deer', 'Cervus elaphus', '1931-07-28', 'Endangered'),
('Hawksbill Turtle', 'Eretmochelys imbricata', '1908-10-30', 'Critically Endangered'),
('Orangutan', 'Pongo pygmaeus', '1760-11-12', 'Critically Endangered'),
('Giant Panda', 'Ailuropoda melanoleuca', '1914-04-21', 'Vulnerable'),
('African Lion', 'Panthera leo', '1961-02-27', 'Vulnerable'),
('Red Panda', 'Ailurus fulgens', '1720-05-14', 'Endangered'),
('Indian Cobra', 'Naja naja', '1929-06-05', 'Near Threatened'),
('Timber Wolf', 'Canis lycaon', '1966-07-14', 'Least Concern');

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY UNIQUE,
    ranger_id INTEGER REFERENCES rangers (ranger_id) ON DELETE RESTRICT,
    species_id INTEGER REFERENCES species (species_id) ON DELETE RESTRICT,
    sighting_time TIMESTAMP,
    location VARCHAR(100),
    notes TEXT
);
INSERT INTO sightings (
    ranger_id,
    species_id,
    sighting_time,
    location,
    notes
)
VALUES 
(5, 2, '2024-06-15 12:45:33', '8720 Elephant Pass, South Thomas, CA 91045', 'Herd of elephants moving across dry plain.'),
(7, 3, '2023-08-18 15:22:10', '1011 Wolf Creek, West Rachel, MT 59019', 'Pack of wolves howling at dusk.'),
(2, 4, '2024-09-05 18:59:43', '445 Whale Way, Port Isla, WA 98123', 'Large whale spouted twice, moving west.'),
(9, 6, '2024-07-03 09:08:27', '567 Cheetah Hollow, North Wanda, TX 75429', 'Cheetah observed sprinting across savanna.'),
(1, 7, '2023-10-21 05:44:15', '7622 Leopard Point, West Tracyland, AZ 85012', 'Elusive leopard seen near rocky cliff.'),
(4, 8, '2024-04-30 17:30:09', '391 Deer Grove, Lake Nina, NE 68124', 'Group of deer grazing in open meadow.'),
(8, 9, '2023-06-14 13:19:55', '105 Turtle Nest, East Adrian, NC 27513', 'Shell fragments found along beach.'),
(10, 10, '2024-02-22 20:12:33', '7341 Orangutan Bend, West Patrickville Pass, OR 97461', 'Orangutan seen swinging across canopy.'),
(3, 11, '2024-11-03 16:17:01', '258 Panda Track, North Dawn, NH 03452', 'Panda observed munching on bamboo.'),
(6, 12, '2024-08-12 07:56:22', '824 Lion Rock, Lake Brittany, KS 67501', 'Lion pride resting under trees.'),
(2, 13, '2023-05-19 04:34:47', '9267 Panda Rise, South Donnaborough Passing , LA 70023', 'Red panda seen climbing low branches.'),
(1, 14, '2025-01-07 22:08:05', '431 Cobra Way, West Ericstad, IN 46077 Passes', 'Cobra spotted slithering under rock.'),
(8, 15, '2024-12-01 10:41:17', '3987 Wolf Hollow, North Abigail, FL 33617', 'Timber wolf heard howling before dawn.'),
(4, 3, '2024-03-15 13:00:00', '1213 Dusk Trail, South Michael, IL 61254', 'Single wolf tracked for several hours.'),
(9, 12, '2023-07-07 18:33:20', '6229 Savannah View, North Susan, OK 73101', 'Lion cubs playing under watchful mother.'),
(7, 10, '2023-09-29 09:18:18', '8794 Ape Hollow, North Zachary, MO 64093', 'Orangutan mimic observed using tool.');


-- Problem 01 
INSERT INTO rangers (name, region) VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 02
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- Problem 03 
SELECT * FROM sightings WHERE location ~* '\mPass\M';

-- Problem 04 
SELECT name as "name", count(*) as "total_sightings" FROM sightings NATURAL join rangers GROUP BY name;

SELECT name, count(sighting_id) as total_sightings FROM rangers LEFT JOIN sightings on rangers.ranger_id = sightings.ranger_id GROUP BY name;

-- Problem 05 
SELECT common_name FROM species LEFT JOIN sightings ON species.species_id = sightings.species_id WHERE sightings.sighting_id IS NULL;

-- Problem 06 
SELECT common_name, sighting_time, name FROM sightings NATURAL JOIN species NATURAL JOIN rangers ORDER BY sighting_time DESC LIMIT 2;

-- Problem 07 
UPDATE species set conservation_status = 'Historic' WHERE extract(year from discovery_date) < 1800;

-- Problem 08 
SELECT sighting_id, 
CASE
WHEN extract(hour from sighting_time) < 12 THEN 'Morning'
WHEN extract(hour from sighting_time) >= 12 and extract(hour from sighting_time) < 17 THEN 'Afternoon'
WHEN extract(hour from sighting_time) >= 17 THEN 'Evening'
ELSE '' 
END AS time_of_day
FROM sightings;

-- Problem 09 
DELETE FROM rangers where ranger_id in (SELECT rangers.ranger_id FROM rangers LEFT join sightings on rangers.ranger_id = sightings.ranger_id WHERE sighting_id is null);

