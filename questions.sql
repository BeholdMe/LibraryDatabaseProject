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

-- Question 5: Return all Books that were loaned between March 5, 2022 until March 23, 2022. List Book title and Branch name, and how many days it was borrowed for. [10 points]
SELECT B.Title AS Book_title, LB.Branch_name,
(DATE(BL.Returned_date) - DATE(BL.Date_out)) AS Days_Borrowed
FROM BOOK_LOANS BL
JOIN BOOK B ON BL.Book_id = B.Book_id
JOIN LIBRARY_BRANCH LB ON BL.Branch_id = LB.Branch_id
WHERE BL.Date_out BETWEEN '2022-03-05' AND '2022-03-23' AND BL.Returned_date IS NOT NULL;

-- Question 6: Return a List borrower names, that have books not returned. [3 points]
SELECT BO.Name AS Borrower_name
FROM BORROWER BO
JOIN BOOK_LOANS BL ON BO.Card_no = BL.Card_no
WHERE BL.Returned_date IS NULL;

SELECT LB.Branch_name,
    SUM(CASE 
        WHEN BL.Returned_date IS NOT NULL THEN 1
        ELSE 0 
    END) AS Returned_books,
    SUM(CASE 
        WHEN BL.Returned_date IS NULL AND DATE(BL.Due_date) >= DATE(CURRENT_DATE) THEN 1
        ELSE 0 
    END) AS Borrowed_books,
    SUM(CASE 
        WHEN BL.Returned_date IS NULL AND DATE(BL.Due_date) < DATE(CURRENT_DATE) THEN 1
        ELSE 0 
    END) AS Late_books
FROM LIBRARY_BRANCH LB
JOIN BOOK_LOANS BL ON LB.Branch_id = BL.Branch_id
GROUP BY LB.Branch_name;

--Question 8: List all the books (title) and the maximum number of days that they were borrowed. [15 points]
SELECT B.Title AS Book_title, MAX(DATE(BL.Returned_date) - DATE(BL.Date_out)) AS Maximum_days_borrowed
FROM BOOK B
JOIN BOOK_LOANS BL ON B.Book_id = BL.Book_id
WHERE BL.Returned_date IS NOT NULL
GROUP BY B.Title;

--Question 9: Create a report for Ethan Martinez with all the books they borrowed. List the book title and author. Also, calculate the number of days each book was borrowed for and if any book is late being returned. Order the results by the date_out. [6 points]
SELECT B.Title AS Book_title, BA.Author_name, 
    (DATE(BL.Returned_date) - DATE(BL.Date_out)) AS Days_borrowed,
    CASE 
        WHEN DATE(BL.Due_date) < DATE(CURRENT_DATE) AND BL.Returned_date IS NULL THEN 'Late'
        ELSE 'On Time'
    END AS Return_status
FROM BORROWER BO
JOIN BOOK_LOANS BL ON BO.Card_no = BL.Card_no
JOIN BOOK B ON BL.Book_id = B.Book_id
JOIN BOOK_AUTHORS BA ON B.Book_id = BA.Book_id
WHERE BO.Name = 'Ethan Martinez'
ORDER BY BL.Date_out;

--Question 10: Return the names of all borrowers that borrowed a book from the West Branch include their addresses. [3 points]
SELECT BO.Name AS Borrower_name, BO.Address AS Borrower_address
FROM BORROWER BO
JOIN BOOK_LOANS BL ON BO.Card_no = BL.Card_no
JOIN LIBRARY_BRANCH LB ON BL.Branch_id = LB.Branch_id
WHERE LB.Branch_name = 'West Branch' AND BL.Returned_date IS NOT NULL;
