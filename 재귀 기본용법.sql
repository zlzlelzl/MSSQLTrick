WITH tmp_TPDBOM(GoodCd, ItemCd) AS (
	SELECT
		GoodCd,
        ItemCd
	FROM
		TPDBOM WITH(NOLOCK)
	WHERE
		GoodCd = '000004'
	UNION ALL
	SELECT
		A.GoodCd,
        A.ItemCd
	FROM
		TPDBOM A,
		tmp_TPDBOM B
	WHERE
		A.GoodCd = B.Itemcd
)
SELECT top 50 * FROM tmp_TPDBOM
