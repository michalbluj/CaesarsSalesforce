trigger CampaignProjectTrigger on Campaign_Project__c (before insert, before update, after insert, after update) {
    new CampaignProjectTriggerHandler().run();
}