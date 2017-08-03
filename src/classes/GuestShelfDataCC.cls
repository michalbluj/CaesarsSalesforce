/**
* @author Sarah Kennedy
* @date July 2017
*
* @description Class to retrieve Shelf (Marketing Campaign) Data, extending base class GuestSubjectcDataBase.cls
*/
global with sharing class GuestShelfDataCC extends GuestSubjectDataBaseCC {

	global GuestShelfDataCC() { }

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
		return retrieveMarketingCampaigns(externalIds, whereClause);
	}

	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignWrapper> retrieveMarketingCampaignByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		return retrieveMarketingCampaigns(contactIds, whereClause);
	}

	private static List<MarketingCampaignWrapper> retrieveMarketingCampaigns(List<String> ids, String whereClause) {
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
	  	soql1 += ' FROM marketing_campaigns__x ';
	  	soql1 += whereClause + ': ids';

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
	  	soql2 += whereClause + ': ids';

	  	soql2 = String.escapeSingleQuotes(soql2);

	  	String soql3 = 'SELECT ExternalId, ';	   				
	  	soql3 += ' c_pref_prop_cd_fk__c, ';	
	  	soql3 += ' c_pref_prop_cd_fk__r.Name, ';	
	  	soql3 += ' c_prop_cd_1_fk__c, ';	
	  	soql3 += ' c_prop_cd_1_fk__r.Name, ';	
	  	soql3 += ' c_prop_cd_2_fk__c, ';	
	  	soql3 += ' c_prop_cd_2_fk__r.Name ';	
	  	soql3 += ' FROM marketing_campaigns__x  ';	
	  	soql3 += whereClause + ': ids';

	  	soql3 = String.escapeSingleQuotes(soql3);

	  	String soql4 = 'SELECT ExternalId, ';	   				
	  	soql4 += ' c_tier_cd_fk__c, ';
	  	soql4 += ' c_tier_cd_fk__r.Name, ';
	  	soql4 += ' f_worth__c ';
	  	soql4 += ' FROM marketing_campaigns__x  ';
	  	soql4 += whereClause + ': ids';

	  	soql4 = String.escapeSingleQuotes(soql4);

		//
		// need to run several SOQLs due to error if too many external data source are
		// used in a SOQL
		//
		Map<String, MarketingCampaignWrapper> mktCampaignsMap = new Map<String, MarketingCampaignWrapper> ();

		List<marketing_campaigns__x> mktCampaignsList = (!mockedRequests.isEmpty()) ? mockedRequests : Database.query(soql1);	  	
	  	updateMarketingCampaign (mktCampaignsMap, mktCampaignsList, '1');
	  	system.debug('*** mktCampaignsMap1 ' + mktCampaignsMap);

	  	mktCampaignsList = (!mockedRequests.isEmpty()) ? mockedRequests : Database.query(soql2);
	  	updateMarketingCampaign (mktCampaignsMap, mktCampaignsList, '2');
	  	system.debug('*** mktCampaignsMap2 ' + mktCampaignsMap);

	  	mktCampaignsList = (!mockedRequests.isEmpty()) ? mockedRequests : Database.query(soql3);
	  	updateMarketingCampaign (mktCampaignsMap, mktCampaignsList, '3');
	  	system.debug('*** mktCampaignsMap3 ' + mktCampaignsMap);

	  	mktCampaignsList = (!mockedRequests.isEmpty()) ? mockedRequests : Database.query(soql4);
	  	updateMarketingCampaign (mktCampaignsMap, mktCampaignsList, '4');

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
		  		mcw.c_dom_market_cd_fk_POD = mktCampaign.c_dom_market_cd_fk__r.POD__c;
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
		return retrieveMarketingCampaignProperties(externalIds, whereClause);
	}

	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignPropertyWrapper> retrieveMarketingCampaignPropByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		return retrieveMarketingCampaignProperties(contactIds, whereClause);
	}

	private static List<MarketingCampaignPropertyWrapper> retrieveMarketingCampaignProperties(List<String> ids, String whereClause) {
		Map<String, MarketingCampaignPropertyWrapper> mktCampaignsPropMap = new Map<String, MarketingCampaignPropertyWrapper> ();

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
	  	soql1 += whereClause + ': ids';

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
	  	soql2 += whereClause + ': ids';

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
	  	soql3 += whereClause + ': ids';

	  	soql3 = String.escapeSingleQuotes(soql3);

		//
		// need to run several SOQLs due to error if too many external data source are
		// used in a SOQL
		//
		List<marketing_campaigns_properties__x> mktCampaignsPropList = (!mockedPropRequests.isEmpty()) ? mockedPropRequests : Database.query(soql1);
	  	updateMarketingCampaignProp (mktCampaignsPropMap, mktCampaignsPropList, '1');

	  	mktCampaignsPropList = (!mockedPropRequests.isEmpty()) ? mockedPropRequests : Database.query(soql2);
	  	updateMarketingCampaignProp (mktCampaignsPropMap, mktCampaignsPropList, '2');

	  	mktCampaignsPropList = (!mockedPropRequests.isEmpty()) ? mockedPropRequests : Database.query(soql3);  	
	  	updateMarketingCampaignProp (mktCampaignsPropMap, mktCampaignsPropList, '3');

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
		  		mcw.c_dom_market_cd_fk_POD = mktCampaignProp.c_dom_market_cd_fk__r.POD__c;
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
		return retrieveEnterpriseCampaign(externalIds, whereClause);
	}

	@RemoteAction
	@AuraEnabled
	global static List<EnterpriseCampaignWrapper> retrieveEnterpriseByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		return retrieveEnterpriseCampaign(contactIds, whereClause);
	}

	private static List<EnterpriseCampaignWrapper> retrieveEnterpriseCampaign(List<String> ids, String whereClause) {

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
	  	soql1 += whereClause + ': ids';

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
		return retrieveMarketingCampaignWeekly(externalIds, whereClause);
	}

	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignWeeklyWrapper> retrieveWeeklyByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		return retrieveMarketingCampaignWeekly(contactIds, whereClause);
	}

	private static List<MarketingCampaignWeeklyWrapper> retrieveMarketingCampaignWeekly(List<String> ids, String whereClause) {

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
	  	soql1 += whereClause + ': ids';

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
	  	soql2 += whereClause + ': ids';

	  	soql2 = String.escapeSingleQuotes(soql2);

	  	String soql3 = ' SELECT ExternalId,	 ';  				
	  	soql3 += ' c_prop_cd_1_fk__c, ';
	  	soql3 += ' c_prop_cd_1_fk__r.Name, ';
	  	soql3 += ' c_prop_cd_2_fk__c, ';
	  	soql3 += ' c_prop_cd_2_fk__r.Name, ';
	  	soql3 += ' c_tier_cd_fk__c, ';
	  	soql3 += ' c_tier_cd_fk__r.Name ';
	  	soql3 += ' FROM marketing_campaigns_weekly__x  ';
	  	soql3 += whereClause + ': ids';

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
		return retrieveMarketingCampaignLVM(externalIds, whereClause);
	}

	@RemoteAction
	@AuraEnabled
	global static List<MarketingCampaignsLVMWrapper> retrieveLVMByContacts(List<String> contactIds) {
		system.debug('*** contactIds ' + contactIds);
		String whereClause = ' WHERE contact__c in';
		return retrieveMarketingCampaignLVM(contactIds, whereClause);
	}

	private static List<MarketingCampaignsLVMWrapper> retrieveMarketingCampaignLVM(List<String> ids, String whereClause) {

		String soql1 = ' SELECT ExternalId, ';
	   	soql1 += ' c_acct_type_cd_fk__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Name, ';
	  	soql1 += ' c_acct_type_cd_fk__r.Description__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Quality_code__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Type_category__c,  ';
	  	soql1 += ' c_acct_type_cd_fk__r.Type_Id__c, ';
	  	soql1 += ' contact__c ';
	  	soql1 += ' FROM marketing_lvm__x  ';
	  	soql1 += whereClause + ': ids';

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
	  	soql2 += whereClause + ': ids';

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

	  	global MarketingCampaignWrapper(){

	  	}

	  	//global void updateMcw(){

	  	//}
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