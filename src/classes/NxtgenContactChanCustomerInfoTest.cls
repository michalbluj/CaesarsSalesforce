/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for NxtgenContactChanCustomerInfo class
**/
@IsTest
private class NxtgenContactChanCustomerInfoTest {

	static testMethod void populateDataTest() {
		NxtgenContactChanCustomerInfo info = new NxtgenContactChanCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_app_cd						= '';
		dataRecord.d_create_dt 					= null;
		dataRecord.c_creator_login 				= null;
		dataRecord.c_modifier_login 			= null;
		dataRecord.c_do_not_contact_channel 	= null;
		dataRecord.c_preferred_contact_channel 	= null;

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('app_cd'),'');
		System.assertEquals((String)row.get('create_dt'),null);
		System.assertEquals((String)row.get('creator_login'),null);
		System.assertEquals((String)row.get('modifier_login'),null);
		System.assertEquals((String)row.get('do_not_contact_channel'),null);
		System.assertEquals((String)row.get('preferred_contact_channel'),null);
	}
}