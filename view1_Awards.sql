USE t6;

CREATE VIEW AwardDetailsView AS
SELECT 
    aw.AwardID,
    aw.Name AS AwardName,
    aw.Value AS AwardValue,
    awn.Date AS AwardDate,
    c.FirstName AS CelebrityFirstName,
    c.LastName AS CelebrityLastName,
    c.Country AS CelebrityCountry
FROM 
    Award aw
JOIN 
    Award_Winning awn ON aw.AwardID = awn.AwardID
JOIN 
    Celebrity c ON awn.CelebrityID = c.CelebrityID;




