/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for NxtgenInterestCustomerInfo class
**/
@IsTest
private class NxtgenInterestCustomerInfoTest {

	static testMethod void populateDataTest() {
		NxtgenInterestCustomerInfo info = new NxtgenInterestCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_app_cd 			= 'PCS';
		dataRecord.c_interest 			= 'Classical';
		dataRecord.d_create_dt 			= '2014-03-18';
		dataRecord.i_interest_id 		= 1002006489;
		dataRecord.c_creator_login 		= 'Email Survey January';
		dataRecord.c_interest_group 	= 'Music';
		dataRecord.c_interest_notes 	= 'MASKING IN CASE OF SENSITIVE INFORMATION CONTAINED';
		dataRecord.c_modifier_login 	= 'Email Survey January';
		dataRecord.c_interest_status 	= 'A';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('app_cd'),'PCS');
		System.assertEquals((String)row.get('interest'),'Classical');
		System.assertEquals((String)row.get('create_dt'),'2014-03-18');
		System.assertEquals((Integer)row.get('interest_id'),1002006489);
		System.assertEquals((String)row.get('creator_login'),'Email Survey January');
		System.assertEquals((String)row.get('interest_group'),'Music');
		System.assertEquals((String)row.get('interest_notes'),'MASKING IN CASE OF SENSITIVE INFORMATION CONTAINED');
		System.assertEquals((String)row.get('modifier_login'),'Email Survey January');
		System.assertEquals((String)row.get('interest_status'),'A');
	}
}