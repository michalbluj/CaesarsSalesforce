/**
 *  @author Ivan Yeung
 *  @date 6/28/17
 *  @group Model
 *  @description  Model class for the Offer_Incentive__c object
 */


public with sharing class OfferIncentiveModel {

    /*******************************************************************************************************
    * @description update the Offer Incentive id field with base30 encoding
    * @param List of offer incentive
    * @return n/a
    * @example
    *      List<Offer_Incentive__c> listOfferInentive = [select Offer_Id__c, Name from Offer_Definition__c where Offer_Id__c = null];
    *      OfferIncentiveModel.updateOfferIds(listOfferInentive);
    */
    public static void  updateOfferIncentiveIds(List<Offer_Incentive__c> listOfferIncentives){

        List <Offer_Incentive__c> updateOfferIncentives = new List <Offer_Incentive__c>();
        for (Offer_Incentive__c o : listOfferIncentives ){
            String offerIdAutoNumber = o.Name.mid(3,255); // assume syntax: OD-{000000000}
            if (String.isNotBlank(offerIdAutoNumber)){
                Decimal num = Decimal.valueOf(offerIdAutoNumber);
                Offer_Incentive__c updatedOffer = new Offer_Incentive__c();
                updatedOffer.Id = o.Id;
                updatedOffer.Offer_Incentive_Id__c = Utils.convertToBase30(num, 6);
                updateOfferIncentives.add(updatedOffer);
            }
        }

        DML.save(updateOfferIncentives);

    }

  /*******************************************************************************************************
    *  temporary solution. to be replaced with rollup summary package.
    */
    public static void  updateOfferDefinitionCount(List<Offer_Incentive__c> listOfferIncentives){


        Set <Id> offerDefinitionIds = new Set <Id>();
        map <Id, Integer> offerCountMap = new map<Id, Integer>();
        for (Offer_Incentive__c o : listOfferIncentives ){
            if (o.Offer_Definition__c != null){
                if (offerDefinitionIds.contains(o.Offer_Definition__c)){
                    Integer existingCount = offerCountMap.get(o.Offer_Definition__c);
                    existingCount += 1;
                    offerCountMap.put(o.Offer_Definition__c, existingCount);
                } else {
                    offerCountMap.put(o.Offer_Definition__c, 1);
                    offerDefinitionIds.add(o.Offer_Definition__c);
                }
            }
        }

        System.debug('~~~~~~ offerCountMap: ' + offerCountMap);

        if (offerDefinitionIds.size() > 0){
            List <Offer_Definition__c> updateOfferDefinitions = [select Id, Offer_Incentive_Count__c from Offer_Definition__c  where Id in: offerDefinitionIds ];
            for (Offer_Definition__c o: updateOfferDefinitions){
                System.debug('~~~~~~ offerCountMap: ' + offerCountMap);
                System.debug('~~~~~~ offerCountMap count: ' + offerCountMap.get(o.Id));
                if (o.Offer_Incentive_Count__c != null) {
                    o.Offer_Incentive_Count__c += offerCountMap.get(o.Id);
                } else {
                    o.Offer_Incentive_Count__c = offerCountMap.get(o.Id);
                }
            }
            DML.save(updateOfferDefinitions);
        }


    }


    /*******************************************************************************************************
    * @description  if Offer_Definition__c is not set already, get from Offer_Incentive_Group__c if it is available
    * @param List of offer incentive
    * @return n/a
    * @example
    *      List<Offer_Incentive__c> listOfferInentive = [select Offer_Id__c, Name from Offer_Definition__c where Offer_Id__c = null];
    *      OfferIncentiveModel.updateOfferIds(listOfferInentive);
    */
    /*
    public static void setOfferDefinitionFromGroup(List<Offer_Incentive__c> listOfferIncentives) {

        // get the offer definition id from offer incentive group, if needed
        Set<Id> offerIncentiveGroupIds = new Set<Id>();


        for (Offer_Incentive__c o : listOfferIncentives) {
            if (o.Offer_Definition__c == null && o.Offer_Incentive_Group__c != null) {
                offerIncentiveGroupIds.add(o.Offer_Incentive_Group__c);
            }
        }

        Map<Id, Id> groupToDefinitionIdMap = new Map<id, id>();
        if (offerIncentiveGroupIds.size() > 0) {
            for (Offer_Incentive_Group__c g:  [select Id, Offer_Definition__c from Offer_Incentive_Group__c where Id in :offerIncentiveGroupIds] ){
                groupToDefinitionIdMap.put(g.Id, g.Offer_Definition__c);
            }
        }

        // set the offer definiton id from offer incentive group. note this function does not impose DML operation
        for (Offer_Incentive__c o : listOfferIncentives) {
            if (o.Offer_Definition__c == null && o.Offer_Incentive_Group__c != null) {
                o.Offer_Definition__c = groupToDefinitionIdMap.get(o.Offer_Incentive_Group__c);
            }
        }


    }
    */


}