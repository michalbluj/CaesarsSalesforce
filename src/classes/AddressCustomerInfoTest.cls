/* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Unit test class for AddressCustomerInfo class
**/
@IsTest
private class AddressCustomerInfoTest {

    static testMethod void populateDataTest() {
        AddressCustomerInfo info = new AddressCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.c_address_1 = 'xxx yyy zzz';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('address'),'xxx yyy zzz');
    }
}