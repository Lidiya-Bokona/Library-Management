-- Step 1: Create the Database
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- Step 2: Create Members Table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    join_date DATE DEFAULT (CURRENT_DATE)
) ENGINE=InnoDB;

-- Step 3: Create MemberAddresses Table
CREATE TABLE MemberAddresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT UNIQUE NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    zip_code VARCHAR(10) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE CASCADE  -- If member is deleted, address is too.
) ENGINE=InnoDB;

-- Step 4: Create Authors Table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    bio TEXT,
    birth_year INT
) ENGINE=InnoDB;

-- Step 5: Create Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(13) UNIQUE NOT NULL,  -- Standard ISBN length
    publication_year INT,
    available_copies INT DEFAULT 1 CHECK (available_copies >= 0),
    total_copies INT DEFAULT 1
) ENGINE=InnoDB;

-- Step 6: Create BookAuthors Table
CREATE TABLE BookAuthors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
        ON DELETE CASCADE,  -- If book deleted, links are too.
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
        ON DELETE CASCADE   -- If author deleted, links are too.
) ENGINE=InnoDB;

-- Step 7: Create Loans Table
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    loan_date DATE DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE,  -- NULL if not returned
    status ENUM('Active', 'Overdue', 'Returned', 'Lost') DEFAULT 'Active',
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE RESTRICT,  -- Prevent deleting member with active loans.
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
        ON DELETE RESTRICT   -- Prevent deleting book in active loans.
) ENGINE=InnoDB;
