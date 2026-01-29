/*
Business Question 1
Which business categories receive the most reviews
*/

WITH business_categories AS (
    SELECT
        b.name AS business_name,
        TRIM(c.value) AS category
    FROM tbl_yelp_businesses b,
         LATERAL SPLIT_TO_TABLE(b.categories, ',') c
)
SELECT
    category,
    COUNT(business_name) AS total_businesses
FROM business_categories
GROUP BY category
ORDER BY total_businesses DESC;


/*
Business Question 2
Top 10 users by number of reviews
*/

SELECT
    user_id,
    COUNT(*) AS total_reviews
FROM tbl_yelp_reviews
GROUP BY user_id
ORDER BY total_reviews DESC
LIMIT 10;


/*
Business Question 3
Top 10 users reviewing restaurants
*/

SELECT
    r.user_id,
    COUNT(*) AS total_reviews
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b
ON r.business_id = b.business_id
WHERE b.categories ILIKE '%restaurant%'
GROUP BY r.user_id
ORDER BY total_reviews DESC
LIMIT 10;


/*
Business Question 4
Most recent restaurant reviews
*/

SELECT
    b.name,
    r.review_date
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b
ON r.business_id = b.business_id
WHERE b.categories ILIKE '%restaurant%'
ORDER BY r.review_date DESC
LIMIT 3;


/*
Business Question 5
Top 3 most recent reviews per business
*/

WITH ranked_reviews AS (
    SELECT
        r.review_text,
        b.name,
        r.review_date,
        ROW_NUMBER() OVER (
            PARTITION BY b.business_id
            ORDER BY r.review_date DESC
        ) AS row_num
    FROM tbl_yelp_reviews r
    JOIN tbl_yelp_businesses b
    ON r.business_id = b.business_id
)
SELECT
    review_text,
    name,
    review_date
FROM ranked_reviews
WHERE row_num <= 3;


/*
Business Question 6
Month with highest number of reviews
*/

SELECT
    MONTH(review_date) AS review_month,
    COUNT(*) AS total_reviews
FROM tbl_yelp_reviews
GROUP BY review_month
ORDER BY total_reviews DESC;


/*
Business Question 7
Percentage of five star reviews per business
*/

SELECT
    b.name,
    COUNT(*) AS total_reviews,
    SUM(CASE WHEN r.review_stars = 5 THEN 1 ELSE 0 END) AS five_star_reviews,
    (SUM(CASE WHEN r.review_stars = 5 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS five_star_percentage
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b
ON r.business_id = b.business_id
GROUP BY b.name;


/*
Business Question 8
Top 5 businesses reviewed in each city
*/

WITH city_rankings AS (
    SELECT
        b.city,
        b.name,
        COUNT(*) AS total_reviews,
        ROW_NUMBER() OVER (
            PARTITION BY b.city
            ORDER BY COUNT(*) DESC
        ) AS row_num
    FROM tbl_yelp_reviews r
    JOIN tbl_yelp_businesses b
    ON r.business_id = b.business_id
    GROUP BY b.city, b.name
)
SELECT
    city,
    name,
    total_reviews
FROM city_rankings
WHERE row_num <= 5;


/*
Business Question 9
Top users and businesses they reviewed
*/

WITH top_users AS (
    SELECT
        user_id
    FROM tbl_yelp_reviews
    GROUP BY user_id
    ORDER BY COUNT(*) DESC
    LIMIT 10
)
SELECT
    r.user_id,
    r.business_id
FROM tbl_yelp_reviews r
WHERE r.user_id IN (SELECT user_id FROM top_users)
GROUP BY r.user_id, r.business_id
ORDER BY r.user_id;


/*
Business Question 10
Businesses with highest positive sentiment reviews
*/

SELECT
    b.business_id,
    b.name,
    COUNT(*) AS positive_reviews
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b
ON r.business_id = b.business_id
WHERE analyze_sentiment(r.review_text) = 'Positive'
GROUP BY b.business_id, b.name
ORDER BY positive_reviews DESC
LIMIT 10;
