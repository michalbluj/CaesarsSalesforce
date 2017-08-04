/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PrefCustomerInfo class
**/
@IsTest
private class PrefCustomerInfoTest {

	static testMethod void populateDataTest() {
		PrefCustomerInfo info = new PrefCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_modifier 				= '';
		dataRecord.c_pref_flag 				= 'N';
		dataRecord.c_quality_cd 			= ' ';
		dataRecord.i_category_id 			= 10650;
		dataRecord.c_derived_flag 			= 'ST';
		dataRecord.i_preference_id 			= 10650;
		dataRecord.c_data_source_cd 		= '   ';
		dataRecord.c_pref_type_name 		= 'Hispanic Cultural Events';
		dataRecord.c_modifier_location 		= '';
		dataRecord.c_pref_category_name 	= 'Events';
		dataRecord.c_modifier_workstation 	= '';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('modifier'),'');
		System.assertEquals((String)row.get('pref_flag'),'N');
		System.assertEquals((String)row.get('quality_cd'),' ');
		System.assertEquals((Integer)row.get('category_id'),10650);
		System.assertEquals((String)row.get('derived_flag'),'ST');
		System.assertEquals((Integer)row.get('preference_id'),10650);
		System.assertEquals((String)row.get('data_source_cd'),'   ');
		System.assertEquals((String)row.get('pref_type_name'),'Hispanic Cultural Events');
		System.assertEquals((String)row.get('modifier_location'),'');
		System.assertEquals((String)row.get('pref_category_name'),'Events');
		System.assertEquals((String)row.get('modifier_workstation'),'');
	}
}