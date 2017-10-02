@isTest
private class GuestHotelFolioTest {
	
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

	@isTest static void testActivityMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    lms_hotel_activity__x mockedRequest = new lms_hotel_activity__x(
	        contact1__c = cId
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestHotelFolioDataCC.mockedActivity.add(mockedRequest);
	    List<GuestHotelFolioDataCC.ActivityWrapper> requestList = 
	    		GuestHotelFolioDataCC.retrieveHotelActivityByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Activity record'); 
	    System.assertEquals(cId, requestList[0].contact1, 'The Activity record should be for the contact'); 
	
	}

	@isTest static void testActivityVEDWMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    guest_hotel_activity_vedw__x mockedVEDWRequest = new guest_hotel_activity_vedw__x(
	        contact__c = cId
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestHotelFolioDataCC.mockedActivityVEDW.add(mockedVEDWRequest);
	    List<GuestHotelFolioDataCC.ActivityVEDWWrapper> requestList = 
	    		GuestHotelFolioDataCC.retrieveHotelActivityVEDWByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Activity VEDW record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Activity VEDW record should be for the contact'); 
	
	}

	@isTest static void testFolioHeaderMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		lms_hotel_activity__x mockedRequest = new lms_hotel_activity__x(
			contact1__c = cId,
	        ExternalId = '111' 
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestHotelFolioDataCC.mockedActivity.add(mockedRequest);
	    List<GuestHotelFolioDataCC.ActivityWrapper> requestList = 
	    		GuestHotelFolioDataCC.retrieveHotelActivityByContacts(contactIds);

		Test.startTest();
	    lms_folio_hdr__x mockedHdrRequest = new lms_folio_hdr__x(
	        lms_hotel_activity_fk__c = '111'
	    );

	    GuestHotelFolioDataCC.mockedFolioHeader.add(mockedHdrRequest);
	    List<GuestHotelFolioDataCC.FolioHeaderWrapper> requestListHdr = 
	    		GuestHotelFolioDataCC.retrieveFolioHeaderByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestListHdr ' + requestListHdr);

	    System.assertEquals(1, requestListHdr.size(), 'There should be 1 Folio Header record'); 
	    System.assertEquals('111', requestListHdr[0].lms_hotel_activity_fk, 'The Folio Header record should be for the Hotel Activity'); 
	}

	@isTest static void testFolioDetailsMock() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		lms_hotel_activity__x mockedRequest = new lms_hotel_activity__x(
			contact1__c = cId,
	        ExternalId = '111' 
	    );

	    List<Id> contactIds = new List<Id>();
	    contactIds.add(cId);

	    GuestHotelFolioDataCC.mockedActivity.add(mockedRequest);
	    List<GuestHotelFolioDataCC.ActivityWrapper> requestList = 
	    		GuestHotelFolioDataCC.retrieveHotelActivityByContacts(contactIds);

	      lms_folio_hdr__x mockedHdrRequest = new lms_folio_hdr__x(
	        lms_hotel_activity_fk__c = '111',
	        ExternalId = '222'
	    );

	    GuestHotelFolioDataCC.mockedFolioHeader.add(mockedHdrRequest);
	    List<GuestHotelFolioDataCC.FolioHeaderWrapper> requestListHdr = 
	    		GuestHotelFolioDataCC.retrieveFolioHeaderByContacts(contactIds);		

		Test.startTest();
	    lms_folio_dtl__x mockedDtlRequest = new lms_folio_dtl__x(
	        lms_folio_hdr_fk__c = '222'
	    );

	    GuestHotelFolioDataCC.mockedFolioDetails.add(mockedDtlRequest);
	    List<GuestHotelFolioDataCC.FolioDetailsWrapper> requestListDtl = 
	    		GuestHotelFolioDataCC.retrieveFolioDetailsByContacts(contactIds);
	    Test.stopTest();

	    system.debug('*** requestListDtl ' + requestListDtl);

	    System.assertEquals(1, requestListDtl.size(), 'There should be 1 Folio Details record'); 
	    System.assertEquals('222', requestListDtl[0].lms_folio_hdr_fk, 'The Folio Details record should be for the Folio Header'); 
	}

	@isTest static void testXref() {
		List<Id> contactIds = new List<Id>();	    
		for (Contact c : [SELECT Id FROM Contact WHERE FirstName in ('MyFirstName', 'MyFirstNameX') LIMIT 2]){
			contactIds.add(c.Id);
		}

		String winetId = [SELECT winet_Id__c FROM Contact WHERE FirstName in ('MyFirstName') LIMIT 1].winet_Id__c;
		Test.startTest();
	    caesars_gst_id_xref__x mockedXrefX = new caesars_gst_id_xref__x(
	        i_xref_dmid__c = '333',
	        i_dmid__c = '111'
	    );   

	    GuestHotelFolioDataCC.mockedXref.add(mockedXrefX);
	    List<String> requestListX = 
	    		GuestHotelFolioDataCC.getXrefIds(contactIds);
	    Test.stopTest();

	    system.debug('*** requestListX ' + requestListX);

	    System.assertEquals(3, requestListX.size(), 'There should be 3 contacts'); 
	
	}

	@isTest static void testActivityMockDetails() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    lms_hotel_activity__x mockedRequest = new lms_hotel_activity__x(
	        contact1__c = cId,
	        ExternalId = '111'
	    );

	  	List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestHotelFolioDataCC.mockedActivity.add(mockedRequest);
	    List<GuestHotelFolioDataCC.ActivityWrapper> requestList = 
	    		GuestHotelFolioDataCC.retrieveHotelActivityDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Activity record'); 
	    System.assertEquals(cId, requestList[0].contact1, 'The Activity record should be for the contact'); 
	
	}

	@isTest static void testActivityVEDWMockDetails() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		Test.startTest();
	    guest_hotel_activity_vedw__x mockedVEDWRequest = new guest_hotel_activity_vedw__x(
	        contact__c = cId,
	        ExternalId = '111'
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

	    GuestHotelFolioDataCC.mockedActivityVEDW.add(mockedVEDWRequest);
	    List<GuestHotelFolioDataCC.ActivityVEDWWrapper> requestList = 
	    		GuestHotelFolioDataCC.retrieveHotelActivityVEDWDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestList ' + requestList);

	    System.assertEquals(1, requestList.size(), 'There should be 1 Activity VEDW record'); 
	    System.assertEquals(cId, requestList[0].contact, 'The Activity VEDW record should be for the contact'); 
	
	}

	@isTest static void testFolioHeaderMockDetails() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		lms_hotel_activity__x mockedRequest = new lms_hotel_activity__x(
			contact1__c = cId,
	        ExternalId = '111' 
	    );

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

		Test.startTest();
	    lms_folio_hdr__x mockedHdrRequest = new lms_folio_hdr__x(
	        lms_hotel_activity_fk__c = '222'
	    );

	    GuestHotelFolioDataCC.mockedFolioHeader.add(mockedHdrRequest);
	    List<GuestHotelFolioDataCC.FolioHeaderWrapper> requestListHdr = 
	    		GuestHotelFolioDataCC.retrieveFolioHeaderDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestListHdr ' + requestListHdr);

	    System.assertEquals(1, requestListHdr.size(), 'There should be 1 Folio Header record'); 
	    System.assertEquals('222', requestListHdr[0].lms_hotel_activity_fk, 'The Folio Header record should be for the Hotel Activity'); 
	}

	@isTest static void testFolioDetailsMockDetails() {
		String cId = [SELECT Id FROM Contact LIMIT 1].id;
		lms_hotel_activity__x mockedRequest = new lms_hotel_activity__x(
			contact1__c = cId,
	        ExternalId = '111' 
	    );	

	    List<String> externalIds = new List<String>();
	    externalIds.add('111');

		Test.startTest();
	    lms_folio_dtl__x mockedDtlRequest = new lms_folio_dtl__x(
	        lms_folio_hdr_fk__c = '222'
	    );

	    GuestHotelFolioDataCC.mockedFolioDetails.add(mockedDtlRequest);
	    List<GuestHotelFolioDataCC.FolioDetailsWrapper> requestListDtl = 
	    		GuestHotelFolioDataCC.retrieveFolioDetailsDetails(externalIds);
	    Test.stopTest();

	    system.debug('*** requestListDtl ' + requestListDtl);

	    System.assertEquals(1, requestListDtl.size(), 'There should be 1 Folio Details record'); 
	    System.assertEquals('222', requestListDtl[0].lms_folio_hdr_fk, 'The Folio Details record should be for the Folio Header'); 
	}
}