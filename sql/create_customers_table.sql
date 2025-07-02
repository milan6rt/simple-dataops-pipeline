--test 1
-- Simple customer table creation script
-- This will be executed automatically when changes are pushed to GitHub

-- Create customers table if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'customers' AND type = 'U')
BEGIN
    CREATE TABLE customers (
        CustomerID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) UNIQUE NOT NULL,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    
    PRINT 'SUCCESS: customers table created successfully!';
END
ELSE
BEGIN
    PRINT 'INFO: customers table already exists - no changes needed.';
END

-- Insert sample data if table is empty
IF NOT EXISTS (SELECT * FROM customers)
BEGIN
    INSERT INTO customers (Name, Email)
    VALUES 
        ('Milan Johnson', 'alice@example.com'),
        ('Bob Smith', 'bob@example.com'),
        ('Carol Davis', 'carol@example.com');
    
    PRINT 'SUCCESS: Sample customer data inserted!';
END
ELSE
BEGIN
    PRINT 'INFO: customers table already contains data - skipping insert.';
END

-- Show results
SELECT COUNT(*) as TotalCustomers FROM customers;
SELECT TOP 3 * FROM customers ORDER BY CreatedDate DESC;
