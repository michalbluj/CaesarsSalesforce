/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for AcquisitionCustomerInfo class
**/
@IsTest
private class AcquisitionCustomerInfoTest {

    static testMethod void populateDataTest() {
        AcquisitionCustomerInfo info = new AcquisitionCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.c_prop_cd            = 'PLV';
        dataRecord.d_acq_date           = '2014-09-13';
        dataRecord.c_quality_cd         = '';
        //dataRecord.c_acquisition_cd   = 'HTL';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('prop_cd'),'PLV');
        System.assertEquals((String)row.get('acq_date'),'2014-09-13');
        System.assertEquals((String)row.get('quality_cd'),'');
        //System.assertEquals((String)row.get('acquisition_cd'),'HTL');
    }
}