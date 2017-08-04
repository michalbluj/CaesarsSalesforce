/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for EmailCustomerInfo class
**/
@IsTest
private class EmailCustomerInfoTest {

	static testMethod void populateDataTest() {
		EmailCustomerInfo info = new EmailCustomerInfo();

		CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
		dataRecord.c_email = 'invalid@invalid.com';
		dataRecord.c_source = 'P';
		dataRecord.c_qual_cd = '';
		dataRecord.c_ofr_freq = 'WEEKLY';
		dataRecord.c_qual_cat = '';
		dataRecord.c_email_flag = 'Y';
		dataRecord.c_quality_cd = '';
		dataRecord.i_contact_count = 0;
		dataRecord.c_last_bounce_cd = 'H';
		dataRecord.c_qual_reason_cd = '';
		dataRecord.c_qual_hygiene_cd = '';
		dataRecord.d_bounce_timestamp = '1899-12-31T00:00:00';
		dataRecord.d_qual_chg_timestamp = '1899-12-31T00:00:00';
		dataRecord.c_email_engagement_cd = 'M';
		dataRecord.d_email_chg_timestamp = '1899-12-31T00:00:00';
		dataRecord.d_qual_conf_timestamp = '1899-12-31T00:00:00';
		dataRecord.c_email_address_valid_cd = 'Y';
		dataRecord.c_email_address_quality_cd = 'B';
		dataRecord.d_last_change_timestamp_utc = '2014-12-12';

		CustomerInfo wrapper = new CustomerInfo();
		wrapper.data = dataRecord;

		Test.startTest();
		Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
		Test.stopTest();

		System.assertEquals((String)row.get('email'),'invalid@invalid.com');
		System.assertEquals((String)row.get('source'),'P');
		System.assertEquals((String)row.get('qual_cd'),'');
		System.assertEquals((String)row.get('ofr_freq'),'WEEKLY');
		System.assertEquals((String)row.get('qual_cat'),'');
		System.assertEquals((String)row.get('email_flag'),'Y');
		System.assertEquals((String)row.get('quality_cd'),'');
		System.assertEquals((Integer)row.get('contact_count'),0);
		System.assertEquals((String)row.get('last_bounce_cd'),'H');
		System.assertEquals((String)row.get('qual_reason_cd'),'');
		System.assertEquals((String)row.get('qual_hygiene_cd'),'');
		System.assertEquals((String)row.get('bounce_timestamp'),'1899-12-31T00:00:00');
		System.assertEquals((String)row.get('qual_chg_timestamp'),'1899-12-31T00:00:00');
		System.assertEquals((String)row.get('email_engagement_cd'),'M');
		System.assertEquals((String)row.get('email_chg_timestamp'),'1899-12-31T00:00:00');
		System.assertEquals((String)row.get('qual_conf_timestamp'),'1899-12-31T00:00:00');
		System.assertEquals((String)row.get('email_address_valid_cd'),'Y');
		System.assertEquals((String)row.get('email_address_quality_cd'),'B');
		System.assertEquals((String)row.get('last_change_timestamp_utc'),'2014-12-12');
	}
}