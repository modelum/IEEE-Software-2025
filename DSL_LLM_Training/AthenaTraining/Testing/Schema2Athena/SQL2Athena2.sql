CREATE TABLE movie (
  id INT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  production_year SMALLINT
);

CREATE TABLE person (
  id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  gender VARCHAR(10),
  birth_country VARCHAR(100),
  birth_year SMALLINT,
  death_year SMALLINT,
  age_group VARCHAR(50),
  death_cause VARCHAR(100),
  height_group VARCHAR(50)
);

CREATE TABLE role (
  id INT PRIMARY KEY,
  role VARCHAR(100) NOT NULL
);

CREATE TABLE castinfo (
  movie_id INT,
  person_id INT,
  role_id INT,
  PRIMARY KEY (movie_id, person_id, role_id),
  FOREIGN KEY (movie_id)  REFERENCES movie(id),
  FOREIGN KEY (person_id) REFERENCES person(id),
  FOREIGN KEY (role_id)   REFERENCES role(id)
);

CREATE TABLE genre (
  id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE movietogenre (
  movie_id INT,
  genre_id INT,
  PRIMARY KEY (movie_id, genre_id),
  FOREIGN KEY (movie_id) REFERENCES movie(id),
  FOREIGN KEY (genre_id) REFERENCES genre(id)
);

CREATE TABLE language (
  id INT PRIMARY KEY,
  name VARCHAR(80) NOT NULL
);

CREATE TABLE movietolanguage (
  movie_id INT,
  language_id INT,
  PRIMARY KEY (movie_id, language_id),
  FOREIGN KEY (movie_id)    REFERENCES movie(id),
  FOREIGN KEY (language_id) REFERENCES language(id)
);

CREATE TABLE country (
  id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE movietocountry (
  movie_id INT,
  country_id INT,
  PRIMARY KEY (movie_id, country_id),
  FOREIGN KEY (movie_id)  REFERENCES movie(id),
  FOREIGN KEY (country_id) REFERENCES country(id)
);

CREATE TABLE company (
  id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE production (
  movie_id INT,
  company_id INT,
  PRIMARY KEY (movie_id, company_id),
  FOREIGN KEY (movie_id)   REFERENCES movie(id),
  FOREIGN KEY (company_id) REFERENCES company(id)
);

CREATE TABLE distribution (
  movie_id INT,
  company_id INT,
  PRIMARY KEY (movie_id, company_id),
  FOREIGN KEY (movie_id)   REFERENCES movie(id),
  FOREIGN KEY (company_id) REFERENCES company(id)
);

CREATE TABLE certificate (
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE movietocertificate (
  movie_id INT,
  certificate_id INT,
  PRIMARY KEY (movie_id, certificate_id),
  FOREIGN KEY (movie_id)       REFERENCES movie(id),
  FOREIGN KEY (certificate_id) REFERENCES certificate(id)
);
