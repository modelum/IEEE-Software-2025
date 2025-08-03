CREATE TABLE User (
    id VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    birthday TIMESTAMP NOT NULL,
    nameProfile VARCHAR(255) NOT NULL,
    avatar_url VARCHAR(255) NULL,
    description VARCHAR(255) NULL,
    website VARCHAR(255) NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (id),
    CONSTRAINT user_uk_username UNIQUE(username),
    CONSTRAINT user_uk_email UNIQUE(email),
    CONSTRAINT email_check CHECK (email REGEXP '^.+@.+\\.com$')
);

CREATE TABLE Followers (
    follower_id VARCHAR(255) NOT NULL,
    following_id VARCHAR(255) NOT NULL,
    PRIMARY KEY (follower_id, following_id),
    FOREIGN KEY (follower_id) REFERENCES User(id),
    FOREIGN KEY (following_id) REFERENCES User(id)
);

CREATE TABLE Post (
    id VARCHAR(255) NOT NULL,
    caption VARCHAR(255) NULL,
    description VARCHAR(255) NULL,
    user_id VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    CONSTRAINT post_pk PRIMARY KEY (id),
    CONSTRAINT post_fk_user FOREIGN KEY (user_id) REFERENCES User(id) 
);

CREATE TABLE VideoPost (
    id VARCHAR(255) NOT NULL,
    videoUrl VARCHAR(255) NOT NULL,
    duration DOUBLE NOT NULL,
    lastMinute DOUBLE NOT NULL,
    CONSTRAINT videopost_pk PRIMARY KEY (id),
    CONSTRAINT videopost_fk_post FOREIGN KEY (id) REFERENCES Post(id) 
);

CREATE TABLE PhotoPost (
    id VARCHAR(255) NOT NULL,
    photoUrl VARCHAR(255) NOT NULL,
    CONSTRAINT photopost_pk PRIMARY KEY (id),
    CONSTRAINT photopost_fk_post FOREIGN KEY (id) REFERENCES Post(id) 
);

CREATE TABLE Comment (
    id VARCHAR(255) NOT NULL,
    text TEXT NOT NULL,
    post VARCHAR(255) NOT NULL,
    replyTo VARCHAR(255) NULL,
    user VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    CONSTRAINT comment_pk PRIMARY KEY (id),
    CONSTRAINT comment_fk_post FOREIGN KEY (post) REFERENCES Post(id) ON DELETE CASCADE,
    CONSTRAINT comment_fk_reply FOREIGN KEY (replyTo) REFERENCES Comment(id) ON DELETE CASCADE,
    CONSTRAINT comment_fk_user FOREIGN KEY (user) REFERENCES User(id) ON DELETE CASCADE
);
