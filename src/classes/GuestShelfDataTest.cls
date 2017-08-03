@isTest
private class GuestShelfDataTest {
	
	@testSetup  static void testSetup() {
		CaesarsSetup__c csetup = new CaesarsSetup__c(
			Name = 'Contact',
			turnOffContactTrigger__c = false
			);
		insert csetup;

		Account acct = new Account(
			Name = 'Account1',
			winet_id__c = '111');
		insert acct;

		Account_Type_Code__c atc = new Account_Type_Code__c(
			Name = 'atcName',
			Description__c = 'atcDesc',			
			Quality_code__c = 'A',
			Type_category__c = 'BCD'
			);
		insert atc;

		Account propAcct = new Account(
			Name = 'DomPropAcctName'
			);
		insert propAcct;

		Pod__c pod = new Pod__c(
			POD_Name__c = 'Heartland POD'
			);
		insert pod;

		Market__c mkt = new Market__c(
			Name = 'mktName',
	  		Active_Flag__c = true,
	  		Description__c = 'mktDesc',
	  		Time_Zone__c = 'PST',
	  		Market_Code__c = 'ACM',
	  		POD__c = pod.Id);
		insert mkt;

		Contact c = new Contact (
			FirstName = 'MyFirstName',
			LastName = 'MyLastName',
			AccountId = acct.id
			);
		insert c;
	}

	@isTest static void testGetGuestShelfCampaignsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		String atcId = [SELECT Id FROM Account_Type_Code__c LIMIT 1].id;
		String acctPropId = [SELECT Id FROM Account WHERE Name = 'DomPropAcctName' LIMIT 1].id;
		String mktId = [SELECT Id FROM Market__c LIMIT 1].id;
		Test.startTest();
	    marketing_campaigns__x mockedRequest = new marketing_campaigns__x(
	        contact__c = cId,
	        c_acct_type_cd_fk__c = atcId,
	        c_dom_cd_prop_fk__c = acctPropId,
	        c_dom_market_cd_fk__c = mktId
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestShelfDataCC.mockedRequests.add(mockedRequest);
	    List<GuestShelfDataCC.MarketingCampaignWrapper> requestList = 
	    		GuestShelfDataCC.retrieveMarketingCampaignByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Marketing Campaign record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Marketing Campaign record should be for the contact'); 
	
	}

	@isTest static void testGetGuestShelfCampaignsPropMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		String atcId = [SELECT Id FROM Account_Type_Code__c LIMIT 1].id;
		String acctPropId = [SELECT Id FROM Account WHERE Name = 'DomPropAcctName' LIMIT 1].id;
		String mktId = [SELECT Id FROM Market__c LIMIT 1].id;
		Test.startTest();
	    marketing_campaigns_properties__x mockedPropRequest = new marketing_campaigns_properties__x(
	        contact__c = cId,
	        c_acct_type_cd_fk__c = atcId,
	        c_dom_cd_prop_fk__c = acctPropId,
	        c_dom_market_cd_fk__c = mktId
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	   GuestShelfDataCC.mockedPropRequests.add(mockedPropRequest);
	    List<GuestShelfDataCC.MarketingCampaignPropertyWrapper> requestList = 
	    		GuestShelfDataCC.retrieveMarketingCampaignPropByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);


	    System.assertEquals(1, requestList.size(), 'There should be 1 Marketing Campaign Property record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Marketing Campaign Property record should be for the contact'); 
	
	}

	@isTest static void testGetGuestShelfCampaignsWeeklyMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		String atcId = [SELECT Id FROM Account_Type_Code__c LIMIT 1].id;
		String mktId = [SELECT Id FROM Market__c LIMIT 1].id;
		Test.startTest();
	    marketing_campaigns_weekly__x mockedWeeklyRequest = new marketing_campaigns_weekly__x(
	        contact__c = cId,
	        c_acct_type_cd_fk__c = atcId,
	        c_prop_market_cd_fk__c = mktId
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	   GuestShelfDataCC.mockedWeeklyRequests.add(mockedWeeklyRequest);
	    List<GuestShelfDataCC.MarketingCampaignWeeklyWrapper> requestList = 
	    		GuestShelfDataCC.retrieveWeeklyByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);


	    System.assertEquals(1, requestList.size(), 'There should be 1 Marketing Campaign Weekly record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Marketing Campaign Weekly record should be for the contact'); 
	
	}

	@isTest static void testGetGuestShelfCampaignsLVMMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		String atcId = [SELECT Id FROM Account_Type_Code__c LIMIT 1].id;
		String mktId = [SELECT Id FROM Market__c LIMIT 1].id;
		Test.startTest();
	    marketing_lvm__x mockedLVMRequest = new marketing_lvm__x(
	        contact__c = cId,
	        c_acct_type_cd_fk__c = atcId,
	        c_prop_market_cd_fk__c = mktId
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	   GuestShelfDataCC.mockedLVMRequests.add(mockedLVMRequest);
	    List<GuestShelfDataCC.MarketingCampaignsLVMWrapper> requestList = 
	    		GuestShelfDataCC.retrieveLVMByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);


	    System.assertEquals(1, requestList.size(), 'There should be 1 Marketing LVM record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Marketing LVM record should be for the contact'); 
	
	}

	@isTest static void testGetGuestShelfCampaignsEnterpriseMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;

		Test.startTest();
	    enterprise_campaign__x mockedEntRequest = new enterprise_campaign__x(
	        contact__c = cId
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	   GuestShelfDataCC.mockedEnterpriseRequests.add(mockedEntRequest);
	    List<GuestShelfDataCC.EnterpriseCampaignWrapper> requestList = 
	    		GuestShelfDataCC.retrieveEnterpriseByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);


	    System.assertEquals(1, requestList.size(), 'There should be 1 Enterprise Campaign] record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Enterprise Campaign record should be for the contact'); 
	
	}

	@isTest static void testGetGuestShelfCampaignsDetMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		String atcId = [SELECT Id FROM Account_Type_Code__c LIMIT 1].id;
		String acctPropId = [SELECT Id FROM Account WHERE Name = 'DomPropAcctName' LIMIT 1].id;
		String mktId = [SELECT Id FROM Market__c LIMIT 1].id;
		Test.startTest();
	    marketing_campaigns__x mockedRequest = new marketing_campaigns__x(
	        contact__c = cId,
	        c_acct_type_cd_fk__c = atcId,
	        c_dom_cd_prop_fk__c = acctPropId,
	        c_dom_market_cd_fk__c = mktId,
	        ExternalId = '1'
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('1');

	    GuestShelfDataCC.mockedRequests.add(mockedRequest);
	    List<GuestShelfDataCC.MarketingCampaignWrapper> requestList = 
	    		GuestShelfDataCC.retrieveMarketingCampaignDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Marketing Campaign record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Marketing Campaign record should be for the contact'); 
	
	}

	@isTest static void testGetGuestShelfCampaignsPropDetMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		String atcId = [SELECT Id FROM Account_Type_Code__c LIMIT 1].id;
		String acctPropId = [SELECT Id FROM Account WHERE Name = 'DomPropAcctName' LIMIT 1].id;
		String mktId = [SELECT Id FROM Market__c LIMIT 1].id;
		Test.startTest();
	    marketing_campaigns_properties__x mockedPropRequest = new marketing_campaigns_properties__x(
	        contact__c = cId,
	        c_acct_type_cd_fk__c = atcId,
	        c_dom_cd_prop_fk__c = acctPropId,
	        c_dom_market_cd_fk__c = mktId,
     		ExternalId = '1'
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('1');

	   GuestShelfDataCC.mockedPropRequests.add(mockedPropRequest);
	    List<GuestShelfDataCC.MarketingCampaignPropertyWrapper> requestList = 
	    		GuestShelfDataCC.retrieveMarketingCampaignPropDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);


	    System.assertEquals(1, requestList.size(), 'There should be 1 Marketing Campaign Property record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Marketing Campaign Property record should be for the contact'); 
	
	}

	@isTest static void testGetGuestShelfCampaignsWeeklyDetMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		String atcId = [SELECT Id FROM Account_Type_Code__c LIMIT 1].id;
		String mktId = [SELECT Id FROM Market__c LIMIT 1].id;
		Test.startTest();
	    marketing_campaigns_weekly__x mockedWeeklyRequest = new marketing_campaigns_weekly__x(
	        contact__c = cId,
	        c_acct_type_cd_fk__c = atcId,
	        c_prop_market_cd_fk__c = mktId,
	    	ExternalId = '1'
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('1');

	   GuestShelfDataCC.mockedWeeklyRequests.add(mockedWeeklyRequest);
	    List<GuestShelfDataCC.MarketingCampaignWeeklyWrapper> requestList = 
	    		GuestShelfDataCC.retrieveWeeklyDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);


	    System.assertEquals(1, requestList.size(), 'There should be 1 Marketing Campaign Weekly record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Marketing Campaign Weekly record should be for the contact'); 
	
	}

	@isTest static void testGetGuestShelfCampaignsLVMDetMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		String atcId = [SELECT Id FROM Account_Type_Code__c LIMIT 1].id;
		String mktId = [SELECT Id FROM Market__c LIMIT 1].id;
		Test.startTest();
	    marketing_lvm__x mockedLVMRequest = new marketing_lvm__x(
	        contact__c = cId,
	        c_acct_type_cd_fk__c = atcId,
	        c_prop_market_cd_fk__c = mktId,
	    	ExternalId = '1'
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('1');

	   GuestShelfDataCC.mockedLVMRequests.add(mockedLVMRequest);
	    List<GuestShelfDataCC.MarketingCampaignsLVMWrapper> requestList = 
	    		GuestShelfDataCC.retrieveLVMDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);


	    System.assertEquals(1, requestList.size(), 'There should be 1 Marketing LVM record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Marketing LVM record should be for the contact'); 
	
	}

	@isTest static void testGetGuestShelfCampaignsEnterpriseDetMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;

		Test.startTest();
	    enterprise_campaign__x mockedEntRequest = new enterprise_campaign__x(
	        contact__c = cId,
	    	ExternalId = '1'
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('1');

	   GuestShelfDataCC.mockedEnterpriseRequests.add(mockedEntRequest);
	    List<GuestShelfDataCC.EnterpriseCampaignWrapper> requestList = 
	    		GuestShelfDataCC.retrieveEnterpriseDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);


	    System.assertEquals(1, requestList.size(), 'There should be 1 Enterprise Campaign] record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Enterprise Campaign record should be for the contact'); 
	
	}
}