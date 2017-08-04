/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PropMailCustomerInfo class
**/
@IsTest
private class PropMailCustomerInfoTest {

	static testMethod void populateDataTest() {
		PropMailCustomerInfo info = new PropMailCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_quality_cd 	= '';
		dataRecord.c_prop_mail_cd 	= '100';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((String)row.get('prop_mail_cd'),'100');
	}
}