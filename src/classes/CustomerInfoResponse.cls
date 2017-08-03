/**
* @author Michał Bluj
* @date 2017
* @group UnitTest
* @description Class represents response for retrieving customer infos from heroku
**/
public class CustomerInfoResponse {
    public String timestamp {get;set;}
    public List<CustomerInfo> body {get;set;}
}