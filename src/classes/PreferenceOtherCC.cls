global with sharing class PreferenceOtherCC extends GuestSubjectDataBaseCC {
	
	global PreferenceOtherCC(){}
	
    	/*******************************************************************************************************
	/*******************************************************************************************************
    * @description Retrieve the Preference data from pcs_interest table
    * @param List<Id> of Contact/External Ids used to retrieve
    * @return List<PcsInterestWrapper> containing the retrieved data
    * @example
    * List<PreferencesCC.GuestGamePrefWrapper>  gameGamePrefList = 
	*   		PreferenceOtherCC.retrievePcsInterestByContacts(new List<String>{'0030v0000030aZdAAI'});    */
    @TestVisible private static List<Customer_Info_External_c__x> mockedPcsInterest = new List<Customer_Info_External_c__x>();
	@RemoteAction
	@AuraEnabled
	global static List<PcsInterestWrapper> retrievePcsInterestDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return (new PreferenceOtherCC()).retrievePcsInterest(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<PcsInterestWrapper> retrievePcsInterestByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return (new PreferenceOtherCC()).retrievePcsInterest(contactIds, whereClause, idType);
	}
	
	private List<PcsInterestWrapper> retrievePcsInterest(List<String> Ids, String whereClause, String idType) {	
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged data
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new PreferenceOtherCC()).getConsXrefIds(ids);
		} 	
		List<String> recordTypes = new List<String>{'PCSInterest'};
		String soql1 = soqlFromFieldSet(SOBjectType.customer_info_external_c__x.FieldSets.PCSInterest,
			'customer_info_external_c__x',recordTypes);
		if (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}
		
		Map<String, PcsInterestWrapper> pcsInterestMap = new Map<String, PcsInterestWrapper> ();
		List<customer_info_external_c__x> pcsInterestList = (!mockedPcsInterest.isEmpty()) ? mockedPcsInterest : Database.query(soql1);
	  	system.debug('*** pcsInterestList ' + pcsInterestList );

	  	updatePcsInterest (pcsInterestMap, pcsInterestList, '1');
	  	system.debug('*** pcsInterestList return ' + pcsInterestMap.values());

	  	return pcsInterestMap.values();
	}
	
    private static void updatePcsInterest (Map<String, PcsInterestWrapper> pcsInterestMap, List<customer_info_external_c__x> pcsInterestList, String pass){
		for (customer_info_external_c__x pcsInterest : pcsInterestList ){
	  		if (pcsInterestMap.containsKey(pcsInterest.ExternalId)) {
	  			if (pass == '1'){
					PcsInterestWrapper pcsInterestWrap = pcsInterestMap.get(pcsInterest.ExternalId);
					pcsInterestWrap.copyfromCustomerInfo(pcsInterest);
					pcsInterestMap.put(pcsInterestWrap.ExternalId, pcsInterestWrap);
			  	}
	  		} else {
		  		pcsInterestMap.put(pcsInterest.ExternalId, new PcsInterestWrapper(pcsInterest));
	  		}
	  	}
	}  
    
    	/*******************************************************************************************************
    * @description Wrapper class for pcs_interest
    */
	global class PcsInterestWrapper extends PrefWrapperBase {
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String ExternalId { get; set; } 
		
		@AuraEnabled global Decimal i_interest_id { get; set; }
		@AuraEnabled global String c_interest { get; set; } 
		@AuraEnabled global String c_interest_group { get; set; } 
		@AuraEnabled global String c_interest_status { get; set; } 
		@AuraEnabled global String c_interest_notes { get; set; } 
		@AuraEnabled global String c_app_cd { get; set; } 
		
		global PcsInterestWrapper(){
	  	}
	  	
	  	global PcsInterestWrapper(customer_info_external_c__x pcsInterest){
			copyfromCustomerInfo(pcsInterest);
	  	}
	  	
	  	//CustomerInfo to PcsInterestWrapper Mapping
	  	global void copyfromCustomerInfo(customer_info_external_c__x pcsInterest){
	  			recordtype = pcsInterest.recordtype__c;
		  		ExternalId = pcsInterest.ExternalId;
		  		
				c_interest = pcsInterest.interest__c;
				c_interest_group = pcsInterest.interest_group__c;
				c_interest_status = pcsInterest.interest_status__c;
				c_interest_notes = pcsInterest.interest_notes__c;
				c_app_cd = pcsInterest.app_cd__c;
	  	}
	}	
	
	
		
	/*******************************************************************************************************
	//guest_game5
	/*******************************************************************************************************
    * @description Retrieve the Preference data from guest_game5 table
    * @param List<Id> of Contact/External Ids used to retrieve
    * @return List<GuestGamePrefWrapper> containing the retrieved data
    * @example
    * List<PreferencesCC.GuestGamePrefWrapper>  gameGamePrefList = 
	*   		PreferenceOtherCC.retrieveGuestGamePrefByContacts(new List<String>{'0030v0000030awyAAA'});
    */
    @TestVisible private static List<Customer_Info_External_c__x> mockedGuestGamePref = new List<Customer_Info_External_c__x>();
	@RemoteAction
	@AuraEnabled
	global static List<GuestGamePrefWrapper> retrieveGuestGamePrefDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return (new PreferenceOtherCC()).retrieveGuestGamePref(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<GuestGamePrefWrapper> retrieveGuestGamePrefByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return (new PreferenceOtherCC()).retrieveGuestGamePref(contactIds, whereClause, idType);
	}
	
	global List<GuestGamePrefWrapper> retrieveGuestGamePref(List<String> Ids, String whereClause, String idType) {		
		List<String> recordTypes = new List<String>{'GuestGame5'};
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged data
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new PreferenceOtherCC()).getConsXrefIds(ids);
		} 
		String soql1 = soqlFromFieldSet(SOBjectType.customer_info_external_c__x.FieldSets.PrefGame5,
			'customer_info_external_c__x',recordTypes);
		if (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}
		system.debug('*** soql1 ' + soql1);
		
		Map<String, GuestGamePrefWrapper> guestGamePrefMap = new Map<String, GuestGamePrefWrapper> ();
		List<customer_info_external_c__x> guestGamePrefList = (!mockedGuestGamePref.isEmpty()) ? mockedGuestGamePref : Database.query(soql1);
	  	system.debug('*** guestGamePrefList ' + guestGamePrefList );

	  	updateGuestGamePref (guestGamePrefMap, guestGamePrefList, '1');
	  	system.debug('*** guestGamePrefList return ' + guestGamePrefMap.values());

	  	return guestGamePrefMap.values();
	}
	
    private static void updateGuestGamePref (Map<String, GuestGamePrefWrapper> guestGamePrefMap, List<customer_info_external_c__x> guestGamePrefList, String pass){
		for (customer_info_external_c__x guestGamePref : guestGamePrefList ){
	  		if (guestGamePrefMap.containsKey(guestGamePref.ExternalId)) {
	  			if (pass == '1'){
					GuestGamePrefWrapper guestGamePrefWrap = guestGamePrefMap.get(guestGamePref.ExternalId);
					guestGamePrefWrap.copyfromCustomerInfo(guestGamePref);
					guestGamePrefMap.put(guestGamePrefWrap.ExternalId, guestGamePrefWrap);
			  	}
	  		} else {
		  		guestGamePrefMap.put(guestGamePref.ExternalId, new GuestGamePrefWrapper(guestGamePref));
	  		}
	  	}
	}  
    
    	/*******************************************************************************************************
    * @description Wrapper class for guest_game5
    */
	global class GuestGamePrefWrapper extends PrefWrapperBase {
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String ExternalId { get; set; } 
		
		@AuraEnabled global String c_game_type { get; set; } 
		@AuraEnabled global String c_group_1 { get; set; } 
		@AuraEnabled global String c_group_2 { get; set; } 
		@AuraEnabled global String c_group_3 { get; set; } 
		@AuraEnabled global String c_group_4 { get; set; } 
		@AuraEnabled global String c_group_5 { get; set; } 
		@AuraEnabled global Decimal i_top1_value { get; set; } 
		@AuraEnabled global Decimal i_top5_value { get; set; } 
		@AuraEnabled global Decimal i_total_value { get; set; } 
		@AuraEnabled global Decimal i_groups { get; set; } 
		@AuraEnabled global Decimal i_cards_top { get; set; } 
		@AuraEnabled global Decimal i_cards_total { get; set; } 
		@AuraEnabled global Decimal i_machines { get; set; } 
		@AuraEnabled global Decimal f_denom_pref { get; set; } 
		@AuraEnabled global Decimal i_denom { get; set; } 
		@AuraEnabled global Decimal i_denom_pref { get; set; } 
		@AuraEnabled global Decimal i_denom_total { get; set; } 
		@AuraEnabled global String c_user_flag_1 { get; set; } 
		@AuraEnabled global String c_user_flag_2 { get; set; } 
		@AuraEnabled global String c_user_flag_3 { get; set; } 
		@AuraEnabled global String c_user_flag_4 { get; set; } 
		@AuraEnabled global String c_user_flag_5 { get; set; } 
		@AuraEnabled global String c_user_flag_6 { get; set; } 
		@AuraEnabled global String c_user_flag_7 { get; set; } 
		@AuraEnabled global String c_user_flag_8 { get; set; } 
		@AuraEnabled global String c_user_flag_9 { get; set; } 
		@AuraEnabled global String c_user_flag_10 { get; set; } 
		@AuraEnabled global Decimal i_user_score_1 { get; set; } 
		@AuraEnabled global Decimal i_user_score_2 { get; set; } 
		@AuraEnabled global Decimal i_user_score_3 { get; set; } 
		@AuraEnabled global Decimal i_user_score_4 { get; set; } 
		@AuraEnabled global Decimal i_user_score_5 { get; set; } 
		@AuraEnabled global Decimal i_user_score_6 { get; set; } 
		@AuraEnabled global Decimal i_user_score_7 { get; set; } 
		@AuraEnabled global Decimal i_user_score_8 { get; set; } 
		@AuraEnabled global Decimal i_user_score_9 { get; set; } 
		@AuraEnabled global Decimal i_user_score_10 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_1 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_2 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_3 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_4 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_5 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_6 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_7 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_8 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_9 { get; set; } 
		@AuraEnabled global Decimal f_user_amt_10 { get; set; } 
		
		global GuestGamePrefWrapper(){
	  	}
	  	global GuestGamePrefWrapper(customer_info_external_c__x pcsInterest){
			copyfromCustomerInfo(pcsInterest);
	  	}
	  	//CustomerInfo to GuestGamePrefWrapper Mapping
	  	global void copyfromCustomerInfo(customer_info_external_c__x guestGamePref){
	  			recordtype = guestGamePref.recordtype__c;
		  		ExternalId = guestGamePref.ExternalId;
		  		
				c_game_type = guestGamePref.game_type__c;
				c_group_1 = guestGamePref.group_1__c;
				c_group_2 = guestGamePref.group_2__c;
				c_group_3 = guestGamePref.group_3__c;
				c_group_4 = guestGamePref.group_4__c;
				c_group_5 = guestGamePref.group_5__c;
				i_top1_value = guestGamePref.top1_value__c;
				i_top5_value = guestGamePref.top5_value__c;
				i_total_value = guestGamePref.total_value__c;
				i_groups = guestGamePref.groups__c;
				i_cards_top = guestGamePref.cards_top__c;
				i_cards_total = guestGamePref.cards_total__c;
				i_machines = guestGamePref.machines__c;
				f_denom_pref = guestGamePref.denom_pref__c;
				i_denom = guestGamePref.denom__c;
				i_denom_pref = guestGamePref.denom_pref_i__c;
				i_denom_total = guestGamePref.denom_total__c;
				
				c_user_flag_1= guestGamePref.user_flag_1__c;
				c_user_flag_2= guestGamePref.user_flag_2__c;
				c_user_flag_3= guestGamePref.user_flag_3__c;
				c_user_flag_4= guestGamePref.user_flag_4__c;
				c_user_flag_5= guestGamePref.user_flag_5__c;
				c_user_flag_6= guestGamePref.user_flag_6__c;
				c_user_flag_7= guestGamePref.user_flag_7__c;
				c_user_flag_8= guestGamePref.user_flag_8__c;
				c_user_flag_9= guestGamePref.user_flag_9__c;
				c_user_flag_10= guestGamePref.user_flag_10__c;
				
				i_user_score_1= guestGamePref.user_score_1__c;
				i_user_score_2= guestGamePref.user_score_2__c;
				i_user_score_3= guestGamePref.user_score_3__c;
				i_user_score_4= guestGamePref.user_score_4__c;
				i_user_score_5= guestGamePref.user_score_5__c;
				i_user_score_6= guestGamePref.user_score_6__c;
				i_user_score_7= guestGamePref.user_score_7__c;
				i_user_score_8= guestGamePref.user_score_8__c;
				i_user_score_9= guestGamePref.user_score_9__c;
				i_user_score_10= guestGamePref.user_score_10__c;
				
				f_user_amt_1= guestGamePref.user_amt_1__c;
				f_user_amt_2= guestGamePref.user_amt_2__c;
				f_user_amt_3= guestGamePref.user_amt_3__c;
				f_user_amt_4= guestGamePref.user_amt_4__c;
				f_user_amt_5= guestGamePref.user_amt_5__c;
				f_user_amt_6= guestGamePref.user_amt_6__c;
				f_user_amt_7= guestGamePref.user_amt_7__c;
				f_user_amt_8= guestGamePref.user_amt_8__c;
				f_user_amt_9= guestGamePref.user_amt_9__c;
				f_user_amt_10= guestGamePref.user_amt_10__c;
	  	}
	}	
				
	/*******************************************************************************************************
	//gst_pref_specified - Channel -  Email/DirectMail/NoPreference
	/*******************************************************************************************************
    * @description Retrieve the Preference data from gst_pref_specified table
    * @param List<Id> of Contact/External Ids used to retrieve
    * @return List<GuestGamePrefWrapper> containing the retrieved data
    *
    * @example
	* List<PreferenceOtherCC.GuestPrefSpecWrapper>  guestPrefSpecList = 
	*      PreferenceOtherCC.retrieveGuestPrefSpecByContacts(new List<String>{'0030v0000030awyAAA'});
    */
    @TestVisible private static List<Customer_Info_External_c__x> mockedGuestPrefSpec = new List<Customer_Info_External_c__x>();
	@RemoteAction
	@AuraEnabled
	global static List<GuestPrefSpecWrapper> retrieveGuestPrefSpecDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return (new PreferenceOtherCC()).retrieveGuestPrefSpec(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<GuestPrefSpecWrapper> retrieveGuestPrefSpecByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return (new PreferenceOtherCC()).retrieveGuestPrefSpec(contactIds, whereClause, idType);
	}
	
	global List<GuestPrefSpecWrapper> retrieveGuestPrefSpec(List<String> Ids, String whereClause, String idType) {		
		List<String> recordTypes = new List<String>{'PrefSpecified'};
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged data
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new PreferenceOtherCC()).getConsXrefIds(ids);
		} 
		String soql1 = soqlFromFieldSet(SOBjectType.customer_info_external_c__x.FieldSets.PrefSpecified,
			'customer_info_external_c__x',recordTypes);
		if (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}
		system.debug('*** soql1 ' + soql1);
		
		Map<String, GuestPrefSpecWrapper> guestPrefSpecMap = new Map<String, GuestPrefSpecWrapper> ();
		List<customer_info_external_c__x> guestPrefSpecList = (!mockedGuestPrefSpec.isEmpty()) ? mockedGuestPrefSpec : Database.query(soql1);
	  	system.debug('*** guestPrefSpecList ' + guestPrefSpecList );

	  	updateGuestSpecPref (guestPrefSpecMap, guestPrefSpecList, '1');
	  	system.debug('*** guestPrefSpecMap return ' + guestPrefSpecMap.values());

	  	return guestPrefSpecMap.values();
	}
	
    private static void updateGuestSpecPref (Map<String, GuestPrefSpecWrapper> guestPrefSpecMap, List<customer_info_external_c__x> guestPrefSpecList, String pass){
		for (customer_info_external_c__x guestPrefSpec : guestPrefSpecList ){
	  		if (guestPrefSpecMap.containsKey(guestPrefSpec.ExternalId)) {
	  			if (pass == '1'){
					GuestPrefSpecWrapper guestPrefSpecWrap = guestPrefSpecMap.get(guestPrefSpec.ExternalId);
					guestPrefSpecWrap.copyfromCustomerInfo(guestPrefSpec);
					guestPrefSpecMap.put(guestPrefSpec.ExternalId, guestPrefSpecWrap);
			  	}
	  		} else {
		  		guestPrefSpecMap.put(guestPrefSpec.ExternalId, new GuestPrefSpecWrapper(guestPrefSpec));
	  		}
	  	}
	}  
    
    	/*******************************************************************************************************
    * @description Wrapper class for gst_pref_specified
    */
	global class GuestPrefSpecWrapper extends PrefWrapperBase {
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String ExternalId { get; set; } 
		
		@AuraEnabled global String c_channel_pref { get; set; } 
		@AuraEnabled global String c_quality_cd { get; set; } 
		
		global GuestPrefSpecWrapper(){
	  	}
	  	global GuestPrefSpecWrapper(customer_info_external_c__x guestPrefSpec){
			copyfromCustomerInfo(guestPrefSpec);
	  	}
	  	//CustomerInfo to GuestGamePrefWrapper Mapping
	  	global void copyfromCustomerInfo(customer_info_external_c__x guestPrefSpec){
	  			recordtype = guestPrefSpec.recordtype__c;
		  		ExternalId = guestPrefSpec.ExternalId;
		  		
		  		c_channel_pref = guestPrefSpec.channel_pref__c;
				c_quality_cd = guestPrefSpec.quality_cd__c;
	  	}
	}	
	

	/*******************************************************************************************************
	//gst_pref_hotel
	/*******************************************************************************************************
    * @description Retrieve the Preference data from gst_pref_hotel table
    * @param List<Id> of Contact/External Ids used to retrieve
    * @return List<GuestGamePrefWrapper> containing the retrieved data
    *
    * @example
	* List<PreferenceOtherCC.GuestPrefHotelWrapper>  guestPrefHotelfList = 
	*      PreferenceOtherCC.retrieveGuestPrefHotelByContacts(new List<String>{'0030v0000030aa1AAA'});
    */
    @TestVisible private static List<Customer_Info_External_c__x> mockedGuestPrefHotel = new List<Customer_Info_External_c__x>();
	@RemoteAction
	@AuraEnabled
	global static List<GuestPrefHotelWrapper> retrieveGuestPrefHotelDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return (new PreferenceOtherCC()).retrieveGuestPrefHotel(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<GuestPrefHotelWrapper> retrieveGuestPrefHotelByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return (new PreferenceOtherCC()).retrieveGuestPrefHotel(contactIds, whereClause, idType);
	}
	
	global List<GuestPrefHotelWrapper> retrieveGuestPrefHotel(List<String> ids, String whereClause, String idType) {		
		List<String> recordTypes = new List<String>{'PrefHotel'};
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged data
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new PreferenceOtherCC()).getConsXrefIds(ids);
		} 
		String soql1 = soqlFromFieldSet(SOBjectType.customer_info_external_c__x.FieldSets.PrefHotel,
			'customer_info_external_c__x',recordTypes);
		if (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}
		system.debug('*** soql1 ' + soql1);
		
		Map<String, GuestPrefHotelWrapper> guestPrefHotelMap = new Map<String, GuestPrefHotelWrapper> ();
		List<customer_info_external_c__x> guestPrefHotelList = (!mockedGuestPrefHotel.isEmpty()) ? mockedGuestPrefHotel : Database.query(soql1);
	  	system.debug('*** guestPrefHotelList ' + guestPrefHotelList );

	  	updateGuestSpecHotel (guestPrefHotelMap, guestPrefHotelList, '1');
	  	system.debug('*** guestPrefHotelMap return ' + guestPrefHotelMap.values());

	  	return guestPrefHotelMap.values();
	}
	
    private static void updateGuestSpecHotel (Map<String, GuestPrefHotelWrapper> guestPrefHotelMap, List<customer_info_external_c__x> guestPrefHotelList, String pass){
		for (customer_info_external_c__x guestPrefHotel : guestPrefHotelList ){
	  		if (guestPrefHotelMap.containsKey(guestPrefHotel.ExternalId)) {
	  			if (pass == '1'){
					GuestPrefHotelWrapper guestPrefHotelWrap = guestPrefHotelMap.get(guestPrefHotel.ExternalId);
					guestPrefHotelWrap.copyfromCustomerInfo(guestPrefHotel);
					guestPrefHotelMap.put(guestPrefHotel.ExternalId, guestPrefHotelWrap);
			  	}
	  		} else {
		  		guestPrefHotelMap.put(guestPrefHotel.ExternalId, new GuestPrefHotelWrapper(guestPrefHotel));
	  		}
	  	}
	}  	
	
	/*******************************************************************************************************
    * @description Wrapper class for gst_pref_hotel
    */
	global class GuestPrefHotelWrapper extends PrefWrapperBase {
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String ExternalId { get; set; } 
		
		@AuraEnabled global String c_cc_type { get; set; } 
		@AuraEnabled global String c_cc_number { get; set; } 
		
		@AuraEnabled global String d_cc_expire_dt { get; set; } 
		@AuraEnabled global String c_smoking { get; set; } 
		@AuraEnabled global String c_bed_type { get; set; } 
		@AuraEnabled global String c_room_type { get; set; }
		@AuraEnabled global String c_spcl_request { get; set; } 
		@AuraEnabled global String c_spcl_instruction { get; set; }
		@AuraEnabled global String c_companion_id { get; set; } 
		@AuraEnabled global String c_quality_cd { get; set; }
		global GuestPrefHotelWrapper(){
	  	}
	  	global GuestPrefHotelWrapper(customer_info_external_c__x guestPrefHotel){
			copyfromCustomerInfo(guestPrefHotel);
	  	}
	  	//CustomerInfo to GuestPrefHotelWrapper Mapping
	  	global void copyfromCustomerInfo(customer_info_external_c__x guestPrefHotel){
	  			recordtype = guestPrefHotel.recordtype__c;
		  		ExternalId = guestPrefHotel.ExternalId;
		  		
		  		c_cc_type = guestPrefHotel.cc_type__c;
				c_cc_number = guestPrefHotel.cc_number__c;
				d_cc_expire_dt = guestPrefHotel.cc_expire_dt__c;
				
				c_smoking = guestPrefHotel.smoking__c;
				c_bed_type = guestPrefHotel.bed_type__c;
				
				c_room_type = guestPrefHotel.room_type__c;
				c_spcl_request = guestPrefHotel.spcl_request__c;
				c_spcl_instruction = guestPrefHotel.spcl_instruction__c;
				c_quality_cd = guestPrefHotel.quality_cd__c;	
	  	}
	}	
	
	/*******************************************************************************************************
	//gst_interest
	/*******************************************************************************************************
    * @description Retrieve the Preference data from gst_interest table
    * @param List<Id> of Contact/External Ids used to retrieve
    * @return List<GuestGamePrefWrapper> containing the retrieved data
    	*
    * @example
	* List<PreferenceOtherCC.GuestInterestWrapper>  guestInterestList = 
	*    PreferenceOtherCC.retrieveGuestInterestByContacts(new List<String>{'0030v0000030aa1AAA'});
    */
    @TestVisible private static List<Customer_Info_External_c__x> mockedGuestInterest = new List<Customer_Info_External_c__x>();
	@RemoteAction
	@AuraEnabled
	global static List<GuestInterestWrapper> retrieveGuestInterestDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return (new PreferenceOtherCC()).retrieveGuestInterest(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<GuestInterestWrapper> retrieveGuestInterestByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return (new PreferenceOtherCC()).retrieveGuestInterest(contactIds, whereClause, idType);
	}
	
	global List<GuestInterestWrapper> retrieveGuestInterest(List<String> ids, String whereClause, String idType) {		
		List<String> recordTypes = new List<String>{'Interest'};
		//
		// get the cross-reference dmIds for the contacts in order to access unmerged data
		//
		List<String> allContactIds = new List<String>();
		if (idType == 'contact') {
			allContactIds = (new PreferenceOtherCC()).getConsXrefIds(ids);
		} 
		String soql1 = soqlFromFieldSet(SOBjectType.customer_info_external_c__x.FieldSets.Interest,
			'customer_info_external_c__x',recordTypes,new List<String>{'interest_cd_fk__r.Name','interest_cd_fk__r.interest_type__c', 'interest_cd_fk__r.description__c'});
		if (idType == 'contact') {
			soql1 += whereClause + ': allContactIds';
		} else {
			soql1 += whereClause + ': ids';
		}
		system.debug('*** soql1x ' + soql1);
		
		Map<String, GuestInterestWrapper> guestInterestMap = new Map<String, GuestInterestWrapper> ();
		List<customer_info_external_c__x> guestInterestList = (!mockedGuestInterest.isEmpty()) ? mockedGuestInterest : Database.query(soql1);
	  	system.debug('*** guestInterestList ' + guestInterestList );

	  	updateGuestInterest (guestInterestMap, guestInterestList, '1');
	  	system.debug('*** guestInterestMap return ' + guestInterestMap.values());

	  	return guestInterestMap.values();
	}
	
    private static void updateGuestInterest (Map<String, GuestInterestWrapper> guestInterestMap, List<customer_info_external_c__x> guestInterestList, String pass){
		for (customer_info_external_c__x guestInterest : guestInterestList ){
	  		if (guestInterestMap.containsKey(guestInterest.ExternalId)) {
	  			if (pass == '1'){
					GuestInterestWrapper guestInterestWrap = guestInterestMap.get(guestInterest.ExternalId);
					guestInterestWrap.copyfromCustomerInfo(guestInterest);
					guestInterestMap.put(guestInterest.ExternalId, guestInterestWrap);
			  	}
	  		} else {
		  		guestInterestMap.put(guestInterest.ExternalId, new GuestInterestWrapper(guestInterest));
	  		}
	  	}
	}  	
	/*******************************************************************************************************
    * @description Wrapper class for gst_interest
    */
	global class GuestInterestWrapper extends PrefWrapperBase {
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String ExternalId { get; set; } 
		
		@AuraEnabled global String c_interest_cd { get; set; } 
		@AuraEnabled global String c_interest_type { get; set; } 
		@AuraEnabled global String c_interest_desc { get; set; } 
		
		global GuestInterestWrapper(){
	  	}
	  	global GuestInterestWrapper(customer_info_external_c__x guestInterest){
			copyfromCustomerInfo(guestInterest);
	  	}
	  	//CustomerInfo to GuestInterestWrapper Mapping
	  	global void copyfromCustomerInfo(customer_info_external_c__x guestInterest){
	  			recordtype = guestInterest.recordtype__c;
		  		ExternalId = guestInterest.ExternalId;
		  		
		  		c_interest_cd = guestInterest.interest_cd_fk__r.Name;
				c_interest_type = guestInterest.interest_cd_fk__r.interest_type__c;
				c_interest_desc = guestInterest.interest_cd_fk__r.description__c;
	  	}
	}	
}