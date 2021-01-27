---------------------------------------------------------------------
-- Name        : Andre Sandoval
--
-- UserName    : SandovalA
--
-- Date        : 3/19/2018
--
-- Course      : CS 3630
--               Section 3
--
-- Assignment 7: 5 points
--               Create tables with constraints
--               Need to drop tables first
--               Drop tables in the reserve order they were created.
--
--               Due  Wednesday, March 21, at 5 PM
---------------------------------------------------------------------

/*
Create an SQL*Plus Script file to do the following.
    
Create the following tables in your Oracle account.

          Hotel
               Hotel_No   Char of size 3      primary key
               Name       Char of at most 15  required
               Address    Char of at most 30  required

          Room
               Room_No    Char of size 4      
               Hotel_No   Char of size 3      foreign key, references Hotel
               RType      Char of size 6      'Single', 'Double', or 'Family', required, default 'Double'
               Price      Number              required, between 30 and 200, inclusive
               Primary Key: Hotel_No, Room_No

          Guest
               Guest_No   Char of size 6      primary key
               Guest_Name Char of at most 30  required 
               Address    Char of at most 40

          Booking
               Hotel_No   Char of size 3      
               Guest_No   Char of size 6      required
               Date_From  Date                
               Date_To    Date                required
               Room_No    Char of size 4      
               Primary Key: Hotel_No, Room_No, Date_From
               Foreign key (Hotel_No, Room_No) References Room
                            Guest_no references Guest
                            
Insert the following records into the tables:
          Hotel
               H01, Grosvenor, London
               H05, Glasgow,   London
               H07, Aberdeen,  London
               H12, London,    Glasgow
               H16, Aberdeen,  Glasgow
               H24, London,    Aberdeen
               H28, Glasgow,   Aberdeen

          Room
               R001, H01, Single, 30
               R002, H01, Single, 100
               R103, H01, Double, 30
               R105, H01, Double, 119
               R209, H01, Family, 150
               R219, H01, Family, 190

               R001, H05, Double, 39
               R003, H05, Single, 40
               R103, H05, Single, 55
               R101, H05, Double, 40
               R104, H05, Double, 105

               R104, H07, Double, 100
               R105, H12, Double, 45
               R201, H12, Family, 80
               R003, H28, Family, 49.95

         Guest
               G01003, John White,    6 Lawrence Street, Glasgow
               G01011, Mary Tregear,  5 Tarbot Rd, Aberdeen
               G02003, Aline Stewart, 64 Fern Dr, London
               G02005, Mike Ritchie,  18 Tain St, London, W1H 7DL, England
               G02007, Joe Keogh,     Null
               G12345, CS 3630,       London
               G02008, Scott Summers, London, W1H 7DL, England

         Booking
               H01, G01003, 25-Apr-04, 14-May-04, R001
               H01, G02003, 24-Apr-04, 26-Apr-04, R103
               H01, G01011, 25-Apr-04, 30-Apr-04, R209
               H05, G01003, 05-May-05, 14-May-05, R003
               H05, G02003, 14-Apr-05, 16-Apr-05, R101
               H05, G01011, 15-Apr-05, 16-Apr-05, R003
               H05, G02003, 12-Mar-05, 15-May-05, R003
               H01, G01011, 11-Mar-05, 30-Apr-05, R103
               H01, G02007, 11-Apr-05, 02-Sep-05, R001
               H28, G01003, 11-Mar-05, 30-Apr-05, R003
               H28, G01003, 01-Jan-10, 10-Jan-10, R003

               H05, G02003, 12-Mar-18, 15-May-18, R003
               H01, G01011, 11-Mar-18, 30-Apr-18, R103
               H01, G02007, 11-Apr-18, 02-Sep-18, R001
               H01, G02007, 11-Jan-18, 22-Jan-18, R001
               H07, G02007, 15-Apr-17, 02-May-18, R104

Notes
         The names of all tables and fields MUST be exactly the same as specified above. 
         Your script file should have a comment block at the beginning, including your name, 
              date, course, and your UserName.
         You must drop all the tables first then create the tables and insert records.
         Use "COMMIT" at the end of your script file.
         Both your script file and tables created in your Oracle account will be checked.
         Follow the style given in class. You may lose up to two points on style.
         You can logout and login again to double check the records are saved in Oracle.

Submission
   Name your script file as UserName_A7.sql using your own UWP username. For example, YangQ_A7.sql.
   Upload your UserName_A7 to the DropBox in D2L by the due time.
*/

Drop table Booking;
Drop table Guest;
Drop table Room;
Drop table Hotel;

Pause

Create Table Hotel (
        Hotel_No   Char(3)  Primary Key,
        Name   Varchar2(15) not null,
        Address  Varchar2(30) not null
		);

desc Hotel
Pause
	
Create Table Room (
        Room_No Char(4),
        Hotel_No Char(3) references Hotel,  
        RType  Char(6) Default 'Double' Not Null, 
		Price number not null, 
		Constraint Room_PK
		         Primary Key (Hotel_No, Room_No),
		Constraint Price_Range
		         Check (Price Between 30 and 200)	    
	    );
		
desc Room
Pause
		
Create Table Guest (
        Guest_No Char(6) Primary Key,
		Guest_Name Varchar2(30) not null,
		Address Varchar2(40)
		);
		
desc Guest
Pause
			
Create Table Booking (
        Hotel_No Char(3) references Hotel,
		Guest_No Char(6) not null,
		Date_From Date,
		Date_To Date not null,
		Room_No Char(4) not null,
		Constraint Booking_PK
		         Primary Key (Hotel_No, Room_No, Date_From),
        Constraint Booking_FK
				 Foreign Key (Hotel_No, Room_No) References Room,
				 Foreign Key (Guest_No) References Guest
		);
		
desc Booking

Pause
	
Insert into Hotel
Values ('H01', 'Grosvenor', 'London');

Insert into Hotel
Values ('H05', 'Glasgow',   'London');

Insert into Hotel
Values ('H07', 'Aberdeen',  'London');

Insert into Hotel
Values ('H12', 'London',    'Glasgow');

Insert into Hotel
Values ('H16', 'Aberdeen',  'Glasgow');

Insert into Hotel
Values ('H24', 'London',    'Aberdeen');

Insert into Hotel
Values ('H28', 'Glasgow',   'Aberdeen');

pause 
		
Insert into Room
Values ('R001', 'H01', 'Single', 30);

Insert into Room
Values ('R002', 'H01', 'Single', 100);

Insert into Room
Values ('R103', 'H01', 'Double', 30);

Insert into Room
Values ('R105', 'H01', 'Double', 119);

Insert into Room
Values ('R209', 'H01', 'Family', 150);

Insert into Room
Values ('R219', 'H01', 'Family', 190);

Insert into Room
Values ('R001', 'H05', 'Double', 39);

Insert into Room
Values ('R003', 'H05', 'Single', 40);

Insert into Room
Values ('R103', 'H05', 'Single', 55);

Insert into Room
Values ('R101', 'H05', 'Double', 40);

Insert into Room
Values ('R104', 'H05', 'Double', 105);

Insert into Room
Values ('R104', 'H07', 'Double', 100);

Insert into Room
Values ('R105', 'H12', 'Double', 45);

Insert into Room
Values ('R201', 'H12', 'Family', 80);

Insert into Room
Values ('R003', 'H28', 'Family', 49.95);

pause
		
Insert into Guest
Values ('G01003', 'John White', '6 Lawrence Street, Glasgow');

Insert into Guest
Values ('G01011', 'Mary Tregear', '5 Tarbot Rd, Aberdeen');

Insert into Guest
Values ('G02003', 'Aline Stewart', '64 Fern Dr, London');

Insert into Guest
Values ('G02005', 'Mike Ritchie', '18 Tain St, London, W1H 7DL, England');

Insert into Guest
Values ('G02007', 'Joe Keogh', Null);

Insert into Guest
Values ('G12345', 'CS 3630', 'London');

Insert into Guest
Values ('G02008', 'Scott Summers', 'London, W1H 7DL, England');

pause
		
desc Booking
pause 
		
Insert into Booking
Values ('H01', 'G01003', '25-Apr-04', '14-May-04', 'R001');

Insert into Booking
Values ('H01', 'G02003', '24-Apr-04', '26-Apr-04', 'R103');

Insert into Booking
Values ('H01', 'G01011', '25-Apr-04', '30-Apr-04', 'R209');

Insert into Booking
Values ('H05', 'G01003', '05-May-05', '14-May-05', 'R003');

Insert into Booking
Values ('H05', 'G02003', '14-Apr-05', '16-Apr-05', 'R101');

Insert into Booking
Values ('H05', 'G01011', '15-Apr-05', '16-Apr-05', 'R003');

Insert into Booking
Values ('H05', 'G02003', '12-Mar-05', '15-May-05', 'R003');

Insert into Booking
Values ('H01', 'G01011', '11-Mar-05', '30-Apr-05', 'R103');

Insert into Booking
Values ('H01', 'G02007', '11-Apr-05', '02-Sep-05', 'R001');

Insert into Booking
Values ('H28', 'G01003', '11-Mar-05', '30-Apr-05', 'R003');

Insert into Booking
Values ('H28', 'G01003', '01-Jan-10', '10-Jan-10', 'R003');

Insert into Booking
Values ('H05', 'G02003', '12-Mar-18', '15-May-18', 'R003');

Insert into Booking
Values ('H01', 'G01011', '11-Mar-18', '30-Apr-18', 'R103');

Insert into Booking
Values ('H01', 'G02007', '11-Apr-18', '02-Sep-18', 'R001');

Insert into Booking
Values ('H01', 'G02007', '11-Jan-18', '22-Jan-18', 'R001');

Insert into Booking
Values ('H07', 'G02007', '15-Apr-17', '02-May-18', 'R104');

Commit;

select * 
from Hotel;

select * 
from Room;

select * 
from Guest;

select * 
from Booking;

pause

		
