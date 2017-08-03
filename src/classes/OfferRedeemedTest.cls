/**
 * Created by Michal Bluj on 2017-07-27.
 */

@IsTest
private class OfferRedeemedTest {

    static testMethod void populateDataTest() {

        OfferRedeemed eObject = new OfferRedeemed();
        OfferRedeemed.Record record = new OfferRedeemed.Record();
        record.id = '1234';
        record.contact = '5678';
        eObject.body = new List<OfferRedeemed.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');
        System.assertEquals((String)rows.get(0).get('contact'),'5678');

    }
}