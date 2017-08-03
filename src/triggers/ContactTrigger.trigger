/**
 * Created by Michal Bluj on 2017-06-29.
 */

trigger ContactTrigger on Contact (before insert, after update, after insert) {
    Boolean switchVar = CaesarsSetup__c.getInstance('Contact').turnOffContactTrigger__c;

    if(!switchVar){
    	new ContactTriggerHandler().run();
    }
}