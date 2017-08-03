/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Marketing LVM external object
**/
public with sharing class MarketingLVM extends ExternalObjectResponse implements ExternalObjectInterface {

    public List<Record> body {get; set;}

    public class Record {
        public String contact {get; set;}
        public String id {get; set;}
        public final String c_acct_type_cd_fk {get; set;}
        public final String c_dom_pref_prop_cd_fk {get; set;}
        public final String c_prop_market_cd_fk {get; set;}
        public final String c_tier_cd_fk {get; set;}
        public final String c_acct_type_cd {get; set;}
        public final String c_adw_break_12 {get; set;}
        public final String c_adw_break_15 {get; set;}
        public final String c_adw_break_24 {get; set;}
        public final String c_adw_break_48 {get; set;}
        public final String c_adw_trip_break_12 {get; set;}
        public final String c_adw_trip_break_6 {get; set;}
        public final String c_avg_day_hotel_flag {get; set;}
        public final String c_channel_pref {get; set;}
        public final String c_country_cd_ah {get; set;}
        public final String c_credit_status_flag {get; set;}
        public final String c_distance_cluster {get; set;}
        public final String c_dom_cd_prop {get; set;}
        public final String c_dom_cd_prop_fk {get; set;}
        public final String c_dom_pref_prop_cd {get; set;}
        public final String c_emailable {get; set;}
        public final String c_ethnic_group1 {get; set;}
        public final String c_frequency_tc_12 {get; set;}
        public final String c_frequency_tc_48 {get; set;}
        public final String c_frequency_ttm_24 {get; set;}
        public final String c_frequency_ttm {get; set;}
        public final String c_game_pref {get; set;}
        public final String c_hotel_adw_break_12 {get; set;}
        public final String c_hotel_adw_break_15 {get; set;}
        public final String c_hotel_adw_break_24 {get; set;}
        public final String c_hotel_adw_break_48 {get; set;}
        public final String c_hotel_adw_break {get; set;}
        public final String c_last_gaming_trip {get; set;}
        public final String c_mailable {get; set;}
        public final String c_main_ethnic_type {get; set;}
        public final String c_prop_mail_cd {get; set;}
        public final String c_prop_market_cd {get; set;}
        public final String c_recency {get; set;}
        public final String c_rep_id_blv {get; set;}
        public final String c_rep_id_clv {get; set;}
        public final String c_rep_id_flv {get; set;}
        public final String c_rep_id_ilv {get; set;}
        public final String c_rep_id_las {get; set;}
        public final String c_rep_id_phv {get; set;}
        public final String c_rep_id_plv {get; set;}
        public final String c_rep_id_rlv {get; set;}
        public final String c_tier_cd {get; set;}
        public final String c_tierscore_desc {get; set;}
        public final String c_zip_7_pdb {get; set;}
        public final Decimal f_act_all_ap_pdb_12mn_plus {get; set;}
        public final Decimal f_actual_all_p_pm15 {get; set;}
        public final Decimal f_ada_p_pm15 {get; set;}
        public final Decimal f_adt_p_pm15 {get; set;}
        public final Decimal f_adw_12 {get; set;}
        public final Decimal f_adw_15 {get; set;}
        public final Decimal f_adw_24 {get; set;}
        public final Decimal f_adw_48 {get; set;}
        public final Decimal f_adw_trip_12 {get; set;}
        public final Decimal f_adw_trip_6 {get; set;}
        public final Decimal f_daily_act_ap_pdb_12mn_plus {get; set;}
        public final Decimal f_daily_theo_ap_pdb_12mnplus {get; set;}
        public final Decimal f_hotel_adw_12 {get; set;}
        public final Decimal f_hotel_adw_15 {get; set;}
        public final Decimal f_hotel_adw_24 {get; set;}
        public final Decimal f_hotel_adw_48 {get; set;}
        public final Decimal f_hotel_adw {get; set;}
        public final Decimal f_slot_pct_ap_pdb_12mn_plus {get; set;}
        public final Decimal f_slot_pct_pm15 {get; set;}
        public final Decimal f_theo_all_ap_pdb_12mn_plus {get; set;}
        public final Decimal f_theo_all_p_pm15 {get; set;}
        public final Decimal f_theo_slot_pm12 {get; set;}
        public final Decimal f_theo_slot_pm15 {get; set;}
        public final Decimal f_tier_score {get; set;}
        public final Decimal f_trip_cycle_12 {get; set;}
        public final Decimal f_trip_cycle_48 {get; set;}
        public final Decimal f_trp_all_adj_sc_pdb_12mn {get; set;}
        public final Integer i_age_adj_ah {get; set;}
        public final Integer i_cas_acct_blv {get; set;}
        public final Integer i_cas_acct_clv {get; set;}
        public final Integer i_cas_acct_flv {get; set;}
        public final Integer i_cas_acct_ilv {get; set;}
        public final Integer i_cas_acct_las {get; set;}
        public final Integer i_cas_acct_phv {get; set;}
        public final Integer i_cas_acct_plv {get; set;}
        public final Integer i_cas_acct_rlv {get; set;}
        public final Integer i_days_rtd_ap_pdb_12mn_plus {get; set;}
        public final Integer i_days_since_gaming {get; set;}
        public final Integer i_days_since_last {get; set;}
        public final String i_dmid {get; set;}
        public final Integer i_dob_mn_adj_ah {get; set;}
        public final Integer i_email_decile {get; set;}
        public final Integer i_nbr_rtd_trips_p_pm15 {get; set;}
        public final Integer i_nbr_trips_p_pm15 {get; set;}
        public final Integer i_nbr_trips_p_pm24 {get; set;}
        public final Integer i_random_1 {get; set;}
        public final Integer i_random_2 {get; set;}
        public final Integer i_random_static_yr {get; set;}
        public final Integer i_rated_days_p_pm15 {get; set;}
        public final Integer i_trp_rtd_ap_pdb_12mn_plus {get; set;}
        public final Integer i_ttm_trip_cnt_12 {get; set;}
        public final Integer i_ttm_trip_cnt_24 {get; set;}
        public final Integer lvm12mohv {get; set;}
        public final Integer lvm15mohv {get; set;}
        public final Integer lvm24mohv {get; set;}
        public final Integer max_exp_date_exh_12mo {get; set;}
        public final Integer max_exp_date_exh_24mo {get; set;}
        public final Integer max_exp_date_ina_12mo {get; set;}
        public final Integer max_exp_date_ina_24mo {get; set;}
        public final Integer max_exp_date_sin_12mo {get; set;}
        public final Integer max_exp_date_sin_24mo {get; set;}
        public final String predicted_bucket_12mo {get; set;}
        public final String predicted_bucket_24mo {get; set;}
        public final Integer probability_12mo {get; set;}
        public final Integer probability_24mo {get; set;}
        public final String d_campaign_score_dt {get; set;}
        public final String d_min_est_dt {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (MarketingLVM.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('contact', wrapper.contact);
            row.put('c_acct_type_cd_fk', wrapper.c_acct_type_cd_fk);
            row.put('c_dom_pref_prop_cd_fk', wrapper.c_dom_pref_prop_cd_fk);
            row.put('c_prop_market_cd_fk', wrapper.c_prop_market_cd_fk);
            row.put('c_tier_cd_fk', wrapper.c_tier_cd_fk);
            row.put('c_acct_type_cd', wrapper.c_acct_type_cd);
            row.put('c_adw_break_12', wrapper.c_adw_break_12);
            row.put('c_adw_break_15', wrapper.c_adw_break_15);
            row.put('c_adw_break_24', wrapper.c_adw_break_24);
            row.put('c_adw_break_48', wrapper.c_adw_break_48);
            row.put('c_adw_trip_break_12', wrapper.c_adw_trip_break_12);
            row.put('c_adw_trip_break_6', wrapper.c_adw_trip_break_6);
            row.put('c_avg_day_hotel_flag', wrapper.c_avg_day_hotel_flag);
            row.put('c_channel_pref', wrapper.c_channel_pref);
            row.put('c_country_cd_ah', wrapper.c_country_cd_ah);
            row.put('c_credit_status_flag', wrapper.c_credit_status_flag);
            row.put('c_distance_cluster', wrapper.c_distance_cluster);
            row.put('c_dom_cd_prop', wrapper.c_dom_cd_prop);
            row.put('c_dom_cd_prop_fk', wrapper.c_dom_cd_prop_fk);
            row.put('c_dom_pref_prop_cd', wrapper.c_dom_pref_prop_cd);
            row.put('c_emailable', wrapper.c_emailable);
            row.put('c_ethnic_group1', wrapper.c_ethnic_group1);
            row.put('c_frequency_tc_12', wrapper.c_frequency_tc_12);
            row.put('c_frequency_tc_48', wrapper.c_frequency_tc_48);
            row.put('c_frequency_ttm_24', wrapper.c_frequency_ttm_24);
            row.put('c_frequency_ttm', wrapper.c_frequency_ttm);
            row.put('c_game_pref', wrapper.c_game_pref);
            row.put('c_hotel_adw_break_12', wrapper.c_hotel_adw_break_12);
            row.put('c_hotel_adw_break_15', wrapper.c_hotel_adw_break_15);
            row.put('c_hotel_adw_break_24', wrapper.c_hotel_adw_break_24);
            row.put('c_hotel_adw_break_48', wrapper.c_hotel_adw_break_48);
            row.put('c_hotel_adw_break', wrapper.c_hotel_adw_break);
            row.put('c_last_gaming_trip', wrapper.c_last_gaming_trip);
            row.put('c_mailable', wrapper.c_mailable);
            row.put('c_main_ethnic_type', wrapper.c_main_ethnic_type);
            row.put('c_prop_mail_cd', wrapper.c_prop_mail_cd);
            row.put('c_prop_market_cd', wrapper.c_prop_market_cd);
            row.put('c_recency', wrapper.c_recency);
            row.put('c_rep_id_blv', wrapper.c_rep_id_blv);
            row.put('c_rep_id_clv', wrapper.c_rep_id_clv);
            row.put('c_rep_id_flv', wrapper.c_rep_id_flv);
            row.put('c_rep_id_ilv', wrapper.c_rep_id_ilv);
            row.put('c_rep_id_las', wrapper.c_rep_id_las);
            row.put('c_rep_id_phv', wrapper.c_rep_id_phv);
            row.put('c_rep_id_plv', wrapper.c_rep_id_plv);
            row.put('c_rep_id_rlv', wrapper.c_rep_id_rlv);
            row.put('c_tier_cd', wrapper.c_tier_cd);
            row.put('c_tierscore_desc', wrapper.c_tierscore_desc);
            row.put('c_zip_7_pdb', wrapper.c_zip_7_pdb);
            row.put('f_act_all_ap_pdb_12mn_plus', wrapper.f_act_all_ap_pdb_12mn_plus);
            row.put('f_actual_all_p_pm15', wrapper.f_actual_all_p_pm15);
            row.put('f_ada_p_pm15', wrapper.f_ada_p_pm15);
            row.put('f_adt_p_pm15', wrapper.f_adt_p_pm15);
            row.put('f_adw_12', wrapper.f_adw_12);
            row.put('f_adw_15', wrapper.f_adw_15);
            row.put('f_adw_24', wrapper.f_adw_24);
            row.put('f_adw_48', wrapper.f_adw_48);
            row.put('f_adw_trip_12', wrapper.f_adw_trip_12);
            row.put('f_adw_trip_6', wrapper.f_adw_trip_6);
            row.put('f_daily_act_ap_pdb_12mn_plus', wrapper.f_daily_act_ap_pdb_12mn_plus);
            row.put('f_daily_theo_ap_pdb_12mnplus', wrapper.f_daily_theo_ap_pdb_12mnplus);
            row.put('f_hotel_adw_12', wrapper.f_hotel_adw_12);
            row.put('f_hotel_adw_15', wrapper.f_hotel_adw_15);
            row.put('f_hotel_adw_24', wrapper.f_hotel_adw_24);
            row.put('f_hotel_adw_48', wrapper.f_hotel_adw_48);
            row.put('f_hotel_adw', wrapper.f_hotel_adw);
            row.put('f_slot_pct_ap_pdb_12mn_plus', wrapper.f_slot_pct_ap_pdb_12mn_plus);
            row.put('f_slot_pct_pm15', wrapper.f_slot_pct_pm15);
            row.put('f_theo_all_ap_pdb_12mn_plus', wrapper.f_theo_all_ap_pdb_12mn_plus);
            row.put('f_theo_all_p_pm15', wrapper.f_theo_all_p_pm15);
            row.put('f_theo_slot_pm12', wrapper.f_theo_slot_pm12);
            row.put('f_theo_slot_pm15', wrapper.f_theo_slot_pm15);
            row.put('f_tier_score', wrapper.f_tier_score);
            row.put('f_trip_cycle_12', wrapper.f_trip_cycle_12);
            row.put('f_trip_cycle_48', wrapper.f_trip_cycle_48);
            row.put('f_trp_all_adj_sc_pdb_12mn', wrapper.f_trp_all_adj_sc_pdb_12mn);
            row.put('i_age_adj_ah', wrapper.i_age_adj_ah);
            row.put('i_cas_acct_blv', wrapper.i_cas_acct_blv);
            row.put('i_cas_acct_clv', wrapper.i_cas_acct_clv);
            row.put('i_cas_acct_flv', wrapper.i_cas_acct_flv);
            row.put('i_cas_acct_ilv', wrapper.i_cas_acct_ilv);
            row.put('i_cas_acct_las', wrapper.i_cas_acct_las);
            row.put('i_cas_acct_phv', wrapper.i_cas_acct_phv);
            row.put('i_cas_acct_plv', wrapper.i_cas_acct_plv);
            row.put('i_cas_acct_rlv', wrapper.i_cas_acct_rlv);
            row.put('i_days_rtd_ap_pdb_12mn_plus', wrapper.i_days_rtd_ap_pdb_12mn_plus);
            row.put('i_days_since_gaming', wrapper.i_days_since_gaming);
            row.put('i_days_since_last', wrapper.i_days_since_last);
            row.put('i_dmid', wrapper.i_dmid);
            row.put('i_dob_mn_adj_ah', wrapper.i_dob_mn_adj_ah);
            row.put('i_email_decile', wrapper.i_email_decile);
            row.put('i_nbr_rtd_trips_p_pm15', wrapper.i_nbr_rtd_trips_p_pm15);
            row.put('i_nbr_trips_p_pm15', wrapper.i_nbr_trips_p_pm15);
            row.put('i_nbr_trips_p_pm24', wrapper.i_nbr_trips_p_pm24);
            row.put('i_random_1', wrapper.i_random_1);
            row.put('i_random_2', wrapper.i_random_2);
            row.put('i_random_static_yr', wrapper.i_random_static_yr);
            row.put('i_rated_days_p_pm15', wrapper.i_rated_days_p_pm15);
            row.put('i_trp_rtd_ap_pdb_12mn_plus', wrapper.i_trp_rtd_ap_pdb_12mn_plus);
            row.put('i_ttm_trip_cnt_12', wrapper.i_ttm_trip_cnt_12);
            row.put('i_ttm_trip_cnt_24', wrapper.i_ttm_trip_cnt_24);
            row.put('lvm12mohv', wrapper.lvm12mohv);
            row.put('lvm15mohv', wrapper.lvm15mohv);
            row.put('lvm24mohv', wrapper.lvm24mohv);
            row.put('max_exp_date_exh_12mo', wrapper.max_exp_date_exh_12mo);
            row.put('max_exp_date_exh_24mo', wrapper.max_exp_date_exh_24mo);
            row.put('max_exp_date_ina_12mo', wrapper.max_exp_date_ina_12mo);
            row.put('max_exp_date_ina_24mo', wrapper.max_exp_date_ina_24mo);
            row.put('max_exp_date_sin_12mo', wrapper.max_exp_date_sin_12mo);
            row.put('max_exp_date_sin_24mo', wrapper.max_exp_date_sin_24mo);
            row.put('predicted_bucket_12mo', wrapper.predicted_bucket_12mo);
            row.put('predicted_bucket_24mo', wrapper.predicted_bucket_24mo);
            row.put('probability_12mo', wrapper.probability_12mo);
            row.put('probability_24mo', wrapper.probability_24mo);
            row.put('d_campaign_score_dt', wrapper.d_campaign_score_dt);
            row.put('d_min_est_dt', wrapper.d_min_est_dt);
            rows.add(row);
        }
        return rows;
    }
}