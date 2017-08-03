/**
* @author Jakub Kołacz
* @date 2017
* @group UnitTest
* @description Unit test class for MarketingCampaign class
**/
@isTest
private class MarketingCampaignTest
{
@isTest
	static void populateDataTest()
	{
		Test.startTest();
		MarketingCampaign marketingCampaignProperty=new MarketingCampaign();
		MarketingCampaign.Record record=new MarketingCampaign.Record();
		record.contact='Contact';
		record.id='RecordId';
		marketingCampaignProperty.body=new List<MarketingCampaign.Record>();
		marketingCampaignProperty.body.add(record);

		List<Map<String, Object>> rows=new List<Map<String, Object>>();
		rows=marketingCampaignProperty.populateData(rows);
		Test.stopTest();

		for(Map<String, Object> row : rows){
			System.assertEquals('Contact',row.get('contact'));
			System.assertEquals('RecordId',row.get('ExternalId'));
			System.assertEquals('RecordId',row.get('DisplayUrl'));
		}
	}
}