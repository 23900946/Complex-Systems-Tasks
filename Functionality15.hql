SELECT count(reviews.placeid) as reviewCount, places.name as name, places.placeid as placeID
FROM reviews INNER JOIN places on reviews.placeid = places.placeid 
GROUP BY reviews.placeid, places.name, places.placeid ORDER BY reviewCount DESC LIMIT 1;


