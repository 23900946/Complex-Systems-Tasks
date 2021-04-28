SELECT AVG(rating) as Average_Rating, categories FROM reviews GROUP BY categories ORDER BY Average_Rating DESC LIMIT 5;
