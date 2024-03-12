-- Drop schema if it exists
DROP SCHEMA IF EXISTS basic_library CASCADE;

-- Create the schema within the database
CREATE SCHEMA basic_library;

-- Set the search path to the basic_library schema
SET search_path TO basic_library;

-- Table: types
CREATE TABLE types (
    typeId SERIAL PRIMARY KEY,
    name VARCHAR(30)
);

-- Table: authors
CREATE TABLE authors (
    authorId SERIAL PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(70)
);

-- Table: students
CREATE TABLE students (
    studentId SERIAL PRIMARY KEY,
    name VARCHAR(20),
    surname VARCHAR(20),
    birthdate DATE,
    gender VARCHAR(10),
    class VARCHAR(7),
    point INT
);

-- Table: books
CREATE TABLE books (
    bookId SERIAL PRIMARY KEY,
    name VARCHAR(90),
    pagecount INT,
    point INT,
    authorId INT,
    typeId INT,
    FOREIGN KEY (authorId) REFERENCES basic_library.authors(authorId),
    FOREIGN KEY (typeId) REFERENCES basic_library.types(typeId)
);

-- Table: borrows
CREATE TABLE borrows (
    borrowId SERIAL PRIMARY KEY,
    studentId INT,
    bookId INT,
    takenDate TIMESTAMP,
    broughtDate TIMESTAMP,
    FOREIGN KEY (studentId) REFERENCES basic_library.students(studentId),
    FOREIGN KEY (bookId) REFERENCES basic_library.books(bookId)
);

ALTER TABLE basic_library.books ADD CONSTRAINT FK_books_authors FOREIGN KEY (authorId) REFERENCES basic_library.authors(authorId);
ALTER TABLE basic_library.books VALIDATE CONSTRAINT FK_books_authors;
ALTER TABLE basic_library.books ADD CONSTRAINT FK_books_types FOREIGN KEY (typeId) REFERENCES basic_library.types(typeId);
ALTER TABLE basic_library.books VALIDATE CONSTRAINT FK_books_types;
ALTER TABLE basic_library.borrows ADD CONSTRAINT FK_borrows_books FOREIGN KEY (bookId) REFERENCES basic_library.books(bookId);
ALTER TABLE basic_library.borrows VALIDATE CONSTRAINT FK_borrows_books;
ALTER TABLE basic_library.borrows ADD CONSTRAINT FK_borrows_students FOREIGN KEY (studentId) REFERENCES basic_library.students(studentId);
ALTER TABLE basic_library.borrows VALIDATE CONSTRAINT FK_borrows_students;