/**
* @author Michał Bluj
* @date 2017
* @group Utils
* @description Class responsible for holding endpoint for various heroku operations
**/
public with sharing class HKUEndpoint {

    private static String customerValue = null;
    private static String externalObjectValue = null;

    public static String getEndpoint() {
        if(customerValue == null){
            customerValue = initiate();
        }
        return customerValue;
    }

    public static String getCustomerEndpoint() {
        if(customerValue == null){
            customerValue = initiateCustomer();
        }
        return customerValue;
    }

    public static String getGenericExternalObjectEndpoint() {
        if(externalObjectValue == null){
            externalObjectValue = initiateGeneralExternalObject();
        }
        return externalObjectValue;
    }

    private static String initiate() {
        return 'callout:herokuapp/customer/getCustomers';
    }

    private static String initiateCustomer() {
        return 'callout:herokuapp/customer/getCustomers';
    }

    private static String initiateGeneralExternalObject(){
        return 'callout:herokuapp/Salesforce/getDataFromTable';
    }

}