/*------------------------------------------------------------------------
Author:        Charu Goyal    
Company:       Salesforce
Description:   A test class created to validate the CampaignProjectModel and CampaignProjectTriggerHandler
               
History

10-July-17   Venkata Polavarapu - coomented out the controller logic as the TestFactory has been modifed
----------------------------------------------------------------------------*/

@isTest
private class CampaignProjectModelTest {
    @isTest static void test_Template_Association_Standard() {
        Test.startTest();
        list<Campaign_Project__c> lstCampProj= TestFactory.CampaignProjects ;
        list<Campaign_Project__c> InsertlstCampProj = new list<Campaign_Project__c>();
        Campaign_Project__c testCampProj = lstCampProj[0];
        
        DML.save(testCampProj);
        
        testCampProj = lstCampProj[1];
        
        InsertlstCampProj.add(testCampProj);
        
        DML.save(testCampProj);
        Campaign_Project__c testCampProj2 = lstCampProj[0];
        //testCampProj = lstCampProj[1];
        testCampProj2.Status__c = 'Submitted for Approval';
        testCampProj2.Email_Drop_Date__c = date.today();
        testCampProj2.Valid_Start_Date__c =date.today()+3;
        testCampProj2.Valid_End_Date__c =date.today()+4;
        testCampProj2.Direct_Mail_Drop_Date__c =date.today()+4;
        InsertlstCampProj.add(testCampProj2);
         DML.save(InsertlstCampProj);
        
        testCampProj.Status__c = 'Plan';
        DML.save(testCampProj);
        
        list<Proforma__c> lstpf = TestFactory.getCampaignProjectProformaLst;
        Proforma__c pf = lstpf[0];
        pf.Campaign_Project__c =testCampProj.id;
        DML.save(pf);
        pf.Status__c = 'Submitted for Approval';
        DML.save(pf);
        testCampProj.Status__c = 'Submitted for Approval';
        DML.save(testCampProj);
        
         testCampProj.Status__c = 'Approved'; 
         testCampProj.Delivery_Channel__c= null;
        DML.save(testCampProj);
        
        testCampProj.Status__c = 'Rejected'; 
        DML.save(testCampProj);
        
        Test.stopTest();
    }
}