/* IS607 WEEK TWO ASSIGNMENT */

/*1. How many airplanes have listed speeds? 
*What is the minimum listed speed and the maximum listed speed?
* Answers: There are 23  airplanes with list speeds with mininum speed of 90 knots
*maximum speed of 432 knots. P.S: google search shows airplanes' speed is commonly measured in knot like ship */

SELECT COUNT(*) 
FROM flg.planes pl
WHERE pl.speed is not null

SELECT MAX(pl.speed), MIN(pl.speed) 
FROM flg.planes pl
WHERE pl.speed is not null


/*2. What is the total distance flown by all of the planes in January 2013? What is the total distance flown by all of
*the planes in January 2013 where the tailnum is missing?
* Answer: The todal distance flown is 27,188,805 (miles?) in January 2013 ,and planes without tailnum flown 27,107,042 */

SELECT SUM(fl.distance) 
FROM flg.flights fl
WHERE fl.month = 1

SELECT SUM(fl.distance) 
FROM flg.flights fl
Where fl.month = 1
AND fl.tailnum is not null




/* 3. What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? Write this
 * statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare? */
 * Answer: The results from both Inner Join and Left Join would have been the same should there been no nulls in the keys 
 *for joining the two tables. Everything else is the same. The left join statements have combined all the null tailnumber into 
 * a single manufaturer*/


/* Inner JOIN RESULT */
SELECT plns.manufacturer
	, SUM(flgt.distance)
FROM flg.flights flgt INNER JOIN flg.planes plns ON flgt.tailnum = plns.tailnum
WHERE 
	flgt.month = 7
AND 
	flgt.day = 5
GROUP BY plns.manufacturer
ORDER BY plns.manufacturer ASC

/* LEFT OUTER JOIN */
SELECT plns.manufacturer
	, SUM(flgt.distance)
FROM flg.flights flgt LEFT OUTER JOIN flg.planes plns ON flgt.tailnum = plns.tailnum
WHERE 
	flgt.month = 7
AND 
	flgt.day = 5
GROUP BY plns.manufacturer
ORDER BY plns.manufacturer ASC

/*4. Write and answer at least one question of your own choosing that joins information from at least three of the
 *	tables in the flights database. */
/* Assuming the snowing temperature is less than 32F; 
	what is the the manufacturer that have the most number of flights under this weather condition*/
/*Answer : The manufacturer that have the most flights when there is snowing temperature are Embraer, Boeing and Airbus */
Create TEMPORARY TABLE tem1
SELECT FLGT.origin, FLGT.dest, FLGT.tailnum,WETH.temp, PLNS.manufacturer, PLNS.model
FROM flg.flights FLGT, flg.weather WETH, flg.planes PLNS
WHERE
FLGT.origin = WETH.origin
AND FLGT.month = WETH.month
AND FLGT.day = WETH. day
AND FLGT.hour = WETH.hour
AND WETH.temp < 32
AND FLGT.tailnum = PLNS.tailnum

SELECT manufacturer, count(manufacturer) AS NO_of_flights 
-- count(manufacturer)
FROM tem1
GROUP BY manufacturer
ORDER BY NO_of_flights DESC

