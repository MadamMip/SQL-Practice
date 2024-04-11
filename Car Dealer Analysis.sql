-- question 1 which type of vehicle got the largest total sales?

select
	cast(VehicleType as nvarchar(max)) as CarType,
	sum(Price) as TotalSales
from Vehicle
group by cast(VehicleType as nvarchar(max))
order by TotalSales desc

-- question 2 who sale the most and find each Salesperson total sale?

select
	cast(CONCAT(P.FirstName, ' ', P.LastName) as nvarchar(max)) as FullName,
	T.SalespersonID as ID,
	count(T.SalespersonID) as Sales
from SalesTransaction T
join Salesperson P
	on T.SalespersonID = P.SalespersonID
group by T.SalespersonID, cast(CONCAT(P.FirstName, ' ', P.LastName) as nvarchar(max))
order by Sales desc

-- question 3 Find each salesperson total revenue?

select
	cast(concat(SP.FirstName, ' ', SP.LastName) as nvarchar(max))as FullName,
	ST.SalespersonID,
	sum(V.Price) as TotalRevenue
from SalesTransaction ST
join Vehicle V
	on ST.VehicleID = V.VehicleID
join Salesperson SP
	on SP.SalespersonID = ST.SalespersonID
group by ST.SalespersonID,
		cast(concat(SP.FirstName, ' ', SP.LastName) as nvarchar(max))
order by TotalRevenue desc

-- question 4 In 2023 which fuel type got the most sell?

select
	cast(FuelType as nvarchar(max)) as Fuel_Type,
	count(cast(FuelType as nvarchar(max))) as Sales
from SalesTransaction ST
join Vehicle V
	on ST.VehicleID = V.VehicleID
WHERE YEAR(SaleDate) = 2023 
	and cast(FuelType as nvarchar(max)) in ('Electric', 'Petrol')
group by cast(FuelType as nvarchar(max))
order by Sales desc

-- question 5 group car model 
-- if price is more than or equal to 1000000 the 'Flagship Model'
-- if price is lower than 1000000 then 'Normal Model'

select
	ModelName,
	Price,
		case
			when Price >= 1000000 then 'Flagship Model'
			else 'Normal Model'
		end as ModelLabel
from Vehicle
order by Price desc