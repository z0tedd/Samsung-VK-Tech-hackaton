USE data.hackaton;
CREATE TABLE lineitem_sept_1995
WITH (
  format = 'PARQUET'
) AS
WITH 
-- Первый этап: фильтрация по периоду доставки
shipdate_filtered AS (
    SELECT *
    FROM lineitem
    WHERE shipdate >= DATE '1995-09-01'
      AND shipdate < DATE '1995-09-01' + INTERVAL '1' MONTH
)
-- Финальный результат
SELECT * FROM shipdate_filtered;
