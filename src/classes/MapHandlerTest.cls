/**
* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Unit test class for MapHandler
**/
@IsTest
private class MapHandlerTest {

    static testMethod void getAcquisitionCodeMapTest() {
        List<Acquisition_Code__c> codes = TestFactory.acquisitionCodes;
        Test.startTest();
        Map<String,Id> mapa = MapHandler.getAcquisitionCodeMap();
        Test.stopTest();
        System.assertEquals(mapa.keySet().size(),2);
    }

    static testMethod void getAssociationReasonMapTest() {
        List<Association_Reason__c> reasons = TestFactory.associationReasons;
        Test.startTest();
        Map<String,Id> mapa = MapHandler.getAssociationReasonMap();
        Test.stopTest();
        System.assertEquals(mapa.keySet().size(),2);
    }

}