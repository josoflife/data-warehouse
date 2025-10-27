TRUNCATE TABLE silver.crm_sales_details;
 print'inserting data into  :silver.crm_sales_details';

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