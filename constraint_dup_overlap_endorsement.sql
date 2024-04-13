use t6;


create function checkDupOverLapEndorsement (@CID int,@BID int,@SDate Date,@EDate Date)
returns smallint
as
begin
	declare @count smallint=0;
	--check for duplicate records
	select @count = COUNT(*)
					from Endorsement
					where CelebrityID = @CID and BrandID = @BID and StartDate = @SDate;
	if @count > 1
	begin
		return 1; -- duplicates found
	end
	--check for overlapping records
	select @count = COUNT(*)
					from Endorsement
					where CelebrityID = @CID and BrandID = @BID
						and (((@SDate between StartDate and EndDate)or (@EDate between StartDate and EndDate))
							or (@SDate<StartDate and @EDate>EndDate));
	if @count > 1 
	begin 
		return 2; -- overlaps found
	end
	
	return 0; --no duplicates or overlaps found
end;


alter table Endorsement 
add constraint DupOverlapEndorsement
check (dbo.checkDupOverlapEndorsement(CelebrityID, BrandID,StartDate, EndDate)=0);


--duplicate -- same StartDate
insert into Endorsement(CelebrityID, BrandID, Title, StartDate, EndDate)
values (1,1,'Ambassador','2020-01-01','2026-12-31');
--overlap --startdate between the other range
insert into Endorsement(CelebrityID, BrandID, Title, StartDate, EndDate)
values (1,1,'Endorser','2021-01-01','2026-12-31');
-- new date range cover the older
insert into Endorsement(CelebrityID, BrandID, Title, StartDate, EndDate)
values (1,1,'Ambassador','2019-01-01','2026-12-31');
-- no duplicates or overlaps, so can be inserted
insert into Endorsement(CelebrityID, BrandID, Title, StartDate, EndDate)
values (1,1,'Endorser','2019-01-01','2019-12-31');

