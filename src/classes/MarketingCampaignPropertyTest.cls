/**
* @author Jakub Kołacz
* @date 2017
* @group UnitTest
* @description Unit test class for MarketingCampaignProperty class
**/

@isTest
private class MarketingCampaignPropertyTest
{
	@isTest
	static void populateDataTest()
	{
		Test.startTest();
		MarketingCampaignProperty marketingCampaignProperty=new MarketingCampaignProperty();
		MarketingCampaignProperty.Record record=new MarketingCampaignProperty.Record();
		record.contact='Contact';
		record.id='RecordId';
		marketingCampaignProperty.body=new List<MarketingCampaignProperty.Record>();
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