@isTest
private class CaseModelTest {
	
	@isTest static void testCaseWithOneDependency() {
		list<Campaign_Project__c> lstCampProj= TestFactory.CampaignProjects ;
		Campaign_Project__c testCampProj = lstCampProj[0];
		testCampProj.Status__c = 'Plan';
		DML.save(testCampProj);
		testCampProj.Status__c = 'Approved';
		DML.save(testCampProj);

		List<Case> relatedCases = [select Id,Status,Order__c,Dependencies__c, Campaign_Project__c from Case where Campaign_Project__c =: testCampProj.Id and RecordType.Name = 'Campaign Workflow Instance'];
		Test.startTest();
		relatedCases[0].Status = 'Completed';
		DML.save(relatedCases[0]);
		Test.stopTest();
		relatedCases = [select Id,Status,Order__c,Dependencies__c, Campaign_Project__c from Case where Campaign_Project__c =: testCampProj.Id and RecordType.Name = 'Campaign Workflow Instance'];
		system.assertEquals(relatedCases[1].Status,'Ready to Start');
		system.assertEquals(relatedCases[2].Status,'Not Started');
	}
	
	@isTest static void test_method_two() {
		list<Campaign_Project__c> lstCampProj= TestFactory.CampaignProjects ;
		Campaign_Project__c testCampProj = lstCampProj[0];
		testCampProj.Status__c = 'Plan';
		DML.save(testCampProj);
		testCampProj.Status__c = 'Approved';
		DML.save(testCampProj);

		List<Case> relatedCases = [select Id,Status,Order__c,Dependencies__c, Campaign_Project__c from Case where Campaign_Project__c =: testCampProj.Id and RecordType.Name = 'Campaign Workflow Instance'];
		relatedCases[0].Status = 'Completed';
		relatedCases[1].Status = 'Completed';
		Test.startTest();
		DML.save(relatedCases[0]);
		DML.save(relatedCases[1]);
		Test.stopTest();
		relatedCases = [select Id,Status,Order__c,Dependencies__c, Campaign_Project__c from Case where Campaign_Project__c =: testCampProj.Id and RecordType.Name = 'Campaign Workflow Instance'];
		system.assertEquals(relatedCases[2].Status,'Ready to Start');
	}
	
}