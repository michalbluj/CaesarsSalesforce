/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for AliasCustomerInfo class
**/
@IsTest
private class AliasCustomerInfoTest {

    static testMethod void populateDataTest() {
        AliasCustomerInfo info = new AliasCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.c_prop_cd = '7';
        dataRecord.c_last_name = 'MOUSE';
        dataRecord.c_first_name = 'MICK';
        dataRecord.c_quality_cd = '';
        dataRecord.c_phonetic_last = 'V200';
        dataRecord.c_phonetic_first = 'A655';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('prop_cd'),'7');
        System.assertEquals((String)row.get('last_name'),'MOUSE');
        System.assertEquals((String)row.get('first_name'),'MICK');
        System.assertEquals((String)row.get('quality_cd'),'');
        System.assertEquals((String)row.get('phonetic_last'),'V200');
        System.assertEquals((String)row.get('phonetic_first'),'A655');
    }
}