SELECT COUNT(rating) FROM default.reviews WHERE rating = ${hiveconf:num};
