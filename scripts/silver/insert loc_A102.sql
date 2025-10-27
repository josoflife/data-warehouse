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