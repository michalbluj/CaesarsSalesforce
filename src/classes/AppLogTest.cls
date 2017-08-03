/**
 * Created by ceezar on 03.08.2017.
 */

@isTest
private class AppLogTest {

    static testMethod void populateDataTest() {

        AppLog.Record dataRecord = new AppLog.Record();
        dataRecord.id = '1234';

        AppLog wrapper = new AppLog();
        wrapper.body = new List<AppLog.Record>{dataRecord};

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