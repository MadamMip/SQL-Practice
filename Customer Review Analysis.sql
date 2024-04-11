-- question 1 The average rating of each product

SELECT 
    CAST(p.product_name AS NVARCHAR(MAX)),
    AVG(rv.rating) AS average_rating
FROM Products AS p
LEFT JOIN Reviews AS rv ON p.product_id = rv.product_id
GROUP BY CAST(p.product_name AS NVARCHAR(MAX))

-- question 2 Customer whose rating is more than 4

select 
	name,
	rating,
	contact_info
from sample..Customers
join sample..Reviews
	on sample..Customers.customer_id = sample..Reviews.customer_id
where rating > 4

-- question 3 How many times do the customer post their review?

select
	cast(c.name as nvarchar(max)) as 'review_name',
	count(r.review_id) as 'times'
from sample..Customers as c
join sample..Reviews as r
	on c.customer_id = r.customer_id
group by cast(c.name as nvarchar(max))
order by  times desc

-- easy version

select 
	customer_id,
	count(review_id)
from sample..Reviews
group by customer_id

-- question 4 avg rating of each day of the week?

select
	days_of_week,
	avg_rate 
from (
	select
		format(cast(date as DATE), 'ddd') as days_of_week,
		avg(rating) as avg_rate
	from Reviews
	group by format(cast(date as DATE), 'ddd')
	) as subquery
order by avg_rate desc

-- question 5 Which product got rating above or equal to 3.5?

select
	cast(product_name as nvarchar(max)) as product,
	avg(rating) as avg_rate
from Products P
join Reviews R
	on P.product_id = R.product_id
group by cast(product_name as nvarchar(max))
having avg(rating) >= 3.5

-- question 6 count the reviews that got 'disappointed' in the comment

select
	count(cast(review_text as nvarchar(max))) as negative_review
from Reviews
where review_text like '%disappointed%'

-- question 7 which customer post positive review
--(excellent, impressive, recommend) and give more than 4 rating?

select
	name,
	R.rating,
	R.review_text
from Reviews R
join Customers C
	on R.customer_id = C.customer_id
where R.rating >= 4
and (
	review_text like '%impressive%'
	or review_text like '%excellent%'
	or review_text like '%recommend%'
	)

-- question 8 find avg word each customer write their reviews

select
	C.customer_id,
	cast(C.name as nvarchar(max)) as Customer,
	avg(review_len) avg_len_review
from (
	select
		customer_id,
		len(cast(review_text as nvarchar(max))) as review_len
	from Reviews 
	) as subquery
JOIN Customers C 
	ON subquery.customer_id = C.customer_id
group by C.customer_id, cast(C.name as nvarchar(max))
