/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for VedwAssociatedCustomerInfo class
**/
@IsTest
private class VedwAssociatedCustomerInfoTest {

	static testMethod void populateDataTest() {
		VedwAssociatedCustomerInfo info = new VedwAssociatedCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.age 			= '117';
		dataRecord.d_dob 		= '1899-12-31';
		dataRecord.c_suffix 	= '';
		dataRecord.c_addr_pref 	= 'H';
		dataRecord.c_mail_flag 	= 'Y';
		dataRecord.d_create_dt 	= '2017-05-05';
		dataRecord.c_quality_cd = '';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('age'),'117');
		System.assertEquals((String)row.get('dob'),'1899-12-31');
		System.assertEquals((String)row.get('suffix'),'');
		System.assertEquals((String)row.get('addr_pref'),'H');
		System.assertEquals((String)row.get('mail_flag'),'Y');
		System.assertEquals((String)row.get('create_dt'),'2017-05-05');
		System.assertEquals((String)row.get('quality_cd'),'');
	}
}