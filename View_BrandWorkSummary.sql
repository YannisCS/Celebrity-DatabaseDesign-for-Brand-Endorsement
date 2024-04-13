USE t6;

DROP VIEW BrandWork;

CREATE VIEW BrandWork AS

WITH table1 AS(
SELECT b.Name [Brand],
		c.FirstName + ' ' + c.LastName [Celebrity],
		w.[Type]
FROM Endorsement e 
JOIN Brand b ON b.BrandID = e.BrandID 
JOIN Celebrity c ON e.CelebrityID = c.CelebrityID 
LEFT JOIN Participation p ON p.CelebrityID = e.CelebrityID 
JOIN [Work] w ON p.WorkID = w.WorkID),

table2 AS(
SELECT Brand,Celebrity,[Type],COUNT([Type]) as [No]
FROM table1
GROUP BY Brand, Celebrity, [Type]
UNION
SELECT Brand,'Overall' as [Celebrity],[Type],COUNT([Type]) 
FROM table1
GROUP BY Brand, [Type])

SELECT Brand,Celebrity,[music],[movie],[TV series]
FROM table2
PIVOT(
	SUM([No])
	FOR [Type] IN ([music], [movie], [TV series])
) as P;

