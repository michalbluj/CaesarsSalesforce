/**
* @author Jakub Kołacz
* @date 2017
* @group UnitTest
* @description Unit test class for MarketingCampaignWeekly class
**/

@isTest
private class MarketingCampaignWeeklyTest
{
	@isTest
	static void populateDataTest()
	{
		Test.startTest();
		MarketingCampaignWeekly marketingCampaignProperty=new MarketingCampaignWeekly();
		MarketingCampaignWeekly.Record record=new MarketingCampaignWeekly.Record();
		record.contact='Contact';
		record.id='RecordId';
		marketingCampaignProperty.body=new List<MarketingCampaignWeekly.Record>();
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