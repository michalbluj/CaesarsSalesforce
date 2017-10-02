global with sharing class GuestPDBTripCC extends GuestSubjectDataBaseCC {
	
	global GuestPDBTripCC(){}
	
	/*******************************************************************************************************
    * @description Retrieve the PDB Trip data from pdb_trip table
    * @param List<Id> of Contact/External Ids used to retrieve
    * @return List<PDBTripWrapper> containing the retrieved data
    * @example
    * List<GuestPDBTripCC.PDBTripWrapper>  pdbTripList = 
	*   		GuestPDBTripCC.retrievePDBTripByContacts(new List<String>{'0030v0000030aZdAAI'});    */
    @TestVisible private static List<pdb_trip__x> mockedPDBTrip = new List<pdb_trip__x>();

	@RemoteAction
	@AuraEnabled
	global static List<PDBTripWrapper> retrievePDBTripDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  WHERE ExternalId in';
		String idType = 'external';
		return (new GuestPDBTripCC()).retrievePDBTrip(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<PDBTripWrapper> retrievePDBTripByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact_fk__c in';
		String idType = 'contact';
		return (new GuestPDBTripCC()).retrievePDBTrip(contactIds, whereClause, idType);
	}
	
	private List<PDBTripWrapper> retrievePDBTrip(List<String> Ids, String whereClause, String idType) {	
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new GuestHotelFolioDataCC()).getConsXrefIds(ids);
		}

		String soql1 = ' SELECT ';	
		soql1 += ' Id, ';
		soql1 += ' ExternalId, ';
		soql1 += ' account_c_home_prop_cd_fk__c, ';
		soql1 += ' account_c_home_prop_cd_fk__r.Name, ';
		soql1 += ' account_c_prop_cd_fk__c, ';
		soql1 += ' account_c_prop_cd_fk__r.Name, ';
		soql1 += ' c_as_brand_flag__c, ';
		soql1 += ' c_as_cms_flag__c, ';
		soql1 += ' c_casino_flag__c, ';
		soql1 += ' c_cons_rev_flag__c, ';
		soql1 += ' c_curr_flag__c, ';
		soql1 += ' c_first_prop_visit__c, ';
		soql1 += ' c_home_prop_cd__c, ';
		soql1 += ' c_hotel_flag__c, ';
		soql1 += ' c_pos_flag__c, ';
		soql1 += ' c_prop_cd__c, ';
		soql1 += ' c_quality_cd__c, ';
		soql1 += ' c_rated_trip__c, ';
		soql1 += ' c_w2g_flag__c, ';
		soql1 += ' c_week_cd__c, ';
		soql1 += ' contact_fk__c, ';
		soql1 += ' contact_fk__r.Name, ';
		soql1 += ' f_actual_all__c, ';
		soql1 += ' f_actual_game__c, ';
		soql1 += ' f_actual_oth__c, ';
		soql1 += ' f_actual_slot__c, ';
		soql1 += ' f_avgbet_game__c, ';
		soql1 += ' f_avgbet_oth__c, ';
		soql1 += ' f_avgbet_slot__c, ';
		soql1 += ' f_beer_amt__c, ';
		soql1 += ' f_cash_chrg_amt__c, ';
		soql1 += ' f_cash_play_game__c, ';
		soql1 += ' f_cash_play_oth__c, ';
		soql1 += ' f_cash_play_slot__c, ';
		soql1 += ' f_comp_rev__c, ';
		soql1 += ' f_comp_worth__c, ';
		soql1 += ' f_discount_amt__c, ';
		soql1 += ' f_entertain_actual_profit__c, ';
		soql1 += ' f_entertain_avg_profit__c, ';
		soql1 += ' f_entertain_cash_rev__c, ';
		soql1 += ' f_entertain_cash_tt__c, ';
		soql1 += ' f_entertain_comp_rev__c, ';
		soql1 += ' f_entertain_comp_tt__c, ';
		soql1 += ' f_event_actual_profit__c, ';
		soql1 += ' f_event_avg_profit__c, ';
		soql1 += ' f_event_cash_rev__c, ';
		soql1 += ' f_event_cash_tt__c, ';
		soql1 += ' f_event_comp_rev__c, ';
		soql1 += ' f_event_comp_tt__c, ';
		soql1 += ' f_fb_rev__c, ';
		soql1 += ' f_food_amt__c, ';
		soql1 += ' f_food_bev_nc_actual_profit__c, ';
		soql1 += ' f_food_bev_nc_avg_profit__c, ';
		soql1 += ' f_food_bev_nc_cash_rev__c, ';
		soql1 += ' f_food_bev_nc_cash_tt__c, ';
		soql1 += ' f_food_bev_nc_comp_rev__c, ';
		soql1 += ' f_food_bev_nc_comp_tt__c, ';
		soql1 += ' f_food_cd_actual_profit__c, ';
		soql1 += ' f_food_cd_avg_profit__c, ';
		soql1 += ' f_food_cd_cash_rev__c, ';
		soql1 += ' f_food_cd_cash_tt__c, ';
		soql1 += ' f_food_cd_comp_rev__c, ';
		soql1 += ' f_food_cd_comp_tt__c, ';
		soql1 += ' f_food_comp_amt__c, ';
		soql1 += ' f_food_fd_actual_profit__c, ';
		soql1 += ' f_food_fd_avg_profit__c, ';
		soql1 += ' f_food_fd_cash_rev__c, ';
		soql1 += ' f_food_fd_cash_tt__c, ';
		soql1 += ' f_food_fd_comp_rev__c, ';
		soql1 += ' f_food_fd_comp_tt__c, ';
		soql1 += ' f_food_qs_actual_profit__c, ';
		soql1 += ' f_food_qs_avg_profit__c, ';
		soql1 += ' f_food_qs_cash_rev__c, ';
		soql1 += ' f_food_qs_cash_tt__c, ';
		soql1 += ' f_food_qs_comp_rev__c, ';
		soql1 += ' f_food_qs_comp_tt__c, ';
		soql1 += ' f_golf_actual_profit__c, ';
		soql1 += ' f_golf_avg_profit__c, ';
		soql1 += ' f_golf_cash_rev__c, ';
		soql1 += ' f_golf_cash_tt__c, ';
		soql1 += ' f_golf_comp_rev__c, ';
		soql1 += ' f_golf_comp_tt__c, ';
		soql1 += ' f_liq_amt__c, ';
		soql1 += ' f_marker_play_game__c, ';
		soql1 += ' f_marker_play_oth__c, ';
		soql1 += ' f_marker_play_slot__c, ';
		soql1 += ' f_misc_amt__c, ';
		soql1 += ' f_na_bev_amt__c, ';
		soql1 += ' f_oth_amt__c, ';
		soql1 += ' f_other_actual_profit__c, ';
		soql1 += ' f_other_avg_profit__c, ';
		soql1 += ' f_other_cash_rev__c, ';
		soql1 += ' f_other_cash_tt__c, ';
		soql1 += ' f_other_comp_amt__c, ';
		soql1 += ' f_other_comp_rev__c, ';
		soql1 += ' f_other_comp_tt__c, ';
		soql1 += ' f_other_payment_amt__c, ';
		soql1 += ' f_other_rev__c, ';
		soql1 += ' f_package_actual_profit__c, ';
		soql1 += ' f_package_avg_profit__c, ';
		soql1 += ' f_package_cash_rev__c, ';
		soql1 += ' f_package_cash_tt__c, ';
		soql1 += ' f_package_comp_rev__c, ';
		soql1 += ' f_package_comp_tt__c, ';
		soql1 += ' f_pos_actual_profit_amt__c, ';
		soql1 += ' f_pos_avg_profit_amt__c, ';
		soql1 += ' f_pos_comp_amt__c, ';
		soql1 += ' f_retail_amt__c, ';
		soql1 += ' f_retail_le_actual_profit__c, ';
		soql1 += ' f_retail_le_avg_profit__c, ';
		soql1 += ' f_retail_le_cash_rev__c, ';
		soql1 += ' f_retail_le_cash_tt__c, ';
		soql1 += ' f_retail_le_comp_rev__c, ';
		soql1 += ' f_retail_le_comp_tt__c, ';
		soql1 += ' f_retail_owned_actual_profit__c, ';
		soql1 += ' f_retail_owned_avg_profit__c, ';
		soql1 += ' f_retail_owned_cash_rev__c, ';
		soql1 += ' f_retail_owned_cash_tt__c, ';
		soql1 += ' f_retail_owned_comp_rev__c, ';
		soql1 += ' f_retail_owned_comp_tt__c, ';
		soql1 += ' f_room_actual_profit__c, ';
		soql1 += ' f_room_avg_profit__c, ';
		soql1 += ' f_room_cash_rev__c, ';
		soql1 += ' f_room_cash_tt__c, ';
		soql1 += ' f_room_chrg_amt__c, ';
		soql1 += ' f_room_comp_amt__c, ';
		soql1 += ' f_room_comp_rev__c, ';
		soql1 += ' f_room_comp_tt__c, ';
		soql1 += ' f_room_rev__c, ';
		soql1 += ' f_service_charge_amt__c, ';
		soql1 += ' f_spa_actual_profit__c, ';
		soql1 += ' f_spa_avg_profit__c, ';
		soql1 += ' f_spa_cash_rev__c, ';
		soql1 += ' f_spa_cash_tt__c, ';
		soql1 += ' f_spa_comp_rev__c, ';
		soql1 += ' f_spa_comp_tt__c, ';
		soql1 += ' f_tax_amt__c, ';
		soql1 += ' f_tax_discount_oth_amt__c, ';
		soql1 += ' f_theo_all__c, ';
		soql1 += ' f_theo_game__c, ';
		soql1 += ' f_theo_oth__c, ';
		soql1 += ' f_theo_slot__c, ';
		soql1 += ' f_total_comp_amount__c, ';
		soql1 += ' f_total_item_amt__c, ';
		soql1 += ' f_total_payment_amt__c, ';
		soql1 += ' f_trans_amt__c, ';
		soql1 += ' f_transport_actual_profit__c, ';
		soql1 += ' f_transport_avg_profit__c, ';
		soql1 += ' f_transport_cash_rev__c, ';
		soql1 += ' f_transport_cash_tt__c, ';
		soql1 += ' f_transport_comp_rev__c, ';
		soql1 += ' f_transport_comp_tt__c, ';
		soql1 += ' f_wine_amt__c, ';
		soql1 += ' i_avgbet_div_game__c, ';
		soql1 += ' i_avgbet_div_oth__c, ';
		soql1 += ' i_avgbet_div_slot__c, ';
		soql1 += ' i_brand_trip_nbr__c, ';
		soql1 += ' i_comped_trip__c, ';
		soql1 += ' i_covers__c, ';
		soql1 += ' i_dmid__c, ';
		soql1 += ' i_events__c, ';
		soql1 += ' i_len_of_play_game__c, ';
		soql1 += ' i_len_of_play_oth__c, ';
		soql1 += ' i_len_of_play_slot__c, ';
		soql1 += ' i_line_item_qty__c, ';
		soql1 += ' i_nbr_cms_trips__c, ';
		soql1 += ' i_nbr_cons_rev_days__c, ';
		soql1 += ' i_nbr_days__c, ';
		soql1 += ' i_nbr_line_item__c, ';
		soql1 += ' i_nbr_occupants__c, ';
		soql1 += ' i_nbr_offers_red__c, ';
		soql1 += ' i_nbr_offers_unred__c, ';
		soql1 += ' i_nbr_pos_days__c, ';
		soql1 += ' i_nbr_rev_centers__c, ';
		soql1 += ' i_nbr_rooms__c, ';
		soql1 += ' i_nbr_trans__c, ';
		soql1 += ' i_nbr_trip_game__c, ';
		soql1 += ' i_nbr_trip_oth__c, ';
		soql1 += ' i_nbr_trip_slot__c, ';
		soql1 += ' i_pdb_trip_id__c, ';
		soql1 += ' i_rated_days__c, ';
		soql1 += ' i_rated_trips__c, ';
		soql1 += ' i_rm_night__c, ';
		soql1 += ' i_stay__c, ';
		soql1 += ' i_trip_nbr__c, ';
		soql1 += ' id__c, ';
		soql1 += ' week_code_fk__c, ';
		soql1 += ' week_code_fk__r.c_week_cd_desc__c, ';
		soql1 += ' d_end_dt__c, ';
		soql1 += ' d_rpt_per__c, ';
		soql1 += ' d_start_dt__c, ';
		soql1 += ' d_timestamp__c ';

		soql1 += ' FROM pdb_trip__x  ';

		if (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}
		soql1 = String.escapeSingleQuotes(soql1);
		system.debug('*** soql1 ' + soql1);
		
		Map<String, PDBTripWrapper> pdbTripMap = new Map<String, PDBTripWrapper> ();
		List<pdb_trip__x> pdbTripList = (!mockedPDBTrip.isEmpty()) ? mockedPDBTrip : Database.query(soql1);
	  	updatePDBTrip (pdbTripMap, pdbTripList, '1');

	  	system.debug('*** pdbTripMap.values() return ' + pdbTripMap.values());

	  	//
		// load pdbTripAllMap with the PDB Trip data
		//
		// note that the pdbTripAllMap has a key of pdb_trip_id
		//
		Map<String, PDBTripWrapper> pdbTripAllMap = new Map<String, PDBTripWrapper>();

		PDBTripWrapper pdbWrap;
		for (PDBTripWrapper pdbTripWrap : pdbTripMap.values()) {
			if (!pdbTripAllMap.containsKey(pdbTripWrap.i_pdb_trip_id)) {
				pdbTripAllMap.put(pdbTripWrap.i_pdb_trip_id, pdbTripWrap);
			}
		}
		system.debug('*** pdbTripAllMap ' + pdbTripAllMap);
		//
		// read the PDB Trip Info data and load it into the PDBTripWrapper in the pdbTripAllMap
		//
		List<PDBTripInfoWrapper>  infoWrapList;

		List<String> pdbTripIds = new List<String>();
		pdbTripIds.addAll(pdbTripAllMap.keySet());

		infoWrapList = retrievePDBTripInfoDetails(pdbTripIds);

		for (PDBTripInfoWrapper infoWrap : infoWrapList) {
			if (pdbTripAllMap.containsKey(infoWrap.i_pdb_trip_id)) {
			//	pdbTripAllMap.put(infoWrap.i_pdb_trip_id, new PDBTripInfoWrapper());
			//}
				pdbWrap = pdbTripAllMap.get(infoWrap.i_pdb_trip_id);

				pdbWrap.c_user_flag_1 = infoWrap.c_user_flag_1;
				pdbWrap.c_user_flag_2 = infoWrap.c_user_flag_2;
				pdbWrap.c_user_flag_3 = infoWrap.c_user_flag_3;
				pdbWrap.c_user_flag_4 = infoWrap.c_user_flag_4;
				pdbWrap.f_cash_cost = infoWrap.f_cash_cost;
				pdbWrap.f_cash_value = infoWrap.f_cash_value;
				pdbWrap.f_cashless_cost = infoWrap.f_cashless_cost;
				pdbWrap.f_cashless_value = infoWrap.f_cashless_value;
				pdbWrap.f_exl_from_profitb_value = infoWrap.f_exl_from_profitb_value;
				pdbWrap.f_hotel_cost = infoWrap.f_hotel_cost;
				pdbWrap.f_hotel_value = infoWrap.f_hotel_value;
				pdbWrap.f_other_cost1 = infoWrap.f_other_cost1;
				pdbWrap.f_other_cost2 = infoWrap.f_other_cost2;
				pdbWrap.f_other_cost3 = infoWrap.f_other_cost3;
				pdbWrap.f_other_cost4 = infoWrap.f_other_cost4;
				pdbWrap.f_other_cost5 = infoWrap.f_other_cost5;
				pdbWrap.f_other_cost = infoWrap.f_other_cost;
				pdbWrap.f_other_value = infoWrap.f_other_value;
				pdbWrap.f_total_cost = infoWrap.f_total_cost;
				pdbWrap.f_trip_value1 = infoWrap.f_trip_value1;
				pdbWrap.f_trip_value2 = infoWrap.f_trip_value2;
				pdbWrap.f_trip_value3 = infoWrap.f_trip_value3;
				pdbWrap.f_trip_value4 = infoWrap.f_trip_value4;
				pdbWrap.f_trip_value5 = infoWrap.f_trip_value5;
				pdbWrap.f_user_amt_10 = infoWrap.f_user_amt_10;
				pdbWrap.f_user_amt_1 = infoWrap.f_user_amt_1;
				pdbWrap.f_user_amt_2 = infoWrap.f_user_amt_2;
				pdbWrap.f_user_amt_3 = infoWrap.f_user_amt_3;
				pdbWrap.f_user_amt_4 = infoWrap.f_user_amt_4;
				pdbWrap.f_user_amt_5 = infoWrap.f_user_amt_5;
				pdbWrap.f_user_amt_6 = infoWrap.f_user_amt_6;
				pdbWrap.f_user_amt_7 = infoWrap.f_user_amt_7;
				pdbWrap.f_user_amt_8 = infoWrap.f_user_amt_8;
				pdbWrap.f_user_amt_9 = infoWrap.f_user_amt_9;
				pdbWrap.i_cash_coup = infoWrap.i_cash_coup;
				pdbWrap.i_cashless_coup = infoWrap.i_cashless_coup;
				pdbWrap.i_dmid = infoWrap.i_dmid;
				pdbWrap.i_exl_from_profitb_coup = infoWrap.i_exl_from_profitb_coup;
				pdbWrap.i_hotel_coup = infoWrap.i_hotel_coup;
				pdbWrap.i_offers = infoWrap.i_offers;
				pdbWrap.i_other_coup = infoWrap.i_other_coup;
				pdbWrap.i_pdb_trip_id = infoWrap.i_pdb_trip_id;
				pdbWrap.i_pdb_trip_id_fk = infoWrap.i_pdb_trip_id_fk;
				pdbWrap.i_total_coup = infoWrap.i_total_coup;
				pdbWrap.i_user_score_10 = infoWrap.i_user_score_10;
				pdbWrap.i_user_score_1 = infoWrap.i_user_score_1;
				pdbWrap.i_user_score_2 = infoWrap.i_user_score_2;
				pdbWrap.i_user_score_3 = infoWrap.i_user_score_3;
				pdbWrap.i_user_score_4 = infoWrap.i_user_score_4;
				pdbWrap.i_user_score_5 = infoWrap.i_user_score_5;
				pdbWrap.i_user_score_6 = infoWrap.i_user_score_6;
				pdbWrap.i_user_score_7 = infoWrap.i_user_score_7;
				pdbWrap.i_user_score_8 = infoWrap.i_user_score_8;
				pdbWrap.i_user_score_9 = infoWrap.i_user_score_9;

				pdbTripAllMap.put(infoWrap.i_pdb_trip_id, pdbWrap);
			}
		}
		//
		// read the PDB Trip Day data and load it into the PDBTripWrapper in the pdbTripAllMap
		//
		List<PDBTripDayWrapper>  dayWrapList;

		dayWrapList = retrievePDBTripDayDetails(pdbTripIds);

		for (PDBTripDayWrapper dayWrap : dayWrapList) {
			if (pdbTripAllMap.containsKey(dayWrap.i_pdb_trip_id)) {
				pdbWrap = pdbTripAllMap.get(dayWrap.i_pdb_trip_id);

				pdbWrap.c_division_desc = dayWrap.c_division_desc;
				pdbWrap.c_market_cd = dayWrap.c_market_cd;
				pdbWrap.c_market_cd_fk = dayWrap.c_market_cd_fk;
				pdbWrap.c_market_cd_fk_description = dayWrap.c_market_cd_fk_description;
				pdbWrap.c_prop_cd = dayWrap.c_prop_cd;
				pdbWrap.c_prop_cd_fk = dayWrap.c_prop_cd_fk;
				pdbWrap.c_prop_cd_fk_name = dayWrap.c_prop_cd_fk_Name;
				pdbWrap.c_prop_market_cd = dayWrap.c_prop_market_cd;
				pdbWrap.c_prop_market_cd_fk = dayWrap.c_prop_market_cd_fk;
				pdbWrap.c_prop_market_cd_fk_name = dayWrap.c_prop_market_cd_fk_Name;
				pdbWrap.c_quality_cd = dayWrap.c_quality_cd;
				pdbWrap.f_act_all = dayWrap.f_act_all;
				pdbWrap.f_act_game = dayWrap.f_act_game;
				pdbWrap.f_act_other = dayWrap.f_act_other;
				pdbWrap.f_act_slot = dayWrap.f_act_slot;
				pdbWrap.f_actual_profit_amt = dayWrap.f_actual_profit_amt;
				pdbWrap.f_avg_profit_amt = dayWrap.f_avg_profit_amt;
				pdbWrap.f_cash_marker_game = dayWrap.f_cash_marker_game;
				pdbWrap.f_cash_marker_other = dayWrap.f_cash_marker_other;
				pdbWrap.f_cash_rev_amt = dayWrap.f_cash_rev_amt;
				pdbWrap.f_cash_tt_amt = dayWrap.f_cash_tt_amt;
				pdbWrap.f_coinin_slot = dayWrap.f_coinin_slot;
				pdbWrap.f_comp_rev_amt = dayWrap.f_comp_rev_amt;
				pdbWrap.f_comp_tt_amt = dayWrap.f_comp_tt_amt;
				pdbWrap.f_cw_dlrs_dec_food_used = dayWrap.f_cw_dlrs_dec_food_used;
				pdbWrap.f_cw_dlrs_dec_other_used = dayWrap.f_cw_dlrs_dec_other_used;
				pdbWrap.f_cw_dlrs_dec_room_used = dayWrap.f_cw_dlrs_dec_room_used;
				pdbWrap.f_cw_dlrs_dec_trans_used = dayWrap.f_cw_dlrs_dec_trans_used;
				pdbWrap.f_cw_dlrs_dec_used = dayWrap.f_cw_dlrs_dec_used;
				pdbWrap.f_cw_dlrs_food_used = dayWrap.f_cw_dlrs_food_used;
				pdbWrap.f_cw_dlrs_nondec_food_used = dayWrap.f_cw_dlrs_nondec_food_used;
				pdbWrap.f_cw_dlrs_nondec_other_used = dayWrap.f_cw_dlrs_nondec_other_used;
				pdbWrap.f_cw_dlrs_nondec_room_used = dayWrap.f_cw_dlrs_nondec_room_used;
				pdbWrap.f_cw_dlrs_nondec_trans_used = dayWrap.f_cw_dlrs_nondec_trans_used;
				pdbWrap.f_cw_dlrs_nondec_used = dayWrap.f_cw_dlrs_nondec_used;
				pdbWrap.f_cw_dlrs_other_used = dayWrap.f_cw_dlrs_other_used;
				pdbWrap.f_cw_dlrs_room_used = dayWrap.f_cw_dlrs_room_used;
				pdbWrap.f_cw_dlrs_trans_used = dayWrap.f_cw_dlrs_trans_used;
				pdbWrap.f_cw_dlrs_used = dayWrap.f_cw_dlrs_used;
				pdbWrap.f_rc_dlrs_food_used = dayWrap.f_rc_dlrs_food_used;
				pdbWrap.f_rc_dlrs_other_used = dayWrap.f_rc_dlrs_other_used;
				pdbWrap.f_rc_dlrs_room_used = dayWrap.f_rc_dlrs_room_used;
				pdbWrap.f_rc_dlrs_trans_used = dayWrap.f_rc_dlrs_trans_used;
				pdbWrap.f_rc_dlrs_used = dayWrap.f_rc_dlrs_used;
				pdbWrap.f_theo_all = dayWrap.f_theo_all;
				pdbWrap.f_theo_game = dayWrap.f_theo_game;
				pdbWrap.f_theo_other = dayWrap.f_theo_other;
				pdbWrap.f_theo_slot = dayWrap.f_theo_slot;
				pdbWrap.f_total_cms_comps = dayWrap.f_total_cms_comps;
				pdbWrap.i_cash_cost = dayWrap.i_cash_cost;
				pdbWrap.i_cash_coupons = dayWrap.i_cash_coupons;
				pdbWrap.i_comp_tickets = dayWrap.i_comp_tickets;
				pdbWrap.i_division_sort = dayWrap.i_division_sort;
				pdbWrap.i_event_cost = dayWrap.i_event_cost;
				pdbWrap.i_event_coupons = dayWrap.i_event_coupons;
				pdbWrap.i_fb_cost = dayWrap.i_fb_cost;
				pdbWrap.i_fb_coupons = dayWrap.i_fb_coupons;
				pdbWrap.i_hotel_cost = dayWrap.i_hotel_cost;
				pdbWrap.i_hotel_coupons = dayWrap.i_hotel_coupons;
				pdbWrap.i_lop_all = dayWrap.i_lop_all;
				pdbWrap.i_lop_game = dayWrap.i_lop_game;
				pdbWrap.i_lop_other = dayWrap.i_lop_other;
				pdbWrap.i_lop_slot = dayWrap.i_lop_slot;
				pdbWrap.i_merchandise_cost = dayWrap.i_merchandise_cost;
				pdbWrap.i_merchandise_coupons = dayWrap.i_merchandise_coupons;
				pdbWrap.i_other_cost = dayWrap.i_other_cost;
				pdbWrap.i_other_coupons = dayWrap.i_other_coupons;
				pdbWrap.i_promo_rc_cost = dayWrap.i_promo_rc_cost;
				pdbWrap.i_promo_rc_coupons = dayWrap.i_promo_rc_coupons;
				pdbWrap.i_prop_sort = dayWrap.i_prop_sort;
				pdbWrap.i_rrerr_cash_cost = dayWrap.i_rrerr_cash_cost;
				pdbWrap.i_rrerr_cash_coupons = dayWrap.i_rrerr_cash_coupons;
				pdbWrap.i_tot_cost = dayWrap.i_tot_cost;
				pdbWrap.i_tot_coupons = dayWrap.i_tot_coupons;
				pdbWrap.d_date = dayWrap.d_date;

				
				pdbTripAllMap.put(dayWrap.i_pdb_trip_id, pdbWrap);
			}
		}

		return pdbTripAllMap.values();

	}
	
    private static void updatePDBTrip (Map<String, PDBTripWrapper> pdbTripMap, List<pdb_trip__x> pdbTripList, String pass){
    	PDBTripWrapper pdbTripWrap;
    	GuestPDBTripCC ghfCC = new GuestPDBTripCC();

		for (pdb_trip__x pdbTrip : pdbTripList ){
			if (!pdbTripMap.containsKey(pdbTrip.ExternalId)) {
				pdbTripMap.put(pdbTrip.ExternalId, new PDBTripWrapper());
			}
			pdbTripWrap = pdbTripMap.get(pdbTrip.ExternalId);
			if (pass == '1') {
  				pdbTripWrap.ExternalId = pdbTrip.ExternalId;
  				pdbTripWrap.Id = pdbTrip.Id;

				pdbTripWrap.account_c_home_prop_cd_fk = pdbTrip.account_c_home_prop_cd_fk__c;
				pdbTripWrap.account_c_home_prop_cd_fk_Name = pdbTrip.account_c_home_prop_cd_fk__r.Name;
				pdbTripWrap.account_c_prop_cd_fk = pdbTrip.account_c_prop_cd_fk__c;
				pdbTripWrap.account_c_prop_cd_fk_Name = pdbTrip.account_c_prop_cd_fk__r.Name;
				pdbTripWrap.c_as_brand_flag = pdbTrip.c_as_brand_flag__c;
				pdbTripWrap.c_as_cms_flag = pdbTrip.c_as_cms_flag__c;
				pdbTripWrap.c_casino_flag = pdbTrip.c_casino_flag__c;
				pdbTripWrap.c_cons_rev_flag = pdbTrip.c_cons_rev_flag__c;
				pdbTripWrap.c_curr_flag = pdbTrip.c_curr_flag__c;
				pdbTripWrap.c_first_prop_visit = pdbTrip.c_first_prop_visit__c;
				pdbTripWrap.c_home_prop_cd = pdbTrip.c_home_prop_cd__c;
				pdbTripWrap.c_hotel_flag = pdbTrip.c_hotel_flag__c;
				pdbTripWrap.c_pos_flag = pdbTrip.c_pos_flag__c;
				pdbTripWrap.c_prop_cd = pdbTrip.c_prop_cd__c;
				pdbTripWrap.c_quality_cd = pdbTrip.c_quality_cd__c;
				pdbTripWrap.c_rated_trip = pdbTrip.c_rated_trip__c;
				pdbTripWrap.c_w2g_flag = pdbTrip.c_w2g_flag__c;
				pdbTripWrap.c_week_cd = pdbTrip.c_week_cd__c;
				pdbTripWrap.contact_fk = pdbTrip.contact_fk__c;
				pdbTripWrap.contact_fk_Name = pdbTrip.contact_fk__r.Name;
				pdbTripWrap.f_actual_all = pdbTrip.f_actual_all__c;
				pdbTripWrap.f_actual_game = pdbTrip.f_actual_game__c;
				pdbTripWrap.f_actual_oth = pdbTrip.f_actual_oth__c;
				pdbTripWrap.f_actual_slot = pdbTrip.f_actual_slot__c;
				pdbTripWrap.f_avgbet_game = pdbTrip.f_avgbet_game__c;
				pdbTripWrap.f_avgbet_oth = pdbTrip.f_avgbet_oth__c;
				pdbTripWrap.f_avgbet_slot = pdbTrip.f_avgbet_slot__c;
				pdbTripWrap.f_beer_amt = pdbTrip.f_beer_amt__c;
				pdbTripWrap.f_cash_chrg_amt = pdbTrip.f_cash_chrg_amt__c;
				pdbTripWrap.f_cash_play_game = pdbTrip.f_cash_play_game__c;
				pdbTripWrap.f_cash_play_oth = pdbTrip.f_cash_play_oth__c;
				pdbTripWrap.f_cash_play_slot = pdbTrip.f_cash_play_slot__c;
				pdbTripWrap.f_comp_rev = pdbTrip.f_comp_rev__c;
				pdbTripWrap.f_comp_worth = pdbTrip.f_comp_worth__c;
				pdbTripWrap.f_discount_amt = pdbTrip.f_discount_amt__c;
				pdbTripWrap.f_entertain_actual_profit = pdbTrip.f_entertain_actual_profit__c;
				pdbTripWrap.f_entertain_avg_profit = pdbTrip.f_entertain_avg_profit__c;
				pdbTripWrap.f_entertain_cash_rev = pdbTrip.f_entertain_cash_rev__c;
				pdbTripWrap.f_entertain_cash_tt = pdbTrip.f_entertain_cash_tt__c;
				pdbTripWrap.f_entertain_comp_rev = pdbTrip.f_entertain_comp_rev__c;
				pdbTripWrap.f_entertain_comp_tt = pdbTrip.f_entertain_comp_tt__c;
				pdbTripWrap.f_event_actual_profit = pdbTrip.f_event_actual_profit__c;
				pdbTripWrap.f_event_avg_profit = pdbTrip.f_event_avg_profit__c;
				pdbTripWrap.f_event_cash_rev = pdbTrip.f_event_cash_rev__c;
				pdbTripWrap.f_event_cash_tt = pdbTrip.f_event_cash_tt__c;
				pdbTripWrap.f_event_comp_rev = pdbTrip.f_event_comp_rev__c;
				pdbTripWrap.f_event_comp_tt = pdbTrip.f_event_comp_tt__c;
				pdbTripWrap.f_fb_rev = pdbTrip.f_fb_rev__c;
				pdbTripWrap.f_food_amt = pdbTrip.f_food_amt__c;
				pdbTripWrap.f_food_bev_nc_actual_profit = pdbTrip.f_food_bev_nc_actual_profit__c;
				pdbTripWrap.f_food_bev_nc_avg_profit = pdbTrip.f_food_bev_nc_avg_profit__c;
				pdbTripWrap.f_food_bev_nc_cash_rev = pdbTrip.f_food_bev_nc_cash_rev__c;
				pdbTripWrap.f_food_bev_nc_cash_tt = pdbTrip.f_food_bev_nc_cash_tt__c;
				pdbTripWrap.f_food_bev_nc_comp_rev = pdbTrip.f_food_bev_nc_comp_rev__c;
				pdbTripWrap.f_food_bev_nc_comp_tt = pdbTrip.f_food_bev_nc_comp_tt__c;
				pdbTripWrap.f_food_cd_actual_profit = pdbTrip.f_food_cd_actual_profit__c;
				pdbTripWrap.f_food_cd_avg_profit = pdbTrip.f_food_cd_avg_profit__c;
				pdbTripWrap.f_food_cd_cash_rev = pdbTrip.f_food_cd_cash_rev__c;
				pdbTripWrap.f_food_cd_cash_tt = pdbTrip.f_food_cd_cash_tt__c;
				pdbTripWrap.f_food_cd_comp_rev = pdbTrip.f_food_cd_comp_rev__c;
				pdbTripWrap.f_food_cd_comp_tt = pdbTrip.f_food_cd_comp_tt__c;
				pdbTripWrap.f_food_comp_amt = pdbTrip.f_food_comp_amt__c;
				pdbTripWrap.f_food_fd_actual_profit = pdbTrip.f_food_fd_actual_profit__c;
				pdbTripWrap.f_food_fd_avg_profit = pdbTrip.f_food_fd_avg_profit__c;
				pdbTripWrap.f_food_fd_cash_rev = pdbTrip.f_food_fd_cash_rev__c;
				pdbTripWrap.f_food_fd_cash_tt = pdbTrip.f_food_fd_cash_tt__c;
				pdbTripWrap.f_food_fd_comp_rev = pdbTrip.f_food_fd_comp_rev__c;
				pdbTripWrap.f_food_fd_comp_tt = pdbTrip.f_food_fd_comp_tt__c;
				pdbTripWrap.f_food_qs_actual_profit = pdbTrip.f_food_qs_actual_profit__c;
				pdbTripWrap.f_food_qs_avg_profit = pdbTrip.f_food_qs_avg_profit__c;
				pdbTripWrap.f_food_qs_cash_rev = pdbTrip.f_food_qs_cash_rev__c;
				pdbTripWrap.f_food_qs_cash_tt = pdbTrip.f_food_qs_cash_tt__c;
				pdbTripWrap.f_food_qs_comp_rev = pdbTrip.f_food_qs_comp_rev__c;
				pdbTripWrap.f_food_qs_comp_tt = pdbTrip.f_food_qs_comp_tt__c;
				pdbTripWrap.f_golf_actual_profit = pdbTrip.f_golf_actual_profit__c;
				pdbTripWrap.f_golf_avg_profit = pdbTrip.f_golf_avg_profit__c;
				pdbTripWrap.f_golf_cash_rev = pdbTrip.f_golf_cash_rev__c;
				pdbTripWrap.f_golf_cash_tt = pdbTrip.f_golf_cash_tt__c;
				pdbTripWrap.f_golf_comp_rev = pdbTrip.f_golf_comp_rev__c;
				pdbTripWrap.f_golf_comp_tt = pdbTrip.f_golf_comp_tt__c;
				pdbTripWrap.f_liq_amt = pdbTrip.f_liq_amt__c;
				pdbTripWrap.f_marker_play_game = pdbTrip.f_marker_play_game__c;
				pdbTripWrap.f_marker_play_oth = pdbTrip.f_marker_play_oth__c;
				pdbTripWrap.f_marker_play_slot = pdbTrip.f_marker_play_slot__c;
				pdbTripWrap.f_misc_amt = pdbTrip.f_misc_amt__c;
				pdbTripWrap.f_na_bev_amt = pdbTrip.f_na_bev_amt__c;
				pdbTripWrap.f_oth_amt = pdbTrip.f_oth_amt__c;
				pdbTripWrap.f_other_actual_profit = pdbTrip.f_other_actual_profit__c;
				pdbTripWrap.f_other_avg_profit = pdbTrip.f_other_avg_profit__c;
				pdbTripWrap.f_other_cash_rev = pdbTrip.f_other_cash_rev__c;
				pdbTripWrap.f_other_cash_tt = pdbTrip.f_other_cash_tt__c;
				pdbTripWrap.f_other_comp_amt = pdbTrip.f_other_comp_amt__c;
				pdbTripWrap.f_other_comp_rev = pdbTrip.f_other_comp_rev__c;
				pdbTripWrap.f_other_comp_tt = pdbTrip.f_other_comp_tt__c;
				pdbTripWrap.f_other_payment_amt = pdbTrip.f_other_payment_amt__c;
				pdbTripWrap.f_other_rev = pdbTrip.f_other_rev__c;
				pdbTripWrap.f_package_actual_profit = pdbTrip.f_package_actual_profit__c;
				pdbTripWrap.f_package_avg_profit = pdbTrip.f_package_avg_profit__c;
				pdbTripWrap.f_package_cash_rev = pdbTrip.f_package_cash_rev__c;
				pdbTripWrap.f_package_cash_tt = pdbTrip.f_package_cash_tt__c;
				pdbTripWrap.f_package_comp_rev = pdbTrip.f_package_comp_rev__c;
				pdbTripWrap.f_package_comp_tt = pdbTrip.f_package_comp_tt__c;
				pdbTripWrap.f_pos_actual_profit_amt = pdbTrip.f_pos_actual_profit_amt__c;
				pdbTripWrap.f_pos_avg_profit_amt = pdbTrip.f_pos_avg_profit_amt__c;
				pdbTripWrap.f_pos_comp_amt = pdbTrip.f_pos_comp_amt__c;
				pdbTripWrap.f_retail_amt = pdbTrip.f_retail_amt__c;
				pdbTripWrap.f_retail_le_actual_profit = pdbTrip.f_retail_le_actual_profit__c;
				pdbTripWrap.f_retail_le_avg_profit = pdbTrip.f_retail_le_avg_profit__c;
				pdbTripWrap.f_retail_le_cash_rev = pdbTrip.f_retail_le_cash_rev__c;
				pdbTripWrap.f_retail_le_cash_tt = pdbTrip.f_retail_le_cash_tt__c;
				pdbTripWrap.f_retail_le_comp_rev = pdbTrip.f_retail_le_comp_rev__c;
				pdbTripWrap.f_retail_le_comp_tt = pdbTrip.f_retail_le_comp_tt__c;
				pdbTripWrap.f_retail_owned_actual_profit = pdbTrip.f_retail_owned_actual_profit__c;
				pdbTripWrap.f_retail_owned_avg_profit = pdbTrip.f_retail_owned_avg_profit__c;
				pdbTripWrap.f_retail_owned_cash_rev = pdbTrip.f_retail_owned_cash_rev__c;
				pdbTripWrap.f_retail_owned_cash_tt = pdbTrip.f_retail_owned_cash_tt__c;
				pdbTripWrap.f_retail_owned_comp_rev = pdbTrip.f_retail_owned_comp_rev__c;
				pdbTripWrap.f_retail_owned_comp_tt = pdbTrip.f_retail_owned_comp_tt__c;
				pdbTripWrap.f_room_actual_profit = pdbTrip.f_room_actual_profit__c;
				pdbTripWrap.f_room_avg_profit = pdbTrip.f_room_avg_profit__c;
				pdbTripWrap.f_room_cash_rev = pdbTrip.f_room_cash_rev__c;
				pdbTripWrap.f_room_cash_tt = pdbTrip.f_room_cash_tt__c;
				pdbTripWrap.f_room_chrg_amt = pdbTrip.f_room_chrg_amt__c;
				pdbTripWrap.f_room_comp_amt = pdbTrip.f_room_comp_amt__c;
				pdbTripWrap.f_room_comp_rev = pdbTrip.f_room_comp_rev__c;
				pdbTripWrap.f_room_comp_tt = pdbTrip.f_room_comp_tt__c;
				pdbTripWrap.f_room_rev = pdbTrip.f_room_rev__c;
				pdbTripWrap.f_service_charge_amt = pdbTrip.f_service_charge_amt__c;
				pdbTripWrap.f_spa_actual_profit = pdbTrip.f_spa_actual_profit__c;
				pdbTripWrap.f_spa_avg_profit = pdbTrip.f_spa_avg_profit__c;
				pdbTripWrap.f_spa_cash_rev = pdbTrip.f_spa_cash_rev__c;
				pdbTripWrap.f_spa_cash_tt = pdbTrip.f_spa_cash_tt__c;
				pdbTripWrap.f_spa_comp_rev = pdbTrip.f_spa_comp_rev__c;
				pdbTripWrap.f_spa_comp_tt = pdbTrip.f_spa_comp_tt__c;
				pdbTripWrap.f_tax_amt = pdbTrip.f_tax_amt__c;
				pdbTripWrap.f_tax_discount_oth_amt = pdbTrip.f_tax_discount_oth_amt__c;
				pdbTripWrap.f_theo_all = pdbTrip.f_theo_all__c;
				pdbTripWrap.f_theo_game = pdbTrip.f_theo_game__c;
				pdbTripWrap.f_theo_oth = pdbTrip.f_theo_oth__c;
				pdbTripWrap.f_theo_slot = pdbTrip.f_theo_slot__c;
				pdbTripWrap.f_total_comp_amount = pdbTrip.f_total_comp_amount__c;
				pdbTripWrap.f_total_item_amt = pdbTrip.f_total_item_amt__c;
				pdbTripWrap.f_total_payment_amt = pdbTrip.f_total_payment_amt__c;
				pdbTripWrap.f_trans_amt = pdbTrip.f_trans_amt__c;
				pdbTripWrap.f_transport_actual_profit = pdbTrip.f_transport_actual_profit__c;
				pdbTripWrap.f_transport_avg_profit = pdbTrip.f_transport_avg_profit__c;
				pdbTripWrap.f_transport_cash_rev = pdbTrip.f_transport_cash_rev__c;
				pdbTripWrap.f_transport_cash_tt = pdbTrip.f_transport_cash_tt__c;
				pdbTripWrap.f_transport_comp_rev = pdbTrip.f_transport_comp_rev__c;
				pdbTripWrap.f_transport_comp_tt = pdbTrip.f_transport_comp_tt__c;
				pdbTripWrap.f_wine_amt = pdbTrip.f_wine_amt__c;
				pdbTripWrap.i_avgbet_div_game = pdbTrip.i_avgbet_div_game__c;
				pdbTripWrap.i_avgbet_div_oth = pdbTrip.i_avgbet_div_oth__c;
				pdbTripWrap.i_avgbet_div_slot = pdbTrip.i_avgbet_div_slot__c;
				pdbTripWrap.i_brand_trip_nbr = pdbTrip.i_brand_trip_nbr__c;
				pdbTripWrap.i_comped_trip = pdbTrip.i_comped_trip__c;
				pdbTripWrap.i_covers = pdbTrip.i_covers__c;
				pdbTripWrap.i_dmid = pdbTrip.i_dmid__c;
				pdbTripWrap.i_events = pdbTrip.i_events__c;
				pdbTripWrap.i_len_of_play_game = pdbTrip.i_len_of_play_game__c;
				pdbTripWrap.i_len_of_play_oth = pdbTrip.i_len_of_play_oth__c;
				pdbTripWrap.i_len_of_play_slot = pdbTrip.i_len_of_play_slot__c;
				pdbTripWrap.i_line_item_qty = pdbTrip.i_line_item_qty__c;
				pdbTripWrap.i_nbr_cms_trips = pdbTrip.i_nbr_cms_trips__c;
				pdbTripWrap.i_nbr_cons_rev_days = pdbTrip.i_nbr_cons_rev_days__c;
				pdbTripWrap.i_nbr_days = pdbTrip.i_nbr_days__c;
				pdbTripWrap.i_nbr_line_item = pdbTrip.i_nbr_line_item__c;
				pdbTripWrap.i_nbr_occupants = pdbTrip.i_nbr_occupants__c;
				pdbTripWrap.i_nbr_offers_red = pdbTrip.i_nbr_offers_red__c;
				pdbTripWrap.i_nbr_offers_unred = pdbTrip.i_nbr_offers_unred__c;
				pdbTripWrap.i_nbr_pos_days = pdbTrip.i_nbr_pos_days__c;
				pdbTripWrap.i_nbr_rev_centers = pdbTrip.i_nbr_rev_centers__c;
				pdbTripWrap.i_nbr_rooms = pdbTrip.i_nbr_rooms__c;
				pdbTripWrap.i_nbr_trans = pdbTrip.i_nbr_trans__c;
				pdbTripWrap.i_nbr_trip_game = pdbTrip.i_nbr_trip_game__c;
				pdbTripWrap.i_nbr_trip_oth = pdbTrip.i_nbr_trip_oth__c;
				pdbTripWrap.i_nbr_trip_slot = pdbTrip.i_nbr_trip_slot__c;
				pdbTripWrap.i_pdb_trip_id = pdbTrip.i_pdb_trip_id__c;
				pdbTripWrap.i_rated_days = pdbTrip.i_rated_days__c;
				pdbTripWrap.i_rated_trips = pdbTrip.i_rated_trips__c;
				pdbTripWrap.i_rm_night = pdbTrip.i_rm_night__c;
				pdbTripWrap.i_stay = pdbTrip.i_stay__c;
				pdbTripWrap.i_trip_nbr = pdbTrip.i_trip_nbr__c;
				pdbTripWrap.idc = pdbTrip.id__c;
				pdbTripWrap.week_code_fk = pdbTrip.week_code_fk__c;
				pdbTripWrap.week_code_fk_Desc = pdbTrip.week_code_fk__r.Name;
				pdbTripWrap.d_end_dt = ghfCC.stripTime(pdbTrip.d_end_dt__c);
				pdbTripWrap.d_rpt_per = ghfCC.stripTime(pdbTrip.d_rpt_per__c);
				pdbTripWrap.d_start_dt = ghfCC.stripTime(pdbTrip.d_start_dt__c);
				pdbTripWrap.d_timestamp = pdbTrip.d_timestamp__c;

				
		  	}
		  	pdbTripMap.put(pdbTripWrap.ExternalId, pdbTripWrap);
	  	}

	}  
    
    	/*******************************************************************************************************
    * @description Wrapper class for pdb_trip__x
    */
	global class PDBTripWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String Id { get; set; } 

		@AuraEnabled global String account_c_home_prop_cd_fk { get; set; } 
		@AuraEnabled global String account_c_prop_cd_fk { get; set; } 
		@AuraEnabled global String account_c_home_prop_cd_fk_Name { get; set; } 
		@AuraEnabled global String account_c_prop_cd_fk_Name { get; set; }
		@AuraEnabled global String c_as_brand_flag { get; set; } 
		@AuraEnabled global String c_as_cms_flag { get; set; } 
		@AuraEnabled global String c_casino_flag { get; set; } 
		@AuraEnabled global String c_cons_rev_flag { get; set; } 
		@AuraEnabled global String c_curr_flag { get; set; } 
		@AuraEnabled global String c_first_prop_visit { get; set; } 
		@AuraEnabled global String c_home_prop_cd { get; set; } 
		@AuraEnabled global String c_hotel_flag { get; set; } 
		@AuraEnabled global String c_pos_flag { get; set; } 
		@AuraEnabled global String c_prop_cd { get; set; } 
		@AuraEnabled global String c_quality_cd { get; set; } 
		@AuraEnabled global String c_rated_trip { get; set; } 
		@AuraEnabled global String c_w2g_flag { get; set; } 
		@AuraEnabled global String c_week_cd { get; set; } 
		@AuraEnabled global String contact_fk { get; set; } 
		@AuraEnabled global String contact_fk_Name { get; set; }
		@AuraEnabled global Decimal f_actual_all { get; set; } 
		@AuraEnabled global Decimal f_actual_game { get; set; } 
		@AuraEnabled global Decimal f_actual_oth { get; set; } 
		@AuraEnabled global Decimal f_actual_slot { get; set; } 
		@AuraEnabled global Decimal f_avgbet_game { get; set; } 
		@AuraEnabled global Decimal f_avgbet_oth { get; set; } 
		@AuraEnabled global Decimal f_avgbet_slot { get; set; } 
		@AuraEnabled global Decimal f_beer_amt { get; set; } 
		@AuraEnabled global Decimal f_cash_chrg_amt { get; set; } 
		@AuraEnabled global Decimal f_cash_play_game { get; set; } 
		@AuraEnabled global Decimal f_cash_play_oth { get; set; } 
		@AuraEnabled global Decimal f_cash_play_slot { get; set; } 
		@AuraEnabled global Decimal f_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_comp_worth { get; set; } 
		@AuraEnabled global Decimal f_discount_amt { get; set; } 
		@AuraEnabled global Decimal f_entertain_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_entertain_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_entertain_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_entertain_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_entertain_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_entertain_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_event_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_event_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_event_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_event_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_event_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_event_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_fb_rev { get; set; } 
		@AuraEnabled global Decimal f_food_amt { get; set; } 
		@AuraEnabled global Decimal f_food_bev_nc_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_food_bev_nc_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_food_bev_nc_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_food_bev_nc_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_food_bev_nc_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_food_bev_nc_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_food_cd_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_food_cd_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_food_cd_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_food_cd_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_food_cd_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_food_cd_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_food_comp_amt { get; set; } 
		@AuraEnabled global Decimal f_food_fd_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_food_fd_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_food_fd_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_food_fd_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_food_fd_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_food_fd_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_food_qs_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_food_qs_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_food_qs_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_food_qs_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_food_qs_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_food_qs_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_golf_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_golf_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_golf_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_golf_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_golf_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_golf_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_liq_amt { get; set; } 
		@AuraEnabled global Decimal f_marker_play_game { get; set; } 
		@AuraEnabled global Decimal f_marker_play_oth { get; set; } 
		@AuraEnabled global Decimal f_marker_play_slot { get; set; } 
		@AuraEnabled global Decimal f_misc_amt { get; set; } 
		@AuraEnabled global Decimal f_na_bev_amt { get; set; } 
		@AuraEnabled global Decimal f_oth_amt { get; set; } 
		@AuraEnabled global Decimal f_other_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_other_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_other_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_other_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_other_comp_amt { get; set; } 
		@AuraEnabled global Decimal f_other_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_other_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_other_payment_amt { get; set; } 
		@AuraEnabled global Decimal f_other_rev { get; set; } 
		@AuraEnabled global Decimal f_package_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_package_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_package_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_package_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_package_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_package_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_pos_actual_profit_amt { get; set; } 
		@AuraEnabled global Decimal f_pos_avg_profit_amt { get; set; } 
		@AuraEnabled global Decimal f_pos_comp_amt { get; set; } 
		@AuraEnabled global Decimal f_retail_amt { get; set; } 
		@AuraEnabled global Decimal f_retail_le_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_retail_le_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_retail_le_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_retail_le_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_retail_le_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_retail_le_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_retail_owned_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_retail_owned_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_retail_owned_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_retail_owned_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_retail_owned_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_retail_owned_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_room_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_room_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_room_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_room_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_room_chrg_amt { get; set; } 
		@AuraEnabled global Decimal f_room_comp_amt { get; set; } 
		@AuraEnabled global Decimal f_room_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_room_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_room_rev { get; set; } 
		@AuraEnabled global Decimal f_service_charge_amt { get; set; } 
		@AuraEnabled global Decimal f_spa_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_spa_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_spa_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_spa_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_spa_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_spa_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_tax_amt { get; set; } 
		@AuraEnabled global Decimal f_tax_discount_oth_amt { get; set; } 
		@AuraEnabled global Decimal f_theo_all { get; set; } 
		@AuraEnabled global Decimal f_theo_game { get; set; } 
		@AuraEnabled global Decimal f_theo_oth { get; set; } 
		@AuraEnabled global Decimal f_theo_slot { get; set; } 
		@AuraEnabled global Decimal f_total_comp_amount { get; set; } 
		@AuraEnabled global Decimal f_total_item_amt { get; set; } 
		@AuraEnabled global Decimal f_total_payment_amt { get; set; } 
		@AuraEnabled global Decimal f_trans_amt { get; set; } 
		@AuraEnabled global Decimal f_transport_actual_profit { get; set; } 
		@AuraEnabled global Decimal f_transport_avg_profit { get; set; } 
		@AuraEnabled global Decimal f_transport_cash_rev { get; set; } 
		@AuraEnabled global Decimal f_transport_cash_tt { get; set; } 
		@AuraEnabled global Decimal f_transport_comp_rev { get; set; } 
		@AuraEnabled global Decimal f_transport_comp_tt { get; set; } 
		@AuraEnabled global Decimal f_wine_amt { get; set; } 
		@AuraEnabled global Decimal i_avgbet_div_game { get; set; } 
		@AuraEnabled global Decimal i_avgbet_div_oth { get; set; } 
		@AuraEnabled global Decimal i_avgbet_div_slot { get; set; } 
		@AuraEnabled global Decimal i_brand_trip_nbr { get; set; } 
		@AuraEnabled global Decimal i_comped_trip { get; set; } 
		@AuraEnabled global Decimal i_covers { get; set; } 
		@AuraEnabled global String i_dmid { get; set; } 
		@AuraEnabled global Decimal i_events { get; set; } 
		@AuraEnabled global Decimal i_len_of_play_game { get; set; } 
		@AuraEnabled global Decimal i_len_of_play_oth { get; set; } 
		@AuraEnabled global Decimal i_len_of_play_slot { get; set; } 
		@AuraEnabled global Decimal i_line_item_qty { get; set; } 
		@AuraEnabled global Decimal i_nbr_cms_trips { get; set; } 
		@AuraEnabled global Decimal i_nbr_cons_rev_days { get; set; } 
		@AuraEnabled global Decimal i_nbr_days { get; set; } 
		@AuraEnabled global Decimal i_nbr_line_item { get; set; } 
		@AuraEnabled global Decimal i_nbr_occupants { get; set; } 
		@AuraEnabled global Decimal i_nbr_offers_red { get; set; } 
		@AuraEnabled global Decimal i_nbr_offers_unred { get; set; } 
		@AuraEnabled global Decimal i_nbr_pos_days { get; set; } 
		@AuraEnabled global Decimal i_nbr_rev_centers { get; set; } 
		@AuraEnabled global Decimal i_nbr_rooms { get; set; } 
		@AuraEnabled global Decimal i_nbr_trans { get; set; } 
		@AuraEnabled global Decimal i_nbr_trip_game { get; set; } 
		@AuraEnabled global Decimal i_nbr_trip_oth { get; set; } 
		@AuraEnabled global Decimal i_nbr_trip_slot { get; set; } 
		@AuraEnabled global String i_pdb_trip_id { get; set; } 
		@AuraEnabled global Decimal i_rated_days { get; set; } 
		@AuraEnabled global Decimal i_rated_trips { get; set; } 
		@AuraEnabled global Decimal i_rm_night { get; set; } 
		@AuraEnabled global Decimal i_stay { get; set; } 
		@AuraEnabled global Decimal i_trip_nbr { get; set; } 
		@AuraEnabled global String week_code_fk { get; set; } 
		@AuraEnabled global String week_code_fk_Desc { get; set; } 
		@AuraEnabled global Decimal idc { get; set; }
		@AuraEnabled global String d_end_dt { get; set; } 
		@AuraEnabled global String d_rpt_per { get; set; } 
		@AuraEnabled global String d_start_dt { get; set; } 
		@AuraEnabled global String d_timestamp { get; set; } 
		//
		// PDB Info
		//
		//@AuraEnabled global String ExternalId { get; set; } 
		//@AuraEnabled global String Id { get; set; } 
		//@AuraEnabled global String account_c_prop_cd_fk { get; set; } 
		//@AuraEnabled global String c_prop_cd { get; set; } 
		@AuraEnabled global String c_user_flag_1 { get; set; } 
		@AuraEnabled global String c_user_flag_2 { get; set; } 
		@AuraEnabled global String c_user_flag_3 { get; set; } 
		@AuraEnabled global String c_user_flag_4 { get; set; } 
		//@AuraEnabled global String contact_fk { get; set; } 
		@AuraEnabled global Decimal f_cash_cost { get; set; } 
		@AuraEnabled global Decimal f_cash_value { get; set; } 
		@AuraEnabled global Decimal f_cashless_cost { get; set; } 
		@AuraEnabled global Decimal f_cashless_value { get; set; } 
		@AuraEnabled global Decimal f_exl_from_profitb_value { get; set; } 
		@AuraEnabled global Decimal f_hotel_cost { get; set; } 
		@AuraEnabled global Decimal f_hotel_value { get; set; } 
		@AuraEnabled global Decimal f_other_cost1 { get; set; } 
		@AuraEnabled global Decimal f_other_cost2 { get; set; } 
		@AuraEnabled global Decimal f_other_cost3 { get; set; } 
		@AuraEnabled global Decimal f_other_cost4 { get; set; } 
		@AuraEnabled global Decimal f_other_cost5 { get; set; } 
		@AuraEnabled global Decimal f_other_cost { get; set; } 
		@AuraEnabled global Decimal f_other_value { get; set; } 
		@AuraEnabled global Decimal f_total_cost { get; set; } 
		@AuraEnabled global Decimal f_trip_value1 { get; set; } 
		@AuraEnabled global Decimal f_trip_value2 { get; set; } 
		@AuraEnabled global Decimal f_trip_value3 { get; set; } 
		@AuraEnabled global Decimal f_trip_value4 { get; set; } 
		@AuraEnabled global Decimal f_trip_value5 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_10 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_1 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_2 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_3 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_4 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_5 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_6 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_7 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_8 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_9 { get; set; } 
		@AuraEnabled global Decimal i_cash_coup { get; set; } 
		@AuraEnabled global Decimal i_cashless_coup { get; set; } 
		//@AuraEnabled global String i_dmid { get; set; } 
		@AuraEnabled global Decimal i_exl_from_profitb_coup { get; set; } 
		@AuraEnabled global Decimal i_hotel_coup { get; set; } 
		@AuraEnabled global Decimal i_offers { get; set; } 
		@AuraEnabled global Decimal i_other_coup { get; set; } 
		//@AuraEnabled global String i_pdb_trip_id { get; set; } 
		@AuraEnabled global Decimal i_pdb_trip_id_fk { get; set; } 
		@AuraEnabled global Decimal i_total_coup { get; set; } 
		@AuraEnabled global Decimal i_user_score_10 { get; set; } 
		@AuraEnabled global Decimal i_user_score_1 { get; set; } 
		@AuraEnabled global Decimal i_user_score_2 { get; set; } 
		@AuraEnabled global Decimal i_user_score_3 { get; set; } 
		@AuraEnabled global Decimal i_user_score_4 { get; set; } 
		@AuraEnabled global Decimal i_user_score_5 { get; set; } 
		@AuraEnabled global Decimal i_user_score_6 { get; set; } 
		@AuraEnabled global Decimal i_user_score_7 { get; set; } 
		@AuraEnabled global Decimal i_user_score_8 { get; set; } 
		@AuraEnabled global Decimal i_user_score_9 { get; set; } 
		//@AuraEnabled global Decimal idc { get; set; } 
		//@AuraEnabled global String d_end_dt { get; set; } 
		//@AuraEnabled global String d_start_dt { get; set; } 
		//
		// PDB Trip Day
		//
		//@AuraEnabled global String Id { get; set; } 
		//@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String c_division_desc { get; set; } 
		@AuraEnabled global String c_market_cd { get; set; } 
		@AuraEnabled global String c_market_cd_fk { get; set; } 
		@AuraEnabled global String c_market_cd_fk_description { get; set; } 
		//@AuraEnabled global String c_prop_cd { get; set; } 
		@AuraEnabled global String c_prop_cd_fk { get; set; } 
		@AuraEnabled global String c_prop_cd_fk_name { get; set; } 
		@AuraEnabled global String c_prop_market_cd { get; set; } 
		@AuraEnabled global String c_prop_market_cd_fk { get; set; } 
		@AuraEnabled global String c_prop_market_cd_fk_name { get; set; } 
		//@AuraEnabled global String c_quality_cd { get; set; } 
		//@AuraEnabled global String contact { get; set; } 
		@AuraEnabled global String contact_name { get; set; } 
		@AuraEnabled global Decimal f_act_all { get; set; } 
		@AuraEnabled global Decimal f_act_game { get; set; } 
		@AuraEnabled global Decimal f_act_other { get; set; } 
		@AuraEnabled global Decimal f_act_slot { get; set; } 
		@AuraEnabled global Decimal f_actual_profit_amt { get; set; } 
		@AuraEnabled global Decimal f_avg_profit_amt { get; set; } 
		@AuraEnabled global Decimal f_cash_marker_game { get; set; } 
		@AuraEnabled global Decimal f_cash_marker_other { get; set; } 
		@AuraEnabled global Decimal f_cash_rev_amt { get; set; } 
		@AuraEnabled global Decimal f_cash_tt_amt { get; set; } 
		@AuraEnabled global Decimal f_coinin_slot { get; set; } 
		@AuraEnabled global Decimal f_comp_rev_amt { get; set; } 
		@AuraEnabled global Decimal f_comp_tt_amt { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_dec_food_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_dec_other_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_dec_room_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_dec_trans_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_dec_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_food_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_nondec_food_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_nondec_other_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_nondec_room_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_nondec_trans_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_nondec_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_other_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_room_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_trans_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_used { get; set; } 
		@AuraEnabled global Decimal f_rc_dlrs_food_used { get; set; } 
		@AuraEnabled global Decimal f_rc_dlrs_other_used { get; set; } 
		@AuraEnabled global Decimal f_rc_dlrs_room_used { get; set; } 
		@AuraEnabled global Decimal f_rc_dlrs_trans_used { get; set; } 
		@AuraEnabled global Decimal f_rc_dlrs_used { get; set; } 
		//@AuraEnabled global Decimal f_theo_all { get; set; } 
		//@AuraEnabled global Decimal f_theo_game { get; set; } 
		@AuraEnabled global Decimal f_theo_other { get; set; } 
		//@AuraEnabled global Decimal f_theo_slot { get; set; } 
		@AuraEnabled global Decimal f_total_cms_comps { get; set; } 
		@AuraEnabled global Decimal i_cash_cost { get; set; } 
		@AuraEnabled global Decimal i_cash_coupons { get; set; } 
		@AuraEnabled global Decimal i_comp_tickets { get; set; } 
		@AuraEnabled global Decimal i_division_sort { get; set; } 
		//@AuraEnabled global String i_dmid { get; set; } 
		@AuraEnabled global Decimal i_event_cost { get; set; } 
		@AuraEnabled global Decimal i_event_coupons { get; set; } 
		@AuraEnabled global Decimal i_fb_cost { get; set; } 
		@AuraEnabled global Decimal i_fb_coupons { get; set; } 
		@AuraEnabled global Decimal i_hotel_cost { get; set; } 
		@AuraEnabled global Decimal i_hotel_coupons { get; set; } 
		@AuraEnabled global Decimal i_lop_all { get; set; } 
		@AuraEnabled global Decimal i_lop_game { get; set; } 
		@AuraEnabled global Decimal i_lop_other { get; set; } 
		@AuraEnabled global Decimal i_lop_slot { get; set; } 
		@AuraEnabled global Decimal i_merchandise_cost { get; set; } 
		@AuraEnabled global Decimal i_merchandise_coupons { get; set; } 
		@AuraEnabled global Decimal i_other_cost { get; set; } 
		@AuraEnabled global Decimal i_other_coupons { get; set; } 
		//@AuraEnabled global String i_pdb_trip_id { get; set; } 
		@AuraEnabled global Decimal i_promo_rc_cost { get; set; } 
		@AuraEnabled global Decimal i_promo_rc_coupons { get; set; } 
		@AuraEnabled global Decimal i_prop_sort { get; set; } 
		@AuraEnabled global Decimal i_rrerr_cash_cost { get; set; } 
		@AuraEnabled global Decimal i_rrerr_cash_coupons { get; set; } 
		@AuraEnabled global Decimal i_tot_cost { get; set; } 
		@AuraEnabled global Decimal i_tot_coupons { get; set; } 
		//@AuraEnabled global Decimal idc { get; set; } 
		@AuraEnabled global String d_date { get; set; } 
		//@AuraEnabled global String d_end_dt_pdb_trip { get; set; } 
		//@AuraEnabled global String d_start_dt_pdb_trip { get; set; } 
		//@AuraEnabled global String d_timestamp { get; set; } 

		global PDBTripWrapper(){
	  	}	  	
	}

	/*******************************************************************************************************
    * @description Retrieve the PDB Trip data from pdb_trip_info table
    * @param List<Id> of Contact/External Ids used to retrieve
    * @return List<PDBTripInfoWrapper> containing the retrieved data
    * @example
    * List<GuestPDBTripCC.PDBTripInfoWrapper>  pdbTripInfoList = 
	*   		GuestPDBTripCC.retrievePPDBTripInfoByContacts(new List<String>{'0030v0000030aZdAAI'});    */
    @TestVisible private static List<pdb_trip_info__x> mockedPDBTripInfo = new List<pdb_trip_info__x>();

	//@RemoteAction
	//@AuraEnabled
	private static List<PDBTripInfoWrapper> retrievePDBTripInfoDetails(List<String> pdbTripIds) {
		system.debug('*** pdbTripIds ' + pdbTripIds);
		String whereClause = '  WHERE i_pdb_trip_id__c in';
		String idType = 'pdbTrip';
		return (new GuestPDBTripCC()).retrievePDBTripInfo(pdbTripIds, whereClause, idType);
	}

	//@RemoteAction
	//@AuraEnabled
	//global static List<PDBTripInfoWrapper> retrievePDBTripInfoByContacts(List<String> contactIds) {
	//	system.debug('*** contactIds ' + contactIds);
	//	String whereClause = ' and contact_fk__c in';
	//	String idType = 'contact';
	//	return (new GuestPDBTripCC()).retrievePDBTripInfo(contactIds, whereClause, idType);
	//}
	
	private List<PDBTripInfoWrapper> retrievePDBTripInfo(List<String> Ids, String whereClause, String idType) {	
		String soql1 = ' SELECT  ';	
		soql1 += ' Id, ';
		soql1 += ' ExternalId, ';
		soql1 += ' DisplayUrl, ';
		soql1 += ' account_c_prop_cd_fk__c, ';
		soql1 += ' c_prop_cd__c, ';
		soql1 += ' c_user_flag_1__c, ';
		soql1 += ' c_user_flag_2__c, ';
		soql1 += ' c_user_flag_3__c, ';
		soql1 += ' c_user_flag_4__c, ';
		soql1 += ' contact_fk__c, ';
		soql1 += ' f_cash_cost__c, ';
		soql1 += ' f_cash_value__c, ';
		soql1 += ' f_cashless_cost__c, ';
		soql1 += ' f_cashless_value__c, ';
		soql1 += ' f_exl_from_profitb_value__c, ';
		soql1 += ' f_hotel_cost__c, ';
		soql1 += ' f_hotel_value__c, ';
		soql1 += ' f_other_cost1__c, ';
		soql1 += ' f_other_cost2__c, ';
		soql1 += ' f_other_cost3__c, ';
		soql1 += ' f_other_cost4__c, ';
		soql1 += ' f_other_cost5__c, ';
		soql1 += ' f_other_cost__c, ';
		soql1 += ' f_other_value__c, ';
		soql1 += ' f_total_cost__c, ';
		soql1 += ' f_trip_value1__c, ';
		soql1 += ' f_trip_value2__c, ';
		soql1 += ' f_trip_value3__c, ';
		soql1 += ' f_trip_value4__c, ';
		soql1 += ' f_trip_value5__c, ';
		soql1 += ' f_user_amt_10__c, ';
		soql1 += ' f_user_amt_1__c, ';
		soql1 += ' f_user_amt_2__c, ';
		soql1 += ' f_user_amt_3__c, ';
		soql1 += ' f_user_amt_4__c, ';
		soql1 += ' f_user_amt_5__c, ';
		soql1 += ' f_user_amt_6__c, ';
		soql1 += ' f_user_amt_7__c, ';
		soql1 += ' f_user_amt_8__c, ';
		soql1 += ' f_user_amt_9__c, ';
		soql1 += ' i_cash_coup__c, ';
		soql1 += ' i_cashless_coup__c, ';
		soql1 += ' i_dmid__c, ';
		soql1 += ' i_exl_from_profitb_coup__c, ';
		soql1 += ' i_hotel_coup__c, ';
		soql1 += ' i_offers__c, ';
		soql1 += ' i_other_coup__c, ';
		soql1 += ' i_pdb_trip_id__c, ';
		soql1 += ' i_pdb_trip_id_fk__c, ';
		soql1 += ' i_total_coup__c, ';
		soql1 += ' i_user_score_10__c, ';
		soql1 += ' i_user_score_1__c, ';
		soql1 += ' i_user_score_2__c, ';
		soql1 += ' i_user_score_3__c, ';
		soql1 += ' i_user_score_4__c, ';
		soql1 += ' i_user_score_5__c, ';
		soql1 += ' i_user_score_6__c, ';
		soql1 += ' i_user_score_7__c, ';
		soql1 += ' i_user_score_8__c, ';
		soql1 += ' i_user_score_9__c, ';
		soql1 += ' id__c, ';
		soql1 += ' d_end_dt__c, ';
		soql1 += ' d_start_dt__c';

		soql1 += ' FROM pdb_trip_info__x  ';
		soql1 += whereClause + ' :ids';
		soql1 = String.escapeSingleQuotes(soql1);
		system.debug('*** soql1 ' + soql1);
		
		Map<String, PDBTripInfoWrapper> PDBTripInfoMap = new Map<String, PDBTripInfoWrapper> ();
		List<pdb_trip_info__x> PDBTripInfoList = (!mockedPDBTripInfo.isEmpty()) ? mockedPDBTripInfo : Database.query(soql1);
	  	updatePDBTripInfo (PDBTripInfoMap, PDBTripInfoList, '1');

	  	system.debug('*** PDBTripInfoMap.values() return ' + PDBTripInfoMap.values());

	  	return PDBTripInfoMap.values();
	}
	
    private static void updatePDBTripInfo (Map<String, PDBTripInfoWrapper> pdbTripInfoMap, List<pdb_trip_info__x> pdbTripInfoList, String pass){
    	PDBTripInfoWrapper pdbTripInfoWrap;
    	GuestPDBTripCC ghfCC = new GuestPDBTripCC();

		for (pdb_trip_info__x pdbTripInfo : pdbTripInfoList ){
			if (!pdbTripInfoMap.containsKey(pdbTripInfo.ExternalId)) {
				pdbTripInfoMap.put(pdbTripInfo.ExternalId, new PDBTripInfoWrapper());
			}
			pdbTripInfoWrap = pdbTripInfoMap.get(pdbTripInfo.ExternalId);
			if (pass == '1') {
  				pdbTripInfoWrap.Id = pdbTripInfo.Id;
				pdbTripInfoWrap.ExternalId = pdbTripInfo.ExternalId;
				pdbTripInfoWrap.account_c_prop_cd_fk = pdbTripInfo.account_c_prop_cd_fk__c;
				pdbTripInfoWrap.c_prop_cd = pdbTripInfo.c_prop_cd__c;
				pdbTripInfoWrap.c_user_flag_1 = pdbTripInfo.c_user_flag_1__c;
				pdbTripInfoWrap.c_user_flag_2 = pdbTripInfo.c_user_flag_2__c;
				pdbTripInfoWrap.c_user_flag_3 = pdbTripInfo.c_user_flag_3__c;
				pdbTripInfoWrap.c_user_flag_4 = pdbTripInfo.c_user_flag_4__c;
				pdbTripInfoWrap.contact_fk = pdbTripInfo.contact_fk__c;
				pdbTripInfoWrap.f_cash_cost = pdbTripInfo.f_cash_cost__c;
				pdbTripInfoWrap.f_cash_value = pdbTripInfo.f_cash_value__c;
				pdbTripInfoWrap.f_cashless_cost = pdbTripInfo.f_cashless_cost__c;
				pdbTripInfoWrap.f_cashless_value = pdbTripInfo.f_cashless_value__c;
				pdbTripInfoWrap.f_exl_from_profitb_value = pdbTripInfo.f_exl_from_profitb_value__c;
				pdbTripInfoWrap.f_hotel_cost = pdbTripInfo.f_hotel_cost__c;
				pdbTripInfoWrap.f_hotel_value = pdbTripInfo.f_hotel_value__c;
				pdbTripInfoWrap.f_other_cost1 = pdbTripInfo.f_other_cost1__c;
				pdbTripInfoWrap.f_other_cost2 = pdbTripInfo.f_other_cost2__c;
				pdbTripInfoWrap.f_other_cost3 = pdbTripInfo.f_other_cost3__c;
				pdbTripInfoWrap.f_other_cost4 = pdbTripInfo.f_other_cost4__c;
				pdbTripInfoWrap.f_other_cost5 = pdbTripInfo.f_other_cost5__c;
				pdbTripInfoWrap.f_other_cost = pdbTripInfo.f_other_cost__c;
				pdbTripInfoWrap.f_other_value = pdbTripInfo.f_other_value__c;
				pdbTripInfoWrap.f_total_cost = pdbTripInfo.f_total_cost__c;
				pdbTripInfoWrap.f_trip_value1 = pdbTripInfo.f_trip_value1__c;
				pdbTripInfoWrap.f_trip_value2 = pdbTripInfo.f_trip_value2__c;
				pdbTripInfoWrap.f_trip_value3 = pdbTripInfo.f_trip_value3__c;
				pdbTripInfoWrap.f_trip_value4 = pdbTripInfo.f_trip_value4__c;
				pdbTripInfoWrap.f_trip_value5 = pdbTripInfo.f_trip_value5__c;
				pdbTripInfoWrap.f_user_amt_10 = pdbTripInfo.f_user_amt_10__c;
				pdbTripInfoWrap.f_user_amt_1 = pdbTripInfo.f_user_amt_1__c;
				pdbTripInfoWrap.f_user_amt_2 = pdbTripInfo.f_user_amt_2__c;
				pdbTripInfoWrap.f_user_amt_3 = pdbTripInfo.f_user_amt_3__c;
				pdbTripInfoWrap.f_user_amt_4 = pdbTripInfo.f_user_amt_4__c;
				pdbTripInfoWrap.f_user_amt_5 = pdbTripInfo.f_user_amt_5__c;
				pdbTripInfoWrap.f_user_amt_6 = pdbTripInfo.f_user_amt_6__c;
				pdbTripInfoWrap.f_user_amt_7 = pdbTripInfo.f_user_amt_7__c;
				pdbTripInfoWrap.f_user_amt_8 = pdbTripInfo.f_user_amt_8__c;
				pdbTripInfoWrap.f_user_amt_9 = pdbTripInfo.f_user_amt_9__c;
				pdbTripInfoWrap.i_cash_coup = pdbTripInfo.i_cash_coup__c;
				pdbTripInfoWrap.i_cashless_coup = pdbTripInfo.i_cashless_coup__c;
				pdbTripInfoWrap.i_dmid = pdbTripInfo.i_dmid__c;
				pdbTripInfoWrap.i_exl_from_profitb_coup = pdbTripInfo.i_exl_from_profitb_coup__c;
				pdbTripInfoWrap.i_hotel_coup = pdbTripInfo.i_hotel_coup__c;
				pdbTripInfoWrap.i_offers = pdbTripInfo.i_offers__c;
				pdbTripInfoWrap.i_other_coup = pdbTripInfo.i_other_coup__c;
				pdbTripInfoWrap.i_pdb_trip_id = pdbTripInfo.i_pdb_trip_id__c;
				pdbTripInfoWrap.i_pdb_trip_id_fk = pdbTripInfo.i_pdb_trip_id_fk__c;
				pdbTripInfoWrap.i_total_coup = pdbTripInfo.i_total_coup__c;
				pdbTripInfoWrap.i_user_score_10 = pdbTripInfo.i_user_score_10__c;
				pdbTripInfoWrap.i_user_score_1 = pdbTripInfo.i_user_score_1__c;
				pdbTripInfoWrap.i_user_score_2 = pdbTripInfo.i_user_score_2__c;
				pdbTripInfoWrap.i_user_score_3 = pdbTripInfo.i_user_score_3__c;
				pdbTripInfoWrap.i_user_score_4 = pdbTripInfo.i_user_score_4__c;
				pdbTripInfoWrap.i_user_score_5 = pdbTripInfo.i_user_score_5__c;
				pdbTripInfoWrap.i_user_score_6 = pdbTripInfo.i_user_score_6__c;
				pdbTripInfoWrap.i_user_score_7 = pdbTripInfo.i_user_score_7__c;
				pdbTripInfoWrap.i_user_score_8 = pdbTripInfo.i_user_score_8__c;
				pdbTripInfoWrap.i_user_score_9 = pdbTripInfo.i_user_score_9__c;
				pdbTripInfoWrap.idc = pdbTripInfo.id__c;
				pdbTripInfoWrap.d_end_dt = ghfCC.stripTime(pdbTripInfo.d_end_dt__c);
				pdbTripInfoWrap.d_start_dt = ghfCC.stripTime(pdbTripInfo.d_start_dt__c);

				
		  	}
		  	pdbTripInfoMap.put(pdbTripInfoWrap.ExternalId, pdbTripInfoWrap);
	  	}

	}  
    
    	/*******************************************************************************************************
    * @description Wrapper class for pdb_trip_info__x
    */
	global class PDBTripInfoWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String Id { get; set; } 
		@AuraEnabled global String account_c_prop_cd_fk { get; set; } 
		@AuraEnabled global String c_prop_cd { get; set; } 
		@AuraEnabled global String c_user_flag_1 { get; set; } 
		@AuraEnabled global String c_user_flag_2 { get; set; } 
		@AuraEnabled global String c_user_flag_3 { get; set; } 
		@AuraEnabled global String c_user_flag_4 { get; set; } 
		@AuraEnabled global String contact_fk { get; set; } 
		@AuraEnabled global Decimal f_cash_cost { get; set; } 
		@AuraEnabled global Decimal f_cash_value { get; set; } 
		@AuraEnabled global Decimal f_cashless_cost { get; set; } 
		@AuraEnabled global Decimal f_cashless_value { get; set; } 
		@AuraEnabled global Decimal f_exl_from_profitb_value { get; set; } 
		@AuraEnabled global Decimal f_hotel_cost { get; set; } 
		@AuraEnabled global Decimal f_hotel_value { get; set; } 
		@AuraEnabled global Decimal f_other_cost1 { get; set; } 
		@AuraEnabled global Decimal f_other_cost2 { get; set; } 
		@AuraEnabled global Decimal f_other_cost3 { get; set; } 
		@AuraEnabled global Decimal f_other_cost4 { get; set; } 
		@AuraEnabled global Decimal f_other_cost5 { get; set; } 
		@AuraEnabled global Decimal f_other_cost { get; set; } 
		@AuraEnabled global Decimal f_other_value { get; set; } 
		@AuraEnabled global Decimal f_total_cost { get; set; } 
		@AuraEnabled global Decimal f_trip_value1 { get; set; } 
		@AuraEnabled global Decimal f_trip_value2 { get; set; } 
		@AuraEnabled global Decimal f_trip_value3 { get; set; } 
		@AuraEnabled global Decimal f_trip_value4 { get; set; } 
		@AuraEnabled global Decimal f_trip_value5 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_10 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_1 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_2 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_3 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_4 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_5 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_6 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_7 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_8 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_9 { get; set; } 
		@AuraEnabled global Decimal i_cash_coup { get; set; } 
		@AuraEnabled global Decimal i_cashless_coup { get; set; } 
		@AuraEnabled global String i_dmid { get; set; } 
		@AuraEnabled global Decimal i_exl_from_profitb_coup { get; set; } 
		@AuraEnabled global Decimal i_hotel_coup { get; set; } 
		@AuraEnabled global Decimal i_offers { get; set; } 
		@AuraEnabled global Decimal i_other_coup { get; set; } 
		@AuraEnabled global String i_pdb_trip_id { get; set; } 
		@AuraEnabled global Decimal i_pdb_trip_id_fk { get; set; } 
		@AuraEnabled global Decimal i_total_coup { get; set; } 
		@AuraEnabled global Decimal i_user_score_10 { get; set; } 
		@AuraEnabled global Decimal i_user_score_1 { get; set; } 
		@AuraEnabled global Decimal i_user_score_2 { get; set; } 
		@AuraEnabled global Decimal i_user_score_3 { get; set; } 
		@AuraEnabled global Decimal i_user_score_4 { get; set; } 
		@AuraEnabled global Decimal i_user_score_5 { get; set; } 
		@AuraEnabled global Decimal i_user_score_6 { get; set; } 
		@AuraEnabled global Decimal i_user_score_7 { get; set; } 
		@AuraEnabled global Decimal i_user_score_8 { get; set; } 
		@AuraEnabled global Decimal i_user_score_9 { get; set; } 
		@AuraEnabled global Decimal idc { get; set; } 
		@AuraEnabled global String d_end_dt { get; set; } 
		@AuraEnabled global String d_start_dt { get; set; } 

		
		global PDBTripInfoWrapper(){
	  	}	  	
	}	

	/*******************************************************************************************************
    * @description Retrieve the PDB Trip data from gst_pdb_trip_day_dtl_bidl__x table
    * @param List<Id> of Contact/External Ids used to retrieve
    * @return List<PDBTripDayWrapper> containing the retrieved data
    * @example
    * List<GuestPDBTripCC.PDBTripDayWrapper>  pdbTripDayList = 
	*   		GuestPDBTripCC.retrievePPDBTripDayByContacts(new List<String>{'0030v0000030aZdAAI'});    */
    @TestVisible private static List<gst_pdb_trip_day_dtl_bidl__x> mockedPDBTripDay = new List<gst_pdb_trip_day_dtl_bidl__x>();

	//@RemoteAction
	//@AuraEnabled
	private static List<PDBTripDayWrapper> retrievePDBTripDayDetails(List<String> pdbTripIds) {
		system.debug('*** pdbTripIds ' + pdbTripIds);
		String whereClause = '  WHERE i_pdb_trip_id__c in';
		String idType = 'pdbTrip';
		return (new GuestPDBTripCC()).retrievePDBTripDay(pdbTripIds, whereClause, idType);
	}

	//@RemoteAction
	//@AuraEnabled
	//global static List<PDBTripDayWrapper> retrievePDBTripDayByContacts(List<String> contactIds) {
	//	system.debug('*** contactIds ' + contactIds);
	//	String whereClause = ' and contact_fk__c in';
	//	String idType = 'contact';
	//	return (new GuestPDBTripCC()).retrievePDBTripDay(contactIds, whereClause, idType);
	//}
	
	private List<PDBTripDayWrapper> retrievePDBTripDay(List<String> Ids, String whereClause, String idType) {	
		String soql1 = ' SELECT  ';	
		soql1 += ' Id, ';
		soql1 += ' ExternalId, ';
		soql1 += ' c_division_desc__c, ';
		soql1 += ' c_market_cd__c, ';
		soql1 += ' c_market_cd_fk__c, ';
		soql1 += ' c_market_cd_fk__r.description__c, ';
		soql1 += ' c_prop_cd__c, ';
		soql1 += ' c_prop_cd_fk__c, ';
		soql1 += ' c_prop_cd_fk__r.Name, ';
		soql1 += ' c_prop_market_cd__c, ';
		soql1 += ' c_prop_market_cd_fk__c, ';
		soql1 += ' c_prop_market_cd_fk__r.Name, ';
		soql1 += ' c_quality_cd__c, ';
		soql1 += ' contact__c, ';
		soql1 += ' contact__r.Name, ';
		soql1 += ' f_act_all__c, ';
		soql1 += ' f_act_game__c, ';
		soql1 += ' f_act_other__c, ';
		soql1 += ' f_act_slot__c, ';
		soql1 += ' f_actual_profit_amt__c, ';
		soql1 += ' f_avg_profit_amt__c, ';
		soql1 += ' f_cash_marker_game__c, ';
		soql1 += ' f_cash_marker_other__c, ';
		soql1 += ' f_cash_rev_amt__c, ';
		soql1 += ' f_cash_tt_amt__c, ';
		soql1 += ' f_coinin_slot__c, ';
		soql1 += ' f_comp_rev_amt__c, ';
		soql1 += ' f_comp_tt_amt__c, ';
		soql1 += ' f_cw_dlrs_dec_food_used__c, ';
		soql1 += ' f_cw_dlrs_dec_other_used__c, ';
		soql1 += ' f_cw_dlrs_dec_room_used__c, ';
		soql1 += ' f_cw_dlrs_dec_trans_used__c, ';
		soql1 += ' f_cw_dlrs_dec_used__c, ';
		soql1 += ' f_cw_dlrs_food_used__c, ';
		soql1 += ' f_cw_dlrs_nondec_food_used__c, ';
		soql1 += ' f_cw_dlrs_nondec_other_used__c, ';
		soql1 += ' f_cw_dlrs_nondec_room_used__c, ';
		soql1 += ' f_cw_dlrs_nondec_trans_used__c, ';
		soql1 += ' f_cw_dlrs_nondec_used__c, ';
		soql1 += ' f_cw_dlrs_other_used__c, ';
		soql1 += ' f_cw_dlrs_room_used__c, ';
		soql1 += ' f_cw_dlrs_trans_used__c, ';
		soql1 += ' f_cw_dlrs_used__c, ';
		soql1 += ' f_rc_dlrs_food_used__c, ';
		soql1 += ' f_rc_dlrs_other_used__c, ';
		soql1 += ' f_rc_dlrs_room_used__c, ';
		soql1 += ' f_rc_dlrs_trans_used__c, ';
		soql1 += ' f_rc_dlrs_used__c, ';
		soql1 += ' f_theo_all__c, ';
		soql1 += ' f_theo_game__c, ';
		soql1 += ' f_theo_other__c, ';
		soql1 += ' f_theo_slot__c, ';
		soql1 += ' f_total_cms_comps__c, ';
		soql1 += ' i_cash_cost__c, ';
		soql1 += ' i_cash_coupons__c, ';
		soql1 += ' i_comp_tickets__c, ';
		soql1 += ' i_division_sort__c, ';
		soql1 += ' i_dmid__c, ';
		soql1 += ' i_event_cost__c, ';
		soql1 += ' i_event_coupons__c, ';
		soql1 += ' i_fb_cost__c, ';
		soql1 += ' i_fb_coupons__c, ';
		soql1 += ' i_hotel_cost__c, ';
		soql1 += ' i_hotel_coupons__c, ';
		soql1 += ' i_lop_all__c, ';
		soql1 += ' i_lop_game__c, ';
		soql1 += ' i_lop_other__c, ';
		soql1 += ' i_lop_slot__c, ';
		soql1 += ' i_merchandise_cost__c, ';
		soql1 += ' i_merchandise_coupons__c, ';
		soql1 += ' i_other_cost__c, ';
		soql1 += ' i_other_coupons__c, ';
		soql1 += ' i_pdb_trip_id__c, ';
		soql1 += ' i_promo_rc_cost__c, ';
		soql1 += ' i_promo_rc_coupons__c, ';
		soql1 += ' i_prop_sort__c, ';
		soql1 += ' i_rrerr_cash_cost__c, ';
		soql1 += ' i_rrerr_cash_coupons__c, ';
		soql1 += ' i_tot_cost__c, ';
		soql1 += ' i_tot_coupons__c, ';
		soql1 += ' id__c, ';
		soql1 += ' d_date__c, ';
		soql1 += ' d_end_dt_pdb_trip__c, ';
		soql1 += ' d_start_dt_pdb_trip__c, ';
		soql1 += ' d_timestamp__c ';

		soql1 += ' FROM gst_pdb_trip_day_dtl_bidl__x  ';
		soql1 += whereClause + ' :ids';
		soql1 = String.escapeSingleQuotes(soql1);
		system.debug('*** soql1 ' + soql1);
		
		Map<String, PDBTripDayWrapper> pdbTripDayMap = new Map<String, PDBTripDayWrapper> ();
		List<gst_pdb_trip_day_dtl_bidl__x> pdbTripDayList = (!mockedPDBTripDay.isEmpty()) ? mockedPDBTripDay : Database.query(soql1);
	  	updatePDBTripDay (pdbTripDayMap, pdbTripDayList, '1');

	  	system.debug('*** pdbTripDayMap.values() return ' + pdbTripDayMap.values());

	  	return pDBTripDayMap.values();
	}
	
    private static void updatePDBTripDay (Map<String, PDBTripDayWrapper> pdbTripDayMap, List<gst_pdb_trip_day_dtl_bidl__x> pdbTripDayList, String pass){
    	PDBTripDayWrapper pdbTripDayWrap;

		for (gst_pdb_trip_day_dtl_bidl__x pdbTripDay : pdbTripDayList ){
			if (!pdbTripDayMap.containsKey(pdbTripDay.ExternalId)) {
				pdbTripDayMap.put(pdbTripDay.ExternalId, new PDBTripDayWrapper());
			}
			pdbTripDayWrap = pdbTripDayMap.get(pdbTripDay.ExternalId);
			if (pass == '1') {
  				pdbTripDayWrap.Id = pdbTripDay.Id;
				pdbTripDayWrap.ExternalId = pdbTripDay.ExternalId;
				pdbTripDayWrap.c_division_desc = pdbTripDay.c_division_desc__c;
				pdbTripDayWrap.c_market_cd = pdbTripDay.c_market_cd__c;
				pdbTripDayWrap.c_market_cd_fk = pdbTripDay.c_market_cd_fk__c;
				pdbTripDayWrap.c_market_cd_fk_description = pdbTripDay.c_market_cd_fk__r.description__c;
				pdbTripDayWrap.c_prop_cd = pdbTripDay.c_prop_cd__c;
				pdbTripDayWrap.c_prop_cd_fk = pdbTripDay.c_prop_cd_fk__c;
				pdbTripDayWrap.c_prop_cd_fk_name = pdbTripDay.c_prop_cd_fk__r.Name;
				pdbTripDayWrap.c_prop_market_cd = pdbTripDay.c_prop_market_cd__c;
				pdbTripDayWrap.c_prop_market_cd_fk = pdbTripDay.c_prop_market_cd_fk__c;
				pdbTripDayWrap.c_prop_market_cd_fk_name = pdbTripDay.c_prop_market_cd_fk__r.Name;
				pdbTripDayWrap.c_quality_cd = pdbTripDay.c_quality_cd__c;
				pdbTripDayWrap.contact = pdbTripDay.contact__c;
				pdbTripDayWrap.contact_name = pdbTripDay.contact__r.Name;
				pdbTripDayWrap.f_act_all = pdbTripDay.f_act_all__c;
				pdbTripDayWrap.f_act_game = pdbTripDay.f_act_game__c;
				pdbTripDayWrap.f_act_other = pdbTripDay.f_act_other__c;
				pdbTripDayWrap.f_act_slot = pdbTripDay.f_act_slot__c;
				pdbTripDayWrap.f_actual_profit_amt = pdbTripDay.f_actual_profit_amt__c;
				pdbTripDayWrap.f_avg_profit_amt = pdbTripDay.f_avg_profit_amt__c;
				pdbTripDayWrap.f_cash_marker_game = pdbTripDay.f_cash_marker_game__c;
				pdbTripDayWrap.f_cash_marker_other = pdbTripDay.f_cash_marker_other__c;
				pdbTripDayWrap.f_cash_rev_amt = pdbTripDay.f_cash_rev_amt__c;
				pdbTripDayWrap.f_cash_tt_amt = pdbTripDay.f_cash_tt_amt__c;
				pdbTripDayWrap.f_coinin_slot = pdbTripDay.f_coinin_slot__c;
				pdbTripDayWrap.f_comp_rev_amt = pdbTripDay.f_comp_rev_amt__c;
				pdbTripDayWrap.f_comp_tt_amt = pdbTripDay.f_comp_tt_amt__c;
				pdbTripDayWrap.f_cw_dlrs_dec_food_used = pdbTripDay.f_cw_dlrs_dec_food_used__c;
				pdbTripDayWrap.f_cw_dlrs_dec_other_used = pdbTripDay.f_cw_dlrs_dec_other_used__c;
				pdbTripDayWrap.f_cw_dlrs_dec_room_used = pdbTripDay.f_cw_dlrs_dec_room_used__c;
				pdbTripDayWrap.f_cw_dlrs_dec_trans_used = pdbTripDay.f_cw_dlrs_dec_trans_used__c;
				pdbTripDayWrap.f_cw_dlrs_dec_used = pdbTripDay.f_cw_dlrs_dec_used__c;
				pdbTripDayWrap.f_cw_dlrs_food_used = pdbTripDay.f_cw_dlrs_food_used__c;
				pdbTripDayWrap.f_cw_dlrs_nondec_food_used = pdbTripDay.f_cw_dlrs_nondec_food_used__c;
				pdbTripDayWrap.f_cw_dlrs_nondec_other_used = pdbTripDay.f_cw_dlrs_nondec_other_used__c;
				pdbTripDayWrap.f_cw_dlrs_nondec_room_used = pdbTripDay.f_cw_dlrs_nondec_room_used__c;
				pdbTripDayWrap.f_cw_dlrs_nondec_trans_used = pdbTripDay.f_cw_dlrs_nondec_trans_used__c;
				pdbTripDayWrap.f_cw_dlrs_nondec_used = pdbTripDay.f_cw_dlrs_nondec_used__c;
				pdbTripDayWrap.f_cw_dlrs_other_used = pdbTripDay.f_cw_dlrs_other_used__c;
				pdbTripDayWrap.f_cw_dlrs_room_used = pdbTripDay.f_cw_dlrs_room_used__c;
				pdbTripDayWrap.f_cw_dlrs_trans_used = pdbTripDay.f_cw_dlrs_trans_used__c;
				pdbTripDayWrap.f_cw_dlrs_used = pdbTripDay.f_cw_dlrs_used__c;
				pdbTripDayWrap.f_rc_dlrs_food_used = pdbTripDay.f_rc_dlrs_food_used__c;
				pdbTripDayWrap.f_rc_dlrs_other_used = pdbTripDay.f_rc_dlrs_other_used__c;
				pdbTripDayWrap.f_rc_dlrs_room_used = pdbTripDay.f_rc_dlrs_room_used__c;
				pdbTripDayWrap.f_rc_dlrs_trans_used = pdbTripDay.f_rc_dlrs_trans_used__c;
				pdbTripDayWrap.f_rc_dlrs_used = pdbTripDay.f_rc_dlrs_used__c;
				pdbTripDayWrap.f_theo_all = pdbTripDay.f_theo_all__c;
				pdbTripDayWrap.f_theo_game = pdbTripDay.f_theo_game__c;
				pdbTripDayWrap.f_theo_other = pdbTripDay.f_theo_other__c;
				pdbTripDayWrap.f_theo_slot = pdbTripDay.f_theo_slot__c;
				pdbTripDayWrap.f_total_cms_comps = pdbTripDay.f_total_cms_comps__c;
				pdbTripDayWrap.i_cash_cost = pdbTripDay.i_cash_cost__c;
				pdbTripDayWrap.i_cash_coupons = pdbTripDay.i_cash_coupons__c;
				pdbTripDayWrap.i_comp_tickets = pdbTripDay.i_comp_tickets__c;
				pdbTripDayWrap.i_division_sort = pdbTripDay.i_division_sort__c;
				pdbTripDayWrap.i_dmid = pdbTripDay.i_dmid__c;
				pdbTripDayWrap.i_event_cost = pdbTripDay.i_event_cost__c;
				pdbTripDayWrap.i_event_coupons = pdbTripDay.i_event_coupons__c;
				pdbTripDayWrap.i_fb_cost = pdbTripDay.i_fb_cost__c;
				pdbTripDayWrap.i_fb_coupons = pdbTripDay.i_fb_coupons__c;
				pdbTripDayWrap.i_hotel_cost = pdbTripDay.i_hotel_cost__c;
				pdbTripDayWrap.i_hotel_coupons = pdbTripDay.i_hotel_coupons__c;
				pdbTripDayWrap.i_lop_all = pdbTripDay.i_lop_all__c;
				pdbTripDayWrap.i_lop_game = pdbTripDay.i_lop_game__c;
				pdbTripDayWrap.i_lop_other = pdbTripDay.i_lop_other__c;
				pdbTripDayWrap.i_lop_slot = pdbTripDay.i_lop_slot__c;
				pdbTripDayWrap.i_merchandise_cost = pdbTripDay.i_merchandise_cost__c;
				pdbTripDayWrap.i_merchandise_coupons = pdbTripDay.i_merchandise_coupons__c;
				pdbTripDayWrap.i_other_cost = pdbTripDay.i_other_cost__c;
				pdbTripDayWrap.i_other_coupons = pdbTripDay.i_other_coupons__c;
				pdbTripDayWrap.i_pdb_trip_id = pdbTripDay.i_pdb_trip_id__c;
				pdbTripDayWrap.i_promo_rc_cost = pdbTripDay.i_promo_rc_cost__c;
				pdbTripDayWrap.i_promo_rc_coupons = pdbTripDay.i_promo_rc_coupons__c;
				pdbTripDayWrap.i_prop_sort = pdbTripDay.i_prop_sort__c;
				pdbTripDayWrap.i_rrerr_cash_cost = pdbTripDay.i_rrerr_cash_cost__c;
				pdbTripDayWrap.i_rrerr_cash_coupons = pdbTripDay.i_rrerr_cash_coupons__c;
				pdbTripDayWrap.i_tot_cost = pdbTripDay.i_tot_cost__c;
				pdbTripDayWrap.i_tot_coupons = pdbTripDay.i_tot_coupons__c;
				pdbTripDayWrap.idc = pdbTripDay.id__c;
				pdbTripDayWrap.d_date = pdbTripDay.d_date__c;
				pdbTripDayWrap.d_end_dt_pdb_trip = pdbTripDay.d_end_dt_pdb_trip__c;
				pdbTripDayWrap.d_start_dt_pdb_trip = pdbTripDay.d_start_dt_pdb_trip__c;
				pdbTripDayWrap.d_timestamp = pdbTripDay.d_timestamp__c;

				
		  	}
		  	pdbTripDayMap.put(pdbTripDayWrap.ExternalId, pdbTripDayWrap);
	  	}

	}  
    
    	/*******************************************************************************************************
    * @description Wrapper class for pdb_trip_info__x
    */
	global class PDBTripDayWrapper {
		@AuraEnabled global String Id { get; set; } 
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String c_division_desc { get; set; } 
		@AuraEnabled global String c_market_cd { get; set; } 
		@AuraEnabled global String c_market_cd_fk { get; set; } 
		@AuraEnabled global String c_market_cd_fk_description { get; set; } 
		@AuraEnabled global String c_prop_cd { get; set; } 
		@AuraEnabled global String c_prop_cd_fk { get; set; } 
		@AuraEnabled global String c_prop_cd_fk_name { get; set; } 
		@AuraEnabled global String c_prop_market_cd { get; set; } 
		@AuraEnabled global String c_prop_market_cd_fk { get; set; } 
		@AuraEnabled global String c_prop_market_cd_fk_name { get; set; } 
		@AuraEnabled global String c_quality_cd { get; set; } 
		@AuraEnabled global String contact { get; set; } 
		@AuraEnabled global String contact_name { get; set; } 
		@AuraEnabled global Decimal f_act_all { get; set; } 
		@AuraEnabled global Decimal f_act_game { get; set; } 
		@AuraEnabled global Decimal f_act_other { get; set; } 
		@AuraEnabled global Decimal f_act_slot { get; set; } 
		@AuraEnabled global Decimal f_actual_profit_amt { get; set; } 
		@AuraEnabled global Decimal f_avg_profit_amt { get; set; } 
		@AuraEnabled global Decimal f_cash_marker_game { get; set; } 
		@AuraEnabled global Decimal f_cash_marker_other { get; set; } 
		@AuraEnabled global Decimal f_cash_rev_amt { get; set; } 
		@AuraEnabled global Decimal f_cash_tt_amt { get; set; } 
		@AuraEnabled global Decimal f_coinin_slot { get; set; } 
		@AuraEnabled global Decimal f_comp_rev_amt { get; set; } 
		@AuraEnabled global Decimal f_comp_tt_amt { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_dec_food_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_dec_other_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_dec_room_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_dec_trans_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_dec_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_food_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_nondec_food_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_nondec_other_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_nondec_room_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_nondec_trans_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_nondec_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_other_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_room_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_trans_used { get; set; } 
		@AuraEnabled global Decimal f_cw_dlrs_used { get; set; } 
		@AuraEnabled global Decimal f_rc_dlrs_food_used { get; set; } 
		@AuraEnabled global Decimal f_rc_dlrs_other_used { get; set; } 
		@AuraEnabled global Decimal f_rc_dlrs_room_used { get; set; } 
		@AuraEnabled global Decimal f_rc_dlrs_trans_used { get; set; } 
		@AuraEnabled global Decimal f_rc_dlrs_used { get; set; } 
		@AuraEnabled global Decimal f_theo_all { get; set; } 
		@AuraEnabled global Decimal f_theo_game { get; set; } 
		@AuraEnabled global Decimal f_theo_other { get; set; } 
		@AuraEnabled global Decimal f_theo_slot { get; set; } 
		@AuraEnabled global Decimal f_total_cms_comps { get; set; } 
		@AuraEnabled global Decimal i_cash_cost { get; set; } 
		@AuraEnabled global Decimal i_cash_coupons { get; set; } 
		@AuraEnabled global Decimal i_comp_tickets { get; set; } 
		@AuraEnabled global Decimal i_division_sort { get; set; } 
		@AuraEnabled global String i_dmid { get; set; } 
		@AuraEnabled global Decimal i_event_cost { get; set; } 
		@AuraEnabled global Decimal i_event_coupons { get; set; } 
		@AuraEnabled global Decimal i_fb_cost { get; set; } 
		@AuraEnabled global Decimal i_fb_coupons { get; set; } 
		@AuraEnabled global Decimal i_hotel_cost { get; set; } 
		@AuraEnabled global Decimal i_hotel_coupons { get; set; } 
		@AuraEnabled global Decimal i_lop_all { get; set; } 
		@AuraEnabled global Decimal i_lop_game { get; set; } 
		@AuraEnabled global Decimal i_lop_other { get; set; } 
		@AuraEnabled global Decimal i_lop_slot { get; set; } 
		@AuraEnabled global Decimal i_merchandise_cost { get; set; } 
		@AuraEnabled global Decimal i_merchandise_coupons { get; set; } 
		@AuraEnabled global Decimal i_other_cost { get; set; } 
		@AuraEnabled global Decimal i_other_coupons { get; set; } 
		@AuraEnabled global String i_pdb_trip_id { get; set; } 
		@AuraEnabled global Decimal i_promo_rc_cost { get; set; } 
		@AuraEnabled global Decimal i_promo_rc_coupons { get; set; } 
		@AuraEnabled global Decimal i_prop_sort { get; set; } 
		@AuraEnabled global Decimal i_rrerr_cash_cost { get; set; } 
		@AuraEnabled global Decimal i_rrerr_cash_coupons { get; set; } 
		@AuraEnabled global Decimal i_tot_cost { get; set; } 
		@AuraEnabled global Decimal i_tot_coupons { get; set; } 
		@AuraEnabled global Decimal idc { get; set; } 
		@AuraEnabled global String d_date { get; set; } 
		@AuraEnabled global String d_end_dt_pdb_trip { get; set; } 
		@AuraEnabled global String d_start_dt_pdb_trip { get; set; } 
		@AuraEnabled global String d_timestamp { get; set; } 

		
		global PDBTripDayWrapper(){
	  	}	  	
	}	
}