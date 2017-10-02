@isTest
private class GuestContactMasterTest {
	
	@testSetup  static void testSetup() {
		CaesarsSetup__c csetup = new CaesarsSetup__c(
			Name = 'Contact',
			turnOffContactTrigger__c = false
			);
		insert csetup;

		Account acct = AccountBuilder.buildAccount()
		.withName('Account1')
		.withWinetId('111')
		.get();

		insert acct;
		
		Contact c = ContactBuilder.buildContact()
		.withFirstName('MyFirstName')
		.withLastName('MyLastName')
		.withWinetId('111')
		.withAccount(acct.id).get();
		
		insert c;

		Contact cXref = ContactBuilder.buildContact()
		.withFirstName('MyFirstNameX')
		.withLastName('MyLastNameX')
		.withWinetId('333')
		.withAccount(acct.id).get();

		insert cXref;
	}

	@isTest static void testAddressMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedAddr = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Address'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedAddress.add(mockedAddr);
	    List<GuestContactMasterCC.AddressWrapper> requestList = 
	    		GuestContactMasterCC.retrieveAddressByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Address record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Address record should be for the contact'); 
	
	}

	@isTest static void testEmailMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedEm = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Email'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedEmail.add(mockedEm);
	    List<GuestContactMasterCC.EmailWrapper> requestList = 
	    		GuestContactMasterCC.retrieveEmailByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Email record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Email record should be for the contact'); 
	
	}

	@isTest static void testPrefMarketMailMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedPMM = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'PrefMarketMail'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedPrefMarketMail.add(mockedPMM);
	    List<GuestContactMasterCC.PrefMarketMailWrapper> requestList = 
	    		GuestContactMasterCC.retrievePrefMarketMailByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Pref Market Mail record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Pref Market Mail record should be for the contact'); 
	
	}

	@isTest static void testPrefPropMailMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedPPM = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'PrefPropMail'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedPrefPropMail.add(mockedPPM);
	    List<GuestContactMasterCC.PrefPropMailWrapper> requestList = 
	    		GuestContactMasterCC.retrievePrefPropMailByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Pref Prop Mail record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Pref Prop Mail record should be for the contact'); 
	
	}

	@isTest static void testNxtGenAddressMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedNxtAddr = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'NxtgenAddress'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedNxtGenAddress.add(mockedNxtAddr);
	    List<GuestContactMasterCC.NxtgenAddressWrapper> requestList = 
	    		GuestContactMasterCC.retrieveNxtgenAddressByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 NxtgenAddress record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The NxtgenAddress record should be for the contact'); 
	
	}

	@isTest static void testNxtGenEmailMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedNxtEmail = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'NxtgenEmail'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedNxtGenEmail.add(mockedNxtEmail);
	    List<GuestContactMasterCC.NxtgenEmailWrapper> requestList = 
	    		GuestContactMasterCC.retrieveNxtgenEmailByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 NxtgenEmail record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The NxtgenEmail record should be for the contact'); 
	
	}

	@isTest static void testNxtGenContactChanMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedNxtCC = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'NxtgenEmail'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedNxtGenContactChan.add(mockedNxtCC);
	    List<GuestContactMasterCC.NxtgenContactChanWrapper> requestList = 
	    		GuestContactMasterCC.retrieveNxtgenContactChanByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 NxtgenContactChan record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The NxtgenContactChan record should be for the contact'); 
	
	}

	@isTest static void testNxtGenPhoneMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedNxtPhone = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'NxtgenPhone'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedNxtGenPhone.add(mockedNxtPhone);
	    List<GuestContactMasterCC.NxtgenPhoneWrapper> requestList = 
	    		GuestContactMasterCC.retrieveNxtgenPhoneByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 NxtgenPhone record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The NxtgenPhone record should be for the contact'); 
	
	}

	@isTest static void testNxtGenToDoMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedNxtToDo = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'NxtgenToDo'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedNxtGenToDo.add(mockedNxtToDo);
	    List<GuestContactMasterCC.NxtgenToDoWrapper> requestList = 
	    		GuestContactMasterCC.retrieveNxtgenToDoByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 NxtgenToDo record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The NxtgenToDo record should be for the contact'); 
	
	}

	@isTest static void testTierScoreMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedTier = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'TierScore'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedTierScore.add(mockedTier);
	    List<GuestContactMasterCC.TierScoreWrapper> requestList = 
	    		GuestContactMasterCC.retrieveTierScoreByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 TierScore record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The TierScore record should be for the contact'); 
	
	}

	@isTest static void testCasinoMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedCas = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Casino'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedCasino.add(mockedCas);
	    List<GuestContactMasterCC.CasinoWrapper> requestList = 
	    		GuestContactMasterCC.retrieveCasinoByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Casino record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Casino record should be for the contact'); 
	
	}

	@isTest static void testRepcodeMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedrCode = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Repcode'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedRepcode.add(mockedrCode);
	    List<GuestContactMasterCC.RepcodeWrapper> requestList = 
	    		GuestContactMasterCC.retrieveRepcodeByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Repcode record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Repcode record should be for the contact'); 
	
	}

	@isTest static void testAcquisitionMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedAcq = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Acquisition'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedAcquisition.add(mockedAcq);
	    List<GuestContactMasterCC.AcquisitionWrapper> requestList = 
	    		GuestContactMasterCC.retrieveAcquisitionByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Acquisition record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Repcode Acquisition should be for the contact'); 
	
	}

	@isTest static void testAliasMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedAcq = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Alias'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedAlias.add(mockedAcq);
	    List<GuestContactMasterCC.AliasWrapper> requestList = 
	    		GuestContactMasterCC.retrieveAliasByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Alias record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The  Alias should be for the contact'); 
	
	}

	@isTest static void testEthnicityAppendMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedAcq = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'EthnicityAppend'
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedEthnicityAppend.add(mockedAcq);
	    List<GuestContactMasterCC.EthnicityAppendWrapper> requestList = 
	    		GuestContactMasterCC.retrieveEthnicityAppendByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 EthnicityAppend record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The  EthnicityAppend should be for the contact'); 
	
	}

	@isTest static void testAIdXrefMock() {
		String wId = [SELECT Id, winet_Id__c FROM Contact LIMIT 1].winet_Id__c;
		String cId = [SELECT Id, winet_Id__c FROM Contact LIMIT 1].id;
		Test.startTest();
	    caesars_gst_id_xref__x mockedIx = new caesars_gst_id_xref__x(
	        i_dmid__c = wId
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedIDXref.add(mockedIx);
	    List<GuestContactMasterCC.IdXrefWrapper> requestList = 
	    		GuestContactMasterCC.retrieveIdXrefByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 IdXref record'); 
	    System.assertEquals(wId, requestList[0].i_dmid, 'The IdXref should be for the contact'); 
	
	}

	@isTest static void testAConsxrefMock() {
		String wId = [SELECT Id, winet_Id__c FROM Contact LIMIT 1].winet_Id__c;
		String cId = [SELECT Id, winet_Id__c FROM Contact LIMIT 1].id;
		Test.startTest();
	    gst_cons_xref__x mockedIx = new gst_cons_xref__x(
	        i_dmid__c = wId
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestContactMasterCC.mockedConsXref.add(mockedIx);
	    List<GuestContactMasterCC.ConsXrefWrapper> requestList = 
	    		GuestContactMasterCC.retrieveConsXrefByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 ConsXref record'); 
	    System.assertEquals(wId, requestList[0].i_dmid, 'The ConsXref should be for the contact'); 
	
	}


	@isTest static void testAddressDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedAddr = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Address',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedAddress.add(mockedAddr);
	    List<GuestContactMasterCC.AddressWrapper> requestList = 
	    		GuestContactMasterCC.retrieveAddressDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Address record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Address record should be for the contact'); 
	
	}

	@isTest static void testEmailDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedEm = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Email',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedEmail.add(mockedEm);
	    List<GuestContactMasterCC.EmailWrapper> requestList = 
	    		GuestContactMasterCC.retrieveEmailDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Email record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Email record should be for the contact'); 
	
	}

	@isTest static void testPrefMarketMailDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedPMM = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'PrefMarketMail',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedPrefMarketMail.add(mockedPMM);
	    List<GuestContactMasterCC.PrefMarketMailWrapper> requestList = 
	    		GuestContactMasterCC.retrievePrefMarketMailDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Pref Market Mail record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Pref Market Mail record should be for the contact'); 
	
	}

	@isTest static void testPrefPropMailDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedPPM = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'PrefPropMail',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedPrefPropMail.add(mockedPPM);
	    List<GuestContactMasterCC.PrefPropMailWrapper> requestList = 
	    		GuestContactMasterCC.retrievePrefPropMailDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Pref Prop Mail record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Pref Prop Mail record should be for the contact'); 
	
	}

	@isTest static void testNxtGenAddressDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedNxtAddr = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'NxtgenAddress',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedNxtGenAddress.add(mockedNxtAddr);
	    List<GuestContactMasterCC.NxtgenAddressWrapper> requestList = 
	    		GuestContactMasterCC.retrieveNxtgenAddressDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 NxtgenAddress record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The NxtgenAddress record should be for the contact'); 
	
	}

	@isTest static void testNxtGenEmailDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedNxtEmail = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'NxtgenEmail',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');


	    GuestContactMasterCC.mockedNxtGenEmail.add(mockedNxtEmail);
	    List<GuestContactMasterCC.NxtgenEmailWrapper> requestList = 
	    		GuestContactMasterCC.retrieveNxtgenEmailDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 NxtgenEmail record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The NxtgenEmail record should be for the contact'); 
	
	}

	@isTest static void testNxtGenContactChanDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedNxtCC = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'NxtgenEmail',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedNxtGenContactChan.add(mockedNxtCC);
	    List<GuestContactMasterCC.NxtgenContactChanWrapper> requestList = 
	    		GuestContactMasterCC.retrieveNxtgenContactChanDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 NxtgenContactChan record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The NxtgenContactChan record should be for the contact'); 
	
	}

	@isTest static void testNxtGenPhoneDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedNxtPhone = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'NxtgenPhone',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedNxtGenPhone.add(mockedNxtPhone);
	    List<GuestContactMasterCC.NxtgenPhoneWrapper> requestList = 
	    		GuestContactMasterCC.retrieveNxtgenPhoneDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 NxtgenPhone record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The NxtgenPhone record should be for the contact'); 
	
	}

	@isTest static void testNxtGenToDoDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedNxtToDo = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'NxtgenToDo',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');


	    GuestContactMasterCC.mockedNxtGenToDo.add(mockedNxtToDo);
	    List<GuestContactMasterCC.NxtgenToDoWrapper> requestList = 
	    		GuestContactMasterCC.retrieveNxtgenToDoDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 NxtgenToDo record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The NxtgenToDo record should be for the contact'); 
	
	}

	@isTest static void testTierScoreDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedTier = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'TierScore',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedTierScore.add(mockedTier);
	    List<GuestContactMasterCC.TierScoreWrapper> requestList = 
	    		GuestContactMasterCC.retrieveTierScoreDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 TierScore record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The TierScore record should be for the contact'); 
	
	}

	@isTest static void testCasinoDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedCas = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Casino',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedCasino.add(mockedCas);
	    List<GuestContactMasterCC.CasinoWrapper> requestList = 
	    		GuestContactMasterCC.retrieveCasinoDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Casino record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Casino record should be for the contact'); 
	
	}

	@isTest static void testRepcodeDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedrCode = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Repcode',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedRepcode.add(mockedrCode);
	    List<GuestContactMasterCC.RepcodeWrapper> requestList = 
	    		GuestContactMasterCC.retrieveRepcodeDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Repcode record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Repcode record should be for the contact'); 
	
	}

	@isTest static void testAcquisitionDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedAcq = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Acquisition',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedAcquisition.add(mockedAcq);
	    List<GuestContactMasterCC.AcquisitionWrapper> requestList = 
	    		GuestContactMasterCC.retrieveAcquisitionDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Acquisition record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Repcode Acquisition should be for the contact'); 
	
	}

	@isTest static void testAliasDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedAcq = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'Alias',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedAlias.add(mockedAcq);
	    List<GuestContactMasterCC.AliasWrapper> requestList = 
	    		GuestContactMasterCC.retrieveAliasDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Alias record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Alias should be for the contact'); 
	
	}

	@isTest static void testEthnicityAppendDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    Customer_Info_External_c__x mockedAcq = new Customer_Info_External_c__x(
	        contact__c = cId,
	        recordtype__c = 'EthnicityAppend',
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestContactMasterCC.mockedEthnicityAppend.add(mockedAcq);
	    List<GuestContactMasterCC.EthnicityAppendWrapper> requestList = 
	    		GuestContactMasterCC.retrieveEthnicityAppendByContacts(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 EthnicityAppend record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The  EthnicityAppend should be for the contact'); 
	
	}


}