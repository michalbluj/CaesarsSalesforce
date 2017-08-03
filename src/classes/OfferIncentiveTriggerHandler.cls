/**
 *  @author Ivan Yeung
 *  @date 6/28/17
 *  @group Trigger
 *  @description  The trigger for Offer Definition
 */

public with sharing class OfferIncentiveTriggerHandler extends TriggerHandler {


    public override void beforeInsert() {

    }


    public override void beforeUpdate() {

    }

    public override void afterupdate() {
    }

    public override void afterInsert() {

        OfferIncentiveModel.updateOfferDefinitionCount(trigger.new);
        OfferIncentiveModel.updateOfferIncentiveIds(trigger.new); 

    }


}