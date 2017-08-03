/**
 *  @author Charu Goyal
 *  @date 6/27/17
 *  @group TriggerHandler
 *  @description  The trigger handler for Case
 */


public with sharing class CaseTriggerHandler extends TriggerHandler{
    
    public override void beforeInsert() {
     //   CaseModel.AsscoaiteAnchoredTasks(null,Trigger.new);
    }

    public override void beforeUpdate() {

        CaseModel.setReadyToStartTimeStamp((Map<Id,Case>)Trigger.oldMap, Trigger.new);
    }

    public override void afterInsert() {
        CaseModel.AsscoaiteAnchoredTasks(null,Trigger.new);
        CaseModel.updateParentMilestone(null, Trigger.new);
       
    }

    public override void afterUpdate() {
        CaseModel.updateCaseStatusForDependencies((Map<Id,Case>)Trigger.oldMap, Trigger.new);
        CaseModel.updateCaseMilestones((Map<Id,Case>)Trigger.oldMap, Trigger.new);
        CaseModel.createCaseMilestoneHistory((Map<Id,Case>)Trigger.oldMap, Trigger.new);
        CaseModel.processOwnershipChange((Map<Id,Case>)Trigger.oldMap, Trigger.new);
        CaseModel.updateParentMilestone((Map<Id,Case>)Trigger.oldMap, Trigger.new);
         CaseModel.AsscoaiteAnchoredTasks((Map<Id,Case>)Trigger.oldMap, Trigger.new);
        //CampaignProjectModel.setRecordType((Map<Id,Campaign_Project__c>)Trigger.oldMap, Trigger.new);
    }
}