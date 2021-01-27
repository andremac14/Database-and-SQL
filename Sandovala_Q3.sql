---------------------------------------------------------------------------------
-- Name       : Andre Sandoval
--
-- UserName   : 
--
-- Course     : CS 3630
--
-- Description: Quiz 3
--
-- Date       : April 13, 2018
---------------------------------------------------------------------------------

prompt
prompt 1. Set column format 
Prompt 

-- Column NIN is displayed as string of length 8 with heading "Staff No"
-- Column BirthDay is displayed as string of length 12 with heading "Birth Day"
-- Column FirstName is displayed as string of length 10 with heading "First Name"
-- Column LastName is displayed as string of length 10 with heading "Last Name"
-- Column State is displayed as string of length 6 with heading "State"
-- Column HotelNo is displayed as string of length 8 with heading "Hotel No"

Col NIN Format a8 heading "Staff No"
Col BirthDay Format a12 heading "Birth Day"
Col FirstName Format a10 heading "First Name"
Col LastName Format a10 heading "Last Name"
Col State Format a6 heading "State"
Col HotelNo Format a8 heading "Hotel No"

pause

prompt
prompt 2.
prompt List NIN, FirstName, LastName and DOB of all 
prompt staff, sorted on DOB in descending order,
prompt and then on last name in ascending order.
prompt DOB must have a new heading BirthDay and 
prompt be in the format mm/dd/yyyy, e.g., 06/21/1955.
prompt

Select NIN, FirstName, LastName, To_Char(DOB, 'Mon dd yyyy') "Birthday"
    From AllStaff
	Order by DOB desc, LastName asc;
	



pause

prompt
prompt 3.
prompt List NIN, firstName and lastName of all staff
prompt whose DOB is missing or 
prompt the fourth char of the last name is a lower case n.
prompt 

Select NIN, FirstName, LastName 
    From AllStaff
	Where DOB is Null or LastName like '___n%';
	
pause

prompt
prompt 4.
prompt For each staff and each hotel, list NIN, HotelNo,
prompt and the total number of hours (with heading "Total Hours")
prompt the staff has worked for the hotel,
prompt sorted by NIN and then HotelNo.
prompt

/*
Sample output

Staff No Hotel No Total Hours
-------- -------- -----------
1001     H18001            20 
1001     H19001            32
1001     H19005           144 
1001     H19008            99 
2001     H18001           250 
2001     H19001            92
*/

Select NIN, HotelNo, To_Char(Hours) "Total Hours"
    From ContractPayRoll
	Order by NIN, HotelNo;



pause

prompt
prompt 5.
prompt For each staff who has been paid between April 04, 2015 
prompt and April 11, 2015 (inclusive), list the NIN and the 
prompt total number of hours (with heading "Total Hours") the 
prompt staff has been paid during that period of time.
prompt

Select NIN, To_Char(Hours) "Total Hours"
    From ContractPayRoll
	Where Paydate between '04-Apr-15' and '11-Apr-15';
	
pause

prompt
prompt 6.
prompt For each city of each state that has more than one staff, list
prompt the City, State, and the total number of staff from the city
prompt (with heading "Number of Staff").
prompt 

Select City, State, Count(*) as "Number of Staff"
    From AllStaff
	Where "Number of Bookings" > 1
	Group by City;


pause

prompt 
Prompt 7. Remove all column formatting
prompt 

Clear col
