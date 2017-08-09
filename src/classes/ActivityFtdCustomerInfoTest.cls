/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for ActivityFtdCustomerInfo class
**/
@IsTest
private class ActivityFtdCustomerInfoTest {

	static testMethod void populateDataTest() {
		ActivityFtdCustomerInfo info = new ActivityFtdCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_prop_cd 			= 'CHE';
		dataRecord.c_pos_flag 			= 'N';
		dataRecord.c_w2g_flag 			= 'N';
		dataRecord.d_acq_date 			= '1999-05-09';
		dataRecord.c_comp_flag 			= 'N';
		dataRecord.c_curr_flag 			= 'N';
		dataRecord.c_event_flag 		= 'N';
		dataRecord.c_hotel_flag 		= 'N';
		dataRecord.c_quality_cd 		= '';
		dataRecord.c_visit_flag 		= 'Y';
		dataRecord.c_rating_flag 		= 'Y';
		dataRecord.d_last_trip_dt 		= '1999-05-09';
		dataRecord.c_cons_rev_flag 		= 'N';
		dataRecord.d_first_trip_dt 		= '1999-05-09';
		dataRecord.c_acquisition_cd 	= 'CAS';
		dataRecord.c_offer_rdm_flag 	= 'N';
		dataRecord.d_last_activity_dt 	= '1999-05-09';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('prop_cd'),'CHE');
		System.assertEquals((String)row.get('pos_flag'),'N');
		System.assertEquals((String)row.get('w2g_flag'),'N');
		System.assertEquals((String)row.get('acq_date'),'1999-05-09');
		System.assertEquals((String)row.get('comp_flag'),'N');
		System.assertEquals((String)row.get('curr_flag'),'N');
		System.assertEquals((String)row.get('event_flag'),'N');
		System.assertEquals((String)row.get('hotel_flag'),'N');
		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((String)row.get('visit_flag'),'Y');
		System.assertEquals((String)row.get('rating_flag'),'Y');
		System.assertEquals((String)row.get('last_trip_dt'),'1999-05-09');
		System.assertEquals((String)row.get('cons_rev_flag'),'N');
		System.assertEquals((String)row.get('first_trip_dt'),'1999-05-09');
		System.assertEquals((String)row.get('acquisition_cd'),'CAS');
		System.assertEquals((String)row.get('offer_rdm_flag'),'N');
		System.assertEquals((String)row.get('last_activity_dt'),'1999-05-09');
	}
}