IF OBJECT_ID('bronze.crm_cust_info')IS NOT NULL
DROP TABLE bronze.crm_cust_info
CREATE TABLE bronze.crm_cust_info(
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_marital_status NVARCHAR(50),
cst_gender NVARCHAR(50),
cst_create_date DATE
);

IF OBJECT_ID('bronze.crm_prd_info')IS NOT NULL
DROP TABLE bronze.crm_prd_info
CREATE TABLE bronze.crm_prd_info(
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line nvarchar(50),
prd_start Date,
prd_end_dt Date,
);

IF OBJECT_ID('bronze.crm_sales_details')IS NOT NULL
DROP TABLE bronze.crm_sales_details
CREATE TABLE bronze.crm_sales_details(
sls_order_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_date INT,
sls_due_date INT,
sls_sales INT,
sls_quantity INT,
sls_price INT,
);

IF OBJECT_ID('bronze.erp_cust_AZ12')IS NOT NULL
DROP TABLE bronze.erp_cust_AZ12
CREATE TABLE bronze.erp_cust_AZ12(
cust_cid NVARCHAR(50),
cust_Bdate DateTIME,
cust_Gender NVARCHAR(50),
);

IF OBJECT_ID('bronze.erp_loc_A102')IS NOT NULL
DROP TABLE bronze.erp_loc_A102
CREATE TABLE bronze.erp_loc_A102(
loc_cid NVARCHAR(50),
loc_cntry NVARCHAR(50),
);

IF OBJECT_ID('bronze.erp_px_cat_g1v2')IS NOT NULL
DROP TABLE bronze.erp_px_cat_g1v2

CREATE TABLE bronze.erp_px_cat_g1v2(
px_cat_id NVARCHAR(50),
px_cat_cat NVARCHAR(50),
px_cat_subcat NVARCHAR(50),
px_cat_maintanace NVARCHAR(50),
)
