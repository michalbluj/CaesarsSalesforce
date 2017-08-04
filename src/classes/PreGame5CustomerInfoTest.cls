/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PreGame5CustomerInfo class
**/
@IsTest
private class PreGame5CustomerInfoTest {

	static testMethod void populateDataTest() {
		PreGame5CustomerInfo info = new PreGame5CustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.i_denom 			= 6;
		dataRecord.i_groups 		= 26;
		dataRecord.c_group_1 		= 'Blazing Sevens';
		dataRecord.c_group_2 		= 'Quick Hit';
		dataRecord.c_group_3 		= 'Harrahs';
		dataRecord.c_group_4 		= 'Wheel Of Fortune';
		dataRecord.c_group_5 		= 'Bonus Times';
		dataRecord.i_machines 		= 105;
		dataRecord.c_game_type 		= 'Slots-Reel';
		dataRecord.i_cards_top 		= 238;
		dataRecord.f_denom_pref 	= 0.25;
		dataRecord.f_user_amt_1 	= 0.01;
		dataRecord.f_user_amt_2 	= 0.01;
		dataRecord.f_user_amt_3 	= 0.01;
		dataRecord.f_user_amt_4 	= 0.01;
		dataRecord.f_user_amt_5 	= 0.01;
		dataRecord.f_user_amt_6 	= 0.01;
		dataRecord.f_user_amt_7 	= 0.01;
		dataRecord.f_user_amt_8 	= 0.01;
		dataRecord.f_user_amt_9 	= 0.01;
		dataRecord.i_denom_pref 	= 19142;
		dataRecord.i_top1_value 	= 18161;
		dataRecord.i_top5_value 	= 24514;
		dataRecord.c_user_flag_1 	= 'Slots';
		dataRecord.c_user_flag_2 	= 'e. $0.25';
		dataRecord.c_user_flag_3 	= 'A';
		dataRecord.c_user_flag_4 	= 'A';
		dataRecord.c_user_flag_5 	= 'A';
		dataRecord.c_user_flag_6 	= 'A';
		dataRecord.c_user_flag_7 	= 'A';
		dataRecord.c_user_flag_8 	= 'A';
		dataRecord.c_user_flag_9 	= 'A';
		dataRecord.f_user_amt_10 	= 0.01;
		dataRecord.i_cards_total 	= 297;
		dataRecord.i_denom_total 	= 27088;
		dataRecord.i_total_value 	= 27088;
		dataRecord.c_user_flag_10 	= 'A';
		dataRecord.i_user_score_1 	= 26755;
		dataRecord.i_user_score_2 	= 1;
		dataRecord.i_user_score_3 	= 1;
		dataRecord.i_user_score_4 	= 1;
		dataRecord.i_user_score_5 	= 1;
		dataRecord.i_user_score_6 	= 1;
		dataRecord.i_user_score_7 	= 1;
		dataRecord.i_user_score_8 	= 1;
		dataRecord.i_user_score_9 	= 1;
		dataRecord.i_user_score_10 	= 1;

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((Integer)row.get('denom'),6);
		System.assertEquals((Integer)row.get('groups'),26);
		System.assertEquals((String)row.get('group_1'),'Blazing Sevens');
		System.assertEquals((String)row.get('group_2'),'Quick Hit');
		System.assertEquals((String)row.get('group_3'),'Harrahs');
		System.assertEquals((String)row.get('group_4'),'Wheel Of Fortune');
		System.assertEquals((String)row.get('group_5'),'Bonus Times');
		System.assertEquals((Integer)row.get('machines'),105);
		System.assertEquals((String)row.get('game_type'),'Slots-Reel');
		System.assertEquals((Integer)row.get('cards_top'),238);
		System.assertEquals((Decimal)row.get('denom_pref'),0.25);
		System.assertEquals((Decimal)row.get('user_amt_1'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_2'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_3'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_4'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_5'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_6'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_7'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_8'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_9'),0.01);
		System.assertEquals((Integer)row.get('denom_pref_i'),19142);
		System.assertEquals((Integer)row.get('top1_value'),18161);
		System.assertEquals((Integer)row.get('top5_value'),24514);
		System.assertEquals((String)row.get('user_flag_1'),'Slots');
		System.assertEquals((String)row.get('user_flag_2'),'e. $0.25');
		System.assertEquals((String)row.get('user_flag_3'),'A');
		System.assertEquals((String)row.get('user_flag_4'),'A');
		System.assertEquals((String)row.get('user_flag_5'),'A');
		System.assertEquals((String)row.get('user_flag_6'),'A');
		System.assertEquals((String)row.get('user_flag_7'),'A');
		System.assertEquals((String)row.get('user_flag_8'),'A');
		System.assertEquals((String)row.get('user_flag_9'),'A');
		System.assertEquals((Decimal)row.get('user_amt_10'),0.01);
		System.assertEquals((Integer)row.get('cards_total'),297);
		System.assertEquals((Integer)row.get('denom_total'),27088);
		System.assertEquals((Integer)row.get('total_value'),27088);
		System.assertEquals((String)row.get('user_flag_10'),'A');
		System.assertEquals((Integer)row.get('user_score_1'),26755);
		System.assertEquals((Integer)row.get('user_score_2'),1);
		System.assertEquals((Integer)row.get('user_score_3'),1);
		System.assertEquals((Integer)row.get('user_score_4'),1);
		System.assertEquals((Integer)row.get('user_score_5'),1);
		System.assertEquals((Integer)row.get('user_score_6'),1);
		System.assertEquals((Integer)row.get('user_score_7'),1);
		System.assertEquals((Integer)row.get('user_score_8'),1);
		System.assertEquals((Integer)row.get('user_score_9'),1);
		System.assertEquals((Integer)row.get('user_score_10'),1);
	}
}