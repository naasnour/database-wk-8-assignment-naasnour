-- Create the database
CREATE DATABASE IF NOT EXISTS art_gallery_db;
USE art_gallery_db;

-- Drop tables if they already exist (for re-runs)
DROP TABLE IF EXISTS artwork_exhibitions;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS artworks;
DROP TABLE IF EXISTS exhibitions;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS artists;

-- Artists table
CREATE TABLE artists (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    birth_year YEAR,
    UNIQUE (name)
);

-- Artworks table
CREATE TABLE artworks (
    artwork_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    artist_id INT,
    year_created YEAR,
    medium VARCHAR(100),
    price DECIMAL(10,2),
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

-- Exhibitions table
CREATE TABLE exhibitions (
    exhibition_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    UNIQUE(title, location)
);

-- Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address TEXT
);

-- Sales table (Many-to-One: each sale is linked to one artwork & one customer)
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    artwork_id INT NOT NULL,
    customer_id INT NOT NULL,
    sale_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (artwork_id) REFERENCES artworks(artwork_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Artwork_Exhibitions table (Many-to-Many: artworks shown in many exhibitions)
CREATE TABLE artwork_exhibitions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    artwork_id INT NOT NULL,
    exhibition_id INT NOT NULL,
    FOREIGN KEY (artwork_id) REFERENCES artworks(artwork_id),
    FOREIGN KEY (exhibition_id) REFERENCES exhibitions(exhibition_id),
    UNIQUE (artwork_id, exhibition_id)  -- prevent duplicate entries
);
