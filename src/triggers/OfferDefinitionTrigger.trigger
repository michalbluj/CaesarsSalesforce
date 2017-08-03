/**
 *  @author Ivan Yeung
 *  @date 6/28/17
 *  @group Trigger
 *  @description  The trigger for Offer Definition
 */

trigger OfferDefinitionTrigger on Offer_Definition__c (after insert, after update, before insert, before update) {
    new OfferDefinitionTriggerHandler().run();
}