@isTest
private class CaseModelTest {
    
    @isTest static void testCaseWithOneDependency() {
        list<Campaign_Project__c> lstCampProj= TestFactory.CampaignProjects ;
        Campaign_Project__c testCampProj = lstCampProj[0];
        testCampProj.Status__c = 'Plan';
        DML.save(testCampProj);
        testCampProj.Status__c = 'Approved';
        DML.save(testCampProj);
        List<Case> parentList = TestFactory.uniqueCases;
        List<Case> caseList = TestFactory.uniqueCasesInstance;
        caseList[0].Campaign_Project__c = testCampProj.id;
        caseList[0].ParentId = parentList[0].id;
        caseList[0].Milestone__c = 'AEM Job Start';
        caseList[0].Status = 'Approved';
        caseList[0].Target_End_Date__c = system.today()+2;
        caseList[0].Target_Start_Date__c = system.today()+1;
        DML.save(caseList[0]);
        caseList[0].Status = 'Ready to Start';
        DML.save(caseList[0]);
        system.debug('caselist-->'+caseList[0]);
        List<Case> relatedCases = [select Id,Status,Order__c,Dependencies__c, Campaign_Project__c from Case where Campaign_Project__c =: testCampProj.Id and RecordType.Name = 'Campaign Workflow Instance'];
        Test.startTest();
        relatedCases[0].Status = 'Completed';
        DML.save(relatedCases[0]);
        Test.stopTest();
        relatedCases = [select Id,Status,Order__c,Dependencies__c, Campaign_Project__c from Case where Campaign_Project__c =: testCampProj.Id and RecordType.Name = 'Campaign Workflow Instance'];
        CaseModel.getAnchoredTasksMapping();
        
    }
    
    @isTest static void test_method_two() {
        list<Campaign_Project__c> lstCampProj= TestFactory.CampaignProjects ;
        Campaign_Project__c testCampProj = lstCampProj[0];
        testCampProj.Status__c = 'Plan';
        DML.save(testCampProj);
        testCampProj.Status__c = 'Approved';
        DML.save(testCampProj);
        List<Case> caseList = TestFactory.uniqueCasesInstance;
        caseList[0].Campaign_Project__c = testCampProj.id;
        DML.save(caseList[0]);
        caseList[1].Campaign_Project__c = testCampProj.id;
        DML.save(caseList[1]);
        system.debug('caselist-->'+caseList[0]);
        List<Case> relatedCases = [select Id,Status,Order__c,Dependencies__c, Campaign_Project__c from Case where Campaign_Project__c =: testCampProj.Id and RecordType.Name = 'Campaign Workflow Instance'];
        relatedCases[0].Status = 'Completed';
        Test.startTest();
        DML.save(relatedCases[0]);
        Test.stopTest();
        relatedCases = [select Id,Status,Order__c,Dependencies__c, Campaign_Project__c from Case where Campaign_Project__c =: testCampProj.Id and RecordType.Name = 'Campaign Workflow Instance'];
    }
    
}