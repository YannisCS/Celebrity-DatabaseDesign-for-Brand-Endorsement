CREATE FUNCTION checkDate (@StartDate DATE, @EndDate DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;
    IF (@EndDate > @StartDate)
        SET @Result = 1;
    ELSE
        SET @Result = 0;
    RETURN @Result;
END;

ALTER TABLE Endorsement ADD CONSTRAINT checkDate CHECK (dbo.checkDate(StartDate, EndDate) = 1);
