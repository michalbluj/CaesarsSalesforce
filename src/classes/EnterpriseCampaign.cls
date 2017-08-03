/**
 * Created by Michal Bluj on 2017-07-28.
 */

public with sharing class EnterpriseCampaign extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get;set;}

    public class Record {
        public final String contact {get;set;}
        public String id {get;set;}
        public final Decimal f_actual_all_all_mkts {get;set;}
        public final Decimal f_mdw_all_all_mkts {get;set;}
        public final Decimal f_mdw_rated_all_mkts {get;set;}
        public final Decimal f_theo_all_all_mkts {get;set;}
        public final Integer i_all_days_all_mkts {get;set;}
        public final Integer i_cms_rated_trips_all_mkts {get;set;}
        public final Integer i_hotel_trips_all_mkts {get;set;}
        public final Integer i_minutes_all_mkts {get;set;}
        public final Integer i_offer_trips_all_mkts {get;set;}
        public final Integer i_pdb_rated_trips_all_mkts {get;set;}
        public final Integer i_pdb_trips_all_mkts {get;set;}
        public final Integer i_rated_days_all_mkts {get;set;}
        public final String i_dmid {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows){
        for(EnterpriseCampaign.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId',wrapper.id);
            row.put('DisplayUrl',wrapper.id);
            row.put('contact',wrapper.contact);
            row.put('f_actual_all_all_mkts',wrapper.f_actual_all_all_mkts);
            row.put('f_mdw_all_all_mkts',wrapper.f_mdw_all_all_mkts);
            row.put('f_mdw_rated_all_mkts',wrapper.f_mdw_rated_all_mkts);
            row.put('f_theo_all_all_mkts',wrapper.f_theo_all_all_mkts);
            row.put('i_all_days_all_mkts',wrapper.i_all_days_all_mkts);
            row.put('i_cms_rated_trips_all_mkts',wrapper.i_cms_rated_trips_all_mkts);
            row.put('i_hotel_trips_all_mkts',wrapper.i_hotel_trips_all_mkts);
            row.put('i_minutes_all_mkts',wrapper.i_minutes_all_mkts);
            row.put('i_offer_trips_all_mkts',wrapper.i_offer_trips_all_mkts);
            row.put('i_pdb_rated_trips_all_mkts',wrapper.i_pdb_rated_trips_all_mkts);
            row.put('i_pdb_trips_all_mkts',wrapper.i_pdb_trips_all_mkts);
            row.put('i_rated_days_all_mkts',wrapper.i_rated_days_all_mkts);
            row.put('i_dmid', wrapper.i_dmid);
            rows.add(row);
        }
        return rows;
    }
}