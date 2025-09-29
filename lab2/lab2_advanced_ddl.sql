
CREATE DATABASE university_main
	WITH OWNER = admin
	ENCODING = 'UTF8'
	TEMPLATE = template0;
CREATE DATABASE university_archive
	WITH CONNECTION LIMIT = 50
	TEMPLATE = template0;
CREATE DATABASE university_test
	WITH CONNECTION LIMIT = 10
	IS_TEMPLATE = true;



CREATE TABLESPACE student_data LOCATION '/data/students';
CREATE TABLESPACE course_data OWNER admin LOCATION '/data/courses';
CREATE DATABASE university_distributed
	ENCODING = 'UTF8'
	TABLESPACE = student_data;



	CREATE TABLE students(
	     student_id SERIAL PRIMARY KEY,
	     first_name VARCHAR(50),
	     last_name VARCHAR(50),
	     email VARCHAR(100),
     phone CHAR(15),
     date_of_birth date,
     enrollment_data date,
     gpa DECIMAL(10, 2),
     is_active BOOLEAN,
     graduation_year SMALLINT
 );
CREATE TABLE professors(
     proffessor_id SERIAL PRIMARY KEY,
     first_name VARCHAR(50),
     last_name VARCHAR(50),
     email VARCHAR(100),
     office_number VARCHAR(20),
     hire_date date,
     salary DECIMAL(18, 2),
     is_tenured BOOLEAN,
     years_experience INT
 );
CREATE TABLE courses(
      course_id SERIAL PRIMARY KEY,
      course_code CHAR(8),
      course_title VARCHAR(100),
      description TEXT,
      credits SMALLINT,
      max_enrollment INT,
      course_fee DECIMAL(10, 2),
      is_online BOOLEAN,
      created_at TIMESTAMP
  );
CREATE TABLE class_schedule(
     schedule_id SERIAL PRIMARY KEY,
     course_id INT,
     professor_id INT,
     classroom VARCHAR(20),
     class_date date,
     start_time TIME WITHOUT TIME ZONE,
     end_time TIME WITHOUT TIME ZONE,
     duration interval
 );
CREATE TABLE student_records(
      record_id SERIAL PRIMARY KEY,
      student_id INT,
      course_id INT,
      semester VARCHAR(20),
      year INT,
      grade CHAR(2),
      attendance_percentage DECIMAL(10, 1),
      submission_timestamp TIMESTAMP WITH TIME ZONE,
      last_updated TIMESTAMP WITH TIME ZONE
);



ALTER TABLE students
	ADD middle_name VARCHAR(30),
    ADD COLUMN student_status VARCHAR(20),
    ALTER COLUMN phone TYPE VARCHAR(20),
    ALTER COLUMN student_status SET DEFAULT 'ACTIVE',
    ALTER COLUMN gpa SET DEFAULT 0.00;
ALTER TABLE professors
    ADD COLUMN department_code CHAR(5),
    ADD COLUMN research_area TEXT,
    ALTER COLUMN years_experience TYPE SMALLINT,
    ALTER COLUMN is_tenured SET DEFAULT false,
    ADD COLUMN last_promotion_date date;
ALTER TABLE courses
    ADD COLUMN prerequisite_course_id INT,
    ADD COLUMN difficulty_level SMALLINT,
    ALTER COLUMN course_code TYPE VARCHAR(10),
    ALTER COLUMN credits SET DEFAULT 3,
    ADD COLUMN lab_required BOOLEAN DEFAULT false;
ALTER TABLE class_schedule
    ADD COLUMN room_capacity INT,
    DROP COLUMN duration,
    ADD COLUMN session_type VARCHAR(15),
    ALTER COLUMN classroom TYPE VARCHAR(30),
    ADD COLUMN equipment_needed TEXT;
 ALTER TABLE student_records
    ADD COLUMN extra_credit_points DECIMAL(10, 1),
    ALTER COLUMN grade TYPE VARCHAR(5),
    ALTER COLUMN extra_credit_points SET DEFAULT 0.0,
    ADD COLUMN final_exam_date DATE,
    DROP COLUMN last_updated;



CREATE TABLE departments(
     department_id SERIAL PRIMARY KEY,
     deparment_name VARCHAR(100),
     department_code CHAR(5),
     building VARCHAR(50),
     phone VARCHAR(15),
     budget DECIMAL(18, 2),
     established_year INT
);
CREATE TABLE library_books(
     book_id SERIAL PRIMARY KEY,
     isbn CHAR(13),
     title VARCHAR(200),
     author VARCHAR(100),
     publisher VARCHAR(100),
     publication_date DATE,
     price DECIMAL(10, 2),
     is_available BOOLEAN,
     acquisition_timestamp TIMESTAMP WITHOUT TIME ZONE
 );
CREATE TABLE student_book_loans(
     loan_id SERIAL PRIMARY KEY,
     student_id INT,
     book_id INT,
     loan_date DATE,
     due_date DATE,
     return_date DATE,
     fine_amount DECIMAL(10, 2),
     loan_status VARCHAR(20)
 );

ALTER TABLE professors
     ADD COLUMN department_id INT; 
ALTER TABLE students
     ADD COLUMN advisor_id INT;
ALTER TABLE courses
     ADD COLUMN department_id INT;

CREATE TABLE grade_scale(
     grade_id SERIAL PRIMARY KEY,
     letter_grade CHAR(2),
     min_percentage DECIMAL(3, 1),
     max_percentage DECIMAL(3, 1),
     gpa_points DECIMAL(10, 2)
 );
CREATE TABLE semester_calendar(
     semester_id SERIAL PRIMARY KEY,
     semester_name VARCHAR(20),
     academic_year INT,
     start_date DATE,
     end_date DATE,
     registration_deadline TIMESTAMP WITH TIME ZONE,
     is_current BOOLEAN
 );

DROP  TABLE IF EXISTS student_book_loans;
DROP  TABLE IF EXISTS library_books;
DROP  TABLE IF EXISTS grade_scale;
CREATE TABLE grade_scale(
     grade_id SERIAL PRIMARY KEY,
     letter_grade CHAR(2),
     min_percentage DECIMAL(3, 1),
     max_percentage DECIMAL(3, 1),
     gpa_points DECIMAL(10, 2),
     description TEXT
);
DROP TABLE semester_calendar CASCADE;
CREATE TABLE semester_calendar(
     semester_id SERIAL PRIMARY KEY,
     semester_name VARCHAR(20),
     academic_year INT,
     start_date DATE,
     end_date DATE,
     registration_deadline TIMESTAMP WITH TIME ZONE,
     is_current BOOLEAN
);



ALTER DATABASE university_test IS_TEMPLATE false;
DROP DATABASE IF EXISTS university_test;
DROP DATABASE IF EXISTS university_distributed;
CREATE DATABASE university_backup WITH TEMPLATE university_main;


-- additional tasks
-- A
CREATE DATABASE elearning_platform;
CREATE TABLESPACE video_storage LOCATION '/data/videos';


-- B
CREATE TABLE online_videos(
    video_id SERIAL,
    course_id INT,
    video_title VARCHAR(100),
    video_description TEXT,
    video_duration TIME WITHOUT TIME ZONE,
    file_size  BIGINT,
    upload_date DATE,
    is_public BOOLEAN,
    view_count INT
);
CREATE TABLE student_progress(
    progress_id SERIAL,
    student_id INT,
    video_id INT,
    watch_percentage DECIMAL(10, 1),
    last_watched TIMESTAMP WITH TIME ZONE,
    completed BOOLEAN,
    notes TEXT,
    bookmark_time TIME WITHOUT TIME ZONE
);



-- C
ALTER TABLE courses
    ADD COLUMN is_online_available BOOLEAN DEFAULT false,
    ADD COLUMN platform_url VARCHAR(200),
    ALTER COLUMN description SET DEFAULT 'No description available';
ALTER TABLE students
    ADD COLUMN preffered_language CHAR(5),
    ADD COLUMN last_login TIMESTAMP WITHOUT TIME ZONE;

-- D
CREATE TABLE quiz_attempts(
    id SERIAL PRIMARY KEY,
    student_id INT,
    Quiz_name VARCHAR(80),
    start_time TIMESTAMP WITHOUT TIME ZONE,
    duration INTERVAL,
    score DECIMAL(10, 2),
    passed BOOLEAN,
    attempt_number SMALLINT
);
