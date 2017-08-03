/* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Unit test class for AliasCustomerInfo class
**/
@IsTest
private class AliasCustomerInfoTest {

    static testMethod void populateDataTest() {
        AliasCustomerInfo info = new AliasCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.c_first_name = 'Michal';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('first_name'),'Michal');
    }
}