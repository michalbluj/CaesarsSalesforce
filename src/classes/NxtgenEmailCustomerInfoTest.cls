/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for NxtgenEmailCustomerInfo class
**/
@IsTest
private class NxtgenEmailCustomerInfoTest {

	static testMethod void populateDataTest() {
		NxtgenEmailCustomerInfo info = new NxtgenEmailCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_email 			= 'INVALID@INVALID.COM';
		dataRecord.c_app_cd 		= 'SFD';
		dataRecord.i_email_id 		= 14664;
		dataRecord.d_create_dt 		= '2015-01-23';
		dataRecord.c_created_by 	= 'emcarthur';
		dataRecord.c_email_type 	= 'Good Email';
		dataRecord.c_email_status 	= 'A';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('email'),'INVALID@INVALID.COM');
		System.assertEquals((String)row.get('app_cd'),'SFD');
		System.assertEquals((Integer)row.get('email_id'),14664);
		System.assertEquals((String)row.get('create_dt'),'2015-01-23');
		System.assertEquals((String)row.get('created_by'),'emcarthur');
		System.assertEquals((String)row.get('email_type'),'Good Email');
		System.assertEquals((String)row.get('email_status'),'A');
	}
}