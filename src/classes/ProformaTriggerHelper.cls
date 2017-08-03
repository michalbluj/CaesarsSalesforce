public with sharing class  ProformaTriggerHelper extends TriggerHandler{

    public override void beforeInsert() {
        
    }
    
    public override void beforeUpdate() {
        
    }
    
    public override void afterInsert() {
        ProformaModel.AssociateProformaToCase(null, trigger.new);
    }
    
    public override void afterUpdate() {
          ProformaModel.AssociateProformaToCase((Map<Id,Proforma__c>)Trigger.oldMap, Trigger.new);
    }
    
    
}