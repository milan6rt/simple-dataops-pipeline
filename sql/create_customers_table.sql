-- Simple customer table update test
-- Testing pipeline with a simple email update

-- Create customers table if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'customers' AND type = 'U')
BEGIN
    CREATE TABLE customers (
        CustomerID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) UNIQUE NOT NULL,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    
    INSERT INTO customers (Name, Email)
    VALUES 
        ('Alice Johnson', 'alice@example.com'),
        ('Bob Smith', 'bob@example.com'),
        ('Carol Davis', 'carol@example.com');
    
    PRINT 'SUCCESS: customers table created with initial data!';
END
ELSE
BEGIN
    PRINT 'INFO: customers table exists. Applying updates...';
    
    -- Simple update: Change Alice's email address
    UPDATE customers 
    SET Email = 'alice.johnson.@delphime.com'
    WHERE Name = 'Alice Johnson' AND Email != 'alice.johnson.@delphime.com';
    
    IF @@ROWCOUNT > 0
        PRINT 'SUCCESS: Updated Alice Johnson email address!';
    ELSE
        PRINT 'INFO: Alice email already updated or not found.';
END

-- Show current state
SELECT COUNT(*) as TotalCustomers FROM customers;
SELECT Name, Email FROM customers ORDER BY Name;