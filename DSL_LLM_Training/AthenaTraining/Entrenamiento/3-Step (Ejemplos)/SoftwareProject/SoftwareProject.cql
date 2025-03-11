CREATE KEYSPACE SoftwareProject 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

USE SoftwareProject;

CREATE TABLE Developer (
    id TEXT PRIMARY KEY,
    email TEXT,
    dev_info_name TEXT,
    dev_info_team TEXT,
    dev_info_about_me TEXT,
    permissions TEXT,
    is_active BOOLEAN,
    suspended_acc TEXT
);


CREATE TABLE Repository (
    id TEXT PRIMARY KEY,
    title TEXT,
    url TEXT,
    developers LIST<TEXT>,
    requests LIST<FROZEN<TUPLE<TEXT, TEXT, INT>>>,
    tags LIST<TEXT>,
    num_forks INT,
    num_stars INT,
    created_time TIMESTAMP,
    last_activity_date TIMESTAMP
);

CREATE TABLE Ticket (
    id TEXT PRIMARY KEY,
    message TEXT,
    repository_id TEXT,
    developer_id TEXT,
    num_forks INT,
    num_stars INT,
    created_time TIMESTAMP,
    last_activity_date TIMESTAMP
);

CREATE TABLE Project (
    id TEXT PRIMARY KEY,  
    name TEXT,
    due_date TIMESTAMP,
    developers SET<TEXT>,  
    repositories SET<TEXT> 
);

CREATE TABLE ProjectManager (
    id TEXT PRIMARY KEY,  
    in_active BOOLEAN,
    managed_projects INT
);

CREATE TABLE ProjectDeveloper (
    id TEXT PRIMARY KEY,  
    languages SET<TEXT>,  
    solved_tickets SET<TEXT>  
);
