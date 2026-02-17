-- Bronze Layer : 

Create database AirlineCustomerAnalysis;
GO
use AirlineCustomerAnalysis;

if OBJECT_ID('airline_passenger_satisfaction','U') is not null 
drop table airline_passenger_satisfaction;

GO

create table airline_passenger_satisfaction 
(
	id int,
	gender varchar(10),
	age int,
	customer_type varchar(25),
	type_of_travel varchar(20),
	class varchar(20),
	flight_distance int,
	departure_delay int,
	arrival_delay int,
	departure_and_arrival_time_convenience int,
	ease_of_online_booking int,
	checkin_service int,
	online_boarding int,
	gate_location int,
	onboard_service int,
	seat_comfort int,
	leg_room_service int,
	cleanliness int,
	food_and_drink int ,
	inflight_service int, 
	inflight_wifi_service int, 
	inflight_entertainment int,
	baggage_handling int,
	satisfaction varchar(30)
)


BULK INSERT airline_passenger_satisfaction
FROM 'C:\works\Power BI\Data\Airline+Passenger+Satisfaction\airline_passenger_satisfaction.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

use AirlineCustomerAnalysis;
select count(*) as total_count from airline_passenger_satisfaction;
select top (100) * from airline_passenger_satisfaction;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT id) AS distinct_ids
FROM airline_passenger_satisfaction;

select 
	sum(case when satisfaction is null then 1 else 0 end) as satisfaction,
	sum(case when class is null then 1 else 0 end) as class,
	sum(case when type_of_travel is null then 1 else 0 end) as travel_type,
	sum(case when age is null then 1 else 0 end) as age,
	sum(case when gender is null then 1 else 0 end) as gender
from airline_passenger_satisfaction;

select satisfaction,count(*) as counttt from airline_passenger_satisfaction
group by satisfaction;

select distinct customer_type from airline_passenger_satisfaction;
select distinct class from airline_passenger_satisfaction;

--- gold layer -- 

if OBJECT_ID('vw_airline_customer_satisfaction','V') is not null
	Drop view vw_airline_customer_satisfaction;

GO 

CREATE VIEW vw_airline_customer_satisfaction AS 
select * from airline_passenger_satisfaction;

GO

select * from vw_airline_customer_satisfaction;

