CREATE KEYSPACE Umugram
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

use Umugram;

CREATE TABLE User (
    id TEXT PRIMARY KEY, 
    username TEXT,
    email TEXT,
    password TEXT,
    birthday TIMESTAMP,
    profile MAP<TEXT, TEXT>,  
    followers SET<TEXT>,  
    following SET<TEXT>,  
    userComments LIST<TEXT>, 
    userPosts LIST<TEXT>, 
    create_at TIMESTAMP,
    update_at TIMESTAMP
);

CREATE TABLE Post (
    id TEXT PRIMARY KEY, 
    user_id TEXT,  
    caption TEXT,
    description TEXT,
    create_at TIMESTAMP,
    update_at TIMESTAMP,
    photoUrl TEXT, 
    videoUrl TEXT, 
    duration DOUBLE, 
    lastMinute DOUBLE 
);

CREATE TABLE Comment (
    id TEXT PRIMARY KEY, 
    text TEXT, 
    post_id TEXT, 
    replyTo_id TEXT, 
    user_id TEXT, 
    create_at TIMESTAMP,
    update_at TIMESTAMP
);



