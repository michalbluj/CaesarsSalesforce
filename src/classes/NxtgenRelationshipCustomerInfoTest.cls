/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for NxtgenRelationshipCustomerInfo class
**/
@IsTest
private class NxtgenRelationshipCustomerInfoTest {

	static testMethod void populateDataTest() {
		NxtgenRelationshipCustomerInfo info = new NxtgenRelationshipCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_app_cd 			= 'SFD';
		dataRecord.d_rel_dob 			= '1983-07-06';
		dataRecord.c_rel_name 			= 'MICKEY MOUSE';
		dataRecord.c_rel_notes 			= null;
		dataRecord.d_create_dt 			= '2013-02-25';
		dataRecord.i_gst_rel_id 		= 1165453;
		dataRecord.c_rel_type_cd 		= 'Games With';
		dataRecord.c_relationship 		= 'Spouse';
		dataRecord.c_creator_login 		= 'sdenos';
		dataRecord.c_rel_status_cd 		= 'A';
		dataRecord.c_modifier_login 	= 'sdenos';
		dataRecord.i_plays_with_dmid 	= '11203322796';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('app_cd'),'SFD');
		System.assertEquals((String)row.get('rel_dob'),'1983-07-06');
		System.assertEquals((String)row.get('rel_name'),'MICKEY MOUSE');
		System.assertEquals((String)row.get('rel_notes'),null);
		System.assertEquals((String)row.get('create_dt'),'2013-02-25');
		System.assertEquals((Integer)row.get('gst_rel_id'),1165453);
		System.assertEquals((String)row.get('rel_type_cd'),'Games With');
		System.assertEquals((String)row.get('relationship'),'Spouse');
		System.assertEquals((String)row.get('creator_login'),'sdenos');
		System.assertEquals((String)row.get('rel_status_cd'),'A');
		System.assertEquals((String)row.get('modifier_login'),'sdenos');
		System.assertEquals((String)row.get('plays_with_dmid'),'11203322796');
	}
}