/**
* @author Sarah Kennedy
* @date July 2017
*
* @description Class to retrieve Shelf (Marketing Campaign) Data, extending base class GuestSubjectcDataBase.cls
*/
global with sharing class  GuestHotelFolioDataCC extends GuestSubjectDataBaseCC {

	global GuestHotelFolioDataCC() { }

	@TestVisible private static List<lms_hotel_activity__x> mockedActivity = new List<lms_hotel_activity__x>();
	@TestVisible private static List<guest_hotel_activity_vedw__x> mockedActivityVEDW = new List<guest_hotel_activity_vedw__x>();
	@TestVisible private static List<lms_folio_hdr__x> mockedFolioHeader = new List<lms_folio_hdr__x>();
	@TestVisible private static List<lms_folio_dtl__x> mockedFolioDetails = new List<lms_folio_dtl__x>();
	@TestVisible private static List<caesars_gst_id_xref__x> mockedXref = new List<caesars_gst_id_xref__x>();

	/*******************************************************************************************************
	* @description Retrieve the external data for Hotel Activity as view only
	* @param List<Id> of Contact Ids used to retrieve the Hotel Activity data
	* @return List<ActivityWrapper> containing the retrieved data
	* @example
	* List<GuestHotelFolioDataCC.ActivityWrapper>  activityList =
	*   		GuestHotelFolioDataCC.retrieveHotelActivity(List<Id> contactIds);
	*/
	@RemoteAction
	@AuraEnabled
	global static List<ActivityWrapper> retrieveHotelActivityDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = ' WHERE ExternalId in';
		String whereClause2 = '';
		String idType = 'external';
		return retrieveHotelActivity(externalIds, whereClause, whereClause2, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<ActivityWrapper> retrieveHotelActivityByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact1__c in';
		String whereClause2 = ' OR contact2__c in';
		String idType = 'contact';
		return retrieveHotelActivity(contactIds, whereClause, whereClause2, idType);
	}

	private static List<ActivityWrapper> retrieveHotelActivity(List<String> ids, String whereClause1, String whereClause2, String idType) {
		system.debug('*** whereClause1 ' + whereClause1);
		system.debug('*** whereClause2 ' + whereClause2);
		system.debug('*** idType ' + idType);
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged activities
		//

		String whereClause3 = '';
		List<String> allContactIds = new List<String>();
		List<String> winetIds = new List<String>();
		if (idType == 'contact') {
			for (Contact c :  [SELECT Id, winet_id__c FROM Contact WHERE Id in : ids]){
				if (String.IsBlank(c.winet_id__c)){
					allContactIds.add(c.Id);
				} else {
					winetIds.add(c.winet_id__c);
				}
			}
			//
			// VEDW has the correct dmids. Retreve the VEDW records to find the reserve Id and Prop Cd for then accessing the LMS table
			if (winetIds.size() > 0){
				for (guest_hotel_activity_vedw__x vedw : [SELECT f_reserve_id__c, c_prop_cd__c 
															FROM guest_hotel_activity_vedw__x 
															WHERE i_dmid__c in: winetIds OR i_sec_dmid__c in: winetIds]){

					if (String.isBlank(whereClause3) &&
						allContactIds.size() == 0){
						whereClause3 = ' WHERE (f_reserve_id__c = \'' + String.escapeSingleQuotes(vedw.f_reserve_id__c) + '\'' + ' AND c_prop_cd__c =  \'' + String.escapeSingleQuotes(vedw.c_prop_cd__c)  + '\')';
					} else {
						whereClause3 += ' OR (f_reserve_id__c = \'' + String.escapeSingleQuotes(vedw.f_reserve_id__c) + '\'' + ' AND c_prop_cd__c = \'' + String.escapeSingleQuotes(vedw.c_prop_cd__c) + '\')';
					}
				}
			}
		}
		String soql1 = ' SELECT externalid, ';
		soql1 += ' f_reserve_id__c, ';
		soql1 += ' c_cancel_agent_id__c, ';
		soql1 += ' c_cancel_id__c, ';
		soql1 += ' c_checkin_agent_id__c, ';
		soql1 += ' c_checkin_location__c, ';
		soql1 += ' c_checkout_agent_id__c, ';
		soql1 += ' c_checkout_location__c, ';
		soql1 += ' c_city__c, ';
		soql1 += ' c_confirm_email__c, ';
		soql1 += ' c_confirm_id__c, ';
		soql1 += ' contact1__c, ';
		soql1 += ' contact2__c, ';
		soql1 += ' c_credit_card_auth_nbr__c, ';
		soql1 += ' c_credit_card_exp_dt__c, ';
		soql1 += ' c_credit_card_nbr__c, ';
		soql1 += ' source_code_fk__c, ';
		soql1 += ' source_code_fk__r.Code__c, ';
		soql1 += ' hotel_act_status_code_fk__r.Description__c, ';
		soql1 += ' c_prop_cd__c ';
		soql1 += ' FROM lms_hotel_activity__x  ';
		if (idType == 'contact') {
			if (allContactIds.size() > 0){
				soql1 += whereClause1 + ': allContactIds';
				soql1 += whereClause2 + ': allContactIds';
			}
			if (!String.IsBlank(whereclause3)){
				soql1 += whereclause3;
			}
		} else {
			soql1 += whereClause1 + ': ids';
		}

		system.debug('*** soql1 ' + soql1);

		String soql2 = ' SELECT externalid, ';
		soql2 += ' f_reserve_id__c, ';
		soql2 += ' customer_control_segments_fk__r.c_control_segment_desc__c ,';
		soql2 += ' hotel_wing_codes_fk__r.Code__c, ';
		soql2 += ' lms_room_type_desc_sda_fk__r.c_rm_type__c , ';
		soql2 += ' c_prop_cd__c ';
		soql2 += ' FROM lms_hotel_activity__x  ';
		if (idType == 'contact') {
			if (allContactIds.size() > 0){
				soql2 += whereClause1 + ': allContactIds';
				soql2 += whereClause2 + ': allContactIds';
			}
			if (!String.IsBlank(whereclause3)){
				soql2 += whereclause3;
			}
		} else {
			soql2 += whereClause1 + ': ids';
		}
		//
		// read the hotel activity
		//
		String soqlx = ' SELECT externalid, ';
		soqlx += ' f_reserve_id__c, ';
		soqlx += ' c_activity_status__c, ';
		soqlx += ' c_prop_cd__c, ';

		soqlx += ' d_checkin_dt__c, ';
		soqlx += ' d_arrival_dt__c, ';
		soqlx += ' d_checkout_dt__c, ';
		soqlx += ' d_departure_dt__c, ';
		soqlx += ' d_reserve_dt__c, ';
		soqlx += ' i_rm_night__c, ';
		soqlx += ' f_room_rev__c, ';
		soqlx += ' c_quality_cd__c, ';

		soqlx += ' c_reservation_agent_id__c, ';
		
		soqlx += ' f_comp_room_rev__c, ';

		soqlx += ' source_code_fk__r.Description__c, ';
		soqlx += ' source_code_fk__c, ';

		soqlx += ' hotel_wing_codes_fk__r.Code__c, ';
		soqlx += ' hotel_wing_codes_fk__r.Description__c, ';

		soqlx += '  c_first_name__c, ';
		soqlx += '  c_last_name__c, ';
		soqlx += '  c_sec_cas_guest_id__c, ';

		soqlx += '  c_pri_cas_guest_id__c, ';

		soqlx += '  d_transaction_dt__c, ';
		soqlx += '  d_cancel_dt__c, ';
		soqlx += '  c_share_id__c, ';
		soqlx += '  i_nbr_shares__c, ';
		soqlx += '  c_transaction_agent_id__c, ';
		soqlx += '  c_wing_cd__c, ';
		soqlx += '  c_original_wing_cd__c, ';
		soqlx += '  c_original_rm_type__c, ';
		soqlx += '  c_rm_nbr__c, ';
		soqlx += '  i_nbr_rooms__c, ';
		soqlx += '  i_nbr_occupants__c, ';
		soqlx += '  c_source_cd__c, ';
		soqlx += '  c_rate_plan__c, ';
		soqlx += '  c_group_cd__c, ';
		//soqlx += '  i_group_id__c, ';
		soqlx += '  c_group_type__c, ';
		soqlx += '  c_state_cd__c, ';
		soqlx += '  c_zip_cd__c, ';
		soqlx += '  c_offer_id__c, ';
		soqlx += '  i_customer_segment__c, ';
		soqlx += '  c_tracking__c, ';
		soqlx += '  c_settle_method__c, ';
		soqlx += '  f_deposit_amt_req__c, ';
		soqlx += '  f_deposit_credit_card_chg__c, ';
		soqlx += '  f_room_rev_reserved__c, ';
		soqlx += '  f_room_tax_reserved__c, ';
		//soqlx += '  d_checkout_time__c, ';
		soqlx += '  f_fb_rev__c, ';
		soqlx += '  f_other_rev__c, ';
		soqlx += '  f_comp_fb_rev__c, ';
		soqlx += '  f_comp_other_rev__c, ';
		soqlx += '  d_timestamp__c, ';
		// soqlx += '  d_checkin_time__c, ';

		soqlx += '  c_occupant_type__c, ';

		soqlx += '  hotel_act_status_code_fk__r.description__c ';

		soqlx += ' FROM lms_hotel_activity__x  ';
		if (idType == 'contact') {
			if (allContactIds.size() > 0){
				soqlx += whereClause1 + ': allContactIds';
				soqlx += whereClause2 + ': allContactIds';
			}
			if (!String.IsBlank(whereclause3)){
				soqlx += whereclause3;
			}
		} else {
			soqlx += whereClause1 + ': ids';
		}

		String soqlx2 = ' SELECT externalid, ';
		soqlx2 += ' f_reserve_id__c, ';
		soqlx2 += ' c_prop_cd__c, ';
		soqlx2 += ' c_prop_cd_fk__r.Name, ';
		soqlx2 += ' lms_room_type_desc_sda_fk__r.c_room_quality__c, ';
		soqlx2 += ' lms_room_type_desc_sda_fk__r.c_room_smoking__c, ';
		soqlx2 += ' lms_room_type_desc_sda_fk__r.c_room_bed_type__c, ';
		soqlx2 += ' lms_room_type_desc_sda_fk__r.c_room_accessible__c, ';
		soqlx2 += '  lms_room_type_desc_sda_fk__r.c_room_desc1__c, ';
		soqlx2 += ' lms_room_type_desc_sda_fk__r.c_rm_type__c, ';
		soqlx2 += '  customer_control_segments_fk__r.c_customer_segment_desc__c, ';
		soqlx2 += '  customer_control_segments_fk__r.c_customer_segment_short_desc__c, ';
		soqlx2 += ' customer_control_segments_fk__r.i_control_segment__c, ';
		soqlx2 += ' customer_control_segments_fk__r.c_incented_status__c, ';
		soqlx2 += '  customer_control_segments_fk__r.c_known_status__c ';
		soqlx2 += ' FROM lms_hotel_activity__x  ';
		if (idType == 'contact') {
			if (allContactIds.size() > 0){
				soqlx2 += whereClause1 + ': allContactIds';
				soqlx2 += whereClause2 + ': allContactIds';
			}
			if (!String.IsBlank (whereclause3)){
				soqlx2 += whereclause3;
			}
		} else {
			soqlx2 += whereClause1 + ': ids';
		}

		// load the Activity wrapper
		//
		Map<String, ActivityWrapper> activityMap = new Map<String, ActivityWrapper> ();
		List<lms_hotel_activity__x> activityList;

		if (idType == 'external') {

			activityList = (!mockedActivity.isEmpty()) ? mockedActivity : Database.query(soql1);
			updateActivity (activityMap, activityList, '1');

			activityList = (!mockedActivity.isEmpty()) ? mockedActivity : Database.query(soql2);
			updateActivity (activityMap, activityList, '2');
		}

		system.debug('*** soqlx ' + soqlx);
		activityList = (!mockedActivity.isEmpty()) ? mockedActivity : Database.query(soqlx);
		system.debug('*** activityList ' + activityList);
		updateActivity (activityMap, activityList, '3');

		//soqlx2 = String.escapeSingleQuotes(soqlx2);
		system.debug('*** soqlx2 ' + soqlx2);
		activityList = (!mockedActivity.isEmpty()) ? mockedActivity : Database.query(soqlx2);
		system.debug('*** activityList ' + activityList);
		updateActivity (activityMap, activityList, '4');
		
		//
		// get the source cd ids and retrieve the lmssourcedescsda records
		//
		Set<String> sourceIds = new Set<String>();
		for (ActivityWrapper awrap : activityMap.values()){
			if (awrap.source_code_fk != null){
				sourceIds.add(awrap.source_code_fk);
			}
			
		}

		for (LMSSourceDescSda__c lms : [SELECT Id, c_source_cd__c, c_source_cd_desc__c, c_source_cat2__c, c_source_group__c, c_rms_group_source_cd__c
											FROM LMSSourceDescSda__c
											WHERE c_source_cd__c in : sourceIds]){
			for (ActivityWrapper awrap : activityMap.values()){
				if (awrap.source_code_fk == lms.c_source_cd__c){
					awrap.c_source_cd_desc= lms.c_source_cd_desc__c;
					awrap.c_source_cat2= lms.c_source_cat2__c;
					awrap.bookingMainSource= lms.c_source_cat2__c;
					awrap.c_source_group= lms.c_source_group__c;
					awrap.c_rms_group_source_cd = lms.c_rms_group_source_cd__c;
				}
			}
		}

		//
		// load reserveActivityMap with the Activity data
		//
		// note that the reserveActivityMap has a key of f_reserve_id__c + ':' + prop_cd
		//
		Map<String, ActivityWrapper> reserveActivityMap = new Map<String, ActivityWrapper>();
		system.debug('*** activityMap.values() ' + activityMap.values());

		ActivityWrapper activityWrap;
		for (ActivityWrapper awrap : activityMap.values()) {
			if (!reserveActivityMap.containsKey(awrap.f_reserve_id + ':' + awrap.c_prop_cd)) {
				reserveActivityMap.put(awrap.f_reserve_id + ':' + awrap.c_prop_cd, awrap);
			}
		}
		system.debug('*** reserveActivityMap ' + reserveActivityMap);
		//
		// read the VEDW data and load it into the ActivityWrapper in the reserveActivityMap
		//
		List<ActivityVEDWWrapper>  vedwWrapList;

		List<String> reservePropIds = new List<String>();
		reservePropIds.addAll(reserveActivityMap.keySet());

		vedwWrapList = retrieveHotelActivityVEDWDetails(reservePropIds);

		for (ActivityVEDWWrapper vedwWrap : vedwWrapList) {
			system.debug('*** resProp ' + vedwWrap.f_reserve_id + ':' + vedwWrap.c_prop_cd);
			if (!reserveActivityMap.containsKey(vedwWrap.f_reserve_id + ':' + vedwWrap.c_prop_cd)) {
				reserveActivityMap.put(vedwWrap.f_reserve_id + ':' + vedwWrap.c_prop_cd, new activityWrapper());
			}
			activityWrap = reserveActivityMap.get(vedwWrap.f_reserve_id + ':' + vedwWrap.c_prop_cd);
			activitywrap.c_activity_status  = vedwWrap.c_activity_status;
			activitywrap.c_address_1  = vedwWrap.c_address_1;
			activitywrap.c_address_2  = vedwWrap.c_address_2;
			activitywrap.contact  = vedwWrap.contact;
			activitywrap.hotel_act_status_code_fk  = vedwWrap.hotel_act_status_code_fk;
			activitywrap.i_sec_dmid  = vedwWrap.i_sec_dmid;
			activityWrap.c_cancel_agent_id = vedwWrap.c_cancel_agent_id;
			activityWrap.c_cancel_id = vedwWrap.c_cancel_id;
			activityWrap.c_checkin_agent_id = vedwWrap.c_checkin_agent_id;
			activityWrap.c_checkin_location = vedwWrap.c_checkin_location;
			activityWrap.c_checkout_agent_id = vedwWrap.c_checkout_agent_id;
			activityWrap.c_checkout_location = vedwWrap.c_checkout_location;	
			activityWrap.i_sec_dmid = vedwWrap.i_sec_dmid	 ;
			//activityWrap.f_reserve_id = vedwWrap.f_reserve_id ;
			activityWrap.i_checkin_yr = vedwWrap.i_checkin_yr;
			activityWrap.i_checkin_mn = vedwWrap.i_checkin_mn;
			activityWrap.i_checkin_dy = vedwWrap.i_checkin_dy;
			activityWrap.i_checkin_hr = vedwWrap.i_checkin_hr;
			activityWrap.i_checkin_min = vedwWrap.i_checkin_min;
			activityWrap.i_checkin_sec = vedwWrap.i_checkin_sec;
			activityWrap.i_checkout_yr = vedwWrap.i_checkout_yr;
			activityWrap.i_checkout_mn = vedwWrap.i_checkout_mn;
			activityWrap.i_checkout_dy = vedwWrap.i_checkout_dy;
			activityWrap.i_checkout_hr = vedwWrap.i_checkout_hr;
			activityWrap.i_checkout_min = vedwWrap.i_checkout_min;
			activityWrap.i_checkout_sec = vedwWrap.i_checkout_sec;
			activityWrap.i_stay_id = vedwWrap.i_stay_id;
			activityWrap.i_dmid = vedwWrap.i_dmid;
			activityWrap.i_cms_dmid = vedwWrap.i_cms_dmid;
			activityWrap.i_sec_cms_dmid = vedwWrap.i_sec_cms_dmid;
			activityWrap.i_group_id = vedwWrap.i_group_id;

			activityWrap.d_reserve_rpt_period = vedwWrap.d_reserve_rpt_period;
			activityWrap.d_cancel_rpt_period = vedwWrap.d_cancel_rpt_period;
			activityWrap.d_checkin_rpt_period = vedwWrap.d_checkin_rpt_period;
			activityWrap.d_checkout_rpt_period = vedwWrap.d_checkout_rpt_period;
			//activityWrap.prop_cd = vedwWrap.c_prop_cd;
			activityWrap.vedwExternalId = vedwWrap.ExternalId;

			reserveActivityMap.put(vedwWrap.f_reserve_id + ':' + vedwWrap.c_prop_cd, activityWrap);
		}

		return reserveActivityMap.values();
	}			

	/*******************************************************************************************************
	* @description Update the ActivityWrapper with soql results
	* @param Map<String, ActivityWrapper> activityMap
	* @param List<lms_hotel_activity__x>
	* @param String pass - which fields to update based on the soql that was run
	* @return List<ActivityWrapper> containing the updated data
	* @example
	* List<GuestHotelFolioDataCC.ActivityWrapper>  wrapperList =
	*   		GuestHotelFolioDataCC.updateActivity(Map<String, ActivityWrapper> activityMap, List<lms_hotel_activity__x> activityList, String pass);
	*/
	private static void updateActivity (Map<String, ActivityWrapper> activityMap, List<lms_hotel_activity__x> activityList, String pass) {
		ActivityWrapper activityWrap;
		GuestHotelFolioDataCC ghfCC = new GuestHotelFolioDataCC();


		for (lms_hotel_activity__x activity : activityList ) {
			if (!activityMap.containsKey(activity.ExternalId)) {
				activityMap.put(activity.ExternalId, new activityWrapper());
			}
			activityWrap = activityMap.get(activity.ExternalId);
			if (pass == '1') {
				activityWrap.ExternalId = activity.ExternalId;
				activityWrap.f_reserve_id = activity.f_reserve_id__c;
				activityWrap.c_prop_cd = activity.c_prop_cd__c;
				activityWrap.c_cancel_agent_id = activity.c_cancel_agent_id__c;
				activityWrap.c_cancel_id = activity.c_cancel_id__c;
				activityWrap.c_checkin_agent_id = activity.c_checkin_agent_id__c;
				activityWrap.c_checkin_location = activity.c_checkin_location__c;
				activityWrap.c_checkout_agent_id = activity.c_checkout_agent_id__c;
				activityWrap.c_checkout_location = activity.c_checkout_location__c;
				activityWrap.c_city = activity.c_city__c;
				activityWrap.c_confirm_email = activity.c_confirm_email__c;
				activityWrap.c_confirm_id = activity.c_confirm_id__c;
				activityWrap.c_credit_card_auth_nbr = activity.c_credit_card_auth_nbr__c;
				activityWrap.c_credit_card_exp_dt = activity.c_credit_card_exp_dt__c;
				activityWrap.c_credit_card_nbr = activity.c_credit_card_nbr__c;
				activityWrap.source_cd = activity.source_code_fk__r.Code__c ;
				activityWrap.source_code_fk = activity.source_code_fk__c;
				activityWrap.hotel_act_status_cd = activity.hotel_act_status_code_fk__r.Description__c;

				activityWrap.contact1 = activity.contact1__c;
				activityWrap.contact2 = activity.contact2__c;

			}
			if (pass == '2') {
				activityWrap.ExternalId = activity.ExternalId;
				activityWrap.f_reserve_id = activity.f_reserve_id__c;
				activityWrap.c_prop_cd = activity.c_prop_cd__c;
				activityWrap.customer_control_segment_desc = activity.customer_control_segments_fk__r.c_control_segment_desc__c ;
				activityWrap.hotel_wing_cd = activity.hotel_wing_codes_fk__r.Code__c;
				activityWrap.lms_room_type_desc_sda = activity.lms_room_type_desc_sda_fk__r.c_rm_type__c;

			}
			if (pass == '3') {
				activityWrap.ExternalId = activity.ExternalId;
				activityWrap.f_reserve_id = activity.f_reserve_id__c;
				activityWrap.c_prop_cd = activity.c_prop_cd__c;

				if (activity.c_activity_status__c == 'I' ||
				        activity.c_activity_status__c == 'O') {
					activityWrap.d_checkin_dt = ghfCC.stripTime(activity.d_checkin_dt__c);
				} else {
					activityWrap.d_checkin_dt = ghfCC.stripTime(activity.d_arrival_dt__c);
				}
				if (activity.c_activity_status__c == 'O') {
					activityWrap.d_checkout_dt = ghfCC.stripTime(activity.d_checkout_dt__c);
				} else {
					activityWrap.d_checkout_dt = ghfCC.stripTime(activity.d_departure_dt__c);
				}
				if (!String.IsBlank(activity.c_reservation_agent_id__c)){

					if (activity.c_reservation_agent_id__c == 'INTERNET') {
						activityWrap.bookHow = 'CZR.Com';
					} else if (activity.c_reservation_agent_id__c.left(3) == 'OTA') {
						activityWrap.bookHow = '3rd Party Web';
					} else if (activity.c_reservation_agent_id__c.left(1) == '$') {
						activityWrap.bookHow = 'SMART';
					} else if (activity.c_reservation_agent_id__c == 'PASSKEYRES') {
						activityWrap.bookHow = 'PassKey';
					} else if (activity.c_reservation_agent_id__c.left(3) == 'LV2') {
						activityWrap.bookHow = 'LV CCS';
					}  else if (activity.c_reservation_agent_id__c.left(3) == 'LV2' ||
					            activity.c_reservation_agent_id__c.left(3) == 'VIP' ||
					            activity.c_reservation_agent_id__c.left(3) == 'LVR' ||
					            activity.c_reservation_agent_id__c.left(3) == 'WST' ||
					            activity.c_reservation_agent_id__c.left(3) == 'WMK' ||
					            activity.c_reservation_agent_id__c.left(3) == 'WSP' ||
					            activity.c_reservation_agent_id__c.left(3) == 'WPN' ||
					            activity.c_reservation_agent_id__c.left(3) == 'WPT' ||
					            activity.c_reservation_agent_id__c.left(3) == 'LVC' ||
					            activity.c_reservation_agent_id__c.left(3) == 'TA2' ||
					            activity.c_reservation_agent_id__c.left(3) == 'TC1' ||
					            activity.c_reservation_agent_id__c.left(3) == 'NCC' ) {
						activityWrap.bookHow = '1-800-CZR';
					} else {
						activityWrap.bookHow = 'Other/Prop';
					}
				}
				system.debug('*** d_arrival_dt__c ' + activity.d_arrival_dt__c);
				system.debug('*** d_reserve_dt__c ' + activity.d_reserve_dt__c);
				if (!String.isBlank(activity.d_arrival_dt__c) &&
				        !String.isBlank(activity.d_reserve_dt__c)) {
					Integer yArr = Integer.valueOf(activity.d_arrival_dt__c.substring(0, 4));
					Integer mArr = Integer.valueOf(activity.d_arrival_dt__c.substring(5, 7));
					Integer dArr = Integer.valueOf(activity.d_arrival_dt__c.substring(8, 10));
					Date arrDate = date.newinstance(yArr, mArr, dArr);
					system.debug('*** arrDate ' + arrDate);
					Integer yRes = Integer.valueOf(activity.d_reserve_dt__c.substring(0, 4));
					Integer mRes = Integer.valueOf(activity.d_reserve_dt__c.substring(5, 7));
					Integer dRes = Integer.valueOf(activity.d_reserve_dt__c.substring(8, 10));
					Date resDate = date.newinstance(yRes, mRes, dRes);
					system.debug('*** resDate ' + resDate);

					activityWrap.daysBooked = resDate.daysBetween(arrDate);
					system.debug('*** activityWrap.daysBooked ' + activityWrap.daysBooked);
				}

				if (activity.f_room_rev__c != null &&
					activity.i_rm_night__c != null){
					activityWrap.avgRoomRate = (activity.f_room_rev__c / (activity.i_rm_night__c + 0.01)).setScale(2);
				}
				if (activity.f_comp_room_rev__c != null){
					activityWrap.roomComped = activity.f_comp_room_rev__c >= 1 ? 'Yes' : 'No';
				} else {
					activityWrap.roomComped = 'No';
				}

				activityWrap.i_rm_night = activity.i_rm_night__c;
				


				activityWrap.c_quality_cd = activity.c_quality_cd__c;

				activityWrap.source_code_Description = activity.source_code_fk__r.Description__c;


				if (activity.c_activity_status__c == 'O') {
					activityWrap.status = 'Past Stay';
				} else if (activity.c_activity_status__c == 'I') {
					activityWrap.status = 'In House';
				} else if (activity.c_activity_status__c == 'X') {
					activityWrap.status = 'Cancel';
				} else {
					activityWrap.status = 'Future Res';
				}

				activityWrap.hotel_wing_codes_Code = activity.hotel_wing_codes_fk__r.Description__c + ' - ' + activity.hotel_wing_codes_fk__r.Code__c;


				activityWrap.c_pri_cas_guest_id = activity.c_pri_cas_guest_id__c;
				activityWrap.c_first_name = activity.c_first_name__c;
				activityWrap.c_sec_cas_guest_id = activity.c_sec_cas_guest_id__c;

				activityWrap.c_last_name = activity.c_last_name__c;

				activityWrap.d_arrival_dt = ghfCC.stripTime(activity.d_arrival_dt__c);

				
				activityWrap.d_transaction_dt = ghfCC.stripTime(activity.d_transaction_dt__c);
				activityWrap.d_reserve_dt = ghfCC.stripTime(activity.d_reserve_dt__c);				
				activityWrap.d_cancel_dt = ghfCC.stripTime(activity.d_cancel_dt__c);
				activityWrap.d_departure_dt = ghfCC.stripTime(activity.d_departure_dt__c);
				activityWrap.c_share_id = activity.c_share_id__c;
				activityWrap.i_nbr_shares = activity.i_nbr_shares__c;
				activityWrap.c_transaction_agent_id = activity.c_transaction_agent_id__c;
				activityWrap.c_wing_cd = activity.c_wing_cd__c;
				activityWrap.c_original_wing_cd = activity.c_original_wing_cd__c;
				activityWrap.c_original_rm_type = activity.c_original_rm_type__c;
				activityWrap.c_rm_nbr = activity.c_rm_nbr__c;
				activityWrap.i_nbr_rooms = activity.i_nbr_rooms__c;
				activityWrap.i_nbr_occupants = activity.i_nbr_occupants__c;
				activityWrap.c_source_cd = activity.c_source_cd__c;
				activityWrap.c_rate_plan = activity.c_rate_plan__c;
				activityWrap.c_group_cd = activity.c_group_cd__c;

				activityWrap.c_group_type = activity.c_group_type__c;
				activityWrap.c_state_cd = activity.c_state_cd__c;
				activityWrap.c_zip_cd = activity.c_zip_cd__c;
				activityWrap.c_offer_id = activity.c_offer_id__c;
				activityWrap.i_customer_segment = activity.i_customer_segment__c;
				activityWrap.c_tracking = activity.c_tracking__c;
				activityWrap.c_settle_method = activity.c_settle_method__c;
				activityWrap.f_deposit_amt_req = activity.f_deposit_amt_req__c;
				activityWrap.f_deposit_credit_card_chg = activity.f_deposit_credit_card_chg__c;
				activityWrap.f_room_rev_reserved = activity.f_room_rev_reserved__c;
				activityWrap.f_room_tax_reserved = activity.f_room_tax_reserved__c;
				//activityWrap.d_checkin_time= activity.d_checkin_time__c;
				//activityWrap.d_checkout_time= activity.d_checkout_time__c;
				activityWrap.f_room_rev = activity.f_room_rev__c;
				activityWrap.f_fb_rev = activity.f_fb_rev__c;
				activityWrap.f_other_rev = activity.f_other_rev__c;
				activityWrap.f_comp_room_rev = activity.f_comp_room_rev__c;
				activityWrap.f_comp_fb_rev = activity.f_comp_fb_rev__c;
				activityWrap.f_comp_other_rev = activity.f_comp_other_rev__c;
				activityWrap.d_timestamp = activity.d_timestamp__c;

				activityWrap.c_occupant_type = activity.c_occupant_type__c;

				activityWrap.c_activity_desc = activity.hotel_act_status_code_fk__r.description__c;
				activityWrap.c_wing_cd = activity.c_wing_cd__c;
				activityWrap.source_code_fk = activity.source_code_fk__c;

			}
			if (pass == '4') {
				activityWrap.ExternalId = activity.ExternalId;
				activityWrap.f_reserve_id = activity.f_reserve_id__c;
				activityWrap.c_prop_cd = activity.c_prop_cd__c;
				activityWrap.c_prop_cd_Name = activity.c_prop_cd_fk__r.Name;
				activityWrap.c_room_smoking = activity.lms_room_type_desc_sda_fk__r.c_room_smoking__c;
				activityWrap.c_room_bed_type = activity.lms_room_type_desc_sda_fk__r.c_room_bed_type__c;
				activityWrap.c_room_accessible = activity.lms_room_type_desc_sda_fk__r.c_room_accessible__c;
				activityWrap.c_rm_type  = activity.lms_room_type_desc_sda_fk__r.c_rm_type__c ;
				activityWrap.c_room_desc1 = activity.lms_room_type_desc_sda_fk__r.c_room_desc1__c ;
				activityWrap.c_room_smoking = activity.lms_room_type_desc_sda_fk__r.c_room_smoking__c;
				activityWrap.c_room_quality = activity.lms_room_type_desc_sda_fk__r.c_room_quality__c; 
				activityWrap.c_customer_segment_desc = activity.customer_control_segments_fk__r.c_customer_segment_desc__c;
				activityWrap.c_customer_segment_short_desc = activity.customer_control_segments_fk__r.c_customer_segment_short_desc__c;
				activityWrap.c_incented_status = activity.customer_control_segments_fk__r.c_incented_status__c;
				activityWrap.c_known_status = activity.customer_control_segments_fk__r.c_known_status__c;
				activityWrap.i_control_segment = activity.customer_control_segments_fk__r.i_control_segment__c;
				activityWrap.hotelOfferWithBooking = activity.customer_control_segments_fk__r.c_incented_status__c == 'I' ? 'Yes' : 'No';

			}

			activityMap.put(activity.ExternalId, activityWrap);
		}
	}

	/*******************************************************************************************************
	* @description Retrieve the external data for Hotel Activity VEDW as view only
	* @param List<Id> of Contact Ids used to retrieve the Hotel Activity VEDW data
	* @return List<ActivityWrapper> containing the retrieved data
	* @example
	* List<GuestHotelFolioDataCC.ActivityVEDWWrapper>  activityList =
	*   		GuestHotelFolioDataCC.retrieveHotelActivityVEDW(List<Id> contactIds);
	*/
	@RemoteAction
	@AuraEnabled
	global static List<ActivityVEDWWrapper> retrieveHotelActivityVEDWDetails(List<String> reservePropIds) {
		system.debug('*** reservationPropIds ' + reservePropIds);	
		String whereClause = '';
		String whereClause2 = '';
		String [] reservProps = new String []{'0', '0'};
		for (String resvProp : reservePropIds){
			if (resvProp.indexOf(':') > -1){
				reservProps = resvProp.split(':');
				if (String.isBlank(whereClause)){
					whereClause = ' WHERE (f_reserve_id__c = \'' + String.escapeSingleQuotes(reservProps[0]) + '\'' + ' AND c_prop_cd__c =  \'' + String.escapeSingleQuotes(reservProps[1]) + '\')';
				} else {
					whereClause += ' OR (f_reserve_id__c = \'' + String.escapeSingleQuotes(reservProps[0]) + '\'' + ' AND c_prop_cd__c =  \'' + String.escapeSingleQuotes(reservProps[1]) + '\')';
				}
			}
		}

		String idType = 'reserve';
		return retrieveHotelActivityVEDW(reservePropIds, whereClause, whereClause2, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<ActivityVEDWWrapper> retrieveHotelActivityVEDWByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		String whereClause2 = '';
		String idType = 'contact';
		return retrieveHotelActivityVEDW(contactIds, whereClause, whereClause2, idType);
	}

	private static List<ActivityVEDWWrapper> retrieveHotelActivityVEDW(List<String> ids, String whereClause, String whereClause2, String idType) {
		system.debug('*** whereClause ' + whereClause);
		system.debug('*** whereClause2 ' + whereClause2);
		system.debug('*** ids ' + ids);
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged activities
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new GuestHotelFolioDataCC()).getConsXrefIds(ids);
		}

		system.debug('*** allContactIds ' + allContactIds);

		String soql1 = ' SELECT ExternalId, ';
		soql1 += ' c_activity_status__c, ';
		soql1 += ' c_address_1__c, ';
		soql1 += ' c_address_2__c, ';
		soql1 += ' c_cancel_agent_id__c, ';
		soql1 += ' c_cancel_id__c, ';
		soql1 += ' c_checkin_agent_id__c, ';
		soql1 += ' c_checkin_location__c, ';
		soql1 += ' c_checkout_agent_id__c, ';
		soql1 += ' c_checkout_location__c, ';
		soql1 += ' contact__c, ';
		soql1 += ' hotel_act_status_code_fk__c, ';
		soql1 += ' i_sec_dmid__c, ';
		soql1 += '  i_checkin_yr__c, ';
		soql1 += '  i_checkin_mn__c, ';
		soql1 += '  i_checkin_dy__c, ';
		soql1 += '  i_checkin_hr__c, ';
		soql1 += '  i_checkin_min__c, ';
		soql1 += '  i_checkin_sec__c, ';
		soql1 += '  i_checkout_yr__c, ';
		soql1 += '  i_checkout_mn__c, ';
		soql1 += '  i_checkout_dy__c, ';
		soql1 += '  i_checkout_hr__c, ';
		soql1 += '  i_checkout_min__c, ';
		soql1 += '  i_checkout_sec__c, ';
		soql1 += '  i_stay_id__c, ';
		soql1 += '  i_dmid__c, ';
		soql1 += '  i_cms_dmid__c, ';
		soql1 += '  i_group_id__c, ';
		soql1 += '  c_prop_cd__c, ';

		soql1 += '  i_sec_cms_dmid__c, ';
		soql1 += '  d_reserve_rpt_period__c, ';
		soql1 += '  d_cancel_rpt_period__c, ';
		soql1 += '  d_checkin_rpt_period__c, ';
		soql1 += '  d_checkout_rpt_period__c, ';
		soql1 += ' f_reserve_id__c ';
		soql1 += ' FROM guest_hotel_activity_vedw__x ';
		if (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause;
		}

		//soql1 = String.escapeSingleQuotes(soql1);

		

		Map<String, ActivityVEDWWrapper> activityVEDWMap = new Map<String, ActivityVEDWWrapper> ();

		List<guest_hotel_activity_vedw__x> activityVEDWList = (!mockedActivityVEDW.isEmpty()) ? mockedActivityVEDW : Database.query(soql1);

		system.debug('*** activityVEDWList ' + activityVEDWList );

		updateActivityVEDW (activityVEDWMap, activityVEDWList, '1');

		system.debug('*** activityVEDWMap return ' + activityVEDWMap.values());

		return activityVEDWMap.values();
	}

	/*******************************************************************************************************
	* @description Update the ActivityVEDWWrapper with soql results
	* @param Map<String, ActivityVEDWWrapper> activityVEDWMap
	* @param List<guest_hotel_activity_vedw__x>
	* @param String pass - which fields to update based on the soql that was run
	* @return List<ActivityVEDWWrapper> containing the updated data
	* @example
	* List<GuestHotelFolioDataCC.ActivityVEDWWrapper>  wrapperList =
	*   		GuestHotelFolioDataCC.updateActivityVEDW(Map<String, ActivityVEDWWrapper> activityVEDWMap, List<guest_hotel_activity_vedw__x> activityVEDWList, String pass);
	*/
	private static void updateActivityVEDW (Map<String, ActivityVEDWWrapper> activityVEDWMap, List<guest_hotel_activity_vedw__x> activityVEDWList, String pass) {
		ActivityVEDWWrapper activityVEDWWrap;
		GuestHotelFolioDataCC ghfCC = new GuestHotelFolioDataCC();

		for (guest_hotel_activity_vedw__x activityVEDW : activityVEDWList ) {
			if (!activityVEDWMap.containsKey(activityVEDW.ExternalId)) {
				activityVEDWMap.put(activityVEDW.ExternalId, new ActivityVEDWWrapper());
			}
			activityVEDWWrap = activityVEDWMap.get(activityVEDW.ExternalId);
			if (pass == '1') {
				activityVEDWWrap.ExternalId = activityVEDW.ExternalId;
				activityVEDWWrap.c_activity_status = activityVEDW.c_activity_status__c;
				activityVEDWWrap.c_address_1 = activityVEDW.c_address_1__c;
				activityVEDWWrap.c_address_2 = activityVEDW.c_address_2__c;
				activityVEDWWrap.c_cancel_agent_id = activityVEDW.c_cancel_agent_id__c;
				activityVEDWWrap.c_cancel_id = activityVEDW.c_cancel_id__c;
				activityVEDWWrap.c_checkin_agent_id = activityVEDW.c_checkin_agent_id__c;
				activityVEDWWrap.c_checkin_location = activityVEDW.c_checkin_location__c;
				activityVEDWWrap.c_checkout_agent_id = activityVEDW.c_checkout_agent_id__c;
				activityVEDWWrap.c_checkout_location = activityVEDW.c_checkout_location__c;
				activityVEDWWrap.contact = activityVEDW.contact__c;
				activityVEDWWrap.hotel_act_status_code_fk = activityVEDW.hotel_act_status_code_fk__c;
				activityVEDWWrap.i_sec_dmid = activityVEDW.i_sec_dmid__c	 ;
				activityVEDWWrap.f_reserve_id = activityVEDW.f_reserve_id__c ;
				activityVEDWWrap.i_checkin_yr = activityVEDW.i_checkin_yr__c;
				activityVEDWWrap.i_checkin_mn = activityVEDW.i_checkin_mn__c;
				activityVEDWWrap.i_checkin_dy = activityVEDW.i_checkin_dy__c;
				activityVEDWWrap.i_checkin_hr = activityVEDW.i_checkin_hr__c;
				activityVEDWWrap.i_checkin_min = activityVEDW.i_checkin_min__c;
				activityVEDWWrap.i_checkin_sec = activityVEDW.i_checkin_sec__c;
				activityVEDWWrap.i_checkout_yr = activityVEDW.i_checkout_yr__c;
				activityVEDWWrap.i_checkout_mn = activityVEDW.i_checkout_mn__c;
				activityVEDWWrap.i_checkout_dy = activityVEDW.i_checkout_dy__c;
				activityVEDWWrap.i_checkout_hr = activityVEDW.i_checkout_hr__c;
				activityVEDWWrap.i_checkout_min = activityVEDW.i_checkout_min__c;
				activityVEDWWrap.i_checkout_sec = activityVEDW.i_checkout_sec__c;
				activityVEDWWrap.i_stay_id = activityVEDW.i_stay_id__c;
				activityVEDWWrap.i_dmid = activityVEDW.i_dmid__c;
				activityVEDWWrap.i_cms_dmid = activityVEDW.i_cms_dmid__c;
				activityVEDWWrap.i_sec_cms_dmid = activityVEDW.i_sec_cms_dmid__c;
				activityVEDWWrap.i_group_id = activityVEDW.i_group_id__c;

				activityVEDWWrap.d_reserve_rpt_period = ghfCC.stripTime(activityVEDW.d_reserve_rpt_period__c);
				activityVEDWWrap.d_cancel_rpt_period = ghfCC.stripTime(activityVEDW.d_cancel_rpt_period__c);
				activityVEDWWrap.d_checkin_rpt_period = ghfCC.stripTime(activityVEDW.d_checkin_rpt_period__c);
				activityVEDWWrap.d_checkout_rpt_period = ghfCC.stripTime(activityVEDW.d_checkout_rpt_period__c);
				activityVEDWWrap.c_prop_cd = activityVEDW.c_prop_cd__c;
			}

			activityVEDWMap.put(activityVEDW.ExternalId, activityVEDWWrap);
		}
	}

	/*******************************************************************************************************
	* @description Retrieve the external data for Folio Header as view only
	* @param List<Id> of Contact Ids used to retrieve the Folio Header data
	* @return List<FolioHeaderWrapper> containing the retrieved data
	* @example
	* List<GuestHotelFolioDataCC.FolioHeaderWrapper>  folioHeaderList =
	*   		GuestHotelFolioDataCC.retrieveFolioHeader(List<Id> contactIds);
	*/
	@RemoteAction
	@AuraEnabled
	global static List<FolioHeaderWrapper> retrieveFolioHeaderDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = ' WHERE ExternalId in';
		String whereClause2 =  '';
		String idType = 'external';
		return retrieveFolioHeader(externalIds, whereClause, whereClause2, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<FolioHeaderWrapper> retrieveFolioHeaderByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact1__c in';
		String whereClause2 = ' OR contact2__c in';
		String idType = 'contact';
		return retrieveFolioHeader(contactIds, whereClause, whereclause2, idType);
	}

	private static List<FolioHeaderWrapper> retrieveFolioHeader(List<String> ids, String whereClause, String whereClause2, string idType) {
		system.debug('*** whereClause ' + whereClause);
		system.debug('*** whereClause2 ' + whereClause2);

		Set<String> activityIds = new Set<String>();

		Map<String, FolioHeaderWrapper> folioHeaderMap = new Map<String, FolioHeaderWrapper> ();
		//
		// for contacts, start with the activity
		//
		// for externalid, go get the record directly
		//
		if (idType == 'contact') {
			//
			// get the cross-reference dmIds for the contacts in order to access unmerged activities
			//
			List<String> allContactIds = new List<String>();
			allContactIds = (new GuestHotelFolioDataCC()).getConsXrefIds(ids);
			//
			// first get all the hotel activities
			//
			String soqlActivity = ' SELECT externalid ';
			soqlActivity += ' FROM lms_hotel_activity__x  ';
			if (idType == 'contact') {
				soqlActivity += whereClause + ': allContactIds';
				soqlActivity += whereClause2 + ': allContactIds';
			} else {
				soqlActivity += whereClause + ': ids';
			}

			List<lms_hotel_activity__x> activityList = (!mockedActivity.isEmpty()) ? mockedActivity : Database.query(soqlActivity);

			system.debug('*** activityList ' + activityList );

			for (lms_hotel_activity__x activity : activityList ) {
				activityIds.add(activity.externalId);
			}
		}

		String soql1 = ' SELECT ExternalId, ';
		soql1 += ' c_bill_cd__c, ';
		soql1 += ' c_compor_dept__c, ';
		soql1 += ' c_compor_first_name__c, ';
		soql1 += ' c_compor_gl_cd__c,  ';
		soql1 += ' c_compor_last_name__c, ';
		soql1 += ' c_convention_cd__c, ';
		soql1 += ' c_folio_creator_id__c,  ';
		soql1 += ' c_prop_cd__c,  ';
		soql1 += ' c_prop_cd_fk__c, ';
		soql1 += ' c_quality_cd__c, ';
		soql1 += ' d_folio_create_timestamp__c, ';
		soql1 += ' d_folio_effective_dt__c, ';
		soql1 += ' d_folio_expire_dt__c, ';
		soql1 += ' d_timestamp__c, ';
		soql1 += ' f_folio_id__c, ';
		soql1 += ' f_reserve_id__c, ';
		soql1 += ' i_folio_type_id__c, ';
		soql1 += ' id__c, ';
		soql1 += ' lms_hotel_activity_fk__c ';
		soql1 += ' FROM lms_folio_hdr__x ';
		if (idType == 'contact') {
			soql1 +=  'where lms_hotel_activity_fk__c in:  activityIds ';
		} else {
			soql1 +=  'where externalid in:  ids ';
		}


		soql1 = String.escapeSingleQuotes(soql1);

		List<lms_folio_hdr__x> folioHeaderList = (!mockedFolioHeader.isEmpty()) ? mockedFolioHeader : Database.query(soql1);

		system.debug('*** folioHeaderList ' + folioHeaderList );

		updateFolioHeader (folioHeaderMap, folioHeaderList, '1');

		system.debug('*** folioHeaderMap return ' + folioHeaderMap.values());

		return folioHeaderMap.values();
	}

	/*******************************************************************************************************
	* @description Update the FolioHeaderWrapper with soql results
	* @param Map<String, FolioHeaderWrapper> folioHeaderMap
	* @param List<lms_folio_hdr__x>
	* @param String pass - which fields to update based on the soql that was run
	* @return List<FolioHeaderWrapper> containing the updated data
	* @example
	* List<GuestHotelFolioDataCC.FolioHeaderWrapper>  wrapperList =
	*   		GuestHotelFolioDataCC.updateActivityVEDW(Map<String, FolioHeaderWrapper> folioHeaderMap, List<lms_folio_hdr__x> folioHeaderList, String pass);
	*/
	private static void updateFolioHeader (Map<String, FolioHeaderWrapper> folioHeaderMap, List<lms_folio_hdr__x> folioHeaderList, String pass) {
		FolioHeaderWrapper folioHotel;
		GuestHotelFolioDataCC ghfCC = new GuestHotelFolioDataCC();

		for (lms_folio_hdr__x folioHeader : folioHeaderList ) {
			if (!folioHeaderMap.containsKey(folioHeader.ExternalId)) {
				folioHeaderMap.put(folioHeader.ExternalId, new FolioHeaderWrapper());
			}
			folioHotel = folioHeaderMap.get(folioHeader.ExternalId);
			if (pass == '1') {
				folioHotel.ExternalId = folioHeader.ExternalId;
				folioHotel.c_bill_cd = folioHeader.c_bill_cd__c;
				folioHotel.c_compor_dept = folioHeader.c_compor_dept__c;
				folioHotel.c_compor_first_name = folioHeader.c_compor_first_name__c;
				folioHotel.c_compor_gl_cd = folioHeader.c_compor_gl_cd__c;
				folioHotel.c_compor_last_name = folioHeader.c_compor_last_name__c;
				folioHotel.c_convention_cd = folioHeader.c_convention_cd__c;
				folioHotel.c_folio_creator_id = folioHeader.c_folio_creator_id__c;
				folioHotel.c_prop_cd = folioHeader.c_prop_cd__c;
				folioHotel.c_prop_cd_fk = folioHeader.c_prop_cd_fk__c;
				folioHotel.c_quality_cd = folioHeader.c_quality_cd__c;
				folioHotel.d_folio_create_timestamp = folioHeader.d_folio_create_timestamp__c;

				folioHotel.d_folio_effective_dt = ghfCC.stripTime(folioHeader.d_folio_effective_dt__c);
				folioHotel.d_folio_expire_dt = ghfCC.stripTime(folioHeader.d_folio_expire_dt__c);
				folioHotel.d_timestamp = folioHeader.d_timestamp__c;
				folioHotel.f_folio_id = folioHeader.f_folio_id__c;
				folioHotel.f_reserve_id = folioHeader.f_reserve_id__c;
				folioHotel.i_folio_type_id = folioHeader.i_folio_type_id__c;
				folioHotel.id = folioHeader.id__c;
				folioHotel.lms_hotel_activity_fk = folioHeader.lms_hotel_activity_fk__c;

			}

			folioHeaderMap.put(folioHotel.ExternalId, folioHotel);
		}
	}

	/*******************************************************************************************************
	* @description Retrieve the external data for Folio Details as view only
	* @param List<Id> of Contact Ids used to retrieve the Folio Header data
	* @return List<FolioDetailsWrapper> containing the retrieved data
	* @example
	* List<GuestHotelFolioDataCC.FolioDetailsWrapper>  folioHeaderList =
	*   		GuestHotelFolioDataCC.retrieveFolioDetails(List<Id> contactIds);
	*/
	@RemoteAction
	@AuraEnabled
	global static List<FolioDetailsWrapper> retrieveFolioDetailsDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = ' WHERE ExternalId in';
		String whereClause2 =  '';
		String idType = 'external';
		return retrieveFolioDetails(externalIds, whereClause, whereClause2, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<FolioDetailsWrapper> retrieveFolioDetailsByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact1__c in';
		String whereClause2 = ' OR contact2__c in';
		String idType = 'contact';
		return retrieveFolioDetails(contactIds, whereClause, whereclause2, idType);
	}

	private static List<FolioDetailsWrapper> retrieveFolioDetails(List<String> ids, String whereClause, String whereClause2, string idType) {

		system.debug('*** ids ' + ids);
		Set<String> activityIds = new Set<String>();
		Set<String> folioHeaderIds = new Set<String>();

		Map<String, FolioDetailsWrapper> folioDetailsMap = new Map<String, FolioDetailsWrapper> ();
		FolioDetailsWrapper folioDetail;
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged activities
		//
		//
		// for contacts, start with the activity
		//
		// for externalid, go get the record directly
		//
		if (idType == 'contact') {
			List<String> allContactIds = new List<String>();
			allContactIds = (new GuestHotelFolioDataCC()).getConsXrefIds(ids);
			//
			// first get all the hotel activities
			//
			String soqlActivity = ' SELECT externalid ';
			soqlActivity += ' FROM lms_hotel_activity__x  ';
			if (idType == 'contact') {
				soqlActivity += whereClause + ': allContactIds';
				soqlActivity += whereClause2 + ': allContactIds';
			} else {
				soqlActivity += whereClause + ': ids';
			}

			List<lms_hotel_activity__x> activityList = (!mockedActivity.isEmpty()) ? mockedActivity : Database.query(soqlActivity);

			system.debug('*** activityList ' + activityList );

			for (lms_hotel_activity__x activity : activityList ) {
				activityIds.add(activity.externalId);
			}
			//
			// the get all the folio headers
			//
			List<lms_folio_hdr__x> folioHeaderList = (!mockedFolioHeader.isEmpty()) ? mockedFolioHeader :
			        [SELECT externalid
			         FROM lms_folio_hdr__x
			         where lms_hotel_activity_fk__c in:  activityIds
			        ];

			system.debug('*** folioHeaderList ' + folioHeaderList );

			for (lms_folio_hdr__x folioHeader : folioHeaderList ) {
				folioHeaderIds.add(folioHeader.ExternalId);
			}
		}
		//
		// now get all the folio details
		//

		String soql1 = ' SELECT ExternalId, ';
		//soql1 += ' c_account__c, ';
		soql1 += ' c_bill_cd__c, ';
		soql1 += ' c_bill_cd_desc__c, ';
		soql1 += ' c_cashier_first_name__c, ';
		soql1 += ' c_cashier_id__c, ';
		soql1 += ' c_cashier_last_name__c, ';
		soql1 += ' c_cashier_user_profile__c, ';
		soql1 += ' c_cc_lead_digit_type__c, ';
		soql1 += ' c_comments__c, ';
		soql1 += ' c_compor_dept__c, ';
		soql1 += ' c_compor_first_name__c, ';
		soql1 += ' c_compor_gl_cd__c, ';
		soql1 += ' c_compor_last_name__c, ';
		soql1 += ' c_external_ticket_nbr__c, ';
		soql1 += ' c_meal_period_cd__c, ';
		soql1 += ' c_meal_period_desc__c, ';
		soql1 += ' c_prop_cd__c, ';
		soql1 += ' c_prop_cd_fk__c, ';
		soql1 += ' c_quality_cd__c, ';
		soql1 += ' c_rev_center_cd__c, ';
		soql1 += ' c_server_nbr__c, ';
		soql1 += ' c_settle_method_cd__c, ';
		soql1 += ' c_settle_method_short_desc__c, ';
		soql1 += ' c_settle_method_type__c, ';
		soql1 += ' c_split_ticket_flag__c, ';
		soql1 += ' c_ticket_type_cd__c, ';
		soql1 += ' d_create_ts__c, ';
		soql1 += ' d_timestamp__c, ';
		soql1 += ' d_trans_dt__c, ';
		soql1 += ' f_folio_id__c, ';
		soql1 += ' f_tax_amt__c, ';
		soql1 += ' f_ticket_amt__c, ';
		soql1 += ' f_ticket_id__c, ';
		soql1 += ' f_tip_amt__c, ';
		soql1 += ' i_cashier_emp_id__c, ';
		soql1 += ' i_covers__c, ';
		soql1 += ' i_invoice_number__c, ';
		soql1 += ' i_seq_nbr__c, ';
		soql1 += ' id__c, ';
		soql1 += ' lms_folio_hdr_fk__c ';
		soql1 += ' FROM lms_folio_dtl__x  ';
		if (idType == 'contact') {
			soql1 +=  'where lms_folio_hdr_fk__c in:  folioHeaderIds ';
		} else {
			soql1 +=  'where externalid in:  ids ';
		}

		soql1 = String.escapeSingleQuotes(soql1);

		List<lms_folio_dtl__x> folioDetailsList = (!mockedFolioDetails.isEmpty()) ? mockedFolioDetails : Database.query(soql1);

		system.debug('*** folioDetailsList ' + folioDetailsList );

		updateFolioDetails (folioDetailsMap, folioDetailsList, '1');

		system.debug('*** folioDetailsMap return ' + folioDetailsMap.values());

		return folioDetailsMap.values();
	}

	/*******************************************************************************************************
	* @description Update the FolioDetailsWrapper with soql results
	* @param Map<String, FolioDetailsWrapper> folioDetailsMap
	* @param List<lms_folio_dtl__x>
	* @param String pass - which fields to update based on the soql that was run
	* @return List<FolioDetailsWrapper> containing the updated data
	* @example
	* List<GuestHotelFolioDataCC.FolioDetailsWrapper>  wrapperList =
	*   		GuestHotelFolioDataCC.updateActivityVEDW(Map<String, FolioDetailsWrapper> folioDetailsMap, List<lms_folio_dtl__x> folioDetailsList, String pass);
	*/
	private static void updateFolioDetails (Map<String, FolioDetailsWrapper> folioDetailsMap, List<lms_folio_dtl__x> folioDetailsList, String pass) {
		FolioDetailsWrapper folioDetail;
		GuestHotelFolioDataCC ghfCC = new GuestHotelFolioDataCC();

		for (lms_folio_dtl__x folioDetails : folioDetailsList ) {
			if (!folioDetailsMap.containsKey(folioDetails.ExternalId)) {
				folioDetailsMap.put(folioDetails.ExternalId, new FolioDetailsWrapper());
			}
			folioDetail = folioDetailsMap.get(folioDetails.ExternalId);
			if (pass == '1') {
				folioDetail.ExternalId = folioDetails.ExternalId;
				//folioDetail.c_account = folioDetails.c_account__c;
				folioDetail.c_bill_cd = folioDetails.c_bill_cd__c;
				folioDetail.c_bill_cd_desc = folioDetails.c_bill_cd_desc__c;
				folioDetail.c_cashier_first_name = folioDetails.c_cashier_first_name__c;
				folioDetail.c_cashier_id = folioDetails.c_cashier_id__c;
				folioDetail.c_cashier_last_name = folioDetails.c_cashier_last_name__c;
				folioDetail.c_cashier_user_profile = folioDetails.c_cashier_user_profile__c;
				folioDetail.c_cc_lead_digit_type = folioDetails.c_cc_lead_digit_type__c;
				folioDetail.c_comments = folioDetails.c_comments__c;
				folioDetail.c_compor_dept = folioDetails.c_compor_dept__c;
				folioDetail.c_compor_first_name = folioDetails.c_compor_first_name__c;
				folioDetail.c_compor_gl_cd = folioDetails.c_compor_gl_cd__c;
				folioDetail.c_compor_last_name = folioDetails.c_compor_last_name__c;
				folioDetail.c_external_ticket_nbr = folioDetails.c_external_ticket_nbr__c;
				folioDetail.c_meal_period_cd = folioDetails.c_meal_period_cd__c;
				folioDetail.c_meal_period_desc = folioDetails.c_meal_period_desc__c;
				folioDetail.c_prop_cd = folioDetails.c_prop_cd__c;
				folioDetail.c_prop_cd_fk = folioDetails.c_prop_cd_fk__c;
				folioDetail.c_quality_cd = folioDetails.c_quality_cd__c;
				folioDetail.c_rev_center_cd = folioDetails.c_rev_center_cd__c;
				folioDetail.c_server_nbr = folioDetails.c_server_nbr__c;
				folioDetail.c_settle_method_cd = folioDetails.c_settle_method_cd__c;
				folioDetail.c_settle_method_short_desc = folioDetails.c_settle_method_short_desc__c;
				folioDetail.c_settle_method_type = folioDetails.c_settle_method_type__c;
				folioDetail.c_split_ticket_flag = folioDetails.c_split_ticket_flag__c;
				folioDetail.c_ticket_type_cd = folioDetails.c_ticket_type_cd__c;
				folioDetail.d_create_ts = folioDetails.d_create_ts__c;
				folioDetail.d_timestamp = folioDetails.d_timestamp__c;
				folioDetail.d_trans_dt = folioDetails.d_trans_dt__c;
				folioDetail.f_folio_id = folioDetails.f_folio_id__c;
				folioDetail.f_tax_amt = folioDetails.f_tax_amt__c;
				folioDetail.f_ticket_amt = folioDetails.f_ticket_amt__c;
				folioDetail.f_ticket_id = folioDetails.f_ticket_id__c;
				folioDetail.f_tip_amt = folioDetails.f_tip_amt__c;
				folioDetail.i_cashier_emp_id = folioDetails.i_cashier_emp_id__c;
				folioDetail.i_covers = folioDetails.i_covers__c;
				folioDetail.i_invoice_number = folioDetails.i_invoice_number__c;
				folioDetail.i_seq_nbr = folioDetails.i_seq_nbr__c;
				folioDetail.id = folioDetails.id__c;
				folioDetail.lms_folio_hdr_fk = folioDetails.lms_folio_hdr_fk__c;
			}

			folioDetailsMap.put(folioDetail.ExternalId, folioDetail);
		}
	}


	/*******************************************************************************************************
	* @description Wrapper class for Folio Header
	*/
	global class FolioHeaderWrapper {
		@AuraEnabled global String ExternalId { get; set; }
		@AuraEnabled global String c_bill_cd { get; set; }
		@AuraEnabled global String c_compor_dept { get; set; }
		@AuraEnabled global String c_compor_first_name { get; set; }
		@AuraEnabled global String c_compor_gl_cd { get; set; }
		@AuraEnabled global String c_compor_last_name { get; set; }
		@AuraEnabled global String c_convention_cd { get; set; }
		@AuraEnabled global String c_folio_creator_id { get; set; }
		@AuraEnabled global String c_prop_cd { get; set; }
		@AuraEnabled global String c_prop_cd_fk { get; set; }
		@AuraEnabled global String c_quality_cd { get; set; }
		@AuraEnabled global String d_folio_create_timestamp { get; set; }
		@AuraEnabled global String d_folio_effective_dt { get; set; }
		@AuraEnabled global String d_folio_expire_dt { get; set; }
		@AuraEnabled global String d_timestamp { get; set; }
		@AuraEnabled global String f_folio_id { get; set; }
		@AuraEnabled global String f_reserve_id { get; set; }
		@AuraEnabled global Decimal i_folio_type_id { get; set; }
		@AuraEnabled global Decimal id { get; set; }
		@AuraEnabled global String lms_hotel_activity_fk { get; set; }

		global FolioHeaderWrapper() {

		}
	}

	/*******************************************************************************************************
	* @description Wrapper class for Activity VEDW
	*/
	global class ActivityVEDWWrapper {
		@AuraEnabled global String ExternalId { get; set; }
		@AuraEnabled global String c_activity_status { get; set; }
		@AuraEnabled global String c_address_1 { get; set; }
		@AuraEnabled global String c_address_2 { get; set; }
		@AuraEnabled global String c_cancel_agent_id { get; set; }
		@AuraEnabled global String c_cancel_id { get; set; }
		@AuraEnabled global String c_checkin_agent_id { get; set; }
		@AuraEnabled global String c_checkin_location { get; set; }
		@AuraEnabled global String c_checkout_agent_id { get; set; }
		@AuraEnabled global String c_checkout_location { get; set; }
		@AuraEnabled global String contact { get; set; }
		@AuraEnabled global String hotel_act_status_code_fk { get; set; }
		@AuraEnabled global String i_sec_dmid  { get; set; }
		@AuraEnabled global String f_reserve_id  { get; set; }
		@AuraEnabled global Decimal i_checkin_yr  { get; set; }
		@AuraEnabled global Decimal i_checkin_mn  { get; set; }
		@AuraEnabled global Decimal i_checkin_dy  { get; set; }
		@AuraEnabled global Decimal i_checkin_hr  { get; set; }
		@AuraEnabled global Decimal i_checkin_min  { get; set; }
		@AuraEnabled global Decimal i_checkin_sec  { get; set; }
		@AuraEnabled global Decimal i_checkout_yr  { get; set; }
		@AuraEnabled global Decimal i_checkout_mn  { get; set; }
		@AuraEnabled global Decimal i_checkout_dy  { get; set; }
		@AuraEnabled global Decimal i_checkout_hr  { get; set; }
		@AuraEnabled global Decimal i_checkout_min  { get; set; }
		@AuraEnabled global Decimal i_checkout_sec  { get; set; }
		@AuraEnabled global String i_dmid  { get; set; }
		@AuraEnabled global String i_cms_dmid  { get; set; }
		@AuraEnabled global String i_stay_id  { get; set; }
		@AuraEnabled global String i_sec_cms_dmid  { get; set; }
		@AuraEnabled global String d_reserve_rpt_period  { get; set; }
		@AuraEnabled global String d_cancel_rpt_period  { get; set; }
		@AuraEnabled global String d_checkin_rpt_period  { get; set; }
		@AuraEnabled global String d_checkout_rpt_period  { get; set; }
		@AuraEnabled global Decimal i_group_id  { get; set; }
		@AuraEnabled global String c_prop_cd { get; set; }



		global ActivityVEDWWrapper() {

		}
	}

	/*******************************************************************************************************
	* @description Wrapper class for Folio Header
	*/
	global class FolioDetailsWrapper {
		@AuraEnabled global String ExternalId { get; set; }
		//global Decimal  c_account__c { get; set; }
		@AuraEnabled global String c_bill_cd { get; set; }
		@AuraEnabled global String c_bill_cd_desc { get; set; }
		@AuraEnabled global String c_cashier_first_name { get; set; }
		@AuraEnabled global String c_cashier_id { get; set; }
		@AuraEnabled global String c_cashier_last_name { get; set; }
		@AuraEnabled global String c_cashier_user_profile { get; set; }
		@AuraEnabled global String c_cc_lead_digit_type { get; set; }
		@AuraEnabled global String c_comments { get; set; }
		@AuraEnabled global String c_compor_dept { get; set; }
		@AuraEnabled global String c_compor_first_name { get; set; }
		@AuraEnabled global String c_compor_gl_cd { get; set; }
		@AuraEnabled global String c_compor_last_name { get; set; }
		@AuraEnabled global String c_external_ticket_nbr { get; set; }
		@AuraEnabled global String c_meal_period_cd { get; set; }
		@AuraEnabled global String c_meal_period_desc { get; set; }
		@AuraEnabled global String c_prop_cd { get; set; }
		@AuraEnabled global String c_prop_cd_fk { get; set; }
		@AuraEnabled global String c_quality_cd { get; set; }
		@AuraEnabled global String c_rev_center_cd { get; set; }
		@AuraEnabled global String c_server_nbr { get; set; }
		@AuraEnabled global String c_settle_method_cd { get; set; }
		@AuraEnabled global String c_settle_method_short_desc { get; set; }
		@AuraEnabled global String c_settle_method_type { get; set; }
		@AuraEnabled global String c_split_ticket_flag { get; set; }
		@AuraEnabled global String c_ticket_type_cd { get; set; }
		@AuraEnabled global String d_create_ts { get; set; }
		@AuraEnabled global String d_timestamp { get; set; }
		@AuraEnabled global String d_trans_dt { get; set; }
		@AuraEnabled global String f_folio_id { get; set; }
		@AuraEnabled global Decimal f_tax_amt { get; set; }
		@AuraEnabled global Decimal f_ticket_amt { get; set; }
		@AuraEnabled global String f_ticket_id { get; set; }
		@AuraEnabled global Decimal f_tip_amt { get; set; }
		@AuraEnabled global String i_cashier_emp_id { get; set; }
		@AuraEnabled global Decimal i_covers { get; set; }
		@AuraEnabled global Decimal i_invoice_number { get; set; }
		@AuraEnabled global Decimal i_seq_nbr { get; set; }
		@AuraEnabled global Decimal id { get; set; }
		@AuraEnabled global String lms_folio_hdr_fk { get; set; }

		global FolioDetailsWrapper() {

		}
	}

	/*******************************************************************************************************
	* @description Wrapper class for Hotel Activity and VEDW
	*/
	global class ActivityWrapper {
		@AuraEnabled global String ExternalId { get; set; }
		@AuraEnabled global String c_cancel_agent_id { get; set; }
		@AuraEnabled global String c_cancel_id { get; set; }
		@AuraEnabled global String c_checkin_agent_id { get; set; }
		@AuraEnabled global String c_checkin_location { get; set; }
		@AuraEnabled global String c_checkout_agent_id { get; set; }
		@AuraEnabled global String c_checkout_location { get; set; }
		@AuraEnabled global String c_city { get; set; }
		@AuraEnabled global String c_confirm_email { get; set; }
		@AuraEnabled global String c_confirm_id { get; set; }
		@AuraEnabled global String contact1 { get; set; }
		@AuraEnabled global String contact2 { get; set; }
		@AuraEnabled global String c_credit_card_auth_nbr { get; set; }
		@AuraEnabled global String c_credit_card_exp_dt { get; set; }
		@AuraEnabled global String c_credit_card_nbr { get; set; }
		@AuraEnabled global String source_cd { get; set; }
		@AuraEnabled global String hotel_act_status_cd { get; set; }
		@AuraEnabled global String customer_control_segment_desc { get; set; }
		@AuraEnabled global String hotel_wing_cd { get; set; }
		@AuraEnabled global String lms_room_type_desc_sda { get; set; }
		@AuraEnabled global String f_reserve_id  { get; set; }
		@AuraEnabled global String c_prop_cd  { get; set; }
		@AuraEnabled global String c_prop_cd_Name  { get; set; }
		@AuraEnabled global String d_checkin_dt  { get; set; }
		@AuraEnabled global String d_checkout_dt  { get; set; }
		@AuraEnabled global Decimal i_rm_night  { get; set; }
		@AuraEnabled global String c_quality_cd  { get; set; }
		@AuraEnabled global String c_room_smoking  { get; set; }
		@AuraEnabled global String c_room_quality  { get; set; }
		@AuraEnabled global String c_room_bed_type  { get; set; }
		@AuraEnabled global String c_room_accessible  { get; set; }
		@AuraEnabled global String source_code_Description  { get; set; }
		@AuraEnabled global String source_code_fk  { get; set; }
		@AuraEnabled global Decimal i_control_segment  { get; set; }
		@AuraEnabled global String hotel_wing_codes_Code  { get; set; }
		@AuraEnabled global String c_rm_type   { get; set; }
		@AuraEnabled global String status { get; set; }
		@AuraEnabled global String c_reservation_agent_id { get; set; }
		@AuraEnabled global String bookHow   { get; set; }
		@AuraEnabled global Decimal daysBooked   { get; set; }
		@AuraEnabled global Decimal avgRoomRate   { get; set; }
		@AuraEnabled global String roomComped   { get; set; }
		@AuraEnabled global String hotelOfferWithBooking   { get; set; }

		@AuraEnabled global String c_pri_cas_guest_id  { get; set; }
		@AuraEnabled global String d_arrival_dt  { get; set; }
		@AuraEnabled global String i_stay_id  { get; set; }
		@AuraEnabled global String i_dmid  { get; set; }
		@AuraEnabled global String i_cms_dmid  { get; set; }
		@AuraEnabled global String c_first_name  { get; set; }
		@AuraEnabled global String c_last_name  { get; set; }
		@AuraEnabled global String c_sec_cas_guest_id  { get; set; }
		@AuraEnabled global String i_sec_cms_dmid  { get; set; }
		@AuraEnabled global String d_reserve_rpt_period  { get; set; }
		@AuraEnabled global String d_cancel_rpt_period  { get; set; }
		@AuraEnabled global String d_checkin_rpt_period  { get; set; }
		@AuraEnabled global String d_checkout_rpt_period  { get; set; }
		@AuraEnabled global String d_transaction_dt  { get; set; }
		@AuraEnabled global String d_reserve_dt  { get; set; }
		@AuraEnabled global String d_cancel_dt  { get; set; }
		@AuraEnabled global String d_departure_dt  { get; set; }
		@AuraEnabled global String c_share_id  { get; set; }
		@AuraEnabled global Decimal i_nbr_shares  { get; set; }
		@AuraEnabled global String c_transaction_agent_id  { get; set; }
		@AuraEnabled global String c_wing_cd  { get; set; }
		@AuraEnabled global String c_original_wing_cd  { get; set; }
		@AuraEnabled global String c_original_rm_type  { get; set; }
		@AuraEnabled global String c_rm_nbr  { get; set; }
		@AuraEnabled global Decimal i_nbr_rooms  { get; set; }
		@AuraEnabled global Decimal i_nbr_occupants  { get; set; }
		@AuraEnabled global String c_source_cd  { get; set; }
		@AuraEnabled global String c_rate_plan  { get; set; }
		@AuraEnabled global String c_group_cd  { get; set; }
		@AuraEnabled global Decimal i_group_id  { get; set; }
		@AuraEnabled global String c_group_type  { get; set; }
		@AuraEnabled global String c_state_cd  { get; set; }
		@AuraEnabled global String c_zip_cd  { get; set; }
		@AuraEnabled global String c_offer_id  { get; set; }
		@AuraEnabled global Decimal i_customer_segment  { get; set; }
		@AuraEnabled global String c_tracking  { get; set; }
		@AuraEnabled global String c_settle_method  { get; set; }
		@AuraEnabled global Decimal f_deposit_amt_req  { get; set; }
		@AuraEnabled global Decimal f_deposit_credit_card_chg  { get; set; }
		@AuraEnabled global Decimal f_room_rev_reserved  { get; set; }
		@AuraEnabled global Decimal f_room_tax_reserved  { get; set; }
		@AuraEnabled global String d_checkin_time  { get; set; }
		@AuraEnabled global String d_checkout_time  { get; set; }
		@AuraEnabled global Decimal f_room_rev  { get; set; }
		@AuraEnabled global Decimal f_fb_rev  { get; set; }
		@AuraEnabled global Decimal f_other_rev  { get; set; }
		@AuraEnabled global Decimal f_comp_room_rev  { get; set; }
		@AuraEnabled global Decimal f_comp_fb_rev  { get; set; }
		@AuraEnabled global Decimal f_comp_other_rev  { get; set; }
		@AuraEnabled global String d_timestamp  { get; set; }
		@AuraEnabled global Decimal i_checkin_yr  { get; set; }
		@AuraEnabled global Decimal i_checkin_mn  { get; set; }
		@AuraEnabled global Decimal i_checkin_dy  { get; set; }
		@AuraEnabled global Decimal i_checkin_hr  { get; set; }
		@AuraEnabled global Decimal i_checkin_min  { get; set; }
		@AuraEnabled global Decimal i_checkin_sec  { get; set; }
		@AuraEnabled global Decimal i_checkout_yr  { get; set; }
		@AuraEnabled global Decimal i_checkout_mn  { get; set; }
		@AuraEnabled global Decimal i_checkout_dy  { get; set; }
		@AuraEnabled global Decimal i_checkout_hr  { get; set; }
		@AuraEnabled global Decimal i_checkout_min  { get; set; }
		@AuraEnabled global Decimal i_checkout_sec  { get; set; }
		@AuraEnabled global String c_occupant_type  { get; set; }
		@AuraEnabled global String c_customer_segment_desc { get; set; }
		@AuraEnabled global String c_customer_segment_short_desc { get; set; }
		@AuraEnabled global String c_incented_status { get; set; }
		@AuraEnabled global String c_known_status { get; set; }
		@AuraEnabled global String c_activity_desc { get; set; }
		@AuraEnabled global String c_wing_desc { get; set; }
		@AuraEnabled global String c_source_cd_desc { get; set; }
		@AuraEnabled global String c_source_cat2 { get; set; }
		@AuraEnabled global String bookingMainSource { get; set; }
		@AuraEnabled global String c_source_group { get; set; }
		@AuraEnabled global String c_rms_group_source_cd { get; set; }
		@AuraEnabled global String c_room_desc1 { get; set; }
		@AuraEnabled global String c_activity_status { get; set; }
		@AuraEnabled global String c_address_1 { get; set; }
		@AuraEnabled global String c_address_2 { get; set; }
		@AuraEnabled global String contact { get; set; }
		@AuraEnabled global String hotel_act_status_code_fk { get; set; }
		@AuraEnabled global String i_sec_dmid  { get; set; }
		@AuraEnabled global String vedwExternalId { get; set; }

		global ActivityWrapper() {

		}
	}
}