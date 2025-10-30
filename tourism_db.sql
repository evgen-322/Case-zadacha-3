-- --------------------------------------------------------
-- SQL-скрипт: База данных "Туризм"
-- Кейс №3: Спроектирована база с 4 справочниками и 1 таблицей заказов
-- --------------------------------------------------------

-- Удаление базы (если существует), чтобы избежать конфликтов при повторном запуске
DROP DATABASE IF EXISTS tourism;

-- Создание базы данных
CREATE DATABASE tourism DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Используем базу
USE tourism;

-- 1. Справочник: Страны
CREATE TABLE countries (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 2. Справочник: Типы туров
CREATE TABLE tour_types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 3. Справочник: Клиенты
CREATE TABLE clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE
) ENGINE=InnoDB;

-- 4. Справочник: Услуги
CREATE TABLE services (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    service_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
) ENGINE=InnoDB;

-- 5. Таблица переменной информации: Заказанные туры
CREATE TABLE tours (
    tour_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    country_id INT NOT NULL,
    type_id INT NOT NULL,
    service_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (country_id) REFERENCES countries(country_id) ON DELETE RESTRICT,
    FOREIGN KEY (type_id) REFERENCES tour_types(type_id) ON DELETE RESTRICT,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Наполнение справочников и тестовыми данными
-- --------------------------------------------------------

INSERT INTO countries (country_name) VALUES 
    ('Италия'),
    ('Турция'),
    ('Япония');

INSERT INTO tour_types (type_name) VALUES 
    ('Экскурсионный'),
    ('Пляжный'),
    ('Горнолыжный');

INSERT INTO clients (full_name, phone, email) VALUES 
    ('Иван Петров', '+79001234567', 'ivan@example.com'),
    ('Анна Сидорова', '+79109876543', 'anna@example.com');

INSERT INTO services (service_name, description) VALUES 
    ('Трансфер', 'Аэропорт ↔ Отель'),
    ('Медицинская страховка', 'Страховка на время поездки'),
    ('Экскурсия по городу', 'Гид + входные билеты');

INSERT INTO tours (client_id, country_id, type_id, service_id, start_date, end_date, price) VALUES 
    (1, 2, 2, 1, '2025-12-01', '2025-12-10', 85000.00),
    (2, 1, 1, 3, '2026-04-15', '2026-04-22', 120000.50);

