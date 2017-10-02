/**
* @author Michał Bluj
* @date 2017
* @group Builder
* @description Class responsible for building Account record
**/
public with sharing class AccountBuilder {

    private Account accountObject {get;set;}
    private static AccountBuilder builderInstance{get;set;}

    /*
    * @description Builds contact builder
    * @return builder instance
    */
    public static AccountBuilder buildAccount(){
        builderInstance = new AccountBuilder();
        return builderInstance;
    }

    /*
    * @description Constructor
    */
    private AccountBuilder(){
        accountObject = new Account();
    }

    /*
    * @description Sets name for account beeing build
    * @return builder instance
    */
    public AccountBuilder withName(String name){
        builderInstance.accountObject.name = name;
        return builderInstance;
    }
    
    /*
    * @description Sets name for account beeing build
    * @return builder instance
    */
    public AccountBuilder withWinetId(String winetId){
        builderInstance.accountObject.winet_Id__c = winetId;
        return builderInstance;
    }

    /*
    * @return Built Contact record
    */
    public Account get(){
        return builderInstance.accountObject;
    }
}