/**
 * Created by Michal Bluj on 2017-07-26.
 */

@IsTest
private class GuestSlotRatingDetailTest {

    static testMethod void populateDataTest() {

        GuestSlotRatingDetail eObject = new GuestSlotRatingDetail();
        GuestSlotRatingDetail.Record record = new GuestSlotRatingDetail.Record();
        record.id = '1234';
        eObject.body = new List<GuestSlotRatingDetail.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');

    }
}