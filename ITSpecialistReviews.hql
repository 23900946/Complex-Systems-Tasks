use default;
SELECT users.userid, reviews.reviewText, users.jobs FROM users INNER JOIN reviews ON users.userid=reviews.userid WHERE users.jobs='IT Specialist';

