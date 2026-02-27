/*
===================================================================
DDL Scripts: Create Bronze Tables
===================================================================
Script Purpose:
  This Script Creates tables in the 'bronze' schema, dropping existing tables if they already exists.
Run this script to redefine the DDL structure of bronze Tables
==================================================================
*/
IF OBJECT_ID('bronze.crm_cust_info', 'U')IS NOT NULL
  DROP TABLE bronze.crm_cust_info;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
    BEGIN TRY
        PRINT '===================================';
        PRINT 'Loading Bronze Layer';
        PRINT '===================================';

        PRINT '-----------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '-----------------------------------';

        SET @start_time= GETDATE();
        PRINT '>> Truncating table: bronze.crm_cust_info'
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>> Inserting Data Into:bronze.crm_cust_info'

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\SQL DATA\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT 'Load Duration: '+ CAST(DATEDIFF(SECOND,@start_time, @end_time)AS NVARCHAR)+ 'seconds';
        PRINT '------------------------------'

        SET @start_time= GETDATE();
        PRINT '>> Truncating table: bronze.crm_prd_info'
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>> Inserting Data Into:bronze.crm_prd_info'

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\SQL DATA\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT 'Load Duration: '+ CAST(DATEDIFF(SECOND,@start_time, @end_time)AS NVARCHAR)+ 'seconds';
        PRINT '------------------------------'

        SET @start_time= GETDATE();
        PRINT '>> Truncating table: bronze.crm_sales_details'
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>> Inserting Data Into:bronze.crm_sales_details'

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\SQL DATA\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT 'Load Duration: '+ CAST(DATEDIFF(SECOND,@start_time, @end_time)AS NVARCHAR)+ 'seconds';
        PRINT '------------------------------'

        SET @start_time= GETDATE();
        PRINT '-----------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '-----------------------------------';

        PRINT '>> Truncating table: bronze.erp_cust_az12'
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT '>> Inserting Data Into:bronze.erp_cust_az12'

        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\SQL DATA\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT 'Load Duration: '+ CAST(DATEDIFF(SECOND,@start_time,@end_time)AS NVARCHAR)+ 'seconds';
        PRINT '------------------------------'

        SET @start_time= GETDATE();
        PRINT '>> Truncating table: bronze.erp_loc_a101'
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>> Inserting Data Into:bronze.erp_loc_a101'

        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\SQL DATA\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT 'Load Duration: '+ CAST(DATEDIFF(SECOND,@start_time,@end_time)AS NVARCHAR)+ 'seconds';
        PRINT '------------------------------'

        SET @start_time= GETDATE();
        PRINT '>> Truncating table: bronze.erp_px_cat_g1v'
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT '>> Inserting Data Into:bronze.erp_px_cat_g1v'

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\SQL DATA\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT 'Load Duration: '+ CAST(DATEDIFF(SECOND,@start_time,@end_time)AS NVARCHAR)+ 'seconds';
        PRINT '------------------------------'
    END TRY
    BEGIN CATCH
    PRINT '===================================='
    PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
    PRINT 'Error Message'+ ERROR_MESSAGE();
    PRINT 'Error_Number'+ CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Error State'+ CAST(ERROR_STATE() AS NVARCHAR);

    PRINT '===================================='

    END CATCH
END
