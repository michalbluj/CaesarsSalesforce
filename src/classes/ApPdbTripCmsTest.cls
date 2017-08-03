/**
 * Created by Michal Bluj on 2017-08-01.
 */

@IsTest
private class ApPdbTripCmsTest {

    static testMethod void populateDataTest() {

        ApPdbTripCms eObject = new ApPdbTripCms();
        ApPdbTripCms.Record record = new ApPdbTripCms.Record();
        record.id = '1234';
        eObject.body = new List<ApPdbTripCms.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');

    }
}