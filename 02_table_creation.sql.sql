/*
Purpose
Transform raw JSON data into structured Snowflake tables
*/

CREATE OR REPLACE TABLE tbl_yelp_reviews AS
SELECT
    review_data:business_id::STRING AS business_id,
    review_data:user_id::STRING AS user_id,
    review_data:date::DATE AS review_date,
    review_data:stars::NUMBER AS review_stars,
    review_data:text::STRING AS review_text
FROM yelp_reviews_raw;

CREATE OR REPLACE TABLE yelp_businesses_raw (
    business_data VARIANT
);

COPY INTO yelp_businesses_raw
FROM 's3://your-s3-bucket/yelp/yelp_academic_dataset_business.json'
FILE_FORMAT = (TYPE = JSON);

CREATE OR REPLACE TABLE tbl_yelp_businesses AS
SELECT
    business_data:business_id::STRING AS business_id,
    business_data:name::STRING AS name,
    business_data:city::STRING AS city,
    business_data:state::STRING AS state,
    business_data:review_count::NUMBER AS review_count,
    business_data:stars::NUMBER AS stars,
    business_data:categories::STRING AS categories
FROM yelp_businesses_raw;
