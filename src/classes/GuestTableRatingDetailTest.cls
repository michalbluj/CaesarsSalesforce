/**
 * Created by Michal Bluj on 2017-07-26.
 */

@IsTest
private class GuestTableRatingDetailTest {

    static testMethod void populateDataTest() {

        GuestTableRatingDetail eObject = new GuestTableRatingDetail();
        GuestTableRatingDetail.Record record = new GuestTableRatingDetail.Record();
        record.id = '1234';
        eObject.body = new List<GuestTableRatingDetail.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');
    }
}