/**
 * Created by iyeung on 6/30/17.
 */

trigger OfferIncentiveTrigger on Offer_Incentive__c (before insert, before update, after insert, after update) {

    new OfferIncentiveTriggerHandler().run();

}