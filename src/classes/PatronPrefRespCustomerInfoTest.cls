/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PatronPrefRespCustomerInfo class
**/
@IsTest
private class PatronPrefRespCustomerInfoTest {

	static testMethod void populateDataTest() {
		PatronPrefRespCustomerInfo info = new PatronPrefRespCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.i_file_id 				= 10231;
		dataRecord.c_modifier 				= 'PDB';
		//dataRecord.i_response 				= 1;
		dataRecord.c_quality_cd 			= '';
		dataRecord.i_upd_run_id 			= 0;
		dataRecord.c_derived_flag 			= 'ST';
		dataRecord.d_create_update 			= '2017-02-28';
		dataRecord.i_original_dmid 			= '40004420489';
		//dataRecord.i_preference_id 			= '10619';
		dataRecord.c_data_source_cd 		= 'PDB';
		dataRecord.c_modifier_location 		= 'load_pro';
		dataRecord.c_modifier_workstation 	= 'INC1492992.csv';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((Integer)row.get('file_id'),10231);
		System.assertEquals((String)row.get('modifier'),'PDB');
		//System.assertEquals((Integer)row.get('response'),1);
		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((Integer)row.get('upd_run_id'),0);
		System.assertEquals((String)row.get('derived_flag'),'ST');
		System.assertEquals((String)row.get('create_update'),'2017-02-28');
		System.assertEquals((String)row.get('original_dmid'),'40004420489');
		//System.assertEquals((String)row.get('preference_id'),'10619');
		System.assertEquals((String)row.get('data_source_cd'),'PDB');
		System.assertEquals((String)row.get('modifier_location'),'load_pro');
		System.assertEquals((String)row.get('modifier_workstation'),'INC1492992.csv');
	}
}