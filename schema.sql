CREATE TABLE country (
    name VARCHAR(255) NOT NULL,
    country_code VARCHAR(4) NOT NULL,
    capital VARCHAR(255),
    province VARCHAR(255),
    area INT UNSIGNED NOT NULL, 
    population INT UNSIGNED NOT NULL, 
    encompasses_continent VARCHAR(255) NOT NULL, 
    encompass_percentage INT UNSIGNED NOT NULL, 
    continent_area INT UNSIGNED NOT NULL,
	PRIMARY KEY (code, encompasses_continent),
    CHECK (encompass_percentage BETWEEN 0 AND 100)
);

CREATE TABLE country_other_localname (
	country_code VARCHAR(4) NOT NULL,
    localname VARCHAR(255) NOT NULL,
    othername VARCHAR(255),
    PRIMARY KEY (country),
    CONSTRAINT fk_countrylocal FOREIGN KEY (country) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE countrypopulations (
	country_code VARCHAR(4) NOT NULL,
    year INT NOT NULL,
    population INT UNSIGNED,
    PRIMARY KEY(country, year),
    CONSTRAINT fk_countrypop FOREIGN KEY (country) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE,
	CHECK (year <= 2023)
);
CREATE TABLE province (
    province_name VARCHAR(255) NOT NULL,
    country VARCHAR(4) NOT NULL,
    population INT UNSIGNED,
    area INT UNSIGNED NOT NULL,
    capital VARCHAR(255),
    capprov VARCHAR(255),
    PRIMARY KEY (name, country),
    CONSTRAINT fk_countrypro FOREIGN KEY (country) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE provincelocalname (
	province_name VARCHAR(255) NOT NULL,
    country VARCHAR(4) NOT NULL,
    localname VARCHAR(255) NOT NULL,
    PRIMARY KEY(province, country),
    CONSTRAINT fk_provincelocal FOREIGN KEY (province) REFERENCES province (name) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE provinceothername (
	province_name VARCHAR(255) NOT NULL,
    country VARCHAR(4) NOT NULL,
    othername VARCHAR(255) NOT NULL,
    PRIMARY KEY(province, country, othername),
    CONSTRAINT fk_provinceother FOREIGN KEY (province) REFERENCES province (name) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE provincepopulation (
	province_name VARCHAR(255) NOT NULL,
    country VARCHAR(4) NOT NULL,
    year INT NOT NULL,
    population INT UNSIGNED NOT NULL,
    PRIMARY KEY(province, country, year),
    CONSTRAINT fk_provincepop FOREIGN KEY (province) REFERENCES province (name) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (year <= 2023)
);

CREATE TABLE city (
    city_name VARCHAR(255) NOT NULL,
    country VARCHAR(4) NOT NULL,
    province VARCHAR(255),
    population INT UNSIGNED, 
    latitude DECIMAL(8,6) NOT NULL,
    longitude DECIMAL (8,6) NOT NULL,
    elevation INT UNSIGNED,
    PRIMARY KEY (name, latitude, longitude),
    CONSTRAINT fk_country FOREIGN KEY (country) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_province FOREIGN KEY (province) REFERENCES province (name) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (latitude BETWEEN -90 AND 90),
    CHECK (longitude BETWEEN -180 AND 180)
);

CREATE TABLE citylocalname (
	city_name VARCHAR(255) NOT NULL,
    country VARCHAR(4) NOT NULL,
    province VARCHAR(255) NOT NULL,
    localname VARCHAR(255) NOT NULL,
    PRIMARY KEY (city, province),
    CONSTRAINT fk_citylocal FOREIGN KEY (city) REFERENCES city (name) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE cityothername (
	city_name VARCHAR(100) NOT NULL,
    country VARCHAR(4) NOT NULL,
    province VARCHAR(100) NOT NULL,
    othername VARCHAR(255) NOT NULL,
    PRIMARY KEY (city, country, province, othername),
    CONSTRAINT fk_cityother FOREIGN KEY (city) REFERENCES city (name) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE citypopulations (
	city_name VARCHAR(255) NOT NULL,
    country VARCHAR(4) NOT NULL,
    province VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    population INT UNSIGNED NOT NULL,
    PRIMARY KEY (city, province, year), 
    CONSTRAINT fk_citypop FOREIGN KEY (city) REFERENCES city (name) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (year <= 2023)
);

CREATE TABLE airport (
    iatacode VARCHAR(3) NOT NULL,
    name VARCHAR(255) NOT NULL,
    country_code VARCHAR(4) NOT NULL,
    city VARCHAR(255),
    island VARCHAR(255),
	latitude DECIMAL(12,10) NOT NULL,
    longitude DECIMAL (11,8) NOT NULL,
    elevation INT,
    gmtoffset DECIMAL(8,6) NOT NULL,
    PRIMARY KEY (iatacode),
    CONSTRAINT fk_countryair FOREIGN KEY (country_code) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_cityair FOREIGN KEY (city) REFERENCES city (name) ON DELETE RESTRICT ON UPDATE CASCADE,
	CHECK (latitude BETWEEN -90 AND 90),
    CHECK (longitude BETWEEN -180 AND 180),
    CHECK (gmtoffset BETWEEN -12 AND 14)
);

CREATE TABLE organization (
	abbreviation VARCHAR(8) NOT NULL,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(255),
    country VARCHAR(4),
    province VARCHAR(255),
    established VARCHAR(10),
    PRIMARY KEY (abbreviation),
    CONSTRAINT fk_cityorg FOREIGN KEY (city) REFERENCES city (name) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE ismember (
	country VARCHAR(4) NOT NULL,
    organization VARCHAR(8) NOT NULL,
    type VARCHAR(255) NOT NULL,
    PRIMARY KEY (country, organization), 
    CONSTRAINT fk_countrymem FOREIGN KEY (country) REFERENCES country(code) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_organization FOREIGN KEY (organization) REFERENCES organization(abbreviation) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE borders (
	country_code VARCHAR(4) NOT NULL,
    country VARCHAR(4) NOT NULL,
    length INT UNSIGNED NOT NULL,
    PRIMARY KEY(country_code, country),
    CONSTRAINT fk_country1 FOREIGN KEY (country1) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_country2 FOREIGN KEY (country2) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE language (
	country_code VARCHAR(4) NOT NULL,
    language VARCHAR(255) NOT NULL,
    percentage DECIMAL(6,3),
    PRIMARY KEY(country, language),
    CONSTRAINT fk_countrylang FOREIGN KEY (country) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (percentage BETWEEN 0 AND 100.00)
);

CREATE TABLE economy (
	country_code VARCHAR(4) NOT NULL,
	gdp INT UNSIGNED,
    agriculture DECIMAL(5,2),
    service DECIMAL(5,2),
    industry DECIMAL(5,2),
    inflation DECIMAL(5,2),
    unemployment DECIMAL(5,2),
    PRIMARY KEY (country),
    CONSTRAINT fk_countryecon FOREIGN KEY (country) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (agriculture IS NULL OR agriculture BETWEEN 0 AND 100.00),
    CHECK (service IS NULL OR service BETWEEN 0 AND 100.00),
    CHECK (industry IS NULL OR industry BETWEEN 0 AND 100.00)
);

CREATE TABLE ethnicgroup (
	country_code VARCHAR(4) NOT NULL,
    ethnic_group_name VARCHAR(255) NOT NULL,
    ethnic_group_percentage DECIMAL(6,3),
    PRIMARY KEY (country, ethnic_group_name),
    CONSTRAINT fk_countryethnic FOREIGN KEY (country) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (ethnic_group_percentage IS NULL OR ethnic_group_percentage BETWEEN 0 AND 100.00)
);

CREATE TABLE religion (
	country_code VARCHAR(4) NOT NULL,
    name VARCHAR(255) NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (country,name),
    CONSTRAINT fk_countryrel FOREIGN KEY (country) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (percentage BETWEEN 0 AND 100.00)
);

CREATE TABLE politics (
	country_code VARCHAR(4) NOT NULL,
    independence VARCHAR(10),
    wasdependent VARCHAR(255),
    dependent VARCHAR(4),
    government VARCHAR(255),
    PRIMARY KEY (country),
    CONSTRAINT fk_countrypol FOREIGN KEY (country) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE populations (
	country_code VARCHAR(4) NOT NULL,
    province VARCHAR(255),
    population_growth DECIMAL(5,2),
    infant_mortality DECIMAL(5,2),
    PRIMARY KEY (country),
    CONSTRAINT fk_countrypopulation FOREIGN KEY (country) REFERENCES country (code) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (population_growth IS NULL OR population_growth BETWEEN -100.00 AND 100.00)
);

CREATE TABLE located_on (
	city_name VARCHAR(255) NOT NULL, 
    province VARCHAR(255) NOT NULL,
    country VARCHAR(4) NOT NULL,
    island VARCHAR(255) NOT NULL,
    PRIMARY KEY (city, province, country, island),
    CONSTRAINT fk_citylocation FOREIGN KEY (city) REFERENCES city (name) ON DELETE RESTRICT ON UPDATE CASCADE
);



