CREATE KEYSPACE imdb WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE imdb;

CREATE TABLE movie (
  id INT PRIMARY KEY,
  title text,
  production_year smallint
);

CREATE TABLE person (
  id INT PRIMARY KEY,
  name text,
  gender text,
  birth_country text,
  birth_year smallint,
  death_year smallint,
  age_group text,
  death_cause text,
  height_group text
);

CREATE TABLE role (
  id INT PRIMARY KEY,
  role text
);

CREATE TABLE castinfo (
  movie_id INT,
  person_id INT,
  role_id INT,
  PRIMARY KEY ((movie_id), person_id, role_id)
);

CREATE TABLE genre (
  id INT PRIMARY KEY,
  name text
);

CREATE TABLE movietogenre (
  movie_id INT,
  genre_id INT,
  PRIMARY KEY ((movie_id), genre_id)
);

CREATE TABLE language (
  id INT PRIMARY KEY,
  name text
);

CREATE TABLE movietolanguage (
  movie_id INT,
  language_id INT,
  PRIMARY KEY ((movie_id), language_id)
);

CREATE TABLE country (
  id INT PRIMARY KEY,
  name text
);

CREATE TABLE movietocountry (
  movie_id INT,
  country_id INT,
  PRIMARY KEY ((movie_id), country_id)
);

CREATE TABLE company (
  id INT PRIMARY KEY,
  name text
);

CREATE TABLE production (
  movie_id INT,
  company_id INT,
  PRIMARY KEY ((movie_id), company_id)
);

CREATE TABLE distribution (
  movie_id INT,
  company_id INT,
  PRIMARY KEY ((movie_id), company_id)
);

CREATE TABLE certificate (
  id INT PRIMARY KEY,
  name text
);

CREATE TABLE movietocertificate (
  movie_id INT,
  certificate_id INT,
  PRIMARY KEY ((movie_id), certificate_id)
);
