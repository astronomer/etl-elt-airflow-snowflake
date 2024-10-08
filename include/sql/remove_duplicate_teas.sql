CREATE OR REPLACE TABLE temp_teas AS
SELECT * 
FROM teas
WHERE 1=0; 

INSERT INTO temp_teas (TEA_ID, TEA_NAME, TEA_TYPE, PRICE, UPDATED_AT) 
SELECT TEA_ID, TEA_NAME, TEA_TYPE, PRICE, UPDATED_AT
FROM (
    SELECT TEA_ID, TEA_NAME, TEA_TYPE, PRICE, UPDATED_AT,
           ROW_NUMBER() OVER (PARTITION BY TEA_ID ORDER BY UPDATED_AT DESC) AS row_num
    FROM teas
)
WHERE row_num = 1;

TRUNCATE TABLE teas;

INSERT INTO teas
SELECT * FROM temp_teas;

DROP TABLE IF EXISTS temp_teas;