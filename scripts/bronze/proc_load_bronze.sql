/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE load_bronzelayer
AS
BEGIN
    DECLARE @start_time DATETIME,
            @end_time   DATETIME;

    BEGIN TRY

        PRINT '=====================================================================';
        PRINT 'Starting Bronze Layer Load';
        PRINT '=====================================================================';

        /*
        =========================================================================
        >> Load CRM Tables
        =========================================================================
        */

        PRINT '---------------------------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '---------------------------------------------------------------------';

        -- Load CRM Customer Info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info;';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting Data into: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\elshamey\Desktop\sql-BARRA warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW       = 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------------------------------------';

        -- Load CRM Product Info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_prd_info;';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting Data into: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\elshamey\Desktop\sql-BARRA warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW       = 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------------------------------------';

        -- Load CRM Sales Details
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_sales_details;';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting Data into: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\elshamey\Desktop\sql-BARRA warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW       = 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------------------------------------';


        /*
        =========================================================================
        >> Load ERP Tables
        =========================================================================
        */

        PRINT '---------------------------------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '---------------------------------------------------------------------';

        -- Load ERP Customer AZ12
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_CUST_AZ12;';
        TRUNCATE TABLE bronze.erp_CUST_AZ12;

        PRINT '>> Inserting Data into: bronze.erp_CUST_AZ12';
        BULK INSERT bronze.erp_CUST_AZ12
        FROM 'C:\Users\elshamey\Desktop\sql-BARRA warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW       = 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------------------------------------';

        -- Load ERP Location A101
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_LOC_A101;';
        TRUNCATE TABLE bronze.erp_LOC_A101;

        PRINT '>> Inserting Data into: bronze.erp_LOC_A101';
        BULK INSERT bronze.erp_LOC_A101
        FROM 'C:\Users\elshamey\Desktop\sql-BARRA warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW       = 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------------------------------------';

        -- Load ERP PX Category G1V2
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_PX_CAT_G1V2;';
        TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

        PRINT '>> Inserting Data into: bronze.erp_PX_CAT_G1V2';
        BULK INSERT bronze.erp_PX_CAT_G1V2
        FROM 'C:\Users\elshamey\Desktop\sql-BARRA warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW       = 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------------------------------------';

    END TRY

    BEGIN CATCH
        PRINT '=================================================================';
        PRINT '!! ERROR OCCURRED DURING LOADING BRONZE LAYER !!';
        PRINT '>> Error Message: ' + ERROR_MESSAGE();
        PRINT '>> Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT '=================================================================';
    END CATCH

END
