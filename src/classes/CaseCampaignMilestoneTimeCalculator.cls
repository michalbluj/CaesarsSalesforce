/**
 *  @author Ivan Yeung
 *  @date 7/22/17
 *  @group Entitlement
 *  @description  The implementation of Support.MilestoneTriggerTimeCalculator interface to support the calcuation of the milestone trigger time
 */


global with sharing class CaseCampaignMilestoneTimeCalculator implements Support.MilestoneTriggerTimeCalculator  {


    /*******************************************************************************************************
    * @description implmentation of interface's calculateMilestoneTriggerTime
    * @param String caseId, String milestoneTypeId
    * @return the milestone time in term of minutes
    *
    */
    global Integer calculateMilestoneTriggerTime(String caseId, String milestoneTypeId) {

        // depend upon the miletone type , get the time stamp from the case.

        Case c = [SELECT MS_DM_Drop_Date__c, MS_Email_Drop_Date__c, MS_Email_Job_Complete__c, MS_Email_Job_Start__c, MS_Email_Proof_Approved__c, MS_POD_Submitted_Job__c, MS_Proforma_Approved__c, MS_R_R_Approved__c, MS_Standard_Campaign_Project_Complete__c, MS_Standard_Project_Kickoff__c, MS_Studio_Art_Approved__c, MS_Studio_Job_Complete__c FROM Case WHERE Id=:caseId limit 1];
        MilestoneType mt = [SELECT Name FROM MilestoneType WHERE Id=:milestoneTypeId limit 1];

        String milestoneTimeStampField = CaseModel.milestoneTimeStampMap.get(mt.Name.toUpperCase());  // assumption: the milestone type name is the same as the drop down of the campaign milestone in the case
        Integer milestoneTime = 0;

        if (String.isNotBlank(milestoneTimeStampField)){
            Datetime dueDateTime = (Datetime) c.get(milestoneTimeStampField);
            milestoneTime = (BusinessHours.diff(BusinessHourUtil.caesarsBusinessWeek.Id ,  Datetime.now(), dueDateTime) / (60 *1000)) .intValue();
        }


        return  milestoneTime;



    }

}