/**
 *  @author Ivan Yeung
 *  @date 6/28/17
 *  @group Model
 *  @description  Model class for the Offer_Definition__c object
 */


public with sharing class OfferDefinitionModel {


    /*******************************************************************************************************
    * @description update the Offer Defintion id field with base30 encoding
    * @param List of offer definiton
    * @return n/a
    * @example
    *      List<Offer_Definition__c> listOfferDefinition = [select Offer_Id__c, Name from Offer_Definition__c where Offer_Id__c = null];
    *      OfferDefinitionModel.updateOfferIds(listOfferDefinition);
    */
    public static void updateOfferIds(List<Offer_Definition__c> listOfferDefinition){

        List <Offer_Definition__c> updateOfferDefinition = new List <Offer_Definition__c>();
        for (Offer_Definition__c o : listOfferDefinition ){
            String offerIdAutoNumber = o.Name.mid(3,255); // assume syntax: OD-{000000000}
            if (String.isNotBlank(offerIdAutoNumber)){
                Decimal num = Decimal.valueOf(offerIdAutoNumber);
                Offer_Definition__c updatedOffer = new Offer_Definition__c();
                updatedOffer.Id = o.Id;
                updatedOffer.Offer_Id__c = Utils.convertToBase30(num, 6);
                updateOfferDefinition.add(updatedOffer);
            }
        }

        DML.save(updateOfferDefinition);

    }


     /*******************************************************************************************************
    * @description set the offer definiton type field, based upon record Type
    * @param   Trigger.new
    * @return n/a
    * @example
    *
    */
    public static void setOfferDefinitionType(List<Offer_Definition__c> listOfferDefinitions){


        Id choiceRecordType = Schema.SObjectType.Offer_Definition__c.getRecordTypeInfosByName().get('Choice').getRecordTypeId();
        Id packageRecordType = Schema.SObjectType.Offer_Definition__c.getRecordTypeInfosByName().get('Package').getRecordTypeId();
        // System.debug('~~~~~~ choiceRecordType: ' + choiceRecordType);
        // System.debug('~~~~~~ packageRecordType: ' + packageRecordType);

        for(Offer_Definition__c o: listOfferDefinitions ){
            if (o.recordTypeId == packageRecordType){
                o.Offer_Definition_Type__c = 'Package';
            } else if (o.recordTypeId == choiceRecordType){
                o.Offer_Definition_Type__c = 'Choice';
            }

            // System.debug('~~~~~~ recordTypeId: ' + o.recordTypeId);

        }
    }



    }