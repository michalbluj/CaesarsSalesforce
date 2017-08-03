/**
 * Created by Michal Bluj on 2017-08-01.
 */

@IsTest
private class ApPdbTripHdrTest {

    static testMethod void populateDataTest() {

        ApPdbTripHdr eObject = new ApPdbTripHdr();
        ApPdbTripHdr.Record record = new ApPdbTripHdr.Record();
        record.id = '1234';
        eObject.body = new List<ApPdbTripHdr.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');

    }
}