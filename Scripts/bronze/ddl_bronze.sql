
 /*


========================================================
DDL Script: Create Bronze Tables
========================================================
script purpose:
This scrip create the tables in the 'bronze' schema, dropping the exiting table if they already exist.
Run these script to re-defined the DDL structure of 'bronze' Tables. 


*/
		
		
		print'---------------------------------------';
		print 'creating crm tables';
		print '---------------------------------------';

		if object_id('bronze.crm_cust_info','U') is not null
		drop table bronze.crm_cust_info
		Begin
		create table bronze.crm_cust_info(
			cst_id int,
			cst_key varchar(50),
			cst_firstname varchar(50),
			cst_lastname varchar(50),
			cst_marital_status varchar(50),
			cst_gndr varchar(50),
			cst_create_date date
		)
		end


		if object_id('bronze.crm_pdf_info','U') is not null
		drop table bronze.crm_pdf_info
		Begin
			create table bronze.crm_pdf_info(
			prd_id int,
			prd_key varchar(50),
			prd_nm varchar(50),
			prd_cost int,
			prd_line varchar(50),
			prd_start_dt datetime,
			prd_end_dt datetime
			)
		end

		if OBJECT_ID('bronze.crm_sales_details','U') is not null
		drop table bronze.crm_sales_details
		begin
		create table bronze.crm_sales_details
		(
			sls_ord_num varchar(50),
			sls_prd_key varchar(50),
			sls_cust_id int,
			sls_order_id int,
			sls_ship_dt int,
			sls_due_dt int,
			sls_sales int,
			sls_quantity int,
			sls_price int

		)
		end

		print'---------------------------------------';
		print 'Creating erp tables';
		print '---------------------------------------';



		--erp tables 
		if object_id('bronze.erp_cust_az12','U') is not null
		drop table bronze.erp_cust_az12
		begin
		create table bronze.erp_cust_az12
		(
			cid varchar(50),
			bdate datetime,
			gen varchar(50)
		)
		end

		if object_id('bronze.erp_loc_a101','U') is not null
		drop table bronze.erp_loc_a101
		Begin
		create table bronze.erp_loc_a101
		(
			cid varchar(50),
			cntry varchar(50)
		)
		end

		if OBJECT_ID('bronze.erp_px_cat_g1v2','U') is not null
		drop table bronze.erp_px_cat_g1v2
		begin
		create table bronze.erp_px_cat_g1v2
		(
			id varchar(50),
			cat varchar(50),
			suncat varchar(50),
			maintain varchar(50)
		)
		end
