/**
 *  @author Charu Goyal
 *  @date 6/27/17
 *  @group TriggerHandler
 *  @description  The trigger handler for Campaign_Project__c
 */

public with sharing class CampaignProjectTriggerHandler extends TriggerHandler {
    


    public override void beforeInsert() {
        CampaignProjectModel.setChannelFlag(null, Trigger.new);
    }

    public override void beforeUpdate() {

        CampaignProjectModel.setRecordType((Map<Id,Campaign_Project__c>)Trigger.oldMap, Trigger.new);
        CampaignProjectModel.setChannelFlag((Map<Id,Campaign_Project__c>)Trigger.oldMap, Trigger.new);
        CampaignProjectModel.UpdateeAncoredTaskCases((Map<Id,Campaign_Project__c>)Trigger.oldMap, Trigger.new);
    }

    public override void afterInsert() {

        CampaignProjectModel.createCampaignProjectWorkflow(Trigger.new);


    }

    public override void afterUpdate() {



        CampaignProjectModel.createPlanningCases((Map<Id,Campaign_Project__c>)Trigger.oldMap, Trigger.new);
        CampaignProjectModel.createExecutionCases((Map<Id,Campaign_Project__c>)Trigger.oldMap, Trigger.new);


    }

    
}