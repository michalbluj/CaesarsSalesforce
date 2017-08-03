/**
 * Created by Michal Bluj on 2017-06-28.
 */

@IsTest
private class TaxRateUtilsTest {

    private TaxRateUtilsTest() {
    }

    static testMethod void transformationTest() {
        Test.startTest();
        final List<Tax_Rates__c> rates = TaxRateUtils.clearObjectIdentifiers(TaxRateUtils.transformJsonToList(TaxRateUtils.transformTableToJson()));
        Test.stopTest();
        System.assert(rates.isEmpty());
    }
}