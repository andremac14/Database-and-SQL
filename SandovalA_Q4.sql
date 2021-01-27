--grade: 16/25
---------------------------------------------------------------------------------
-- Name       : Andre Sandoval
--
-- UserName   : sandovala@eddb
--
-- Course     : CS 3630
--              Section 1 (09 AM) 
--              Section 2 (10 AM)
--              Section 3 (02 PM)
--
-- Description: Quiz 4
--              Queries using joins/outer joins, sub-queries, and views
--
-- Date       : April 25, 2018
---------------------------------------------------------------------------------

prompt
prompt 1. Set column format 
Prompt 

set pagesize 20 

-- Column NIN      : string of length 8,  heading: "Staff No"
-- Column FirstName: string of length 11, heading: "First Name"
-- Column LastName : string of length 10, heading "Last Name"
-- Column Name     : string of length 15, heading "Hotel Name"
-- Column HotelNo  : string of length 8,  heading "Hotel No"
-- Column city     : string of length 12, heading "City"
-- Column State    : string of length 6,  heading "State"
-- Column hours    : number of 3 digits,  heading "Hours"
-- Column Payment  : dollar no cents,     heading "Salary"
-- Column "Total Amount of Payments" : dollar no cents

Col NIN Format a8 heading "Staff No"
Col FirstName Format a11 heading "First Name"
Col LastName Format a10 heading "Last Name"
Col Name Format a15 heading "Hotel Name"
Col HotelNo Format a8 heading "Hotel No"
Col City Format a12 heading "City"
Col State Format a6 heading "State"
Col Hours Format 999 heading "Hours"
Col Payment Format $9,999 heading "Salary"
Col Format $999 "Total Amount of Payments" 



prompt
prompt 2.
prompt For each pay roll record in ContractPayRoll, 
prompt list Hotel No, Hotel Name, payDate and payment,
prompt sorted on Hotel No in descending order,
prompt and then on payDate in ascending order.
prompt PayDate must be in the format Month dd yyyy, 
prompt e.g., April 25 2018 with heading "Pay Date"

Select C.HotelNo, Name, To_Char((C.PayDate), 'Mon dd yyyy'), C.Payment 
From ContractPayRoll C
Join AllHotels A
on C.HotelNo = A.HotelNo 
Order by C.HotelNo desc, C.Paydate asc;

incorrect formatting: -1

prompt 
prompt Correct Formatting 
prompt 


Select H.HotelNo, Name, To_Char((C.PayDate), 'Mon dd yyyy') "Pay Date", C.Payment 
From   ContractPayRoll C 
Join   AllHotels H 
  on   C.HotelNo = H.HotelNo 
Order by HotelNo desc, payDate;

pause

prompt
prompt 3.
prompt For each hotel, 
prompt list Hotel No, Hotel Name, and the total number 
prompt of payments in ContractPayRoll by the hotel 
prompt with heading "Total # of Payments", 
prompt sorted on hotel no.
prompt A zero must be displayed if a hotel has no payments at all.
prompt

Select A.HotelNo, A.Name,
       (Select Count(*)
	    From ContractPayroll C
		Where C.HotelNo = A.HotelNo) "Total # of Payments"
From AllHotels A
Order by  A.HotelNo;

prompt 
prompt Using left join 
prompt 

Select    H.HotelNo, Name, count(hours) "Total # of Payments"
From      AllHotels H 
Left Join ContractPayRoll C 
on        C.HotelNo = H.HotelNo 
Group by  H.HotelNo, name
Order by  HotelNo; 

pause

prompt
prompt 4.
prompt For each staff who received payments from more than 
prompt one hotel, list first name, last name and the number
prompt of different hotels he/she received payments from
prompt with heading "# Hotels Worked on", 
prompt sorted on NIN.
prompt

Select A.FirstName, A.LastName, 
       (Select Count(*) 
	    From ContractPayRoll C
		Where A.NIN = C.NIN) "# Hotels Worked on"
From AllStaff A 
Order by NIN;

incorrect query: -2

prompt 
prompt Correct Query 
prompt 

Select firstName, lastName, count(unique C.HotelNo) "# Hotels Worked on"
From   AllStaff A 
Join   ContractPayRoll C 
on     C.NIN = A.NIN 
Group by A.NIN, firstName, lastName 
Having count(unique C.HotelNo) > 1
Order by A.NIN;  

pause


prompt
prompt 5. 
prompt For each hotel and each staff who received payments from 
prompt the hotel during the last month, list hotel number, hotel 
prompt name, NIN and last name with the total amount of payments 
prompt the staff received last month from the hotel with heading 
prompt "Total Amount of Payments", sorted on NIN and then HotelNo. 
prompt The same query should work for any day.
prompt Ignore the hotels that did not make payments last month 
prompt and the staff who did not receive payments last month.

/*
Sample output

Hotel No Hotel Name      Staff No Last Name  Total Amount of Payments 
-------- --------------- -------- ---------- ------------------------ 
H2801    Country Inn     2135     Rowe                           $350
H3807    Mound View Inn  2135     Rowe                           $250
H2801    Country Inn     5001     Hasker                         $600
*/

prompt 
prompt Correct Query  
prompt 

Select H.HotelNo, H.Name, S.NIN, LastName, sum(payment) "Total Amount of Payments"
From   AllStaff S
Join   ContractPayroll C 
  on   C.NIN = S.NIN 
Join   AllHotels H 
  on   H.HotelNo = C.HotelNo
Where to_char (Paydate, 'mm yyyy') = to_char(Add_Months(Sysdate , -1), 'mm yyyy')
Group by S.NIN, firstName, lastName, H.HotelNo, H.Name 
Order by S.NIN, H.HotelNo;  
  
no query: -4

pause
prompt
prompt 6.  
prompt For each staff who did not receive any payments
prompt last month, list NIN, last name, and the total number
prompt of payments the staff has received from all hotels 
prompt with heading "No. of Payments", sorted by NIN. 
prompt A zero should displayed for those staff without any payments.
prompt The same query should work for any day.
prompt 

Select A.NIN, A.LastName, count(C.Payment) "No. of Payments"
From AllStaff A
Left Join ContractPayRoll C 
     on A.NIN = C.NIN 
Having count(C.Payment) = 0	 
Group by A.NIN, A.LastName;

incorrect query: -2

prompt 
prompt Correct Query  
prompt 

Select S.NIN, LastName, 
       ( 
	      Select Count(*)
		  From ContractPayRoll C
		  Where C.NIN = S.NIN) "No. of Payments"
From AllStaff S 
Where NIN Not in 
      ( 
	     Select C.NIN 
		 From ContractPayRoll C 
		 Where C.NIN = S.NIN 
		   And to_char(Add_Months(Sysdate , -1), 'mm yyyy') = to_char(PayDate, 'mm yyyy'))
Order by S.NIN;		 

prompt 
prompt Correct Query using outer join 
prompt 

Select S.NIN, LastName, 
       ( 
	      Select Count(*)
		  From ContractPayRoll C
		  Where C.NIN = S.NIN) "No. of Payments"
From AllStaff S  
Left Join 
       ( 
	      Select NIN 
		  From   ContractPayRoll
		  Where  to_char(Add_Months(Sysdate , -1), 'mm yyyy') = to_char(PayDate, 'mm yyyy')) C 
		  on C.NIN = S.NIN 
Where C.NIN is null 
Order by S.NIN;
  
prompt 
Prompt 7. Remove all column formatting
prompt 

clear col

