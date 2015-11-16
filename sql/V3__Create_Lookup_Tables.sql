
-- You can run this command using the newly created nucleus user:
-- psql -U nucleus -f <path to>/V3__Create_Lookup_Tables.sql


-- Taxonomy subject information 
CREATE TABLE taxonomy_subject (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 code varchar(2000), 
 name varchar(2000) NOT NULL, 
 description varchar(5000), 
 sequence_id smallint NOT NULL, 
 classification varchar(2000),
 PRIMARY KEY(id)
);


-- Taxonomy course information 
CREATE TABLE taxonomy_course (
 id varchar(36) NOT NULL,
 subject_id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 code varchar(2000), 
 name varchar(2000) NOT NULL, 
 description varchar(5000), 
 grades varchar(2000),
 sequence_id smallint NOT NULL, 
 PRIMARY KEY(id)
);

-- Index on subject_id to enhance query performance
CREATE INDEX taxonomy_course_subject_id_idx ON 
 taxonomy_course (subject_id);

-- Taxonomy domain information 
CREATE TABLE taxonomy_domain (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 code varchar(2000), 
 name varchar(2000) NOT NULL, 
 description varchar(5000), 
 sequence_id smallint NOT NULL, 
 PRIMARY KEY(id)
);

-- Mapping between taxonomy course and domain 
CREATE TABLE taxonomy_subdomain (
 id varchar(36) NOT NULL,
 course_id varchar(36) NOT NULL,
 domain_id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 code varchar(2000), 
 name varchar(2000) NOT NULL, 
 description varchar(5000), 
 sequence_id smallint NOT NULL, 
 PRIMARY KEY(id)
);

-- Index on course_id, domain_id to enhance query performance
CREATE INDEX taxonomy_subdomain_course_id_domain_id_idx ON 
 taxonomy_subdomain (course_id, domain_id);

-- Information about 21st century skills like critical thinking, 
--civic literacy and so on
CREATE TABLE twentyone_century_skill (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);

-- Information about whether the content is an article, book, game and so on
CREATE TABLE educational_use (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);


-- Information about whether the content is meant for extending understanding, 
--preparing the learning etc. 
-- Not sure if this needs to be deprecated (pending decision from Amara, Elaine) 
CREATE TABLE moments_of_learning (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);

-- Information about whether the question's depth of knowledge quotient whether 
--it is for recall, strategic thinking and so on
CREATE TABLE depth_of_knowledge (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);


-- Information about whether the content intended to be consumed for a specific 
--grade level
CREATE TABLE reading_level (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);

-- Information about whether the content has some or more advertisements
CREATE TABLE advertisement_level (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);

-- Information about whether the content has flashing hazard, sound hazard etc.
CREATE TABLE hazard_level (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);


-- Information about whether the content has audio description, annotations etc. 
CREATE TABLE media_feature (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);


-- Information about whether the content is a video, webpage and so on
CREATE TABLE resource_format (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);

-- Information about whether the assessment is internal or external
CREATE TABLE assessment_type (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);

-- Information about whether the content is meant for all students, 
--specific students etc. 
CREATE TABLE audience (
 id varchar(36) NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 value JSONB NOT NULL, 
 PRIMARY KEY(id)
);

-- Supported question types
-- TBD use table instead with JSON value?
CREATE TYPE question_type AS ENUM ('multiple_choice', 'multiple_answer', 
'true_false', 'fill_in_the_blank', 'open_ended', 'hot_text_reorder', 
'hot_text_highlight',  'hot_spot_image', 'hot_spot_text');

-- Supported sharing types 
-- TBD use table instead with JSON value?
CREATE TYPE sharing_type AS ENUM ('private', 'shared', 'public');

-- Supported class member
-- TBD use table instead with JSON value? 
CREATE TYPE class_member_status AS ENUM ('invited', 'pending', 'joined');


 


