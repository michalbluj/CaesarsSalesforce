/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PrefGlbaCustomerInfo class
**/
@IsTest
private class PrefGlbaCustomerInfoTest {

	static testMethod void populateDataTest() {
		PrefGlbaCustomerInfo info = new PrefGlbaCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_modifier = null;
		dataRecord.c_quality_cd = '';
		dataRecord.i_category_id = 10067;
		dataRecord.c_derived_flag = 'ST';
		dataRecord.i_preference_id = 11151;
		dataRecord.c_data_source_cd = '';
		dataRecord.c_pref_type_name = 'Do not share my personal information with non-affiliates to market their products & services to me.';
		dataRecord.c_modifier_location = null;
		dataRecord.c_pref_category_name = 'Sharing of Information with Non-Affiliates';
		dataRecord.c_pref_suppress_flag = 'Y';
		dataRecord.c_modifier_workstation = null;

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('modifier'),null);
		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((Integer)row.get('category_id'),10067);
		System.assertEquals((String)row.get('derived_flag'),'ST');
		System.assertEquals((Integer)row.get('preference_id'),11151);
		System.assertEquals((String)row.get('data_source_cd'),'');
		System.assertEquals((String)row.get('pref_type_name'),'Do not share my personal information with non-affiliates to market their products & services to me.');
		System.assertEquals((String)row.get('modifier_location'),null);
		System.assertEquals((String)row.get('pref_category_name'),'Sharing of Information with Non-Affiliates');
		System.assertEquals((String)row.get('pref_suppress_flag'),'Y');
		System.assertEquals((String)row.get('modifier_workstation'),null);
	}
}