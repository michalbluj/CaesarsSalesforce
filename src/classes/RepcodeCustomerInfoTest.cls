/* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Unit test class for RepcodeCustomerInfo class
**/
@IsTest
private class RepcodeCustomerInfoTest {

    static testMethod void populateDataTest() {
        RepcodeCustomerInfo info = new RepcodeCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.c_rep_cd             = 'XXX';
        dataRecord.c_prop_cd            = 'LAU';
        dataRecord.i_efft_dy            = 13;
        dataRecord.i_efft_mn            = 12;
        dataRecord.i_efft_yr            = 6;
        dataRecord.c_rep_type           = '3';
        dataRecord.i_rep_rank           = 1;
        dataRecord.i_patron_id          = '8211936';
        dataRecord.c_current_cd         = '1';
        //dataRecord.c_entered_by       = 'NVCONV';
        dataRecord.c_quality_cd         = '';
        dataRecord.d_trans_time         = 20621;
        dataRecord.d_efft_end_dt        = '2016-10-17';
        dataRecord.d_trans_100_yr       = 39063;
        dataRecord.d_trans_cal_dt       = 121306;
        dataRecord.i_rep_trip_nbr       = 0;
        dataRecord.d_efft_start_dt      = '2006-12-13';
        dataRecord.c_patron_rep_appv    = 'NVCONV';
        dataRecord.i_last_rep_h_date    = 0;
        dataRecord.i_assigned_century   = 20;
        dataRecord.i_last_rep_cd_date   = 0;

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('rep_cd'),'XXX');
        System.assertEquals((String)row.get('prop_cd'),'LAU');
        System.assertEquals((Integer)row.get('efft_dy'),13);
        System.assertEquals((Integer)row.get('efft_mn'),12);
        System.assertEquals((Integer)row.get('efft_yr'),6);
        System.assertEquals((String)row.get('rep_type'),'3');
        System.assertEquals((Integer)row.get('rep_rank'),1);
        System.assertEquals((String)row.get('patron_id'),'8211936');
        System.assertEquals((String)row.get('current_cd'),'1');
        //System.assertEquals((String)row.get('entered_by'),'NVCONV');
        System.assertEquals((String)row.get('quality_cd'),'');
        System.assertEquals((Integer)row.get('trans_time'),20621);
        System.assertEquals((String)row.get('efft_end_dt'),'2016-10-17');
        System.assertEquals((Integer)row.get('trans_100_yr'),39063);
        System.assertEquals((Integer)row.get('trans_cal_dt'),121306);
        System.assertEquals((Integer)row.get('rep_trip_nbr'),0);
        System.assertEquals((String)row.get('efft_start_dt'),'2006-12-13');
        System.assertEquals((String)row.get('patron_rep_appv'),'NVCONV');
        System.assertEquals((Integer)row.get('last_rep_h_date'),0);
        System.assertEquals((Integer)row.get('assigned_century'),20);
        System.assertEquals((Integer)row.get('last_rep_cd_date'),0);
    }
}