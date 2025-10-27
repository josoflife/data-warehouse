

TRUNCATE TABLE silver.erp_cust_AZ12;
 print'inserting data into  :silver.erp_cust_AZ12';
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