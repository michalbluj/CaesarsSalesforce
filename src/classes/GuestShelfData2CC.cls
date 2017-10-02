/**
* @author Sarah Kennedy
* @date July 2017
*
* @description Class to retrieve Shelf (Marketing Campaign) Data, extending base class GuestSubjectcDataBase.cls
*/
global with sharing class GuestShelfData2CC extends GuestSubjectDataBaseCC {

	global GuestShelfData2CC() { }

	@TestVisible private static List<marketing_campaigns__x> mockedRequests = new List<marketing_campaigns__x>();
	@TestVisible private static List<marketing_campaigns_properties__x> mockedPropRequests = new List<marketing_campaigns_properties__x>();
	@TestVisible private static List<marketing_campaigns_weekly__x> mockedWeeklyRequests = new List<marketing_campaigns_weekly__x>();
	@TestVisible private static List<marketing_lvm__x> mockedLVMRequests = new List<marketing_lvm__x>();
	@TestVisible private static List<enterprise_campaign__x> mockedEnterpriseRequests = new List<enterprise_campaign__x>();

	/*******************************************************************************************************
    * @description Retrieve the external data for Marketing Campaigns as view only
    * @param List<Id> of Contact Ids used to retrieve the Marketing Campaign data
    * @return List<MarketingCampaignWrapper> containing the retrieve data
    * @example
    * List<GuestShelfDataCC.MarketingCampaignWrapper>  marketingCampaignList = 
	*   		GuestShelfDataCC.retrieveMarketingCampaigns(List<Id> contactIds);
    */
	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignWrapper> retrieveMarketingCampaignDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = ' WHERE ExternalId in';
		String idType = 'external';
		return retrieveMarketingCampaigns(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignWrapper> retrieveMarketingCampaignByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		String idType = 'contact';
		return retrieveMarketingCampaigns(contactIds, whereClause, idType);
	}

	private static List<MarketingCampaignWrapper> retrieveMarketingCampaigns(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClause ' + whereClause);
		system.debug('*** idType ' + idType);

		//
		// get the cross-reference dmIds for the contacts in order to access unmerged activities
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new GuestShelfData2CC()).getConsXrefIds(ids);
		} 

		String soql1 = 'SELECT ExternalId, ';
	   	soql1 += ' c_acct_type_cd_fk__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Name, ';
	  	soql1 += ' c_acct_type_cd_fk__r.Description__c, ';
	  	soql1 += ' c_acct_type_cd_fk__r.Quality_code__c, ';
	  	soql1 += ' c_acct_type_cd_fk__r.Type_category__c, ';
	  	soql1 += ' c_acct_type_cd_fk__r.Type_Id__c, ';
	  	soql1 += ' c_campaign_cd_fk__c, ';
	  	soql1 += ' c_campaign_cd_fk__r.Name,';
	  	soql1 += ' c_campaign_cd_fk__r.Description__c, ';
	  	soql1 += ' c_campaign_cd_fk__r.In_use__c, ';
	  	soql1 += ' c_campaign_type_fk__c, ';
	  	soql1 += ' c_campaign_type_fk__r.Name, ';
	  	soql1 += ' c_campaign_type_fk__r.Description__c, ';
	  	soql1 += ' contact__c ';
	  	soql1 += ' FROM marketing_campaigns__x ';
	  	if (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}

	  	soql1 = String.escapeSingleQuotes(soql1);


	  	String soql2 = 'SELECT ExternalId, ';   				
	  	soql2 += ' c_dom_cd_prop_fk__c, ';
	  	soql2 += ' c_dom_cd_prop_fk__r.Name, ';
	  	soql2 += ' c_dom_market_cd_fk__c, ';
	  	soql2 += ' c_dom_market_cd_fk__r.Name, ';
	  	soql2 += ' c_dom_market_cd_fk__r.Active_Flag__c, ';
	  	soql2 += ' c_dom_market_cd_fk__r.Description__c, ';
	  	soql2 += ' c_dom_market_cd_fk__r.Direct_Marketing_Center__r.Name, ';
	  	soql2 += ' c_dom_market_cd_fk__r.Market_Code__c, ';
	  	soql2 += ' c_dom_market_cd_fk__r.POD__c, ';
	  	soql2 += ' c_dom_market_cd_fk__r.Time_Zone__c, ';
	  	soql2 += ' c_dom_pref_prop_cd_fk__c, ';
	  	soql2 += ' c_dom_pref_prop_cd_fk__r.Name ';
	  	soql2 += ' FROM marketing_campaigns__x  ';
	  	if (idType == 'contact') {
			soql2 += whereClause + ': allContactIds';
		} else {
			soql2 += whereClause + ': ids';
		}

	  	soql2 = String.escapeSingleQuotes(soql2);

	  	String soql3 = 'SELECT ExternalId, ';	   				
	  	soql3 += ' c_pref_prop_cd_fk__c, ';	
	  	soql3 += ' c_pref_prop_cd_fk__r.Name, ';	
	  	soql3 += ' c_prop_cd_1_fk__c, ';	
	  	soql3 += ' c_prop_cd_1_fk__r.Name, ';	
	  	soql3 += ' c_prop_cd_2_fk__c, ';	
	  	soql3 += ' c_prop_cd_2_fk__r.Name ';	
	  	soql3 += ' FROM marketing_campaigns__x  ';	
	  	if (idType == 'contact') {
			soql3 += whereClause + ': allContactIds';
		} else {
			soql3 += whereClause + ': ids';
		}

	  	soql3 = String.escapeSingleQuotes(soql3);

	  	String soql4 = 'SELECT ExternalId, ';	   				
	  	soql4 += ' c_tier_cd_fk__c, ';
	  	soql4 += ' c_tier_cd_fk__r.Name, ';
	  	soql4 += ' f_worth__c ';
	  	soql4 += ' FROM marketing_campaigns__x  ';
	  	if (idType == 'contact') {
			soql4 += whereClause + ': allContactIds';
		} else {
			soql4 += whereClause + ': ids';
		}

	  	soql4 = String.escapeSingleQuotes(soql4);

	  	String soql5 = 'SELECT ExternalId, ';
	  	soql5 += ' c_prop_market_cd__c, ';
		//soql5 += ' c_prop_market_cd_fk__r.Name, ';
		soql5 += ' c_dom_pref_prop_cd__c, ';
		//soql5 += '  c_dom_pref_prop_cd_fk__r.Name, ';
		soql5 += ' d_last_activity_dt__c, ';
		soql5+= '  c_worth_break__c, '; 
		soql5 += '  f_worth__c, ';
		soql5 += ' f_worth_12mn_ap_ah__c, ';
		soql5 += ' f_worth_all_ytd_ap_ah__c, ';
		soql5 += ' c_frequency__c, ';
		soql5 += ' i_trp_rtd_ap_pdb_12mn_plus__c, ';

		soql5 += ' i_trp_rtd_ap_pdb_24mn_plus__c, ';
		soql5 += ' c_game_pref__c, ';
		soql5 += ' c_drive_distance_cluster__c, ';
		soql5 += ' d_min_est_dt__c, ';
		soql5 += ' c_campaign_type__c, ';
		soql5 += ' c_campaign_cd__c, ';
		soql5 += ' c_campaign_desc__c' ;
		soql5 += ' FROM marketing_campaigns__x  ';
		if (idType == 'contact') {
			soql5 += whereClause + ': allContactIds';
		} else {
			soql5 += whereClause + ': ids';
		}

		soql5 = String.escapeSingleQuotes(soql5);

		String soql6 = 'SELECT ExternalId, ';
		soql6 += ' c_campaign_desc__c, ' ;
		soql6 += ' c_campaign_type__c, ' ;	
		soql6 += ' c_campaign_type_desc__c, ' ;
		soql6 += ' d_campaign_score_dt__c, ' ;
		soql6 += ' c_version_cd__c, ' ;
		soql6 += ' c_acct_type_cd__c, ' ;
		soql6 += ' c_prop_market_cd__c, ' ;
		soql6 += ' c_dom_pref_prop_cd__c, ' ;
		soql6 += ' c_tier_cd__c, ' ;
		soql6 += ' c_marketing_state_cd__c, ' ;	
		soql6 += ' c_regulatory_state_cd__c, ' ;	
		soql6 += ' i_random_1__c, ' ;
		soql6 += ' i_random_2__c, ' ;
		soql6 += ' i_random_static_yr__c, ' ;
		soql6 += ' c_main_ethnic_type__c, ' ;	
		soql6 += ' c_ethnic_group1__c, ' ;
		soql6 += ' c_preferred_written_language__c, ' ;
		soql6 += ' c_prop_mail_cd__c, ' ;
		soql6 += ' c_emailable__c, ' ;
		soql6 += ' c_mailable__c, ' ;
		soql6 += ' c_channel_pref__c, ' ;
		soql6 += ' c_uk_res_supress__c, ' ;
		soql6 += ' c_id_verified__c, ' ;
		soql6 += ' c_age_18_plus__c, ' ;
		soql6 += ' c_age_19_plus__c, ' ;
		soql6 += ' c_age_21_plus__c, ' ;
		soql6 += ' c_ucl_supp_flag__c, ' ;
		soql6 += ' c_uci_supp_flag__c, ' ;
		soql6 += ' c_video_poker_pref__c, ' ;	
		soql6 += ' c_baccarat_pref__c, ' ;
		soql6 += ' i_profitable_pct__c, ' ;
		soql6 += ' c_convienence_cd__c, ' ;
		soql6 += ' i_lodging_pct__c, ' ;
		soql6 += ' c_channel_rec__c, ' ;
		soql6 += ' c_dom_market_cd__c, ' ;
		soql6 += ' c_gst_prop_dm_optout_flag__c, ' ;	
		soql6 += ' c_tdc_supp_flag__c, ';	
		soql6 += ' c_prop_cd_1__c, ' ;
		soql6 += ' i_prop_pct_worth_1__c, ' ;
		soql6 += ' c_prop_cd_2__c, ' ;
		soql6 += ' i_prop_pct_worth_2__c, ' ;
		soql6 += ' c_pref_prop_host_cd__c, ' ;
		soql6 += ' c_host_type__c, ' ;
		soql6 += ' i_age__c, ' ;
		soql6 += ' c_gender__c, ' ;
		soql6 += ' c_dom_cd_prop__c, ' ;	
		soql6 += ' c_pref_prop_cd__c, ' ;
		soql6 += ' c_geo_dm_zone__c, ' ;
		soql6 += ' c_geo_rpt_zone__c, ' ;
		soql6 += ' c_distance_cluster__c, ' ;
		soql6 += ' c_msa_cd__c, ' ;
		soql6 += ' c_msa__c, ' ;
		soql6 += ' c_zip_7_pdb__c, ' ;
		soql6 += ' d_create_dt_mkt__c, ' ;
		soql6 += ' d_create_dt_ent__c, ' ;
		soql6 += ' f_act_all_ap_pdb_12mn_plus__c, ' ;	
		soql6 += ' f_theo_all_ap_pdb_12mn_plus__c, ' ;
		soql6 += ' i_days_rtd_ap_pdb_12mn_plus__c, ' ;
		soql6 += ' f_daily_theo_ap_pdb_12mnplus__c, ' ;
		soql6 += ' f_daily_act_ap_pdb_12mn_plus__c, ' ;
		soql6 += ' f_daily_wrth_ap_pdb_12mnplus__c, ' ;
		soql6 += ' f_resp_rate_ap_pdb_12mn_plus__c, ' ;
		soql6 += ' f_ofr_trp_pct_ap_pdb12mnplus__c, ' ;
		soql6 += ' f_htlsty_pct_ap_pdb_12mnplus__c, ' ;
		soql6 += ' f_slot_pct_ap_pdb_12mn_plus__c, ' ;
		soql6 += ' f_trp_all_adj_sc_pdb_12mn__c, ' ;
		soql6 += ' f_trp_rtd_adj_sc_pdb_12mn__c, ' ;
		soql6 += ' f_act_all_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' f_theo_all_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' i_days_rtd_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' f_daily_theo_ap_pdb_24mnplus__c, ' ;
		soql6 += ' f_daily_act_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' f_daily_wrth_ap_pdb_24mnplus__c, ' ;
		soql6 += ' f_resp_rate_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' f_ofr_trp_pct_ap_pdb24mnplus__c, ' ;
		soql6 += ' f_htlsty_pct_ap_pdb_24mnplus__c, ' ;
		soql6 += ' f_slot_pct_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' f_trp_all_adj_sc_pdb_24mn__c, ' ;
		soql6 += ' f_trp_rtd_adj_sc_pdb_24mn__c, ' ;
		soql6 += ' f_trp_all_adj_sc_pdb_36mn__c, ' ;
		soql6 += ' f_trp_rtd_adj_sc_pdb_36mn__c, ' ;
		soql6 += ' f_profit_pct_ent__c, ' ;
		soql6 += ' c_profit_flag_ent__c, ' ;
		soql6 += ' f_profit_pct_mkt__c, ' ;
		soql6 += ' c_profit_flag_mkt__c, ' ;
		soql6 += ' i_age_adj_ah__c, ' ;
		soql6 += ' i_dob_mn_adj_ah__c, ' ;
		soql6 += ' i_dob_yr_adj_ah__c, ' ;
		soql6 += ' c_country_cd_ah__c, ' ;
		soql6 += ' c_credit_status_flag__c, ' ;
		soql6 += ' c_mkt_host_cd_adj_ah__c, ' ;
		soql6 += ' c_dom_prop_host_cd_adj_ah__c, ' ;	
		soql6 += ' c_prop_cd_1_host_cd_adj_ah__c, ' ;
		soql6 += ' c_zip_7_ah__c, ' ;
		soql6 += ' f_tier_score_ah__c, ' ;
		soql6 += ' f_lodging_pct_mkt_adj_ah__c, ' ;	
		soql6 += ' f_pct_bacarrat_mkt_ah__c, ' ;
		soql6 += ' f_pct_blackjack_mkt_ah__c, ' ;
		soql6 += ' f_pct_craps_mkt_ah__c, ' ;
		soql6 += ' f_pct_other_mkt_ah__c, ' ;
		soql6 += ' f_pct_paigow_mkt_ah__c, ' ;
		soql6 += ' f_pct_roulette_mkt_ah__c, ' ;
		soql6 += ' f_pct_video_poker_mkt_ah__c, ' ;
		soql6 += ' c_future_res_flag_mkt_ah__c, ' ;
		soql6 += ' f_worth_1mn_ap_ah__c, ' ;
		soql6 += ' f_worth_3mn_ap_ah__c, ' ;
		soql6 += ' f_worth_6mn_ap_ah__c, ' ;
		soql6 += ' f_theo_all_1mn_ap_ah__c, ' ;
		soql6 += ' f_theo_all_3mn_ap_ah__c, ' ;
		soql6 += ' f_theo_all_6mn_ap_ah__c, ' ;
		soql6 += ' f_theo_all_12mn_ap_ah__c, ' ;
		soql6 += ' f_theo_all_ytd_ap_ah__c, ' ;
		soql6 += ' f_theo_slot_1mn_ap_ah__c, ' ;
		soql6 += ' f_theo_slot_3mn_ap_ah__c, ' ;
		soql6 += ' f_theo_slot_6mn_ap_ah__c, ' ;
		soql6 += ' f_theo_slot_12mn_ap_ah__c, ' ;
		soql6 += ' f_theo_table_1mn_ap_ah__c, ' ;
		soql6 += ' f_theo_table_3mn_ap_ah__c, ' ;
		soql6 += ' f_theo_table_6mn_ap_ah__c, ' ;
		soql6 += ' f_theo_table_12mn_ap_ah__c, ' ;
		soql6 += ' f_act_all_1mn_ap_ah__c, ' ;
		soql6 += ' f_act_all_3mn_ap_ah__c, ' ;
		soql6 += ' f_act_all_6mn_ap_ah__c, ' ;
		soql6 += ' f_act_all_12mn_ap_ah__c, ' ;
		soql6 += ' f_actual_all_ytd_ap_ah__c, ' ;
		soql6 += ' f_avgbet_game_1mn_ap_ah__c, ' ;
		soql6 += ' f_avgbet_game_3mn_ap_ah__c, ' ;
		soql6 += ' f_avgbet_game_6mn_ap_ah__c, ' ;
		soql6 += ' f_avgbet_game_12mn_ap_ah__c, ' ;
		soql6 += ' i_lop_game_1mn_ap_ah__c, ' ;
		soql6 += ' i_lop_game_3mn_ap_ah__c, ' ;
		soql6 += ' i_lop_game_6mn_ap_ah__c, ' ;
		soql6 += ' i_lop_game_12mn_ap_ah__c, ' ;
		soql6 += ' i_trp_all_cms_1mn_ap_ah__c, ' ;
		soql6 += ' i_trp_all_cms_3mn_ap_ah__c, ' ;
		soql6 += ' i_trp_all_cms_6mn_ap_ah__c, ' ;
		soql6 += ' i_trp_all_cms_12mn_ap_ah__c, ' ;
		soql6 += ' i_trp_rtd_1mn_ap_ah__c, ' ;
		soql6 += ' i_trp_rtd_3mn_ap_ah__c, ' ;
		soql6 += ' i_trp_rtd_6mn_ap_ah__c, ' ;
		soql6 += ' i_trp_rtd_12mn_ap_ah__c, ' ;
		soql6 += ' i_days_rtd_1mn_ap_ah__c, ' ;
		soql6 += ' i_days_rtd_3mn_ap_ah__c, ' ;
		soql6 += ' i_days_rtd_6mn_ap_ah__c, ' ;
		soql6 += ' i_days_rtd_12mn_ap_ah__c, ' ;
		soql6 += ' d_last_rated_dt_mkt_ah__c, ' ;
		soql6 += ' f_rc_earned_1mn_mkt_ah__c, ' ;
		soql6 += ' f_rc_earned_3mn_mkt_ah__c, ' ;
		soql6 += ' f_rc_earned_6mn_mkt_ah__c, ' ;
		soql6 += ' f_rc_earned_12mn_mkt_ah__c, ' ;
		soql6 += ' d_first_gaming_dt_mkt_ah__c, ' ;
		soql6 += ' d_first_gaming_dt_ent_ah__c, ' ;
		soql6 += ' d_first_dt_played_mkt_ah__c, ' ;
		soql6 += ' f_act_all_cms_first_hr_m_ah__c, ' ;
		soql6 += ' f_act_all_cms_first_day_m_ah__c, ' ;
		soql6 += ' f_act_all_cms_first_trp_m_ah__c, ' ;
		soql6 += ' i_lop_first_hr_mkt_ah__c, ' ;
		soql6 += ' i_lop_first_day_mkt_ah__c, ' ;
		soql6 += ' i_lop_first_trp_mkt_ah__c, ' ;
		soql6 += ' c_convienence_cd_new__c, ' ;
		soql6 += ' c_recency__c, ' ;
		soql6 += ' c_frequency_tc__c, ' ;
		soql6 += ' c_frequency_ttm_24__c, ' ;
		soql6 += ' c_tierscore_desc__c, ' ;
		soql6 += ' f_hotel_adw__c, ' ;
		soql6 += ' c_hotel_adw_break__c, ' ;	
		soql6 += ' c_frequency_ttm__c, ' ;
		soql6 += ' c_avg_day_hotel_flag__c, ' ;
		soql6 += ' i_days_since_last__c, ' ;
		soql6 += ' f_trip_cycle_48__c, ' ;
		soql6 += ' c_frequency_tc_12__c, ' ;
		soql6 += ' f_trip_cycle_12__c, ' ;
		soql6 += ' i_ttm_trip_cnt_12__c, ' ;
		soql6 += ' i_ttm_trip_cnt_24__c, ' ;
		soql6 += ' c_adw_trip_break_12__c, ' ;
		soql6 += ' f_adw_trip_12__c, ' ;
		soql6 += ' c_adw_trip_break_6__c, ' ;
		soql6 += ' f_adw_trip_6__c, ' ;
		soql6 += ' c_adw_break_48__c, ' ;
		soql6 += ' f_adw_48__c, ' ;
		soql6 += ' c_adw_break_24__c, ' ;	
		soql6 += ' f_adw_24__c, ' ;
		soql6 += ' c_adw_break_15__c, ' ;	
		soql6 += ' f_adw_15__c, ' ;
		soql6 += ' c_adw_break_12__c, ' ;	
		soql6 += ' f_adw_12__c, ' ;
		soql6 += ' c_hotel_adw_break_48__c, ' ;	
		soql6 += ' f_hotel_adw_48__c, ' ;
		soql6 += ' c_hotel_adw_break_24__c, ' ;
		soql6 += ' f_hotel_adw_24__c, ' ;
		soql6 += ' c_hotel_adw_break_15__c, ' ;
		soql6 += ' f_hotel_adw_15__c, ' ;
		soql6 += ' c_hotel_adw_break_12__c, ' ;
		soql6 += ' f_hotel_adw_12__c, ' ;
		soql6 += ' c_last_gaming_trip__c, ' ;
		soql6 += ' i_days_since_gaming__c, ' ;
		soql6 += ' i_email_decile__c ' ;

		soql6 += ' FROM marketing_campaigns__x  ';
		if (idType == 'contact') {
			soql6 += whereClause + ': allContactIds';
		} else {
			soql6 += whereClause + ': ids';
		}

		soql6 = String.escapeSingleQuotes(soql6);


		//
		// need to run several SOQLs due to error if too many external data source are
		// used in a SOQL
		//
		Map<String, MarketingCampaignWrapper> mktCampaignsMap = new Map<String, MarketingCampaignWrapper> ();

		List<marketing_campaigns__x> mktCampaignsList;
		if (idType == 'external') {
			mktCampaignsList = (!mockedRequests.isEmpty()) ? mockedRequests : Database.query(soql1);	  	
		  	updateMarketingCampaign (mktCampaignsMap, mktCampaignsList, '1');

		  	mktCampaignsList = (!mockedRequests.isEmpty()) ? mockedRequests : Database.query(soql2);
		  	updateMarketingCampaign (mktCampaignsMap, mktCampaignsList, '2');

		  	mktCampaignsList = (!mockedRequests.isEmpty()) ? mockedRequests : Database.query(soql3);
		  	updateMarketingCampaign (mktCampaignsMap, mktCampaignsList, '3');

		  	mktCampaignsList = (!mockedRequests.isEmpty()) ? mockedRequests : Database.query(soql4);
		  	updateMarketingCampaign (mktCampaignsMap, mktCampaignsList, '4');

		  	mktCampaignsList = (!mockedRequests.isEmpty()) ? mockedRequests : Database.query(soql6);
		  	updateMarketingCampaign (mktCampaignsMap, mktCampaignsList, '6');
		} else {

		  	mktCampaignsList = (!mockedRequests.isEmpty()) ? mockedRequests : Database.query(soql5);
		  	updateMarketingCampaign (mktCampaignsMap, mktCampaignsList, '5');
		}

	  	system.debug('*** mktCampaignsMap return ' + mktCampaignsMap.values());

	  	return mktCampaignsMap.values();
	}

	/*******************************************************************************************************
    * @description Update the MarketingCampaignWrapper with soql results
    * @param Map<String, MarketingCampaignWrapper> mktCampaignsMap
    * @param List<marketing_campaigns__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<MarketingCampaignWrapper> containing the updated data
    * @example
    * List<GuestShelfDataCC.MarketingCampaignWrapper>  wrapperList = 
	*   		GuestShelfDataCC.updateMarketingCampaign(Map<String, MarketingCampaignWrapper> mktCampaignsMap, List<marketing_campaigns__x> mktCampaignsList, String pass);
    */
	private static void updateMarketingCampaign (Map<String, MarketingCampaignWrapper> mktCampaignsMap, List<marketing_campaigns__x> mktCampaignsList, String pass){
		MarketingCampaignWrapper mcw;
		GuestShelfData2CC ghfCC = new GuestShelfData2CC();

		for (marketing_campaigns__x mktCampaign : mktCampaignsList ){
	  		if (!mktCampaignsMap.containsKey(mktCampaign.ExternalId)) {
	  			mktCampaignsMap.put(mktCampaign.ExternalId, new MarketingCampaignWrapper());
	  		}
	  		mcw = mktCampaignsMap.get(mktCampaign.ExternalId);
	  		if (pass == '1'){
		  		mcw.ExternalId = mktCampaign.ExternalId;
		  		mcw.c_acct_type_cd_fk = mktCampaign.c_acct_type_cd_fk__c;
		  		mcw.c_acct_type_cd_fk_Name = mktCampaign.c_acct_type_cd_fk__r.Name;
		  		mcw.c_acct_type_cd_fk_Description = mktCampaign.c_acct_type_cd_fk__r.Description__c;
		  		mcw.c_acct_type_cd_fk_Quality_code = mktCampaign.c_acct_type_cd_fk__r.Quality_code__c;
		  		mcw.c_acct_type_cd_fk_Type_category = mktCampaign.c_acct_type_cd_fk__r.Type_category__c;
		  		mcw.c_acct_type_cd_fk_Type_Id = mktCampaign.c_acct_type_cd_fk__r.Type_Id__c;
		  		mcw.c_campaign_cd_fk = mktCampaign.c_campaign_cd_fk__c;
		  		mcw.c_campaign_cd_fk_Name = mktCampaign.c_campaign_cd_fk__r.Name;
		  		mcw.c_campaign_cd_fk_Description = mktCampaign.c_campaign_cd_fk__r.Description__c;
		  		mcw.c_campaign_cd_fk_In_use = mktCampaign.c_campaign_cd_fk__r.In_use__c;
		  		mcw.c_campaign_type_fk = mktCampaign.c_campaign_type_fk__c;
		  		mcw.c_campaign_type_fk_Name = mktCampaign.c_campaign_type_fk__r.Name;
		  		mcw.c_campaign_type_fk_Description = mktCampaign.c_campaign_type_fk__r.Description__c;
		  		mcw.contact = mktCampaign.contact__c;
		  	}
		  	if (pass == '2'){
			  	mcw.c_dom_cd_prop_fk = mktCampaign.c_dom_cd_prop_fk__c;
		  		mcw.c_dom_cd_prop_fk_Name = mktCampaign.c_dom_cd_prop_fk__r.Name;
		  		mcw.c_dom_market_cd_fk = mktCampaign.c_dom_market_cd_fk__c;
		  		mcw.c_dom_market_cd_fk_Name = mktCampaign.c_dom_market_cd_fk__r.Name;
		  		mcw.c_dom_market_cd_fk_Active_Flag = mktCampaign.c_dom_market_cd_fk__r.Active_Flag__c;
		  		mcw.c_dom_market_cd_fk_Description = mktCampaign.c_dom_market_cd_fk__r.Description__c;
		  		mcw.c_dom_market_cd_fk_Direct_Marketing_Center_Name = mktCampaign.c_dom_market_cd_fk__r.Direct_Marketing_Center__r.Name;
		  		mcw.c_dom_market_cd_fk_Market_Code = mktCampaign.c_dom_market_cd_fk__r.Market_Code__c;
		  		mcw.c_dom_market_cd_fk_POD = mktCampaign.c_dom_market_cd_fk__r.POD__r.Description__c;
		  		mcw.c_dom_market_cd_fk_Time_Zone = mktCampaign.c_dom_market_cd_fk__r.Time_Zone__c;
		  		mcw.c_dom_pref_prop_cd_fk = mktCampaign.c_dom_pref_prop_cd_fk__c;
		  		mcw.c_dom_pref_prop_cd_fk_Name = mktCampaign.c_dom_pref_prop_cd_fk__r.Name;
		  	}
		  	if (pass == '3'){
			  	mcw.c_pref_prop_cd_fk = mktCampaign.c_pref_prop_cd_fk__c;
		  		mcw.c_pref_prop_cd_fk_Name = mktCampaign.c_pref_prop_cd_fk__r.Name;
		  		mcw.c_prop_cd_1_fk= mktCampaign.c_prop_cd_1_fk__c;
		  		mcw.c_prop_cd_1_fk_Name = mktCampaign.c_prop_cd_1_fk__r.Name;
		  		mcw.c_prop_cd_2_fk = mktCampaign.c_prop_cd_2_fk__c;
		  		mcw.c_prop_cd_2_fk_Name = mktCampaign.c_prop_cd_2_fk__r.Name;
		  	}
		  	if (pass == '4'){
		  		mcw.c_tier_cd_fk = mktCampaign.c_tier_cd_fk__c;
		  		mcw.c_tier_cd_fk_Name = mktCampaign.c_tier_cd_fk__r.Name;
		  		mcw.f_worth = mktCampaign.f_worth__c;
		  	}
		  	if (pass == '5'){
		  		mcw.ExternalId = mktCampaign.ExternalId;
			  //	mcw. = mktCampaign.c_prop_market_cd_fk__c;
				mcw.c_prop_market_cd_Name =mktCampaign.c_prop_market_cd__c;
				//mcw. =mktCampaign.c_dom_pref_prop_cd_fk__c;
				mcw.c_dom_pref_prop_cd_Name =mktCampaign.c_dom_pref_prop_cd__c;
				mcw.d_last_activity_dt = ghfCC.stripTime(mktCampaign.d_last_activity_dt__c);

				mcw.c_worth_break =mktCampaign.c_worth_break__c; 
				mcw.f_worth =mktCampaign.f_worth__c ;
				mcw.f_worth_12mn_ap_ah =mktCampaign.f_worth_12mn_ap_ah__c;
				mcw.f_worth_all_ytd_ap_ah =mktCampaign.f_worth_all_ytd_ap_ah__c;
				mcw.c_frequency =mktCampaign.c_frequency__c;
				mcw.i_trp_rtd_ap_pdb_12mn_plus =mktCampaign.i_trp_rtd_ap_pdb_12mn_plus__c;
				mcw.i_trp_rtd_ap_pdb_24mn_plus =mktCampaign.i_trp_rtd_ap_pdb_24mn_plus__c;
				mcw.c_game_pref =mktCampaign.c_game_pref__c;
				mcw.c_drive_distance_cluster =mktCampaign.c_drive_distance_cluster__c;
				mcw.d_min_est_dt = ghfCC.stripTime(mktCampaign.d_min_est_dt__c);

				mcw.c_campaign_type =mktCampaign.c_campaign_type__c;
				mcw.c_campaign_cd =mktCampaign.c_campaign_cd__c;
				mcw.c_campaign_desc =mktCampaign.c_campaign_desc__c;
				mcw.subCampaign = mktCampaign.c_campaign_cd__c + '-' + mktCampaign.c_campaign_desc__c;
			}
			if (pass == '6'){
		  		mcw.ExternalId = mktCampaign.ExternalId;
				mcw.c_campaign_desc= mktCampaign.c_campaign_desc__c ;
				mcw.c_campaign_type= mktCampaign.c_campaign_type__c ;	
				mcw.c_campaign_type_desc= mktCampaign.c_campaign_type_desc__c ;
				mcw.d_campaign_score_dt= mktCampaign.d_campaign_score_dt__c ;
				mcw.c_version_cd= mktCampaign.c_version_cd__c ;
				mcw.c_acct_type_cd= mktCampaign.c_acct_type_cd__c ;
				mcw.c_prop_market_cd= mktCampaign.c_prop_market_cd__c ;
				mcw.c_dom_pref_prop_cd= mktCampaign.c_dom_pref_prop_cd__c ;
				mcw.c_tier_cd= mktCampaign.c_tier_cd__c ;
				mcw.c_marketing_state_cd= mktCampaign.c_marketing_state_cd__c ;	
				mcw.c_regulatory_state_cd= mktCampaign.c_regulatory_state_cd__c ;	
				mcw.i_random_1= mktCampaign.i_random_1__c ;
				mcw.i_random_2= mktCampaign.i_random_2__c ;
				mcw.i_random_static_yr= mktCampaign.i_random_static_yr__c ;
				mcw.c_main_ethnic_type= mktCampaign.c_main_ethnic_type__c ;	
				mcw.c_ethnic_group1= mktCampaign.c_main_ethnic_type__c ;
				mcw.c_preferred_written_language= mktCampaign.c_preferred_written_language__c ;
				mcw.c_prop_mail_cd= mktCampaign.c_prop_mail_cd__c ;
				mcw.c_emailable= mktCampaign.c_emailable__c ;
				mcw.c_mailable= mktCampaign.c_mailable__c ;
				mcw.c_channel_pref= mktCampaign.c_channel_pref__c ;
				mcw.c_uk_res_supress= mktCampaign.c_uk_res_supress__c ;
				mcw.c_id_verified= mktCampaign.c_id_verified__c ;
				mcw.c_age_18_plus= mktCampaign.c_age_18_plus__c ;
				mcw.c_age_19_plus= mktCampaign.c_age_19_plus__c ;
				mcw.c_age_21_plus= mktCampaign.c_age_21_plus__c ;
				mcw.c_ucl_supp_flag= mktCampaign.c_ucl_supp_flag__c ;
				mcw.c_uci_supp_flag= mktCampaign.c_uci_supp_flag__c ;
				mcw.c_video_poker_pref= mktCampaign.c_video_poker_pref__c ;	
				mcw.c_baccarat_pref= mktCampaign.c_baccarat_pref__c ;
				mcw.i_profitable_pct= mktCampaign.i_profitable_pct__c ;
				mcw.c_convienence_cd= mktCampaign.c_convienence_cd__c ;
				mcw.i_lodging_pct= mktCampaign.i_lodging_pct__c ;
				mcw.c_channel_rec= mktCampaign.c_channel_rec__c ;
				mcw.c_dom_market_cd= mktCampaign.c_dom_market_cd__c ;
				mcw.c_gst_prop_dm_optout_flag= mktCampaign.c_gst_prop_dm_optout_flag__c ;	
				mcw.c_tdc_supp_flag= mktCampaign.c_tdc_supp_flag__c;	
				mcw.c_prop_cd_1= mktCampaign.c_prop_cd_1__c ;
				mcw.i_prop_pct_worth_1= mktCampaign.i_prop_pct_worth_1__c ;
				mcw.c_prop_cd_2= mktCampaign.c_prop_cd_2__c ;
				mcw.i_prop_pct_worth_2= mktCampaign.i_prop_pct_worth_2__c ;
				mcw.c_pref_prop_host_cd= mktCampaign.c_pref_prop_host_cd__c ;
				mcw.c_host_type= mktCampaign.c_host_type__c ;
				mcw.i_age= mktCampaign.i_age__c ;
				mcw.c_gender= mktCampaign.c_gender__c ;
				mcw.c_dom_cd_prop= mktCampaign.c_dom_cd_prop__c ;	
				mcw.c_pref_prop_cd= mktCampaign.c_pref_prop_cd__c ;
				mcw.c_geo_dm_zone= mktCampaign.c_geo_dm_zone__c ;
				mcw.c_geo_rpt_zone= mktCampaign.c_geo_rpt_zone__c ;
				mcw.c_distance_cluster= mktCampaign.c_distance_cluster__c ;
				mcw.c_msa_cd= mktCampaign.c_msa_cd__c ;
				mcw.c_msa= mktCampaign.c_msa__c ;
				mcw.c_zip_7_pdb= mktCampaign.c_zip_7_pdb__c ;
				mcw.d_create_dt_mkt= mktCampaign.d_create_dt_mkt__c ;
				mcw.d_create_dt_ent= mktCampaign.d_create_dt_ent__c ;
				mcw.f_act_all_ap_pdb_12mn_plus= mktCampaign.f_act_all_ap_pdb_12mn_plus__c ;	
				mcw.f_theo_all_ap_pdb_12mn_plus= mktCampaign.f_theo_all_ap_pdb_12mn_plus__c ;
				mcw.i_days_rtd_ap_pdb_12mn_plus= mktCampaign.i_days_rtd_ap_pdb_12mn_plus__c ;
				mcw.f_daily_theo_ap_pdb_12mnplus= mktCampaign.f_daily_theo_ap_pdb_12mnplus__c ;
				mcw.f_daily_act_ap_pdb_12mn_plus= mktCampaign.f_daily_act_ap_pdb_12mn_plus__c ;
				mcw.f_daily_wrth_ap_pdb_12mnplus= mktCampaign.f_daily_wrth_ap_pdb_12mnplus__c ;
				mcw.f_resp_rate_ap_pdb_12mn_plus= mktCampaign.f_resp_rate_ap_pdb_12mn_plus__c ;
				mcw.f_ofr_trp_pct_ap_pdb12mnplus= mktCampaign.f_ofr_trp_pct_ap_pdb12mnplus__c ;
				mcw.f_htlsty_pct_ap_pdb_12mnplus= mktCampaign.f_htlsty_pct_ap_pdb_12mnplus__c ;
				mcw.f_slot_pct_ap_pdb_12mn_plus= mktCampaign.f_slot_pct_ap_pdb_12mn_plus__c ;
				mcw.f_trp_all_adj_sc_pdb_12mn= mktCampaign.f_trp_all_adj_sc_pdb_12mn__c ;
				mcw.f_trp_rtd_adj_sc_pdb_12mn= mktCampaign.f_trp_rtd_adj_sc_pdb_12mn__c ;
				mcw.f_act_all_ap_pdb_24mn_plus= mktCampaign.f_act_all_ap_pdb_24mn_plus__c ;
				mcw.f_theo_all_ap_pdb_24mn_plus= mktCampaign.f_theo_all_ap_pdb_24mn_plus__c ;
				mcw.i_days_rtd_ap_pdb_24mn_plus= mktCampaign.i_days_rtd_ap_pdb_24mn_plus__c ;
				mcw.f_daily_theo_ap_pdb_24mnplus= mktCampaign.f_daily_theo_ap_pdb_24mnplus__c ;
				mcw.f_daily_act_ap_pdb_24mn_plus= mktCampaign.f_daily_act_ap_pdb_24mn_plus__c ;
				mcw.f_daily_wrth_ap_pdb_24mnplus= mktCampaign.f_daily_wrth_ap_pdb_24mnplus__c ;
				mcw.f_resp_rate_ap_pdb_24mn_plus= mktCampaign.f_resp_rate_ap_pdb_24mn_plus__c ;
				mcw.f_ofr_trp_pct_ap_pdb24mnplus= mktCampaign.f_ofr_trp_pct_ap_pdb24mnplus__c ;
				mcw.f_htlsty_pct_ap_pdb_24mnplus= mktCampaign.f_htlsty_pct_ap_pdb_24mnplus__c ;
				mcw.f_slot_pct_ap_pdb_24mn_plus= mktCampaign.f_slot_pct_ap_pdb_24mn_plus__c ;
				mcw.f_trp_all_adj_sc_pdb_24mn= mktCampaign.f_trp_all_adj_sc_pdb_24mn__c ;
				mcw.f_trp_rtd_adj_sc_pdb_24mn= mktCampaign.f_trp_rtd_adj_sc_pdb_24mn__c ;
				mcw.f_trp_all_adj_sc_pdb_36mn= mktCampaign.f_trp_all_adj_sc_pdb_36mn__c ;
				mcw.f_trp_rtd_adj_sc_pdb_36mn= mktCampaign.f_trp_rtd_adj_sc_pdb_36mn__c ;
				mcw.f_profit_pct_ent= mktCampaign.f_profit_pct_ent__c ;
				mcw.c_profit_flag_ent= mktCampaign.c_profit_flag_ent__c ;
				mcw.f_profit_pct_mkt= mktCampaign.f_profit_pct_mkt__c ;
				mcw.c_profit_flag_mkt= mktCampaign.c_profit_flag_mkt__c ;
				mcw.i_age_adj_ah= mktCampaign.i_age_adj_ah__c ;
				mcw.i_dob_mn_adj_ah= mktCampaign.i_dob_mn_adj_ah__c ;
				mcw.i_dob_yr_adj_ah= mktCampaign.i_dob_yr_adj_ah__c ;
				mcw.c_country_cd_ah= mktCampaign.c_country_cd_ah__c ;
				mcw.c_credit_status_flag= mktCampaign.c_credit_status_flag__c ;
				mcw.c_mkt_host_cd_adj_ah= mktCampaign.c_mkt_host_cd_adj_ah__c ;
				mcw.c_dom_prop_host_cd_adj_ah= mktCampaign.c_dom_prop_host_cd_adj_ah__c ;	
				mcw.c_prop_cd_1_host_cd_adj_ah= mktCampaign.c_prop_cd_1_host_cd_adj_ah__c ;
				mcw.c_zip_7_ah= mktCampaign.c_zip_7_ah__c ;
				mcw.f_tier_score_ah= mktCampaign.f_tier_score_ah__c ;
				mcw.f_lodging_pct_mkt_adj_ah= mktCampaign.f_lodging_pct_mkt_adj_ah__c ;	
				mcw.f_pct_bacarrat_mkt_ah= mktCampaign.f_pct_bacarrat_mkt_ah__c ;
				mcw.f_pct_blackjack_mkt_ah= mktCampaign.f_pct_blackjack_mkt_ah__c ;
				mcw.f_pct_craps_mkt_ah= mktCampaign.f_pct_craps_mkt_ah__c ;
				mcw.f_pct_other_mkt_ah= mktCampaign.f_pct_other_mkt_ah__c ;
				mcw.f_pct_paigow_mkt_ah= mktCampaign.f_pct_paigow_mkt_ah__c ;
				mcw.f_pct_roulette_mkt_ah= mktCampaign.f_pct_roulette_mkt_ah__c ;
				mcw.f_pct_video_poker_mkt_ah= mktCampaign.f_pct_video_poker_mkt_ah__c ;
				mcw.c_future_res_flag_mkt_ah= mktCampaign.c_future_res_flag_mkt_ah__c ;
				mcw.f_worth_1mn_ap_ah= mktCampaign.f_worth_1mn_ap_ah__c ;
				mcw.f_worth_3mn_ap_ah= mktCampaign.f_worth_3mn_ap_ah__c ;
				mcw.f_worth_6mn_ap_ah= mktCampaign.f_worth_6mn_ap_ah__c ;
				mcw.f_theo_all_1mn_ap_ah= mktCampaign.f_theo_all_1mn_ap_ah__c ;
				mcw.f_theo_all_3mn_ap_ah= mktCampaign.f_theo_all_3mn_ap_ah__c ;
				mcw.f_theo_all_6mn_ap_ah= mktCampaign.f_theo_all_6mn_ap_ah__c ;
				mcw.f_theo_all_12mn_ap_ah= mktCampaign.f_theo_all_12mn_ap_ah__c ;
				mcw.f_theo_all_ytd_ap_ah= mktCampaign.f_theo_all_ytd_ap_ah__c ;
				mcw.f_theo_slot_1mn_ap_ah= mktCampaign.f_theo_slot_1mn_ap_ah__c ;
				mcw.f_theo_slot_3mn_ap_ah= mktCampaign.f_theo_slot_3mn_ap_ah__c ;
				mcw.f_theo_slot_6mn_ap_ah= mktCampaign.f_theo_slot_6mn_ap_ah__c;
				mcw.f_theo_slot_12mn_ap_ah= mktCampaign.f_theo_slot_12mn_ap_ah__c ;
				mcw.f_theo_table_1mn_ap_ah= mktCampaign.f_theo_table_1mn_ap_ah__c ;
				mcw.f_theo_table_3mn_ap_ah= mktCampaign.f_theo_table_3mn_ap_ah__c ;
				mcw.f_theo_table_6mn_ap_ah= mktCampaign.f_theo_table_6mn_ap_ah__c ;
				mcw.f_theo_table_12mn_ap_ah= mktCampaign.f_theo_table_12mn_ap_ah__c ;
				mcw.f_act_all_1mn_ap_ah= mktCampaign.f_act_all_1mn_ap_ah__c ;
				mcw.f_act_all_3mn_ap_ah= mktCampaign.f_act_all_3mn_ap_ah__c ;
				mcw.f_act_all_6mn_ap_ah= mktCampaign.f_act_all_6mn_ap_ah__c ;
				mcw.f_act_all_12mn_ap_ah= mktCampaign.f_act_all_12mn_ap_ah__c;
				mcw.f_actual_all_ytd_ap_ah= mktCampaign.f_actual_all_ytd_ap_ah__c ;
				mcw.f_avgbet_game_1mn_ap_ah= mktCampaign.f_avgbet_game_1mn_ap_ah__c ;
				mcw.f_avgbet_game_3mn_ap_ah= mktCampaign.f_avgbet_game_3mn_ap_ah__c ;
				mcw.f_avgbet_game_6mn_ap_ah= mktCampaign.f_avgbet_game_6mn_ap_ah__c ;
				mcw.f_avgbet_game_12mn_ap_ah= mktCampaign.f_avgbet_game_12mn_ap_ah__c ;
				mcw.i_lop_game_1mn_ap_ah= mktCampaign.i_lop_game_1mn_ap_ah__c ;
				mcw.i_lop_game_3mn_ap_ah= mktCampaign.i_lop_game_3mn_ap_ah__c ;
				mcw.i_lop_game_6mn_ap_ah= mktCampaign.i_lop_game_6mn_ap_ah__c ;
				mcw.i_lop_game_12mn_ap_ah= mktCampaign.i_lop_game_12mn_ap_ah__c ;
				mcw.i_trp_all_cms_1mn_ap_ah= mktCampaign.i_trp_all_cms_1mn_ap_ah__c ;
				mcw.i_trp_all_cms_3mn_ap_ah= mktCampaign.i_trp_all_cms_3mn_ap_ah__c ;
				mcw.i_trp_all_cms_6mn_ap_ah= mktCampaign.i_trp_all_cms_6mn_ap_ah__c ;
				mcw.i_trp_all_cms_12mn_ap_ah= mktCampaign.i_trp_all_cms_12mn_ap_ah__c ;
				mcw.i_trp_rtd_1mn_ap_ah= mktCampaign.i_trp_rtd_1mn_ap_ah__c ;
				mcw.i_trp_rtd_3mn_ap_ah= mktCampaign.i_trp_rtd_3mn_ap_ah__c ;
				mcw.i_trp_rtd_6mn_ap_ah= mktCampaign.i_trp_rtd_6mn_ap_ah__c;
				mcw.i_trp_rtd_12mn_ap_ah= mktCampaign.i_trp_rtd_12mn_ap_ah__c ;
				mcw.i_days_rtd_1mn_ap_ah= mktCampaign.i_days_rtd_1mn_ap_ah__c ;
				mcw.i_days_rtd_3mn_ap_ah= mktCampaign.i_days_rtd_3mn_ap_ah__c ;
				mcw.i_days_rtd_6mn_ap_ah= mktCampaign.i_days_rtd_6mn_ap_ah__c ;
				mcw.i_days_rtd_12mn_ap_ah= mktCampaign.i_days_rtd_12mn_ap_ah__c ;
				mcw.d_last_rated_dt_mkt_ah= mktCampaign.d_last_rated_dt_mkt_ah__c ;
				mcw.f_rc_earned_1mn_mkt_ah= mktCampaign.f_rc_earned_1mn_mkt_ah__c ;
				mcw.f_rc_earned_3mn_mkt_ah= mktCampaign.f_rc_earned_3mn_mkt_ah__c ;
				mcw.f_rc_earned_6mn_mkt_ah= mktCampaign.f_rc_earned_6mn_mkt_ah__c ;
				mcw.f_rc_earned_12mn_mkt_ah= mktCampaign.f_rc_earned_12mn_mkt_ah__c ;
				mcw.d_first_gaming_dt_mkt_ah= mktCampaign.d_first_gaming_dt_mkt_ah__c ;
				mcw.d_first_gaming_dt_ent_ah= mktCampaign.d_first_gaming_dt_ent_ah__c ;
				mcw.d_first_dt_played_mkt_ah= mktCampaign.d_first_dt_played_mkt_ah__c ;
				mcw.f_act_all_cms_first_hr_m_ah= mktCampaign.f_act_all_cms_first_hr_m_ah__c ;
				mcw.f_act_all_cms_first_day_m_ah= mktCampaign.f_act_all_cms_first_day_m_ah__c ;
				mcw.f_act_all_cms_first_trp_m_ah= mktCampaign.f_act_all_cms_first_trp_m_ah__c ;
				mcw.i_lop_first_hr_mkt_ah= mktCampaign.i_lop_first_hr_mkt_ah__c ;
				mcw.i_lop_first_day_mkt_ah= mktCampaign.i_lop_first_day_mkt_ah__c ;
				mcw.i_lop_first_trp_mkt_ah= mktCampaign.i_lop_first_trp_mkt_ah__c ;
				mcw.c_convienence_cd_new= mktCampaign.c_convienence_cd_new__c ;
				mcw.c_recency= mktCampaign.c_recency__c ;
				mcw.c_frequency_tc= mktCampaign.c_frequency_tc__c ;
				mcw.c_frequency_ttm_24= mktCampaign.c_frequency_ttm_24__c ;
				mcw.c_tierscore_desc= mktCampaign.c_tierscore_desc__c ;
				mcw.f_hotel_adw= mktCampaign.f_hotel_adw__c ;
				mcw.c_hotel_adw_break= mktCampaign.c_hotel_adw_break__c ;	
				mcw.c_frequency_ttm= mktCampaign.c_frequency_ttm__c ;
				mcw.c_avg_day_hotel_flag= mktCampaign.c_avg_day_hotel_flag__c ;
				mcw.i_days_since_last= mktCampaign.i_days_since_last__c ;
				mcw.f_trip_cycle_48= mktCampaign.f_trip_cycle_48__c ;
				mcw.c_frequency_tc_12= mktCampaign.c_frequency_tc_12__c ;
				mcw.f_trip_cycle_12= mktCampaign.f_trip_cycle_12__c ;
				mcw.i_ttm_trip_cnt_12= mktCampaign.i_ttm_trip_cnt_12__c ;
				mcw.i_ttm_trip_cnt_24= mktCampaign.i_ttm_trip_cnt_24__c ;
				mcw.c_adw_trip_break_12= mktCampaign.c_adw_trip_break_12__c ;
				mcw.f_adw_trip_12= mktCampaign.f_adw_trip_12__c ;
				mcw.c_adw_trip_break_6= mktCampaign.c_adw_trip_break_6__c ;
				mcw.f_adw_trip_6= mktCampaign.f_adw_trip_6__c ;
				mcw.c_adw_break_48= mktCampaign.c_adw_break_48__c ;
				mcw.f_adw_48= mktCampaign.f_adw_48__c ;
				mcw.c_adw_break_24= mktCampaign.c_adw_break_24__c ;	
				mcw.f_adw_24= mktCampaign.f_adw_24__c ;
				mcw.c_adw_break_15= mktCampaign.c_adw_break_15__c ;	
				mcw.f_adw_15= mktCampaign.f_adw_15__c ;
				mcw.c_adw_break_12= mktCampaign.c_adw_break_12__c ;	
				mcw.f_adw_12= mktCampaign.f_adw_12__c ;
				mcw.c_hotel_adw_break_48= mktCampaign.c_hotel_adw_break_48__c ;	
				mcw.f_hotel_adw_48= mktCampaign.f_hotel_adw_48__c ;
				mcw.c_hotel_adw_break_24= mktCampaign.c_hotel_adw_break_24__c ;
				mcw.f_hotel_adw_24= mktCampaign.f_hotel_adw_24__c ;
				mcw.c_hotel_adw_break_15= mktCampaign.c_hotel_adw_break_15__c ;
				mcw.f_hotel_adw_15= mktCampaign.f_hotel_adw_15__c ;
				mcw.c_hotel_adw_break_12= mktCampaign.c_hotel_adw_break_12__c ;
				mcw.f_hotel_adw_12= mktCampaign.f_hotel_adw_12__c ;
				mcw.c_last_gaming_trip= mktCampaign.c_last_gaming_trip__c ;
				mcw.i_days_since_gaming= mktCampaign.i_days_since_gaming__c ;
				mcw.i_email_decile= mktCampaign.i_email_decile__c ;
		  	}
				

	  		mktCampaignsMap.put(mktCampaign.ExternalId, mcw);
	  	}
	}
	/*******************************************************************************************************
    * @description Retrieve the external data for Marketing Campaign Properties as view only
    * @param List<Id> of Contact Ids used to retrieve the Marketing Campaign Properties data
    * @return List<MarketingCampaignPropWrapper> containing the retrieve data
    * @example
    * List<GuestShelfDataCC.MarketingCampaignPropWrapper>  marketingCampaignPropList = 
	*   		GuestShelfDataCC.retrieveMarketingCampaignProperties(List<Id> contactIds);
    */

    @RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignPropertyWrapper> retrieveMarketingCampaignPropDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = ' WHERE ExternalId in';
		String idType = 'external';
		return retrieveMarketingCampaignProperties(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignPropertyWrapper> retrieveMarketingCampaignPropByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		String idType = 'contact';
		return retrieveMarketingCampaignProperties(contactIds, whereClause, idType);
	}

	private static List<MarketingCampaignPropertyWrapper> retrieveMarketingCampaignProperties(List<String> ids, String whereClause, String idType) {
		Map<String, MarketingCampaignPropertyWrapper> mktCampaignsPropMap = new Map<String, MarketingCampaignPropertyWrapper> ();

		//
		// get the cross-reference dmIds for the contacts in order to access unmerged activities
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new GuestShelfData2CC()).getConsXrefIds(ids);
		} 
		
			system.debug('*** whereClause ' + whereClause);
			String soql1 = 'SELECT ExternalId, ';
		   	soql1 += ' c_acct_type_cd_fk__c,  ';
		  	soql1 += ' c_acct_type_cd_fk__r.Name, ';
		  	soql1 += ' c_acct_type_cd_fk__r.Description__c, ';
		  	soql1 += ' c_acct_type_cd_fk__r.Quality_code__c, ';
		  	soql1 += ' c_acct_type_cd_fk__r.Type_category__c, ';
		  	soql1 += ' c_acct_type_cd_fk__r.Type_Id__c, ';
		  	soql1 += ' c_campaign_cd_fk__c, ';
		  	soql1 += ' c_campaign_cd_fk__r.Name,';
		  	soql1 += ' c_campaign_cd_fk__r.Description__c, ';
		  	soql1 += ' c_campaign_cd_fk__r.In_use__c, ';
		  	soql1 += ' c_campaign_type_fk__c, ';
		  	soql1 += ' c_campaign_type_fk__r.Name, ';
		  	soql1 += ' c_campaign_type_fk__r.Description__c, ';
		  	soql1 += ' contact__c ';
		  	soql1 += ' FROM marketing_campaigns_properties__x ';
		  	if (idType == 'contact') {
				soql1 += whereClause + ': allContactIds';
			} else {
				soql1 += whereClause + ': ids';
			}

		  	soql1 = String.escapeSingleQuotes(soql1);

		  	String soql2 = ' SELECT ExternalId,	 ';   				
		  	soql2 += ' c_dom_cd_prop_fk__c, ';
		  	soql2 += ' c_dom_cd_prop_fk__r.Name, ';
		  	soql2 += ' c_dom_market_cd_fk__c, ';
		  	soql2 += ' c_dom_market_cd_fk__r.Name, ';
		  	soql2 += ' c_dom_market_cd_fk__r.Active_Flag__c, ';
		  	soql2 += ' c_dom_market_cd_fk__r.Description__c, ';
		  	soql2 += ' c_dom_market_cd_fk__r.Direct_Marketing_Center__r.Name, ';
		  	soql2 += ' c_dom_market_cd_fk__r.Market_Code__c, ';
		  	soql2 += ' c_dom_market_cd_fk__r.POD__c, ';
		  	soql2 += ' c_dom_market_cd_fk__r.Time_Zone__c, ';
		  	soql2 += ' c_dom_pref_prop_cd_fk__c, ';
		  	soql2 += ' c_dom_pref_prop_cd_fk__r.Name ';
		  	soql2 += ' FROM marketing_campaigns_properties__x  ';
		  	if (idType == 'contact') {
				soql2 += whereClause + ': allContactIds';
			} else {
				soql2 += whereClause + ': ids';
			}

		  	soql2 = String.escapeSingleQuotes(soql2);

		  	String soql3 = ' SELECT ExternalId,	 '; 				
		  	soql3 += ' c_pref_prop_cd_fk__c, '; 
		  	soql3 += ' c_pref_prop_cd_fk__r.Name, '; 
		  	soql3 += ' c_prop_cd_fk__c, '; 
		  	soql3 += ' c_prop_cd_fk__r.Name, '; 
		  	soql3 += ' c_prop_cd_2_fk__c, '; 
		  	soql3 += ' c_prop_cd_2_fk__r.Name, '; 
		  	soql3 += ' c_worth_break__c, '; 
		  	soql3 += ' f_property_worth__c  '; 
		    soql3 += ' FROM marketing_campaigns_properties__x  '; 
		  	if (idType == 'contact') {
				soql3 += whereClause + ': allContactIds';
			} else {
				soql3 += whereClause + ': ids';
			}

		  	soql3 = String.escapeSingleQuotes(soql3);

	  	String soql5 = 'SELECT ExternalId, ';
	  	soql5 += ' c_prop_market_cd__c, ';
		//soql5 += ' c_prop_market_cd_fk__r.Name, ';
		soql5 += ' c_dom_pref_prop_cd__c, ';
		//soql5 += '  c_dom_pref_prop_cd_fk__r.Name, ';
		soql5 += ' d_last_activity_dt__c, ';
		soql5+= '  c_worth_break__c, '; 
		soql5 += '  f_worth__c, ';
		soql5 += ' f_worth_12mn_ap_ah__c, ';
		soql5 += ' f_worth_all_ytd_ap_ah__c, ';
		soql5 += ' c_frequency__c, ';
		soql5 += ' i_trp_rtd_ap_pdb_12mn_plus__c, ';

		soql5 += ' i_trp_rtd_ap_pdb_24mn_plus__c, ';
		soql5 += ' c_game_pref__c, ';
		soql5 += ' c_drive_distance_cluster__c, ';
		soql5 += ' d_min_est_dt__c, ';
		soql5 += ' c_campaign_type__c, ';
		soql5 += ' c_campaign_cd__c, ';
		soql5 += ' c_campaign_desc__c' ;
		soql5 += ' FROM marketing_campaigns_properties__x  ';
		if (idType == 'contact') {
				soql5 += whereClause + ': allContactIds';
			} else {
				soql5 += whereClause + ': ids';
			}

		soql5 = String.escapeSingleQuotes(soql5);

		String soql6 = 'SELECT ExternalId, ';
		soql6 += ' c_campaign_desc__c, ' ;
		soql6 += ' c_campaign_type__c, ' ;	
		soql6 += ' c_campaign_type_desc__c, ' ;
		soql6 += ' d_campaign_score_dt__c, ' ;
		soql6 += ' c_version_cd__c, ' ;
		soql6 += ' c_acct_type_cd__c, ' ;
		soql6 += ' c_prop_market_cd__c, ' ;
		soql6 += ' c_dom_pref_prop_cd__c, ' ;
		soql6 += ' c_tier_cd__c, ' ;
		soql6 += ' c_marketing_state_cd__c, ' ;	
		soql6 += ' c_regulatory_state_cd__c, ' ;	
		soql6 += ' i_random_1__c, ' ;
		soql6 += ' i_random_2__c, ' ;
		soql6 += ' i_random_static_yr__c, ' ;
		soql6 += ' c_main_ethnic_type__c, ' ;	
		soql6 += ' c_ethnic_group1__c, ' ;
		soql6 += ' c_preferred_written_language__c, ' ;
		soql6 += ' c_prop_mail_cd__c, ' ;
		soql6 += ' c_emailable__c, ' ;
		soql6 += ' c_mailable__c, ' ;
		soql6 += ' c_channel_pref__c, ' ;
		soql6 += ' c_uk_res_supress__c, ' ;
		soql6 += ' c_id_verified__c, ' ;
		soql6 += ' c_age_18_plus__c, ' ;
		soql6 += ' c_age_19_plus__c, ' ;
		soql6 += ' c_age_21_plus__c, ' ;
		soql6 += ' c_ucl_supp_flag__c, ' ;
		soql6 += ' c_uci_supp_flag__c, ' ;
		soql6 += ' c_video_poker_pref__c, ' ;	
		soql6 += ' c_baccarat_pref__c, ' ;
		soql6 += ' i_profitable_pct__c, ' ;
		soql6 += ' c_convienence_cd__c, ' ;
		soql6 += ' i_lodging_pct__c, ' ;
		soql6 += ' c_channel_rec__c, ' ;
		soql6 += ' c_dom_market_cd__c, ' ;
		//soql6 += ' c_gst_prop_dm_optout_flag__c, ' ;	
		soql6 += ' c_tdc_supp_flag__c, ';	
		soql6 += ' c_prop_cd_1__c, ' ;
		soql6 += ' i_prop_pct_worth_1__c, ' ;
		soql6 += ' c_prop_cd_2__c, ' ;
		soql6 += ' i_prop_pct_worth_2__c, ' ;
		soql6 += ' c_pref_prop_host_cd__c, ' ;
		soql6 += ' c_host_type__c, ' ;
		soql6 += ' i_age__c, ' ;
		soql6 += ' c_gender__c, ' ;
		soql6 += ' c_dom_cd_prop__c, ' ;	
		soql6 += ' c_pref_prop_cd__c, ' ;
		soql6 += ' c_geo_dm_zone__c, ' ;
		soql6 += ' c_geo_rpt_zone__c, ' ;
		soql6 += ' c_distance_cluster__c, ' ;
		soql6 += ' c_msa_cd__c, ' ;
		soql6 += ' c_msa__c, ' ;
		soql6 += ' c_zip_7_pdb__c, ' ;
		soql6 += ' d_create_dt_mkt__c, ' ;
		soql6 += ' d_create_dt_ent__c, ' ;
		soql6 += ' f_act_all_ap_pdb_12mn_plus__c, ' ;	
		soql6 += ' f_theo_all_ap_pdb_12mn_plus__c, ' ;
		soql6 += ' i_days_rtd_ap_pdb_12mn_plus__c, ' ;
		soql6 += ' f_daily_theo_ap_pdb_12mnplus__c, ' ;
		soql6 += ' f_daily_act_ap_pdb_12mn_plus__c, ' ;
		soql6 += ' f_daily_wrth_ap_pdb_12mnplus__c, ' ;
		soql6 += ' f_resp_rate_ap_pdb_12mn_plus__c, ' ;
		soql6 += ' f_ofr_trp_pct_ap_pdb12mnplus__c, ' ;
		soql6 += ' f_htlsty_pct_ap_pdb_12mnplus__c, ' ;
		soql6 += ' f_slot_pct_ap_pdb_12mn_plus__c, ' ;
		soql6 += ' f_trp_all_adj_sc_pdb_12mn__c, ' ;
		soql6 += ' f_trp_rtd_adj_sc_pdb_12mn__c, ' ;
		soql6 += ' f_act_all_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' f_theo_all_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' i_days_rtd_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' f_daily_theo_ap_pdb_24mnplus__c, ' ;
		soql6 += ' f_daily_act_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' f_daily_wrth_ap_pdb_24mnplus__c, ' ;
		soql6 += ' f_resp_rate_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' f_ofr_trp_pct_ap_pdb24mnplus__c, ' ;
		soql6 += ' f_htlsty_pct_ap_pdb_24mnplus__c, ' ;
		soql6 += ' f_slot_pct_ap_pdb_24mn_plus__c, ' ;
		soql6 += ' f_trp_all_adj_sc_pdb_24mn__c, ' ;
		soql6 += ' f_trp_rtd_adj_sc_pdb_24mn__c, ' ;
		soql6 += ' f_trp_all_adj_sc_pdb_36mn__c, ' ;
		soql6 += ' f_trp_rtd_adj_sc_pdb_36mn__c, ' ;
		soql6 += ' f_profit_pct_ent__c, ' ;
		soql6 += ' c_profit_flag_ent__c, ' ;
		soql6 += ' f_profit_pct_mkt__c, ' ;
		soql6 += ' c_profit_flag_mkt__c, ' ;
		soql6 += ' i_age_adj_ah__c, ' ;
		soql6 += ' i_dob_mn_adj_ah__c, ' ;
		soql6 += ' i_dob_yr_adj_ah__c, ' ;
		soql6 += ' c_country_cd_ah__c, ' ;
		soql6 += ' c_credit_status_flag__c, ' ;
		soql6 += ' c_mkt_host_cd_adj_ah__c, ' ;
		soql6 += ' c_dom_prop_host_cd_adj_ah__c, ' ;	
		soql6 += ' c_prop_cd_1_host_cd_adj_ah__c, ' ;
		soql6 += ' c_zip_7_ah__c, ' ;
		soql6 += ' f_tier_score_ah__c, ' ;
		soql6 += ' f_lodging_pct_mkt_adj_ah__c, ' ;	
		soql6 += ' f_pct_bacarrat_mkt_ah__c, ' ;
		soql6 += ' f_pct_blackjack_mkt_ah__c, ' ;
		soql6 += ' f_pct_craps_mkt_ah__c, ' ;
		soql6 += ' f_pct_other_mkt_ah__c, ' ;
		soql6 += ' f_pct_paigow_mkt_ah__c, ' ;
		soql6 += ' f_pct_roulette_mkt_ah__c, ' ;
		soql6 += ' f_pct_video_poker_mkt_ah__c, ' ;
		soql6 += ' c_future_res_flag_mkt_ah__c, ' ;
		soql6 += ' f_worth_1mn_ap_ah__c, ' ;
		soql6 += ' f_worth_3mn_ap_ah__c, ' ;
		soql6 += ' f_worth_6mn_ap_ah__c, ' ;
		soql6 += ' f_theo_all_1mn_ap_ah__c, ' ;
		soql6 += ' f_theo_all_3mn_ap_ah__c, ' ;
		soql6 += ' f_theo_all_6mn_ap_ah__c, ' ;
		soql6 += ' f_theo_all_12mn_ap_ah__c, ' ;
		soql6 += ' f_theo_all_ytd_ap_ah__c, ' ;
		soql6 += ' f_theo_slot_1mn_ap_ah__c, ' ;
		soql6 += ' f_theo_slot_3mn_ap_ah__c, ' ;
		soql6 += ' f_theo_slot_6mn_ap_ah__c, ' ;
		soql6 += ' f_theo_slot_12mn_ap_ah__c, ' ;
		soql6 += ' f_theo_table_1mn_ap_ah__c, ' ;
		soql6 += ' f_theo_table_3mn_ap_ah__c, ' ;
		soql6 += ' f_theo_table_6mn_ap_ah__c, ' ;
		soql6 += ' f_theo_table_12mn_ap_ah__c, ' ;
		soql6 += ' f_act_all_1mn_ap_ah__c, ' ;
		soql6 += ' f_act_all_3mn_ap_ah__c, ' ;
		soql6 += ' f_act_all_6mn_ap_ah__c, ' ;
		soql6 += ' f_act_all_12mn_ap_ah__c, ' ;
		soql6 += ' f_actual_all_ytd_ap_ah__c, ' ;
		soql6 += ' f_avgbet_game_1mn_ap_ah__c, ' ;
		soql6 += ' f_avgbet_game_3mn_ap_ah__c, ' ;
		soql6 += ' f_avgbet_game_6mn_ap_ah__c, ' ;
		soql6 += ' f_avgbet_game_12mn_ap_ah__c, ' ;
		soql6 += ' i_lop_game_1mn_ap_ah__c, ' ;
		soql6 += ' i_lop_game_3mn_ap_ah__c, ' ;
		soql6 += ' i_lop_game_6mn_ap_ah__c, ' ;
		soql6 += ' i_lop_game_12mn_ap_ah__c, ' ;
		soql6 += ' i_trp_all_cms_1mn_ap_ah__c, ' ;
		soql6 += ' i_trp_all_cms_3mn_ap_ah__c, ' ;
		soql6 += ' i_trp_all_cms_6mn_ap_ah__c, ' ;
		soql6 += ' i_trp_all_cms_12mn_ap_ah__c, ' ;
		soql6 += ' i_trp_rtd_1mn_ap_ah__c, ' ;
		soql6 += ' i_trp_rtd_3mn_ap_ah__c, ' ;
		soql6 += ' i_trp_rtd_6mn_ap_ah__c, ' ;
		soql6 += ' i_trp_rtd_12mn_ap_ah__c, ' ;
		soql6 += ' i_days_rtd_1mn_ap_ah__c, ' ;
		soql6 += ' i_days_rtd_3mn_ap_ah__c, ' ;
		soql6 += ' i_days_rtd_6mn_ap_ah__c, ' ;
		soql6 += ' i_days_rtd_12mn_ap_ah__c, ' ;
		soql6 += ' d_last_rated_dt_mkt_ah__c, ' ;
		soql6 += ' f_rc_earned_1mn_mkt_ah__c, ' ;
		soql6 += ' f_rc_earned_3mn_mkt_ah__c, ' ;
		soql6 += ' f_rc_earned_6mn_mkt_ah__c, ' ;
		soql6 += ' f_rc_earned_12mn_mkt_ah__c, ' ;
		soql6 += ' d_first_gaming_dt_mkt_ah__c, ' ;
		soql6 += ' d_first_gaming_dt_ent_ah__c, ' ;
		soql6 += ' d_first_dt_played_mkt_ah__c, ' ;
		soql6 += ' f_act_all_cms_first_hr_m_ah__c, ' ;
		soql6 += ' f_act_all_cms_first_day_m_ah__c, ' ;
		soql6 += ' f_act_all_cms_first_trp_m_ah__c, ' ;
		soql6 += ' i_lop_first_hr_mkt_ah__c, ' ;
		soql6 += ' i_lop_first_day_mkt_ah__c, ' ;
		soql6 += ' i_lop_first_trp_mkt_ah__c, ' ;
		soql6 += ' c_convienence_cd_new__c, ' ;
		soql6 += ' c_recency__c, ' ;
		soql6 += ' c_frequency_tc__c, ' ;
		soql6 += ' c_frequency_ttm_24__c, ' ;
		soql6 += ' c_tierscore_desc__c, ' ;
		soql6 += ' f_hotel_adw__c, ' ;
		soql6 += ' c_hotel_adw_break__c, ' ;	
		soql6 += ' c_frequency_ttm__c, ' ;
		soql6 += ' c_avg_day_hotel_flag__c, ' ;
		soql6 += ' i_days_since_last__c, ' ;
		soql6 += ' f_trip_cycle_48__c, ' ;
		soql6 += ' c_frequency_tc_12__c, ' ;
		soql6 += ' f_trip_cycle_12__c, ' ;
		soql6 += ' i_ttm_trip_cnt_12__c, ' ;
		soql6 += ' i_ttm_trip_cnt_24__c, ' ;
		soql6 += ' c_adw_trip_break_12__c, ' ;
		soql6 += ' f_adw_trip_12__c, ' ;
		soql6 += ' c_adw_trip_break_6__c, ' ;
		soql6 += ' f_adw_trip_6__c, ' ;
		soql6 += ' c_adw_break_48__c, ' ;
		soql6 += ' f_adw_48__c, ' ;
		soql6 += ' c_adw_break_24__c, ' ;	
		soql6 += ' f_adw_24__c, ' ;
		soql6 += ' c_adw_break_15__c, ' ;	
		soql6 += ' f_adw_15__c, ' ;
		soql6 += ' c_adw_break_12__c, ' ;	
		soql6 += ' f_adw_12__c, ' ;
		soql6 += ' c_hotel_adw_break_48__c, ' ;	
		soql6 += ' f_hotel_adw_48__c, ' ;
		soql6 += ' c_hotel_adw_break_24__c, ' ;
		soql6 += ' f_hotel_adw_24__c, ' ;
		soql6 += ' c_hotel_adw_break_15__c, ' ;
		soql6 += ' f_hotel_adw_15__c, ' ;
		soql6 += ' c_hotel_adw_break_12__c, ' ;
		soql6 += ' f_hotel_adw_12__c, ' ;
		soql6 += ' c_last_gaming_trip__c, ' ;
		soql6 += ' i_days_since_gaming__c, ' ;
		soql6 += ' i_email_decile__c ' ;

		soql6 += ' FROM marketing_campaigns_properties__x  ';
		if (idType == 'contact') {
				soql6 += whereClause + ': allContactIds';
			} else {
				soql6 += whereClause + ': ids';
			}

		soql6 = String.escapeSingleQuotes(soql6);

		//
		// need to run several SOQLs due to error if too many external data source are
		// used in a SOQL
		//
		List<marketing_campaigns_properties__x> mktCampaignsPropList;
		if (idType == 'external'){
			mktCampaignsPropList = (!mockedPropRequests.isEmpty()) ? mockedPropRequests : Database.query(soql1);
		  	updateMarketingCampaignProp (mktCampaignsPropMap, mktCampaignsPropList, '1');

		  	mktCampaignsPropList = (!mockedPropRequests.isEmpty()) ? mockedPropRequests : Database.query(soql2);
		  	updateMarketingCampaignProp (mktCampaignsPropMap, mktCampaignsPropList, '2');

		  	mktCampaignsPropList = (!mockedPropRequests.isEmpty()) ? mockedPropRequests : Database.query(soql3);  	
		  	updateMarketingCampaignProp (mktCampaignsPropMap, mktCampaignsPropList, '3');

		  	mktCampaignsPropList = (!mockedPropRequests.isEmpty()) ? mockedPropRequests : Database.query(soql6);  	
		  	updateMarketingCampaignProp (mktCampaignsPropMap, mktCampaignsPropList, '6');
		  } else {
		  	mktCampaignsPropList = (!mockedPropRequests.isEmpty()) ? mockedPropRequests : Database.query(soql5);  	
		  	updateMarketingCampaignProp (mktCampaignsPropMap, mktCampaignsPropList, '5');
		  }

	  	system.debug('*** mktCampaignsPropMap return ' + mktCampaignsPropMap.values());

	  	return mktCampaignsPropMap.values();
	}

	/*******************************************************************************************************
    * @description Update the MarketingCampaignPropertyWrapper with soql results
    * @param Map<String, MarketingCampaignPropertyWrapper> mktCampaignsPropMap
    * @param List<marketing_campaigns_properties__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<MarketingCampaignPropertyWrapper> containing the updated data
    * @example
    * 	GuestShelfDataCC.updateMarketingCampaignProp(Map<String, MarketingCampaignPropertyWrapper> mktCampaignsPropMap,
	*				 List<marketing_campaigns_properties__x> mktCampaignsPropList, String pass);
    */
	private static void updateMarketingCampaignProp (Map<String, MarketingCampaignPropertyWrapper> mktCampaignsPropMap, 
		List<marketing_campaigns_properties__x> mktCampaignsPropList, String pass){
		MarketingCampaignPropertyWrapper mcw;
		GuestShelfData2CC ghfCC = new GuestShelfData2CC();

		for (marketing_campaigns_properties__x mktCampaignProp : mktCampaignsPropList ){
	  		if (!mktCampaignsPropMap.containsKey(mktCampaignProp.ExternalId)) {
	  			mktCampaignsPropMap.put(mktCampaignProp.ExternalId, new MarketingCampaignPropertyWrapper());
	  		}
	  		mcw = mktCampaignsPropMap.get(mktCampaignProp.ExternalId);
	  		if (pass == '1'){
	  			mcw = mktCampaignsPropMap.get(mktCampaignProp.ExternalId);
	  			mcw.ExternalId = mktCampaignProp.ExternalId;
		  		mcw.c_acct_type_cd_fk = mktCampaignProp.c_acct_type_cd_fk__c;
		  		mcw.c_acct_type_cd_fk_Name = mktCampaignProp.c_acct_type_cd_fk__r.Name;
		  		mcw.c_acct_type_cd_fk_Description = mktCampaignProp.c_acct_type_cd_fk__r.Description__c;
		  		mcw.c_acct_type_cd_fk_Quality_code = mktCampaignProp.c_acct_type_cd_fk__r.Quality_code__c;
		  		mcw.c_acct_type_cd_fk_Type_category = mktCampaignProp.c_acct_type_cd_fk__r.Type_category__c;
		  		mcw.c_acct_type_cd_fk_Type_Id = mktCampaignProp.c_acct_type_cd_fk__r.Type_Id__c;
		  		mcw.c_campaign_cd_fk = mktCampaignProp.c_campaign_cd_fk__c;
		  		mcw.c_campaign_cd_fk_Name = mktCampaignProp.c_campaign_cd_fk__r.Name;
		  		mcw.c_campaign_cd_fk_Description = mktCampaignProp.c_campaign_cd_fk__r.Description__c;
		  		mcw.c_campaign_cd_fk_In_use = mktCampaignProp.c_campaign_cd_fk__r.In_use__c;
		  		mcw.c_campaign_type_fk = mktCampaignProp.c_campaign_type_fk__c;
		  		mcw.c_campaign_type_fk_Name = mktCampaignProp.c_campaign_type_fk__r.Name;
		  		mcw.c_campaign_type_fk_Description = mktCampaignProp.c_campaign_type_fk__r.Description__c;
		  		mcw.contact = mktCampaignProp.contact__c;
		  	}
		  	if (pass == '2'){
		  		mcw.c_dom_cd_prop_fk = mktCampaignProp.c_dom_cd_prop_fk__c;
		  		mcw.c_dom_cd_prop_fk_Name = mktCampaignProp.c_dom_cd_prop_fk__r.Name;
		  		mcw.c_dom_market_cd_fk = mktCampaignProp.c_dom_market_cd_fk__c;
		  		mcw.c_dom_market_cd_fk_Name = mktCampaignProp.c_dom_market_cd_fk__r.Name;
		  		mcw.c_dom_market_cd_fk_Active_Flag = mktCampaignProp.c_dom_market_cd_fk__r.Active_Flag__c;
		  		mcw.c_dom_market_cd_fk_Description = mktCampaignProp.c_dom_market_cd_fk__r.Description__c;
		  		mcw.c_dom_market_cd_fk_Direct_Marketing_Center_Name = mktCampaignProp.c_dom_market_cd_fk__r.Direct_Marketing_Center__r.Name;
		  		mcw.c_dom_market_cd_fk_Market_Code = mktCampaignProp.c_dom_market_cd_fk__r.Market_Code__c;
		  		mcw.c_dom_market_cd_fk_POD = mktCampaignProp.c_dom_market_cd_fk__r.POD__r.Description__c;
		  		mcw.c_dom_market_cd_fk_Time_Zone = mktCampaignProp.c_dom_market_cd_fk__r.Time_Zone__c;
		  		mcw.c_dom_pref_prop_cd_fk = mktCampaignProp.c_dom_pref_prop_cd_fk__c;
		  		mcw.c_dom_pref_prop_cd_fk_Name = mktCampaignProp.c_dom_pref_prop_cd_fk__r.Name;
		  	}
		  	if (pass == '3'){
		  		mcw.c_pref_prop_cd_fk = mktCampaignProp.c_pref_prop_cd_fk__c;
		  		mcw.c_pref_prop_cd_fk_Name = mktCampaignProp.c_pref_prop_cd_fk__r.Name;
		  		mcw.c_prop_cd_fk= mktCampaignProp.c_prop_cd_fk__c;
		  		mcw.c_prop_cd_fk_Name = mktCampaignProp.c_prop_cd_fk__r.Name;
		  		mcw.c_prop_cd_2_fk = mktCampaignProp.c_prop_cd_2_fk__c;
		  		mcw.c_prop_cd_2_fk_Name = mktCampaignProp.c_prop_cd_2_fk__r.Name;
		  		mcw.c_worth_break = mktCampaignProp.c_worth_break__c;
		  		mcw.f_property_worth = mktCampaignProp.f_property_worth__c;
		  	}
		  	if (pass == '5'){
		  		mcw.ExternalId = mktCampaignProp.ExternalId;
			  //	mcw. = mktCampaign.c_prop_market_cd_fk__c;
				mcw.c_prop_market_cd_Name =mktCampaignProp.c_prop_market_cd__c;
				//mcw. =mktCampaign.c_dom_pref_prop_cd_fk__c;
				mcw.c_dom_pref_prop_cd_Name =mktCampaignProp.c_dom_pref_prop_cd__c;
				mcw.d_last_activity_dt =ghfCC.stripTime(mktCampaignProp.d_last_activity_dt__c);

				mcw.c_worth_break =mktCampaignProp.c_worth_break__c; 
				mcw.f_worth =mktCampaignProp.f_worth__c ;
				mcw.f_worth_12mn_ap_ah =mktCampaignProp.f_worth_12mn_ap_ah__c;
				mcw.f_worth_all_ytd_ap_ah =mktCampaignProp.f_worth_all_ytd_ap_ah__c;
				mcw.c_frequency =mktCampaignProp.c_frequency__c;
				mcw.i_trp_rtd_ap_pdb_12mn_plus =mktCampaignProp.i_trp_rtd_ap_pdb_12mn_plus__c;
				mcw.i_trp_rtd_ap_pdb_24mn_plus =mktCampaignProp.i_trp_rtd_ap_pdb_24mn_plus__c;
				mcw.c_game_pref =mktCampaignProp.c_game_pref__c;
				mcw.c_drive_distance_cluster =mktCampaignProp.c_drive_distance_cluster__c;
				mcw.d_min_est_dt = ghfCC.stripTime(mktCampaignProp.d_min_est_dt__c);
				mcw.c_campaign_type =mktCampaignProp.c_campaign_type__c;
				mcw.c_campaign_cd =mktCampaignProp.c_campaign_cd__c;
				mcw.c_campaign_desc =mktCampaignProp.c_campaign_desc__c;
				mcw.subCampaign = mktCampaignProp.c_campaign_cd__c + '-' + mktCampaignProp.c_campaign_desc__c;
			}
			if (pass == '6'){
		  		mcw.ExternalId = mktCampaignProp.ExternalId;
				mcw.c_campaign_desc= mktCampaignProp.c_campaign_desc__c ;
				mcw.c_campaign_type= mktCampaignProp.c_campaign_type__c ;	
				mcw.c_campaign_type_desc= mktCampaignProp.c_campaign_type_desc__c ;
				mcw.d_campaign_score_dt= mktCampaignProp.d_campaign_score_dt__c ;
				mcw.c_version_cd= mktCampaignProp.c_version_cd__c ;
				mcw.c_acct_type_cd= mktCampaignProp.c_acct_type_cd__c ;
				mcw.c_prop_market_cd= mktCampaignProp.c_prop_market_cd__c ;
				mcw.c_dom_pref_prop_cd= mktCampaignProp.c_dom_pref_prop_cd__c ;
				mcw.c_tier_cd= mktCampaignProp.c_tier_cd__c ;
				mcw.c_marketing_state_cd= mktCampaignProp.c_marketing_state_cd__c ;	
				mcw.c_regulatory_state_cd= mktCampaignProp.c_regulatory_state_cd__c ;	
				mcw.i_random_1= mktCampaignProp.i_random_1__c ;
				mcw.i_random_2= mktCampaignProp.i_random_2__c ;
				mcw.i_random_static_yr= mktCampaignProp.i_random_static_yr__c ;
				mcw.c_main_ethnic_type= mktCampaignProp.c_main_ethnic_type__c ;	
				mcw.c_ethnic_group1= mktCampaignProp.c_main_ethnic_type__c ;
				mcw.c_preferred_written_language= mktCampaignProp.c_preferred_written_language__c ;
				mcw.c_prop_mail_cd= mktCampaignProp.c_prop_mail_cd__c ;
				mcw.c_emailable= mktCampaignProp.c_emailable__c ;
				mcw.c_mailable= mktCampaignProp.c_mailable__c ;
				mcw.c_channel_pref= mktCampaignProp.c_channel_pref__c ;
				mcw.c_uk_res_supress= mktCampaignProp.c_uk_res_supress__c ;
				mcw.c_id_verified= mktCampaignProp.c_id_verified__c ;
				mcw.c_age_18_plus= mktCampaignProp.c_age_18_plus__c ;
				mcw.c_age_19_plus= mktCampaignProp.c_age_19_plus__c ;
				mcw.c_age_21_plus= mktCampaignProp.c_age_21_plus__c ;
				mcw.c_ucl_supp_flag= mktCampaignProp.c_ucl_supp_flag__c ;
				mcw.c_uci_supp_flag= mktCampaignProp.c_uci_supp_flag__c ;
				mcw.c_video_poker_pref= mktCampaignProp.c_video_poker_pref__c ;	
				mcw.c_baccarat_pref= mktCampaignProp.c_baccarat_pref__c ;
				mcw.i_profitable_pct= mktCampaignProp.i_profitable_pct__c ;
				mcw.c_convienence_cd= mktCampaignProp.c_convienence_cd__c ;
				mcw.i_lodging_pct= mktCampaignProp.i_lodging_pct__c ;
				mcw.c_channel_rec= mktCampaignProp.c_channel_rec__c ;
				mcw.c_dom_market_cd= mktCampaignProp.c_dom_market_cd__c ;
				//mcw.c_gst_prop_dm_optout_flag= mktCampaignProp.c_gst_prop_dm_optout_flag__c ;	
				mcw.c_tdc_supp_flag= mktCampaignProp.c_tdc_supp_flag__c;	
				mcw.c_prop_cd_1= mktCampaignProp.c_prop_cd_1__c ;
				mcw.i_prop_pct_worth_1= mktCampaignProp.i_prop_pct_worth_1__c ;
				mcw.c_prop_cd_2= mktCampaignProp.c_prop_cd_2__c ;
				mcw.i_prop_pct_worth_2= mktCampaignProp.i_prop_pct_worth_2__c ;
				mcw.c_pref_prop_host_cd= mktCampaignProp.c_pref_prop_host_cd__c ;
				mcw.c_host_type= mktCampaignProp.c_host_type__c ;
				mcw.i_age= mktCampaignProp.i_age__c ;
				mcw.c_gender= mktCampaignProp.c_gender__c ;
				mcw.c_dom_cd_prop= mktCampaignProp.c_dom_cd_prop__c ;	
				mcw.c_pref_prop_cd= mktCampaignProp.c_pref_prop_cd__c ;
				mcw.c_geo_dm_zone= mktCampaignProp.c_geo_dm_zone__c ;
				mcw.c_geo_rpt_zone= mktCampaignProp.c_geo_rpt_zone__c ;
				mcw.c_distance_cluster= mktCampaignProp.c_distance_cluster__c ;
				mcw.c_msa_cd= mktCampaignProp.c_msa_cd__c ;
				mcw.c_msa= mktCampaignProp.c_msa__c ;
				mcw.c_zip_7_pdb= mktCampaignProp.c_zip_7_pdb__c ;
				mcw.d_create_dt_mkt= mktCampaignProp.d_create_dt_mkt__c ;
				mcw.d_create_dt_ent= mktCampaignProp.d_create_dt_ent__c ;
				mcw.f_act_all_ap_pdb_12mn_plus= mktCampaignProp.f_act_all_ap_pdb_12mn_plus__c ;	
				mcw.f_theo_all_ap_pdb_12mn_plus= mktCampaignProp.f_theo_all_ap_pdb_12mn_plus__c ;
				mcw.i_days_rtd_ap_pdb_12mn_plus= mktCampaignProp.i_days_rtd_ap_pdb_12mn_plus__c ;
				mcw.f_daily_theo_ap_pdb_12mnplus= mktCampaignProp.f_daily_theo_ap_pdb_12mnplus__c ;
				mcw.f_daily_act_ap_pdb_12mn_plus= mktCampaignProp.f_daily_act_ap_pdb_12mn_plus__c ;
				mcw.f_daily_wrth_ap_pdb_12mnplus= mktCampaignProp.f_daily_wrth_ap_pdb_12mnplus__c ;
				mcw.f_resp_rate_ap_pdb_12mn_plus= mktCampaignProp.f_resp_rate_ap_pdb_12mn_plus__c ;
				mcw.f_ofr_trp_pct_ap_pdb12mnplus= mktCampaignProp.f_ofr_trp_pct_ap_pdb12mnplus__c ;
				mcw.f_htlsty_pct_ap_pdb_12mnplus= mktCampaignProp.f_htlsty_pct_ap_pdb_12mnplus__c ;
				mcw.f_slot_pct_ap_pdb_12mn_plus= mktCampaignProp.f_slot_pct_ap_pdb_12mn_plus__c ;
				mcw.f_trp_all_adj_sc_pdb_12mn= mktCampaignProp.f_trp_all_adj_sc_pdb_12mn__c ;
				mcw.f_trp_rtd_adj_sc_pdb_12mn= mktCampaignProp.f_trp_rtd_adj_sc_pdb_12mn__c ;
				mcw.f_act_all_ap_pdb_24mn_plus= mktCampaignProp.f_act_all_ap_pdb_24mn_plus__c ;
				mcw.f_theo_all_ap_pdb_24mn_plus= mktCampaignProp.f_theo_all_ap_pdb_24mn_plus__c ;
				mcw.i_days_rtd_ap_pdb_24mn_plus= mktCampaignProp.i_days_rtd_ap_pdb_24mn_plus__c ;
				mcw.f_daily_theo_ap_pdb_24mnplus= mktCampaignProp.f_daily_theo_ap_pdb_24mnplus__c ;
				mcw.f_daily_act_ap_pdb_24mn_plus= mktCampaignProp.f_daily_act_ap_pdb_24mn_plus__c ;
				mcw.f_daily_wrth_ap_pdb_24mnplus= mktCampaignProp.f_daily_wrth_ap_pdb_24mnplus__c ;
				mcw.f_resp_rate_ap_pdb_24mn_plus= mktCampaignProp.f_resp_rate_ap_pdb_24mn_plus__c ;
				mcw.f_ofr_trp_pct_ap_pdb24mnplus= mktCampaignProp.f_ofr_trp_pct_ap_pdb24mnplus__c ;
				mcw.f_htlsty_pct_ap_pdb_24mnplus= mktCampaignProp.f_htlsty_pct_ap_pdb_24mnplus__c ;
				mcw.f_slot_pct_ap_pdb_24mn_plus= mktCampaignProp.f_slot_pct_ap_pdb_24mn_plus__c ;
				mcw.f_trp_all_adj_sc_pdb_24mn= mktCampaignProp.f_trp_all_adj_sc_pdb_24mn__c ;
				mcw.f_trp_rtd_adj_sc_pdb_24mn= mktCampaignProp.f_trp_rtd_adj_sc_pdb_24mn__c ;
				mcw.f_trp_all_adj_sc_pdb_36mn= mktCampaignProp.f_trp_all_adj_sc_pdb_36mn__c ;
				mcw.f_trp_rtd_adj_sc_pdb_36mn= mktCampaignProp.f_trp_rtd_adj_sc_pdb_36mn__c ;
				mcw.f_profit_pct_ent= mktCampaignProp.f_profit_pct_ent__c ;
				mcw.c_profit_flag_ent= mktCampaignProp.c_profit_flag_ent__c ;
				mcw.f_profit_pct_mkt= mktCampaignProp.f_profit_pct_mkt__c ;
				mcw.c_profit_flag_mkt= mktCampaignProp.c_profit_flag_mkt__c ;
				mcw.i_age_adj_ah= mktCampaignProp.i_age_adj_ah__c ;
				mcw.i_dob_mn_adj_ah= mktCampaignProp.i_dob_mn_adj_ah__c ;
				mcw.i_dob_yr_adj_ah= mktCampaignProp.i_dob_yr_adj_ah__c ;
				mcw.c_country_cd_ah= mktCampaignProp.c_country_cd_ah__c ;
				mcw.c_credit_status_flag= mktCampaignProp.c_credit_status_flag__c ;
				mcw.c_mkt_host_cd_adj_ah= mktCampaignProp.c_mkt_host_cd_adj_ah__c ;
				mcw.c_dom_prop_host_cd_adj_ah= mktCampaignProp.c_dom_prop_host_cd_adj_ah__c ;	
				mcw.c_prop_cd_1_host_cd_adj_ah= mktCampaignProp.c_prop_cd_1_host_cd_adj_ah__c ;
				mcw.c_zip_7_ah= mktCampaignProp.c_zip_7_ah__c ;
				mcw.f_tier_score_ah= mktCampaignProp.f_tier_score_ah__c ;
				mcw.f_lodging_pct_mkt_adj_ah= mktCampaignProp.f_lodging_pct_mkt_adj_ah__c ;	
				mcw.f_pct_bacarrat_mkt_ah= mktCampaignProp.f_pct_bacarrat_mkt_ah__c ;
				mcw.f_pct_blackjack_mkt_ah= mktCampaignProp.f_pct_blackjack_mkt_ah__c ;
				mcw.f_pct_craps_mkt_ah= mktCampaignProp.f_pct_craps_mkt_ah__c ;
				mcw.f_pct_other_mkt_ah= mktCampaignProp.f_pct_other_mkt_ah__c ;
				mcw.f_pct_paigow_mkt_ah= mktCampaignProp.f_pct_paigow_mkt_ah__c ;
				mcw.f_pct_roulette_mkt_ah= mktCampaignProp.f_pct_roulette_mkt_ah__c ;
				mcw.f_pct_video_poker_mkt_ah= mktCampaignProp.f_pct_video_poker_mkt_ah__c ;
				mcw.c_future_res_flag_mkt_ah= mktCampaignProp.c_future_res_flag_mkt_ah__c ;
				mcw.f_worth_1mn_ap_ah= mktCampaignProp.f_worth_1mn_ap_ah__c ;
				mcw.f_worth_3mn_ap_ah= mktCampaignProp.f_worth_3mn_ap_ah__c ;
				mcw.f_worth_6mn_ap_ah= mktCampaignProp.f_worth_6mn_ap_ah__c ;
				mcw.f_theo_all_1mn_ap_ah= mktCampaignProp.f_theo_all_1mn_ap_ah__c ;
				mcw.f_theo_all_3mn_ap_ah= mktCampaignProp.f_theo_all_3mn_ap_ah__c ;
				mcw.f_theo_all_6mn_ap_ah= mktCampaignProp.f_theo_all_6mn_ap_ah__c ;
				mcw.f_theo_all_12mn_ap_ah= mktCampaignProp.f_theo_all_12mn_ap_ah__c ;
				mcw.f_theo_all_ytd_ap_ah= mktCampaignProp.f_theo_all_ytd_ap_ah__c ;
				mcw.f_theo_slot_1mn_ap_ah= mktCampaignProp.f_theo_slot_1mn_ap_ah__c ;
				mcw.f_theo_slot_3mn_ap_ah= mktCampaignProp.f_theo_slot_3mn_ap_ah__c ;
				mcw.f_theo_slot_6mn_ap_ah= mktCampaignProp.f_theo_slot_6mn_ap_ah__c;
				mcw.f_theo_slot_12mn_ap_ah= mktCampaignProp.f_theo_slot_12mn_ap_ah__c ;
				mcw.f_theo_table_1mn_ap_ah= mktCampaignProp.f_theo_table_1mn_ap_ah__c ;
				mcw.f_theo_table_3mn_ap_ah= mktCampaignProp.f_theo_table_3mn_ap_ah__c ;
				mcw.f_theo_table_6mn_ap_ah= mktCampaignProp.f_theo_table_6mn_ap_ah__c ;
				mcw.f_theo_table_12mn_ap_ah= mktCampaignProp.f_theo_table_12mn_ap_ah__c ;
				mcw.f_act_all_1mn_ap_ah= mktCampaignProp.f_act_all_1mn_ap_ah__c ;
				mcw.f_act_all_3mn_ap_ah= mktCampaignProp.f_act_all_3mn_ap_ah__c ;
				mcw.f_act_all_6mn_ap_ah= mktCampaignProp.f_act_all_6mn_ap_ah__c ;
				mcw.f_act_all_12mn_ap_ah= mktCampaignProp.f_act_all_12mn_ap_ah__c;
				mcw.f_actual_all_ytd_ap_ah= mktCampaignProp.f_actual_all_ytd_ap_ah__c ;
				mcw.f_avgbet_game_1mn_ap_ah= mktCampaignProp.f_avgbet_game_1mn_ap_ah__c ;
				mcw.f_avgbet_game_3mn_ap_ah= mktCampaignProp.f_avgbet_game_3mn_ap_ah__c ;
				mcw.f_avgbet_game_6mn_ap_ah= mktCampaignProp.f_avgbet_game_6mn_ap_ah__c ;
				mcw.f_avgbet_game_12mn_ap_ah= mktCampaignProp.f_avgbet_game_12mn_ap_ah__c ;
				mcw.i_lop_game_1mn_ap_ah= mktCampaignProp.i_lop_game_1mn_ap_ah__c ;
				mcw.i_lop_game_3mn_ap_ah= mktCampaignProp.i_lop_game_3mn_ap_ah__c ;
				mcw.i_lop_game_6mn_ap_ah= mktCampaignProp.i_lop_game_6mn_ap_ah__c ;
				mcw.i_lop_game_12mn_ap_ah= mktCampaignProp.i_lop_game_12mn_ap_ah__c ;
				mcw.i_trp_all_cms_1mn_ap_ah= mktCampaignProp.i_trp_all_cms_1mn_ap_ah__c ;
				mcw.i_trp_all_cms_3mn_ap_ah= mktCampaignProp.i_trp_all_cms_3mn_ap_ah__c ;
				mcw.i_trp_all_cms_6mn_ap_ah= mktCampaignProp.i_trp_all_cms_6mn_ap_ah__c ;
				mcw.i_trp_all_cms_12mn_ap_ah= mktCampaignProp.i_trp_all_cms_12mn_ap_ah__c ;
				mcw.i_trp_rtd_1mn_ap_ah= mktCampaignProp.i_trp_rtd_1mn_ap_ah__c ;
				mcw.i_trp_rtd_3mn_ap_ah= mktCampaignProp.i_trp_rtd_3mn_ap_ah__c ;
				mcw.i_trp_rtd_6mn_ap_ah= mktCampaignProp.i_trp_rtd_6mn_ap_ah__c;
				mcw.i_trp_rtd_12mn_ap_ah= mktCampaignProp.i_trp_rtd_12mn_ap_ah__c ;
				mcw.i_days_rtd_1mn_ap_ah= mktCampaignProp.i_days_rtd_1mn_ap_ah__c ;
				mcw.i_days_rtd_3mn_ap_ah= mktCampaignProp.i_days_rtd_3mn_ap_ah__c ;
				mcw.i_days_rtd_6mn_ap_ah= mktCampaignProp.i_days_rtd_6mn_ap_ah__c ;
				mcw.i_days_rtd_12mn_ap_ah= mktCampaignProp.i_days_rtd_12mn_ap_ah__c ;
				mcw.d_last_rated_dt_mkt_ah= mktCampaignProp.d_last_rated_dt_mkt_ah__c ;
				mcw.f_rc_earned_1mn_mkt_ah= mktCampaignProp.f_rc_earned_1mn_mkt_ah__c ;
				mcw.f_rc_earned_3mn_mkt_ah= mktCampaignProp.f_rc_earned_3mn_mkt_ah__c ;
				mcw.f_rc_earned_6mn_mkt_ah= mktCampaignProp.f_rc_earned_6mn_mkt_ah__c ;
				mcw.f_rc_earned_12mn_mkt_ah= mktCampaignProp.f_rc_earned_12mn_mkt_ah__c ;
				mcw.d_first_gaming_dt_mkt_ah= mktCampaignProp.d_first_gaming_dt_mkt_ah__c ;
				mcw.d_first_gaming_dt_ent_ah= mktCampaignProp.d_first_gaming_dt_ent_ah__c ;
				mcw.d_first_dt_played_mkt_ah= mktCampaignProp.d_first_dt_played_mkt_ah__c ;
				mcw.f_act_all_cms_first_hr_m_ah= mktCampaignProp.f_act_all_cms_first_hr_m_ah__c ;
				mcw.f_act_all_cms_first_day_m_ah= mktCampaignProp.f_act_all_cms_first_day_m_ah__c ;
				mcw.f_act_all_cms_first_trp_m_ah= mktCampaignProp.f_act_all_cms_first_trp_m_ah__c ;
				mcw.i_lop_first_hr_mkt_ah= mktCampaignProp.i_lop_first_hr_mkt_ah__c ;
				mcw.i_lop_first_day_mkt_ah= mktCampaignProp.i_lop_first_day_mkt_ah__c ;
				mcw.i_lop_first_trp_mkt_ah= mktCampaignProp.i_lop_first_trp_mkt_ah__c ;
				mcw.c_convienence_cd_new= mktCampaignProp.c_convienence_cd_new__c ;
				mcw.c_recency= mktCampaignProp.c_recency__c ;
				mcw.c_frequency_tc= mktCampaignProp.c_frequency_tc__c ;
				mcw.c_frequency_ttm_24= mktCampaignProp.c_frequency_ttm_24__c ;
				mcw.c_tierscore_desc= mktCampaignProp.c_tierscore_desc__c ;
				mcw.f_hotel_adw= mktCampaignProp.f_hotel_adw__c ;
				mcw.c_hotel_adw_break= mktCampaignProp.c_hotel_adw_break__c ;	
				mcw.c_frequency_ttm= mktCampaignProp.c_frequency_ttm__c ;
				mcw.c_avg_day_hotel_flag= mktCampaignProp.c_avg_day_hotel_flag__c ;
				mcw.i_days_since_last= mktCampaignProp.i_days_since_last__c ;
				mcw.f_trip_cycle_48= mktCampaignProp.f_trip_cycle_48__c ;
				mcw.c_frequency_tc_12= mktCampaignProp.c_frequency_tc_12__c ;
				mcw.f_trip_cycle_12= mktCampaignProp.f_trip_cycle_12__c ;
				mcw.i_ttm_trip_cnt_12= mktCampaignProp.i_ttm_trip_cnt_12__c ;
				mcw.i_ttm_trip_cnt_24= mktCampaignProp.i_ttm_trip_cnt_24__c ;
				mcw.c_adw_trip_break_12= mktCampaignProp.c_adw_trip_break_12__c ;
				mcw.f_adw_trip_12= mktCampaignProp.f_adw_trip_12__c ;
				mcw.c_adw_trip_break_6= mktCampaignProp.c_adw_trip_break_6__c ;
				mcw.f_adw_trip_6= mktCampaignProp.f_adw_trip_6__c ;
				mcw.c_adw_break_48= mktCampaignProp.c_adw_break_48__c ;
				mcw.f_adw_48= mktCampaignProp.f_adw_48__c ;
				mcw.c_adw_break_24= mktCampaignProp.c_adw_break_24__c ;	
				mcw.f_adw_24= mktCampaignProp.f_adw_24__c ;
				mcw.c_adw_break_15= mktCampaignProp.c_adw_break_15__c ;	
				mcw.f_adw_15= mktCampaignProp.f_adw_15__c ;
				mcw.c_adw_break_12= mktCampaignProp.c_adw_break_12__c ;	
				mcw.f_adw_12= mktCampaignProp.f_adw_12__c ;
				mcw.c_hotel_adw_break_48= mktCampaignProp.c_hotel_adw_break_48__c ;	
				mcw.f_hotel_adw_48= mktCampaignProp.f_hotel_adw_48__c ;
				mcw.c_hotel_adw_break_24= mktCampaignProp.c_hotel_adw_break_24__c ;
				mcw.f_hotel_adw_24= mktCampaignProp.f_hotel_adw_24__c ;
				mcw.c_hotel_adw_break_15= mktCampaignProp.c_hotel_adw_break_15__c ;
				mcw.f_hotel_adw_15= mktCampaignProp.f_hotel_adw_15__c ;
				mcw.c_hotel_adw_break_12= mktCampaignProp.c_hotel_adw_break_12__c ;
				mcw.f_hotel_adw_12= mktCampaignProp.f_hotel_adw_12__c ;
				mcw.c_last_gaming_trip= mktCampaignProp.c_last_gaming_trip__c ;
				mcw.i_days_since_gaming= mktCampaignProp.i_days_since_gaming__c ;
				mcw.i_email_decile= mktCampaignProp.i_email_decile__c ;
		  	}

		  	mktCampaignsPropMap.put(mktCampaignProp.ExternalId, mcw);
	  	}
	}


	/*******************************************************************************************************
    * @description Retrieve the external data for Enterprise Campaign as view only
    * @param List<Id> of Contact Ids used to retrieve the Enterprise Campaign data
    * @return List<EnterpriseCampaignWrapper> containing the retrieved data
    * @example
    * List<GuestShelfDataCC.EnterpriseCampaignWrapper>  enterpriseCampaignList = 
	*   		GuestShelfDataCC.retrieveEnterpriseCampaign(List<Id> contactIds);
    */
	@RemoteAction
	@AuraEnabled
	global static List<EnterpriseCampaignWrapper> retrieveEnterpriseDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = ' WHERE ExternalId in';
		String idType = 'external';
		return retrieveEnterpriseCampaign(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<EnterpriseCampaignWrapper> retrieveEnterpriseByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		String idType = 'contact';
		return retrieveEnterpriseCampaign(contactIds, whereClause, idType);
	}

	private static List<EnterpriseCampaignWrapper> retrieveEnterpriseCampaign(List<String> ids, String whereClause, String idType) {
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged activities
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new GuestShelfData2CC()).getConsXrefIds(ids);
		}
		String soql1 = ' SELECT ExternalId, ';
	   	soql1 += ' f_actual_all_all_mkts__c, ';
		soql1 += ' i_all_days_all_mkts__c, ';
		soql1 += ' i_cms_rated_trips_all_mkts__c, ';
		soql1 += ' contact__c, ';
		soql1 += ' i_hotel_trips_all_mkts__c, ';
		soql1 += ' i_dmid__c, ';
		soql1 += ' id__c, ';
		soql1 += ' f_mdw_all_all_mkts__c, ';
		soql1 += ' f_mdw_rated_all_mkts__c, ';
		soql1 += ' i_minutes_all_mkts__c, ';
		soql1 += ' i_offer_trips_all_mkts__c, ';
		soql1 += ' i_pdb_rated_trips_all_mkts__c, ';
		soql1 += ' i_pdb_trips_all_mkts__c, ';
		soql1 += ' i_rated_days_all_mkts__c, ';
		soql1 += ' f_theo_all_all_mkts__c ';
		soql1 += ' FROM enterprise_campaign__x ';
	  	if (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}

	  	soql1 = String.escapeSingleQuotes(soql1);

		Map<String, EnterpriseCampaignWrapper> enterpriseCampaignMap = new Map<String, EnterpriseCampaignWrapper> ();

		List<enterprise_campaign__x> enterpriseCampaignsList = (!mockedEnterpriseRequests.isEmpty()) ? mockedEnterpriseRequests : Database.query(soql1);
	  	updateMarketingEnterprise (enterpriseCampaignMap, enterpriseCampaignsList, '1');

	  	system.debug('*** enterpriseCampaignMap return ' + enterpriseCampaignMap.values());

	  	return enterpriseCampaignMap.values();
	}

	/*******************************************************************************************************
    * @description Update the EnterpriseCampaignWrapper with soql results
    * @param Map<String, EnterpriseCampaignWrapper> enterpriseCampaignMap
    * @param List<enterprise_campaign__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<EnterpriseCampaignWrapper> containing the updated data
    * @example
    * 	GuestShelfDataCC.updateMarketingEnterprise(Map<String, EnterpriseCampaignWrapper> enterpriseCampaignMap,
	*				 List<enterprise_campaign__x> enterpriseCampaignsList, String pass);
    */
	private static void updateMarketingEnterprise (Map<String, EnterpriseCampaignWrapper> enterpriseCampaignMap, 
							List<enterprise_campaign__x> enterpriseCampaignsList, String pass){
		EnterpriseCampaignWrapper mcw;

		for (enterprise_campaign__x mktEnterprise : enterpriseCampaignsList ){
	  		if (!enterpriseCampaignMap.containsKey(mktEnterprise.ExternalId)) {
	  			enterpriseCampaignMap.put(mktEnterprise.ExternalId, new EnterpriseCampaignWrapper());
	  		}
	  		mcw = enterpriseCampaignMap.get(mktEnterprise.ExternalId);
	  		if (pass == '1'){
		  		mcw.ExternalId = mktEnterprise.ExternalId;
		  		mcw.f_actual_all_all_mkts = mktEnterprise.f_actual_all_all_mkts__c;
				mcw.i_all_days_all_mkts = mktEnterprise.i_all_days_all_mkts__c;
				mcw.i_cms_rated_trips_all_mkts = mktEnterprise.i_cms_rated_trips_all_mkts__c;
				mcw.i_hotel_trips_all_mkts = mktEnterprise.i_hotel_trips_all_mkts__c;
				mcw.i_dmid = mktEnterprise.i_dmid__c;
				mcw.id = mktEnterprise.id__c;
				mcw.f_mdw_all_all_mkts = mktEnterprise.f_mdw_all_all_mkts__c;
				mcw.f_mdw_rated_all_mkts = mktEnterprise.f_mdw_rated_all_mkts__c;
				mcw.i_minutes_all_mkts = mktEnterprise.i_minutes_all_mkts__c;
				mcw.i_offer_trips_all_mkts = mktEnterprise.i_offer_trips_all_mkts__c;
				mcw.i_pdb_rated_trips_all_mkts = mktEnterprise.i_pdb_rated_trips_all_mkts__c;
				mcw.i_pdb_trips_all_mkts = mktEnterprise.i_pdb_trips_all_mkts__c;
				mcw.i_rated_days_all_mkts = mktEnterprise.i_rated_days_all_mkts__c;
				mcw.f_theo_all_all_mkts = mktEnterprise.f_theo_all_all_mkts__c;
		  		mcw.contact = mktEnterprise.contact__c;
	  		}
	  		enterpriseCampaignMap.put(mktEnterprise.ExternalId, mcw);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the external data for Marketing Campaign Weekly as view only
    * @param List<Id> of Contact Ids used to retrieve the Marketing Campaign Weekly data
    * @return List<MarketingCampaignWeeklyWrapper> containing the retrieve data
    * @example
    * List<GuestShelfData_CC.MarketingCampaignsWeeklyWrapper>  marketingCampaignWeeklyList = 
	*   		GuestShelfData_CC.retrieveMarketingCampaignWeekly(List<Id> contactIds);
    */
	
	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignWeeklyWrapper> retrieveWeeklyDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = ' WHERE ExternalId in';
		String idType = 'external';
		return retrieveMarketingCampaignWeekly(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignWeeklyWrapper> retrieveWeeklyByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		String idType = 'contact';
		return retrieveMarketingCampaignWeekly(contactIds, whereClause, idType);
	}

	private static List<MarketingCampaignWeeklyWrapper> retrieveMarketingCampaignWeekly(List<String> ids, String whereClause, String idType) {
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged activities
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new GuestShelfData2CC()).getConsXrefIds(ids);
		}
		String soql1 = ' SELECT ExternalId, ';
	   	soql1 += ' c_acct_type_cd_fk__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Name, ';
	  	soql1 += ' c_acct_type_cd_fk__r.Description__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Quality_code__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Type_category__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Type_Id__c, ';
	  	soql1 += ' c_campaign_type_fk__c, ';
	  	soql1 += ' c_campaign_type_fk__r.Name, ';
	  	soql1 += ' c_campaign_type_fk__r.Description__c, ';
	  	soql1 += ' contact__c ';
	  	soql1 += ' FROM marketing_campaigns_weekly__x  ';
	  	if (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}

	  	soql1 = String.escapeSingleQuotes(soql1);

	  	String soql2 = ' SELECT ExternalId,	 ';   				
	  	soql2 += ' c_prop_market_cd_fk__c, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Name, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Active_Flag__c, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Description__c, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Direct_Marketing_Center__r.Name, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Market_Code__c, ';
	  	soql2 += ' c_prop_market_cd_fk__r.POD__c, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Time_Zone__c ';
	  	soql2 += ' FROM marketing_campaigns_weekly__x  ';
	  	if (idType == 'contact') {
			soql2 += whereClause + ': allContactIds';
		} else {
			soql2 += whereClause + ': ids';
		}

	  	soql2 = String.escapeSingleQuotes(soql2);

	  	String soql3 = ' SELECT ExternalId,	 ';  				
	  	soql3 += ' c_prop_cd_1_fk__c, ';
	  	soql3 += ' c_prop_cd_1_fk__r.Name, ';
	  	soql3 += ' c_prop_cd_2_fk__c, ';
	  	soql3 += ' c_prop_cd_2_fk__r.Name, ';
	  	soql3 += ' c_tier_cd_fk__c, ';
	  	soql3 += ' c_tier_cd_fk__r.Name ';
	  	soql3 += ' FROM marketing_campaigns_weekly__x  ';
	  	if (idType == 'contact') {
			soql3 += whereClause + ': allContactIds';
		} else {
			soql3 += whereClause + ': ids';
		}

	  	soql3 = String.escapeSingleQuotes(soql3);

		Map<String, MarketingCampaignWeeklyWrapper> mktCampaignsWeeklyMap = new Map<String, MarketingCampaignWeeklyWrapper> ();

		//
		// need to run several SOQLs due to error if too many external data source are
		// used in a SOQL
		//
		List<marketing_campaigns_weekly__x> mktCampaignsWeeklyList = (!mockedWeeklyRequests.isEmpty()) ? mockedWeeklyRequests : Database.query(soql1);
		updateMarketingWeekly (mktCampaignsWeeklyMap, mktCampaignsWeeklyList, '1');

	  	mktCampaignsWeeklyList = (!mockedWeeklyRequests.isEmpty()) ? mockedWeeklyRequests : Database.query(soql2);
	  	updateMarketingWeekly (mktCampaignsWeeklyMap, mktCampaignsWeeklyList, '2');

	  	mktCampaignsWeeklyList = (!mockedWeeklyRequests.isEmpty()) ? mockedWeeklyRequests : Database.query(soql3);
	  	updateMarketingWeekly (mktCampaignsWeeklyMap, mktCampaignsWeeklyList, '3');

	  	system.debug('*** mktCampaignsWeeklyMap return ' + mktCampaignsWeeklyMap.values());

	  	return mktCampaignsWeeklyMap.values();
	}

	/*******************************************************************************************************
    * @description Update the MarketingCampaignWeeklyWrapper with soql results
    * @param Map<String, MarketingCampaignWeeklyWrapper> mktCampaignsWeeklyMap
    * @param List<marketing_campaigns_weekly__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<MarketingCampaignWeeklyWrapper> containing the updated data
    * @example
    * 	GuestShelfDataCC.updateMarketingWeekly(Map<String, MarketingCampaignWeeklyWrapper> mktCampaignsWeeklyMap,
	*				 List<marketing_campaigns_weekly__x> mktCampaignsWeeklyList, String pass);
    */
	private static void updateMarketingWeekly (Map<String, MarketingCampaignWeeklyWrapper> mktCampaignsWeeklyMap, 
							List<marketing_campaigns_weekly__x> mktCampaignsWeeklyList, String pass){
		MarketingCampaignWeeklyWrapper mcw;

		for (marketing_campaigns_weekly__x mktWeekly : mktCampaignsWeeklyList ){
	  		if (!mktCampaignsWeeklyMap.containsKey(mktWeekly.ExternalId)) {
	  			mktCampaignsWeeklyMap.put(mktWeekly.ExternalId, new MarketingCampaignWeeklyWrapper());
	  		}
	  		mcw = mktCampaignsWeeklyMap.get(mktWeekly.ExternalId);
	  		if (pass == '1'){
		  		mcw.ExternalId = mktWeekly.ExternalId;
		  		mcw.c_acct_type_cd_fk = mktWeekly.c_acct_type_cd_fk__c;
		  		mcw.c_acct_type_cd_fk_Name = mktWeekly.c_acct_type_cd_fk__r.Name;
		  		mcw.c_acct_type_cd_fk_Description = mktWeekly.c_acct_type_cd_fk__r.Description__c;
		  		mcw.c_acct_type_cd_fk_Quality_code = mktWeekly.c_acct_type_cd_fk__r.Quality_code__c;
		  		mcw.c_acct_type_cd_fk_Type_category = mktWeekly.c_acct_type_cd_fk__r.Type_category__c;
		  		mcw.c_acct_type_cd_fk_Type_Id = mktWeekly.c_acct_type_cd_fk__r.Type_Id__c;
		  		mcw.c_campaign_type_fk = mktWeekly.c_campaign_type_fk__c;
		  		mcw.c_campaign_type_fk_Name = mktWeekly.c_campaign_type_fk__r.Name;
		  		mcw.c_campaign_type_fk_Description = mktWeekly.c_campaign_type_fk__r.Description__c;
		  		mcw.contact = mktWeekly.contact__c;		  		
	  		}
	  		if (pass == '2'){
	  			mcw.c_prop_market_cd_fk = mktWeekly.c_prop_market_cd_fk__c;
		  		mcw.c_prop_market_cd_fk_Name = mktWeekly.c_prop_market_cd_fk__r.Name;
		  		mcw.c_prop_market_cd_fk_Active_Flag = mktWeekly.c_prop_market_cd_fk__r.Active_Flag__c;
		  		mcw.c_prop_market_cd_fk_Description = mktWeekly.c_prop_market_cd_fk__r.Description__c;
		  		mcw.c_prop_market_cd_fk_Direct_Marketing_Center_Name = mktWeekly.c_prop_market_cd_fk__r.Direct_Marketing_Center__r.Name;
		  		mcw.c_prop_market_cd_fk_Market_Code = mktWeekly.c_prop_market_cd_fk__r.Market_Code__c;
		  		mcw.c_prop_market_cd_fk_POD = mktWeekly.c_prop_market_cd_fk__r.POD__c;
		  		mcw.c_prop_market_cd_fk_Time_Zone = mktWeekly.c_prop_market_cd_fk__r.Time_Zone__c;
	  		}
	  		if (pass == '3'){
	  			mcw.c_prop_cd_1_fk= mktWeekly.c_prop_cd_1_fk__c;
		  		mcw.c_prop_cd_1_fk_Name = mktWeekly.c_prop_cd_1_fk__r.Name;
		  		mcw.c_prop_cd_2_fk = mktWeekly.c_prop_cd_2_fk__c;
		  		mcw.c_prop_cd_2_fk_Name = mktWeekly.c_prop_cd_2_fk__r.Name;
		  		mcw.c_tier_cd_fk = mktWeekly.c_tier_cd_fk__c;
		  		mcw.c_tier_cd_fk_Name = mktWeekly.c_tier_cd_fk__r.Name;
	  		}
	  		mktCampaignsWeeklyMap.put(mktWeekly.ExternalId, mcw);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the external data for Marketing LVM as view only
    * @param List<Id> of Contact Ids used to retrieve the Marketing LVM data
    * @return List<MarketingCampaignsLVMWrapper> containing the retrieve data
    * @example
    * List<GuestShelfDataCC.MarketingCampaignsLVMWrapper>  marketingCampaignLVMList = 
	*   		GuestShelfDataCC.retrieveMarketingCampaignLVM(List<Id> contactIds);
    */
	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignsLVMWrapper> retrieveLVMDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = ' WHERE ExternalId in';
		String idType= 'external';
		return retrieveMarketingCampaignLVM(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignsLVMWrapper> retrieveLVMByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		String idType= 'contact';
		return retrieveMarketingCampaignLVM(contactIds, whereClause, idType);
	}

	private static List<MarketingCampaignsLVMWrapper> retrieveMarketingCampaignLVM(List<String> ids, String whereClause, String idType) {
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged activities
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new GuestShelfData2CC()).getConsXrefIds(ids);
		}
		String soql1 = ' SELECT ExternalId, ';
	   	soql1 += ' c_acct_type_cd_fk__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Name, ';
	  	soql1 += ' c_acct_type_cd_fk__r.Description__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Quality_code__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Type_category__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Type_Id__c, ';
	  	soql1 += ' contact__c ';
	  	soql1 += ' FROM marketing_lvm__x  ';
	  	If (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}

	  	soql1 = String.escapeSingleQuotes(soql1);

	  	String soql2 = 	' SELECT ExternalId, ';	   				
	  	soql2 += ' c_prop_market_cd_fk__c, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Name, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Active_Flag__c, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Description__c, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Direct_Marketing_Center__r.Name, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Market_Code__c, ';
	  	soql2 += ' c_prop_market_cd_fk__r.POD__c, ';
	  	soql2 += ' c_prop_market_cd_fk__r.Time_Zone__c, ';
	  	soql2 += ' c_dom_pref_prop_cd_fk__c, ';
	  	soql2 += ' c_dom_pref_prop_cd_fk__r.Name, ';
	  	soql2 += ' c_tier_cd_fk__c, ';
	  	soql2 += ' c_tier_cd_fk__r.Name ';
	  	soql2 += ' FROM marketing_lvm__x  ';
	  	if (idType == 'contact') {
			soql2 += whereClause + ': allContactIds';
		} else {
			soql2 += whereClause + ': ids';
		}

	  	soql2 = String.escapeSingleQuotes(soql2);

		Map<String, MarketingCampaignsLVMWrapper> mktCampaignsLVMMap = new Map<String, MarketingCampaignsLVMWrapper> ();

		//
		// need to run several SOQLs due to error if too many external data source are
		// used in a SOQL
		//
		List<marketing_lvm__x> mktCampaignsLVMList = (!mockedLVMRequests.isEmpty()) ? mockedLVMRequests : Database.query(soql1);
	  	updateMarketingLVM (mktCampaignsLVMMap, mktCampaignsLVMList, '1');

	  	mktCampaignsLVMList = (!mockedLVMRequests.isEmpty()) ? mockedLVMRequests : Database.query(soql2);
	  	updateMarketingLVM (mktCampaignsLVMMap, mktCampaignsLVMList, '2');

	  	system.debug('*** mktCampaignsLVMMap return ' + mktCampaignsLVMMap.values());

	  	return mktCampaignsLVMMap.values();
	}

	/*******************************************************************************************************
    * @description Update the MarketingCampaignsLVMWrapper with soql results
    * @param Map<String, MarketingCampaignsLVMWrapper> mktCampaignsLVMMap
    * @param List<marketing_lvm__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<MarketingCampaignsLVMWrapper> containing the updated data
    * @example
    * 	GuestShelfDataCC.updateMarketingLVM(Map<String, MarketingCampaignsLVMWrapper> mktCampaignsLVMMap,
	*				 List<marketing_lvm__x> mktCampaignsLVMList, String pass);
    */
	private static void updateMarketingLVM(Map<String, MarketingCampaignsLVMWrapper> mktCampaignsLVMMap, 
							List<marketing_lvm__x> mktCampaignsLVMList, String pass){
		MarketingCampaignsLVMWrapper mcw;

		for (marketing_lvm__x mktLVM: mktCampaignsLVMList ){
	  		if (!mktCampaignsLVMMap.containsKey(mktLVM.ExternalId)) {
	  			mktCampaignsLVMMap.put(mktLVM.ExternalId, new MarketingCampaignsLVMWrapper());
	  		}
	  		mcw = mktCampaignsLVMMap.get(mktLVM.ExternalId);
	  		if (pass == '1'){
		  		mcw.ExternalId = mktLVM.ExternalId;
		  		mcw.c_acct_type_cd_fk = mktLVM.c_acct_type_cd_fk__c;
		  		mcw.c_acct_type_cd_fk_Name = mktLVM.c_acct_type_cd_fk__r.Name;
		  		mcw.c_acct_type_cd_fk_Description = mktLVM.c_acct_type_cd_fk__r.Description__c;
		  		mcw.c_acct_type_cd_fk_Quality_code = mktLVM.c_acct_type_cd_fk__r.Quality_code__c;
		  		mcw.c_acct_type_cd_fk_Type_category = mktLVM.c_acct_type_cd_fk__r.Type_category__c;
		  		mcw.c_acct_type_cd_fk_Type_Id = mktLVM.c_acct_type_cd_fk__r.Type_Id__c;
		  		mcw.contact = mktLVM.contact__c;
	  		}
	  		if (pass == '2'){
	  			mcw.c_prop_market_cd_fk = mktLVM.c_prop_market_cd_fk__c;
		  		mcw.c_prop_market_cd_fk_Name = mktLVM.c_prop_market_cd_fk__r.Name;
		  		mcw.c_prop_market_cd_fk_Active_Flag = mktLVM.c_prop_market_cd_fk__r.Active_Flag__c;
		  		mcw.c_prop_market_cd_fk_Description = mktLVM.c_prop_market_cd_fk__r.Description__c;
		  		mcw.c_prop_market_cd_fk_Direct_Marketing_Center_Name = mktLVM.c_prop_market_cd_fk__r.Direct_Marketing_Center__r.Name;
		  		mcw.c_prop_market_cd_fk_Market_Code = mktLVM.c_prop_market_cd_fk__r.Market_Code__c;
		  		mcw.c_prop_market_cd_fk_POD = mktLVM.c_prop_market_cd_fk__r.POD__c;
		  		mcw.c_prop_market_cd_fk_Time_Zone = mktLVM.c_prop_market_cd_fk__r.Time_Zone__c;
		  		mcw.c_dom_pref_prop_cd_fk = mktLVM.c_dom_pref_prop_cd_fk__c;
		  		mcw.c_dom_pref_prop_cd_fk_Name = mktLVM.c_dom_pref_prop_cd_fk__r.Name;
		  		mcw.c_tier_cd_fk = mktLVM.c_tier_cd_fk__c;
		  		mcw.c_tier_cd_fk_Name = mktLVM.c_tier_cd_fk__r.Name;
		  	}
	  		
	  		mktCampaignsLVMMap.put(mktLVM.ExternalId, mcw);
	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for Marketing Campaigns
    */
	global class MarketingCampaignWrapper {
		@AuraEnabled global String ExternalId { get; set; }
	    @AuraEnabled global String c_acct_type_cd_fk { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Name { get; set;}
	  	@AuraEnabled global String c_acct_type_cd_fk_Description { get; set; } 
	  	@AuraEnabled global String c_acct_type_cd_fk_Quality_code { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Type_category { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Type_Id { get; set; }
	  	@AuraEnabled global String c_campaign_cd_fk { get; set; } 
	  	@AuraEnabled global String c_campaign_cd_fk_Name { get; set; }
	  	@AuraEnabled global String c_campaign_cd_fk_Description { get; set; }
	    @AuraEnabled global Boolean c_campaign_cd_fk_In_use { get; set; }
	  	@AuraEnabled global String c_campaign_type_fk { get; set; }
	  	@AuraEnabled global String c_campaign_type_fk_Name { get; set; }
	  	@AuraEnabled global String c_campaign_type_fk_Description { get; set; }
	  	@AuraEnabled global String contact { get; set; }
	  	@AuraEnabled global String c_dom_cd_prop_fk { get; set; }
	  	@AuraEnabled global String c_dom_cd_prop_fk_Name { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_Name { get; set; }
	  	@AuraEnabled global Boolean c_dom_market_cd_fk_Active_Flag { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_Description { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_Direct_Marketing_Center_Name { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_Market_Code { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_POD { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_Time_Zone { get; set; }
	  	@AuraEnabled global String c_dom_pref_prop_cd_fk { get; set; }
	  	@AuraEnabled global String c_dom_pref_prop_cd_fk_Name { get; set; }
	  	@AuraEnabled global String c_pref_prop_cd_fk { get; set; }
	  	@AuraEnabled global String c_pref_prop_cd_fk_Name { get; set; }
	  	@AuraEnabled global String c_prop_cd_1_fk { get; set; }
	  	@AuraEnabled global String c_prop_cd_1_fk_Name { get; set; }
	  	@AuraEnabled global String c_prop_cd_2_fk { get; set; }
	  	@AuraEnabled global String c_prop_cd_2_fk_Name { get; set; }
	  	@AuraEnabled global String c_tier_cd_fk { get; set; }
	  	@AuraEnabled global String c_tier_cd_fk_Name { get; set; }
	  	@AuraEnabled global Decimal f_worth { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_Name { get; set; }
	  	@AuraEnabled global String c_dom_pref_prop_cd_Name { get; set; }
	  	@AuraEnabled global String d_last_activity_dt { get; set; }
	  	@AuraEnabled global String c_worth_break { get; set; }
	  	@AuraEnabled global Decimal f_worth_12mn_ap_ah { get; set; }
	  	@AuraEnabled global DEcimal f_worth_all_ytd_ap_ah { get; set; }
	  	@AuraEnabled global String c_frequency { get; set; }
	  	@AuraEnabled global Decimal i_trp_rtd_ap_pdb_12mn_plus { get; set; }
	  	@AuraEnabled global Decimal i_trp_rtd_ap_pdb_24mn_plus { get; set; }
	  	@AuraEnabled global String c_game_pref { get; set; }
	  	@AuraEnabled global String c_drive_distance_cluster { get; set; }
	  	@AuraEnabled global String d_min_est_dt { get; set; }
	  	@AuraEnabled global String c_campaign_type { get; set; }
	  	@AuraEnabled global String c_campaign_cd { get; set; }
	  	@AuraEnabled global String c_campaign_desc { get; set; }
	  	@AuraEnabled global String subCampaign { get; set; }

@AuraEnabled global String c_campaign_type_desc { get; set; }
@AuraEnabled global String d_campaign_score_dt { get; set; }
@AuraEnabled global String c_version_cd { get; set; }
@AuraEnabled global String c_acct_type_cd { get; set; }
@AuraEnabled global String c_prop_market_cd { get; set; }
@AuraEnabled global String c_dom_pref_prop_cd { get; set; }
@AuraEnabled global String c_tier_cd { get; set; }
@AuraEnabled global String c_marketing_state_cd { get; set; }
@AuraEnabled global String c_regulatory_state_cd { get; set; }
@AuraEnabled global Decimal i_random_1 { get; set; }
@AuraEnabled global Decimal i_random_2 { get; set; }
@AuraEnabled global Decimal i_random_static_yr { get; set; }
@AuraEnabled global String c_main_ethnic_type { get; set; }
@AuraEnabled global String c_ethnic_group1 { get; set; }
@AuraEnabled global String c_preferred_written_language { get; set; }
@AuraEnabled global String c_prop_mail_cd { get; set; }
@AuraEnabled global String c_emailable { get; set; }
@AuraEnabled global String c_mailable { get; set; }
@AuraEnabled global String c_channel_pref { get; set; }
@AuraEnabled global String c_uk_res_supress { get; set; }
@AuraEnabled global String c_id_verified { get; set; }
@AuraEnabled global String c_age_18_plus { get; set; }
@AuraEnabled global String c_age_19_plus { get; set; }
@AuraEnabled global String c_age_21_plus { get; set; }
@AuraEnabled global String c_ucl_supp_flag { get; set; }
@AuraEnabled global String c_uci_supp_flag { get; set; }
@AuraEnabled global String c_video_poker_pref { get; set; }
@AuraEnabled global String c_baccarat_pref { get; set; }
@AuraEnabled global Decimal i_profitable_pct { get; set; }
@AuraEnabled global String c_convienence_cd { get; set; }
@AuraEnabled global Decimal i_lodging_pct { get; set; }
@AuraEnabled global String c_channel_rec { get; set; }
@AuraEnabled global String c_dom_market_cd { get; set; }
@AuraEnabled global String c_gst_prop_dm_optout_flag { get; set; }
@AuraEnabled global String c_tdc_supp_flag { get; set; }
@AuraEnabled global String c_prop_cd_1 { get; set; }
@AuraEnabled global Decimal i_prop_pct_worth_1 { get; set; }
@AuraEnabled global String c_prop_cd_2 { get; set; }
@AuraEnabled global Decimal i_prop_pct_worth_2 { get; set; }
@AuraEnabled global String c_pref_prop_host_cd { get; set; }
@AuraEnabled global String c_host_type { get; set; }
@AuraEnabled global Decimal i_age { get; set; }
@AuraEnabled global String c_gender { get; set; }
@AuraEnabled global String c_dom_cd_prop { get; set; }
@AuraEnabled global String c_pref_prop_cd { get; set; }
@AuraEnabled global String c_geo_dm_zone { get; set; }
@AuraEnabled global String c_geo_rpt_zone { get; set; }
@AuraEnabled global String c_distance_cluster { get; set; }
@AuraEnabled global String c_msa_cd { get; set; }
@AuraEnabled global String c_msa { get; set; }
@AuraEnabled global String c_zip_7_pdb { get; set; }
@AuraEnabled global String d_create_dt_mkt { get; set; }
@AuraEnabled global String d_create_dt_ent { get; set; }
@AuraEnabled global Decimal f_act_all_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal f_theo_all_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal i_days_rtd_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal f_daily_theo_ap_pdb_12mnplus { get; set; }
@AuraEnabled global Decimal f_daily_act_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal f_daily_wrth_ap_pdb_12mnplus { get; set; }
@AuraEnabled global Decimal f_resp_rate_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal f_ofr_trp_pct_ap_pdb12mnplus { get; set; }
@AuraEnabled global Decimal f_htlsty_pct_ap_pdb_12mnplus { get; set; }
@AuraEnabled global Decimal f_slot_pct_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal f_trp_all_adj_sc_pdb_12mn { get; set; }
@AuraEnabled global Decimal f_trp_rtd_adj_sc_pdb_12mn { get; set; }
@AuraEnabled global Decimal f_act_all_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal f_theo_all_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal i_days_rtd_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal f_daily_theo_ap_pdb_24mnplus { get; set; }
@AuraEnabled global Decimal f_daily_act_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal f_daily_wrth_ap_pdb_24mnplus { get; set; }
@AuraEnabled global Decimal f_resp_rate_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal f_ofr_trp_pct_ap_pdb24mnplus { get; set; }
@AuraEnabled global Decimal f_htlsty_pct_ap_pdb_24mnplus { get; set; }
@AuraEnabled global Decimal f_slot_pct_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal f_trp_all_adj_sc_pdb_24mn { get; set; }
@AuraEnabled global Decimal f_trp_rtd_adj_sc_pdb_24mn { get; set; }
@AuraEnabled global Decimal f_trp_all_adj_sc_pdb_36mn { get; set; }
@AuraEnabled global Decimal f_trp_rtd_adj_sc_pdb_36mn { get; set; }
@AuraEnabled global Decimal f_profit_pct_ent { get; set; }
@AuraEnabled global String c_profit_flag_ent { get; set; }
@AuraEnabled global Decimal f_profit_pct_mkt { get; set; }
@AuraEnabled global String c_profit_flag_mkt { get; set; }
@AuraEnabled global Decimal i_age_adj_ah { get; set; }
@AuraEnabled global Decimal i_dob_mn_adj_ah { get; set; }
@AuraEnabled global Decimal i_dob_yr_adj_ah { get; set; }
@AuraEnabled global String c_country_cd_ah { get; set; }
@AuraEnabled global String c_credit_status_flag { get; set; }
@AuraEnabled global String c_mkt_host_cd_adj_ah { get; set; }
@AuraEnabled global String c_dom_prop_host_cd_adj_ah { get; set; }
@AuraEnabled global String c_prop_cd_1_host_cd_adj_ah { get; set; }
@AuraEnabled global String c_zip_7_ah { get; set; }
@AuraEnabled global Decimal f_tier_score_ah { get; set; }
@AuraEnabled global Decimal f_lodging_pct_mkt_adj_ah { get; set; }
@AuraEnabled global Decimal f_pct_bacarrat_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_blackjack_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_craps_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_other_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_paigow_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_roulette_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_video_poker_mkt_ah { get; set; }
@AuraEnabled global String c_future_res_flag_mkt_ah { get; set; }
@AuraEnabled global Decimal f_worth_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_worth_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_worth_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_all_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_all_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_all_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_all_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_all_ytd_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_slot_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_slot_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_slot_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_slot_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_table_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_table_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_table_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_table_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_act_all_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_act_all_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_act_all_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_act_all_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_actual_all_ytd_ap_ah { get; set; }
@AuraEnabled global Decimal f_avgbet_game_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_avgbet_game_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_avgbet_game_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_avgbet_game_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_lop_game_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_lop_game_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_lop_game_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_lop_game_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_all_cms_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_all_cms_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_all_cms_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_all_cms_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_rtd_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_rtd_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_rtd_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_rtd_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_days_rtd_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_days_rtd_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_days_rtd_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_days_rtd_12mn_ap_ah { get; set; }
@AuraEnabled global String d_last_rated_dt_mkt_ah { get; set; }
@AuraEnabled global Decimal f_rc_earned_1mn_mkt_ah { get; set; }
@AuraEnabled global Decimal f_rc_earned_3mn_mkt_ah { get; set; }
@AuraEnabled global Decimal f_rc_earned_6mn_mkt_ah { get; set; }
@AuraEnabled global Decimal f_rc_earned_12mn_mkt_ah { get; set; }
@AuraEnabled global String d_first_gaming_dt_mkt_ah { get; set; }
@AuraEnabled global String d_first_gaming_dt_ent_ah { get; set; }
@AuraEnabled global String d_first_dt_played_mkt_ah { get; set; }
@AuraEnabled global Decimal f_act_all_cms_first_hr_m_ah { get; set; }
@AuraEnabled global Decimal f_act_all_cms_first_day_m_ah { get; set; }
@AuraEnabled global Decimal f_act_all_cms_first_trp_m_ah { get; set; }
@AuraEnabled global Decimal i_lop_first_hr_mkt_ah { get; set; }
@AuraEnabled global Decimal i_lop_first_day_mkt_ah { get; set; }
@AuraEnabled global Decimal i_lop_first_trp_mkt_ah { get; set; }
@AuraEnabled global String c_convienence_cd_new { get; set; }
@AuraEnabled global String c_recency { get; set; }
@AuraEnabled global String c_frequency_tc { get; set; }
@AuraEnabled global String c_frequency_ttm_24 { get; set; }
@AuraEnabled global String c_tierscore_desc { get; set; }
@AuraEnabled global Decimal f_hotel_adw { get; set; }
@AuraEnabled global String c_hotel_adw_break { get; set; }
@AuraEnabled global String c_frequency_ttm { get; set; }
@AuraEnabled global String c_avg_day_hotel_flag { get; set; }
@AuraEnabled global Decimal i_days_since_last { get; set; }
@AuraEnabled global Decimal f_trip_cycle_48 { get; set; }
@AuraEnabled global String c_frequency_tc_12 { get; set; }
@AuraEnabled global Decimal f_trip_cycle_12 { get; set; }
@AuraEnabled global Decimal i_ttm_trip_cnt_12 { get; set; }
@AuraEnabled global Decimal i_ttm_trip_cnt_24 { get; set; }
@AuraEnabled global String c_adw_trip_break_12 { get; set; }
@AuraEnabled global Decimal f_adw_trip_12 { get; set; }
@AuraEnabled global String c_adw_trip_break_6 { get; set; }
@AuraEnabled global Decimal f_adw_trip_6 { get; set; }
@AuraEnabled global String c_adw_break_48 { get; set; }
@AuraEnabled global Decimal f_adw_48 { get; set; }
@AuraEnabled global String c_adw_break_24 { get; set; }
@AuraEnabled global Decimal f_adw_24 { get; set; }
@AuraEnabled global String c_adw_break_15 { get; set; }
@AuraEnabled global Decimal f_adw_15 { get; set; }
@AuraEnabled global String c_adw_break_12 { get; set; }
@AuraEnabled global Decimal f_adw_12 { get; set; }
@AuraEnabled global String c_hotel_adw_break_48 { get; set; }
@AuraEnabled global Decimal f_hotel_adw_48 { get; set; }
@AuraEnabled global String c_hotel_adw_break_24 { get; set; }
@AuraEnabled global Decimal f_hotel_adw_24 { get; set; }
@AuraEnabled global String c_hotel_adw_break_15 { get; set; }
@AuraEnabled global Decimal f_hotel_adw_15 { get; set; }
@AuraEnabled global String c_hotel_adw_break_12 { get; set; }
@AuraEnabled global Decimal f_hotel_adw_12 { get; set; }
@AuraEnabled global String c_last_gaming_trip { get; set; }
@AuraEnabled global Decimal i_days_since_gaming { get; set; }
@AuraEnabled global Decimal i_email_decile { get; set; }

	  	global MarketingCampaignWrapper(){

	  	}

	}

	/*******************************************************************************************************
    * @description Wrapper class for Marketing Property Campaigns
    */
	global class MarketingCampaignPropertyWrapper {
		@AuraEnabled global String ExternalId { get; set; }
	    @AuraEnabled global String c_acct_type_cd_fk { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Name { get; set;}
	  	@AuraEnabled global String c_acct_type_cd_fk_Description { get; set; } 
	  	@AuraEnabled global String c_acct_type_cd_fk_Quality_code { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Type_category { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Type_Id { get; set; }
	  	@AuraEnabled global String c_campaign_cd_fk { get; set; } 
	  	@AuraEnabled global String c_campaign_cd_fk_Name { get; set; }
	  	@AuraEnabled global String c_campaign_cd_fk_Description { get; set; }
	    @AuraEnabled global Boolean c_campaign_cd_fk_In_use { get; set; }
	  	@AuraEnabled global String c_campaign_type_fk { get; set; }
	  	@AuraEnabled global String c_campaign_type_fk_Name { get; set; }
	  	@AuraEnabled global String c_campaign_type_fk_Description { get; set; }
	  	@AuraEnabled global String contact { get; set; }
	  	@AuraEnabled global String c_dom_cd_prop_fk { get; set; }
	  	@AuraEnabled global String c_dom_cd_prop_fk_Name { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_Name { get; set; }
	  	@AuraEnabled global Boolean c_dom_market_cd_fk_Active_Flag { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_Description { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_Direct_Marketing_Center_Name { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_Market_Code { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_POD { get; set; }
	  	@AuraEnabled global String c_dom_market_cd_fk_Time_Zone { get; set; }
	  	@AuraEnabled global String c_dom_pref_prop_cd_fk { get; set; }
	  	@AuraEnabled global String c_dom_pref_prop_cd_fk_Name { get; set; }
	  	@AuraEnabled global String c_pref_prop_cd_fk { get; set; }
	  	@AuraEnabled global String c_pref_prop_cd_fk_Name { get; set; }
	  	@AuraEnabled global String c_prop_cd_fk { get; set; }
	  	@AuraEnabled global String c_prop_cd_fk_Name { get; set; }
	  	@AuraEnabled global String c_prop_cd_2_fk { get; set; }
	  	@AuraEnabled global String c_prop_cd_2_fk_Name { get; set; }
	  	@AuraEnabled global String c_worth_break { get; set; }
	  	@AuraEnabled global Decimal f_property_worth { get; set; }

	  	@AuraEnabled global String c_prop_market_cd_Name { get; set; }
	  	@AuraEnabled global String c_dom_pref_prop_cd_Name { get; set; }
	  	@AuraEnabled global String d_last_activity_dt { get; set; }
	  	@AuraEnabled global Decimal f_worth_12mn_ap_ah { get; set; }
	  	@AuraEnabled global DEcimal f_worth_all_ytd_ap_ah { get; set; }
	  	@AuraEnabled global String c_frequency { get; set; }
	  	@AuraEnabled global Decimal i_trp_rtd_ap_pdb_12mn_plus { get; set; }
	  	@AuraEnabled global Decimal i_trp_rtd_ap_pdb_24mn_plus { get; set; }
	  	@AuraEnabled global String c_game_pref { get; set; }
	  	@AuraEnabled global String c_drive_distance_cluster { get; set; }
	  	@AuraEnabled global String d_min_est_dt { get; set; }
	  	@AuraEnabled global String c_campaign_type { get; set; }
	  	@AuraEnabled global String c_campaign_cd { get; set; }
	  	@AuraEnabled global String c_campaign_desc { get; set; }
	  	@AuraEnabled global String subCampaign { get; set; }
	  	@AuraEnabled global Decimal f_worth { get; set; }

	  	@AuraEnabled global String c_campaign_type_desc { get; set; }
@AuraEnabled global String d_campaign_score_dt { get; set; }
@AuraEnabled global String c_version_cd { get; set; }
@AuraEnabled global String c_acct_type_cd { get; set; }
@AuraEnabled global String c_prop_market_cd { get; set; }
@AuraEnabled global String c_dom_pref_prop_cd { get; set; }
@AuraEnabled global String c_tier_cd { get; set; }
@AuraEnabled global String c_marketing_state_cd { get; set; }
@AuraEnabled global String c_regulatory_state_cd { get; set; }
@AuraEnabled global Decimal i_random_1 { get; set; }
@AuraEnabled global Decimal i_random_2 { get; set; }
@AuraEnabled global Decimal i_random_static_yr { get; set; }
@AuraEnabled global String c_main_ethnic_type { get; set; }
@AuraEnabled global String c_ethnic_group1 { get; set; }
@AuraEnabled global String c_preferred_written_language { get; set; }
@AuraEnabled global String c_prop_mail_cd { get; set; }
@AuraEnabled global String c_emailable { get; set; }
@AuraEnabled global String c_mailable { get; set; }
@AuraEnabled global String c_channel_pref { get; set; }
@AuraEnabled global String c_uk_res_supress { get; set; }
@AuraEnabled global String c_id_verified { get; set; }
@AuraEnabled global String c_age_18_plus { get; set; }
@AuraEnabled global String c_age_19_plus { get; set; }
@AuraEnabled global String c_age_21_plus { get; set; }
@AuraEnabled global String c_ucl_supp_flag { get; set; }
@AuraEnabled global String c_uci_supp_flag { get; set; }
@AuraEnabled global String c_video_poker_pref { get; set; }
@AuraEnabled global String c_baccarat_pref { get; set; }
@AuraEnabled global Decimal i_profitable_pct { get; set; }
@AuraEnabled global String c_convienence_cd { get; set; }
@AuraEnabled global Decimal i_lodging_pct { get; set; }
@AuraEnabled global String c_channel_rec { get; set; }
@AuraEnabled global String c_dom_market_cd { get; set; }
//@AuraEnabled global String c_gst_prop_dm_optout_flag { get; set; }
@AuraEnabled global String c_tdc_supp_flag { get; set; }
@AuraEnabled global String c_prop_cd_1 { get; set; }
@AuraEnabled global Decimal i_prop_pct_worth_1 { get; set; }
@AuraEnabled global String c_prop_cd_2 { get; set; }
@AuraEnabled global Decimal i_prop_pct_worth_2 { get; set; }
@AuraEnabled global String c_pref_prop_host_cd { get; set; }
@AuraEnabled global String c_host_type { get; set; }
@AuraEnabled global Decimal i_age { get; set; }
@AuraEnabled global String c_gender { get; set; }
@AuraEnabled global String c_dom_cd_prop { get; set; }
@AuraEnabled global String c_pref_prop_cd { get; set; }
@AuraEnabled global String c_geo_dm_zone { get; set; }
@AuraEnabled global String c_geo_rpt_zone { get; set; }
@AuraEnabled global String c_distance_cluster { get; set; }
@AuraEnabled global String c_msa_cd { get; set; }
@AuraEnabled global String c_msa { get; set; }
@AuraEnabled global String c_zip_7_pdb { get; set; }
@AuraEnabled global String d_create_dt_mkt { get; set; }
@AuraEnabled global String d_create_dt_ent { get; set; }
@AuraEnabled global Decimal f_act_all_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal f_theo_all_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal i_days_rtd_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal f_daily_theo_ap_pdb_12mnplus { get; set; }
@AuraEnabled global Decimal f_daily_act_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal f_daily_wrth_ap_pdb_12mnplus { get; set; }
@AuraEnabled global Decimal f_resp_rate_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal f_ofr_trp_pct_ap_pdb12mnplus { get; set; }
@AuraEnabled global Decimal f_htlsty_pct_ap_pdb_12mnplus { get; set; }
@AuraEnabled global Decimal f_slot_pct_ap_pdb_12mn_plus { get; set; }
@AuraEnabled global Decimal f_trp_all_adj_sc_pdb_12mn { get; set; }
@AuraEnabled global Decimal f_trp_rtd_adj_sc_pdb_12mn { get; set; }
@AuraEnabled global Decimal f_act_all_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal f_theo_all_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal i_days_rtd_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal f_daily_theo_ap_pdb_24mnplus { get; set; }
@AuraEnabled global Decimal f_daily_act_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal f_daily_wrth_ap_pdb_24mnplus { get; set; }
@AuraEnabled global Decimal f_resp_rate_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal f_ofr_trp_pct_ap_pdb24mnplus { get; set; }
@AuraEnabled global Decimal f_htlsty_pct_ap_pdb_24mnplus { get; set; }
@AuraEnabled global Decimal f_slot_pct_ap_pdb_24mn_plus { get; set; }
@AuraEnabled global Decimal f_trp_all_adj_sc_pdb_24mn { get; set; }
@AuraEnabled global Decimal f_trp_rtd_adj_sc_pdb_24mn { get; set; }
@AuraEnabled global Decimal f_trp_all_adj_sc_pdb_36mn { get; set; }
@AuraEnabled global Decimal f_trp_rtd_adj_sc_pdb_36mn { get; set; }
@AuraEnabled global Decimal f_profit_pct_ent { get; set; }
@AuraEnabled global String c_profit_flag_ent { get; set; }
@AuraEnabled global Decimal f_profit_pct_mkt { get; set; }
@AuraEnabled global String c_profit_flag_mkt { get; set; }
@AuraEnabled global Decimal i_age_adj_ah { get; set; }
@AuraEnabled global Decimal i_dob_mn_adj_ah { get; set; }
@AuraEnabled global Decimal i_dob_yr_adj_ah { get; set; }
@AuraEnabled global String c_country_cd_ah { get; set; }
@AuraEnabled global String c_credit_status_flag { get; set; }
@AuraEnabled global String c_mkt_host_cd_adj_ah { get; set; }
@AuraEnabled global String c_dom_prop_host_cd_adj_ah { get; set; }
@AuraEnabled global String c_prop_cd_1_host_cd_adj_ah { get; set; }
@AuraEnabled global String c_zip_7_ah { get; set; }
@AuraEnabled global Decimal f_tier_score_ah { get; set; }
@AuraEnabled global Decimal f_lodging_pct_mkt_adj_ah { get; set; }
@AuraEnabled global Decimal f_pct_bacarrat_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_blackjack_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_craps_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_other_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_paigow_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_roulette_mkt_ah { get; set; }
@AuraEnabled global Decimal f_pct_video_poker_mkt_ah { get; set; }
@AuraEnabled global String c_future_res_flag_mkt_ah { get; set; }
@AuraEnabled global Decimal f_worth_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_worth_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_worth_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_all_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_all_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_all_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_all_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_all_ytd_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_slot_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_slot_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_slot_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_slot_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_table_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_table_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_table_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_theo_table_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_act_all_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_act_all_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_act_all_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_act_all_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_actual_all_ytd_ap_ah { get; set; }
@AuraEnabled global Decimal f_avgbet_game_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_avgbet_game_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_avgbet_game_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal f_avgbet_game_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_lop_game_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_lop_game_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_lop_game_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_lop_game_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_all_cms_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_all_cms_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_all_cms_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_all_cms_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_rtd_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_rtd_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_rtd_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_trp_rtd_12mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_days_rtd_1mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_days_rtd_3mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_days_rtd_6mn_ap_ah { get; set; }
@AuraEnabled global Decimal i_days_rtd_12mn_ap_ah { get; set; }
@AuraEnabled global String d_last_rated_dt_mkt_ah { get; set; }
@AuraEnabled global Decimal f_rc_earned_1mn_mkt_ah { get; set; }
@AuraEnabled global Decimal f_rc_earned_3mn_mkt_ah { get; set; }
@AuraEnabled global Decimal f_rc_earned_6mn_mkt_ah { get; set; }
@AuraEnabled global Decimal f_rc_earned_12mn_mkt_ah { get; set; }
@AuraEnabled global String d_first_gaming_dt_mkt_ah { get; set; }
@AuraEnabled global String d_first_gaming_dt_ent_ah { get; set; }
@AuraEnabled global String d_first_dt_played_mkt_ah { get; set; }
@AuraEnabled global Decimal f_act_all_cms_first_hr_m_ah { get; set; }
@AuraEnabled global Decimal f_act_all_cms_first_day_m_ah { get; set; }
@AuraEnabled global Decimal f_act_all_cms_first_trp_m_ah { get; set; }
@AuraEnabled global Decimal i_lop_first_hr_mkt_ah { get; set; }
@AuraEnabled global Decimal i_lop_first_day_mkt_ah { get; set; }
@AuraEnabled global Decimal i_lop_first_trp_mkt_ah { get; set; }
@AuraEnabled global String c_convienence_cd_new { get; set; }
@AuraEnabled global String c_recency { get; set; }
@AuraEnabled global String c_frequency_tc { get; set; }
@AuraEnabled global String c_frequency_ttm_24 { get; set; }
@AuraEnabled global String c_tierscore_desc { get; set; }
@AuraEnabled global Decimal f_hotel_adw { get; set; }
@AuraEnabled global String c_hotel_adw_break { get; set; }
@AuraEnabled global String c_frequency_ttm { get; set; }
@AuraEnabled global String c_avg_day_hotel_flag { get; set; }
@AuraEnabled global Decimal i_days_since_last { get; set; }
@AuraEnabled global Decimal f_trip_cycle_48 { get; set; }
@AuraEnabled global String c_frequency_tc_12 { get; set; }
@AuraEnabled global Decimal f_trip_cycle_12 { get; set; }
@AuraEnabled global Decimal i_ttm_trip_cnt_12 { get; set; }
@AuraEnabled global Decimal i_ttm_trip_cnt_24 { get; set; }
@AuraEnabled global String c_adw_trip_break_12 { get; set; }
@AuraEnabled global Decimal f_adw_trip_12 { get; set; }
@AuraEnabled global String c_adw_trip_break_6 { get; set; }
@AuraEnabled global Decimal f_adw_trip_6 { get; set; }
@AuraEnabled global String c_adw_break_48 { get; set; }
@AuraEnabled global Decimal f_adw_48 { get; set; }
@AuraEnabled global String c_adw_break_24 { get; set; }
@AuraEnabled global Decimal f_adw_24 { get; set; }
@AuraEnabled global String c_adw_break_15 { get; set; }
@AuraEnabled global Decimal f_adw_15 { get; set; }
@AuraEnabled global String c_adw_break_12 { get; set; }
@AuraEnabled global Decimal f_adw_12 { get; set; }
@AuraEnabled global String c_hotel_adw_break_48 { get; set; }
@AuraEnabled global Decimal f_hotel_adw_48 { get; set; }
@AuraEnabled global String c_hotel_adw_break_24 { get; set; }
@AuraEnabled global Decimal f_hotel_adw_24 { get; set; }
@AuraEnabled global String c_hotel_adw_break_15 { get; set; }
@AuraEnabled global Decimal f_hotel_adw_15 { get; set; }
@AuraEnabled global String c_hotel_adw_break_12 { get; set; }
@AuraEnabled global Decimal f_hotel_adw_12 { get; set; }
@AuraEnabled global String c_last_gaming_trip { get; set; }
@AuraEnabled global Decimal i_days_since_gaming { get; set; }
@AuraEnabled global Decimal i_email_decile { get; set; }



	  	global MarketingCampaignPropertyWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for Marketing Weekly Campaigns
    */
	global class MarketingCampaignWeeklyWrapper {
		@AuraEnabled global String ExternalId { get; set; }
	    @AuraEnabled global String c_acct_type_cd_fk { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Name { get; set;}
	  	@AuraEnabled global String c_acct_type_cd_fk_Description { get; set; } 
	  	@AuraEnabled global String c_acct_type_cd_fk_Quality_code { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Type_category { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Type_Id { get; set; }
	  	@AuraEnabled global String c_campaign_type_fk { get; set; }
	  	@AuraEnabled global String c_campaign_type_fk_Name { get; set; }
	  	@AuraEnabled global String c_campaign_type_fk_Description { get; set; }
	  	@AuraEnabled global String contact { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_Name { get; set; }
	  	@AuraEnabled global Boolean c_prop_market_cd_fk_Active_Flag { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_Description { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_Direct_Marketing_Center_Name { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_Market_Code { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_POD { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_Time_Zone { get; set; }
	  	@AuraEnabled global String c_prop_cd_1_fk { get; set; }
	  	@AuraEnabled global String c_prop_cd_1_fk_Name { get; set; }
	  	@AuraEnabled global String c_prop_cd_2_fk { get; set; }
	  	@AuraEnabled global String c_prop_cd_2_fk_Name { get; set; }
	  	@AuraEnabled global String c_tier_cd_fk { get; set; }
	  	@AuraEnabled global String c_tier_cd_fk_Name { get; set; }

	  	global MarketingCampaignWeeklyWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for Marketing LVM
    */
	global class MarketingCampaignsLVMWrapper {
		@AuraEnabled global String ExternalId { get; set; }
	    @AuraEnabled global String c_acct_type_cd_fk { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Name { get; set;}
	  	@AuraEnabled global String c_acct_type_cd_fk_Description { get; set; } 
	  	@AuraEnabled global String c_acct_type_cd_fk_Quality_code { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Type_category { get; set; }
	  	@AuraEnabled global String c_acct_type_cd_fk_Type_Id { get; set; }
	  	@AuraEnabled global String contact { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_Name { get; set; }
	  	@AuraEnabled global Boolean c_prop_market_cd_fk_Active_Flag { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_Description { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_Direct_Marketing_Center_Name { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_Market_Code { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_POD { get; set; }
	  	@AuraEnabled global String c_prop_market_cd_fk_Time_Zone { get; set; }
	  	@AuraEnabled global String c_dom_pref_prop_cd_fk { get; set; }
	  	@AuraEnabled global String c_dom_pref_prop_cd_fk_Name { get; set; }  	
	  	@AuraEnabled global String c_tier_cd_fk { get; set; }
	  	@AuraEnabled global String c_tier_cd_fk_Name { get; set; }

	  	global MarketingCampaignsLVMWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for Enterprise Campaign
    */
	global class EnterpriseCampaignWrapper {
		@AuraEnabled global String ExternalId { get; set; }
		@AuraEnabled global Decimal f_actual_all_all_mkts { get; set; }
		@AuraEnabled global Decimal i_all_days_all_mkts { get; set; }
		@AuraEnabled global Decimal i_cms_rated_trips_all_mkts { get; set; }
		@AuraEnabled global String contact { get; set; }
		@AuraEnabled global Decimal i_hotel_trips_all_mkts { get; set; }
		@AuraEnabled global String i_dmid { get; set; }
		@AuraEnabled global Decimal id { get; set; }
		@AuraEnabled global Decimal f_mdw_all_all_mkts { get; set; }
		@AuraEnabled global Decimal f_mdw_rated_all_mkts { get; set; }
		@AuraEnabled global Decimal i_minutes_all_mkts { get; set; }
		@AuraEnabled global Decimal i_offer_trips_all_mkts { get; set; }
		@AuraEnabled global Decimal i_pdb_rated_trips_all_mkts { get; set; }
		@AuraEnabled global Decimal i_pdb_trips_all_mkts { get; set; }
		@AuraEnabled global Decimal i_rated_days_all_mkts { get; set; }
		@AuraEnabled global Decimal f_theo_all_all_mkts { get; set; }
	
	  	global EnterpriseCampaignWrapper(){

	  	}
	}

}