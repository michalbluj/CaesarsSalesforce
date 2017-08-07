/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Guest Game Detail external object
**/
public with sharing class GuestGameDetail extends ExternalObjectResponse implements ExternalObjectInterface {

    public List<Record> body {get; set;}

    public class Record {
        public final String contact {get; set;}
        public String id {get; set;}

        public final Decimal f_actual_win {get; set;}
        public final Decimal f_avg_bet {get; set;}
        public final Integer i_avgbet_div {get; set;}
        public final Decimal f_cash_play {get; set;}
        public final String d_date {get; set;}
        public final String c_game_cd {get; set;}
        public final String c_game_type {get; set;}
        public final Integer i_len_of_play {get; set;}
        public final Decimal f_marker_play {get; set;}
        public final String c_prop_cd {get; set;}
        public final String d_purge_date {get; set;}
        public final String c_purge_flag {get; set;}
        public final String c_quality_cd {get; set;}
        public final String d_rpt_period {get; set;}
        public final Decimal f_slot_denom {get; set;}
        public final Decimal f_theoretical {get; set;}
        public final String d_timestamp {get; set;}
        public final String i_dmid {get; set;}
        public final String contact_sec_fk {get; set;}
        public final String contact_pri_fk {get; set;}
    }

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (GuestGameDetail.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('contact', wrapper.contact);
            row.put('f_actual_win', wrapper.f_actual_win);
            row.put('f_avg_bet', wrapper.f_avg_bet);
            row.put('i_avgbet_div', wrapper.i_avgbet_div);
            row.put('f_cash_play', wrapper.f_cash_play);
            row.put('d_date', wrapper.d_date);
            row.put('c_game_cd', wrapper.c_game_cd);
            row.put('c_game_type', wrapper.c_game_type);
            row.put('id', wrapper.id);
            row.put('i_len_of_play', wrapper.i_len_of_play);
            row.put('f_marker_play', wrapper.f_marker_play);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('d_purge_date', wrapper.d_purge_date);
            row.put('c_purge_flag', wrapper.c_purge_flag);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('d_rpt_period', wrapper.d_rpt_period);
            row.put('f_slot_denom', wrapper.f_slot_denom);
            row.put('f_theoretical', wrapper.f_theoretical);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('i_dmid', wrapper.i_dmid);
            row.put('contact_sec_fk', wrapper.contact_sec_fk);
            row.put('contact_pri_fk', wrapper.contact_pri_fk);
            rows.add(row);
        }
        return rows;
    }
}