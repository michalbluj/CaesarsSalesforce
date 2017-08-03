/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Guest Slot Rating Detail external object
**/
public with sharing class GuestSlotRatingDetail extends ExternalObjectResponse implements ExternalObjectInterface {

    public List<Record> body {get; set;}

    public class Record {
        public final String contact {get; set;}
        public String id {get; set;}

        public final Decimal f_coin_in {get; set;}
        public final Decimal f_coin_out {get; set;}
        public final Decimal f_denom {get; set;}
        public final String c_ent_by {get; set;}
        public final String c_game_cd {get; set;}
        public final String i_handle_pulls {get; set;}
        public final Decimal f_jackpot_amt {get; set;}
        public final Integer i_mach_num {get; set;}
        public final Decimal f_play_time {get; set;}
        public final String c_prep_by {get; set;}
        public final String c_prop_cd {get; set;}
        public final String c_quality_cd {get; set;}
        public final Date d_rating_date {get; set;}
        public final Integer i_rs_seq_num {get; set;}
        public final Decimal f_theo_win {get; set;}
        public final Date d_timestamp {get; set;}
        public final Date d_trans_date {get; set;}
        public final Integer i_cms_dmid {get; set;}
        public final Decimal f_winloss {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (GuestSlotRatingDetail.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('contact', wrapper.contact);
            row.put('f_coin_in', wrapper.f_coin_in);
            row.put('f_coin_out', wrapper.f_coin_out);
            row.put('f_denom', wrapper.f_denom);
            row.put('c_ent_by', wrapper.c_ent_by);
            row.put('c_game_cd', wrapper.c_game_cd);
            row.put('i_handle_pulls', wrapper.i_handle_pulls);
            row.put('f_jackpot_amt', wrapper.f_jackpot_amt);
            row.put('i_mach_num', wrapper.i_mach_num);
            row.put('f_play_time', wrapper.f_play_time);
            row.put('c_prep_by', wrapper.c_prep_by);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('d_rating_date', wrapper.d_rating_date);
            row.put('i_rs_seq_num', wrapper.i_rs_seq_num);
            row.put('f_theo_win', wrapper.f_theo_win);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('d_trans_date', wrapper.d_trans_date);
            row.put('i_cms_dmid', wrapper.i_cms_dmid);
            row.put('f_winloss', wrapper.f_winloss);

            rows.add(row);
        }
        return rows;
    }
}