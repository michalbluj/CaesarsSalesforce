/**
 * Created by Michal Bluj on 2017-07-27.
 */

@IsTest
private class OfferSentTest {

    static testMethod void populateDataTest() {

        OfferSent eObject = new OfferSent();
        OfferSent.Record record = new OfferSent.Record();
        record.id = '1234';
        record.contact = '5678';
        eObject.body = new List<OfferSent.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');
        System.assertEquals((String)rows.get(0).get('contact'),'5678');

    }
}