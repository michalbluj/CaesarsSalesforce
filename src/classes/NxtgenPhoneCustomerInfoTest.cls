/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for NxtgenPhoneCustomerInfo class
**/
@IsTest
private class NxtgenPhoneCustomerInfoTest {

	static testMethod void populateDataTest() {
		NxtgenPhoneCustomerInfo info = new NxtgenPhoneCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_phone = '(111) 111-1111';
		dataRecord.c_app_cd = 'SFD';
		dataRecord.c_private = 'F';
		dataRecord.d_create_dt = '2015-09-26';
		dataRecord.c_created_by = 'jgurka1';
		dataRecord.c_phone_type = 'Bad Phone';
		dataRecord.c_phone_status = 'A';
		dataRecord.i_pcs_phone_id = 157817;

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('phone'),'(111) 111-1111');
		System.assertEquals((String)row.get('app_cd'),'SFD');
		System.assertEquals((String)row.get('private'),'F');
		System.assertEquals((String)row.get('create_dt'),'2015-09-26');
		System.assertEquals((String)row.get('created_by'),'jgurka1');
		System.assertEquals((String)row.get('phone_type'),'Bad Phone');
		System.assertEquals((String)row.get('phone_status'),'A');
		System.assertEquals((Integer)row.get('pcs_phone_id'),157817);
	}
}