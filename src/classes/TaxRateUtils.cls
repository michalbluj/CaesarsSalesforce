/**
 * Created by Michal Bluj on 2017-06-28.
 */

public with sharing class TaxRateUtils {
    
    private TaxRateUtils() {
    }

    public static String transformTableToJson() {
        final List<Tax_Rates__c> taxRates = [
                select name,Slot_hold__c, Table_hold__c,Slot_volume__c,Table_volume__c,Slot_tax__c,
                        Table_tax__c,Admission_tax__c,Bad_debt__c,FB_comp_expens__c,Other_comp_exp__c,
                        Comp_room_of_GGR__c,Are_RR_Tax_Deductable__c,Are_PromoChips_Match_Play_Tax_Deductabl__c,
                        Base_RC_as_of_GGR__c
                from Tax_Rates__c
        ];
        return JSON.serialize(taxRates);
    }

    public static List<Tax_Rates__c> transformJsonToList(final String jsonString) {
        return (List<Tax_Rates__c>) JSON.deserialize(jsonString, List<Tax_Rates__c>.class);
    }

    public static List<Tax_Rates__c> clearObjectIdentifiers(final List<Tax_Rates__c> rates) {
        for (Tax_Rates__c rate : rates) {
            rate.id = null;
        }
        return rates;
    }

}