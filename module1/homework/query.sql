-- During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, respectively, happened:
-- Up to 1 mile
-- In between 1 (exclusive) and 3 miles (inclusive),
-- In between 3 (exclusive) and 7 miles (inclusive),
-- In between 7 (exclusive) and 10 miles (inclusive),
-- Over 10 miles
select 
	case 
		when trip_distance <= 1.0 then 'Up to 1 mile'
		when trip_distance > 1.0 and trip_distance <= 3.0 then '1-3 miles'
		when trip_distance > 3.0 and trip_distance <= 7.0 then '3-7 miles'
		when trip_distance > 7.0 and trip_distance <= 10.0 then '7-10 miles'
		else 'Over 10 miles'
	end as distance,
	count(*) as num_trips
from "green_taxi_trips_2019-10"
where lpep_pickup_datetime >= '2019-10-01'
    and lpep_pickup_datetime < '2019-11-01'
    and lpep_dropoff_datetime >= '2019-10-01'
    and lpep_dropoff_datetime < '2019-11-01'
group by distance

-- Which was the pick up day with the longest trip distance?
select max(trip_distance) as distance, to_char(lpep_pickup_datetime, 'YYYY-MM-DD') as day
from "green_taxi_trips_2019-10"
group by to_char(lpep_pickup_datetime, 'YYYY-MM-DD')
order by distance DESC
limit 1

-- Which were three top pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18?
select z.Zone,
	sum(total_amount) as total_amount
from "green_taxi_trips_2019-10" g
join "zones" z on g.PULocationID = z.LocationID
where lpep_pickup_datetime:: = '2019-10-18'
group by z.Zone
having sum(total_amount) > 13000
limit 3

-- For the passengers picked up in October 2019 in the zone named "East Harlem North" which was the drop off zone that had the largest tip?
select puz.zone as pickup_zone,
    doz.zone as dropoff_zone,
    g.tip_amount
from "green_taxi_trips_2019-10" g
join "zones" puz on g.PULocationID = puz.LocationID
join "zones" doz on g.DOLocationID = doz.LocationID
where puz.Zone = 'East Harlem North'
and to_char(lpep_pickup_datetime, 'YYYY-MM') = '2019-10'
order by g.tip_amount desc
limit 1
