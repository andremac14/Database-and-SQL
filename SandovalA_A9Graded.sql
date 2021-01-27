--grade: 14/15
-----------------------------------------------------------------------------
-- Name        : Andre Sandoval
--
-- UserName    : sandovala@eddb
--
-- Date        : 4/4/18
--
-- Course      : CS 3630
--               Section 3
--
-- Assignment 9: 15 points
--               
-----------------------------------------------------------------------------

Col Room_No Format a7 heading "Room No"
Col Hotel_No Format a8 heading "Hotel No"
Col RType Format a9 heading "Room Type"
Col Name Format a10 heading "Name"
Col Price Format $999.00 heading "Price"
Col Address Format a21 heading "Address"
Col RType Format a9 heading "Room Type"
Col Guest_No Format a8 heading "Guest No"
Col Guest_Name Format a20 heading "Guest Name"


PROMPT
PROMPT 1.
PROMPT List all rooms (all details) of hotel Glasgow, sorted by hotel number and then price. 
PROMPT

Select *
From Room R 
Join Hotel H 
on R.Hotel_No = H.Hotel_No
And Name like '%Glasgow%'
Order by R.Hotel_No, Price;

extra attributes: -.5

PROMPT Correct way

Select R.*
From Room R 
Join Hotel H 
on R.Hotel_No = H.Hotel_No
And H.Name = 'Glasgow'
Order by R.Hotel_No, Price;

Pause

PROMPT
PROMPT 2.
PROMPT List all double or family rooms (all details) of hotel Glasgow with a 
PROMPT price below 50 per night sorted in ascending order of price. 
PROMPT

Select *
From Room R 
Join Hotel H 
on R.Hotel_No = H.Hotel_No
Where Price < 50 and (RType = 'Family' or RType = 'Double')
and Name like '%Glasgow%'
Order by Price asc;

extra attributes: -.5

PROMPT Correct way

Select R.*
From Room R 
Join Hotel H 
on R.Hotel_No = H.Hotel_No
Where RType in ('Family' , 'Double')
  and Price < 50
Order by Price asc;

Pause 

PROMPT
PROMPT 3.
PROMPT For each hotel that has at least 6 bookings, list the hotel name, 
PROMPT hotel number and the number of bookings, sorted by the number 
PROMPT of bookings in ascending order.
PROMPT 

Select Name, H.Hotel_No, Count(Date_From) as "Count"
From Hotel H
Join Booking B
on H.Hotel_No = B.Hotel_No
Group by H.Hotel_No, Name
Having Count(Date_From) > 6
Order by Count(Date_From) asc;

incorrect query: -1

PROMPT Correct way

Select Name, H.Hotel_No, Count(*) as "Number of Bookings"
From Hotel H
Join Booking B
  on H.Hotel_No = B.Hotel_No
Group by Name, H.Hotel_No
Having Count(*) > 6
Order by Count(*);



pause

PROMPT
PROMPT 4. 
PROMPT For each hotel, list the hotel name, hotel number and the number 
PROMPT of bookings during the current month of the current year (bookings 
PROMPT that covers at least one day of the current month of the current year). 
PROMPT A zero should be displayed for hotels that do not have any bookings 
PROMPT during the current month, and the query should work for any month of any year. 
PROMPT

Select name, H.Hotel_No, count(B.Hotel_No) as "Count"
From  Hotel H
Left Join Booking B
     on H.Hotel_no = B.Hotel_no
     and To_Char(Date_From, 'yyyy') <= to_char(sysdate, 'yyyy')
     and To_Char(Date_From, 'mm') <= to_char(sysdate, 'mm')
     and To_Char(Date_To, 'mm') >= to_char(sysdate, 'mm')
     and To_Char(Date_To, 'yyyy') >= to_char(sysdate, 'yyyy')
Group by  name, H.Hotel_No;

pause 

PROMPT 
PROMPT Other Way Sub-Query 
PROMPT 

Select H.Name, H.Hotel_No,
       (Select Count(*)
	    From Booking B
		Where H.Hotel_No = B.Hotel_No
		  and (To_Char(sysdate, 'yyyy mm') = To_Char(Date_From, 'yyyy mm') or 
		       to_char(sysdate, 'yyyy mm') = To_Char(Date_To, 'yyyy mm') or 
			   Sysdate between Date_From and Date_To)) "Number of Bookings"
From Hotel H
Order by H.Hotel_No;

pause 

PROMPT
PROMPT 5.
PROMPT List all guests (all details) currently staying at hotel Grosvenor 
PROMPT in London, sorted on Guest_no. The query should work for any day. 
PROMPT

Select G.Guest_No, G.Guest_name, G.Address
From Guest G, booking B, hotel H
Where G.Guest_No = B.Guest_No
      and H.Hotel_No = B.hotel_No 
      and To_Char(Date_From) <= to_char(sysdate)
      and To_Char(Date_To) >= to_char(sysdate) 
      and Name = 'Grosvenor'
	  Group by G.Guest_No, G.Guest_name, G.Address; 
	 
incorrect query: -1

PROMPT 
PROMPT Different Way
PROMPT
PROMPT Sub-Query
PROMPT

Select Unique G.*
From Guest G
Join (Select *
      From Booking 
	  Where SysDate between Date_From and Date_To) B
  on G.Guest_No = B.Guest_No
Join (Select *
      From Hotel 
	  Where Name = 'Grosvenor'
	    and Address = 'London') H 
    on B.Hotel_No = H.Hotel_No
Order by G.Guest_No;
	 
pause

PROMPT
PROMPT 6. 
PROMPT For each hotel that does not have any bookings, display the hotel details, 
PROMPT sorted on Hotel_No. 
PROMPT

Select    H.Hotel_No, H.Name, H.Address
From      Hotel H
Left join Booking B
       on H.Hotel_no = B.Hotel_no
Having count(*) = 0
Group by  H.Hotel_No, H.Name, H.Address;
B.Hotel_No
pause 

PROMPT 
PROMPT Different Way 
PROMPT
PROMPT Sub Query 
PROMPT

Select * 
From Hotel 
Where Hotel_No Not in 
      (Select Distinct Hotel_No
	   From Booking) 
Order by Hotel_No;

pause

PROMPT
PROMPT 7. 
PROMPT List the rooms (all details) that are currently unoccupied at hotel Grosvenor 
PROMPT in London. The query should produce correct results today and any day in the future.
PROMPT

Select R.Room_No, R.Hotel_No, R.RType, R.Price
From Room R, Hotel H
Where R.Hotel_No = H.Hotel_No
      and H.Name = 'Grosvenor'
      and R.Room_No NOT IN 
(Select R.Room_No 
 From Booking B, Hotel H
 Where To_Char(Date_From) <= to_char(sysdate)
       and To_Char(Date_To) >= to_char(sysdate) 
       and R.Hotel_No = B.Hotel_No
       and R.Room_No = B.Room_No
       and R.Hotel_No = B.Hotel_No 
       and H.Name = 'Grosvenor');

	   incorrect query: -1
	   
pause

PROMPT 
PROMPT 8.
PROMPT For each hotel in London, list the hotel number, hotel name, and number of Family rooms 
PROMPT with a price below 180. Display a zero for hotels in London that do not have specified rooms. 
PROMPT

Select H.Hotel_No, H.Name, count(R.Room_No) as "Count"
From Hotel H
Left Join Room R 
     on R.Hotel_No = H.Hotel_No
     and R.RType like '%Family%'
	 and Price < 180
Where Address like '%London%'
Group by H.Hotel_No, H.Name;

pause 

PROMPT 
PROMPT Different Way 
PROMPT 
PROMPT Sub-Query 
PROMPT 

Select H.Hotel_No H.Name,
       (Select Count(*)
	    From Room R 
		Where R.Hotel_No = H.Hotel_No
		  and rtype = 'Family'
		  and price = 180 ) "Number of Rooms"
		From Hotel H 
		Where H.Address = 'London' 
		Order by H.Hotel_No;

pause

PROMPT
PROMPT 9.
PROMPT List the guest number, guest name and the number of bookings for the current year, 
PROMPT sorted by guest_no. Display a zero for guests who do not have any bookings for the current year. 
PROMPT Your query should work for any year. Booking could be longer than one year. 
PROMPT

Select G.Guest_No, G.Guest_name, count(B.Guest_No) as "Count"
From Guest G
Left Join Booking B 
     on G.Guest_No = B.Guest_No
     and (To_char(Date_from, 'yyyy') = To_Char(SysDate, 'yyyy')
     Or  To_Char(Date_to, 'yyyy') = To_Char(SysDate, 'yyyy')
     or to_number(To_char(Date_from, 'yyyy')) < to_number(To_Char(SysDate, 'yyyy'))
     and to_number(To_Char(Date_to, 'yyyy')) > to_number(To_Char(SysDate, 'yyyy')))
     Group by G.Guest_No, G.Guest_Name
	 Order by G.Guest_No;
	 
pause 

PROMPT Alternate Way 
	 
Select G.Guest_No, G.Guest_Name,
       (Select Count(*)
	    From Booking B
		Where G.Guest_No = B.Guest_No
          and (To_Char(Date_from, 'yyyy') <= To_Char(SysDate, 'yyyy') and
		       To_Char(Date_To, 'yyyy') >= To_Char(SysDate, 'yyyy'))) "Number of Bookings"
From Guest G
Order by Guest_No;

pause 

PROMPT 
PROMPT 10.
PROMPT For each hotel that has at least one booking, list the Hotel number, Hotel name, and the most 
PROMPT commonly booked room type for the hotel (the number of bookings is the largest) with the count 
PROMPT of bookings for that room type. Notice that multiple types may have the same largest number of 
PROMPT bookings, and all such types should be listed.
PROMPT 

no query: -2

Select H.Hotel_No, H.Name, R.RType, Count(*) "Number of Bookings"
From Hotel H
Join Room R
  on H.Hotel_No = R.Hotel_No 
Join Booking B 
  on H.Hotel_No = R.Hotel_No
Join Booking B
  on H.Hotel_No = B.Hotel_No
 and B.Room_No = R.Room_No 
Group By H.Hotel_No, H.Name, R.RType 
Having Count(*) >= All 
       (Select Count(*)
        From Room R1 
        Join Booking B1 
          on R1.Hotel_No = B1.Hotel_No 
          and B1.Room_No = R1.Room_No 
        Where R1.Hotel_No = H.Hotel_No 
        Group By R1.RType)
Order by H.Hotel_No, RType;		
	           

pause 

Clear col 


