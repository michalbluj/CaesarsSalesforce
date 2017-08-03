/**
 * Created by Michal Bluj on 2017-07-06.
 */

@IsTest
private class GenericCustomerInfoTest {

    static testMethod void populateDataTest() {
        GenericCustomerInfo info = new GenericCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.id = '12345678901';
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('ExternalId'),'12345678901');
    }
}