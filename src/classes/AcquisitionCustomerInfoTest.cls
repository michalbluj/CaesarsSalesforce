/**
* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Unit test class for AcquisitionCustomerInfo class
**/
@IsTest
private class AcquisitionCustomerInfoTest {

    static testMethod void populateDataTest() {
        AcquisitionCustomerInfo info = new AcquisitionCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.d_acq_date = '2017-01-01';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('acquisition_date'),'2017-01-01');
    }
}