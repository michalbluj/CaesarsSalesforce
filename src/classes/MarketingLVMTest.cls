/**
* @author Jakub Kołacz
* @date 2017
* @group UnitTest
* @description Unit test class for MarketingLVM class
**/

@isTest
private class MarketingLVMTest
{
	@isTest
	static void populateDataTest()
	{
		Test.startTest();
		MarketingLVM marketingLVM=new MarketingLVM();
		MarketingLVM.Record record=new MarketingLVM.Record();
		record.contact='Contact';
		record.id='RecordId';
		marketingLVM.body=new List<MarketingLVM.Record>();
		marketingLVM.body.add(record);

		List<Map<String, Object>> rows=new List<Map<String, Object>>();
		rows=marketingLVM.populateData(rows);
		Test.stopTest();

		for(Map<String, Object> row : rows){
			System.assertEquals('Contact',row.get('contact'));
			System.assertEquals('RecordId',row.get('ExternalId'));
			System.assertEquals('RecordId',row.get('DisplayUrl'));
		}
	}
}