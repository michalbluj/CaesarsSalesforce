/**
* @author Benjamin Lau
* @date Aug 2017
*
* @description Class to retrieve Guest Preference extending base class GuestSubjectcDataBase.cls
* 	1) Enterprice Preference [GLBA, Specialty, program_subs, temp, interests, events, htl_brand]
*   2) PCS_Interest
*	3) Guest Game Preference [ guest_game5 ]
*   4) Guest Pref Specified [ gst_pref_specified ]
*	5) Guest Pref Hotel [ gst_pref_hotel ]
*   6) Guest Interest [ gst_interest ]           
*/
global with sharing class PreferenceEnterpriseCC extends GuestSubjectDataBaseCC {
    global PreferenceEnterpriseCC() {}
    
    //PreferenceEnterpriseCC.test();
    global static void test() {
    		List<String> contacts = new List<String>{};
    	
    		PreferenceEnterpriseCC.retrieveEnterprisePrefByContacts(new List<String>{'0030v0000030bO5AAI'}); 
    }
    
    	/*******************************************************************************************************	
	/*******************************************************************************************************
    * @description Retrieve the Email data from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the Email data
    * @return List<EmailWrapper> containing the retrieved data
    * @example
    * List<PreferenceEnterpriseCC.EntPrefSubType>  entPrefList = 
    *	PreferenceEnterpriseCC.retrieveEnterprisePrefByContacts(new List<String>{'0030v0000030bO5AAI'}); 
    */
    
    	@RemoteAction
	@AuraEnabled
	global static List<EntPrefSubType> retrieveEnterprisePrefByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return (new PreferenceEnterpriseCC()).retrieveEnterprisePref(contactIds, whereClause, idType);
	}
	   
	private List<EntPrefSubType> retrieveEnterprisePref(List<String> Ids, String whereClause, String idType) {
		
		Map<String, EnterprisePrefWrapper> entPrefMap = retrievePatronPref(Ids, whereClause, idType);
		Map<String, EnterprisePrefRespWrapper> entPrefRespMap = retrievePatronPrefResp(Ids, whereClause, idType);
		
		//build preference map
		set<Decimal> preferenceIdSet = new set<Decimal>();
		for(EnterprisePrefWrapper pref : entPrefMap.values()) {
			preferenceIdSet.add(decimal.valueof(pref.preferenceId));
		}
		for(EnterprisePrefRespWrapper prefResp : entPrefRespMap.values()) {
			preferenceIdSet.add(decimal.valueof(prefResp.preferenceId));
		}
		
		list<Preference_Type__c> preferemceTypes = [
			select id, name, Preference_Id__c, Display_Name__c,
			Preference_Category__r.id, Preference_Category__r.Category_Id__c, 
			Property_Code__c, Property_Code__r.Name  //property code is a record type of account
			from Preference_Type__c
			where Preference_Id__c in :preferenceIdSet
		];
		
		map<String,Preference_Type__c> prefTypeMap = new map<String, Preference_Type__c>();
		for(Preference_Type__c prefType : preferemceTypes) {
			prefTypeMap.put(String.valueOf(prefType.Preference_Id__c), prefType);
		}
		
		//setup Category Path
		//map the resp to the pref
		//sort into lists
		List<EntPrefSubType> result = new List<EntPrefSubType>();
		for(EnterprisePrefWrapper pref : entPrefMap.values()) {
			Preference_Type__c prefType = prefTypeMap.get(String.valueOf(pref.preferenceId));
			String propertyDesc = prefType.Property_Code__r.Name;
			String categoryId = String.ValueOf(prefType.Preference_Category__r.Category_Id__c);
			String path = PreferenceCategoryModel.getPath(categoryId);
			
			System.Debug(pref.preferenceId + ' : ' + 
				prefType.Property_Code__c + ' : ' + propertyDesc + ' : '+ 
				categoryId + ' : '+ path);
				
			EntPrefSubType subType = new EntPrefSubType(pref);
			subType.categoryPath = path;
			if ( propertyDesc == null) {
				subType.propertyDesc = '';
			} else {
				subType.propertyDesc = propertyDesc;
			}
			subType.prefType = prefType.Display_Name__c;
			
			if (PreferenceCategoryModel.isPrefEvents(path) ) {
				subType.prefFamily = 'Events';
			} else if (PreferenceCategoryModel.isPrefGLBA(path) ) {
				subType.prefFamily = 'GLBA';
			} else if (PreferenceCategoryModel.isPrefHtlBrand(path) ) {
				subType.prefFamily = 'Hotel Brand';
			} else if (PreferenceCategoryModel.isPrefInterests(path) ) {
				subType.prefFamily = 'Interest';
			} else if (PreferenceCategoryModel.isPrefPartnerSubs(path) ) {
				subType.prefFamily = 'Partner Subs';
			} else if (PreferenceCategoryModel.isPrefProgramSubs(path) ) {
				subType.prefFamily = 'Program Subs';
			} else if (PreferenceCategoryModel.isPrefSpecialty(path) ) {
				subType.prefFamily = 'Specialty';
			} else if (PreferenceCategoryModel.isPrefTemp(path) ) {
				subType.prefFamily = 'Temp List';
			} else if (PreferenceCategoryModel.isPrefBeverage(path) ) {
				subType.prefFamily = 'Beverages';
			} else {
				//other
				subType.prefFamily = 'Other Prefs';
			}
			
			result.add(subType);
		}
		
		System.Debug(JSON.serializePretty(result));
		return result;
		
	  	//return entPrefMap.values();
	}
	
	
	global class EntPrefSubType extends PrefWrapperBase {
		@AuraEnabled global String prefFamily { get; set; }
		
		@AuraEnabled global String prefType { get; set; }
		@AuraEnabled global String prefTypeId { get; set; }
		@AuraEnabled global String categoryPath { get; set; }
		@AuraEnabled global String propertyDesc { get; set; }
		
		@AuraEnabled global String responseCode { get; set; }
		@AuraEnabled global String responseDesc { get; set; }
		
		//@AuraEnabled global String updateDate { get; set; }
		@AuraEnabled global String createDate { get; set; }
	
		global EntPrefSubType(){
		}
		
		global EntPrefSubType(EnterprisePrefWrapper pref){
			prefTypeId = pref.preferenceId;
			responseCode = pref.response;
			if ( responseCode == '1') {
				responseDesc = 'yes/likes';
			} else if ( responseCode == '2') {
				responseDesc = 'no/dislikes';
			} else {
				responseDesc = 'not stated';
			}
			createDate = pref.createUpdate;
			//updateDate = perf.;
			
		}
	}
	
    
    @TestVisible private static List<Customer_Info_External_c__x> mockedEnterprisePref = new List<Customer_Info_External_c__x>();
    private Map<String, EnterprisePrefWrapper> retrievePatronPref(List<String> Ids, String whereClause, String idType) {
    	
    		List<String> recordTypes = new List<String>{'PatronPref'};
		String soql1 = soqlFromFieldSet(SOBjectType.customer_info_external_c__x.FieldSets.PatronPref,
			'customer_info_external_c__x',recordTypes);
		soql1 += whereClause + ' :ids';
		system.debug('*** soql1 ' + soql1);
		  
		List<customer_info_external_c__x> entPrefList = (!mockedEnterprisePref.isEmpty()) ? mockedEnterprisePref : Database.query(soql1);
	  	system.debug('*** entPrefList ' + entPrefList );
	  	
	  	Map<String, EnterprisePrefWrapper> entPrefMap =  updatePatronPref(entPrefList, '1');
	  	system.debug('*** entPrefList return ' + entPrefMap.values());
    	
    		return entPrefMap;
    }
    
	private static Map<String, EnterprisePrefWrapper> updatePatronPref(List<customer_info_external_c__x> guestEntPrefList, String pass){
		Map<String, EnterprisePrefWrapper> entPrefMap = new Map<String, EnterprisePrefWrapper> ();
		
		for (customer_info_external_c__x guestEntPref : guestEntPrefList ){
	  		if (entPrefMap.containsKey(guestEntPref.ExternalId)) {
	  			if (pass == '1'){
					EnterprisePrefWrapper guestEntPrefWrap = entPrefMap.get(guestEntPref.ExternalId);
					guestEntPrefWrap.copyfromCustomerInfo(guestEntPref);
					entPrefMap.put(guestEntPrefWrap.ExternalId, guestEntPrefWrap);
			  	}
	  		} else {
		  		entPrefMap.put(guestEntPref.ExternalId, new EnterprisePrefWrapper(guestEntPref));
	  		}
	  	}
	  	
	  	return entPrefMap;
	}    
    
    @TestVisible private static List<Customer_Info_External_c__x> mockedEnterprisePrefResp = new List<Customer_Info_External_c__x>();
    private Map<String, EnterprisePrefRespWrapper> retrievePatronPrefResp(List<String> Ids, String whereClause, String idType) {
    		List<String> recordTypes = new List<String>{'PatronPrefResp'};
		String soql1 = soqlFromFieldSet(SOBjectType.customer_info_external_c__x.FieldSets.PatronPrefResp,
			'customer_info_external_c__x',recordTypes);
		soql1 += whereClause + ' :ids';
		system.debug('*** soql1 ' + soql1);
		  
		List<customer_info_external_c__x> entPrefRespList = (!mockedEnterprisePref.isEmpty()) ? mockedEnterprisePref : Database.query(soql1);
	  	system.debug('*** entPrefRespList ' + entPrefRespList );
	  	
	  	Map<String, EnterprisePrefRespWrapper> entPrefRespMap =  updatePatronPrefResp(entPrefRespList, '1');
	  	system.debug('*** entPrefRespMap return ' + entPrefRespMap.values());
    	
    		return entPrefRespMap;
    }    
    
   	private static Map<String, EnterprisePrefRespWrapper> updatePatronPrefResp(List<customer_info_external_c__x> guestEntPrefRespList, String pass){
		Map<String, EnterprisePrefRespWrapper> entPrefRespMap = new Map<String, EnterprisePrefRespWrapper> ();
		
		for (customer_info_external_c__x guestEntPrefResp : guestEntPrefRespList ){
	  		if (entPrefRespMap.containsKey(guestEntPrefResp.ExternalId)) {
	  			if (pass == '1'){
					EnterprisePrefRespWrapper guestEntPrefRespWrap = entPrefRespMap.get(guestEntPrefResp.ExternalId);
					guestEntPrefRespWrap.copyfromCustomerInfo(guestEntPrefResp);
					entPrefRespMap.put(guestEntPrefRespWrap.ExternalId, guestEntPrefRespWrap);
			  	}
	  		} else {
		  		entPrefRespMap.put(guestEntPrefResp.ExternalId, new EnterprisePrefRespWrapper(guestEntPrefResp));
	  		}
	  	}
	  	
	  	return entPrefRespMap;
	}   
    
    
    	/*******************************************************************************************************
    * @description Wrapper class for EnterprisePrefWrapper
    */
	global class EnterprisePrefWrapper extends PrefWrapperBase {
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String ExternalId { get; set; } 
		
		//@AuraEnabled global String i_dmid { get; set; }
		//@AuraEnabled global Decimal id { get; set; }

		@AuraEnabled global String preferenceId { get; set; }
		//@AuraEnabled global String i_original_dmid{ get; set; }
		@AuraEnabled global String c_ok2ask_flag{ get; set; }
		@AuraEnabled global String response{ get; set; }
		
		@AuraEnabled global Decimal rankValue { get; set; }
		@AuraEnabled global String freeformValue { get; set; }
		//@AuraEnabled global String d_timestamp { get; set; }
				
		@AuraEnabled global String createUpdate { get; set; }
		@AuraEnabled global String itQryCategory { get; set; }
		
		@AuraEnabled global String modifierLogin { get; set; }
		@AuraEnabled global String modifierWorkstation { get; set; }
		@AuraEnabled global String modifierLocation { get; set; }
		
		@AuraEnabled global String dataSourceCd { get; set; }
		@AuraEnabled global Decimal fileId { get; set; }
		@AuraEnabled global String insRunId { get; set; }
		@AuraEnabled global Decimal updRunId { get; set; }

	  	global EnterprisePrefWrapper(){	  	
	  	}
	  	
	  	global EnterprisePrefWrapper(customer_info_external_c__x guestEntPref){
			copyfromCustomerInfo(guestEntPref);
	  	}
	  	//CustomerInfo to EnterprisePrefWrapper Mapping
	  	global void copyfromCustomerInfo(customer_info_external_c__x guestEntPref){
	  		recordtype = guestEntPref.recordtype__c;
		  	ExternalId = guestEntPref.ExternalId;
		  	
		  	preferenceId = guestEntPref.preference_id__c;
		  	response = guestEntPref.response__c;
		  	rankValue = guestEntPref.rank_value__c;
		  	freeformValue = guestEntPref.freeform_value__c;
		  	createUpdate = guestEntPref.create_update__c;
		  	itQryCategory = guestEntPref.it_qry_category__c;
		  	
		  	modifierLogin = guestEntPref.modifier_login__c;
		  	modifierWorkstation = guestEntPref.modifier_workstation__c;
		  	modifierLocation = guestEntPref.modifier_location__c;
		  	
		  	dataSourceCd = guestEntPref.data_source_cd__c;
		  	fileId = guestEntPref.file_id__c;
		  	
		  	insRunId = guestEntPref.ins_run_id__c;
			updRunId = guestEntPref.upd_run_id__c;
	  	}
	}	 
	
	/*******************************************************************************************************
    * @description Wrapper class for EnterprisePrefRespWrapper
    */
	global class EnterprisePrefRespWrapper extends PrefWrapperBase {
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String externalId { get; set; } 
		
		//@AuraEnabled global String i_dmid { get; set; }
		//@AuraEnabled global Decimal id { get; set; }

		@AuraEnabled global String preferenceId { get; set; }
		@AuraEnabled global String response { get; set; }
		
		@AuraEnabled global String derivedFlag { get; set; }
		@AuraEnabled global String dataSourceCd { get; set; }
		@AuraEnabled global String qualityCd { get; set; }
		//@AuraEnabled global Decimal timestamp { get; set; }
		@AuraEnabled global String createUpdate { get; set; }
		
		@AuraEnabled global String modifierLogin { get; set; }
		@AuraEnabled global String modifierWorkstation { get; set; }
		@AuraEnabled global String modifierLocation { get; set; }
		
		@AuraEnabled global Decimal fileId { get; set; }
		@AuraEnabled global String insRunId { get; set; }
		@AuraEnabled global Decimal updRunId { get; set; }

	  	global EnterprisePrefRespWrapper(){
	  	}
	  	global EnterprisePrefRespWrapper(customer_info_external_c__x guestEntPrefResp){
			copyfromCustomerInfo(guestEntPrefResp);
	  	}
	  	//CustomerInfo to EnterprisePrefWrapper Mapping
	  	global void copyfromCustomerInfo(customer_info_external_c__x guestEntPrefResp){
	  		recordtype = guestEntPrefResp.recordtype__c;
		  	externalId = guestEntPrefResp.ExternalId;
		  
		  	preferenceId = guestEntPrefResp.preference_id__c;
		  	response = guestEntPrefResp.response__c;
		  	
		  	derivedFlag = guestEntPrefResp.derived_flag__c;
		  	dataSourceCd = guestEntPrefResp.data_source_cd__c;
		  	qualityCd = guestEntPrefResp.quality_cd__c;
		  	//timestamp = guestEntPrefResp.d_timestamp;
		  	createUpdate = guestEntPrefResp.create_update__c; 
		  			  	
		  	modifierLogin = guestEntPrefResp.modifier_login__c;
		  	modifierWorkstation = guestEntPrefResp.modifier_workstation__c;
		  	modifierLocation = guestEntPrefResp.modifier_location__c;
		  	
		  	fileId = guestEntPrefResp.file_id__c;
		  	
		  	insRunId = guestEntPrefResp.ins_run_id__c;
			updRunId = guestEntPrefResp.upd_run_id__c;
	  	}
	}	
	
	
	


}