create table lack_session.sessions (
   id VARCHAR(255) NOT NULL,
   session_data TEXT,
   created_at TIMESTAMP,
   updated_at TIMESTAMP,
   PRIMARY KEY (id)
);
