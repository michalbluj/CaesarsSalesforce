/**
 * Created by Michal Bluj on 2017-08-01.
 */

@IsTest
private class ApPdbTripHtlTest {

    static testMethod void populateDataTest() {
        ApPdbTripHtl eObject = new ApPdbTripHtl();
        ApPdbTripHtl.Record record = new ApPdbTripHtl.Record();
        record.id = '1234';
        eObject.body = new List<ApPdbTripHtl.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');
    }
}