/* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Unit test class for CasionCustomerInfo class
**/
@IsTest
private class CasinoCustomerInfoTest {

    static testMethod void populateDataTest() {
        CasinoCustomerInfo info = new CasinoCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.i_casino_id = '12345678901';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('casino_id'),'12345678901');
    }

}