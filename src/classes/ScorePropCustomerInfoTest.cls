/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for ScorePropCustomerInfo class
**/
@IsTest
private class ScorePropCustomerInfoTest {

	static testMethod void populateDataTest() {
		ScorePropCustomerInfo info = new ScorePropCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_prop_cd = 'NOR';
		dataRecord.i_mileage = 659;
		dataRecord.c_quality_cd = 'C';
		dataRecord.f_prep_trips = 1.5;
		dataRecord.f_user_amt_1 = 0;
		dataRecord.f_user_amt_2 = 0;
		dataRecord.f_user_amt_3 = 1;
		dataRecord.f_user_amt_4 = 0;
		dataRecord.f_user_amt_5 = 0.01;
		dataRecord.f_user_amt_6 = -9.99;
		dataRecord.f_user_amt_7 = 0.75;
		dataRecord.f_user_amt_8 = 0.75;
		dataRecord.f_user_amt_9 = 0.8;
		dataRecord.i_pred_worth = 126;
		dataRecord.c_user_flag_1 = null;
		dataRecord.c_user_flag_2 = 'N';
		dataRecord.c_user_flag_3 = null;
		dataRecord.c_user_flag_4 = null;
		dataRecord.c_user_flag_5 = null;
		dataRecord.c_user_flag_6 = null;
		dataRecord.c_user_flag_7 = null;
		dataRecord.c_user_flag_8 = 'YYYYYYYYYY';
		dataRecord.c_user_flag_9 = null;
		dataRecord.d_last_update = '2004-01-26';
		dataRecord.i_user_score_1 = 48;
		dataRecord.i_user_score_2 = 0;
		dataRecord.i_user_score_3 = 0;
		dataRecord.i_user_score_4 = 1;
		dataRecord.i_user_score_5 = 1;
		dataRecord.i_user_score_6 = 1;
		dataRecord.i_user_score_7 = 8;
		dataRecord.i_user_score_8 = 0;
		dataRecord.i_user_score_9 = 0;
		dataRecord.i_pred_hotel_day = 126;
		dataRecord.i_pred_hotel_trip = 126;

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('prop_cd'),'NOR');
		System.assertEquals((Integer)row.get('mileage'),659);
		System.assertEquals((String)row.get('quality_cd'),'C');
		System.assertEquals((Decimal)row.get('prep_trips'),1.5);
		System.assertEquals((Decimal)row.get('user_amt_1'),0);
		System.assertEquals((Decimal)row.get('user_amt_2'),0);
		System.assertEquals((Decimal)row.get('user_amt_3'),1);
		System.assertEquals((Decimal)row.get('user_amt_4'),0);
		System.assertEquals((Decimal)row.get('user_amt_5'),0.01);
		System.assertEquals((Decimal)row.get('user_amt_6'),-9.99);
		System.assertEquals((Decimal)row.get('user_amt_7'),0.75);
		System.assertEquals((Decimal)row.get('user_amt_8'),0.75);
		System.assertEquals((Decimal)row.get('user_amt_9'),0.8);
		System.assertEquals((Integer)row.get('pred_worth'),126);
		System.assertEquals((String)row.get('user_flag_1'),null);
		System.assertEquals((String)row.get('user_flag_2'),'N');
		System.assertEquals((String)row.get('user_flag_3'),null);
		System.assertEquals((String)row.get('user_flag_4'),null);
		System.assertEquals((String)row.get('user_flag_5'),null);
		System.assertEquals((String)row.get('user_flag_6'),null);
		System.assertEquals((String)row.get('user_flag_7'),null);
		System.assertEquals((String)row.get('user_flag_8'),'YYYYYYYYYY');
		System.assertEquals((String)row.get('user_flag_9'),null);
		System.assertEquals((String)row.get('last_update'),'2004-01-26');
		System.assertEquals((Integer)row.get('user_score_1'),48);
		System.assertEquals((Integer)row.get('user_score_2'),0);
		System.assertEquals((Integer)row.get('user_score_3'),0);
		System.assertEquals((Integer)row.get('user_score_4'),1);
		System.assertEquals((Integer)row.get('user_score_5'),1);
		System.assertEquals((Integer)row.get('user_score_6'),1);
		System.assertEquals((Integer)row.get('user_score_7'),8);
		System.assertEquals((Integer)row.get('user_score_8'),0);
		System.assertEquals((Integer)row.get('user_score_9'),0);
		System.assertEquals((Integer)row.get('pred_hotel_day'),126);
		System.assertEquals((Integer)row.get('pred_hotel_trip'),126);
	}
}