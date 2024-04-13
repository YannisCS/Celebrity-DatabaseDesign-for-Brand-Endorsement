USE t6;

DROP VIEW NewsSummary;

CREATE VIEW NewsSummary AS

WITH table1 as(
SELECT c.FirstName + ' ' + c.LastName AS 'Celebrity',
		n.TwitterLink,
		n.Keyword,
		cn.CelebrityID,
		n.NewsID,
		n.Views
FROM News n 
JOIN CelebrityNews cn ON n.NewsID = cn.NewsID
JOIN Celebrity c ON cn.CelebrityID = c.CelebrityID
),

table2 as(
SELECT table1.CelebrityID,
		Celebrity,
		table1.TwitterLink,
		table1.Keyword,
		table1.Views,
		CASE
			WHEN table1.CelebrityID != cn.CelebrityID THEN c.FirstName + ' ' + c.LastName 
			ELSE NULL
		END
		as 'Related'
from table1
JOIN CelebrityNews cn on table1.NewsID=cn.NewsID 
JOIN Celebrity c on cn.CelebrityID = c.CelebrityID
)

SELECT CelebrityID,
		Celebrity,
		TwitterLink,
		Keyword,
		Views,
		STRING_AGG(
		Related, ', '
		) AS 'RelatedCelebrities'
FROM table2
GROUP BY CelebrityID, Celebrity, TwitterLink, Keyword, Views;
