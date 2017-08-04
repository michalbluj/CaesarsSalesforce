/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PersonalCustomerInfo class
**/
@IsTest
private class PersonalCustomerInfoTest {

	static testMethod void populateDataTest() {
		PersonalCustomerInfo info = new PersonalCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.i_ssn = null;
		dataRecord.c_dl_num = null;
		dataRecord.c_gender = '';
		dataRecord.c_quality_cd = '';
		dataRecord.c_dl_state_cd = '';
		dataRecord.c_id_verified = 'N';
		dataRecord.d_annivers_dt = null;
		dataRecord.c_marital_status = 'S';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('ssn'),null);
		System.assertEquals((String)row.get('dl_num'),null);
		System.assertEquals((String)row.get('gender'),'');
		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((String)row.get('dl_state_cd'),'');
		System.assertEquals((String)row.get('id_verified'),'N');
		System.assertEquals((String)row.get('annivers_dt'),null);
		System.assertEquals((String)row.get('marital_status'),'S');
	}
}