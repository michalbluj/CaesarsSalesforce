/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for TierScoreCustomerInfo class
**/
@IsTest
private class TierScoreCustomerInfoTest {

    static testMethod void populateDataTest() {
        TierScoreCustomerInfo info = new TierScoreCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.i_year = 2013;
        dataRecord.d_as_of = '2013-09-03';
        dataRecord.d_posted_on = '2013-09-04';
        dataRecord.c_quality_cd = '';
        dataRecord.f_promo_base = 0;
        dataRecord.f_tier_score = 4;
        dataRecord.f_adjust_base = 0;
        dataRecord.f_earned_base = 4;
        dataRecord.f_prev_tier_score = 0;

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((Integer)row.get('year'),2013);
        System.assertEquals((String)row.get('as_of'),'2013-09-03');
        System.assertEquals((String)row.get('posted_on'),'2013-09-04');
        System.assertEquals((String)row.get('quality_cd'),'');
        System.assertEquals((Decimal)row.get('promo_base'),0);
        System.assertEquals((Decimal)row.get('tier_score'),4);
        System.assertEquals((Decimal)row.get('adjust_base'),0);
        System.assertEquals((Decimal)row.get('earned_base'),4);
        System.assertEquals((Decimal)row.get('prev_tier_score'),0);
    }
}