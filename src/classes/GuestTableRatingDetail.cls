/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Guest Table Rating Detail external object
**/
public with sharing class GuestTableRatingDetail extends ExternalObjectResponse implements ExternalObjectInterface {

    public List<Record> body {get; set;}

    public class Record {
        public final String contact {get; set;}
        public String id {get; set;}

        public final Decimal f_avg_bet_1 {get; set;}
        public final Decimal f_avg_bet_2 {get; set;}
        public final Decimal f_avg_bet_3 {get; set;}
        public final Decimal f_avg_bet_4 {get; set;}
        public final Decimal f_avg_bet_5 {get; set;}
        public final Decimal f_avg_bet_6 {get; set;}
        public final Decimal f_buy_in {get; set;}
        public final Decimal f_cash {get; set;}
        public final Decimal f_cash_out {get; set;}
        public final String c_company {get; set;}
        public final Decimal f_comp_worth {get; set;}
        public final Decimal f_countercheck {get; set;}
        public final Integer i_countercheck_cnt {get; set;}
        public final String c_entered_by {get; set;}
        public final String c_game_speed {get; set;}
        public final Decimal f_handle {get; set;}
        public final Decimal f_hands_played {get; set;}
        public final Integer i_minutes_played {get; set;}
        public final String c_pit_num {get; set;}
        public final String c_prop_cd {get; set;}
        public final String c_prop_game_cd {get; set;}
        public final String c_quality_cd {get; set;}
        public final String c_rated_by {get; set;}
        public final String c_rate_type {get; set;}
        public final String d_rating_date {get; set;}
        public final Integer i_rating_hyd {get; set;}
        public final Integer i_rating_num {get; set;}
        public final String c_shift {get; set;}
        public final String c_table_num {get; set;}
        public final Decimal f_theo_win {get; set;}
        public final String d_timestamp {get; set;}
        public final String d_trans_date {get; set;}
        public final Integer i_trans_hyd {get; set;}
        public final Integer i_cms_dmid {get; set;}
        public final String d_trans_time {get; set;}
        public final String d_rating_start_time {get; set;}
        public final String d_seq_rating_start_time {get; set;}
        public final String d_rating_end_time {get; set;}
    }

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (GuestTableRatingDetail.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('contact', wrapper.contact);
            row.put('f_avg_bet_1', wrapper.f_avg_bet_1);
            row.put('f_avg_bet_2', wrapper.f_avg_bet_2);
            row.put('f_avg_bet_3', wrapper.f_avg_bet_3);
            row.put('f_avg_bet_4', wrapper.f_avg_bet_4);
            row.put('f_avg_bet_5', wrapper.f_avg_bet_5);
            row.put('f_avg_bet_6', wrapper.f_avg_bet_6);
            row.put('f_buy_in', wrapper.f_buy_in);
            row.put('f_cash', wrapper.f_cash);
            row.put('f_cash_out', wrapper.f_cash_out);
            row.put('c_company', wrapper.c_company);
            row.put('f_comp_worth', wrapper.f_comp_worth);
            row.put('f_countercheck', wrapper.f_countercheck);
            row.put('i_countercheck_cnt', wrapper.i_countercheck_cnt);
            row.put('c_entered_by', wrapper.c_entered_by);
            row.put('c_game_speed', wrapper.c_game_speed);
            row.put('f_handle', wrapper.f_handle);
            row.put('f_hands_played', wrapper.f_hands_played);
            row.put('i_minutes_played', wrapper.i_minutes_played);
            row.put('c_pit_num', wrapper.c_pit_num);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_prop_game_cd', wrapper.c_prop_game_cd);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('c_rated_by', wrapper.c_rated_by);
            row.put('c_rate_type', wrapper.c_rate_type);
            row.put('d_rating_date', wrapper.d_rating_date);
            row.put('i_rating_hyd', wrapper.i_rating_hyd);
            row.put('i_rating_num', wrapper.i_rating_num);
            row.put('c_shift', wrapper.c_shift);
            row.put('c_table_num', wrapper.c_table_num);
            row.put('f_theo_win', wrapper.f_theo_win);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('d_trans_date', wrapper.d_trans_date);
            row.put('i_trans_hyd', wrapper.i_trans_hyd);
            row.put('i_cms_dmid', wrapper.i_cms_dmid);
            row.put('d_trans_time', wrapper.d_trans_time);
            row.put('d_rating_start_time', wrapper.d_rating_start_time);
            row.put('d_seq_rating_start_time', wrapper.d_seq_rating_start_time);
            row.put('d_rating_end_time', wrapper.d_rating_end_time);
            rows.add(row);
        }
        return rows;
    }
}