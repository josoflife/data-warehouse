   PRINT ' INSERTING THE SILVER LAYER';
   PRINT'TRUNKING TABLE: silver.crm_cust_info';
   
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

PRINT 'TRUNKING TABLE: silver.crm_prd_info';
TRUNCATE TABLE silver.crm_prd_info;

INSERT INTO silver.crm_prd_info(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start,
prd_end_dt
)

SELECT
prd_id,
REPLACE(SUBSTRING(prd_key, 1, 5),'-', '_') AS cat_id,
SUBSTRING (prd_key, 7 ,LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost, 0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
     WHEN 'M' THEN 'MOUNTAIN'
     WHEN 'R' THEN 'ROAD'
     WHEN 'S' THEN 'OTHER SALES'
     WHEN 'T' THEN 'TOURING'
     ELSE 'N/A'
END AS prd_line,
CAST(prd_start AS DATE) AS prd_start,
DATEADD(DAY, -1, LEAD(prd_start) OVER (PARTITION BY prd_key ORDER BY prd_start)) AS prd_end_dt
FROM bronze.crm_prd_info

PRINT 'TRUNKING TABLE: silver.crm_sales_details';
TRUNCATE TABLE silver.crm_sales_details;
INSERT INTO silver.crm_sales_details(
sls_order_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_date,
sls_due_date,
sls_sales,
sls_quantity,
sls_price
)
SELECT
sls_order_num,
sls_prd_key,
sls_cust_id,
 CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt)!=8 then null
   else CAST(CAST(sls_order_dt AS VARCHAR) AS DATE )
END  AS sls_order_date,
 CASE WHEN sls_ship_date = 0 OR LEN(sls_ship_date)!=8 then null
   else CAST(CAST(sls_ship_date AS VARCHAR) AS DATE )
END  AS sls_ship_date,
 CASE WHEN sls_due_date = 0 OR LEN(sls_due_date)!=8 then null
   else CAST(CAST(sls_due_date AS VARCHAR) AS DATE )
END  AS sls_due_date,
CASE WHEN sls_sales IS NULL OR sls_sales!= sls_quantity * ABS(sls_price)
         THEN sls_quantity*ABS(sls_price)
  else sls_sales
  END AS  sls_sales,
sls_quantity,
CASE WHEN sls_price IS NOT NULL OR  sls_price <=0
     THEN sls_sales/  NULLIF(sls_quantity, 0)
      else sls_price
end as sls_price
from bronze.crm_sales_details


PRINT'TRUNKING TABLE:  silver.erp_cust_AZ12';
TRUNCATE TABLE silver.erp_cust_AZ12;

INSERT INTO silver.erp_cust_AZ12(

cust_cid,
cust_Bdate,
cust_gender)

SELECT
CASE WHEN cust_cid LIKE 'NAS%' THEN SUBSTRING (cust_cid,4 , LEN(cust_cid))
else cust_cid
end as cust_cid,
CASE WHEN cust_Bdate > GetDATE() THEN NULL
ELSE cust_Bdate
end as custBdate,
case  when UPPER(TRIM(cust_gender)) IN ('F','FEMALE') THEN 'Female'
      WHEN UPPER(TRIM(cust_gender))IN ('M', 'MALE') THEN 'Male'
      ELSE 'N/A'
  END AS cust_gender
FROM bronze.erp_cust_AZ12

PRINT'TRUNKING TABLE : silver.erp_loc_A102';
TRUNCATE TABLE silver.erp_loc_A102;
INSERT INTO silver.erp_loc_A102(
loc_cid,
loc_cntry)

SELECt
REPLACE (loc_cid, '-', '') loc_cid,
CASE  WHEN TRIM(loc_cntry) = 'DE' THEN 'GERMANY'
      WHEN TRIM(loc_cntry) IN ('US' , 'USA') THEN 'united states'
      WHEN TRIM(loc_cntry) = '' OR loc_cntry IS NULL THEN 'N/A'
      ELSE TRIM(loc_cntry)
END AS loc_cntry
FROM bronze.erp_loc_A102


PRINT'TRUNKING TABLE :silver.erp_px_cat_g1v2';
TRUNCATE TABLE silver.erp_px_cat_g1v2;
insert into silver.erp_px_cat_g1v2(
px_cat_id,
px_cat_cat,
px_cat_subcat,
px_cat_maintanace)

select
px_cat_id,
px_cat_cat,
px_cat_subcat,
px_cat_maintanace
from bronze.erp_px_cat_g1v2

