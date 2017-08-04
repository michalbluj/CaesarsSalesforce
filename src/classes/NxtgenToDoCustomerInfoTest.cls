/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for NxtgenToDoCustomerInfo class
**/
@IsTest
private class NxtgenToDoCustomerInfoTest {

	static testMethod void populateDataTest() {
		NxtgenToDoCustomerInfo info = new NxtgenToDoCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.f_worth = 2900142.00;
		dataRecord.c_app_cd = 'SFD';
		dataRecord.c_rep_id = 'F96';
		dataRecord.d_due_dt = '2015-03-30';
		dataRecord.c_book_id = 'ILVF96';
		dataRecord.c_prop_cd = 'ILV';
		dataRecord.c_task_id = null;
		dataRecord.d_due_time = '00:00:00';
		dataRecord.i_event_id = 5486;
		dataRecord.i_to_do_id = 34392086;
		dataRecord.c_last_name = 'MOUSE';
		dataRecord.d_create_dt = '2015-03-01';
		dataRecord.c_first_name = 'MICKEY';
		dataRecord.c_to_do_type = 'Adhoc';
		dataRecord.f_market_adw = 141;
		dataRecord.c_middle_init = '';
		dataRecord.c_to_do_notes = 'DUMMIED OUT TO SHORTEN CONTENT';
		dataRecord.c_to_do_status = 'C';
		dataRecord.d_last_trip_dt = '2015-02-05';
		dataRecord.c_creator_login = 'corporate';
		dataRecord.c_to_do_segment = 'Relationship Contact';
		dataRecord.c_to_do_subject = 'Relationship Contact';
		dataRecord.c_modifier_login = 'nquiambao';
		dataRecord.c_offer_reserved = 'N';
		dataRecord.c_suggested_channel = 'PHONE';
		dataRecord.d_contact_dt_by_all = '2015-02-25';
		dataRecord.d_my_last_contact_dt = '2015-02-25';
		dataRecord.d_last_contact_dt_by_me = null;
		dataRecord.d_phone_contact_dt_by_all = '2014-06-20';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((Decimal)row.get('worth'),2900142.00);
		System.assertEquals((String)row.get('app_cd'),'SFD');
		System.assertEquals((String)row.get('rep_id'),'F96');
		System.assertEquals((String)row.get('due_dt'),'2015-03-30');
		System.assertEquals((String)row.get('book_id'),'ILVF96');
		System.assertEquals((String)row.get('prop_cd'),'ILV');
		System.assertEquals((String)row.get('task_id'),null);
		System.assertEquals((String)row.get('due_time'),'00:00:00');
		System.assertEquals((Integer)row.get('event_id'),5486);
		System.assertEquals((Integer)row.get('to_do_id'),34392086);
		System.assertEquals((String)row.get('last_name'),'MOUSE');
		System.assertEquals((String)row.get('create_dt'),'2015-03-01');
		System.assertEquals((String)row.get('first_name'),'MICKEY');
		System.assertEquals((String)row.get('to_do_type'),'Adhoc');
		System.assertEquals((Decimal)row.get('market_adw'),141);
		System.assertEquals((String)row.get('middle_init'),'');
		System.assertEquals((String)row.get('to_do_notes'),'DUMMIED OUT TO SHORTEN CONTENT');
		System.assertEquals((String)row.get('to_do_status'),'C');
		System.assertEquals((String)row.get('last_trip_dt'),'2015-02-05');
		System.assertEquals((String)row.get('creator_login'),'corporate');
		System.assertEquals((String)row.get('to_do_segment'),'Relationship Contact');
		System.assertEquals((String)row.get('to_do_subject'),'Relationship Contact');
		System.assertEquals((String)row.get('modifier_login'),'nquiambao');
		System.assertEquals((String)row.get('offer_reserved'),'N');
		System.assertEquals((String)row.get('suggested_channel'),'PHONE');
		System.assertEquals((String)row.get('contact_dt_by_all'),'2015-02-25');
		System.assertEquals((String)row.get('my_last_contact_dt'),'2015-02-25');
		System.assertEquals((String)row.get('last_contact_dt_by_me'),null);
		System.assertEquals((String)row.get('phone_contact_dt_by_all'),'2014-06-20');
	}
}