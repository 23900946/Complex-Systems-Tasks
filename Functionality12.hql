SELECT places.price, avg(reviews.rating) FROM reviews INNER JOIN places on reviews.placeid=places.placeid WHERE places.price LIKE '%$%' GROUP BY places.price ORDER BY places.price asc;
