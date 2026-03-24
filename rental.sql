create database vehiclerent;
drop database vehicle
USE vehiclerent;

-- Add owner column to vehicles table if it doesn't exist
ALTER TABLE vehicles ADD COLUMN IF NOT EXISTS owner VARCHAR(50) AFTER status;

-- Or if you want to recreate the table (this will delete existing data)
-- First, drop existing tables in correct order
-- DROP TABLE IF EXISTS bookings;
-- DROP TABLE IF EXISTS vehicles;
-- DROP TABLE IF EXISTS users;

-- Then recreate tables with all columns
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS vehicles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(100) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    price_per_day DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'available',
    owner VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner) REFERENCES users(username) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    vehicle_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE
);

-- Insert sample data
INSERT INTO users (username, password, email, phone, role) VALUES 
('admin', 'admin123', 'admin@example.com', '1234567890', 'admin'),
('customer', 'customer123', 'customer@example.com', '0987654321', 'customer'),
('owner', 'owner123', 'owner@example.com', '5551234567', 'owner')
ON DUPLICATE KEY UPDATE username=username;

-- Insert sample vehicles with owner column
INSERT INTO vehicles (model, brand, year, price_per_day, status, owner) VALUES
('Camry', 'Toyota', 2022, 50.00, 'available', 'admin'),
('Accord', 'Honda', 2021, 45.00, 'available', 'admin'),
('Mustang', 'Ford', 2023, 80.00, 'available', 'admin'),
('X5', 'BMW', 2023, 120.00, 'available', 'owner'),
('C-Class', 'Mercedes', 2022, 110.00, 'available', 'owner');