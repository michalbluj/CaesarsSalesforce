/**
* @author Jakub Kołacz
* @date 2017
* @group UnitTest
* @description Unit test class for PrefSpecifiedCustomerInfo class
**/
@isTest
private class PrefSpecifiedCustomerInfoTest
{
	@isTest
	static void populateDataTest()
	{
		Test.startTest();
		Map<String, Object> row = new Map<String, Object>();
		CustomerInfo customerInfo = new CustomerInfo();
		customerInfo.data=new CustomerInfo.CustomerInfoData();
		customerInfo.data.c_channel_pref='ChannelPref';
		PrefSpecifiedCustomerInfo prefSpecifiedCustomerInfo=new PrefSpecifiedCustomerInfo();
		row=prefSpecifiedCustomerInfo.populateData(row,customerInfo);
		Test.stopTest();

		System.assertEquals('ChannelPref',row.get('c_channel_pref'));
	}
}