CREATE TABLE Faculty(
    id INT NOT NULL, 
    NAME varchar2(30) NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE Students(
    id INT NOT NULL,
    last_name VARCHAR2(60) NOT NULL,
    first_name VARCHAR2(30),
    group_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(group_id) REFERENCES GROUPS(id)
);

CREATE TABLE GROUPS(
    id INT NOT NULL,
    name VARCHAR2(10) NOT NULL,
    head_group INT,
    faculty_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(faculty_id) REFERENCES Faculty(id),
    FOREIGN KEY(head_group) REFERENCES Students(id)
);

CREATE TABLE Prepods(
    id INT NOT NULL,
    last_name VARCHAR2(120) NOT NULL,
    first_name VARCHAR2(120),
    faculty_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(faculty_id) REFERENCES Faculty(id)
);

CREATE TABLE TYPE_STUDY_LOAD(
    id NUMBER(10,0) NOT NULL,
    name VARCHAR2(120) NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE STUDY_LOAD(
    subject_id INT NOT NULL,
    type_study_id NUMBER(10,0) NOT NULL,
    hours INT,
    id CHAR(20) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(subject_id) REFERENCES Subjects(id),
    FOREIGN KEY(type_study_id) REFERENCES TYPE_STUDY_LOAD(id)
);

CREATE TABLE LESSONS(
    group_id INT NOT NULL,
    prepod_id INT NOT NULL,
    study_id CHAR(20) NOT NULL,
    PRIMARY KEY(group_id, prepod_id, study_id),
    FOREIGN KEY(group_id) REFERENCES GROUPS(id),
    FOREIGN KEY(prepod_id) REFERENCES Prepods(id),
    FOREIGN KEY(study_id) REFERENCES STADY_LOAD(subject_id)
);

CREATE TABLE RATING(
    id INT NOT NULL,
    DATE DATE NOT NULL,
    val INT,
    student_id INT NOT NULL,
    study_id CHAR(20) NOT NULL,
    prepods_id INT NOT NULL,
    is_absent CHAR(1) DEFAULT 'N',
    PRIMARY KEY(id),
    FOREIGN KEY(student_id) REFERENCES Students(id),
    FOREIGN KEY(study_id) REFERENCES STUDY_LOAD(id),
    FOREIGN key(prepods_id) REFERENCES Prepods(id)
);

CREATE TABLE Subjects(
    id NUMBER NOT NULL,
    name VARCHAR2(120) NOT NULL,
    faculty_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(faculty_id) REFERENCES Faculty(id)
);
