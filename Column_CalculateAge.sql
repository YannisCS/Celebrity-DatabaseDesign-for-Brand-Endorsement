USE t6;

DROP FUNCTION CalculateAge

CREATE FUNCTION CalculateAge
(
    @BirthDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;

    SET @Age = DATEDIFF(YEAR, @BirthDate, GETDATE()) - 
               CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, @BirthDate, GETDATE()), @BirthDate) > GETDATE() THEN 1 ELSE 0 END;

    RETURN @Age;
END;

CalculateAge

ALTER TABLE Celebrity
ADD Age AS CalculateAge(DOB);