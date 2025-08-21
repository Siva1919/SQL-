create database shiva;                                -- Creating database
use shiva;                                            -- use database 
INSERT INTO Branches (BranchName, City, Address, ManagerName)
VALUES
('Central Branch', 'New York', '123 Wall Street, NY', 'John Doe'),
('Westside Branch', 'Los Angeles', '456 Sunset Blvd, LA', 'Jane Smith'),
('Downtown Branch', 'Chicago', '789 Michigan Ave, IL', 'Mike Johnson');
CREATE TABLE Branches (                               -- Create table for Branches
    BranchID INT PRIMARY KEY AUTO_INCREMENT,          -- Unique ID for each branch
    BranchName VARCHAR(100) NOT NULL,                 -- Name of the branch
    City VARCHAR(50),                                 -- City location
    Address TEXT,                                     -- Full address of branch
    ManagerName VARCHAR(100)                          -- Name of branch manager
);
-- Insert values into Branches table
INSERT INTO Branches (BranchName, City, Address, ManagerName)
VALUES
('Central Branch', 'New York', '123 Wall Street, NY', 'John Doe'),
('Westside Branch', 'Los Angeles', '456 Sunset Blvd, LA', 'Jane Smith'),
('Downtown Branch', 'Chicago', '789 Michigan Ave, IL', 'Mike Johnson');

CREATE TABLE Accounts (                               -- Create table for Accounts
    AccountID INT PRIMARY KEY AUTO_INCREMENT,         -- Unique account number
    CustomerID INT NOT NULL,                          -- Linked to a customer
    BranchID INT NOT NULL,                            -- Linked to the branch where opened
    AccountType ENUM('Savings', 'Checking') NOT NULL, -- Type of account
    Balance DECIMAL(12,2) DEFAULT 0.00,               -- Current account balance
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    -- When the account was created
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);             
-- Insert values into Accounts table
INSERT INTO Accounts (CustomerID, BranchID, AccountType, Balance)
VALUES
(1, 1, 'Savings', 1500.00),   -- Alice's savings at Central
(2, 2, 'Checking', 2200.00),  -- Bob's checking at Westside
(3, 3, 'Savings', 1000.00),   -- Charlie's savings at Downtown
(1, 2, 'Checking', 500.00);   -- Alice's second account at Westside
                                    

CREATE TABLE Transaction (                           	-- create table for Transactions
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,     -- Unique ID for transaction
    AccountID INT NOT NULL,                           -- The account where the transaction occurred
    TransactionType ENUM('Deposit', 'Withdrawal', 'Transfer') NOT NULL,
    Amount DECIMAL(12,2) NOT NULL CHECK (Amount > 0), -- Transaction amount
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    RelatedAccountID INT,                             -- For transfers: destination account
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (RelatedAccountID) REFERENCES Accounts(AccountID)
);
-- Deposit into Alice's Savings account (AccountID = 1)
INSERT INTO Transaction (AccountID, TransactionType, Amount)
VALUES (1, 'Deposit', 500.00);

-- Withdrawal from Bob's Checking account (AccountID = 2)
INSERT INTO Transaction (AccountID, TransactionType, Amount)
VALUES (2, 'Withdrawal', 300.00);

-- Transfer from Alice's Savings (AccountID = 1) to her Checking (AccountID = 4)
INSERT INTO Transaction (AccountID, TransactionType, Amount, RelatedAccountID)
VALUES (1, 'Transfer', 200.00, 4);

-- Transfer from Charlie’s Savings (AccountID = 3) to Bob’s Checking (AccountID = 2)
INSERT INTO Transaction (AccountID, TransactionType, Amount, RelatedAccountID)
VALUES (3, 'Transfer', 150.00, 2);

-- Deposit into Charlie’s Savings (AccountID = 3)
INSERT INTO Transaction (AccountID, TransactionType, Amount)
VALUES (3, 'Deposit', 250.00);

-- SQL Third Assignment
-- Update phone number of B0b
Update customers set phone = '555-9999' where Firstname = 'Bopb';

-- Delete a row from Branches
Delete from Branches where City = 'New york';

-- Get Accounts of greater then 1000 balance by using Where
Select * from Accounts where Balance > 1000;

-- Using group by calculate how many branches on each city
Select City, Count(*) As BranchCount from Branches Group BY City;

-- Branches with total Balance greater than 2000 by using having
Select Branchid, sum(balance) As TotalBalance from Accounts Group by Branchid having sum(Balance) > 2000;

-- Agg fun on Accounts table
select Min(Balance) from Accounts;

-- Using like display name start with 'B' from Customers table
Select Firstname from Customers where Firstname like 'b%';

-- Applying subquery
Select CustomerId, Balance from Accounts where Balance > ( Select Avg(Balance) from Accounts);

-- Applying Stored procedure 
Delimiter //
Create Procedure ShowCustomers()
Begin 
     Select * from Customers;
End //
Delimiter ;

-- Applying Triggers 
Delimiter //
Create Trigger AfterCustomersInsert
After Insert on Customers
For Each Row
Begin
	Insert Into CustomerLogs (Message)
    Values ('A new Customer was added!');
End //
Delimiter ;

