drop table #Temp
drop table #temp1
set nocount on
CREATE TABLE #Temp
(Text  NVARCHAR(4000) COLLATE database_default,
 Num   INT)

 DECLARE @Num INT, @sp NVARCHAR(200)
 SELECT @Num = 0

select ROW_NUMBER() OVER (ORDER BY ID) AS Ord,name
  into #temp1
  from sysobjects where xtype in ('P')
    
WHILE(1=1)
BEGIN

    select @Num = MIN(Ord)
      from #temp1
     where Ord > @Num

    select @sp = name
      from #temp1
     where Ord = @Num

     If @Num IS NULL
        BREAK

    insert into #Temp
    select '',0 union all
    select '-- ' + CONVERT(NVARCHAR(10),@Num) + '¹øÂ° SP',0 union all
    select '',0

    exec sys_helptext_union @sp, @Num

END

select Text from #Temp