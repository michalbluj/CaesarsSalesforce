/**
 * Created by Michal Bluj on 2017-07-06.
 */

@IsTest
private class CustomerInfoResponseTest
{
    static testMethod void objectTest() {
        Test.startTest();
        CustomerInfoResponse response = new CustomerInfoResponse();
        response.timestamp = String.valueOf(System.currentTimeMillis());
        response.body = new List<CustomerInfo>();
        Test.stopTest();
        System.assert(response != null);
    }
}