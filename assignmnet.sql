-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    location VARCHAR(50)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Create Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Create Order_Items table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert sample data into the tables
INSERT INTO Customers (customer_id, name, email, location) VALUES
(1, 'John Doe', 'john@example.com', 'New York'),
(2, 'Jane Smith', 'jane@example.com', 'Los Angeles');

INSERT INTO Categories (category_id, name) VALUES
(1, 'Electronics'),
(2, 'Clothing');

INSERT INTO Products (product_id, name, description, price, category_id) VALUES
(1, 'Smartphone', 'High-end smartphone', 799.99, 1),
(2, 'Laptop', 'Powerful laptop', 1299.99, 1),
(3, 'T-shirt', 'Cotton T-shirt', 19.99, 2);

INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(101, 1, '2023-01-15', 799.99),
(102, 1, '2023-02-20', 1299.99),
(103, 2, '2023-03-10', 19.99);

INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1001, 101, 1, 1, 799.99),
(1002, 102, 2, 1, 1299.99),
(1003, 103, 3, 2, 19.99);




--Task1
SELECT
    c.customer_id,
    c.name AS customer_name,
    c.email,
    c.location,
    COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.email, c.location
ORDER BY total_orders DESC;


--Task2

SELECT
    o.order_id,
    p.name AS product_name,
    oi.quantity,
    oi.quantity * p.price AS total_amount
FROM Order_Items oi
INNER JOIN Orders o ON oi.order_id = o.order_id
INNER JOIN Products p ON oi.product_id = p.product_id
ORDER BY o.order_id ASC;

--Task3
SELECT
    c.name AS category_name,
    SUM(oi.quantity * p.price) AS total_revenue
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY c.name
ORDER BY total_revenue DESC;

--Task4
SELECT
    c.name AS customer_name,
    SUM(oi.quantity * p.price) AS total_purchase_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
LEFT JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.name
ORDER BY total_purchase_amount DESC
LIMIT 5;
