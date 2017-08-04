/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PrefSpecifiedCustomerInfo class
**/
@IsTest
private class PrefSpecifiedCustomerInfoTest {

	static testMethod void populateDataTest() {
		PrefSpecifiedCustomerInfo info = new PrefSpecifiedCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_quality_cd = '';
		dataRecord.c_channel_pref = 'Email';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((String)row.get('channel_pref'),'Email');
	}
}