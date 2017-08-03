/**
* @author Jakub Kołacz
* @date 2017
* @group UnitTest
* @description Unit test class for PrefCustomerInfo class
**/

@isTest
private class PrefCustomerInfoTest {
	@isTest
	static void populateDataTest() {
		Test.startTest();
		Map<String, Object> row = new Map<String, Object>();
		CustomerInfo customerInfo = new CustomerInfo();
		customerInfo.data=new CustomerInfo.CustomerInfoData();
		customerInfo.data.c_modifier = 'Modifier';
		customerInfo.data.i_response = 'Response';
		customerInfo.data.c_pref_flag = 'PrefFlag';
		customerInfo.data.i_category_id = 'CategoryId';
		customerInfo.data.c_derived_flag = 'DerivedFlag';
		customerInfo.data.i_preference_id = 'PreferenceId';
		customerInfo.data.c_data_source_cd = 'DataSourceCd';
		customerInfo.data.c_pref_type_name = 'TypeName';
		customerInfo.data.c_modifier_location = 'ModifierLocation';
		customerInfo.data.c_pref_category_name = 'PrefCategoryName';
		customerInfo.data.c_modifier_workstation = 'ModifierWorkstation';

		PrefCustomerInfo prefCustomerInfo=new PrefCustomerInfo();
		row=prefCustomerInfo.populateData(row,customerInfo);
		Test.stopTest();
		
		System.assertEquals('Modifier',row.get('c_modifier'));
		System.assertEquals('Response',row.get('i_response'));
		System.assertEquals('PrefFlag',row.get('c_pref_flag'));
		System.assertEquals('CategoryId',row.get('i_category_id'));
		System.assertEquals('DerivedFlag',row.get('c_derived_flag'));
		System.assertEquals('PreferenceId',row.get('i_preference_id'));
		System.assertEquals('DataSourceCd',row.get('c_data_source_cd'));
		System.assertEquals('TypeName',row.get('c_pref_type_name'));
		System.assertEquals('ModifierLocation',row.get('c_modifier_location'));
		System.assertEquals('PrefCategoryName',row.get('c_pref_category_name'));
		System.assertEquals('ModifierWorkstation',row.get('c_modifier_workstation'));
	}
}