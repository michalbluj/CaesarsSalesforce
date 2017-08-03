/**
 * Created by Michal Bluj on 2017-07-28.
 */

@IsTest
private class EnterpriseCampaignTest {

    static testMethod void populateDataTest() {

        EnterpriseCampaign eObject = new EnterpriseCampaign();
        EnterpriseCampaign.Record record = new EnterpriseCampaign.Record();
        record.id = '1234';
        eObject.body = new List<EnterpriseCampaign.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');

    }
}