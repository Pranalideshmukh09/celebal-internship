1683. Invalid Tweets

SELECT tweet_id
FROM TWEETS
WHERE CHAR_LENGTH(content) > 15;