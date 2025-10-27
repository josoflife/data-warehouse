TRUNCATE TABLE silver.erp_px_cat_g1v2;
 print'inserting data into :silver.erp_px_cat_g1v2';

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