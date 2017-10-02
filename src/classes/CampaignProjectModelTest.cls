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
        Campaign_Project__c testCampProj = lstCampProj[0];
        
        List<Case> caseList = TestFactory.uniqueCasesInstance;
        caseList[0].Campaign_Project__c = lstCampProj[0].id;
        update caseList[0];
        
        testCampProj = lstCampProj[1];
        testCampProj.Email_Drop_Date__c = date.today()+1;
        testCampProj.Valid_End_Date__c = date.today()+5;
        testCampProj.Valid_Start_Date__c = date.today()+4;
        testCampProj.Direct_Mail_Drop_Date__c = date.today()+3;
        
        testCampProj.Status__c = 'Plan';
        DML.save(testCampProj); 
        
        testCampProj.Status__c = 'Submitted for Approval'; 
        DML.save(testCampProj);
        
        testCampProj.Status__c = 'Approved'; 
        DML.save(testCampProj);
        Campaign_Project_Workflow__c caProjectWork = TestFactory.addCampaignProjectWorkflow(lstCampProj[0]);
        testCampProj.Status__c = 'Rejected';
         
        DML.save(testCampProj);
        
        Test.stopTest();
    }
     @isTest static void ProformaModelTestMethod () {
        list<Campaign_Project__c> lstCampProj= TestFactory.CampaignProjects ;
        Campaign_Project__c testCampProj = lstCampProj[0];
        testCampProj.Status__c = 'Plan';
        DML.save(testCampProj);
        testCampProj.Status__c = 'Approved';
        DML.save(testCampProj);
        
        List<Case> caseList = TestFactory.uniqueCasesInstance;        
        caseList[0].Campaign_Project__c = testCampProj.id;
        caseList[0].subject = 'test Approve Pro Formation';
        DML.save(caseList[0]);
        
        testCampProj.Email_Drop_Date__c = date.today()+1;
        testCampProj.Valid_End_Date__c = date.today()+5;
        testCampProj.Valid_Start_Date__c = date.today()+4;
        testCampProj.Direct_Mail_Drop_Date__c = date.today()+3;
        
        testCampProj.Status__c = 'Plan';
        DML.save(testCampProj); 
        
        testCampProj.Status__c = 'Submitted for Approval'; 
        DML.save(testCampProj);
                
        List<Proforma__c> proList = TestFactory.getCampaignProjectProformaLst;      
        proList[0].Campaign_Project__c = lstCampProj[1].id;
        DML.save(proList);
        
        proList[0].Campaign_Project__c = testCampProj.id;
        proList[0].Status__c = 'Approved';
        DML.save(proList);
    }
}