CREATE TABLE PUBLISHER
(
    Publisher_name VARCHAR(32) PRIMARY KEY, 
    Phone CHAR(12), 
    Address VARCHAR(64)
);

CREATE TABLE LIBRARY_BRANCH
(
    Branch_id INTEGER PRIMARY KEY,
    Branch_name VARCHAR(32),
    Branch_address VARCHAR(64)
);

CREATE TABLE BORROWER
(
    Card_no INTEGER PRIMARY KEY,
    Name VARCHAR(32),
    Address VARCHAR(64),
    Phone CHAR(12)
);

CREATE TABLE BOOK
(
    Book_id INTEGER PRIMARY KEY,
    Title VARCHAR(32),
    Publisher_name VARCHAR(32),
    Phone CHAR(12),
    FOREIGN KEY (Publisher_name) REFERENCES PUBLISHER(Publisher_name)
);

CREATE TABLE BOOK_LOANS
(
    Book_id INTEGER,
    Branch_id INTEGER,
    Card_no INTEGER,
    Date_out CHAR(12),
    Due_date CHAR(12),
    Returned_date CHAR(12)
    FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id),
    FOREIGN KEY (Branch_id) REFERENCES LIBRARY_BRANCH(Branch_id),
    FOREIGN KEY (Card_no) REFERENCES BORROWER(Card_no),
    FOREIGN KEY (Card_no) REFERENCES BORROWER(Card_no)
);

CREATE TABLE BOOK_COPIES
(
    Book_id INTEGER,
    Branch_id INTEGER,
    No_of_copies INTEGER,
    FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id),
    FOREIGN KEY (Branch_id) REFERENCES LIBRARY_BRANCH(Branch_id)
);

CREATE TABLE BOOK_AUTHORS
(
    Book_id INTEGER,
    Author_name VARCHAR(32),
    FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id)
);