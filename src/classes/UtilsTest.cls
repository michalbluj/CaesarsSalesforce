/*
* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Unit test class for Utils class
**/
@IsTest
private class UtilsTest {

    static testMethod void convertToBase30Test() {
        Test.startTest();
        String base30 = Utils.convertToBase30(643234534590.0);
        Test.stopTest();
        System.assertEquals(base30,'TCAGL8D0');
    }

    static testMethod void convertToBase30WithPadTest() {
        Test.startTest();
        String base30 = Utils.convertToBase30(29.0,6);
        Test.stopTest();
        System.assertEquals(base30,'00000T');
    }
}