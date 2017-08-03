/**
 *  @author Ivan Yeung
 *  @date 7/24/2017
 *  @group Model
 *  @description  Model class for Milestone object
 *
 *  Ref: https://developer.salesforce.com/page/Case_Milestones_Utilities_Class
 *
 */


public with sharing class MilestoneModel {

    public static final String MILESTONE_CHECKPOINT_23 = 'Checkpoint 2/3';
    public static final String MILESTONE_CHECKPOINT_DUE = 'Checkpoint Due';
    public static final String MILESTONE_WORKFLOW_SLA = 'Workflow SLA';

    public static final String MILESTONE_STATUS_VIOLATED = 'Violated';
    public static final String MILESTONE_STATUS_COMPLETED = 'Completed';


    /*******************************************************************************************************
    * @description utiltiy to complete a milestone for a case
    * @param List<Id> caseIds, String milestoneName, DateTime complDate
    * @return n/a
    * @example
    *
    */
    public static void completeMilestone(Map<Id, String> caseIdMilestoneName, DateTime complDate) {

        Datetime completeDate = complDate == null ? Datetime.now() : complDate;

        List<CaseMilestone> cmsToUpdate = [
                select Id, completionDate, cm.MilestoneType.Name, caseId
                from CaseMilestone cm
                where caseId in :caseIdMilestoneName.keySet()  and completionDate = null
        ];
        /*
        System.debug('##### case ids : ' + caseIds);
        System.debug('##### milestoneName : ' + milestoneName);
        System.debug('##### milestone to be updated: ' + cmsToUpdate);
        */
        if (cmsToUpdate.isEmpty() == false) {
            for (CaseMilestone cm : cmsToUpdate) {
                // complete the milestone that match or if the key word is ALL, close all incomplete milestone 
                if (caseIdMilestoneName.get(cm.caseId) != null  && ( caseIdMilestoneName.get(cm.caseId) == 'ALL' || cm.MilestoneType.Name == caseIdMilestoneName.get(cm.caseId))   )  {
                    cm.completionDate = completeDate;
                }
            }
            DML.save( cmsToUpdate);
        } // end if

    }


    /*******************************************************************************************************
    * @description utiltiy to create a history record in Case_Milestone_History__c
    * @param List <Case> where Last_Milestone_Violated__c identify the milestone history to be created
    * @return n/a
    * @example
    *
    */
    public static void createCaseMilestoneHistory(List <Case> caseList){

        Map<String, CaseMilestone> violatedMap = new Map<String, CaseMilestone>();
        Set<Id> caseIds = new set<Id>();
        for (Case c: caseList){
            caseIds.add(c.Id);
        }

        // retrieve all the case milestone
        for (CaseMilestone cm: [select Id, caseId, completionDate, IsCompleted, IsDeleted, IsViolated, MilestoneType.Name
        from CaseMilestone where caseId in :caseIds]){
            if (cm.IsViolated == true){
                violatedMap.put( (''+ cm.caseId + cm.MilestoneType.Name), cm );
            }
        }
        System.debug('#### map: ' + violatedMap );

        // create Case_Milestone_History__c
        List <Case_Milestone_History__c> caseMilestoneHistories = new List <Case_Milestone_History__c>();
        for (Case c: caseList){
            System.debug('#### key: ' + '' + c.Id + c.Last_Milestone_Violated__c );
            CaseMilestone cm = violatedMap.get('' + c.Id + c.Last_Milestone_Violated__c);

            if (cm != null) {
                Case_Milestone_History__c history = new Case_Milestone_History__c();
                history.Case__c = c.Id;
                history.Case_Milestone_Id__c = cm.Id;
                history.Milestone_Name__c = cm.MilestoneType.Name;
                history.Status__c = MILESTONE_STATUS_VIOLATED;

                caseMilestoneHistories.add(history);

                // also create a chatter post

                ChatterUtil.PostFeedItemMethodQueue(c.Id, 'Milestone ' + cm.MilestoneType.Name + ' is ' + MILESTONE_STATUS_VIOLATED , c.Escalation_Assignment__c, '');

            }


        }

        DML.save(caseMilestoneHistories);

    }

}