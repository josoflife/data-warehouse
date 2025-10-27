   TRUNCATE TABLE  silver.crm_cust_info;
   
   INSERT INTO silver.crm_cust_info(
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gender,
    cst_create_date)
SELECT  
 cst_id,
 cst_key,
 TRIM(cst_firstname) AS cst_firstname,
 TRIM(cst_lastname) AS cst_lastname,
 
 CASE WHEN UPPER(TRIM(cst_marital_status))='M' THEN 'MARRIED'
      WHEN UPPER(TRIM(cst_marital_status))='S' THEN 'SINGLE'
      ELSE 'N/A'
 END AS cst_marital_status,
 CASE WHEN UPPER(TRIM(cst_gender))='F' THEN 'FEMALE'
      WHEN UPPER(TRIM(cst_gender))='M' THEN 'MALE'
      ELSE 'N/A'
 END AS cst_gender,
 cst_create_date
FROM (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
    FROM bronze.crm_cust_info
    WHERE cst_id IS NOT NULL
) t
WHERE flag_last = 1

