/*	@description   model class for Global Picklist value set
*
*
*    @author Ivan Yeung
*    @date 07/13/2017
*    @group Model
*/

public with sharing class GlobalPicklistModel {


    /*******************************************************************************************************
    * @description retrive picklist value from a speicfic field
    * @param   object API name, field API name
    * @return List<String> of picklist value;
    */
    public static Map<String, String> getPicklistValues(String ObjectApi_name,String Field_name) {

        Map<String, String> lstPickvals = new Map<String, String >();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(ObjectApi_name);//From the Object Api name retrieving the SObject
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> pick_list_values = field_map.get(Field_name).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
            lstPickvals.put( a.getValue(), a.getLabel() );//add the value  to our final list
        }

        return lstPickvals;
    }


    /*******************************************************************************************************
    * @description retrive pickilst value of the offer incentive category
    * @param   n/a
    * @return List<String> of picklist value;
    */
    private static Map<String, String> pOfferIncentiveCategories;
    public static Map<String, String> offerIncentiveCategories{
        get {
            if (pOfferIncentiveCategories == null){

                pOfferIncentiveCategories = getPicklistValues('Offer_Incentive__c', 'Offer_Incentive_Category__c');
            }

            return pOfferIncentiveCategories;
        }
    }

    /*******************************************************************************************************
    * @description retrive pickilst value of the offer incentive category
    * @param   n/a
    * @return List<String> of picklist value;
    */
    private static Map<String, String> pOfferIncentiveSubCategories;
    public static Map<String, String> offerIncentiveSubCategories{
        get {
            if (pOfferIncentiveSubCategories == null){

                pOfferIncentiveSubCategories = getPicklistValues('Offer_Incentive__c', 'Offer_Incentive_Subcategory__c');
            }

            return pOfferIncentiveSubCategories;
        }
    }


}