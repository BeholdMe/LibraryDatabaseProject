-- Question 1: Insert yourself as a New Borrower. Do not provide the Card_no in your query. [2 points]
INSERT INTO BORROWER(Name, Address, Phone)
VALUES ('Dewa Ratuwina', '8 Anfield Road, Liverpool, England', '666-555-4444');

-- Question 2: Update your phone number to (837) 721-8965 [2 points]
UPDATE BORROWER
SET Phone = '837-721-8965'
WHERE Name = 'Dewa Ratuwina';


-- Question 3: Increase the number of book_copies by 1 for the ‘East Branch’ [2 points]
UPDATE BOOK_COPIES
SET No_of_copies = No_of_copies + 1
WHERE BOOK_COPIES.Branch_id = LIBRARY_BRANCH.Branch_id AND LIBRARY_BRANCH.Branch_name = 'East Branch';


-- Question 4-a: Insert a new BOOK with the following info: Title: ‘Harry Potter and the Sorcerer's Stone’ ; Book_author: ‘J.K. Rowling’ ; Publisher_name: ‘Oxford Publisheing’[2 points]  
INSERT INTO BOOK(Title, Publisher_name)
VALUES('Harry Potter and the Sorcerer''s Stone', 'Oxford Publisheing');

INSERT INTO BOOK_AUTHORS(Book_id, Author_name)
VALUES ((SELECT Book_id FROM BOOK WHERE Title = 'Harry Potter and the Sorcerer''s Stone' AND Publisher_name = 'Oxford Publisheing'), 'J.K. Rowling');


-- Question 4-b: You also need to insert the following branches:  
-- North Branch 456 NW, Irving, TX 76100 
-- UTA Branch 123 Cooper St, Arlington TX 76101
INSERT INTO LIBRARY_BRANCH(Branch_name, Branch_address)
VALUES('North Branch', '456 NW, Irving, TX 76100');

INSERT INTO LIBRARY_BRANCH(Branch_name, Branch_address)
VALUES('UTA Branch', '123 Cooper St, Arlington TX 76101');