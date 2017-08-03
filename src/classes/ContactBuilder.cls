/**
* @author Michał Bluj
* @date 2017
* @group Builder
* @description Class responsible for building Contact record
**/
public with sharing class ContactBuilder {
    private Contact contactObject {get;set;}
    private static ContactBuilder builderInstance{get;set;}

    /*
    * @description Builds contact builder
    * @return builder instance
    */
    public static ContactBuilder buildContact(){
        builderInstance = new ContactBuilder();
        return builderInstance;
    }

    private ContactBuilder(){
        contactObject = new Contact();
    }

    /*
    * @description Sets first name for contact beeing build
    * @return builder instance
    */
    public ContactBuilder withFirstName(String name){
        builderInstance.contactObject.firstName = name;
        return builderInstance;
    }

    /*
    * @description Sets last name for contact beeing build
    * @return builder instance
    */
    public ContactBuilder withLastName(String name){
        builderInstance.contactObject.lastName = name;
        return builderInstance;
    }

    /*
    * @description Sets winet id for contact beeing build
    * @return builder instance
    */
    public ContactBuilder withWinetId(String id){
        builderInstance.contactObject.winet_id__c = id;
        return builderInstance;
    }

    /*
    * @description Sets account id for contact beeing build
    * @return builder instance
    */
    public ContactBuilder withAccount(Id account){
        builderInstance.contactObject.accountId = account;
        return builderInstance;
    }

    /*
    * @description Sets established date for contact beeing build
    * @return builder instance
    */
    public ContactBuilder withEstablishedDate(Date estDate){
        builderInstance.contactObject.Established_Date__c = estDate;
        return builderInstance;
    }

    /*
    * @return Built Contact record
    */
    public Contact get(){
        return builderInstance.contactObject;
    }

}