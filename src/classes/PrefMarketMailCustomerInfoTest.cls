/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PrefMarketMailCustomerInfo class
**/
@IsTest
private class PrefMarketMailCustomerInfoTest {

	static testMethod void populateDataTest() {
		PrefMarketMailCustomerInfo info = new PrefMarketMailCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_market_cd 			= 'CAM';
		dataRecord.c_quality_cd 		= '';
		dataRecord.i_market_type 		= 2;
		dataRecord.c_gst_pref_mail_flag = 'N';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('market_cd'),'CAM');
		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((Integer)row.get('market_type'),2);
		System.assertEquals((String)row.get('gst_pref_mail_flag'),'N');
	}
}