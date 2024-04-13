
CREATE FUNCTION calculatefans(@CelebrityID INT)
RETURNS INT
AS
BEGIN
    DECLARE @fans INT = 
        (SELECT SUM(FanAmount)
         FROM Account 
         WHERE CelebrityID = @CelebrityID);
    SET @fans = ISNULL(@fans, 0);
    RETURN @fans;
END


ALTER TABLE Celebrity
ADD FansAmount AS (dbo.calculatefans(CelebrityID));