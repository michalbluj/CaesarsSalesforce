/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Marketing Campaign external object
**/
public with sharing class MarketingCampaign extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get;set;}

    public class Record {
        public String contact {get;set;}
        public String id {get;set;}
        public final String c_acct_type_cd_fk {get;set;}
        public final String c_campaign_type_fk {get;set;}
        public final String c_campaign_cd_fk {get;set;}
        public final String c_dom_cd_prop_fk {get;set;}
        public final String c_dom_market_cd_fk {get;set;}
        public final String c_dom_pref_prop_cd_fk {get;set;}
        public final String c_pref_prop_cd_fk {get;set;}
        public final String c_prop_cd_1_fk {get;set;}
        public final String c_prop_cd_2_fk {get;set;}
        public final String c_tier_cd_fk {get;set;}
        public final Decimal f_worth {get;set;}
        public final String d_campaign_score_dt {get;set;}
        public final String d_create_dt_ent  {get;set;}
        public final String d_create_dt_mkt  {get;set;}
        public final String d_first_dt_played_mkt_ah  {get;set;}
        public final String d_first_gaming_dt_ent_ah  {get;set;}
        public final String d_min_est_dt  {get;set;}
        public final String d_last_rated_dt_mkt_ah  {get;set;}
        public final String d_last_activity_dt  {get;set;}
        public final String d_first_gaming_dt_mkt_ah {get;set;}
        public final String c_acct_type_cd {get;set;}
        public final String c_adw_break_12 {get;set;}
        public final String c_adw_break_15 {get;set;}
        public final String c_adw_break_24 {get;set;}
        public final String c_adw_break_48 {get;set;}
        public final String c_adw_trip_break_12 {get;set;}
        public final String c_adw_trip_break_6 {get;set;}
        public final String c_age_18_plus {get;set;}
        public final String c_age_19_plus {get;set;}
        public final String c_age_21_plus {get;set;}
        public final String c_avg_day_hotel_flag {get;set;}
        public final String c_baccarat_pref {get;set;}
        public final String c_campaign_cd {get;set;}
        public final String c_campaign_desc {get;set;}
        public final String c_campaign_type {get;set;}
        public final String c_campaign_type_desc {get;set;}
        public final String c_channel_pref {get;set;}
        public final String c_channel_rec {get;set;}
        public final String c_convienence_cd {get;set;}
        public final String c_convienence_cd_new {get;set;}
        public final String c_country_cd_ah {get;set;}
        public final String c_credit_status_flag {get;set;}
        public final String c_distance_cluster {get;set;}
        public final String c_dom_cd_prop {get;set;}
        public final String c_dom_market_cd {get;set;}
        public final String c_dom_pref_prop_cd {get;set;}
        public final String c_dom_prop_host_cd_adj_ah {get;set;}
        public final String c_drive_distance_cluster {get;set;}
        public final String c_emailable {get;set;}
        public final String c_ethnic_group1	 {get;set;}
        public final String c_frequency {get;set;}
        public final String c_frequency_tc {get;set;}
        public final String c_frequency_tc_12 {get;set;}
        public final String c_frequency_ttm {get;set;}
        public final String c_frequency_ttm_24 {get;set;}
        public final String c_future_res_flag_mkt_ah {get;set;}
        public final String c_game_pref {get;set;}
        public final String c_gender {get;set;}
        public final String c_geo_dm_zone {get;set;}
        public final String c_geo_rpt_zone {get;set;}
        public final String c_gst_prop_dm_optout_flag {get;set;}
        public final String c_host_type {get;set;}
        public final String c_hotel_adw_break {get;set;}
        public final String c_hotel_adw_break_12 {get;set;}
        public final String c_hotel_adw_break_15 {get;set;}
        public final String c_hotel_adw_break_24 {get;set;}
        public final String c_hotel_adw_break_48 {get;set;}
        public final String c_id_verified {get;set;}
        public final String c_last_gaming_trip {get;set;}
        public final String c_mailable {get;set;}
        public final String c_main_ethnic_type {get;set;}
        public final String c_marketing_state_cd {get;set;}
        public final String c_mkt_host_cd_adj_ah {get;set;}
        public final String c_msa {get;set;}
        public final String c_msa_cd {get;set;}
        public final String c_pref_prop_cd {get;set;}
        public final String c_pref_prop_host_cd {get;set;}
        public final String c_preferred_written_language {get;set;}
        public final String c_profit_flag_ent {get;set;}
        public final String c_profit_flag_mkt {get;set;}
        public final String c_prop_cd_1 {get;set;}
        public final String c_prop_cd_1_host_cd_adj_ah {get;set;}
        public final String c_prop_cd_2 {get;set;}
        public final String c_prop_mail_cd {get;set;}
        public final String c_prop_market_cd {get;set;}
        public final String c_prop_market_cd_fk {get;set;}
        public final String c_recency {get;set;}
        public final String c_regulatory_state_cd {get;set;}
        public final String c_tdc_supp_flag {get;set;}
        public final String c_tier_cd {get;set;}
        public final String c_tierscore_desc {get;set;}
        public final String c_uci_supp_flag {get;set;}
        public final String c_ucl_supp_flag {get;set;}
        public final String c_uk_res_supress {get;set;}
        public final String c_version_cd {get;set;}
        public final String c_video_poker_pref {get;set;}
        public final String c_worth_break {get;set;}
        public final String c_worth_break_max {get;set;}
        public final String c_worth_break_min {get;set;}
        public final String c_zip_7_ah {get;set;}
        public final String c_zip_7_pdb {get;set;}
        public final Decimal f_act_all_12mn_ap_ah {get;set;}
        public final Decimal f_act_all_1mn_ap_ah {get;set;}
        public final Decimal f_act_all_3mn_ap_ah {get;set;}
        public final Decimal f_act_all_6mn_ap_ah {get;set;}
        public final Decimal f_act_all_ap_pdb_12mn_plus {get;set;}
        public final Decimal f_act_all_ap_pdb_24mn_plus {get;set;}
        public final Decimal f_act_all_cms_first_day_m_ah {get;set;}
        public final Decimal f_act_all_cms_first_hr_m_ah {get;set;}
        public final Decimal f_act_all_cms_first_trp_m_ah {get;set;}
        public final Decimal f_actual_all_ytd_ap_ah {get;set;}
        public final Decimal f_adw_12 {get;set;}
        public final Decimal f_adw_15 {get;set;}
        public final Decimal f_adw_24 {get;set;}
        public final Decimal f_adw_48 {get;set;}
        public final Decimal f_adw_trip_12 {get;set;}
        public final Decimal f_adw_trip_6 {get;set;}
        public final Decimal f_avgbet_game_12mn_ap_ah {get;set;}
        public final Decimal f_avgbet_game_1mn_ap_ah {get;set;}
        public final Decimal f_avgbet_game_3mn_ap_ah {get;set;}
        public final Decimal f_avgbet_game_6mn_ap_ah {get;set;}
        public final Decimal f_daily_act_ap_pdb_12mn_plus {get;set;}
        public final Decimal f_daily_act_ap_pdb_24mn_plus {get;set;}
        public final Decimal f_daily_theo_ap_pdb_12mnplus {get;set;}
        public final Decimal f_daily_theo_ap_pdb_24mnplus {get;set;}
        public final Decimal f_daily_wrth_ap_pdb_12mnplus {get;set;}
        public final Decimal f_daily_wrth_ap_pdb_24mnplus {get;set;}
        public final Decimal f_hotel_adw {get;set;}
        public final Decimal f_hotel_adw_12 {get;set;}
        public final Decimal f_hotel_adw_15 {get;set;}
        public final Decimal f_hotel_adw_24 {get;set;}
        public final Decimal f_hotel_adw_48 {get;set;}
        public final Decimal f_htlsty_pct_ap_pdb_12mnplus {get;set;}
        public final Decimal f_htlsty_pct_ap_pdb_24mnplus {get;set;}
        public final Decimal f_lodging_pct_mkt_adj_ah {get;set;}
        public final Decimal f_ofr_trp_pct_ap_pdb12mnplus {get;set;}
        public final Decimal f_ofr_trp_pct_ap_pdb24mnplus {get;set;}
        public final Decimal f_pct_bacarrat_mkt_ah {get;set;}
        public final Decimal f_pct_blackjack_mkt_ah {get;set;}
        public final Decimal f_pct_craps_mkt_ah {get;set;}
        public final Decimal f_pct_other_mkt_ah {get;set;}
        public final Decimal f_pct_paigow_mkt_ah {get;set;}
        public final Decimal f_pct_roulette_mkt_ah {get;set;}
        public final Decimal f_pct_video_poker_mkt_ah {get;set;}
        public final Decimal f_profit_pct_ent {get;set;}
        public final Decimal f_profit_pct_mkt {get;set;}
        public final Decimal f_rc_earned_12mn_mkt_ah {get;set;}
        public final Decimal f_rc_earned_1mn_mkt_ah {get;set;}
        public final Decimal f_rc_earned_3mn_mkt_ah {get;set;}
        public final Decimal f_rc_earned_6mn_mkt_ah {get;set;}
        public final Decimal f_resp_rate_ap_pdb_12mn_plus {get;set;}
        public final Decimal f_resp_rate_ap_pdb_24mn_plus {get;set;}
        public final Decimal f_slot_pct_ap_pdb_12mn_plus {get;set;}
        public final Decimal f_slot_pct_ap_pdb_24mn_plus {get;set;}
        public final Decimal f_theo_all_12mn_ap_ah {get;set;}
        public final Decimal f_theo_all_1mn_ap_ah {get;set;}
        public final Decimal f_theo_all_3mn_ap_ah {get;set;}
        public final Decimal f_theo_all_6mn_ap_ah {get;set;}
        public final Decimal f_theo_all_ap_pdb_12mn_plus {get;set;}
        public final Decimal f_theo_all_ap_pdb_24mn_plus {get;set;}
        public final Decimal f_theo_all_ytd_ap_ah {get;set;}
        public final Decimal f_theo_slot_12mn_ap_ah {get;set;}
        public final Decimal f_theo_slot_1mn_ap_ah {get;set;}
        public final Decimal f_theo_slot_3mn_ap_ah {get;set;}
        public final Decimal f_theo_slot_6mn_ap_ah {get;set;}
        public final Decimal f_theo_table_12mn_ap_ah {get;set;}
        public final Decimal f_theo_table_1mn_ap_ah {get;set;}
        public final Decimal f_theo_table_3mn_ap_ah {get;set;}
        public final Decimal f_theo_table_6mn_ap_ah {get;set;}
        public final Decimal f_tier_score_ah {get;set;}
        public final Decimal f_trip_cycle_12 {get;set;}
        public final Decimal f_trip_cycle_48 {get;set;}
        public final Decimal f_trp_all_adj_sc_pdb_12mn {get;set;}
        public final Decimal f_trp_all_adj_sc_pdb_24mn {get;set;}
        public final Decimal f_trp_all_adj_sc_pdb_36mn {get;set;}
        public final Decimal f_trp_rtd_adj_sc_pdb_12mn {get;set;}
        public final Decimal f_trp_rtd_adj_sc_pdb_24mn {get;set;}
        public final Decimal f_trp_rtd_adj_sc_pdb_36mn {get;set;}
        public final Decimal f_worth_12mn_ap_ah {get;set;}
        public final Decimal f_worth_1mn_ap_ah {get;set;}
        public final Decimal f_worth_3mn_ap_ah {get;set;}
        public final Decimal f_worth_6mn_ap_ah {get;set;}
        public final Decimal f_worth_all_ytd_ap_ah {get;set;}
        public final Integer i_age {get;set;}
        public final Integer i_age_adj_ah {get;set;}
        public final Integer i_days_rtd_12mn_ap_ah {get;set;}
        public final Integer i_days_rtd_1mn_ap_ah {get;set;}
        public final Integer i_days_rtd_3mn_ap_ah {get;set;}
        public final Integer i_days_rtd_6mn_ap_ah {get;set;}
        public final Integer i_days_rtd_ap_pdb_12mn_plus {get;set;}
        public final Integer i_days_rtd_ap_pdb_24mn_plus {get;set;}
        public final Integer i_days_since_gaming {get;set;}
        public final Integer i_days_since_last {get;set;}
        public final Integer i_dob_mn_adj_ah {get;set;}
        public final Integer i_dob_yr_adj_ah {get;set;}
        public final Integer i_email_decile {get;set;}
        public final Integer i_lodging_pct {get;set;}
        public final Integer i_lop_first_day_mkt_ah {get;set;}
        public final Integer i_lop_first_hr_mkt_ah {get;set;}
        public final Integer i_lop_first_trp_mkt_ah {get;set;}
        public final Integer i_lop_game_12mn_ap_ah {get;set;}
        public final Integer i_lop_game_1mn_ap_ah {get;set;}
        public final Integer i_lop_game_3mn_ap_ah {get;set;}
        public final Integer i_lop_game_6mn_ap_ah {get;set;}
        public final Decimal i_profitable_pct {get;set;}
        public final Integer i_prop_pct_worth_1 {get;set;}
        public final Integer i_prop_pct_worth_2 {get;set;}
        public final Integer i_random_1 {get;set;}
        public final Integer i_random_2 {get;set;}
        public final Integer i_random_static_yr {get;set;}
        public final Integer i_trp_all_cms_12mn_ap_ah {get;set;}
        public final Integer i_trp_all_cms_1mn_ap_ah {get;set;}
        public final Integer i_trp_all_cms_3mn_ap_ah {get;set;}
        public final Integer i_trp_all_cms_6mn_ap_ah {get;set;}
        public final Integer i_trp_rtd_12mn_ap_ah {get;set;}
        public final Integer i_trp_rtd_1mn_ap_ah {get;set;}
        public final Integer i_trp_rtd_3mn_ap_ah {get;set;}
        public final Integer i_trp_rtd_6mn_ap_ah {get;set;}
        public final Integer i_trp_rtd_ap_pdb_12mn_plus {get;set;}
        public final Integer i_trp_rtd_ap_pdb_24mn_plus {get;set;}
        public final Integer i_ttm_trip_cnt_12 {get;set;}
        public final Integer i_ttm_trip_cnt_24 {get;set;}
    }

	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows){
        for(MarketingCampaign.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId',wrapper.id);
            row.put('DisplayUrl',wrapper.id);
            row.put('contact',wrapper.contact);
            row.put('c_acct_type_cd_fk',wrapper.c_acct_type_cd_fk);
            row.put('c_campaign_type_fk',wrapper.c_campaign_type_fk);
            row.put('c_campaign_cd_fk',wrapper.c_campaign_type_fk);
            row.put('c_dom_cd_prop_fk',wrapper.c_dom_cd_prop_fk);
            row.put('c_dom_market_cd_fk',wrapper.c_dom_market_cd_fk);
            row.put('c_dom_pref_prop_cd_fk',wrapper.c_dom_pref_prop_cd_fk);
            row.put('c_pref_prop_cd_fk',wrapper.c_pref_prop_cd_fk);
            row.put('c_prop_cd_1_fk',wrapper.c_prop_cd_1_fk);
            row.put('c_prop_cd_2_fk',wrapper.c_prop_cd_2_fk);
            row.put('c_tier_cd_fk',wrapper.c_tier_cd_fk);
            row.put('f_worth',wrapper.f_worth);
            row.put('d_campaign_score_dt',wrapper.d_campaign_score_dt);
            row.put('d_create_dt_ent',wrapper.d_create_dt_ent);
            row.put('d_create_dt_mkt',wrapper.d_create_dt_mkt);
            row.put('d_first_dt_played_mkt_ah',wrapper.d_first_dt_played_mkt_ah);
            row.put('d_first_gaming_dt_ent_ah',wrapper.d_first_gaming_dt_ent_ah);
            row.put('d_min_est_dt',wrapper.d_min_est_dt);
            row.put('d_last_rated_dt_mkt_ah',wrapper.d_last_rated_dt_mkt_ah);
            row.put('d_last_activity_dt',wrapper.d_last_activity_dt);
            row.put('d_first_gaming_dt_mkt_ah',wrapper.d_first_gaming_dt_mkt_ah);
            row.put('c_acct_type_cd',wrapper.c_acct_type_cd);
            row.put('c_adw_break_12',wrapper.c_adw_break_12);
            row.put('c_adw_break_15',wrapper.c_adw_break_15);
            row.put('c_adw_break_24',wrapper.c_adw_break_24);
            row.put('c_adw_break_48',wrapper.c_adw_break_48);
            row.put('c_adw_trip_break_12',wrapper.c_adw_trip_break_12);
            row.put('c_adw_trip_break_6',wrapper.c_adw_trip_break_6);
            row.put('c_age_18_plus',wrapper.c_age_18_plus);
            row.put('c_age_19_plus',wrapper.c_age_19_plus);
            row.put('c_age_21_plus',wrapper.c_age_21_plus);
            row.put('c_avg_day_hotel_flag',wrapper.c_avg_day_hotel_flag);
            row.put('c_baccarat_pref',wrapper.c_baccarat_pref);
            row.put('c_campaign_cd',wrapper.c_campaign_cd);
            row.put('c_campaign_desc',wrapper.c_campaign_desc);
            row.put('c_campaign_type',wrapper.c_campaign_type);
            row.put('c_campaign_type_desc',wrapper.c_campaign_type_desc);
            row.put('c_channel_pref',wrapper.c_channel_pref);
            row.put('c_channel_rec',wrapper.c_channel_rec);
            row.put('c_convienence_cd',wrapper.c_convienence_cd);
            row.put('c_convienence_cd_new',wrapper.c_convienence_cd_new);
            row.put('c_country_cd_ah',wrapper.c_country_cd_ah);
            row.put('c_credit_status_flag',wrapper.c_credit_status_flag);
            row.put('c_distance_cluster',wrapper.c_distance_cluster);
            row.put('c_dom_cd_prop',wrapper.c_dom_cd_prop);
            row.put('c_dom_market_cd',wrapper.c_dom_market_cd);
            row.put('c_dom_pref_prop_cd',wrapper.c_dom_pref_prop_cd);
            row.put('c_dom_prop_host_cd_adj_ah',wrapper.c_dom_prop_host_cd_adj_ah);
            row.put('c_drive_distance_cluster',wrapper.c_drive_distance_cluster);
            row.put('c_emailable',wrapper.c_emailable);
            row.put('c_ethnic_group1',wrapper.c_ethnic_group1);
            row.put('c_frequency',wrapper.c_frequency);
            row.put('c_frequency_tc',wrapper.c_frequency_tc);
            row.put('c_frequency_tc_12',wrapper.c_frequency_tc_12);
            row.put('c_frequency_ttm',wrapper.c_frequency_ttm);
            row.put('c_frequency_ttm_24',wrapper.c_frequency_ttm_24);
            row.put('c_future_res_flag_mkt_ah',wrapper.c_future_res_flag_mkt_ah);
            row.put('c_game_pref',wrapper.c_game_pref);
            row.put('c_gender',wrapper.c_gender);
            row.put('c_geo_dm_zone',wrapper.c_geo_dm_zone);
            row.put('c_geo_rpt_zone',wrapper.c_geo_rpt_zone);
            row.put('c_gst_prop_dm_optout_flag',wrapper.c_gst_prop_dm_optout_flag);
            row.put('c_host_type',wrapper.c_host_type);
            row.put('c_hotel_adw_break',wrapper.c_hotel_adw_break);
            row.put('c_hotel_adw_break_12',wrapper.c_hotel_adw_break_12);
            row.put('c_hotel_adw_break_15',wrapper.c_hotel_adw_break_15);
            row.put('c_hotel_adw_break_24',wrapper.c_hotel_adw_break_24);
            row.put('c_hotel_adw_break_48',wrapper.c_hotel_adw_break_48);
            row.put('c_id_verified',wrapper.c_id_verified);
            row.put('c_last_gaming_trip',wrapper.c_last_gaming_trip);
            row.put('c_mailable',wrapper.c_mailable);
            row.put('c_main_ethnic_type',wrapper.c_main_ethnic_type);
            row.put('c_marketing_state_cd',wrapper.c_marketing_state_cd);
            row.put('c_mkt_host_cd_adj_ah',wrapper.c_mkt_host_cd_adj_ah);
            row.put('c_msa',wrapper.c_msa);
            row.put('c_msa_cd',wrapper.c_msa_cd);
            row.put('c_pref_prop_cd',wrapper.c_pref_prop_cd);
            row.put('c_pref_prop_host_cd',wrapper.c_pref_prop_host_cd);
            row.put('c_preferred_written_language',wrapper.c_preferred_written_language);
            row.put('c_profit_flag_ent',wrapper.c_profit_flag_ent);
            row.put('c_profit_flag_mkt',wrapper.c_profit_flag_mkt);
            row.put('c_prop_cd_1',wrapper.c_prop_cd_1);
            row.put('c_prop_cd_1_host_cd_adj_ah',wrapper.c_prop_cd_1_host_cd_adj_ah);
            row.put('c_prop_cd_2',wrapper.c_prop_cd_2);
            row.put('c_prop_mail_cd',wrapper.c_prop_mail_cd);
            row.put('c_prop_market_cd',wrapper.c_prop_market_cd);
            row.put('c_prop_market_cd_fk',wrapper.c_prop_market_cd_fk);
            row.put('c_recency',wrapper.c_recency);
            row.put('c_regulatory_state_cd',wrapper.c_regulatory_state_cd);
            row.put('c_tdc_supp_flag',wrapper.c_tdc_supp_flag);
            row.put('c_tier_cd',wrapper.c_tier_cd);
            row.put('c_tierscore_desc',wrapper.c_tierscore_desc);
            row.put('c_uci_supp_flag',wrapper.c_uci_supp_flag);
            row.put('c_ucl_supp_flag',wrapper.c_ucl_supp_flag);
            row.put('c_uk_res_supress',wrapper.c_uk_res_supress);
            row.put('c_version_cd',wrapper.c_version_cd);
            row.put('c_video_poker_pref',wrapper.c_video_poker_pref);
            row.put('c_worth_break',wrapper.c_worth_break);
            row.put('c_worth_break_max',wrapper.c_worth_break_max);
            row.put('c_worth_break_min',wrapper.c_worth_break_min);
            row.put('c_zip_7_ah',wrapper.c_zip_7_ah);
            row.put('c_zip_7_pdb',wrapper.c_zip_7_pdb);
            row.put('c_campaign_cd_fk',wrapper.c_campaign_cd_fk);
            row.put('c_campaign_type_fk',wrapper.c_campaign_type_fk);
            row.put('d_campaign_score_dt',wrapper.d_campaign_score_dt);
            row.put('d_create_dt_ent',wrapper.d_create_dt_ent);
            row.put('d_create_dt_mkt',wrapper.d_create_dt_mkt);
            row.put('d_first_dt_played_mkt_ah',wrapper.d_first_dt_played_mkt_ah);
            row.put('d_first_gaming_dt_ent_ah',wrapper.d_first_gaming_dt_ent_ah);
            row.put('d_first_gaming_dt_mkt_ah',wrapper.d_first_gaming_dt_mkt_ah);
            row.put('d_last_activity_dt',wrapper.d_last_activity_dt);
            row.put('d_last_rated_dt_mkt_ah',wrapper.d_last_rated_dt_mkt_ah);
            row.put('d_min_est_dt',wrapper.d_min_est_dt);
            row.put('c_dom_cd_prop_fk',wrapper.c_dom_cd_prop_fk);
            row.put('c_dom_market_cd_fk',wrapper.c_dom_market_cd_fk);
            row.put('c_dom_pref_prop_cd_fk',wrapper.c_dom_pref_prop_cd_fk);
            row.put('f_act_all_12mn_ap_ah',wrapper.f_act_all_12mn_ap_ah);
            row.put('f_act_all_1mn_ap_ah',wrapper.f_act_all_1mn_ap_ah);
            row.put('f_act_all_3mn_ap_ah',wrapper.f_act_all_3mn_ap_ah);
            row.put('f_act_all_6mn_ap_ah',wrapper.f_act_all_6mn_ap_ah);
            row.put('f_act_all_ap_pdb_12mn_plus',wrapper.f_act_all_ap_pdb_12mn_plus);
            row.put('f_act_all_ap_pdb_24mn_plus',wrapper.f_act_all_ap_pdb_24mn_plus);
            row.put('f_act_all_cms_first_day_m_ah',wrapper.f_act_all_cms_first_day_m_ah);
            row.put('f_act_all_cms_first_hr_m_ah',wrapper.f_act_all_cms_first_hr_m_ah);
            row.put('f_act_all_cms_first_trp_m_ah',wrapper.f_act_all_cms_first_trp_m_ah);
            row.put('f_actual_all_ytd_ap_ah',wrapper.f_actual_all_ytd_ap_ah);
            row.put('f_adw_12',wrapper.f_adw_12);
            row.put('f_adw_15',wrapper.f_adw_15);
            row.put('f_adw_24',wrapper.f_adw_24);
            row.put('f_adw_48',wrapper.f_adw_48);
            row.put('f_adw_trip_12',wrapper.f_adw_trip_12);
            row.put('f_adw_trip_6',wrapper.f_adw_trip_6);
            row.put('f_avgbet_game_12mn_ap_ah',wrapper.f_avgbet_game_12mn_ap_ah);
            row.put('f_avgbet_game_1mn_ap_ah',wrapper.f_avgbet_game_1mn_ap_ah);
            row.put('f_avgbet_game_3mn_ap_ah',wrapper.f_avgbet_game_3mn_ap_ah);
            row.put('f_avgbet_game_6mn_ap_ah',wrapper.f_avgbet_game_6mn_ap_ah);
            row.put('f_daily_act_ap_pdb_12mn_plus',wrapper.f_daily_act_ap_pdb_12mn_plus);
            row.put('f_daily_act_ap_pdb_24mn_plus',wrapper.f_daily_act_ap_pdb_24mn_plus);
            row.put('f_daily_theo_ap_pdb_12mnplus',wrapper.f_daily_theo_ap_pdb_12mnplus);
            row.put('f_daily_theo_ap_pdb_24mnplus',wrapper.f_daily_theo_ap_pdb_24mnplus);
            row.put('f_daily_wrth_ap_pdb_12mnplus',wrapper.f_daily_wrth_ap_pdb_12mnplus);
            row.put('f_daily_wrth_ap_pdb_24mnplus',wrapper.f_daily_wrth_ap_pdb_24mnplus);
            row.put('f_hotel_adw',wrapper.f_hotel_adw);
            row.put('f_hotel_adw_12',wrapper.f_hotel_adw_12);
            row.put('f_hotel_adw_15',wrapper.f_hotel_adw_15);
            row.put('f_hotel_adw_24',wrapper.f_hotel_adw_24);
            row.put('f_hotel_adw_48',wrapper.f_hotel_adw_48);
            row.put('f_htlsty_pct_ap_pdb_12mnplus',wrapper.f_htlsty_pct_ap_pdb_12mnplus);
            row.put('f_htlsty_pct_ap_pdb_24mnplus',wrapper.f_htlsty_pct_ap_pdb_24mnplus);
            row.put('f_lodging_pct_mkt_adj_ah',wrapper.f_lodging_pct_mkt_adj_ah);
            row.put('f_ofr_trp_pct_ap_pdb12mnplus',wrapper.f_ofr_trp_pct_ap_pdb12mnplus);
            row.put('f_ofr_trp_pct_ap_pdb24mnplus',wrapper.f_ofr_trp_pct_ap_pdb24mnplus);
            row.put('f_pct_bacarrat_mkt_ah',wrapper.f_pct_bacarrat_mkt_ah);
            row.put('f_pct_blackjack_mkt_ah',wrapper.f_pct_blackjack_mkt_ah);
            row.put('f_pct_craps_mkt_ah',wrapper.f_pct_craps_mkt_ah);
            row.put('f_pct_other_mkt_ah',wrapper.f_pct_other_mkt_ah);
            row.put('f_pct_paigow_mkt_ah',wrapper.f_pct_paigow_mkt_ah);
            row.put('f_pct_roulette_mkt_ah',wrapper.f_pct_roulette_mkt_ah);
            row.put('f_pct_video_poker_mkt_ah',wrapper.f_pct_video_poker_mkt_ah);
            row.put('f_profit_pct_ent',wrapper.f_profit_pct_ent);
            row.put('f_profit_pct_mkt',wrapper.f_profit_pct_mkt);
            row.put('f_rc_earned_12mn_mkt_ah',wrapper.f_rc_earned_12mn_mkt_ah);
            row.put('f_rc_earned_1mn_mkt_ah',wrapper.f_rc_earned_1mn_mkt_ah);
            row.put('f_rc_earned_3mn_mkt_ah',wrapper.f_rc_earned_3mn_mkt_ah);
            row.put('f_rc_earned_6mn_mkt_ah',wrapper.f_rc_earned_6mn_mkt_ah);
            row.put('f_resp_rate_ap_pdb_12mn_plus',wrapper.f_resp_rate_ap_pdb_12mn_plus);
            row.put('f_resp_rate_ap_pdb_24mn_plus',wrapper.f_resp_rate_ap_pdb_24mn_plus);
            row.put('f_slot_pct_ap_pdb_12mn_plus',wrapper.f_slot_pct_ap_pdb_12mn_plus);
            row.put('f_slot_pct_ap_pdb_24mn_plus',wrapper.f_slot_pct_ap_pdb_24mn_plus);
            row.put('f_theo_all_12mn_ap_ah',wrapper.f_theo_all_12mn_ap_ah);
            row.put('f_theo_all_1mn_ap_ah',wrapper.f_theo_all_1mn_ap_ah);
            row.put('f_theo_all_3mn_ap_ah',wrapper.f_theo_all_3mn_ap_ah);
            row.put('f_theo_all_6mn_ap_ah',wrapper.f_theo_all_6mn_ap_ah);
            row.put('f_theo_all_ap_pdb_12mn_plus',wrapper.f_theo_all_ap_pdb_12mn_plus);
            row.put('f_theo_all_ap_pdb_24mn_plus',wrapper.f_theo_all_ap_pdb_24mn_plus);
            row.put('f_theo_all_ytd_ap_ah',wrapper.f_theo_all_ytd_ap_ah);
            row.put('f_theo_slot_12mn_ap_ah',wrapper.f_theo_slot_12mn_ap_ah);
            row.put('f_theo_slot_1mn_ap_ah',wrapper.f_theo_slot_1mn_ap_ah);
            row.put('f_theo_slot_3mn_ap_ah',wrapper.f_theo_slot_3mn_ap_ah);
            row.put('f_theo_slot_6mn_ap_ah',wrapper.f_theo_slot_6mn_ap_ah);
            row.put('f_theo_table_12mn_ap_ah',wrapper.f_theo_table_12mn_ap_ah);
            row.put('f_theo_table_1mn_ap_ah',wrapper.f_theo_table_1mn_ap_ah);
            row.put('f_theo_table_3mn_ap_ah',wrapper.f_theo_table_3mn_ap_ah);
            row.put('f_theo_table_6mn_ap_ah',wrapper.f_theo_table_6mn_ap_ah);
            row.put('f_tier_score_ah',wrapper.f_tier_score_ah);
            row.put('f_trip_cycle_12',wrapper.f_trip_cycle_12);
            row.put('f_trip_cycle_48',wrapper.f_trip_cycle_48);
            row.put('f_trp_all_adj_sc_pdb_12mn',wrapper.f_trp_all_adj_sc_pdb_12mn);
            row.put('f_trp_all_adj_sc_pdb_24mn',wrapper.f_trp_all_adj_sc_pdb_24mn);
            row.put('f_trp_all_adj_sc_pdb_36mn',wrapper.f_trp_all_adj_sc_pdb_36mn);
            row.put('f_trp_rtd_adj_sc_pdb_12mn',wrapper.f_trp_rtd_adj_sc_pdb_12mn);
            row.put('f_trp_rtd_adj_sc_pdb_24mn',wrapper.f_trp_rtd_adj_sc_pdb_24mn);
            row.put('f_trp_rtd_adj_sc_pdb_36mn',wrapper.f_trp_rtd_adj_sc_pdb_36mn);
            row.put('f_worth_12mn_ap_ah',wrapper.f_worth_12mn_ap_ah);
            row.put('f_worth_1mn_ap_ah',wrapper.f_worth_1mn_ap_ah);
            row.put('f_worth_3mn_ap_ah',wrapper.f_worth_3mn_ap_ah);
            row.put('f_worth_6mn_ap_ah',wrapper.f_worth_6mn_ap_ah);
            row.put('f_worth_all_ytd_ap_ah',wrapper.f_worth_all_ytd_ap_ah);
            row.put('i_age',wrapper.i_age);
            row.put('i_age_adj_ah',wrapper.i_age_adj_ah);
            row.put('i_days_rtd_12mn_ap_ah',wrapper.i_days_rtd_12mn_ap_ah);
            row.put('i_days_rtd_1mn_ap_ah',wrapper.i_days_rtd_1mn_ap_ah);
            row.put('i_days_rtd_3mn_ap_ah',wrapper.i_days_rtd_3mn_ap_ah);
            row.put('i_days_rtd_6mn_ap_ah',wrapper.i_days_rtd_6mn_ap_ah);
            row.put('i_days_rtd_ap_pdb_12mn_plus',wrapper.i_days_rtd_ap_pdb_12mn_plus);
            row.put('i_days_rtd_ap_pdb_24mn_plus',wrapper.i_days_rtd_ap_pdb_24mn_plus);
            row.put('i_days_since_gaming',wrapper.i_days_since_gaming);
            row.put('i_days_since_last',wrapper.i_days_since_last);
            row.put('i_dob_mn_adj_ah',wrapper.i_dob_mn_adj_ah);
            row.put('i_dob_yr_adj_ah',wrapper.i_dob_yr_adj_ah);
            row.put('i_email_decile',wrapper.i_email_decile);
            row.put('i_lodging_pct',wrapper.i_lodging_pct);
            row.put('i_lop_first_day_mkt_ah',wrapper.i_lop_first_day_mkt_ah);
            row.put('i_lop_first_hr_mkt_ah',wrapper.i_lop_first_hr_mkt_ah);
            row.put('i_lop_first_trp_mkt_ah',wrapper.i_lop_first_trp_mkt_ah);
            row.put('i_lop_game_12mn_ap_ah',wrapper.i_lop_game_12mn_ap_ah);
            row.put('i_lop_game_1mn_ap_ah',wrapper.i_lop_game_1mn_ap_ah);
            row.put('i_lop_game_3mn_ap_ah',wrapper.i_lop_game_3mn_ap_ah);
            row.put('i_lop_game_6mn_ap_ah',wrapper.i_lop_game_6mn_ap_ah);
            row.put('i_profitable_pct',wrapper.i_profitable_pct);
            row.put('i_prop_pct_worth_1',wrapper.i_prop_pct_worth_1);
            row.put('i_prop_pct_worth_2',wrapper.i_prop_pct_worth_2);
            row.put('i_random_1',wrapper.i_random_1);
            row.put('i_random_2',wrapper.i_random_2);
            row.put('i_random_static_yr',wrapper.i_random_static_yr);
            row.put('i_trp_all_cms_12mn_ap_ah',wrapper.i_trp_all_cms_12mn_ap_ah);
            row.put('i_trp_all_cms_1mn_ap_ah',wrapper.i_trp_all_cms_1mn_ap_ah);
            row.put('i_trp_all_cms_3mn_ap_ah',wrapper.i_trp_all_cms_3mn_ap_ah);
            row.put('i_trp_all_cms_6mn_ap_ah',wrapper.i_trp_all_cms_6mn_ap_ah);
            row.put('i_trp_rtd_12mn_ap_ah',wrapper.i_trp_rtd_12mn_ap_ah);
            row.put('i_trp_rtd_1mn_ap_ah',wrapper.i_trp_rtd_1mn_ap_ah);
            row.put('i_trp_rtd_3mn_ap_ah',wrapper.i_trp_rtd_3mn_ap_ah);
            row.put('i_trp_rtd_6mn_ap_ah',wrapper.i_trp_rtd_6mn_ap_ah);
            row.put('i_trp_rtd_ap_pdb_12mn_plus',wrapper.i_trp_rtd_ap_pdb_12mn_plus);
            row.put('i_trp_rtd_ap_pdb_24mn_plus',wrapper.i_trp_rtd_ap_pdb_24mn_plus);
            row.put('i_ttm_trip_cnt_12',wrapper.i_ttm_trip_cnt_12);
            row.put('i_ttm_trip_cnt_24',wrapper.i_ttm_trip_cnt_24);

            rows.add(row);
        }
        return rows;
    }
}