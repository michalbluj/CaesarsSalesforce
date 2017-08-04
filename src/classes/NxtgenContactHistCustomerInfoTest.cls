/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for NxtgenContactHistCustomerInfo class
**/
@IsTest
private class NxtgenContactHistCustomerInfoTest {

	static testMethod void populateDataTest() {
		NxtgenContactHistCustomerInfo info = new NxtgenContactHistCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_app_cd 			= 'SFD';
		dataRecord.c_rep_id 			= 'D90';
		dataRecord.c_book_id 			= 'BACD90';
		dataRecord.c_outcome 			= 'RelationshipContact';
		dataRecord.c_prop_cd 			= 'BAC';
		dataRecord.c_task_id 			= '00T4000005uFDSfEAO';
		dataRecord.i_to_do_id 			= 0;
		dataRecord.c_direction 			= 'Outbound';
		dataRecord.c_last_name 			= 'MOUSE';
		dataRecord.d_create_dt 			= '2017-06-22';
		dataRecord.c_first_name 		= 'MICKEY';
		dataRecord.d_contact_dt 		= '2017-06-22';
		dataRecord.i_contact_id 		= 258312616;
		dataRecord.c_middle_init 		= 'A';
		dataRecord.c_outcome_desc 		= null;
		dataRecord.c_outcome_more 		= null;
		dataRecord.c_creator_login 		= 'dvaccaro';
		dataRecord.c_outcome_notes 		= 'MASKING IN CASE OF SENSITIVE INFORMATION CONTAINED';
		dataRecord.c_contact_status 	= 'A';
		dataRecord.c_modifier_login 	= 'mdorsz';
		dataRecord.c_contact_subject 	= 'Relationship Contact';
		dataRecord.c_contacted_channel 	= 'Mass Email';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('app_cd'),'SFD');
		System.assertEquals((String)row.get('rep_id'),'D90');
		System.assertEquals((String)row.get('book_id'),'BACD90');
		System.assertEquals((String)row.get('outcome'),'RelationshipContact');
		System.assertEquals((String)row.get('prop_cd'),'BAC');
		System.assertEquals((String)row.get('task_id'),'00T4000005uFDSfEAO');
		System.assertEquals((Integer)row.get('to_do_id'),0);
		System.assertEquals((String)row.get('direction'),'Outbound');
		System.assertEquals((String)row.get('last_name'),'MOUSE');
		System.assertEquals((String)row.get('create_dt'),'2017-06-22');
		System.assertEquals((String)row.get('first_name'),'MICKEY');
		System.assertEquals((String)row.get('contact_dt'),'2017-06-22');
		System.assertEquals((Integer)row.get('contact_id'),258312616);
		System.assertEquals((String)row.get('middle_init'),'A');
		System.assertEquals((String)row.get('outcome_desc'),null);
		System.assertEquals((String)row.get('outcome_more'),null);
		System.assertEquals((String)row.get('creator_login'),'dvaccaro');
		System.assertEquals((String)row.get('outcome_notes'),'MASKING IN CASE OF SENSITIVE INFORMATION CONTAINED');
		System.assertEquals((String)row.get('contact_status'),'A');
		System.assertEquals((String)row.get('modifier_login'),'mdorsz');
		System.assertEquals((String)row.get('contact_subject'),'Relationship Contact');
		System.assertEquals((String)row.get('contacted_channel'),'Mass Email');
	}
}