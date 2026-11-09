/*
========================================================================
Stored Procedure: Load Bronze Layer(Source -> Bronze)
========================================================================
Script Purpose: 
This stored procedure loads data into the 'bronze' schema from external csv.files
It Performs the following actions:
-Truncate the bronze tables before loading the data
-uses the 'Bulk insert' command to load the data from source data(csv files) to bronze layer

Parameters:
None 
This stored procedure didnt accept any parameters or return any values


Usage Example:
Exec bronze.load_bronze

*/


create or alter procedure bronze.load_bronze as
begin
declare @start_time datetime , @end_time datetime , @batch_start_time datetime , @batch_end_time datetime 
	begin try 
	set @batch_start_time = getdate()
		--data load into the crm tables using bulk insert

		--bulk insert for [bronze].[crm_cust_info] 
		set @start_time = getdate()
	
		print ' >> Truncing table:[bronze].[crm_cust_info]';
		Truncate table [bronze].[crm_cust_info]
		print ' >> inserting data into: [bronze].[crm_cust_info]';
		bulk insert [bronze].[crm_cust_info]
		from 'D:\Data_Engineer\sql-data-warehouse-project\01_datasets\source_crm\cust_info.csv'

		with
		(
		firstrow = 2,
		fieldterminator = ',',
		tablock
		)

	   set @end_time = getdate()
	   print '>> load duration:' + cast(datediff(second,@start_time, @end_time) as varchar) + 'seconds';
	   print '---------------------------------';


		--bulk insert for bronze.crm_pdf_info 
		set @start_time = getdate()

		print ' >> Truncing table: [bronze].[crm_pdf_info]';
		truncate table [bronze].[crm_pdf_info]
		print ' >> inserting data into: [bronze].[crm_pdf_info]';
		bulk insert [bronze].[crm_pdf_info]
		from 'D:\Data_Engineer\sql-data-warehouse-project\01_datasets\source_crm\prd_info.csv' 
		with
		(
		firstrow = 2,
		fieldterminator = ',',
		tablock
		)

		set @end_time = getdate()
		print '>> load duration:' + cast(datediff(second,@start_time, @end_time) as varchar) + 'seconds';
		  print '---------------------------------';

		--bulk insert data to bronze.crm_sales_details
		set @start_time = getdate()

		print ' >> Truncing table: [bronze].[crm_sales_details]';
		truncate table  [bronze].[crm_sales_details]
		print ' >> inserting data into: [bronze].[crm_sales_details]';
		bulk insert [bronze].[crm_sales_details]
		from 'D:\Data_Engineer\sql-data-warehouse-project\01_datasets\source_crm\sales_details.csv'
		with
		(
		firstrow = 2,
		fieldterminator = ',',
		tablock
		)

		set @end_time = getdate()
		print '>> load duration:' + cast(datediff(second,@start_time, @end_time) as varchar) + 'seconds';
		print '---------------------------------';


		--data loading into the erp table by using bulk insert

	
		--bulk insert data to [bronze].[erp_cust_az12]
		set @start_time = getdate()

		print ' >> Truncing table: bronze.erp_cust_az12';
		truncate table [bronze].[erp_cust_az12]
		print ' >> inserting data into: [bronze].[erp_cust_az12]';
		bulk insert [bronze].[erp_cust_az12]
		from 'D:\Data_Engineer\sql-data-warehouse-project\01_datasets\source_erp\CUST_AZ12.csv'
		with
		(
		firstrow = 2,
		fieldterminator = ',',
		tablock 
		)

		set @end_time = getdate()
		print '>> load duration:' + cast(datediff(second,@start_time, @end_time) as varchar) + 'seconds';
		print '---------------------------------';
		
		--bulk insert data to [bronze].[erp_loc_a101]
		set @start_time = getdate()

		print ' >> Truncing table:[bronze].[erp_loc_a101]';
		truncate table [bronze].[erp_loc_a101]
		print ' >> inserting data into: [bronze].[erp_loc_a101]';
		bulk insert  [bronze].[erp_loc_a101]
		from 'D:\Data_Engineer\sql-data-warehouse-project\01_datasets\source_erp\LOC_A101.csv'
		with
		(
		firstrow = 2,
		fieldterminator = ',',
		tablock 
		)

		set @end_time = getdate()
		print '>> load duration:' + cast(datediff(second,@start_time, @end_time) as varchar) + 'seconds';
		print '---------------------------------';
		--bulk insert data to [bronze].[erp_px_cat_g1v2]
		set @start_time = getdate()

		print ' >> Truncing table: [bronze].[erp_px_cat_g1v2]';
		truncate table [bronze].[erp_px_cat_g1v2]
		print ' >> inserting data into: [bronze].[erp_px_cat_g1v2]';
		bulk insert [bronze].[erp_px_cat_g1v2]
		from 'D:\Data_Engineer\sql-data-warehouse-project\01_datasets\source_erp\PX_CAT_G1V2.csv'
		with
		(
		firstrow = 2,
		fieldterminator = ',',
		tablock 
		)

		set @end_time = getdate()
		print '>> load duration:' + cast(datediff(second,@start_time, @end_time) as varchar) + 'seconds';
		print '---------------------------------';

		set @batch_end_time = getdate()
		print('========================================================');
		print('Total Loading time of bronze layer');
		print('loading time : ' + cast(datediff(second,@batch_start_time, @batch_end_time)as varchar)) ;
    end try 
	begin catch
		print('==============================================');
		print('error accuring during the load at bronze layer');
		print 'error massage' + error_message();
		print('error number'  + cast(error_number() as varchar));
		print('==============================================');
    end catch

end 
