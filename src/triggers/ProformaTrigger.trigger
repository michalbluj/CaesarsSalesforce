trigger ProformaTrigger on Proforma__c (before insert, before update, after insert, after update) {
    new ProformaTriggerHelper().run();
}