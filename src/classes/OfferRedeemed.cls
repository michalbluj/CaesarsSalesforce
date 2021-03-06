/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Offer Redeemed external object
**/
public with sharing class OfferRedeemed extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get;set;}

    public class Record {
        public String contact {get;set;}
        public String id {get;set;}

        public final String c_collateral_id {get; set;}
        public final String c_coupon_id {get; set;}
        public final String c_coupon_type {get; set;}
        public final String c_logon {get; set;}
        public final String c_offer_id {get; set;}
        public final String c_offer_status {get; set;}
        public final String c_purge_flag {get; set;}
        public final String c_quality_cd {get; set;}
        public final String c_rdm_channel {get; set;}
        public final String c_rdm_source {get; set;}
        public final String c_valid_prop_cd {get; set;}
        public final Decimal f_rdm_amount {get; set;}
        public final Integer i_coupon_counter {get; set;}
        public final Integer i_coupon_key {get; set;}
        public final String i_dmid {get; set;}
        public final String i_gst_offer_nbr {get; set;}
        public final Integer i_pdb_trip_id {get; set;}
        public final String d_offer_status_dt {get; set;}
        public final String d_pdb_timestamp {get; set;}
        public final String d_purge_date {get; set;}
        public final String d_rpt_period {get; set;}
        public final String d_timestamp {get; set;}

    }

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows){
        for(OfferRedeemed.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId',wrapper.id);
            row.put('DisplayUrl',wrapper.id);
            row.put('contact',wrapper.contact);
            row.put('c_collateral_id', wrapper.c_collateral_id);
            row.put('c_coupon_id', wrapper.c_coupon_id);
            row.put('c_coupon_type', wrapper.c_coupon_type);
            row.put('c_logon', wrapper.c_logon);
            row.put('c_offer_id', wrapper.c_offer_id);
            row.put('c_offer_status', wrapper.c_offer_status);
            row.put('c_purge_flag', wrapper.c_purge_flag);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('c_rdm_channel', wrapper.c_rdm_channel);
            row.put('c_rdm_source', wrapper.c_rdm_source);
            row.put('c_valid_prop_cd', wrapper.c_valid_prop_cd);
            row.put('f_rdm_amount', wrapper.f_rdm_amount);
            row.put('i_coupon_counter', wrapper.i_coupon_counter);
            row.put('i_coupon_key', wrapper.i_coupon_key);
            row.put('i_dmid', wrapper.i_dmid);
            row.put('i_gst_offer_nbr', wrapper.i_gst_offer_nbr);
            row.put('i_pdb_trip_id', wrapper.i_pdb_trip_id);
            row.put('d_offer_status_dt', wrapper.d_offer_status_dt);
            row.put('d_pdb_timestamp', wrapper.d_pdb_timestamp);
            row.put('d_purge_date', wrapper.d_purge_date);
            row.put('d_rpt_period', wrapper.d_rpt_period);
            row.put('d_timestamp', wrapper.d_timestamp);
            rows.add(row);
        }
        return rows;
    }

}