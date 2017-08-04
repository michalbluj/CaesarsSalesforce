/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for NxtgenNotePadCustomerInfo class
**/
@IsTest
private class NxtgenNotePadCustomerInfoTest {

	static testMethod void populateDataTest() {
		NxtgenNotePadCustomerInfo info = new NxtgenNotePadCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_app_cd 			= 'PCS';
		dataRecord.c_rep_id 			= 'CKK';
		dataRecord.c_book_id 			= '1.21056E+16';
		dataRecord.c_private 			= 'T';
		dataRecord.c_prop_cd 			= 'UEL';
		dataRecord.c_note_pad 			= 'MASKING IN CASE OF SENSITIVE INFORMATION CONTAINED';
		dataRecord.d_create_dt 			= '2008-02-17';
		dataRecord.i_note_pad_id 		= 34503;
		dataRecord.c_creator_login 		= 'kkumm';
		dataRecord.c_modifier_login 	= 'kkumm';
		dataRecord.c_note_pad_status 	= 'A';
		dataRecord.c_note_pad_priority 	= ' Not Urgent';
		dataRecord.c_send_notification 	= 'F';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('app_cd'),'PCS');
		System.assertEquals((String)row.get('rep_id'),'CKK');
		System.assertEquals((String)row.get('book_id'),'1.21056E+16');
		System.assertEquals((String)row.get('private'),'T');
		System.assertEquals((String)row.get('prop_cd'),'UEL');
		System.assertEquals((String)row.get('note_pad'),'MASKING IN CASE OF SENSITIVE INFORMATION CONTAINED');
		System.assertEquals((String)row.get('create_dt'),'2008-02-17');
		System.assertEquals((Integer)row.get('note_pad_id'),34503);
		System.assertEquals((String)row.get('creator_login'),'kkumm');
		System.assertEquals((String)row.get('modifier_login'),'kkumm');
		System.assertEquals((String)row.get('note_pad_status'),'A');
		System.assertEquals((String)row.get('note_pad_priority'),' Not Urgent');
		System.assertEquals((String)row.get('send_notification'),'F');
	}
}