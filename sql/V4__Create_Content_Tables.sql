
-- You can run this command using the newly created nucleus user:
-- psql -U nucleus -f <path to>/V4__Create_Content_Tables.sql

-- Information about resource ingested offline / created by the user
CREATE TABLE resource (
 id varchar(36) NOT NULL, 
 title varchar(5000) NOT NULL,
 description varchar(20000), 
 format resource_format NOT NULL, 
 thumbnail varchar(2000),
 url varchar(2000) NOT NULL, 
 sharing sharing_type NOT NULL, 
 created timestamp NOT NULL,
 modified timestamp NOT NULL, 
 accessed timestamp NOT NULL, 
 creator_id varchar(36) NOT NULL, 
 owner_id varchar(36) NOT NULL,
 is_frame_breaker boolean,
 is_broken boolean,
 is_deleted boolean,
 flag_report JSONB,
 metadata JSONB,
 PRIMARY KEY (id),
 UNIQUE (url)
);

-- Index on owner to improve query performance of queries that provides list of 
--resources for a given user
CREATE INDEX resource_owner_id_idx ON 
 resource (owner_id);

-- Index on owner and last modified to improve query performance of queries that 
--provides list of resources for a particular owner modified in a given timespan  
CREATE INDEX resource_owner_id_modified_idx ON 
 resource (owner_id, modified);

-- Information about question ingested offline / created by the user
CREATE TABLE question (
 id varchar(36) NOT NULL,
 type question_type NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 accessed timestamp NOT NULL,
 creator_id varchar(36) NOT NULL, 
 owner_id varchar(36) NOT NULL,
 title varchar(20000) NOT NULL, 
 explanation varchar(5000),
 hint JSONB NOT NULL,
 detail JSONB,
 answer JSONB NOT NULL,
 metadata JSONB,
 PRIMARY KEY (id)
);

-- Index on owner to improve query performance of queries that provides lists of 
--resources for a given user.  
CREATE INDEX question_owner_id_idx ON 
 question (owner_id);

-- Index on owner and last modified to improve query performance of queries that 
--provides list of questions for a particular owner modified in a given timespan.  
CREATE INDEX question_owner_id_modified_idx ON 
 resource (owner_id, modified);

-- Container for resources and/or questions with metadata information
CREATE TABLE collection (
 id varchar(36) NOT NULL, 
 title varchar(5000) NOT NULL, 
 creator_id varchar(36) NOT NULL,
 owner_id varchar(36) NOT NULL,
 created timestamp NOT NULL,
 modified timestamp NOT NULL,
 accessed timestamp NOT NULL,
 thumbnail varchar(2000) NOT NULL,
 sharing sharing_type NOT NULL, 
 learning_objective varchar(20000) NOT NULL, 
 flag_report JSONB, 
 comments_enabled boolean, 
 audience JSONB, 
 metadata JSONB, 
 collaborator JSONB,
 PRIMARY KEY (id)
); 

-- Index on owner to improve query performance of queries that lists of collections 
--for a given user.  
CREATE INDEX collection_owner_id_idx ON 
 collection (owner_id);

-- Index on owner and last modified to improve query performance of queries that 
--provides list of collections for a particular owner modified in a given timespan.  
CREATE INDEX collection_owner_id_modified_idx ON 
 collection (owner_id, modified);

-- Create inverted index on collaborators JSONB doc, so we can search for a given user if 
--she is collaborating on a particular collection and it needs to be shown in 
--her workspace.
CREATE INDEX collection_collaborator_gin ON collection 
 USING gin (collaborator jsonb_path_ops);

-- Container for a sequenced set of resources or questions belonging to a collection 
CREATE TABLE collection_item (
 id varchar(36) NOT NULL, 
 collection_id varchar(36) NOT NULL, 
 resource_id varchar(36), 
 question_id varchar(36),
 sequence_id smallint NOT NULL, 
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL, 
 modified timestamp NOT NULL, 
 accessed timestamp NOT NULL, 
 narration varchar(5000), 
 metadata JSONB,
 PRIMARY KEY (id)
 );

-- Index on collection id as we will be querying this table based on collection_id
CREATE INDEX collection_item_collection_id_idx ON 
 collection_item (collection_id);

-- Index on resource id 
CREATE INDEX collection_item_resource_id_idx ON 
 collection_item (resource_id);

-- Index on collection id and resource id combination for improving peformance of AND queries
CREATE INDEX collection_item_collection_id_resource_id_idx ON 
 collection_item (collection_id, resource_id);

-- Index on question id 
CREATE INDEX collection_item_question_id_idx ON 
 collection_item (question_id);

-- Index on collection id and question id combination for improving performance of AND queries 
CREATE INDEX collection_item_collection_id_question_id_idx ON 
 collection_item (collection_id, question_id);

-- Container for a questions with metadata and settings information 
CREATE TABLE assessment (
 id varchar(36) NOT NULL, 
 type JSONB,
 url varchar(2000), 
 title varchar(5000) NOT NULL,
 creator_id varchar(36) NOT NULL, 
 owner_id varchar(36) NOT NULL, 
 created timestamp NOT NULL, 
 modified timestamp NOT NULL,
 accessed timestamp NOT NULL,
 thumbnail varchar(2000), 
 sharing sharing_type NOT NULL, 
 learning_objective varchar(20000) NOT NULL,
 flag_report JSONB, 
 audience JSONB, 
 collaborator JSONB, 
 metadata JSONB,
 login_required boolean, 
 settings JSONB,
 PRIMARY KEY (id)
);

-- Index on owner to improve query performance of queries that lists of assessments 
--for a given user.  
CREATE INDEX assessment_owner_id_idx ON 
 assessment (owner_id);

-- Index on owner and last modified to improve query performance of queries that 
--provides list of assessments for a particular owner modified in a given timespan.  
CREATE INDEX assessment_owner_id_modified_idx ON 
 assessment (owner_id, modified);

-- Create inverted index on collaborators JSONB doc, so we can search for a given user if 
--she is collaborating on a particular assessment and it needs to be shown in 
--her workspace.
CREATE INDEX assessment_collaborator_gin ON assessment 
 USING gin (collaborator jsonb_path_ops);

-- Container for a sequenced set of questions belonging to an assessment 
CREATE TABLE assessment_item (
 id varchar(36) NOT NULL, 
 assessment_id varchar(36) NOT NULL,
 question_id varchar(36) NOT NULL,
 sequence_id smallint NOT NULL,
 creator_id varchar(36) NOT NULL,
 created timestamp NOT NULL,
 modified timestamp NOT NULL, 
 accessed timestamp NOT NULL,
 narration varchar(5000),
 PRIMARY KEY (id)
);

-- Index on assessment id as we will be querying this table based on that key
CREATE INDEX assessment_item_assessment_id_idx ON 
 assessment_item (assessment_id);

-- Index on question id 
CREATE INDEX assessment_item_question_id_idx ON 
 assessment_item (question_id);

-- Index on assessment id and question id combination for improving peformance of AND queries
CREATE INDEX assessment_item_assessment_id_question_id_idx ON 
 assessment_item (assessment_id, question_id);

-- Information for the user course with metadata 
CREATE TABLE course (
 id varchar(36) NOT NULL,
 title varchar(5000) NOT NULL,
 creator_id varchar(36) NOT NULL, 
 owner_id varchar(36) NOT NULL, 
 created timestamp NOT NULL, 
 modified timestamp NOT NULL,
 accessed timestamp NOT NULL,
 thumbnail varchar(2000), 
 sharing sharing_type NOT NULL,
 audience JSONB,
 metadata JSONB,
 collaborator JSONB,
 class_list JSONB,
 PRIMARY KEY (id)
);

-- Index on course owner to show list of course belonging to a user
CREATE INDEX course_owner_id_idx ON 
 course (owner_id);

-- Index on course owner to show list of course belonging to a user modified in 
--a given timespan
CREATE INDEX course_owner_id_modified_idx ON 
 course (owner_id, modified);

-- Create an inverted index on classes that this course is associated with. 
CREATE INDEX course_class_list_gin ON course 
 USING gin (class_list jsonb_path_ops);

-- Create an inverted index on collaborators on this course. 
CREATE INDEX course_collaborator_gin ON course 
 USING gin (collaborator jsonb_path_ops);

-- Container for user created course and unit information with metadata
CREATE TABLE course_unit(
 course_id varchar(36) NOT NULL,
 unit_id varchar(36) NOT NULL,
 title varchar(5000) NOT NULL,
 creator_id varchar(36) NOT NULL,
 owner_id varchar(36) NOT NULL,
 created timestamp NOT NULL,
 modified timestamp NOT NULL,
 accessed timestamp NOT NULL,
 big_ideas varchar(20000) NOT NULL,
 essential_questions varchar(20000) NOT NULL,
 metadata JSONB,
 sequence_id smallint NOT NULL, 
 PRIMARY KEY (course_id, unit_id)
);

-- Create index on course id to allow improved querying perf based on supplied course id
CREATE INDEX course_unit_course_id_idx ON 
 course_unit (course_id);

-- Container for user created course, unit and lesson information with metadata
CREATE TABLE course_unit_lesson(
 course_id varchar(36) NOT NULL,
 unit_id varchar(36) NOT NULL,
 lesson_id varchar(36) NOT NULL,
 title varchar(5000) NOT NULL,
 creator_id varchar(36) NOT NULL,
 owner_id varchar(36) NOT NULL,
 created	timestamp NOT NULL,
 modified timestamp NOT NULL,
 accessed timestamp NOT NULL,
 metadata JSONB,
 sequence_id smallint NOT NULL, 
 PRIMARY KEY (course_id, unit_id, lesson_id)
);

-- Create index on course id to allow improved querying perf based on supplied course id
CREATE INDEX course_unit_lesson_course_id_idx ON 
 course_unit_lesson (course_id);

-- Create index on course id to allow improved querying perf based on supplied course id and unit id
CREATE INDEX course_unit_lesson_course_id_unit_id_idx ON 
 course_unit_lesson (course_id, unit_id);

-- Container for user created course, unit and lesson and collection/assessment information with metadata
CREATE TABLE course_unit_lesson_collection_assessment (
 id varchar(36) NOT NULL, 
 course_id varchar(36) NOT NULL, 
 unit_id varchar(36) NOT NULL,
 lesson_id varchar(36) NOT NULL,
 collection_id varchar(36),
 assessment_id varchar(36),
 sequence_id smallint,
 PRIMARY KEY (id)
);
-- Create index on course, unit, lesson id to allow improved querying perf 
CREATE INDEX course_unit_lesson_collection_assessment_cul_id_idx ON 
 course_unit_lesson_collection_assessment (course_id, unit_id, lesson_id);

-- Create index on collection id to allow improved perf while joining based on collection_id 
CREATE INDEX course_unit_lesson_collection_assessment_collection_id_idx ON 
 course_unit_lesson_collection_assessment (collection_id);

-- Create index on assessment id to allow improved perf while joining based on assessment_id
CREATE INDEX course_unit_lesson_collection_assessment_assessment_id_idx ON 
 course_unit_lesson_collection_assessment (assessment_id);

