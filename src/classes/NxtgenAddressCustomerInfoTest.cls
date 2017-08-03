/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for NxtgenAddressCustomerInfo class
**/
@IsTest
private class NxtgenAddressCustomerInfoTest {

    static testMethod void populateDataTest() {
		NxtgenAddressCustomerInfo info = new NxtgenAddressCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_email 			= null;
		dataRecord.c_notes 			= null;
		dataRecord.c_phone 			= '';
		dataRecord.c_addr_1 		= 'work # 111-111-1111';
		dataRecord.c_addr_2 		= 'Cell #111-111-1111';
		dataRecord.c_addr_3 		= null;
		dataRecord.c_app_cd 		= 'PCS';
		dataRecord.c_rep_id 		= 'CLB';
		dataRecord.c_zip_cd 		= '';
		dataRecord.c_book_id 		= '1.21056E+16';
		dataRecord.c_prop_cd 		= 'MET';
		dataRecord.c_state_cd 		= null;
		dataRecord.c_addr_desc 		= null;
		dataRecord.c_city_name 		= null;
		dataRecord.d_create_dt 		= '2004-01-23';
		dataRecord.c_country_cd 	= null;
		dataRecord.c_state_name 	= null;
		dataRecord.i_note_pad_id 	= 3187;
		dataRecord.c_creator_login 	= 'cbaugher';
		dataRecord.c_addr_status_cd = 'A';
		dataRecord.c_modifier_login = 'cbaugher';
		dataRecord.i_pcs_address_id = 1481;

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('email'),null);
		System.assertEquals((String)row.get('notes'),null);
		System.assertEquals((String)row.get('phone'),'');
		System.assertEquals((String)row.get('addr_1'),'work # 111-111-1111');
		System.assertEquals((String)row.get('addr_2'),'Cell #111-111-1111');
		System.assertEquals((String)row.get('addr_3'),null);
		System.assertEquals((String)row.get('app_cd'),'PCS');
		System.assertEquals((String)row.get('rep_id'),'CLB');
		System.assertEquals((String)row.get('zip_cd'),'');
		System.assertEquals((String)row.get('book_id'),'1.21056E+16');
		System.assertEquals((String)row.get('prop_cd'),'MET');
		System.assertEquals((String)row.get('state_cd'),null);
		System.assertEquals((String)row.get('addr_desc'),null);
		System.assertEquals((String)row.get('city_name'),null);
		System.assertEquals((String)row.get('create_dt'),'2004-01-23');
		System.assertEquals((String)row.get('country_cd'),null);
		System.assertEquals((String)row.get('state_name'),null);
		System.assertEquals((Integer)row.get('note_pad_id'),3187);
		System.assertEquals((String)row.get('creator_login'),'cbaugher');
		System.assertEquals((String)row.get('addr_status_cd'),'A');
		System.assertEquals((String)row.get('modifier_login'),'cbaugher');
		System.assertEquals((Integer)row.get('pcs_address_id'),1481);
    }
}