/**
 *  @author Ivan Yeung
 *  @date 6/28/17
 *  @group Trigger
 *  @description  The trigger for Offer Definition
 */

public with sharing class OfferDefinitionTriggerHandler extends TriggerHandler {

    public override void beforeInsert() {
    }

    public override void beforeUpdate() {
        OfferDefinitionModel.setOfferDefinitionType( Trigger.new ) ;
    }

    public override void afterupdate() {
    }

    public override void afterInsert() {

        OfferDefinitionModel.updateOfferIds( Trigger.new ) ;

        
    }





}