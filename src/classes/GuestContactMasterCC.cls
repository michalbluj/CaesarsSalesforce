/**
* @author Sarah Kennedy
* @date July 2017
*
* @description Class to retrieve Guest Contact, Master and TR Account Data, extending base class GuestSubjectcDataBase.cls
*/
global with sharing class  GuestContactMasterCC extends GuestSubjectDataBaseCC {

	global GuestContactMasterCC() { }

	@TestVisible private static List<Customer_Info_External_c__x> mockedAddress = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedEmail = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedPrefMarketMail = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedPrefPropMail = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedNxtgenAddress = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedNxtgenEmail = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedNxtgenContactChan = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedNxtgenPhone = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedNxtgenToDo = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedTierScore = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedCasino = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedRepcode = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedAcquisition = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedAlias = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedScoreProp = new List<Customer_Info_External_c__x>();
	@TestVisible private static List<Customer_Info_External_c__x> mockedEthnicityAppend= new List<Customer_Info_External_c__x>();
	@TestVisible private static List<caesars_gst_id_xref__x> mockedIdXref = new List<caesars_gst_id_xref__x>();
	@TestVisible private static List<gst_cons_xref__x> mockedConsXref = new List<gst_cons_xref__x>();


	/*******************************************************************************************************
    * @description Retrieve the Address from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the Address data
    * @return List<AddressWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.AddressWrapper>  addressList = 
	*   		GuestContactMasterCC.retrieveAddress(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<AddressWrapper> retrieveAddressDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveAddress(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<AddressWrapper> retrieveAddressByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveAddress(contactIds, whereClause, idType);
	}

	private static List<AddressWrapper> retrieveAddress(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);			

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('Address');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' adi__c, ';
	   	soql1 += ' city__c, ';
	   	soql1 += ' state_cd__c, ';
	   	soql1 += ' country_cd__c, ';
	   	soql1 += ' quality_cd__c, ';
	   	soql1 += ' dpbc__c, ';
	   	soql1 += ' date__c, ';
	   	soql1 += ' zip_3__c, ';
	   	soql1 += ' zip_7__c, ';
		soql1 += ' zip_plus_4__c, ';
		soql1 += ' county__c, ';
		soql1 += ' msa_cd__c, ';
		soql1 += ' pci_cd__c, ';
		soql1 += ' apt_num__c, ';
		soql1 += ' area_cd__c, ';
		soql1 += ' mail_cd__c, ';
		soql1 += ' am_pm_cd__c, ';
		soql1 += ' tele_num__c, ';
		soql1 += ' address_1__c, ';
		soql1 += ' address_2__c, ';
		soql1 += ' contact__c, ';
		soql1 += ' addr_type__c, ';
		soql1 += ' acquisition_cd__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' country_tele_cd__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, AddressWrapper> addressMap = new Map<String, AddressWrapper> ();

		List<customer_info_external_c__x> addressList = (!mockedAddress.isEmpty()) ? mockedAddress : Database.query(soql1);
	   	
	  	system.debug('*** addressList ' + addressList );

	  	updateAddress (addressMap, addressList, '1');
	  	
	  	system.debug('*** addressMap return ' + addressMap.values());

	  	return addressMap.values();
	}

	/*******************************************************************************************************
    * @description Update the AddressWrapper with soql results
    * @param Map<String, AddressWrapper> addressMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<AddressWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.AddressWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateAddress(Map<String, AddressWrapper> addressMap, List<customer_info_external_c__x> addressList, String pass);
    */
	private static void updateAddress (Map<String, AddressWrapper> addressMap, List<customer_info_external_c__x> addressList, String pass){

		Map<String, Acquisition_Code__c> acquisitionCodeMap = new Map<String, Acquisition_Code__c>([SELECT Id , Name, Description__c FROM Acquisition_Code__c]);

		AddressWrapper addrWrap;

		for (customer_info_external_c__x address : addressList ){
	  		if (!addressMap.containsKey(address.ExternalId)) {
	  			addressMap.put(address.ExternalId, new AddressWrapper());
	  		}
	  		addrWrap = addressMap.get(address.ExternalId);
	  		if (pass == '1'){
		  		addrWrap.ExternalId = address.ExternalId;

		  		addrWrap.adi = address.adi__c;
			   	addrWrap.city = address.city__c;
			   	addrWrap.state_cd = address.state_cd__c;
			   	addrWrap.country_cd = address.country_cd__c;
			   	addrWrap.quality_cd = address.quality_cd__c;
			   	addrWrap.dpbc = address.dpbc__c;
			   	addrWrap.datec = address.date__c;
			   	addrWrap.zip_3 = address.zip_3__c;
			   	addrWrap.zip_7 = address.zip_7__c;
				addrWrap.zip_plus_4 = address.zip_plus_4__c;
				addrWrap.county = address.county__c;
				addrWrap.msa_cd =  address.msa_cd__c;
				addrWrap.pci_cd = address.pci_cd__c;
				addrWrap.apt_num = address.apt_num__c;
				addrWrap.area_cd = address.area_cd__c;
				addrWrap.mail_cd = address.mail_cd__c;
				addrWrap.am_pm_cd = address.am_pm_cd__c;
				addrWrap.tele_num = address.tele_num__c;
				addrWrap.address_1 = address.address_1__c;
				addrWrap.address_2 = address.address_2__c;
				addrWrap.contact = address.contact__c;
				addrWrap.addr_type = address.addr_type__c;
				addrWrap.acquisition_cd = address.acquisition_cd__c;
				if (!String.IsBlank(address.acquisition_cd__c) &&
					 acquisitionCodeMap.containsKey(address.acquisition_cd__c) &&
					 !String.IsBlank(acquisitionCodeMap.get(address.acquisition_cd__c).Name) ){
					addrWrap.acquisition_cd_name = acquisitionCodeMap.get(address.acquisition_cd__c).Name;
				}
				addrWrap.recordtype = address.recordtype__c;
				addrWrap.country_tele_cd = address.country_tele_cd__c;		  		
		  	}
		  	
	  		addressMap.put(addrWrap.ExternalId, addrWrap);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the Email data from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the Email data
    * @return List<EmailWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.EmailWrapper>  emailList = 
	*   		GuestContactMasterCC.retrieveEmail(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<EmailWrapper> retrieveEmailDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveEmail(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<EmailWrapper> retrieveEmailByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveEmail(contactIds, whereClause, idType);
	}

	private static List<EmailWrapper> retrieveEmail(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('Email');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' email__c, ';
	   	soql1 += ' source__c, ';
	   	soql1 += ' qual_cd__c, ';
	   	soql1 += ' ofr_freq__c, ';
	   	soql1 += ' qual_cat__c, ';
	   	soql1 += ' email_flag__c, ';
	   	soql1 += ' quality_cd__c, ';
	   	soql1 += ' contact_count__c, ';
		soql1 += ' last_bounce_cd__c, ';
		soql1 += ' qual_reason_cd__c, ';
		soql1 += ' qual_hygiene_cd__c, ';
		soql1 += ' bounce_timestamp__c, ';
		soql1 += ' qual_chg_timestamp__c, ';
		soql1 += ' email_engagement_cd__c, ';
		soql1 += ' email_chg_timestamp__c, ';
		soql1 += ' qual_conf_timestamp__c, ';
		soql1 += ' email_address_valid_cd__c, ';
		soql1 += ' email_address_quality_cd__c, ';
		soql1 += ' last_change_timestamp_utc__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, EmailWrapper> emailMap = new Map<String, EmailWrapper> ();

		List<customer_info_external_c__x> emailList = (!mockedEmail.isEmpty()) ? mockedEmail : Database.query(soql1);
	   	
	  	system.debug('*** emailList ' + emailList );

	  	updateEmail (emailMap, emailList, '1');
	  	
	  	system.debug('*** emailMap return ' + emailMap.values());

	  	return emailMap.values();
	}

	/*******************************************************************************************************
    * @description Update the EmailWrapper with soql results
    * @param Map<String, EmailWrapper> emailMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<EmailWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.EmailWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateEmail(Map<String, EmailWrapper> emailMap, List<customer_info_external_c__x> emailList, String pass);
    */
	private static void updateEmail (Map<String, EmailWrapper> emailMap, List<customer_info_external_c__x> emailList, String pass){
		EmailWrapper emailWrap;

		for (customer_info_external_c__x email : emailList ){
	  		if (!emailMap.containsKey(email.ExternalId)) {
	  			emailMap.put(email.ExternalId, new EmailWrapper());
	  		}
	  		emailWrap = emailMap.get(email.ExternalId);
	  		if (pass == '1'){
		  		emailWrap.ExternalId = email.ExternalId;

		  		emailWrap.email = email.email__c;
			   	emailWrap.source = email.source__c;
			   	emailWrap.qual_cd = email.qual_cd__c;
			   	emailWrap.ofr_freq = email.ofr_freq__c;
			   	emailWrap.qual_cat = email.qual_cat__c;
			   	emailWrap.email_flag = email.email_flag__c;
			   	emailWrap.quality_cd = email.quality_cd__c;
			   	emailWrap.i_contact_count = email.contact_count__c;
				emailWrap.last_bounce_cd = email.last_bounce_cd__c;
				emailWrap.qual_reason_cd = email.qual_reason_cd__c;
				emailWrap.qual_hygiene_cd =  email.qual_hygiene_cd__c;
				emailWrap.bounce_timestamp = email.bounce_timestamp__c;
				emailWrap.qual_chg_timestamp = email.qual_chg_timestamp__c;
				emailWrap.email_engagement_cd = email.email_engagement_cd__c;
				emailWrap.email_chg_timestamp = email.email_chg_timestamp__c;
				emailWrap.qual_conf_timestamp = email.qual_conf_timestamp__c;
				emailWrap.email_address_valid_cd = email.email_address_valid_cd__c;
				emailWrap.email_address_quality_cd = email.email_address_quality_cd__c;
				emailWrap.last_change_timestamp_utc = email.last_change_timestamp_utc__c;
				emailWrap.contact = email.contact__c;
				emailWrap.recordtype = email.recordtype__c;

		  	}
		  	
	  		emailMap.put(emailWrap.ExternalId, emailWrap);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the PrefMarketMail data from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the PrefMarketMail data
    * @return List<PrefMarketMailWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.PrefMarketMailWrapper>  PrefMarketMailList = 
	*   		GuestContactMasterCC.retrievePrefMarketMail(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<PrefMarketMailWrapper> retrievePrefMarketMailDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrievePrefMarketMail(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<PrefMarketMailWrapper> retrievePrefMarketMailByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrievePrefMarketMail(contactIds, whereClause, idType);
	}

	private static List<PrefMarketMailWrapper> retrievePrefMarketMail(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('PrefMarketMail');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' quality_cd__c, ';
	   	//soql1 += ' market_cd__c, ';
	   	//soql1 += ' market_type__c, ';
	   	//soql1 += ' gst_pref_mail_flag__c, ';
	   	soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, PrefMarketMailWrapper> prefMarketMailMap = new Map<String, PrefMarketMailWrapper> ();

		List<customer_info_external_c__x> prefMarketMailList = (!mockedPrefMarketMail.isEmpty()) ? mockedPrefMarketMail : Database.query(soql1);
	   	
	  	system.debug('*** prefMarketMailList ' + prefMarketMailList );

	  	updatePrefMarketMail (prefMarketMailMap, prefMarketMailList, '1');
	  	
	  	system.debug('*** prefMarketMailMap return ' + prefMarketMailMap.values());

	  	return prefMarketMailMap.values();
	}

	/*******************************************************************************************************
    * @description Update the PrefMarketMailWrapper with soql results
    * @param Map<String, PrefMarketMailWrapper> prefMarketMailMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<PrefMarketMailWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.PrefMarketMailWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updatePrefMarketMail(Map<String, PrefMarketMailWrapper> prefMarketMailMap, List<customer_info_external_c__x> prefMarketMailList, String pass);
    */
	private static void updatePrefMarketMail (Map<String, PrefMarketMailWrapper> prefMarketMailMap, List<customer_info_external_c__x> prefMarketMailList, String pass){
		PrefMarketMailWrapper prefMarketMailWrap;

		for (customer_info_external_c__x prefMarketMail : prefMarketMailList ){
	  		if (!prefMarketMailMap.containsKey(prefMarketMail.ExternalId)) {
	  			prefMarketMailMap.put(prefMarketMail.ExternalId, new PrefMarketMailWrapper());
	  		}
	  		prefMarketMailWrap = prefMarketMailMap.get(prefMarketMail.ExternalId);
	  		if (pass == '1'){
		  		prefMarketMailWrap.ExternalId = prefMarketMail.ExternalId;

		  		prefMarketMailWrap.quality_cd = prefMarketMail.quality_cd__c;
		  		//prefMarketMailWrap.market_cd = prefMarketMail.market_cd__c;
		  		//prefMarketMailWrap.market_type = prefMarketMail.Market_type__c;
		  		//prefMarketMailWrap.gst_pref_mail_flag = prefMarketMail.gst_pref_mail_flag__c;
				prefMarketMailWrap.contact = prefMarketMail.contact__c;
				prefMarketMailWrap.recordtype = prefMarketMail.recordtype__c;
		  	}
		  	
	  		prefMarketMailMap.put(prefMarketMailWrap.ExternalId, prefMarketMailWrap);
	  	}
	}

/*******************************************************************************************************
    * @description Retrieve the PrefPropMail data from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the PrefPropMail data
    * @return List<PrefPropMailWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.PrefPropMailWrapper>  PrefPropMailList = 
	*   		GuestContactMasterCC.retrievePrefPropMail(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<PrefPropMailWrapper> retrievePrefPropMailDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrievePrefPropMail(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<PrefPropMailWrapper> retrievePrefPropMailByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrievePrefPropMail(contactIds, whereClause, idType);
	}

	private static List<PrefPropMailWrapper> retrievePrefPropMail(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('PrefPropMail');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' quality_cd__c, ';
	   	soql1 += ' prop_cd__c, ';
	   	//soql1 += ' gst_pref_mail_flag__c, ';
	   	soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, PrefPropMailWrapper> prefPropMailMap = new Map<String, PrefPropMailWrapper> ();

		List<customer_info_external_c__x> prefPropMailList = (!mockedPrefPropMail.isEmpty()) ? mockedPrefPropMail : Database.query(soql1);
	   	
	  	system.debug('*** prefPropMailList ' + prefPropMailList );

	  	updatePrefPropMail (prefPropMailMap, prefPropMailList, '1');
	  	
	  	system.debug('*** prefPropMailMap return ' + prefPropMailMap.values());

	  	return prefPropMailMap.values();
	}

	/*******************************************************************************************************
    * @description Update the PrefPropMailWrapper with soql results
    * @param Map<String, PrefPropMailWrapper> prefPropMailMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<PrefPropMailWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.PrefPropMailWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updatePrefPropMail(Map<String, PrefPropMailWrapper> prefPropMailMap, List<customer_info_external_c__x> prefPropMailList, String pass);
    */
	private static void updatePrefPropMail (Map<String, PrefPropMailWrapper> prefPropMailMap, List<customer_info_external_c__x> prefPropMailList, String pass){
		PrefPropMailWrapper prefPropMailWrap;

		for (customer_info_external_c__x prefPropMail : prefPropMailList ){
	  		if (!prefPropMailMap.containsKey(prefPropMail.ExternalId)) {
	  			prefPropMailMap.put(prefPropMail.ExternalId, new PrefPropMailWrapper());
	  		}
	  		prefPropMailWrap = prefPropMailMap.get(prefPropMail.ExternalId);
	  		if (pass == '1'){
		  		prefPropMailWrap.ExternalId = prefPropMail.ExternalId;

		  		prefPropMailWrap.quality_cd = prefPropMail.quality_cd__c;
		  		prefPropMailWrap.prop_cd = prefPropMail.prop_cd__c;
		  		//prefPropMailWrap.gst_pref_mail_flag = prefPropMail.gst_pref_mail_flag__c;
				prefPropMailWrap.contact = prefPropMail.contact__c;
				prefPropMailWrap.recordtype = prefPropMail.recordtype__c;
		  	}
		  	
	  		prefPropMailMap.put(prefPropMailWrap.ExternalId, prefPropMailWrap);
	  	}
	}


	/*******************************************************************************************************
    * @description Retrieve the NxtGenAddress from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the NxtGenAddress data
    * @return List<NxtGenAddressWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.NxtGenAddressWrapper>  NxtGenAddressList = 
	*   		GuestContactMasterCC.retrieveNxtGenAddress(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<NxtGenAddressWrapper> retrieveNxtGenAddressDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveNxtGenAddress(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<NxtGenAddressWrapper> retrieveNxtGenAddressByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveNxtGenAddress(contactIds, whereClause, idType);
	}

	private static List<NxtGenAddressWrapper> retrieveNxtGenAddress(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('NxtgenAddress');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' email__c, ';
	   	soql1 += ' notes__c, ';
	   	soql1 += ' phone__c, ';
	   	soql1 += ' addr_1__c, ';
	   	soql1 += ' addr_2__c, ';
	   	soql1 += ' addr_3__c, ';
	   	soql1 += ' app_cd__c, ';
	   	soql1 += ' rep_id__c, ';
	   	soql1 += ' zip_cd__c, ';
	   	soql1 += ' book_id__c, ';
	   	soql1 += ' prop_cd__c, ';
	   	soql1 += ' state_cd__c, ';
	   	soql1 += ' addr_desc__c, ';
		soql1 += ' city_name__c, ';
		soql1 += ' create_dt__c, ';
		soql1 += ' country_cd__c, ';
		soql1 += ' state_name__c, ';
		soql1 += ' note_pad_id__c, ';
		soql1 += ' creator_login__c, ';
		soql1 += ' addr_status_cd__c, ';
		soql1 += ' modifier_login__c, ';
		soql1 += ' pcs_address_id__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, NxtGenAddressWrapper> nxtGenAddressMap = new Map<String, NxtGenAddressWrapper> ();

		List<customer_info_external_c__x> nxtGenAddressList = (!mockedNxtGenAddress.isEmpty()) ? mockedNxtGenAddress : Database.query(soql1);
	   	
	  	system.debug('*** nxtGenAddressList ' + nxtGenAddressList );

	  	updateNxtGenAddress (nxtGenAddressMap, nxtGenAddressList, '1');
	  	
	  	system.debug('*** NxtGenAddressMap return ' + NxtGenAddressMap.values());

	  	return nxtGenAddressMap.values();
	}

	/*******************************************************************************************************
    * @description Update the NxtGenAddressWrapper with soql results
    * @param Map<String, NxtGenAddressWrapper> nxtGenAddressMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<NxtGenAddressWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.NxtGenAddressWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateNxtGenAddress(Map<String, NxtGenAddressWrapper> NxtGenAddressMap, List<customer_info_external_c__x> nxtGenAddressList, String pass);
    */
	private static void updateNxtGenAddress (Map<String, NxtGenAddressWrapper> nxtGenAddressMap, List<customer_info_external_c__x> nxtGenAddressList, String pass){
		NxtGenAddressWrapper addrWrap;

		for (customer_info_external_c__x nxtGenAddress : nxtGenAddressList ){
	  		if (!NxtGenAddressMap.containsKey(nxtGenAddress.ExternalId)) {
	  			NxtGenAddressMap.put(nxtGenAddress.ExternalId, new NxtGenAddressWrapper());
	  		}
	  		addrWrap = NxtGenAddressMap.get(nxtGenAddress.ExternalId);
	  		if (pass == '1'){
		  		addrWrap.ExternalId = nxtGenAddress.ExternalId;

		  		addrWrap.notes = nxtGenAddress.notes__c;
			   	addrWrap.phone = nxtGenAddress.phone__c;
			   	addrWrap.addr_1 = nxtGenAddress.addr_1__c;
			   	addrWrap.addr_2 = nxtGenAddress.addr_2__c;
			   	addrWrap.addr_3 = nxtGenAddress.addr_3__c;
			   	addrWrap.app_cd = nxtGenAddress.app_cd__c;
			   	addrWrap.rep_id = nxtGenAddress.rep_id__c;
			   	addrWrap.zip_cd = nxtGenAddress.zip_cd__c;
			   	addrWrap.book_id = nxtGenAddress.book_id__c;
				addrWrap.prop_cd = nxtGenAddress.prop_cd__c;
				addrWrap.stats_cd = nxtGenAddress.state_cd__c;
				addrWrap.addr_desc =  nxtGenAddress.addr_desc__c;
				addrWrap.city_name = nxtGenAddress.city_name__c;
				addrWrap.create_dt = nxtGenAddress.create_dt__c;
				addrWrap.country_cd = nxtGenAddress.country_cd__c;
				addrWrap.state_name = nxtGenAddress.state_name__c;
				addrWrap.note_pad_id = nxtGenAddress.note_pad_id__c;
				addrWrap.creator_login = nxtGenAddress.creator_login__c;
				addrWrap.addr_status_cd = nxtGenAddress.addr_status_cd__c;
				addrWrap.modifier_login = nxtGenAddress.modifier_login__c;
				addrWrap.pcs_address_id = nxtGenAddress.pcs_address_id__c;
				addrWrap.recordtype = nxtGenAddress.recordtype__c;
				addrWrap.contact = nxtGenAddress.contact__c;

		  	}
		  	
	  		nxtGenAddressMap.put(addrWrap.ExternalId, addrWrap);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the NxtGenEmail from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the NxtGenEmail data
    * @return List<NxtGenEmailWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.NxtGenEmailWrapper>  NxtGenEmailList = 
	*   		GuestContactMasterCC.retrieveNxtGenEmail(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<NxtGenEmailWrapper> retrieveNxtGenEmailDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveNxtGenEmail(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<NxtGenEmailWrapper> retrieveNxtGenEmailByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveNxtGenEmail(contactIds, whereClause, idType);
	}

	private static List<NxtGenEmailWrapper> retrieveNxtGenEmail(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('NxtgenEmail');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' email__c, ';
	   	soql1 += ' app_cd__c, ';
		soql1 += ' create_dt__c, ';
		soql1 += ' created_by__c, ';
		soql1 += ' email_type__c, ';
		soql1 += ' email_status__c, ';
		soql1 += ' email_id__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, NxtGenEmailWrapper> nxtGenEmailMap = new Map<String, NxtGenEmailWrapper> ();

		List<customer_info_external_c__x> nxtGenEmailList = (!mockedNxtGenEmail.isEmpty()) ? mockedNxtGenEmail : Database.query(soql1);
	   	
	  	system.debug('*** nxtGenEmailList ' + nxtGenEmailList );

	  	updateNxtGenEmail (nxtGenEmailMap, nxtGenEmailList, '1');
	  	
	  	system.debug('*** NxtGenEmailMap return ' + NxtGenEmailMap.values());

	  	return nxtGenEmailMap.values();
	}

	/*******************************************************************************************************
    * @description Update the NxtGenEmailWrapper with soql results
    * @param Map<String, NxtGenEmailWrapper> nxtGenEmailMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<NxtGenEmailWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.NxtGenEmailWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateNxtGenEmail(Map<String, NxtGenEmailWrapper> NxtGenEmailMap, List<customer_info_external_c__x> nxtGenEmailList, String pass);
    */
	private static void updateNxtGenEmail (Map<String, NxtGenEmailWrapper> nxtGenEmailMap, List<customer_info_external_c__x> nxtGenEmailList, String pass){
		NxtGenEmailWrapper addrWrap;

		for (customer_info_external_c__x nxtGenEmail : nxtGenEmailList ){
	  		if (!NxtGenEmailMap.containsKey(nxtGenEmail.ExternalId)) {
	  			NxtGenEmailMap.put(nxtGenEmail.ExternalId, new NxtGenEmailWrapper());
	  		}
	  		addrWrap = NxtGenEmailMap.get(nxtGenEmail.ExternalId);
	  		if (pass == '1'){
		  		addrWrap.ExternalId = nxtGenEmail.ExternalId;

		  		addrWrap.email = nxtGenEmail.email__c;
			   	addrWrap.app_cd = nxtGenEmail.app_cd__c;
			   	addrWrap.create_dt = nxtGenEmail.create_dt__c;
			   	addrWrap.created_by = nxtGenEmail.created_by__c;
			   	addrWrap.email_type = nxtGenEmail.email_type__c;
			   	addrWrap.email_status = nxtGenEmail.email_status__c;
			   	addrWrap.email_id = nxtGenEmail.email_id__c;	
			   	addrWrap.recordtype = nxtGenEmail.recordtype__c;		   
				addrWrap.contact = nxtGenEmail.contact__c;

		  	}
		  	
	  		nxtGenEmailMap.put(addrWrap.ExternalId, addrWrap);
	  	}
	}

/*******************************************************************************************************
    * @description Retrieve the NxtGenContactChan from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the NxtGenContactChan data
    * @return List<NxtGenContactChanWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.NxtGenContactChanWrapper>  NxtGenContactChanList = 
	*   		GuestContactMasterCC.retrieveNxtGenContactChan(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<NxtGenContactChanWrapper> retrieveNxtGenContactChanDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveNxtGenContactChan(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<NxtGenContactChanWrapper> retrieveNxtGenContactChanByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveNxtGenContactChan(contactIds, whereClause, idType);
	}

	private static List<NxtGenContactChanWrapper> retrieveNxtGenContactChan(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('NxtgenContactChan');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' app_cd__c, ';
		soql1 += ' create_dt__c, ';
		soql1 += ' creator_login__c, ';
		soql1 += ' modifier_login__c, ';
		soql1 += ' do_not_contact_channel__c, ';
		soql1 += ' preferred_contact_channel__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, NxtGenContactChanWrapper> nxtGenContactChanMap = new Map<String, NxtGenContactChanWrapper> ();

		List<customer_info_external_c__x> nxtGenContactChanList = (!mockedNxtGenContactChan.isEmpty()) ? mockedNxtGenContactChan : Database.query(soql1);
	   	
	  	system.debug('*** nxtGenContactChanList ' + nxtGenContactChanList );

	  	updateNxtGenContactChan (nxtGenContactChanMap, nxtGenContactChanList, '1');
	  	
	  	system.debug('*** NxtGenContactChanMap return ' + NxtGenContactChanMap.values());

	  	return nxtGenContactChanMap.values();
	}

	/*******************************************************************************************************
    * @description Update the NxtGenContactChanWrapper with soql results
    * @param Map<String, NxtGenContactChanWrapper> nxtGenContactChanMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<NxtGenContactChanWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.NxtGenContactChanWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateNxtGenContactChan(Map<String, NxtGenContactChanWrapper> NxtGenContactChanMap, List<customer_info_external_c__x> nxtGenContactChanList, String pass);
    */
	private static void updateNxtGenContactChan (Map<String, NxtGenContactChanWrapper> nxtGenContactChanMap, List<customer_info_external_c__x> nxtGenContactChanList, String pass){
		NxtGenContactChanWrapper addrWrap;

		for (customer_info_external_c__x nxtGenContactChan : nxtGenContactChanList ){
	  		if (!NxtGenContactChanMap.containsKey(nxtGenContactChan.ExternalId)) {
	  			NxtGenContactChanMap.put(nxtGenContactChan.ExternalId, new NxtGenContactChanWrapper());
	  		}
	  		addrWrap = NxtGenContactChanMap.get(nxtGenContactChan.ExternalId);
	  		if (pass == '1'){
		  		addrWrap.ExternalId = nxtGenContactChan.ExternalId;

		  		addrWrap.app_cd = nxtGenContactChan.app_cd__c;
			   	addrWrap.create_dt = nxtGenContactChan.create_dt__c;
			   	addrWrap.creator_login = nxtGenContactChan.creator_login__c;
			   	addrWrap.modifier_login = nxtGenContactChan.modifier_login__c;
			   	addrWrap.do_not_contact_channel = nxtGenContactChan.do_not_contact_channel__c;
			   	addrWrap.preferred_contact_channel = nxtGenContactChan.preferred_contact_channel__c;
			   	addrWrap.recordtype = nxtGenContactChan.recordtype__c;			   
				addrWrap.contact = nxtGenContactChan.contact__c;

		  	}
		  	
	  		nxtGenContactChanMap.put(addrWrap.ExternalId, addrWrap);
	  	}
	}


/*******************************************************************************************************
    * @description Retrieve the NxtGenPhone from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the NxtGenPhone data
    * @return List<NxtGenPhoneWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.NxtGenPhoneWrapper>  NxtGenPhoneList = 
	*   		GuestContactMasterCC.retrieveNxtGenPhone(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<NxtGenPhoneWrapper> retrieveNxtGenPhoneDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveNxtGenPhone(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<NxtGenPhoneWrapper> retrieveNxtGenPhoneByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveNxtGenPhone(contactIds, whereClause, idType);
	}

	private static List<NxtGenPhoneWrapper> retrieveNxtGenPhone(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('NxtgenPhone');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' phone__c, ';
		soql1 += ' app_cd__c, ';
		soql1 += ' private__c, ';
		soql1 += ' create_dt__c, ';
		soql1 += ' created_by__c, ';
		soql1 += ' phone_type__c, ';
		soql1 += ' pcs_phone_id__c, ';
		soql1 += ' phone_status__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, NxtGenPhoneWrapper> nxtGenPhoneMap = new Map<String, NxtGenPhoneWrapper> ();

		List<customer_info_external_c__x> nxtGenPhoneList = (!mockedNxtGenPhone.isEmpty()) ? mockedNxtGenPhone : Database.query(soql1);
	   	
	  	system.debug('*** nxtGenPhoneList ' + nxtGenPhoneList );

	  	updateNxtGenPhone (nxtGenPhoneMap, nxtGenPhoneList, '1');
	  	
	  	system.debug('*** NxtGenPhoneMap return ' + NxtGenPhoneMap.values());

	  	return nxtGenPhoneMap.values();
	}

	/*******************************************************************************************************
    * @description Update the NxtGenPhoneWrapper with soql results
    * @param Map<String, NxtGenPhoneWrapper> nxtGenPhoneMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<NxtGenPhoneWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.NxtGenPhoneWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateNxtGenPhone(Map<String, NxtGenPhoneWrapper> NxtGenPhoneMap, List<customer_info_external_c__x> nxtGenPhoneList, String pass);
    */
	private static void updateNxtGenPhone (Map<String, NxtGenPhoneWrapper> nxtGenPhoneMap, List<customer_info_external_c__x> nxtGenPhoneList, String pass){
		NxtGenPhoneWrapper addrWrap;

		for (customer_info_external_c__x nxtGenPhone : nxtGenPhoneList ){
	  		if (!NxtGenPhoneMap.containsKey(nxtGenPhone.ExternalId)) {
	  			NxtGenPhoneMap.put(nxtGenPhone.ExternalId, new NxtGenPhoneWrapper());
	  		}
	  		addrWrap = NxtGenPhoneMap.get(nxtGenPhone.ExternalId);
	  		if (pass == '1'){
		  		addrWrap.ExternalId = nxtGenPhone.ExternalId;

		  		addrWrap.phone = nxtGenPhone.phone__c;
			   	addrWrap.app_cd = nxtGenPhone.app_cd__c;
			   	addrWrap.privatec = nxtGenPhone.private__c;
			   	addrWrap.created_dt = nxtGenPhone.create_dt__c;
			   	addrWrap.created_by = nxtGenPhone.created_by__c;
			   	addrWrap.phone_type = nxtGenPhone.phone_type__c;
			   	addrWrap.psc_phone_id = nxtGenPhone.pcs_phone_id__c;
			   	addrWrap.phone_status = nxtGenPhone.phone_status__c;
			   	addrWrap.recordtype = nxtGenPhone.recordtype__c;			   
				addrWrap.contact = nxtGenPhone.contact__c;

		  	}
		  	
	  		nxtGenPhoneMap.put(addrWrap.ExternalId, addrWrap);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the NxtGenToDo from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the NxtGenToDo data
    * @return List<NxtGenToDoWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.NxtGenToDoWrapper>  NxtGenToDoList = 
	*   		GuestContactMasterCC.retrieveNxtGenToDo(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<NxtGenToDoWrapper> retrieveNxtGenToDoDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveNxtGenToDo(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<NxtGenToDoWrapper> retrieveNxtGenToDoByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveNxtGenToDo(contactIds, whereClause, idType);
	}

	private static List<NxtGenToDoWrapper> retrieveNxtGenToDo(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('NxtgenToDo');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' worth__c, ';
		soql1 += ' app_cd__c, ';
		soql1 += ' rep_id__c, ';
		soql1 += ' due_dt__c, ';
		soql1 += ' book_id__c, ';
		soql1 += ' prop_cd__c, ';
		soql1 += ' task_id__c, ';
		soql1 += ' due_time__c, ';
		soql1 += ' event_id__c, ';
		soql1 += ' to_do_id__c, ';
		soql1 += ' last_name__c, ';
		soql1 += ' create_dt__c, ';
		soql1 += ' first_name__c, ';
		soql1 += ' to_do_type__c, ';
		soql1 += ' market_adw__c, ';
		soql1 += ' middle_init__c, ';
		soql1 += ' to_do_notes__c, ';
		soql1 += ' to_do_status__c, ';
		soql1 += ' last_trip_dt__c, ';
		soql1 += ' creator_login__c, ';
		soql1 += ' to_do_segment__c, ';
		soql1 += ' to_do_subject__c, ';
		soql1 += ' modifier_login__c, ';
		soql1 += ' offer_reserved__c, ';
		soql1 += ' suggested_channel__c, ';
		soql1 += ' contact_dt_by_all__c, ';
		soql1 += ' my_last_contact_dt__c, ';
		soql1 += ' last_contact_dt_by_me__c, ';
		soql1 += ' phone_contact_dt_by_all__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, NxtGenToDoWrapper> nxtGenToDoMap = new Map<String, NxtGenToDoWrapper> ();

		List<customer_info_external_c__x> nxtGenToDoList = (!mockedNxtGenToDo.isEmpty()) ? mockedNxtGenToDo : Database.query(soql1);
	   	
	  	system.debug('*** nxtGenToDoList ' + nxtGenToDoList );

	  	updateNxtGenToDo (nxtGenToDoMap, nxtGenToDoList, '1');
	  	
	  	system.debug('*** NxtGenToDoMap return ' + NxtGenToDoMap.values());

	  	return nxtGenToDoMap.values();
	}

	/*******************************************************************************************************
    * @description Update the NxtGenToDoWrapper with soql results
    * @param Map<String, NxtGenToDoWrapper> nxtGenToDoMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<NxtGenToDoWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.NxtGenToDoWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateNxtGenToDo(Map<String, NxtGenToDoWrapper> NxtGenToDoMap, List<customer_info_external_c__x> nxtGenToDoList, String pass);
    */
	private static void updateNxtGenToDo (Map<String, NxtGenToDoWrapper> nxtGenToDoMap, List<customer_info_external_c__x> nxtGenToDoList, String pass){
		NxtGenToDoWrapper addrWrap;

		for (customer_info_external_c__x nxtGenToDo : nxtGenToDoList ){
	  		if (!NxtGenToDoMap.containsKey(nxtGenToDo.ExternalId)) {
	  			NxtGenToDoMap.put(nxtGenToDo.ExternalId, new NxtGenToDoWrapper());
	  		}
	  		addrWrap = NxtGenToDoMap.get(nxtGenToDo.ExternalId);
	  		if (pass == '1'){
		  		addrWrap.ExternalId = nxtGenToDo.ExternalId;

			   	addrWrap.worth = nxtGenToDo.worth__c;
				addrWrap.app_cd = nxtGenToDo.app_cd__c;
				addrWrap.rep_id = nxtGenToDo.rep_id__c;
				addrWrap.due_dt = nxtGenToDo.due_dt__c;
				addrWrap.book_id = nxtGenToDo.book_id__c;
				addrWrap.prop_cd = nxtGenToDo.prop_cd__c;
				addrWrap.task_id = nxtGenToDo.task_id__c;
				addrWrap.due_time = nxtGenToDo.due_time__c;
				addrWrap.event_id = nxtGenToDo.event_id__c;
				addrWrap.to_do_id = nxtGenToDo.to_do_id__c;
				addrWrap.last_name = nxtGenToDo.last_name__c;
				addrWrap.create_dt = nxtGenToDo.create_dt__c;
				addrWrap.first_name = nxtGenToDo.first_name__c;
				addrWrap.to_do_type = nxtGenToDo.to_do_type__c;
				addrWrap.market_adw = nxtGenToDo.market_adw__c;
				addrWrap.middle_init = nxtGenToDo.middle_init__c;
				addrWrap.to_do_notes = nxtGenToDo.to_do_notes__c;
				addrWrap.to_do_status = nxtGenToDo.to_do_status__c;
				addrWrap.last_trip_dt = nxtGenToDo.last_trip_dt__c;
				addrWrap.creator_login = nxtGenToDo.creator_login__c;
				addrWrap.to_do_segment = nxtGenToDo.to_do_segment__c;
				addrWrap.to_do_subject = nxtGenToDo.to_do_subject__c;
				addrWrap.modifier_login = nxtGenToDo.modifier_login__c;
				addrWrap.offer_reserved = nxtGenToDo.offer_reserved__c;
				addrWrap.suggested_channel = nxtGenToDo.suggested_channel__c;
				addrWrap.contact_dt_by_all = nxtGenToDo.contact_dt_by_all__c;
				addrWrap.my_last_contact_dt = nxtGenToDo.my_last_contact_dt__c;
				addrWrap.last_contact_dt_by_me = nxtGenToDo.last_contact_dt_by_me__c;
				addrWrap.phone_contact_dt_by_all = nxtGenToDo.phone_contact_dt_by_all__c;


			   	addrWrap.recordtype = nxtGenToDo.recordtype__c;			   
				addrWrap.contact = nxtGenToDo.contact__c;

		  	}
		  	
	  		nxtGenToDoMap.put(addrWrap.ExternalId, addrWrap);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the TierScore from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the TierScore data
    * @return List<TierScoreWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.TierScoreWrapper>  TierScoreList = 
	*   		GuestContactMasterCC.retrieveTierScore(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<TierScoreWrapper> retrieveTierScoreDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveTierScore(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<TierScoreWrapper> retrieveTierScoreByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveTierScore(contactIds, whereClause, idType);
	}

	private static List<TierScoreWrapper> retrieveTierScore(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('TierScore');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' year__c, ';
		soql1 += ' as_of__c, ';
		soql1 += ' posted_on__c, ';
		soql1 += ' quality_cd__c, ';
		soql1 += ' promo_base__c, ';
		soql1 += ' tier_score__c, ';
		soql1 += ' adjust_base__c, ';
		soql1 += ' earned_base__c, ';
		soql1 += ' prev_tier_score__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, TierScoreWrapper> tierScoreMap = new Map<String, TierScoreWrapper> ();

		List<customer_info_external_c__x> tierScoreList = (!mockedTierScore.isEmpty()) ? mockedTierScore : Database.query(soql1);
	   	
	  	system.debug('*** tierScoreList ' + tierScoreList );

	  	updateTierScore (tierScoreMap, tierScoreList, '1');
	  	
	  	system.debug('*** tierScoreMap return ' + tierScoreMap.values());

	  	return tierScoreMap.values();
	}

	/*******************************************************************************************************
    * @description Update the TierScoreWrapper with soql results
    * @param Map<String, TierScoreWrapper> tierScoreMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<TierScoreWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.TierScoreWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateTierScore(Map<String, TierScoreWrapper> tierScoreMap, List<customer_info_external_c__x> tierScoreList, String pass);
    */
	private static void updateTierScore (Map<String, TierScoreWrapper> tierScoreMap, List<customer_info_external_c__x> tierScoreList, String pass){
		TierScoreWrapper tsWrap;

		for (customer_info_external_c__x tierScore : tierScoreList ){
	  		if (!tierScoreMap.containsKey(tierScore.ExternalId)) {
	  			tierScoreMap.put(tierScore.ExternalId, new TierScoreWrapper());
	  		}
	  		tsWrap = tierScoreMap.get(tierScore.ExternalId);
	  		if (pass == '1'){
		  		tsWrap.ExternalId = tierScore.ExternalId;

			   	tsWrap.yearc = tierScore.year__c;
				tsWrap.as_of = tierScore.as_of__c;
				tsWrap.posted_on = tierScore.posted_on__c;
				tsWrap.quality_cd = tierScore.quality_cd__c;
				tsWrap.promo_base = tierScore.promo_base__c;
				tsWrap.tier_score = tierScore.tier_score__c;
				tsWrap.adjust_base = tierScore.adjust_base__c;
				tsWrap.earned_base = tierScore.earned_base__c;
				tsWrap.prev_tier_score = tierScore.prev_tier_score__c;

			   	tsWrap.recordtype = tierScore.recordtype__c;			   
				tsWrap.contact = tierScore.contact__c;

		  	}
		  	
	  		tierScoreMap.put(tsWrap.ExternalId, tsWrap);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the Casino from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the Casino data
    * @return List<CasinoWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.CasinoWrapper>  CasinoList = 
	*   		GuestContactMasterCC.retrieveCasino(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<CasinoWrapper> retrieveCasinoDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveCasino(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<CasinoWrapper> retrieveCasinoByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveCasino(contactIds, whereClause, idType);
	}

	private static List<CasinoWrapper> retrieveCasino(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('Casino');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' rep_id__c, ';
		soql1 += ' prop_cd__c, ';
		soql1 += ' update_dt__c, ';
		soql1 += ' casino_id__c, ';
		soql1 += ' quality_cd__c, ';
		soql1 += ' create_date__c, ';
		soql1 += ' purge_react__c, ';
		soql1 += ' cred_appr_by__c, ';
		soql1 += ' prop_mail_cd__c, ';
		soql1 += ' avail_credit__c, ';
		soql1 += ' credit_limit__c, ';
		soql1 += ' credit_status__c, ';
		soql1 += ' outstand_credit__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, CasinoWrapper> casinoMap = new Map<String, CasinoWrapper> ();

		List<customer_info_external_c__x> casinoList = (!mockedCasino.isEmpty()) ? mockedCasino : Database.query(soql1);
	   	
	  	system.debug('*** casinoList ' + casinoList );

	  	updateCasino (casinoMap, casinoList, '1');
	  	
	  	system.debug('*** casinoMap return ' + casinoMap.values());

	  	return casinoMap.values();
	}

	/*******************************************************************************************************
    * @description Update the CasinoWrapper with soql results
    * @param Map<String, CasinoWrapper> casinoMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<CasinoWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.CasinoWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateCasino(Map<String, CasinoWrapper> casinoMap, List<customer_info_external_c__x> casinoList, String pass);
    */
	private static void updateCasino (Map<String, CasinoWrapper> casinoMap, List<customer_info_external_c__x> casinoList, String pass){
		CasinoWrapper casWrap;

		for (customer_info_external_c__x casino : casinoList ){
	  		if (!casinoMap.containsKey(casino.ExternalId)) {
	  			casinoMap.put(casino.ExternalId, new CasinoWrapper());
	  		}
	  		casWrap = casinoMap.get(casino.ExternalId);
	  		if (pass == '1'){
		  		casWrap.ExternalId = casino.ExternalId;

			   	casWrap.rep_id = casino.rep_id__c;
				casWrap.prop_cd = casino.prop_cd__c;
				casWrap.update_dt = casino.update_dt__c;
				casWrap.casino_id = casino.casino_id__c;
				casWrap.quality_cd = casino.quality_cd__c;
				casWrap.create_date = casino.create_date__c;
				casWrap.purge_react = casino.purge_react__c;
				casWrap.cred_appr_by = casino.cred_appr_by__c;
				casWrap.prop_mail_cd = casino.prop_mail_cd__c;
				casWrap.avail_credit = casino.avail_credit__c;
				casWrap.credit_limit = casino.credit_limit__c;
				casWrap.credit_status = casino.credit_status__c;
				casWrap.outstand_credit = casino.outstand_credit__c;

			   	casWrap.recordtype = casino.recordtype__c;			   
				casWrap.contact = casino.contact__c;

		  	}
		  	
	  		casinoMap.put(casWrap.ExternalId, casWrap);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the Repcode from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the Repcode data
    * @return List<RepcodeWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.RepcodeWrapper>  RepcodeList = 
	*   		GuestContactMasterCC.retrieveRepcode(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<RepcodeWrapper> retrieveRepcodeDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveRepcode(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<RepcodeWrapper> retrieveRepcodeByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveRepcode(contactIds, whereClause, idType);
	}

	private static List<RepcodeWrapper> retrieveRepcode(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('Repcode');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' rep_cd__c, ';
		soql1 += ' prop_cd__c, ';
		soql1 += ' efft_dy__c, ';
		soql1 += ' efft_mn__c, ';
		soql1 += ' efft_yr__c, ';
		soql1 += ' rep_type__c, ';
		soql1 += ' rep_rank__c, ';
		soql1 += ' patron_id__c, ';
		soql1 += ' current_cd__c, ';
		soql1 += ' entered_by__c, ';
		soql1 += ' quality_cd__c, ';
		soql1 += ' trans_time__c, ';
		soql1 += ' efft_end_dt__c, ';
		soql1 += ' efft_start_dt__c, ';
		soql1 += ' trans_100_yr__c, ';
		soql1 += ' rep_trip_nbr__c, ';
		soql1 += ' patron_rep_appv__c, ';
		soql1 += ' last_rep_h_date__c, ';
		soql1 += ' assigned_century__c, ';
		soql1 += ' last_rep_cd_date__c, ';
		soql1 += ' trans_cal_dt__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, RepcodeWrapper> repcodeMap = new Map<String, RepcodeWrapper> ();

		List<customer_info_external_c__x> repcodeList = (!mockedRepcode.isEmpty()) ? mockedRepcode : Database.query(soql1);
	   	
	  	system.debug('*** repcodeList ' + repcodeList );

	  	updateRepcode (repcodeMap, repcodeList, '1');
	  	
	  	system.debug('*** repcodeMap return ' + repcodeMap.values());

	  	return repcodeMap.values();
	}

	/*******************************************************************************************************
    * @description Update the RepcodeWrapper with soql results
    * @param Map<String, RepcodeWrapper> repcodeMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<RepcodeWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.RepcodeWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateRepcode(Map<String, RepcodeWrapper> repcodeMap, List<customer_info_external_c__x> repcodeList, String pass);
    */
	private static void updateRepcode (Map<String, RepcodeWrapper> repcodeMap, List<customer_info_external_c__x> repcodeList, String pass){
		RepcodeWrapper repWrap;

		for (customer_info_external_c__x repcode : repcodeList ){
	  		if (!repcodeMap.containsKey(repcode.ExternalId)) {
	  			repcodeMap.put(repcode.ExternalId, new RepcodeWrapper());
	  		}
	  		repWrap = repcodeMap.get(repcode.ExternalId);
	  		if (pass == '1'){
		  		repWrap.ExternalId = repcode.ExternalId;

			   	repWrap.rep_cd = repcode.rep_cd__c;
				repWrap.prop_cd = repcode.prop_cd__c;
				repWrap.efft_dy = repcode.efft_dy__c;
				repWrap.efft_mn = repcode.efft_mn__c;
				repWrap.efft_yr = repcode.efft_yr__c;
				repWrap.rep_type = repcode.rep_type__c;
				repWrap.rep_rank = repcode.rep_rank__c;
				repWrap.patron_id = repcode.patron_id__c;
				repWrap.current_cd = repcode.current_cd__c;
				repWrap.entered_by = repcode.entered_by__c;
				repWrap.quality_cd = repcode.quality_cd__c;
				repWrap.trans_time = repcode.trans_time__c;
				repWrap.efft_end_dt = repcode.efft_end_dt__c;
				repWrap.efft_start_dt = repcode.efft_start_dt__c;
				repWrap.trans_100_yr = repcode.trans_100_yr__c;
				repWrap.rep_trip_nbr = repcode.rep_trip_nbr__c;
				repWrap.patron_rep_appv = repcode.patron_rep_appv__c;
				repWrap.last_rep_h_date = repcode.last_rep_h_date__c;
				repWrap.assigned_century = repcode.assigned_century__c;
				repWrap.last_rep_cd_date = repcode.last_rep_cd_date__c;
				repWrap.trans_cal_dt = repcode.trans_cal_dt__c;

			   	repWrap.recordtype = repcode.recordtype__c;			   
				repWrap.contact = repcode.contact__c;

		  	}
		  	
	  		repcodeMap.put(repWrap.ExternalId, repWrap);
	  	}
	}

/*******************************************************************************************************
    * @description Retrieve the Acquisition from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the Acquisition data
    * @return List<AcquisitionWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.AcquisitionWrapper>  AcquisitionList = 
	*   		GuestContactMasterCC.retrieveAcquisition(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<AcquisitionWrapper> retrieveAcquisitionDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveAcquisition(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<AcquisitionWrapper> retrieveAcquisitionByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveAcquisition(contactIds, whereClause, idType);
	}

	private static List<AcquisitionWrapper> retrieveAcquisition(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('Acquisition');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' acq_date__c, ';
		soql1 += ' prop_cd__c, ';
		soql1 += ' quality_cd__c, ';
		soql1 += ' acquisition_cd__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, AcquisitionWrapper> acquisitionMap = new Map<String, AcquisitionWrapper> ();

		List<customer_info_external_c__x> acquisitionList = (!mockedAcquisition.isEmpty()) ? mockedAcquisition : Database.query(soql1);
	   	
	  	system.debug('*** acquisitionList ' + acquisitionList );

	  	updateAcquisition (acquisitionMap, acquisitionList, '1');
	  	
	  	system.debug('*** acquisitionMap return ' + acquisitionMap.values());

	  	return acquisitionMap.values();
	}

	/*******************************************************************************************************
    * @description Update the AcquisitionWrapper with soql results
    * @param Map<String, AcquisitionWrapper> acquisitionMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<AcquisitionWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.AcquisitionWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateAcquisition(Map<String, AcquisitionWrapper> acquisitionMap, List<customer_info_external_c__x> acquisitionList, String pass);
    */
	private static void updateAcquisition (Map<String, AcquisitionWrapper> acquisitionMap, List<customer_info_external_c__x> acquisitionList, String pass){
		AcquisitionWrapper acqWrap;

		for (customer_info_external_c__x acq : acquisitionList ){
	  		if (!acquisitionMap.containsKey(acq.ExternalId)) {
	  			acquisitionMap.put(acq.ExternalId, new AcquisitionWrapper());
	  		}
	  		acqWrap = acquisitionMap.get(acq.ExternalId);
	  		if (pass == '1'){
		  		acqWrap.ExternalId = acq.ExternalId;

			   	acqWrap.acq_date = acq.acq_date__c;
				acqWrap.prop_cd = acq.prop_cd__c;
				acqWrap.quality_cd = acq.quality_cd__c;
				acqWrap.acquisition_cd = acq.acquisition_cd__c;

			   	acqWrap.recordtype = acq.recordtype__c;			   
				acqWrap.contact = acq.contact__c;

		  	}
		  	
	  		acquisitionMap.put(acqWrap.ExternalId, acqWrap);
	  	}
	}

/*******************************************************************************************************
    * @description Retrieve the Alias from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the Alias data
    * @return List<AliasWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.AliasWrapper>  AliasList = 
	*   		GuestContactMasterCC.retrieveAlias(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<AliasWrapper> retrieveAliasDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  and ExternalId in';
		String idType = 'external';
		return retrieveAlias(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<AliasWrapper> retrieveAliasByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' and contact__c in';
		String idType = 'contact';
		return retrieveAlias(contactIds, whereClause, idType);
	}

	private static List<AliasWrapper> retrieveAlias(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);	

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('Alias');

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' first_name__c, ';
		soql1 += ' last_name__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, AliasWrapper> aliasMap = new Map<String, AliasWrapper> ();

		List<customer_info_external_c__x> aliasList = (!mockedAlias.isEmpty()) ? mockedAlias : Database.query(soql1);
	   	
	  	system.debug('*** aliasList ' + aliasList );

	  	updateAlias (aliasMap, aliasList, '1');
	  	
	  	system.debug('*** aliasMap return ' + aliasMap.values());

	  	return aliasMap.values();
	}

	/*******************************************************************************************************
    * @description Update the AliasWrapper with soql results
    * @param Map<String, AliasWrapper> aliasMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<AliasWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.AliasWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateAlias(Map<String, AliasWrapper> aliasMap, List<customer_info_external_c__x> aliasList, String pass);
    */
	private static void updateAlias (Map<String, AliasWrapper> aliasMap, List<customer_info_external_c__x> aliasList, String pass){
		AliasWrapper acqWrap;

		for (customer_info_external_c__x acq : aliasList ){
	  		if (!aliasMap.containsKey(acq.ExternalId)) {
	  			aliasMap.put(acq.ExternalId, new AliasWrapper());
	  		}
	  		acqWrap = aliasMap.get(acq.ExternalId);
	  		if (pass == '1'){
		  		acqWrap.ExternalId = acq.ExternalId;

			   	acqWrap.first_name = acq.first_name__c;
				acqWrap.last_name = acq.last_name__c;

			   	acqWrap.recordtype = acq.recordtype__c;			   
				acqWrap.contact = acq.contact__c;

		  	}
		  	
	  		aliasMap.put(acqWrap.ExternalId, acqWrap);
	  	}
	}
	/*******************************************************************************************************
    * @description Retrieve the ScoreProp from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the ScoreProp data
    * @return List<ScorePropWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.ScorePropWrapper>  ScorePropList = 
	*   		GuestContactMasterCC.retrieveScoreProp(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<ScorePropWrapper> retrieveScorePropDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  AND  ExternalId in';
		String idType = 'external';
		return retrieveScoreProp(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<ScorePropWrapper> retrieveScorePropByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' AND contact__c in';
		String idType = 'contact';
		return retrieveScoreProp(contactIds, whereClause, idType);
	}

	private static List<ScorePropWrapper> retrieveScoreProp(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);			

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('ScoreProp');

		Map<String, String> contactDmIdMap = new Map<String, String>();
		for (Contact c : [SELECT Id, winet_Id__c  FROM Contact WHERE id in : ids]){
			contactDmIdMap.put(c.id, c.winet_Id__c );
		}

		String soql1 = ' SELECT externalid, ';
		soql1 += ' quality_cd__c, '; 
		soql1 += ' user_amt_1__c, '; 
		soql1 += ' user_amt_2__c, '; 
		soql1 += ' user_amt_3__c, ';
		soql1 += ' user_amt_4__c, ';
		soql1 += ' user_amt_5__c, '; 
		soql1 += ' user_amt_6__c, '; 
		soql1 += ' user_amt_7__c, ';
		soql1 += ' user_amt_8__c, '; 
		soql1 += ' user_amt_9__c, ';
		soql1 += ' worth__c, ';
		soql1 += ' user_flag_1__c, ';
		soql1 += ' user_flag_2__c, ';
		soql1 += ' user_flag_3__c, ';
		soql1 += ' user_flag_4__c, '; 
		soql1 += ' user_flag_5__c, '; 
		soql1 += ' user_flag_6__c, '; 
		soql1 += ' user_flag_7__c, '; 
		soql1 += ' user_flag_8__c, ';
		soql1 += ' prop_cd__c, ';
		soql1 += ' user_flag_9__c, '; 
		soql1 += ' last_update_dt__c, ';
		soql1 += ' user_score_1__c, ';
		soql1 += ' user_score_2__c, ';
		soql1 += ' user_score_3__c, '; 
		soql1 += ' user_score_4__c, '; 
		soql1 += ' user_score_5__c, ';
		soql1 += ' user_score_6__c, ';
		soql1 += ' user_score_7__c, ';
		soql1 += ' user_score_8__c, ';
		soql1 += ' user_score_9__c, ';
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, ScorePropWrapper> scorePropMap = new Map<String, ScorePropWrapper> ();

		List<customer_info_external_c__x> scorePropList = (!mockedScoreProp.isEmpty()) ? mockedScoreProp : Database.query(soql1);
	   	
	  	system.debug('*** scorePropList ' + scorePropList );

	  	updateScoreProp (scorePropMap, scorePropList, '1', contactDmIdMap);
	  	
	  	system.debug('*** scorePropMap return ' + scorePropMap.values());

	  	return scorePropMap.values();
	}

	/*******************************************************************************************************
    * @description Update the ScorePropWrapper with soql results
    * @param Map<String, ScorePropWrapper> scorePropMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<ScorePropWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.ScorePropWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateScoreProp(Map<String, ScorePropWrapper> scorePropMap, List<customer_info_external_c__x> scorePropList, String pass, Map<String, String> contactDmIdMap);
    */
	private static void updateScoreProp (Map<String, ScorePropWrapper> scorePropMap, List<customer_info_external_c__x> scorePropList, String pass, Map<String, String> contactDmIdMap){
		ScorePropWrapper splWrap;

		for (customer_info_external_c__x spl : scorePropList ){
	  		if (!scorePropMap.containsKey(spl.ExternalId)) {
	  			scorePropMap.put(spl.ExternalId, new ScorePropWrapper());
	  		}
	  		splWrap = scorePropMap.get(spl.ExternalId);
	  		if (pass == '1'){
		  		splWrap.ExternalId = spl.ExternalId;

			   	splWrap.quality_cd = spl.quality_cd__c;
				splWrap.user_amt_1 = spl.user_amt_1__c;
				splWrap.user_amt_2 = spl.user_amt_2__c;
				splWrap.user_amt_3 = spl.user_amt_3__c;
				splWrap.user_amt_4 = spl.user_amt_4__c;
				splWrap.user_amt_5 = spl.user_amt_5__c ;
				splWrap.user_amt_6 = spl.user_amt_6__c ;
				splWrap.user_amt_7 = spl.user_amt_7__c;
				splWrap.user_amt_8 = spl.user_amt_8__c ;
				splWrap.user_amt_9 = spl.user_amt_9__c;
				splWrap.worth = spl.worth__c;
				splWrap.user_flag_1 = spl.user_flag_1__c;
				splWrap.user_flag_2 = spl.user_flag_2__c;
				splWrap.user_flag_3 = spl.user_flag_3__c;
				splWrap.user_flag_4 = spl.user_flag_4__c ;
				splWrap.user_flag_5 = spl.user_flag_5__c ;
				splWrap.user_flag_6 = spl.user_flag_6__c ;
				splWrap.user_flag_7 = spl.user_flag_7__c ;
				splWrap.user_flag_8 = spl.user_flag_8__c;
				splWrap.prop_cd = spl.prop_cd__c;
				splWrap.user_flag_9 = spl.user_flag_9__c;
				splWrap.last_update_dt = spl.last_update_dt__c;
				splWrap.user_score_1 = spl.user_score_1__c;
				splWrap.user_score_2 = spl.user_score_2__c;
				splWrap.user_score_3 = spl.user_score_3__c ;
				splWrap.user_score_4 = spl.user_score_4__c ;
				splWrap.user_score_5 = spl.user_score_5__c;
				splWrap.user_score_6 = spl.user_score_6__c;
				splWrap.user_score_7 = spl.user_score_7__c;
				splWrap.user_score_8 = spl.user_score_8__c;
				splWrap.user_score_9 = spl.user_score_9__c;
				if (contactDmIdMap.containsKey(spl.contact__c)){
					splWrap.dmid = contactDmIdMap.get(spl.contact__c);
				}

			   	splWrap.recordtype = spl.recordtype__c;			   
				splWrap.contact = spl.contact__c;

		}
		  	
	  		scorePropMap.put(splWrap.ExternalId, splWrap);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the EthnicityAppend from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the EthnicityAppend data
    * @return List<EthnicityAppendWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.EthnicityAppendWrapper>  EthnicityAppendList = 
	*   		GuestContactMasterCC.retrieveEthnicityAppend(List<Id> ids, String whereClause, String idType);
    */
	@RemoteAction
	@AuraEnabled
	global static List<EthnicityAppendWrapper> retrieveEthnicityAppendDetails(List<String> externalIds) {
		system.debug('*** externalIds ' + externalIds);
		String whereClause = '  AND  ExternalId in';
		String idType = 'external';
		return retrieveEthnicityAppend(externalIds, whereClause, idType);
	}

	@RemoteAction
	@AuraEnabled
	global static List<EthnicityAppendWrapper> retrieveEthnicityAppendByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' AND contact__c in';
		String idType = 'contact';
		return retrieveEthnicityAppend(contactIds, whereClause, idType);
	}

	private static List<EthnicityAppendWrapper> retrieveEthnicityAppend(List<String> ids, String whereClause, String idType) {
		system.debug('*** whereClaus ' + whereClause);
		system.debug('*** idType ' + idType);			

		Set<String> recordtypes = new Set<String>();
		recordtypes.add('EthnicityAppend');

		Map<String, String> contactDmIdMap = new Map<String, String>();
		for (Contact c : [SELECT Id, winet_Id__c  FROM Contact WHERE id in : ids]){
			contactDmIdMap.put(c.id, c.winet_Id__c );
		}

		String soql1 = ' SELECT externalid, ';
		soql1 += ' asian_flag__c, '; 
		soql1 += ' source_file__c, '; 
		soql1 += ' ethnic_group1__c, '; 
		soql1 += ' ethnic_group2__c, '; 
		soql1 += ' pref_language__c, '; 
		soql1 += ' last_update_dt__c, '; 
		soql1 += ' sub_ethnic_type__c, '; 
		soql1 += ' main_ethnic_type__c, '; 
		soql1 += ' user_amt_1__c, '; 
		soql1 += ' user_amt_2__c, '; 
		soql1 += ' user_amt_3__c, ';
		soql1 += ' user_amt_4__c, ';
		soql1 += ' user_flag_1__c, ';
		soql1 += ' user_flag_2__c, ';
		soql1 += ' user_flag_3__c, ';
		soql1 += ' user_flag_4__c, '; 
		soql1 += ' user_flag_5__c, '; 
		soql1 += ' user_flag_6__c, '; 
		soql1 += ' user_score_1__c, ';
		soql1 += ' user_score_2__c, ';
		soql1 += ' user_score_3__c, '; 
		soql1 += ' user_score_4__c, '; 
		soql1 += ' recordtype__c, ';
		soql1 += ' contact__c ';
		soql1 += ' FROM customer_info_external_c__x  ';
		soql1 += ' WHERE recordtype__c in ' + ': recordtypes';
		soql1 += whereClause + ': ids';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, EthnicityAppendWrapper> ethnicityAppendMap = new Map<String, EthnicityAppendWrapper> ();

		List<customer_info_external_c__x> ethnicityAppendList = (!mockedEthnicityAppend.isEmpty()) ? mockedEthnicityAppend : Database.query(soql1);
	   	
	  	system.debug('*** ethnicityAppendList ' + ethnicityAppendList );

	  	updateEthnicityAppend (ethnicityAppendMap, ethnicityAppendList, '1');
	  	
	  	system.debug('*** EthnicityAppendMap return ' + ethnicityAppendMap.values());

	  	return ethnicityAppendMap.values();
	}

	/*******************************************************************************************************
    * @description Update the EthnicityAppendWrapper with soql results
    * @param Map<String, EthnicityAppendWrapper> ethnicityAppendMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<EthnicityAppendWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.EthnicityAppendWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateEthnicityAppend(Map<String, EthnicityAppendWrapper> ethnicityAppendMap, List<customer_info_external_c__x> ethnicityAppendList, String pass,;
    */
	private static void updateEthnicityAppend (Map<String, EthnicityAppendWrapper> ethnicityAppendMap, List<customer_info_external_c__x> ethnicityAppendList, String pass){
		EthnicityAppendWrapper splWrap;

		for (customer_info_external_c__x spl : ethnicityAppendList ){
	  		if (!ethnicityAppendMap.containsKey(spl.ExternalId)) {
	  			ethnicityAppendMap.put(spl.ExternalId, new EthnicityAppendWrapper());
	  		}
	  		splWrap = ethnicityAppendMap.get(spl.ExternalId);
	  		if (pass == '1'){
		  		splWrap.ExternalId = spl.ExternalId;

		  		splWrap.asian_flag = spl.asian_flag__c;
		  		splWrap.source_file = spl.source_file__c;
		  		splWrap.ethnic_group1 = spl.ethnic_group1__c;
		  		splWrap.ethnic_group2 = spl.ethnic_group2__c;
		  		splWrap.pref_language = spl.pref_language__c;
		  		splWrap.last_update_dt = spl.last_update_dt__c;
		  		splWrap.sub_ethnic_type = spl.sub_ethnic_type__c;
		  		splWrap.main_ethnic_type = spl.main_ethnic_type__c;
				splWrap.user_amt_1 = spl.user_amt_1__c;
				splWrap.user_amt_2 = spl.user_amt_2__c;
				splWrap.user_amt_3 = spl.user_amt_3__c;
				splWrap.user_amt_4 = spl.user_amt_4__c;
				splWrap.user_flag_1 = spl.user_flag_1__c;
				splWrap.user_flag_2 = spl.user_flag_2__c;
				splWrap.user_flag_3 = spl.user_flag_3__c;
				splWrap.user_flag_4 = spl.user_flag_4__c ;
				splWrap.user_flag_5 = spl.user_flag_5__c ;
				splWrap.user_flag_6 = spl.user_flag_6__c ;
				splWrap.user_score_1 = spl.user_score_1__c;
				splWrap.user_score_2 = spl.user_score_2__c;
				splWrap.user_score_3 = spl.user_score_3__c ;
				splWrap.user_score_4 = spl.user_score_4__c ;

			   	splWrap.recordtype = spl.recordtype__c;			   
				splWrap.contact = spl.contact__c;

		}
		  	
	  		ethnicityAppendMap.put(splWrap.ExternalId, splWrap);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the ConsXref from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the ConsXref data
    * @return List<ConsXrefWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.ConsXrefWrapper>  ConsXrefList = 
	*   		GuestContactMasterCC.retrieveConsXref(List<Id> ids, String whereClause, String idType);
    */
	//@RemoteAction
	//@AuraEnabled
	//global static List<ConsXrefWrapper> retrieveConsXrefDetails(List<String> externalIds) {
	//	system.debug('*** externalIds ' + externalIds);
	//	String whereClause = '  and ExternalId in';
	//	String idType = 'external';
	//	return retrieveConsXref(externalIds, whereClause, idType);
	//}

	@RemoteAction
	@AuraEnabled
	global static List<ConsXrefWrapper> retrieveConsXrefByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE i_dmid__c in';
		return retrieveConsXref(contactIds, whereClause);
	}

	private static List<ConsXrefWrapper> retrieveConsXref(List<String> ids, String whereClause) {
		system.debug('*** whereClaus ' + whereClause);

		List<String> winIdList = retrieveConsIdRefs (ids);

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' i_xref_dmid__c, ';
		soql1 += ' i_dmid__c, ';
		soql1 += ' c_quality_cd__c, ';
		soql1 += ' id__c ';
		soql1 += ' FROM gst_cons_xref__x   ';
		soql1 += whereClause + ': winIdList';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, ConsXrefWrapper> consXrefMap = new Map<String, ConsXrefWrapper> ();

		List<gst_cons_xref__x> consXrefList = (!mockedConsXref.isEmpty()) ? mockedConsXref : Database.query(soql1);
	   	
	  	system.debug('*** consXrefList ' + consXrefList );

	  	updateConsXref (consXrefMap, consXrefList, '1');
	  	
	  	system.debug('*** consXrefMap return ' + consXrefMap.values());

	  	return consXrefMap.values();
	}

	/*******************************************************************************************************
    * @description Update the ConsXrefWrapper with soql results
    * @param Map<String, ConsXrefWrapper> consXrefMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<ConsXrefWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.ConsXrefWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateConsXref(Map<String, ConsXrefWrapper> consXrefMap, List<customer_info_external_c__x> consXrefList, String pass);
    */
	private static void updateConsXref (Map<String, ConsXrefWrapper> consXrefMap, List<gst_cons_xref__x> consXrefList, String pass){
		ConsXrefWrapper xWrap;

		for (gst_cons_xref__x acq : consXrefList ){
	  		if (!consXrefMap.containsKey(acq.ExternalId)) {
	  			consXrefMap.put(acq.ExternalId, new ConsXrefWrapper());
	  		}
	  		xWrap = consXrefMap.get(acq.ExternalId);
	  		if (pass == '1'){
		  		xWrap.ExternalId = acq.ExternalId;

			   	xWrap.i_xref_dmid = acq.i_xref_dmid__c;
				xWrap.i_dmid = acq.i_dmid__c;
			   	xWrap.c_quality_cd = acq.c_quality_cd__c;	
			   	xWrap.id = acq.id__c;		   

		  	}
		  	
	  		consXrefMap.put(xWrap.ExternalId, xWrap);
	  	}
	}

	/*******************************************************************************************************
    * @description Retrieve the IdXref from Customer Info External
    * @param List<Id> of Contact/External Ids used to retrieve the IdXref data
    * @return List<IdXrefWrapper> containing the retrieved data
    * @example
    * List<GuestContactMasterCC.IdXrefWrapper>  IdXrefList = 
	*   		GuestContactMasterCC.retrieveIdXref(List<Id> ids, String whereClause, String idType);
    */
	//@RemoteAction
	//@AuraEnabled
	//global static List<IdXrefWrapper> retrieveIdXrefDetails(List<String> externalIds) {
	//	system.debug('*** externalIds ' + externalIds);
	//	String whereClause = '  and ExternalId in';
	//	String idType = 'external';
	//	return retrieveIdXref(externalIds, whereClause, idType);
	//}

	@RemoteAction
	@AuraEnabled
	global static List<IdXrefWrapper> retrieveIdXrefByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE i_dmId__c in';
		return retrieveIdXref(contactIds, whereClause);
	}

	private static List<IdXrefWrapper> retrieveIdXref(List<String> ids, String whereClause) {
		system.debug('*** whereClaus ' + whereClause);	

		List<String> winIdList = retrieveConsIdRefs (ids);

		String soql1 = ' SELECT externalid, ';
	   	soql1 += ' i_xref_dmid__c, ';
		soql1 += ' i_dmid__c, ';
		soql1 += ' c_quality_cd__c, ';
		soql1 += ' id__c, ';
		soql1 += ' c_xref_type__c';
		soql1 += ' FROM caesars_gst_id_xref__x   ';
		soql1 += whereClause + ': winIdList';

		soql1 = String.escapeSingleQuotes(soql1);

		system.debug('*** soql1 ' + soql1);
		
		Map<String, IdXrefWrapper> idXrefMap = new Map<String, IdXrefWrapper> ();

		List<caesars_gst_id_xref__x> idXrefList = (!mockedIdXref.isEmpty()) ? mockedIdXref : Database.query(soql1);
	   	
	  	system.debug('*** idXrefList ' + idXrefList );

	  	updateIdXref (idXrefMap, idXrefList, '1');
	  	
	  	system.debug('*** idXrefMap return ' + idXrefMap.values());

	  	return idXrefMap.values();
	}

	/*******************************************************************************************************
    * @description Update the IdXrefWrapper with soql results
    * @param Map<String, IdXrefWrapper> idXrefMap
    * @param List<customer_info_external_c__x> 
    * @param String pass - which fields to update based on the soql that was run
    * @return List<IdXrefWrapper> containing the updated data
    * @example
    * List<GuestContactMasterCC.IdXrefWrapper>  wrapperList = 
	*   		GuestContactMasterCC.updateIdXref(Map<String, IdXrefWrapper> idXrefMap, List<customer_info_external_c__x> idXrefList, String pass);
    */
	private static void updateIdXref (Map<String, IdXrefWrapper> idXrefMap, List<caesars_gst_id_xref__x> idXrefList, String pass){
		IdXrefWrapper xWrap;

		for (caesars_gst_id_xref__x acq : idXrefList ){
	  		if (!idXrefMap.containsKey(acq.ExternalId)) {
	  			idXrefMap.put(acq.ExternalId, new IdXrefWrapper());
	  		}
	  		xWrap = idXrefMap.get(acq.ExternalId);
	  		if (pass == '1'){
		  		xWrap.ExternalId = acq.ExternalId;

			   	xWrap.i_xref_dmid = acq.i_xref_dmid__c;
				xWrap.i_dmid = acq.i_dmid__c;
			   	xWrap.c_quality_cd = acq.c_quality_cd__c;
			   	xWrap.c_xref_type = acq.c_xref_type__c;		
			   	xWrap.id = acq.id__c;		   

		  	}
		  	
	  		idXrefMap.put(xWrap.ExternalId, xWrap);
	  	}
	}



	/*******************************************************************************************************
    * @description Return a list of dmIds based on a list onc Contact Ids
    * @param List<Id> of Contact Ids used to retrieve the Contact dmids
    * @return List<caesars_gst_id_xref__x> a combined list caesars_gst_id_xref__x 
    * @example
    * 	List<caesars_gst_id_xref__x> retrieveIdRefs(List<String> contactIds)
    */
	@TestVisible private static List<String> retrieveIdRefs(List<String> contactIds){
		system.debug('*** in retrieveDmIds');
		List<String> winnetIds = new List<String>();
		//
		// find all the dmIds for the Contacts
		//
		for (Contact ctc : [SELECT Id, winet_Id__c FROM Contact WHERE Id in :contactIds]){
			if (ctc.winet_Id__c != null){
				winnetIds.add(ctc.winet_Id__c);
			}
		}

		system.debug('*** winnetIds ' + winnetIds);

		//
		// return all id_xref rows where the dmId or the xref_dmid are in the winnetIds set
		//
		List<caesars_gst_id_xref__x> idXrefList = new List<caesars_gst_id_xref__x> ();
		idXrefList = (!mockedIdXref.isEmpty()) ? mockedIdXref : 
		[SELECT i_dmid__c
			FROM caesars_gst_id_xref__x 
			WHERE i_xref_dmid__c in :winnetIds ];

		for(caesars_gst_id_xref__x gstx : idXrefList){
			if (gstx.i_dmid__c != null){
				winnetIds.add(gstx.i_dmid__c);
			}
		}

		return winnetIds;

	}

	/*******************************************************************************************************
    * @description Return a list of dmIds based on a list onc Contact Ids
    * @param List<Id> of Contact Ids used to retrieve the Contact dmids
    * @return List<String> a combined list from gst_cons_xref__x 
    * @example
    * 	List<gst_cons_xref__x> retrieveIdRefs(List<String> contactIds)
    */
	@TestVisible private static List<String> retrieveConsIdRefs(List<String> contactIds){
		system.debug('*** in retrieveDmIds');
		List<String> winnetIds = new List<String>();
		//
		// find all the dmIds for the Contacts
		//
		for (Contact ctc : [SELECT Id, winet_Id__c FROM Contact WHERE Id in :contactIds]){
			if (ctc.winet_Id__c != null){
				winnetIds.add(ctc.winet_Id__c);
			}
		}

		system.debug('*** winnetIds ' + winnetIds);

		//
		// return all id_xref rows where the dmId or the xref_dmid are in the winnetIds set
		//
		List<gst_cons_xref__x> idConsXrefList = new List<gst_cons_xref__x> ();
		idConsXrefList = (!mockedConsXref.isEmpty()) ? mockedConsXref : 
		[SELECT i_dmid__c
			FROM gst_cons_xref__x 
			WHERE i_xref_dmid__c in :winnetIds ];

		for(gst_cons_xref__x gstx : idConsXrefList){
			if (gstx.i_dmid__c != null){
				winnetIds.add(gstx.i_dmid__c);
			}
		}

		return winnetIds;

	}


	/*******************************************************************************************************
    * @description Wrapper class for Address
    */
	global class AddressWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
	   	@AuraEnabled global String adi { get; set; } 
		@AuraEnabled global String city { get; set; } 
		@AuraEnabled global String state_cd { get; set; } 
		@AuraEnabled global String country_cd { get; set; }  
		@AuraEnabled global String quality_cd { get; set; } 
		@AuraEnabled global String dpbc { get; set; } 
		@AuraEnabled global String datec { get; set; } 
		@AuraEnabled global String zip_3 { get; set; } 
		@AuraEnabled global String zip_7 { get; set; } 
		@AuraEnabled global String zip_plus_4 { get; set; } 
		@AuraEnabled global String county { get; set; } 
		@AuraEnabled global String msa_cd { get; set; } 
		@AuraEnabled global String pci_cd { get; set; } 
		@AuraEnabled global String apt_num { get; set; } 
		@AuraEnabled global String area_cd { get; set; } 
		@AuraEnabled global String mail_cd { get; set; } 
		@AuraEnabled global String am_pm_cd { get; set; } 
		@AuraEnabled global String tele_num { get; set; } 
		@AuraEnabled global String address_1 { get; set; } 
		@AuraEnabled global String address_2 { get; set; } 
		@AuraEnabled global String contact { get; set; } 
		@AuraEnabled global String addr_type { get; set; } 
		@AuraEnabled global String acquisition_cd { get; set; } 
		@AuraEnabled global String acquisition_cd_name { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String country_tele_cd { get; set; } 
	
	  	global AddressWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for Email
    */
	global class EmailWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
	   	@AuraEnabled global String email { get; set; } 
		@AuraEnabled global String source { get; set; } 
		@AuraEnabled global String qual_cd { get; set; } 
		@AuraEnabled global String ofr_freq { get; set; }  
		@AuraEnabled global String qual_cat { get; set; } 
		@AuraEnabled global String email_flag { get; set; } 
		@AuraEnabled global String quality_cd { get; set; } 
		@AuraEnabled global Decimal i_contact_count { get; set; } 
		@AuraEnabled global String last_bounce_cd { get; set; } 
		@AuraEnabled global String qual_reason_cd { get; set; } 
		@AuraEnabled global String qual_hygiene_cd { get; set; } 
		@AuraEnabled global String bounce_timestamp { get; set; } 
		@AuraEnabled global String qual_chg_timestamp { get; set; } 
		@AuraEnabled global String email_engagement_cd { get; set; } 
		@AuraEnabled global String email_chg_timestamp { get; set; } 
		@AuraEnabled global String qual_conf_timestamp { get; set; } 
		@AuraEnabled global String email_address_valid_cd { get; set; } 
		@AuraEnabled global String email_address_quality_cd { get; set; } 
		@AuraEnabled global String last_change_timestamp_utc { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 
	
	  	global EmailWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for PrefMarketMail
    */
	global class PrefMarketMailWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String market_cd { get; set; } 
		@AuraEnabled global String quality_cd { get; set; }
		@AuraEnabled global String market_type { get; set; } 
		@AuraEnabled global String gst_pref_mail_flag { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 
	
	  	global PrefMarketMailWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for PrefPropMail
    */
	global class PrefPropMailWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String prop_cd { get; set; } 
		@AuraEnabled global String quality_cd { get; set; }
		@AuraEnabled global String gst_pref_mail_flag { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 
	
	  	global PrefPropMailWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for NxtGenAddress
    */
	global class NxtGenAddressWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
	   	@AuraEnabled global String notes { get; set; } 
		@AuraEnabled global String phone { get; set; } 
		@AuraEnabled global String addr_1 { get; set; } 
		@AuraEnabled global String addr_2 { get; set; }  
		@AuraEnabled global String addr_3 { get; set; } 
		@AuraEnabled global String app_cd { get; set; } 
		@AuraEnabled global String rep_id { get; set; } 
		@AuraEnabled global String zip_cd { get; set; } 
		@AuraEnabled global String book_id { get; set; } 
		@AuraEnabled global String prop_cd { get; set; } 
		@AuraEnabled global String stats_cd { get; set; } 
		@AuraEnabled global String addr_desc { get; set; } 
		@AuraEnabled global String city_name { get; set; } 
		@AuraEnabled global String create_dt { get; set; } 
		@AuraEnabled global String country_cd { get; set; } 
		@AuraEnabled global String state_name { get; set; } 
		@AuraEnabled global Decimal note_pad_id { get; set; } 
		@AuraEnabled global String creator_login { get; set; } 
		@AuraEnabled global String addr_status_cd { get; set; } 
		@AuraEnabled global String modifier_login { get; set; } 
		@AuraEnabled global String contact { get; set; } 
		@AuraEnabled global Decimal pcs_address_id { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
	
	  	global NxtGenAddressWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for NxtgenEmail
    */
	global class NxtGenEmailWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String email { get; set; } 
		@AuraEnabled global String email_status { get; set; } 
		@AuraEnabled global String app_cd { get; set; }
		@AuraEnabled global String create_dt { get; set; } 
		@AuraEnabled global String created_by { get; set; } 
		@AuraEnabled global String email_type { get; set; } 
		@AuraEnabled global Decimal email_id { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 
	
	  	global NxtGenEmailWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for NxtgenContactChan
    */
	global class NxtGenContactChanWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String app_cd { get; set; } 
		@AuraEnabled global String creator_login { get; set; } 
		@AuraEnabled global String modifier_login { get; set; }
		@AuraEnabled global String create_dt { get; set; } 
		@AuraEnabled global String do_not_contact_channel { get; set; } 
		@AuraEnabled global String preferred_contact_channel { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 
	
	  	global NxtGenContactChanWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for NxtgenPhone
    */
	global class NxtGenPhoneWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String app_cd { get; set; } 
		@AuraEnabled global String phone { get; set; } 
		@AuraEnabled global String privatec { get; set; }
		@AuraEnabled global String created_dt { get; set; } 
		@AuraEnabled global String created_by { get; set; } 
		@AuraEnabled global String phone_type { get; set; } 
		@AuraEnabled global Decimal psc_phone_id { get; set; } 
		@AuraEnabled global String phone_status { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 

	  	global NxtGenPhoneWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for NxtgenToDo
    */
	global class NxtGenToDoWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global Decimal worth { get; set; } 
		@AuraEnabled global String app_cd { get; set; } 
		@AuraEnabled global String rep_id { get; set; }
		@AuraEnabled global String due_dt { get; set; } 
		@AuraEnabled global String book_id { get; set; } 
		@AuraEnabled global String prop_cd { get; set; } 
		@AuraEnabled global String task_id { get; set; } 
		@AuraEnabled global String due_time { get; set; } 
		@AuraEnabled global Decimal event_id { get; set; } 
		@AuraEnabled global Decimal to_do_id { get; set; } 
		@AuraEnabled global String last_name { get; set; } 
		@AuraEnabled global String create_dt { get; set; } 
		@AuraEnabled global String first_name { get; set; } 
		@AuraEnabled global String to_do_type { get; set; } 
		@AuraEnabled global Decimal market_adw { get; set; } 
		@AuraEnabled global String middle_init { get; set; } 
		@AuraEnabled global String to_do_notes { get; set; } 
		@AuraEnabled global String to_do_status { get; set; } 
		@AuraEnabled global String last_trip_dt { get; set; } 
		@AuraEnabled global String creator_login { get; set; } 
		@AuraEnabled global String to_do_segment { get; set; } 
		@AuraEnabled global String to_do_subject { get; set; } 
		@AuraEnabled global String modifier_login { get; set; } 
		@AuraEnabled global String offer_reserved { get; set; } 
		@AuraEnabled global String suggested_channel { get; set; } 
		@AuraEnabled global String contact_dt_by_all { get; set; } 
		@AuraEnabled global String my_last_contact_dt { get; set; } 
		@AuraEnabled global String last_contact_dt_by_me { get; set; } 
		@AuraEnabled global String phone_contact_dt_by_all { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 

	  	global NxtGenToDoWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for TierScore
    */
	global class TierScoreWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global Decimal yearc { get; set; } 
		@AuraEnabled global String as_of { get; set; } 
		@AuraEnabled global String posted_on { get; set; }
		@AuraEnabled global String quality_cd { get; set; } 
		@AuraEnabled global Decimal promo_base { get; set; } 
		@AuraEnabled global Decimal tier_score { get; set; } 
		@AuraEnabled global Decimal adjust_base { get; set; } 
		@AuraEnabled global Decimal earned_base { get; set; } 
		@AuraEnabled global Decimal prev_tier_score { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 

	  	global TierScoreWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for Casino
    */
	global class CasinoWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String rep_id { get; set; } 
		@AuraEnabled global String prop_cd { get; set; } 
		@AuraEnabled global String update_dt { get; set; }
		@AuraEnabled global Decimal casino_id { get; set; } 
		@AuraEnabled global String quality_cd { get; set; } 
		@AuraEnabled global String create_date { get; set; } 
		@AuraEnabled global String purge_react { get; set; } 
		@AuraEnabled global String cred_appr_by { get; set; } 
		@AuraEnabled global String prop_mail_cd { get; set; } 
		@AuraEnabled global Decimal avail_credit { get; set; }
		@AuraEnabled global Decimal credit_limit { get; set; }
		@AuraEnabled global String credit_status { get; set; }
		@AuraEnabled global Decimal outstand_credit { get; set; }
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 

	  	global CasinoWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for Repcode
    */
	global class RepcodeWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String rep_cd { get; set; } 
		@AuraEnabled global String prop_cd { get; set; } 
		@AuraEnabled global Decimal efft_dy { get; set; }
		@AuraEnabled global Decimal efft_mn { get; set; } 
		@AuraEnabled global Decimal efft_yr { get; set; } 
		@AuraEnabled global String rep_type { get; set; } 
		@AuraEnabled global Decimal rep_rank { get; set; } 
		@AuraEnabled global Decimal patron_id { get; set; } 
		@AuraEnabled global String current_cd { get; set; } 
		@AuraEnabled global String entered_by { get; set; }
		@AuraEnabled global String quality_cd { get; set; }
		@AuraEnabled global Decimal trans_time { get; set; }
		@AuraEnabled global String efft_end_dt { get; set; }
		@AuraEnabled global String efft_start_dt { get; set; }
		@AuraEnabled global String trans_100_yr { get; set; }
		@AuraEnabled global Decimal rep_trip_nbr { get; set; }
		@AuraEnabled global String patron_rep_appv { get; set; }
		@AuraEnabled global Decimal last_rep_h_date { get; set; }
		@AuraEnabled global Decimal assigned_century { get; set; }
		@AuraEnabled global Decimal last_rep_cd_date { get; set; }
		@AuraEnabled global String trans_cal_dt { get; set; }
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 

	  	global RepcodeWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for Acquisition
    */
	global class AcquisitionWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String acq_date { get; set; } 
		@AuraEnabled global String prop_cd { get; set; } 
		@AuraEnabled global String quality_cd { get; set; }
		@AuraEnabled global String acquisition_cd { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 

	  	global AcquisitionWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for Alias
    */
	global class AliasWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String first_name { get; set; } 
		@AuraEnabled global String last_name { get; set; } 
		@AuraEnabled global String recordtype { get; set; } 
		@AuraEnabled global String contact { get; set; } 

	  	global AliasWrapper(){

	  	}
	}
	/*******************************************************************************************************
    * @description Wrapper class for ScoreProp
    */
	global class ScorePropWrapper {
		 @AuraEnabled global String ExternalId { get; set; } 
		 @AuraEnabled global String quality_cd { get; set; } 
		 @AuraEnabled global Decimal user_amt_1  { get; set; } 
		 @AuraEnabled global Decimal user_amt_2  { get; set; } 
		 @AuraEnabled global Decimal user_amt_3  { get; set; } 
		 @AuraEnabled global Decimal user_amt_4  { get; set; } 
		 @AuraEnabled global Decimal user_amt_5  { get; set; } 
		 @AuraEnabled global Decimal user_amt_6  { get; set; } 
		 @AuraEnabled global Decimal user_amt_7  { get; set; } 
		 @AuraEnabled global Decimal user_amt_8  { get; set; } 
		 @AuraEnabled global Decimal user_amt_9  { get; set; } 
		 @AuraEnabled global Decimal worth  { get; set; } 
		 @AuraEnabled global String user_flag_1  { get; set; } 
		 @AuraEnabled global String user_flag_2  { get; set; } 
		 @AuraEnabled global String user_flag_3  { get; set; } 
		 @AuraEnabled global String user_flag_4  { get; set; } 
		 @AuraEnabled global String user_flag_5  { get; set; } 
		 @AuraEnabled global String user_flag_6  { get; set; } 
		 @AuraEnabled global String user_flag_7  { get; set; } 
		 @AuraEnabled global String user_flag_8  { get; set; } 
		 @AuraEnabled global String prop_cd  { get; set; } 
		 @AuraEnabled global String user_flag_9  { get; set; } 
		 @AuraEnabled global String last_update_dt  { get; set; } 
		 @AuraEnabled global Decimal user_score_1  { get; set; } 
		 @AuraEnabled global Decimal user_score_2  { get; set; } 
		 @AuraEnabled global Decimal user_score_3  { get; set; } 
		 @AuraEnabled global Decimal user_score_4  { get; set; } 
		 @AuraEnabled global Decimal user_score_5  { get; set; } 
		 @AuraEnabled global Decimal user_score_6  { get; set; } 
		 @AuraEnabled global Decimal user_score_7  { get; set; } 
		 @AuraEnabled global Decimal user_score_8   { get; set; } 
		 @AuraEnabled global Decimal user_score_9  { get; set; } 
		 @AuraEnabled global String dmid  { get; set; } 

		 @AuraEnabled global String recordtype { get; set; } 
		 @AuraEnabled global String contact { get; set; } 

	  	global ScorePropWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for EthnicityAppend
    */
	global class EthnicityAppendWrapper {
		 @AuraEnabled global String ExternalId { get; set; } 
		 @AuraEnabled global Decimal user_amt_1  { get; set; } 
		 @AuraEnabled global Decimal user_amt_2  { get; set; } 
		 @AuraEnabled global Decimal user_amt_3  { get; set; } 
		 @AuraEnabled global Decimal user_amt_4  { get; set; } 
		 @AuraEnabled global String user_flag_1  { get; set; } 
		 @AuraEnabled global String user_flag_2  { get; set; } 
		 @AuraEnabled global String user_flag_3  { get; set; } 
		 @AuraEnabled global String user_flag_4  { get; set; } 
		 @AuraEnabled global String user_flag_5  { get; set; } 
		 @AuraEnabled global String user_flag_6  { get; set; } 
 		 @AuraEnabled global String source_file  { get; set; } 
 		 @AuraEnabled global String asian_flag  { get; set; } 
 		 @AuraEnabled global String pref_language  { get; set; } 
 		 @AuraEnabled global String ethnic_group1  { get; set; } 
 		 @AuraEnabled global String ethnic_group2  { get; set; } 
 		 @AuraEnabled global String sub_ethnic_type  { get; set; } 
 		 @AuraEnabled global String main_ethnic_type  { get; set; } 
		 @AuraEnabled global String last_update_dt  { get; set; } 
		 @AuraEnabled global Decimal user_score_1  { get; set; } 
		 @AuraEnabled global Decimal user_score_2  { get; set; } 
		 @AuraEnabled global Decimal user_score_3  { get; set; } 
		 @AuraEnabled global Decimal user_score_4  { get; set; } 

		 @AuraEnabled global String recordtype { get; set; } 
		 @AuraEnabled global String contact { get; set; } 

	  	global EthnicityAppendWrapper(){

	  	}
	}

	/*******************************************************************************************************
    * @description Wrapper class for ConsXref
    */
	global class ConsXrefWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String i_xref_dmid { get; set; } 
		@AuraEnabled global String i_dmid { get; set; } 
		@AuraEnabled global String c_quality_cd { get; set; } 
		@AuraEnabled global Decimal id { get; set; }

	  	global ConsXrefWrapper(){

	  	}
	}	

	/*******************************************************************************************************
    * @description Wrapper class for Id Xref
    */
	global class IdXrefWrapper {
		@AuraEnabled global String ExternalId { get; set; } 
		@AuraEnabled global String i_xref_dmid { get; set; } 
		@AuraEnabled global String i_dmid { get; set; } 
		@AuraEnabled global String c_quality_cd { get; set; } 
		@AuraEnabled global Decimal id { get; set; } 
		@AuraEnabled global String c_xref_type { get; set; } 

	  	global IdXrefWrapper(){

	  	}
	}	

}