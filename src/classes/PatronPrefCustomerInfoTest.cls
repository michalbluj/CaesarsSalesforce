/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PatronPrefCustomerInfo class
**/
@IsTest
private class PatronPrefCustomerInfoTest {

	static testMethod void populateDataTest() {
		PatronPrefCustomerInfo info = new PatronPrefCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.i_file_id 				= 10231;
		dataRecord.c_modifier 			= 'PDB';
		//dataRecord.i_response 			= 1;
		//dataRecord.c_quality_cd 			= '';
		//dataRecord.i_ins_run_id 			= 170228000433915000;
		dataRecord.i_rank_value 			= null;
		dataRecord.i_upd_run_id 			= 0;
		dataRecord.c_ok2ask_flag 			= '-';
		dataRecord.d_create_update 			= '2017-02-28';
		dataRecord.i_original_dmid 			= '40004420489';
		//dataRecord.i_preference_id 		= 10614;
		//dataRecord.c_data_source_cd 		= 'PDB';
		dataRecord.c_freeform_value 		= null;
		dataRecord.c_it_qry_category 		= '';
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
		//System.assertEquals((String)row.get('quality_cd'),'');
		//System.assertEquals((Integer)row.get('ins_run_id'),170228000433915000);
		System.assertEquals((String)row.get('rank_value'),null);
		System.assertEquals((Integer)row.get('upd_run_id'),0);
		System.assertEquals((String)row.get('ok2ask_flag'),'-');
		System.assertEquals((String)row.get('create_update'),'2017-02-28');
		System.assertEquals((String)row.get('original_dmid'),'40004420489');
		//System.assertEquals((Integer)row.get('preference_id'),10614);
		//System.assertEquals((String)row.get('data_source_cd'),'PDB');
		System.assertEquals((String)row.get('freeform_value'),null);
		System.assertEquals((String)row.get('it_qry_category'),'');
		System.assertEquals((String)row.get('modifier_location'),'load_pro');
		System.assertEquals((String)row.get('modifier_workstation'),'INC1492992.csv');
	}
}