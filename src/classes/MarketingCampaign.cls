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
    }

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
            rows.add(row);
        }
        return rows;
    }
}