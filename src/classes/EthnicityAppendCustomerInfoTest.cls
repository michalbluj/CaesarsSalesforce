/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for EthnicityAppendCustomerInfo class
**/
@IsTest
private class EthnicityAppendCustomerInfoTest {

    static testMethod void populateDataTest() {
		EthnicityAppendCustomerInfo info = new EthnicityAppendCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
    	dataRecord.c_asian_flag 		= 'N';
		dataRecord.f_user_amt_1 		= 0.01;
		dataRecord.f_user_amt_2 		= 0.02;
		dataRecord.f_user_amt_3 		= 0.03;
		dataRecord.f_user_amt_4 		= 0.04;
		dataRecord.c_source_file 		= 'source file';
		dataRecord.c_user_flag_1 		= '1';
		dataRecord.c_user_flag_2 		= 'K';
		dataRecord.c_user_flag_3 		= 'Z';
		dataRecord.c_user_flag_4 		= '1';
		dataRecord.c_user_flag_5 		= 'P';
		dataRecord.c_user_flag_6 		= 'U';
		dataRecord.i_user_score_1 		= 20140801;
		dataRecord.i_user_score_2 		= 2;
		dataRecord.i_user_score_3 		= 3;
		dataRecord.i_user_score_4 		= 4;
		dataRecord.c_ethnic_group1 		= 'English';
		dataRecord.c_ethnic_group2 		= 'Z. Missing';
		dataRecord.c_pref_language 		= 'ENGLISH';
		dataRecord.d_last_update_dt 	= '2017-06-16';
		dataRecord.c_sub_ethnic_type 	= 'sub ethnic type';
		dataRecord.c_main_ethnic_type 	= 'Western European';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('asian_flag'),'N');
		System.assertEquals((Decimal)row.get('user_amt_1'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_2'),0.02);
		System.assertEquals((Decimal)row.get('user_amt_3'),0.03);
		System.assertEquals((Decimal)row.get('user_amt_4'),0.04);
		System.assertEquals((String)row.get('source_file'),'source file');
		System.assertEquals((String)row.get('user_flag_1'),'1');
		System.assertEquals((String)row.get('user_flag_2'),'K');
		System.assertEquals((String)row.get('user_flag_3'),'Z');
		System.assertEquals((String)row.get('user_flag_4'),'1');
		System.assertEquals((String)row.get('user_flag_5'),'P');
		System.assertEquals((String)row.get('user_flag_6'),'U');
		System.assertEquals((Integer)row.get('user_score_1'),20140801);
		System.assertEquals((Integer)row.get('user_score_2'),2);
		System.assertEquals((Integer)row.get('user_score_3'),3);
		System.assertEquals((Integer)row.get('user_score_4'),4);
		System.assertEquals((String)row.get('ethnic_group1'),'English');
		System.assertEquals((String)row.get('ethnic_group2'),'Z. Missing');
		System.assertEquals((String)row.get('pref_language'),'ENGLISH');
		System.assertEquals((String)row.get('last_update_dt'),'2017-06-16');
		System.assertEquals((String)row.get('sub_ethnic_type'),'sub ethnic type');
		System.assertEquals((String)row.get('main_ethnic_type'),'Western European');
    }
}