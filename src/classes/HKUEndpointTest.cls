/**
* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Unit test class for HKUEndpoint class
**/
@IsTest
private class HKUEndpointTest {

    static testMethod void getEndpointTest() {
        Test.startTest();
        String endpoint = HKUEndpoint.getEndpoint();
        Test.stopTest();
        System.assertEquals('https://caesarsapp.herokuapp.com/api/v1/customer/getCustomers', endpoint,
            'Endpoint should be correctly retrieved');
    }

    static testMethod void getCustomerEndpointTest() {
        Test.startTest();
        String endpoint = HKUEndpoint.getCustomerEndpoint();
        Test.stopTest();
        System.assertEquals('https://caesarsapp.herokuapp.com/api/v1/customer/getCustomers', endpoint,
            'Endpoint should be correctly retrieved');
    }

    static testMethod void getGenericExternalObjectEndpointTest() {
        Test.startTest();
        String endpoint = HKUEndpoint.getGenericExternalObjectEndpoint();
        Test.stopTest();
        System.assertEquals('https://caesarsapp.herokuapp.com/api/v1/Salesforce/getDataFromTable', endpoint,
            'Endpoint should be correctly retrieved');
    }
}