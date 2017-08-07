/**
 * @author Cezary Zeleznicki
 * @date 31.07.2017.
 * @group Model
 * @description generic class responsible mappign ApPdbTripHdr json response
 */
public with sharing class ApPdbTripHdr extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public String id {get; set;}

        public final String account_c_home_prop_cd_fk {get; set;}
        public final String c_as_brand_flag {get; set;}
        public final String c_as_cms_flag {get; set;}
        public final String c_casino_flag {get; set;}
        public final String c_curr_flag {get; set;}
        public final String c_first_prop_visit {get; set;}
        public final String c_home_prop_cd {get; set;}
        public final String c_hotel_flag {get; set;}
        public final String c_prop_market_cd {get; set;}
        public final String c_quality_cd {get; set;}
        public final String c_rated_trip {get; set;}
        public final String c_w2g_flag {get; set;}
        public final String c_week_cd {get; set;}
        public final String contact_fk {get; set;}
        public final String d_end_dt {get; set;}
        public final String d_rpt_per {get; set;}
        public final String d_start_dt {get; set;}
        public final String d_timestamp {get; set;}
        public final String i_ap_pdb_trip_id {get; set;}
        public final Integer i_brand_trip_nbr {get; set;}
        public final String i_dmid {get; set;}
        public final Integer i_events {get; set;}
        public final Integer i_nbr_days {get; set;}
        public final Integer i_nbr_offers_red {get; set;}
        public final Integer i_nbr_offers_unred {get; set;}
        public final Integer i_prop_market_type_id {get; set;}
        public final Integer i_trip_nbr {get; set;}
        public final String market_fk {get; set;}
        public final Integer week_code_fk {get; set;}
    }

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (ApPdbTripHdr.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('account_c_home_prop_cd_fk', wrapper.account_c_home_prop_cd_fk);
            row.put('c_as_brand_flag', wrapper.c_as_brand_flag);
            row.put('c_as_cms_flag', wrapper.c_as_cms_flag);
            row.put('c_casino_flag', wrapper.c_casino_flag);
            row.put('c_curr_flag', wrapper.c_curr_flag);
            row.put('c_first_prop_visit', wrapper.c_first_prop_visit);
            row.put('c_home_prop_cd', wrapper.c_home_prop_cd);
            row.put('c_hotel_flag', wrapper.c_hotel_flag);
            row.put('c_prop_market_cd', wrapper.c_prop_market_cd);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('c_rated_trip', wrapper.c_rated_trip);
            row.put('c_w2g_flag', wrapper.c_w2g_flag);
            row.put('c_week_cd', wrapper.c_week_cd);
            row.put('contact_fk', wrapper.contact_fk);
            row.put('d_end_dt', wrapper.d_end_dt);
            row.put('d_rpt_per', wrapper.d_rpt_per);
            row.put('d_start_dt', wrapper.d_start_dt);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('i_ap_pdb_trip_id', wrapper.i_ap_pdb_trip_id);
            row.put('i_brand_trip_nbr', wrapper.i_brand_trip_nbr);
            row.put('i_dmid', wrapper.i_dmid);
            row.put('i_events', wrapper.i_events);
            row.put('i_nbr_days', wrapper.i_nbr_days);
            row.put('i_nbr_offers_red', wrapper.i_nbr_offers_red);
            row.put('i_nbr_offers_unred', wrapper.i_nbr_offers_unred);
            row.put('i_prop_market_type_id', wrapper.i_prop_market_type_id);
            row.put('i_trip_nbr', wrapper.i_trip_nbr);
            row.put('market_fk', wrapper.market_fk);
            row.put('week_code_fk', wrapper.week_code_fk);
            rows.add(row);
        }
        return rows;
    }
}