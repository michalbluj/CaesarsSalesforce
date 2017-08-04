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
		List<String> allContactIds = new List<String>();
		if (idType == 'contact'){
			allContactIds = getXrefIds(ids);
		}

		String soql1 = ' SELECT externalid, ';
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
		soql1 += ' source_code_fk__c ';
		soql1 += ' FROM lms_hotel_activity__x  ';
		if (idType == 'contact'){
			soql1 += whereClause1 + ': allContactIds';
			soql1 += whereClause2 + ': allContactIds';
		} else {
			soql1 += whereClause1 + ': ids';
		}

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, ActivityWrapper> activityMap = new Map<String, ActivityWrapper> ();

		List<lms_hotel_activity__x> activityList = (!mockedActivity.isEmpty()) ? mockedActivity : Database.query(soql1);
	   	
	  	system.debug('*** activityList ' + activityList );

	  	updateActivity (activityMap, activityList, '1');
	  	
	  	system.debug('*** activityMap return ' + activityMap.values());

	  	return activityMap.values();
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
	private static void updateActivity (Map<String, ActivityWrapper> activityMap, List<lms_hotel_activity__x> activityList, String pass){
		ActivityWrapper activityWrap;

		for (lms_hotel_activity__x activity : activityList ){
	  		if (!activityMap.containsKey(activity.ExternalId)) {
	  			activityMap.put(activity.ExternalId, new ActivityWrapper());
	  		}
	  		activityWrap = activityMap.get(activity.ExternalId);
	  		if (pass == '1'){
		  		activityWrap.ExternalId = activity.ExternalId;
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
		  	
		  		activityWrap.contact1 = activity.contact1__c;
		  		activityWrap.contact2 = activity.contact2__c;
		  		
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
	global static List<ActivityVEDWWrapper> retrieveHotelActivityVEDWDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = ' WHERE ExternalId in';
		String idType = 'external';
		return retrieveHotelActivityVEDW(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<ActivityVEDWWrapper> retrieveHotelActivityVEDWByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		String idType = 'contact';
		return retrieveHotelActivityVEDW(contactIds, whereClause, idType);
	}

	private static List<ActivityVEDWWrapper> retrieveHotelActivityVEDW(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClause ' + whereClause);
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged activities
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact'){
			allContactIds = getXrefIds(ids);
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
		soql1 += ' hotel_act_status_code_fk__c ';
		soql1 += ' FROM guest_hotel_activity_vedw__x ';
		if (idType == 'contact'){
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}

		soql1 = String.escapeSingleQuotes(soql1);
		
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
	private static void updateActivityVEDW (Map<String, ActivityVEDWWrapper> activityVEDWMap, List<guest_hotel_activity_vedw__x> activityVEDWList, String pass){
		ActivityVEDWWrapper activityVEDWWrap;

		for (guest_hotel_activity_vedw__x activityVEDW : activityVEDWList ){
	  		if (!activityVEDWMap.containsKey(activityVEDW.ExternalId)) {
	  			activityVEDWMap.put(activityVEDW.ExternalId, new ActivityVEDWWrapper());
	  		}
	  		activityVEDWWrap = activityVEDWMap.get(activityVEDW.ExternalId);
	  		if (pass == '1'){
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
		// get the cross-reference dmIds for the contacts in order to access unmerged activities
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact'){
			allContactIds = getXrefIds(ids);
		}
		//
		// first get all the hotel activities
		//
		String soqlActivity = ' SELECT externalid ';
		soqlActivity += ' FROM lms_hotel_activity__x  ';
		if (idType == 'contact'){
			soqlActivity += whereClause + ': allContactIds';
			soqlActivity += whereClause2 + ': allContactIds';
		} else {
			soqlActivity += whereClause + ': ids';
		}

		List<lms_hotel_activity__x> activityList = (!mockedActivity.isEmpty()) ? mockedActivity : Database.query(soqlActivity);

	  	system.debug('*** activityList ' + activityList );

	  	for (lms_hotel_activity__x activity : activityList ){
	  		activityIds.add(activity.externalId);
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
		soql1 +=  'where lms_hotel_activity_fk__c in:  activityIds ';

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
	private static void updateFolioHeader (Map<String, FolioHeaderWrapper> folioHeaderMap, List<lms_folio_hdr__x> folioHeaderList, String pass){
		FolioHeaderWrapper folioHotel;

		for (lms_folio_hdr__x folioHeader : folioHeaderList ){
	  		if (!folioHeaderMap.containsKey(folioHeader.ExternalId)) {
	  			folioHeaderMap.put(folioHeader.ExternalId, new FolioHeaderWrapper());
	  		}
	  		folioHotel = folioHeaderMap.get(folioHeader.ExternalId);
	  		if (pass == '1'){
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
		  		folioHotel.d_folio_effective_dt = folioHeader.d_folio_effective_dt__c;
		  		folioHotel.d_folio_expire_dt = folioHeader.d_folio_expire_dt__c;
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
		List<String> allContactIds = new List<String>();
		if (idType == 'contact'){
			allContactIds = getXrefIds(ids);
		}
		//
		// first get all the hotel activities
		//
		String soqlActivity = ' SELECT externalid ';
		soqlActivity += ' FROM lms_hotel_activity__x  ';
		if (idType == 'contact'){
			soqlActivity += whereClause + ': allContactIds';
			soqlActivity += whereClause2 + ': allContactIds';
		} else {
			soqlActivity += whereClause + ': ids';
		}

		List<lms_hotel_activity__x> activityList = (!mockedActivity.isEmpty()) ? mockedActivity : Database.query(soqlActivity);

	  	system.debug('*** activityList ' + activityList );

	  	for (lms_hotel_activity__x activity : activityList ){
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

	  	for (lms_folio_hdr__x folioHeader : folioHeaderList ){
	  		folioHeaderIds.add(folioHeader.ExternalId);
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
		soql1 += ' where lms_folio_hdr_fk__c in: folioHeaderIds ';

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
	private static void updateFolioDetails (Map<String, FolioDetailsWrapper> folioDetailsMap, List<lms_folio_dtl__x> folioDetailsList, String pass){
		FolioDetailsWrapper folioDetail;

		for (lms_folio_dtl__x folioDetails : folioDetailsList ){
	  		if (!folioDetailsMap.containsKey(folioDetails.ExternalId)) {
	  			folioDetailsMap.put(folioDetails.ExternalId, new FolioDetailsWrapper());
	  		}
	  		folioDetail = folioDetailsMap.get(folioDetails.ExternalId);
	  		if (pass == '1'){
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
    * @description Add the xref dmid contacts to capture those activities that have not yet been merged
    * @param List<Id> of Contact Ids used to retrieve the Contact dmids
    * @return List<String> containing the combination of input contact Ids and the xref contact Ids
    * @example
    * 	Set<String> allContactIds = getXrefIds(contactIds);
    */
	@TestVisible private static List<String> getXrefIds(List<String> contactIds){
		system.debug('*** in getxref');
		Set<String> winnetIds = new Set<String>();
		Set<String> xWinnetIds = new Set<String>();
		List<String> xContactIds = new List<String>();
		for (Contact ctc : [SELECT Id, winet_Id__c FROM Contact WHERE Id in :contactIds]){
			if (ctc.winet_Id__c != null){
				winnetIds.add(ctc.winet_Id__c);
			}
		}

		system.debug('*** winnetIds ' + winnetIds);

		List<caesars_gst_id_xref__x> xRefList = (!mockedXref.isEmpty()) ? mockedXref : 
		[SELECT i_dmid__c, i_xref_dmid__c FROM caesars_gst_id_xref__x WHERE i_dmid__c in: winnetIds ];

		system.debug('*** xRefList ' + xRefList);

		for(caesars_gst_id_xref__x gstx : xRefList){
			if (gstx.i_xref_dmid__c != null){
				xWinnetIds.add(gstx.i_xref_dmid__c);
			}
		}

		for (Contact xCtc : [SELECT Id FROM Contact WHERE winet_Id__c in :xWinnetIds]){
			xContactIds.add(xCtc.Id);
		}

		contactIds.addAll(xContactIds);
		system.debug('*** contactIds ' + contactIds);

		return contactIds;

	}

	/*******************************************************************************************************
    * @description Load the code maps
    * @param none
    * @return Map<String, codeObject> of the code tables with the ExternalId as the key
    * @example
    * 	Map<String, Source_code__x> sourceCodeMap = loadSourceCodeMap();
    */
	//private static Map<String, Source_code__x> loadSourceCodeMap(){
	//	Map<String, Source_code__x>  scMap = new Map<String, Source_code__x> ();
	//	for (Source_code__x sourceCode : [SELECT ExternalId,
	//										c_prop_cd__c,
	//										c_quality_cd__c,
	//										c_source_cd__c,
	//										c_source_cd_desc__c,
	//										c_source_group__c,
	//										d_timestamp__c,
	//										id__c,
	//										c_prop_cd_fk__c
	//										FROM Source_code__x
	//										WHERE c_source_cd__c = 'CC']){
	//		scMap.put(sourceCode.ExternalId , sourceCode);
	//	}
	//	system.debug('*** scMap ' + scMap);
	//	return scMap;
	//}

	//private static Map<String, Hotel_act_status_code__x> loadHotelActStatusMap(){
	//	Map<String, Hotel_act_status_code__x> hMap = new Map<String, Hotel_act_status_code__x> ();
	//	for (Hotel_act_status_code__x actStatus : [SELECT ExternalId,
	//										c_activity_desc__c,
	//										c_activity_status__c,
	//										c_prop_cd__c,
	//										c_quality_cd__c,
	//										d_end_dt__c,
	//										d_start_dt__c,
	//										d_timestamp__c,
	//										id__c,
	//										c_prop_cd_fk__c
	//										FROM Hotel_act_status_code__x
	//										WHERE c_activity_status__c = 'C']){
	//		hMap.put(actStatus.ExternalId, actStatus);
	//	}
	//	system.debug('*** hMap ' + hMap);
	//	return hMap;
	//}

	//private static Map<String, Customer_Control_Segments__x> loadCustControlSegmentsMap(){
	//	Map<String, Customer_Control_Segments__x> ccsMap = new Map<String, Customer_Control_Segments__x> ();
	//	for (Customer_Control_Segments__x ccs : [SELECT ExternalId,
	//										c_control_segment_desc__c,
	//										c_control_segment_lvl__c,
	//										c_customer_segment_desc__c,
	//										c_customer_segment_short_desc__c,
	//										c_incented_status__c,
	//										c_known_status__c,
	//										c_prop_cd__c,
	//										c_quality_cd__c,
	//										d_end_dt__c,
	//										d_start_dt__c,
	//										d_timestamp__c,
	//										i_control_segment__c,
	//										i_control_segment_max__c,
	//										i_control_segment_min__c,
	//										i_customer_segment__c,
	//										id__c,
	//										c_prop_cd_fk__c
	//										FROM Customer_Control_Segments__x
	//										WHERE c_prop_cd__c = 'ATL']){
	//		ccsMap.put(ccs.ExternalId, ccs);
	//	}
	//	system.debug('*** ccsMap ' + ccsMap);
	//	return ccsMap;
	//}

	//private static Map<String, Hotel_wing_code__x> loadHotelWingCodesMap(){
	//	Map<String, Hotel_wing_code__x> wingMap = new Map<String, Hotel_wing_code__x> ();
	//	for (Hotel_wing_code__x wing : [SELECT ExternalId,
	//										c_prop_cd__c,
	//										c_quality_cd__c,
	//										c_wing_cd__c,
	//										c_wing_desc__c,
	//										d_end_dt__c,
	//										d_start_dt__c,
	//										d_timestamp__c,											
	//										id__c,
	//										c_prop_cd_fk__c
	//										FROM Hotel_wing_code__x
	//										WHERE c_wing_cd__c = 'RT']){
	//		wingMap.put(wing.ExternalId, wing);
	//		// will lms_hotel_activity populate hotel_wings_cd_fk field??
	//	}
	//	system.debug('*** wingMap ' + wingMap);
	//	return wingMap;
	//}

	//private static Map<String, Lms_Source_Desc_Sda__x> loadSourceDescSdaMap(){
	//	Map<String, Lms_Source_Desc_Sda__x>  scMap = new Map<String, Lms_Source_Desc_Sda__x> ();
	//	for (Lms_Source_Desc_Sda__x sourceDesc : [SELECT ExternalId,
	//										c_prop_cd__c,
	//										c_quality_cd__c,
	//										c_rms_group_source_cd__c,
	//										c_source_cat_sda__c,
	//										c_source_cat1__c,
	//										c_source_cat2__c,
	//										c_source_cat3__c,
	//										c_source_cat4__c,
	//										c_source_cat5__c,
	//										c_source_cat6__c,
	//										c_source_cd__c,
	//										c_source_cd_desc__c,
	//										c_source_group__c,
	//										c_user_flag1__c,
	//										c_user_flag2__c,
	//										c_user_flag3__c,
	//										c_user_flag4__c,
	//										c_user_flag5__c,
	//										c_user_flag6__c,
	//										c_user_flag7__c,
	//										c_user_flag8__c,
	//										d_last_update_ts__c,
	//										d_timestamp__c,
	//										id__c,
	//										f_user_amt1__c,
	//										f_user_amt2__c,
	//										f_user_amt3__c,
	//										f_user_amt4__c,
	//										i_source_cat_sda_sort__c,
	//										i_source_cat1_sort__c,
	//										i_source_cat2_sort__c,
	//										i_source_cat3_sort__c,
	//										i_source_cat4_sort__c,
	//										i_source_cat5_sort__c,
	//										i_source_cat6_sort__c,
	//										i_user_score1__c,
	//										i_user_score2__c,
	//										i_user_score3__c,
	//										i_user_score4__c,
	//										c_prop_cd_fk__c,
	//										c_source_cd_fk__c
	//										FROM Lms_Source_Desc_Sda__x
	//										WHERE c_prop_cd__c = 'ATL']){
	//		scMap.put(sourceDesc.ExternalId, sourceDesc);
	//		// need lms_source_code_desc_fk on lms_hotel_activity
	//	}
	//	system.debug('*** scMap ' + scMap);
	//	return scMap;
	//}

	//private static Map<String, Lms_room_type_desc_sda__x> loadRoomTypeSdaMap(){
	//	Map<String, Lms_room_type_desc_sda__x>  rtMap = new Map<String, Lms_room_type_desc_sda__x> ();
	//	for (Lms_room_type_desc_sda__x roomType : [SELECT ExternalId,
	//										c_prop_cd__c,
	//										c_rm_type__c,
	//										c_room_accessible__c,
	//										c_room_bed_type__c,
	//										c_room_desc1__c,
	//										c_room_desc2__c,
	//										c_room_desc3__c,
	//										c_room_desc4__c,
	//										c_room_quality__c,
	//										c_room_smoking__c,											
	//										c_user_flag1__c,
	//										c_user_flag2__c,
	//										c_user_flag3__c,
	//										c_user_flag4__c,
	//										c_user_flag5__c,
	//										c_user_flag6__c,
	//										c_user_flag7__c,
	//										c_user_flag8__c,
	//										d_last_update_date__c,
	//										f_user_amt1__c,
	//										f_user_amt2__c,
	//										f_user_amt3__c,
	//										f_user_amt4__c,
	//										i_rm_sort_1__c,
	//										i_rm_sort_2__c,
	//										i_rm_sort_3__c,
	//										i_rm_sort_4__c,
	//										i_room_bet_type_sort__c,
	//										i_room_quality_sort__c,
	//										i_user_score1__c,
	//										i_user_score2__c,
	//										i_user_score3__c,
	//										i_user_score4__c,
	//										id__c,
	//										c_prop_cd_fk__c
	//										FROM Lms_room_type_desc_sda__x
	//										WHERE c_prop_cd__c = 'ATL']){
	//		rtMap.put(roomType.ExternalId, roomType);
	//	}
	//	system.debug('*** rtMap ' + rtMap);
	//	return rtMap;
	//}

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
	
	  	global FolioHeaderWrapper(){

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
	
	  	global ActivityVEDWWrapper(){

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
	
	  	global FolioDetailsWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for Hotel Activity
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
	
	  	global ActivityWrapper(){

	  	}
	}
}