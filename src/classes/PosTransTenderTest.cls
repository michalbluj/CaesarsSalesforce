/**
 * Created by ceezar on 03.08.2017.
 */
@isTest
private class PosTransTenderTest {

    static testMethod void populateDataTest() {

        PosTransTender.Record dataRecord = new PosTransTender.Record();
        dataRecord.id = '1234';

        PosTransTender wrapper = new PosTransTender();
        wrapper.body = new List<PosTransTender.Record>{dataRecord};

        Test.startTest();
        List<Map<String, Object>> rows = wrapper.populateData(new List<Map<String, Object>>());
        Test.stopTest();

        for(Map<String, Object> row : rows) {
            System.assertEquals((String) row.get('id'), '1234');
            System.assertEquals((String) row.get('ExternalId'), '1234');
            System.assertEquals((String) row.get('DisplayUrl'), '1234');
        }
    }
}