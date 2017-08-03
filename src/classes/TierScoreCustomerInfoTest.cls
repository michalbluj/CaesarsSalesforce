/* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Unit test class for TierScoreCustomerInfo class
**/
@isTest
private class TierScoreCustomerInfoTest {

    static testMethod void populateDataTest() {
        TierScoreCustomerInfo info = new TierScoreCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.i_year = '2017';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('i_year'),'2017');
    }

}