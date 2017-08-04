/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for VedwEthnicityCustomerInfo class
**/
@IsTest
private class VedwEthnicityCustomerInfoTest {

	static testMethod void populateDataTest() {
		VedwEthnicityCustomerInfo info = new VedwEthnicityCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_group1 				= 'Western European';
		dataRecord.c_group2 				= 'English';
		dataRecord.c_group3 				= 'A';
		dataRecord.c_group4 				= 'A';
		dataRecord.c_last_name 				= 'MOUSE';
		dataRecord.c_group_code 			= 'K';
		dataRecord.c_match_type 			= 'Matched';
		dataRecord.d_lastupdate 			= '2005-04-18';
		dataRecord.f_user_amt_1 			= 0.01;
		dataRecord.f_user_amt_2 			= 0.01;
		dataRecord.f_user_amt_3 			= 0.01;
		dataRecord.f_user_amt_4 			= 0.01;
		dataRecord.c_ethnic_code 			= '1';
		dataRecord.c_vendor_code 			= 'Etech';
		dataRecord.i_user_score_1 			= 1;
		dataRecord.i_user_score_2 			= 1;
		dataRecord.i_user_score_3 			= 1;
		dataRecord.i_user_score_4 			= 1;
		dataRecord.c_ethdom_relg_cd 		= 'P';
		dataRecord.i_est_names_12mn 		= 7917;
		dataRecord.c_group_code_desc 		= 'Western European';
		dataRecord.c_ethnic_code_desc 		= 'English';
		dataRecord.c_ethdom_relg_cd_desc 	= 'Protestant';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('group1'),'Western European');
		System.assertEquals((String)row.get('group2'),'English');
		System.assertEquals((String)row.get('group3'),'A');
		System.assertEquals((String)row.get('group4'),'A');
		System.assertEquals((String)row.get('last_name'),'MOUSE');
		System.assertEquals((String)row.get('group_code'),'K');
		System.assertEquals((String)row.get('match_type'),'Matched');
		System.assertEquals((String)row.get('lastupdate'),'2005-04-18');
		System.assertEquals((Decimal)row.get('user_amt_1'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_2'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_3'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_4'),0.01);
		System.assertEquals((String)row.get('ethnic_code'),'1');
		System.assertEquals((String)row.get('vendor_code'),'Etech');
		System.assertEquals((Integer)row.get('user_score_1'),1);
		System.assertEquals((Integer)row.get('user_score_2'),1);
		System.assertEquals((Integer)row.get('user_score_3'),1);
		System.assertEquals((Integer)row.get('user_score_4'),1);
		System.assertEquals((String)row.get('ethdom_relg_cd'),'P');
		System.assertEquals((Integer)row.get('est_names_12mn'),7917);
		System.assertEquals((String)row.get('group_code_desc'),'Western European');
		System.assertEquals((String)row.get('ethnic_code_desc'),'English');
		System.assertEquals((String)row.get('ethdom_relg_cd_desc'),'Protestant');
	}
}