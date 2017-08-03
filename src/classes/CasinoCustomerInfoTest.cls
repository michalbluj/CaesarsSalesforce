/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for CasinoCustomerInfo class
**/
@IsTest
private class CasinoCustomerInfoTest {

    static testMethod void populateDataTest() {
        CasinoCustomerInfo info = new CasinoCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.c_rep_id             = '';
        dataRecord.c_prop_cd            = 'DLV';
        dataRecord.d_update_dt          = '1899-12-31';
        dataRecord.i_casino_id          = 170266;
        dataRecord.c_quality_cd         = '';
        dataRecord.d_create_date        = '2014-08-01';
        dataRecord.d_purge_react        = null;
        dataRecord.c_cred_appr_by       = '';
        dataRecord.c_prop_mail_cd       = '';
        dataRecord.f_avail_credit       = 0;
        dataRecord.f_credit_limit       = 0;
        dataRecord.c_credit_status      = 'A4';
        dataRecord.f_outstand_credit    = 0;

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('rep_id'),'');
        System.assertEquals((String)row.get('prop_cd'),'DLV');
        System.assertEquals((String)row.get('update_dt'),'1899-12-31');
        System.assertEquals((Integer)row.get('casino_id'),170266);
        System.assertEquals((String)row.get('quality_cd'),'');
        System.assertEquals((String)row.get('create_date'),'2014-08-01');
        System.assertEquals((String)row.get('purge_react'),null);
        System.assertEquals((String)row.get('cred_appr_by'),'');
        System.assertEquals((String)row.get('prop_mail_cd'),'');
        System.assertEquals((Decimal)row.get('avail_credit'),0);
        System.assertEquals((Decimal)row.get('credit_limit'),0);
        System.assertEquals((String)row.get('credit_status'),'A4');
        System.assertEquals((Decimal)row.get('outstand_credit'),0);
    }
}