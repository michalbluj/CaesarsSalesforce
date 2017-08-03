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
        dataRecord.c_rep_cd = '12345678901';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('rep_code'),'12345678901');
    }
}