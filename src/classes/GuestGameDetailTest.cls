/**
 * Created by Michal Bluj on 2017-07-26.
 */

@IsTest
private class GuestGameDetailTest {

    static testMethod void populateDataTest() {

        GuestGameDetail eObject = new GuestGameDetail();
        GuestGameDetail.Record record = new GuestGameDetail.Record();
        record.id = '1234';
        eObject.body = new List<GuestGameDetail.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');

    }
}