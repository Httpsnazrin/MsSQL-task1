
CREATE DATABASE Bookstore;
USE Bookstore;
CREATE TABLE BookCatalog (
    BookCatalogId INT PRIMARY KEY,
    BookTitle NVARCHAR(50),
    NumberOfPages INT,
    AuthorId INT
);


CREATE TABLE Authors (
    AuthorId INT PRIMARY KEY,
    AuthorName NVARCHAR(50)
);

INSERT INTO Authors (AuthorId, AuthorName)
VALUES (1, 'Livaneli'), (2, 'Sabahattin Ali'), (3, 'Irvin D.Yalom');

INSERT INTO BookCatalog (BookCatalogId, BookTitle, NumberOfPages, AuthorId)
VALUES (1, 'Serenad', 342, 1), (2, 'Kurk mantolu madonna', 555, 2), (3, 'Nietzsche agladiginda', 433, 3);


CREATE VIEW BookDetails AS
    SELECT 
        BC.BookCatalogId,
        BC.BookTitle,
        BC.NumberOfPages,
        A.AuthorId
    FROM 
        BookCatalog BC
    INNER JOIN
        Authors A ON A.AuthorId = BC.AuthorId;




CREATE PROCEDURE BookInformationByAuthors
@BookTitle NVARCHAR(50)
AS
BEGIN
    SELECT
        BC.AuthorId,
        A.AuthorName,
        COUNT(*) AS NumberOfBooks
    FROM
        BookDetails BC
    INNER JOIN
        Authors A ON A.AuthorId = BC.AuthorId
    WHERE
        BC.BookTitle = @BookTitle
    GROUP BY
        BC.AuthorId, A.AuthorName;
END;