select *
from sample..Rooms
select *
from sample..Reservations

-- question 1: type of room and how many room available?

select
	room_type,
	count(status) as 'RoomAvailable'
from sample..Rooms
where status = 'available'
group by room_type
order by RoomAvailable

select room_type, status
from sample..Rooms
where status = 'available'

-- question 2: how much is the average amount paid?

select
	AVG(amount_paid) as avg_paid
from sample..Reservations

select 
	customer_id,
	amount_paid
from sample..Reservations
where amount_paid = (select max(amount_paid) from sample..Reservations)

-- question 3: which day of the week has highest check in?

select 
	checkin_day,
	count(*) as booking
from (
	select 
		format(cast(check_in_date as DATE), 'ddd') as checkin_day
	from sample..Reservations
	) as subquery
group by checkin_day
order by booking desc

-- question 4 : which customer paid highest amount?

select
	customer_id,
	max(total_amount_paid) as max_paid,
	count(*) as book_count
from (
	select 
		customer_id,
		sum(amount_paid) as total_amount_paid
	from sample..Reservations
	group by customer_id
	) as customer_payments
group by customer_id
order by max_paid desc

select 
	customer_id,
	amount_paid
from sample..Reservations
where amount_paid = (select max(amount_paid) from sample..Reservations)

-- question 5: Calculate the hotel's occupancy rate.

SELECT 
    (CAST(COUNT(CASE WHEN status = 'occupied' THEN 1 END) AS FLOAT) / COUNT(*)) * 100 AS occupancy_rate
FROM sample..Rooms
