/*
Purpose
Snowflake UDF to classify Yelp review sentiment
*/

CREATE OR REPLACE FUNCTION analyze_sentiment(text STRING)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.8'
PACKAGES = ('textblob')
HANDLER = 'sentiment_analyzer'
AS
$$
from textblob import TextBlob

def sentiment_analyzer(text):
    analysis = TextBlob(text)
    polarity = analysis.sentiment.polarity

    if polarity > 0:
        return 'Positive'
    elif polarity == 0:
        return 'Neutral'
    else:
        return 'Negative'
$$;
