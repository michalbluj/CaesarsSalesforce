/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for AssociationCustomerInfo class
**/
@IsTest
private class AssociationCustomerInfoTest {

    static testMethod void populateDataTest() {
        AssociationCustomerInfo info = new AssociationCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.i_req_dmid = '11402320994';
        dataRecord.d_create_dt = '2007-09-14T15:14:00';
        dataRecord.c_quality_cd = '';
        dataRecord.c_assn_reason = 'CLN';
        dataRecord.c_req_prop_cd = 'HLT';
        dataRecord.c_req_employee = 'CONVERT';
        dataRecord.i_primary_dmid = '11402320994';
        dataRecord.i_secondary_dmid = '19904186047';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('req_dmid'),'11402320994');
        System.assertEquals((String)row.get('create_dt'),'2007-09-14T15:14:00');
        System.assertEquals((String)row.get('quality_cd'),'');
        System.assertEquals((String)row.get('assn_reason'),'CLN');
        System.assertEquals((String)row.get('req_prop_cd'),'HLT');
        System.assertEquals((String)row.get('req_employee'),'CONVERT');
        System.assertEquals((String)row.get('primary_dmid'),'11402320994');
        System.assertEquals((String)row.get('secondary_dmid'),'19904186047');
    }
}