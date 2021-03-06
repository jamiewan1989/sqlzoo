######SQL ZOO######
##AdventureWorks assessment

/*Easy*/
/* Q1 */
SELECT booking_date,nights
FROM booking
WHERE guest_id = 1183

/* Q2 */
SELECT arrival_time, first_name, last_name
FROM booking
JOIN guest
ON booking.guest_id = guest.id
WHERE booking_date = "2016-11-05"
ORDER BY arrival_time;

/* Q3 */
SELECT booking_id,room_type_requested,occupants,amount
FROM booking a
JOIN rate b
ON a.room_type_requested = b.room_type AND a.occupants = b.occupancy
WHERE booking_id in (5152,5165,5154,5295);

/* Q4 */
SELECT first_name,last_name,address
FROM booking a
JOIN guest b
ON a.guest_id = b.id
WHERE room_no = 101 
  AND (TO_DAYS(booking_date)<=TO_DAYS("2016-12-03") 
       AND TO_DAYS(booking_date + INTERVAL nights DAY) > TO_DAYS("2016-12-03"));

/* Q5 */
SELECT guest_id,count(nights), sum(nights)
FROM booking
WHERE guest_id in (1185,1270)
GROUP BY guest_id; 


/* Medium */
/* Q6 */
SELECT SUM(nights*amount)
FROM booking a
JOIN guest b
  ON a.guest_id = b.id
JOIN rate c
  ON a.room_type_requested = c.room_type AND occupants = occupancy
WHERE b.first_name = "Ruth" AND b.last_name = "Cadbury";

/* Q7 --> the answer maybe wrong from sqlzoo --> this is what I think is correct*/
SELECT nights*rate.amount + ex.amount 
FROM booking b
JOIN rate
ON room_type_requested = room_type AND occupants = occupancy
JOIN 
    (SELECT booking_id,SUM(amount) as amount 
     FROM extra 
     WHERE booking_id = 5128 
     GROUP BY booking_id) as ex
ON ex.booking_id = b.booking_id
WHERE b.booking_id = 5128; 

/* Q8 */
SELECT last_name,first_name, address, SUM(nights)
FROM 
    (SELECT last_name,first_name,address,COALESCE(nights,NULL,0) as nights
    FROM booking
    RIGHT JOIN guest
    ON guest.id = booking.guest_id
    WHERE address LIKE "Edinburgh%") as a
GROUP BY a.last_name,a.first_name;


/* Q9 */
SELECT booking_date, COUNT(arrival_time)
FROM booking
WHERE booking_date BETWEEN "2016-11-25" AND "2016-12-01"
GROUP BY booking_date;

/* Q10 */
SELECT SUM(occupants)
FROM booking
WHERE booking_date + INTERVAL nights DAY > "2016-11-21" AND booking_date <= "2016-11-21";

/* Q11 */
SELECT last.last_name, substring_index(group_concat(last.first1 ORDER BY last.last_name),",",1),
substring_index(group_concat(last.first1 ORDER BY last.last_name),",",-1)
FROM (
 SELECT DISTINCT a.last_name,a.first_name first1,b.first_name first2
 FROM (SELECT * FROM booking bo JOIN guest g ON bo.guest_id = g.id) a, 
      (SELECT * FROM booking bo JOIN guest g ON bo.guest_id = g.id) b
 WHERE a.last_name = b.last_name AND a.first_name != b.first_name
 AND (
   (a.booking_date + INTERVAL a.nights DAY > b.booking_date) AND (a.booking_date<=b.booking_date)
 OR (b.booking_date + INTERVAL b.nights DAY > a.booking_date) AND (b.booking_date<=a.booking_date))
  ) last
GROUP BY last_name;

/* Q12 */
SELECT longer.checkout_date, substring_index(group_concat(longer.counts ORDER BY longer.checkout_date),",",-1),
    substring_index(substring_index(group_concat(longer.counts ORDER BY longer.checkout_date),",",2),",",-1),
    substring_index(group_concat(longer.counts ORDER BY longer.checkout_date),",",1)
FROM (
  SELECT checkout_date,COUNT(*) counts
  FROM (
        SELECT (booking_date + INTERVAL nights DAY) as checkout_date,      
                floor(room_no/100) as floor      
        FROM booking
        WHERE (booking_date + INTERVAL nights DAY) BETWEEN "2016-11-14" AND "2016-11-20"
        ) as checkout
  GROUP BY checkout_date, floor
  ) longer
GROUP BY checkout_date;


/* Q13 */
SELECT dates.dates, b_table.last_name
FROM (
    SELECT distinct booking_date as dates
    FROM booking
    WHERE booking_date BETWEEN '2016-11-21' and '2016-11-27'
    ORDER BY booking_date
    ) dates 
LEFT JOIN 
    (SELECT last_name,booking_date,nights,(booking_date + INTERVAL nights DAY) as checkout_date
     FROM booking a
     JOIN guest b
     ON a.guest_id = b.id
     WHERE room_no = 207
     ) b_table
ON dates.dates >= b_table.booking_date AND dates.dates<b_table.checkout_date;


/* Q14 */ 
SELECT room_no, prev_checkout_date
FROM (
SELECT *,(booking_date + INTERVAL nights DAY) as checkout_date, @rownum:=@rownum + 1 as rank1
FROM booking, (SELECT @rownum:= 0) as r
ORDER BY room_no, booking_date
)  main
JOIN (
  SELECT (booking_date + INTERVAL nights DAY) as prev_checkout_date, @rownum2 := @rownum2 + 1 as rank2
  FROM booking, (SELECT @rownum2:=1) as rank2
  ORDER BY room_no, booking_date
) prev
ON main.rank1 = prev.rank2
WHERE  (TO_DAYS(booking_date) - TO_DAYS(prev_checkout_date)) >= 7;


/* Q15 */



