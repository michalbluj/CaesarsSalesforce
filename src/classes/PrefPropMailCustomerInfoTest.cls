/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PrefPropMailCustomerInfo class
**/
@IsTest
private class PrefPropMailCustomerInfoTest {

	static testMethod void populateDataTest() {
		PrefPropMailCustomerInfo info = new PrefPropMailCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_prop_cd 			= 'DLV';
		dataRecord.c_quality_cd 		= '';
		dataRecord.c_gst_pref_mail_flag = 'Y';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('prop_cd'),'DLV');
		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((String)row.get('gst_pref_mail_flag'),'Y');
	}
}