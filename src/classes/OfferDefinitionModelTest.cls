/*------------------------------------------------------------------------
Author:        Venkata Polavarapu    
Company:       Salesforce
Description:   A test class created to validate the OfferDefinitionModel and OfferDefinitionTriggerHandler
               
History

10-July-17   Venkata Polavarapu Utilize the TestFactory utility to get the Campaign_Project__c,Offer_Definition__c data
----------------------------------------------------------------------------*/


@isTest
private class OfferDefinitionModelTest {
    @isTest static void test_Template_Association_Standard() {
      
        list<Campaign_Project__c> lstCampProj= TestFactory.CampaignProjects   ;  
        system.debug('Campaign_Project__c'+lstCampProj);
        
        List <Offer_Definition__c> lstOfferDefinitions =TestFactory.addOfferDefinitions(lstCampProj[0]);
        system.debug('Offer_Definition__c'+lstOfferDefinitions);
        
        
        Offer_Definition__c testoffer = lstOfferDefinitions[0];
        Test.startTest();
        DML.save(testoffer);
        Test.stopTest();       
    } 

}