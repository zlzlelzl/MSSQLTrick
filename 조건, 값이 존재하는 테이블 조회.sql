drop table #Temp
drop table #temp1
set nocount on
CREATE TABLE #Temp
(Text  NVARCHAR(4000) COLLATE database_default,
 Num   INT)

 DECLARE @Num INT, @tablename NVARCHAR(200), @sql NVARCHAR(MAX) = '',
        @subcondition NVARCHAR(MAX) = ''
 SELECT @Num = 0

 -- 빈칸에 조건넣기
 select @subcondition = ''--여기에 조건넣기

select ROW_NUMBER() OVER (ORDER BY ID) AS Ord,name
  into #temp1
  from sysobjects where xtype in ('U') and  name like '%'-- 테이블명
    
WHILE(1=1)
BEGIN

     select @Num = MIN(Ord)
      from #temp1
     where Ord > @Num

    select @tablename = name
      from #temp1
     where Ord = @Num

    If @Num IS NULL
        BREAK

    If @Num <> 1
        select @sql = @sql + ' union all ' 

    if exists (select top 1 1 from sysobjects where name = @tablename)
    BEGIN
        select @sql = @sql + 'select top 1 ''' + @tablename + ''' from ' + @tablename + ' where 1=1'
        
        if isnull(@subcondition,'') <> ''
            select @sql = @sql + ' and ' + @subcondition
        
    END

    

    
     
END


execute(@sql)