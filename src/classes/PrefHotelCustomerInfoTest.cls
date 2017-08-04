/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for PrefHotelCustomerInfo class
**/
@IsTest
private class PrefHotelCustomerInfoTest {

	static testMethod void populateDataTest() {
		PrefHotelCustomerInfo info = new PrefHotelCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_cc_type 			= null;
		dataRecord.c_smoking 			= null;
		dataRecord.c_bed_type 			= null;
		dataRecord.c_cc_number 			= null;
		dataRecord.c_room_type 			= null;
		dataRecord.c_quality_cd 		= '';
		dataRecord.c_companion_id 		= null;
		dataRecord.c_spcl_request 		= null;
		dataRecord.d_cc_expire_dt 		= '1899-12-31';
		dataRecord.c_spcl_instruction 	= null;

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('cc_type'),null);
		System.assertEquals((String)row.get('smoking'),null);
		System.assertEquals((String)row.get('bed_type'),null);
		System.assertEquals((String)row.get('cc_number'),null);
		System.assertEquals((String)row.get('room_type'),null);
		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((String)row.get('companion_id'),null);
		System.assertEquals((String)row.get('spcl_request'),null);
		System.assertEquals((String)row.get('cc_expire_dt'),'1899-12-31');
		System.assertEquals((String)row.get('spcl_instruction'),null);
	}
}