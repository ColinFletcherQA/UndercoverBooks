/*+-------------------+--------------+------+-----+---------+-------+
| Field             | Type         | Null | Key | Default | Extra |
+-------------------+--------------+------+-----+---------+-------+
| book_id           | int(11)      | NO   | PRI | NULL    |       |
| book_image        | varchar(255) | YES  |     | NULL    |       |
| description       | varchar(255) | YES  |     | NULL    |       |
| e_bookisbn        | varchar(255) | YES  |     | NULL    |       |
| format            | varchar(255) | YES  |     | NULL    |       |
| page_count        | int(11)      | NO   |     | NULL    |       |
| paperisbn         | varchar(255) | YES  |     | NULL    |       |
| price             | double       | NO   |     | NULL    |       |
| published_date    | varchar(255) | YES  |     | NULL    |       |
| publisher         | varchar(255) | YES  |     | NULL    |       |
| table_of_contents | varchar(255) | YES  |     | NULL    |       |
| title             | varchar(255) | YES  |     | NULL    |       |
+-------------------+--------------+------+-----+---------+-------
*/

/* Wipe the DB */

delete from BOOK_AUTHORS;
delete from BOOK;
delete from AUTHOR;

insert into BOOK values (
	3,
	null,
	null,
	null,
	null,
	1234,
	null,
	1999.99,
	null,
	null,
	null,
	null
);

insert into BOOK values (
	1,
	"http://www.teleread.com/wp-content/uploads/2016/04/Paperback-Paradise-3.jpg",
	"A test description of a book",
	"E-El53V13R1",
	"Hardcover",
	109,
	"P-El53V13R1",
	19.99,
	"3-31-1996",
	"Elsevier",
	null,
	"Test Title"
);

insert into BOOK values (
	2,
	"http://www.teleread.com/wp-content/uploads/2016/04/Paperback-Paradise-3.jpg",
	null,
	"E-El53V13R2",
	"Hardcover",
	1000,
	"P-El53V13R2",
	19.99,
	null,
	"Elsevier",
	null,
	"Test Title 2"
);
/*
+--------------+--------------+------+-----+---------+-------+
| Field        | Type         | Null | Key | Default | Extra |
+--------------+--------------+------+-----+---------+-------+
| author_id    | int(11)      | NO   | PRI | NULL    |       |
| about_author | varchar(255) | YES  |     | NULL    |       |
| affiliations | varchar(255) | YES  |     | NULL    |       |
| author_name  | varchar(255) | YES  |     | NULL    |       |
| expertise    | varchar(255) | YES  |     | NULL    |       |
+--------------+--------------+------+-----+---------+-------+
*/

insert into AUTHOR values (
	1,
	"I am author",
	"Affiliated with etc",
	"Smash Flannigan",
	"Book"
);

/*
+-------------------+---------+------+-----+---------+-------+
| Field             | Type    | Null | Key | Default | Extra |
+-------------------+---------+------+-----+---------+-------+
| book_book_id      | int(11) | NO   | MUL | NULL    |       |
| authors_author_id | int(11) | NO   | PRI | NULL    |       |
+-------------------+---------+------+-----+---------+-------+
*/

insert into BOOK_AUTHORS values (
	1,
	1
);

