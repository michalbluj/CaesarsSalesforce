/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for NxtgenNicknameCustomerInfo class
**/
@IsTest
private class NxtgenNicknameCustomerInfoTest {

    static testMethod void populateDataTest() {
        NxtgenNicknameCustomerInfo info = new NxtgenNicknameCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.c_app_cd 		= 'SFD';
		dataRecord.c_nick_name 		= null;
		dataRecord.d_create_dt 		= '2017-04-09';
		dataRecord.c_creator_login 	= null;
		dataRecord.c_modifier_login = null;

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('app_cd'),'SFD');
		System.assertEquals((String)row.get('nick_name'),null);
		System.assertEquals((String)row.get('create_dt'),'2017-04-09');
		System.assertEquals((String)row.get('creator_login'),null);
		System.assertEquals((String)row.get('modifier_login'),null);
    }
}