USE data.hackaton;
CREATE TABLE lineitem_1994_receipt
WITH (
  format = 'PARQUET'
) AS
WITH 
-- Первый этап: фильтрация по дате получения и способу доставки
receipt_shipmode_filtered AS (
    SELECT *
    FROM lineitem
    WHERE receiptdate >= DATE '1994-01-01'
      AND receiptdate < DATE '1994-01-01' + INTERVAL '1' YEAR
      AND shipmode IN ('MAIL', 'SHIP') -- Исправлены опечатки (MAIL/SHIP)
),
-- Второй этап: проверка commitdate < receiptdate
commitdate_filtered AS (
    SELECT *
    FROM receipt_shipmode_filtered
    WHERE commitdate < receiptdate
),
-- Третий этап: проверка shipdate < commitdate
shipdate_filtered AS (
    SELECT *
    FROM commitdate_filtered
    WHERE shipdate < commitdate
)
-- Финальный результат
SELECT * FROM shipdate_filtered;
