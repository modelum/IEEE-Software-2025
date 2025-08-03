CREATE TABLE Developer (
    id VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    permissions VARCHAR(3) NOT NULL,
    is_active BOOLEAN NULL,  
    suspended_acc VARCHAR(255) NULL,
    CONSTRAINT developer_pk PRIMARY KEY (id),
    CONSTRAINT email_check CHECK (email REGEXP '^.+@.+\\.com$'),
    CONSTRAINT permissions_check CHECK (permissions IN ('R', 'W', 'X', 'RW', 'RX', 'WX', 'RWX')),
    CONSTRAINT suspended_acc_check CHECK (suspended_acc IN ('true', 'false'))
);

CREATE TABLE DeveloperInfo (
    developer_id VARCHAR(255) NOT NULL,
    about_me VARCHAR(255) NULL,
    name VARCHAR(255) NOT NULL,
    team VARCHAR(255) NOT NULL,
    CONSTRAINT developer_info_pk PRIMARY KEY (developer_id),
    CONSTRAINT developer_info_fk_developer FOREIGN KEY (developer_id) REFERENCES Developer(id),
    CONSTRAINT name_check CHECK (name REGEXP '^[A-Z][a-z]*$')
);

CREATE TABLE Repository (
    id VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    tags JSON DEFAULT NULL, 
    num_forks INT NOT NULL,
    num_stars INT NOT NULL,
    created_time TIMESTAMP NOT NULL,
    last_activity_date TIMESTAMP NOT NULL,
    CONSTRAINT repository_pk PRIMARY KEY (id),
    CONSTRAINT num_forks_check CHECK (num_forks BETWEEN 0 AND 1000),
    CONSTRAINT num_stars_check CHECK (num_stars BETWEEN 0 AND 1000)
);

CREATE TABLE Developer_Repository (
    developer_id VARCHAR(255) NOT NULL,
    repository_id VARCHAR(255) NOT NULL,
    CONSTRAINT developer_repository_pk PRIMARY KEY (developer_id, repository_id),
    CONSTRAINT developer_repository_fk_developer FOREIGN KEY (developer_id) REFERENCES Developer(id),
    CONSTRAINT developer_repository_fk_repository FOREIGN KEY (repository_id) REFERENCES Repository(id)
);

CREATE TABLE Requests (
    repository_id VARCHAR(255) NOT NULL,
    branch VARCHAR(255) NOT NULL,
    status ENUM('Open', 'Closed') NOT NULL,
    numLabels INT NOT NULL,
    CONSTRAINT requests_pk PRIMARY KEY (repository_id, branch),
    CONSTRAINT requests_fk_repository FOREIGN KEY (repository_id) REFERENCES Repository(id)
);

CREATE TABLE Ticket (
    id VARCHAR(255) NOT NULL,
    message VARCHAR(255) NOT NULL,
    repository_id VARCHAR(255) NOT NULL,
    developer_id VARCHAR(255) NOT NULL,
    num_forks INT NOT NULL,
    num_stars INT NOT NULL,
    created_time TIMESTAMP NOT NULL,
    last_activity_date TIMESTAMP NOT NULL,
    CONSTRAINT ticket_pk PRIMARY KEY (id),
    CONSTRAINT ticket_fk_repository FOREIGN KEY (repository_id) REFERENCES Repository(id),
    CONSTRAINT ticket_fk_developer FOREIGN KEY (developer_id) REFERENCES Developer(id),
    CONSTRAINT num_forks_check CHECK (num_forks BETWEEN 0 AND 1000),
    CONSTRAINT num_stars_check CHECK (num_stars BETWEEN 0 AND 1000)
);
