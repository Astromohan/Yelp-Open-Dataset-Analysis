/*
Purpose
Load Yelp JSON files from AWS S3 into Snowflake using COPY INTO
*/

CREATE OR REPLACE TABLE yelp_reviews_raw (
    review_data VARIANT
);

COPY INTO yelp_reviews_raw
FROM 's3://your-s3-bucket/yelp/'
FILE_FORMAT = (TYPE = JSON);

/*
Credentials intentionally omitted.
Use IAM roles or secure secrets management.
*/