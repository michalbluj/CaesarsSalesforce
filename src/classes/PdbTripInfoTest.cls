/**
 * Created by ceezar on 03.08.2017.
 */

@isTest
private class PdbTripInfoTest {

    static testMethod void populateDataTest() {

        PdbTripInfo.Record dataRecord = new PdbTripInfo.Record();
        dataRecord.id = '1234';

        PdbTripInfo wrapper = new PdbTripInfo();
        wrapper.body = new List<PdbTripInfo.Record>{dataRecord};

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