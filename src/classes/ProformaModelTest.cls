@isTest
private class ProformaModelTest {
    
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
        List<Proforma__c> proList = TestFactory.getCampaignProjectProformaLst;      
        proList[0].Campaign_Project__c = lstCampProj[1].id;
        DML.save(proList);
        proList[0].Campaign_Project__c = testCampProj.id;
        proList[0].Status__c = 'Approved';
        DML.save(proList);
    }
    
    
}