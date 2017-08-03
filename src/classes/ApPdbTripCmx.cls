/**
 * Created by ceezar on 31.07.2017.
 */

public with sharing class ApPdbTripCmx extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public String id {get; set;}

        public final Integer ap_pdb_trip_hdr_fk {get; set;}
        public final String c_prop_market_cd {get; set;}
        public final String c_quality_cd {get; set;}
        public final String contact_fk {get; set;}
        public final String d_end_dt {get; set;}
        public final String d_start_dt {get; set;}
        public final String d_timestamp {get; set;}
        public final Decimal f_cash_play_game {get; set;}
        public final Decimal f_cash_play_oth {get; set;}
        public final Decimal f_cash_play_slot {get; set;}
        public final Decimal f_food_comp_amt {get; set;}
        public final Decimal f_marker_play_game {get; set;}
        public final Decimal f_marker_play_oth {get; set;}
        public final Decimal f_marker_play_slot {get; set;}
        public final Decimal f_other_comp_amt {get; set;}
        public final Decimal f_room_comp_amt {get; set;}
        public final Decimal f_total_comp_amt {get; set;}
        public final String i_ap_pdb_trip_id {get; set;}
        public final String i_dmid {get; set;}
        public final Integer i_len_of_play_game {get; set;}
        public final Integer i_len_of_play_oth {get; set;}
        public final Integer i_len_of_play_slot {get; set;}
        public final Integer i_prop_market_type_id {get; set;}
        public final String market_fk {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (ApPdbTripCmx.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('ap_pdb_trip_hdr_fk', wrapper.ap_pdb_trip_hdr_fk);
            row.put('c_prop_market_cd', wrapper.c_prop_market_cd);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('contact_fk', wrapper.contact_fk);
            row.put('d_end_dt', wrapper.d_end_dt);
            row.put('d_start_dt', wrapper.d_start_dt);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('f_cash_play_game', wrapper.f_cash_play_game);
            row.put('f_cash_play_oth', wrapper.f_cash_play_oth);
            row.put('f_cash_play_slot', wrapper.f_cash_play_slot);
            row.put('f_food_comp_amt', wrapper.f_food_comp_amt);
            row.put('f_marker_play_game', wrapper.f_marker_play_game);
            row.put('f_marker_play_oth', wrapper.f_marker_play_oth);
            row.put('f_marker_play_slot', wrapper.f_marker_play_slot);
            row.put('f_other_comp_amt', wrapper.f_other_comp_amt);
            row.put('f_room_comp_amt', wrapper.f_room_comp_amt);
            row.put('f_total_comp_amt', wrapper.f_total_comp_amt);
            row.put('i_ap_pdb_trip_id', wrapper.i_ap_pdb_trip_id);
            row.put('i_dmid', wrapper.i_dmid);
            row.put('i_len_of_play_game', wrapper.i_len_of_play_game);
            row.put('i_len_of_play_oth', wrapper.i_len_of_play_oth);
            row.put('i_len_of_play_slot', wrapper.i_len_of_play_slot);
            row.put('i_prop_market_type_id', wrapper.i_prop_market_type_id);
            row.put('market_fk', wrapper.market_fk);
            rows.add(row);
        }
        return rows;
    }
}