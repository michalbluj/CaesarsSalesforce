/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for OccupationCustomerInfo class
**/
@IsTest
private class OccupationCustomerInfoTest {

	static testMethod void populateDataTest() {
		OccupationCustomerInfo info = new OccupationCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_sic_cd 		= '';
		dataRecord.c_firm_name 		= 'BOOKING.COM (GUEST PAY)';
		dataRecord.c_job_title 		= '';
		dataRecord.c_occupation 	= '';
		dataRecord.c_owner_flag 	= '';
		dataRecord.c_quality_cd 	= '';
		dataRecord.c_nbr_yr_emply 	= '';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('sic_cd'),'');
		System.assertEquals((String)row.get('firm_name'),'BOOKING.COM (GUEST PAY)');
		System.assertEquals((String)row.get('job_title'),'');
		System.assertEquals((String)row.get('occupation'),'');
		System.assertEquals((String)row.get('owner_flag'),'');
		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((String)row.get('nbr_yr_emply'),'');
	}
}