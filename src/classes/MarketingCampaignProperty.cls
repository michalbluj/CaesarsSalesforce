/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Marketing Campaign Property external object
**/
public with sharing class MarketingCampaignProperty extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get;set;}

    public class Record {
        public String contact {get;set;}
        public String id {get;set;}
        public final String c_acct_type_cd_fk {get;set;}
        public final String c_campaign_cd_fk {get;set;}
        public final String c_campaign_type_fk {get;set;}
        public final String c_dom_cd_prop_fk {get;set;}
        public final String c_dom_market_cd_fk {get;set;}
        public final String c_dom_pref_prop_cd_fk {get;set;}
        public final String c_pref_prop_cd_fk {get;set;}
        public final String c_prop_cd_1_fk {get;set;}
        public final String c_prop_cd_2_fk {get;set;}
        public final String c_prop_cd_fk {get;set;}
        public final String c_worth_break {get;set;}
        public final Decimal f_property_worth {get;set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows){
        for(MarketingCampaignProperty.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId',wrapper.id);
            row.put('DisplayUrl',wrapper.id);
            row.put('contact',wrapper.contact);
            row.put('c_acct_type_cd_fk',wrapper.c_acct_type_cd_fk);
            row.put('c_campaign_cd_fk',wrapper.c_campaign_cd_fk);
            row.put('c_campaign_type_fk',wrapper.c_campaign_type_fk);
            row.put('c_dom_cd_prop_fk',wrapper.c_dom_cd_prop_fk);
            row.put('c_dom_market_cd_fk',wrapper.c_dom_market_cd_fk);
            row.put('c_dom_pref_prop_cd_fk',wrapper.c_dom_pref_prop_cd_fk);
            row.put('c_pref_prop_cd_fk',wrapper.c_pref_prop_cd_fk);
            row.put('c_prop_cd_1_fk',wrapper.c_prop_cd_1_fk);
            row.put('c_prop_cd_2_fk',wrapper.c_prop_cd_2_fk);
            row.put('c_prop_cd_fk',wrapper.c_prop_cd_fk);
            row.put('c_worth_break',wrapper.c_worth_break);
            row.put('f_property_worth',wrapper.f_property_worth);
            rows.add(row);
        }
        return rows;
    }
}