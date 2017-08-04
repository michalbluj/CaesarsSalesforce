/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for VedwRelationshipCustomerInfo class
**/
@IsTest
private class VedwRelationshipCustomerInfoTest {

	static testMethod void populateDataTest() {
		VedwRelationshipCustomerInfo info = new VedwRelationshipCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_app_cd 			= 'SFD';
		dataRecord.d_rel_dob 			= null;
		dataRecord.c_rel_name 			= 'MICKEY MOUSE';
		dataRecord.c_rel_notes 			= null;
		dataRecord.d_create_dt 			= '2012-09-04';
		dataRecord.c_rel_type_cd 		= 'Personal';
		dataRecord.c_relationship 		= 'Spouse';
		dataRecord.c_creator_login 		= 'jroy';
		dataRecord.c_rel_status_cd 		= 'A';
		dataRecord.c_modifier_login 	= 'jroy';
		dataRecord.i_plays_with_dmid 	= '11402320994';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('app_cd'),'SFD');
		System.assertEquals((String)row.get('rel_dob'),null);
		System.assertEquals((String)row.get('rel_name'),'MICKEY MOUSE');
		System.assertEquals((String)row.get('rel_notes'),null);
		System.assertEquals((String)row.get('create_dt'),'2012-09-04');
		System.assertEquals((String)row.get('rel_type_cd'),'Personal');
		System.assertEquals((String)row.get('relationship'),'Spouse');
		System.assertEquals((String)row.get('creator_login'),'jroy');
		System.assertEquals((String)row.get('rel_status_cd'),'A');
		System.assertEquals((String)row.get('modifier_login'),'jroy');
		System.assertEquals((String)row.get('plays_with_dmid'),'11402320994');
	}
}