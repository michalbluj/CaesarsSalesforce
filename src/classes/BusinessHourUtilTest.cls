@isTest
public class BusinessHourUtilTest {
	@isTest static void test_BusinessHourUtil() {
        list<Campaign_Project__c> lstCampProj= TestFactory.CampaignProjects ;
        Campaign_Project__c testCampProj = lstCampProj[0];
        testCampProj.Status__c = 'Plan';
        DML.save(testCampProj);
        testCampProj.Status__c = 'Approved';
        DML.save(testCampProj);
        List<Case> caseList = TestFactory.uniqueCases;
        caseList[0].Campaign_Project__c = testCampProj.id;
        DML.save(caseList[0]);
        List<Case> relatedCases = [select Id,Status,Order__c,Dependencies__c, Campaign_Project__c from Case where Campaign_Project__c =: testCampProj.Id and RecordType.Name = 'Campaign Workflow Template'];
        relatedCases[0].Status = 'Completed';
        Test.startTest();
        DML.save(relatedCases[0]);
        Test.stopTest();
        relatedCases = [select Id,Status,Order__c,Dependencies__c, Campaign_Project__c from Case where Campaign_Project__c =: testCampProj.Id and RecordType.Name = 'Campaign Workflow Template'];
        BusinessHourUtil.durationInMs(12.00,12.00,12.00);
        
    }
}