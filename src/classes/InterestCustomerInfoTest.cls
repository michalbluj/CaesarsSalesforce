/**
* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Unit test class for InterestCustomerInfo class
**/
@IsTest
private class InterestCustomerInfoTest {

    static testMethod void populateDataTest() {
        InterestCustomerInfo info = new InterestCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.c_interest_cd = 'icode';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('c_interest_cd'),'icode');
    }
}