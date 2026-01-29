# Yelp Open Dataset Analysis

## Summary

Built an end to end data pipeline using the Yelp Open Dataset to demonstrate large scale data ingestion, cloud integration, Snowflake data modeling, sentiment analysis, and analytical SQL querying.

The project showcases how raw semi structured data can be transformed into structured insights using Python, AWS, and Snowflake.

## Data Pipeline

- Processed multi GB Yelp review JSON data locally using Python  
- Split large files into smaller chunks for efficient ingestion  
- Uploaded processed files to AWS S3  
- Loaded JSON data into Snowflake using COPY INTO and VARIANT columns  
- Transformed raw data into structured review and business tables  
- Implemented Python based sentiment analysis using a Snowflake UDF  

## Technologies Used

- Python and Jupyter Notebook  
- AWS S3  
- Snowflake  
- SQL  
- Snowflake Python UDF  
- TextBlob  

## Analytics Performed

- Business category level review analysis  
- Identification of top reviewers and most reviewed businesses  
- Restaurant specific review trends  
- Time based analysis of review activity  
- Sentiment based ranking of businesses  

## Sample Business Questions Answered

- Which categories receive the highest number of reviews  
- Who are the most active Yelp users  
- Which restaurants have the most recent reviews  
- What percentage of reviews are five star  
- Which businesses have the highest positive sentiment  


## Key Skills Demonstrated

- Large scale data handling  
- Cloud data ingestion using AWS and Snowflake  
- Semi structured data modeling  
- Analytical SQL and window functions  
- In database Python based sentiment analysis  

