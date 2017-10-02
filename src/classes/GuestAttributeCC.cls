global with sharing class GuestAttributeCC extends GuestSubjectDataBaseCC {
    global GuestAttributeCC() {}
    
    @TestVisible private static ContactAttributesWrapper mockContactAttributes = new ContactAttributesWrapper();

	@RemoteAction
	@AuraEnabled
	global static ContactAttributesWrapper retrieveContactAttributesByContacts(String contactId) {
		system.debug('*** contactId ' + contactId);
		return (new GuestAttributeCC()).retrieveGuestAttributes(contactId);
	}
    
    private ContactAttributesWrapper retrieveGuestAttributes(String contactId) {
		ContactAttributesWrapper result = new ContactAttributesWrapper();
		result.conOtherInfo = getContactOtherInfo(contactId);
		result.relatedInfoList = getRelatedInfoList(contactId);
		result.summariesAct = getSummaryActivities(contactId);
		result.trProgInfo = getTRProgramInfo(contactId);
		return result;
    }
    
    private ContactOtherInfo getContactOtherInfo(String contactId) {
    		ContactOtherInfo result = new ContactOtherInfo();
    	    	result.mainAddressInfo = getMainAddressInfo(contactId);
		result.nonPreferrdAddressList = getNonPreferredAddressList(contactId);
		result.emailInfoList = getEmailInfoList(contactId);
		result.phoneInfoList = getPhoneInfoList(contactId);
    		return result;
    }
    
    private AddressInfo getMainAddressInfo(String contactId) {
    	
    		AddressInfo addrInfo = new AddressInfo();
    		addrInfo.addressInfoLabel = 'Main Address';
    		addrInfo.addressDetails = 'main address details';
    	
    		return addrInfo;
    		/*
    		List<String> recordTypes = new List<String>{'Address'};
		String soql1 = soqlFromFieldSet(SOBjectType.customer_info_external_c__x.FieldSets.Address,
			'customer_info_external_c__x',recordTypes);
		soql1 += ' and contact__c in :ids';
		system.debug('*** soql1 ' + soql1);
		List<String> ids = new List<String>();
		ids.add(contactId);
		
		/*
		List<customer_info_external_c__x> pcsInterestList = (!mockedPcsInterest.isEmpty()) ? mockedPcsInterest : Database.query(soql1);
	  	system.debug('*** pcsInterestList ' + pcsInterestList );
		Map<String, PcsInterestWrapper> pcsInterestMap = new Map<String, PcsInterestWrapper> ();
	  	updatePcsInterest (pcsInterestMap, pcsInterestList, '1');
	  	system.debug('*** pcsInterestList return ' + pcsInterestMap.values());
    		*/
    		
    		return null;
    }
    
	private List<AddressInfo> getNonPreferredAddressList(String contactId) {
		List<AddressInfo> result = new List<AddressInfo>();
		AddressInfo addrInfo1 = new AddressInfo();
		addrInfo1.addressInfoLabel = 'Work Address';
    		addrInfo1.addressDetails = 'work address details';
		result.add(addrInfo1);
		
		AddressInfo addrInfo2 = new AddressInfo();
		addrInfo2.addressInfoLabel = 'Cottage Address';
    		addrInfo2.addressDetails = 'Cottage address details';
		result.add(addrInfo2);
		
    		return result;
    }    
    
    private List<EmailInfo> getEmailInfoList(String contactId) {
    		List<EmailInfo> result = new List<EmailInfo>();
		EmailInfo emailInfo1 = new EmailInfo();
		emailInfo1.emailInfoLabel = 'Person Email';
    		emailInfo1.emailAddress = 'benjamin_lau@yahoo.com';
		result.add(emailInfo1);
		
		EmailInfo emailInfo2 = new EmailInfo();
		emailInfo2.emailInfoLabel = 'Work Email';
    		emailInfo2.emailAddress = 'blau@yahoo.com';
		result.add(emailInfo2);
		
    		return result;
    }    
    
    private List<PhoneInfo> getPhoneInfoList(String contactId) {
    		List<PhoneInfo> result = new List<PhoneInfo>();
		PhoneInfo phoneInfo1 = new PhoneInfo();
		phoneInfo1.phoneInfoLabel = 'Mobile';
    		phoneInfo1.phoneNumber = '310-251-6883';
		result.add(phoneInfo1);
		
		PhoneInfo phoneInfo2 = new PhoneInfo();
		phoneInfo2.phoneInfoLabel = 'Work';
    		phoneInfo2.phoneNumber = '310-421-2882';
		result.add(phoneInfo2);
		
    		return result;
    }
    
    private List<RelatedInfo> getRelatedInfoList(String contactId) {
    		List<RelatedInfo> result = new List<RelatedInfo>();
		RelatedInfo relatedInfo1 = new RelatedInfo();
		relatedInfo1.name = 'Minnie Mouse';
    		relatedInfo1.contactId = '1234567890';
    		relatedInfo1.reasonForRelationship = 'is Hotel Stay With';
		result.add(relatedInfo1);
		
		RelatedInfo relatedInfo2 = new RelatedInfo();
		relatedInfo2.name = 'Minnie Mouse';
    		relatedInfo2.contactId = '1234567890';
    		relatedInfo2.reasonForRelationship = 'is Associated as Spouse';
		result.add(relatedInfo2);
		
    		return result;
    }
    
    private SummaryActivities getSummaryActivities(String contactId) {
    		SummaryActivities result = new SummaryActivities(); 		
    		result.numMarketsRecentlyActive = '3';
    		result.numRecordsInShelfMarket = '5';
    		result.numUniquePDBTripMarketCode = '8';
    		result.numPropsRecentlyActive = '10';
    		result.numRecordsInShelfProp = '12';
    		return result;
    }
    
    private TRProgramInfo getTRProgramInfo(String contactId) {
    		TRProgramInfo result = new TRProgramInfo();
    		result.tierExporeDate = '12/31/2017';
    		result.CYTierCreditLabel = '7 STARS DIAMONDS';
    		result.CYTierCreditBalance = '100,000';
    		result.currentRCBankBalance = '1,000,000';
    		return result;
    }
    
    global class ContactAttributesWrapper {
		
		@AuraEnabled global ContactOtherInfo conOtherInfo { get; set; }  
		@AuraEnabled global List<RelatedInfo> relatedInfoList;
    		@AuraEnabled global SummaryActivities summariesAct;
    		@AuraEnabled global TRProgramInfo trProgInfo;
    }
    
    global class ContactOtherInfo {
    		@AuraEnabled global AddressInfo mainAddressInfo;
		@AuraEnabled global List<AddressInfo> nonPreferrdAddressList;
		@AuraEnabled global List<EmailInfo> emailInfoList;
		@AuraEnabled global List<PhoneInfo> phoneInfoList;
    }
    
    global class AddressInfo {
    		@AuraEnabled global String addressInfoLabel;
		@AuraEnabled global String addressDetails;
    }
    
    global class EmailInfo {
    		@AuraEnabled global String emailInfoLabel;
		@AuraEnabled global String emailAddress;
    }
    
    global class PhoneInfo {
    		@AuraEnabled global String phoneInfoLabel;
		@AuraEnabled global String phoneNumber;
    }
    
    global class RelatedInfo {
    		@AuraEnabled global String name;
    		@AuraEnabled global String contactId;
    		@AuraEnabled global String reasonForRelationship;    	
    }
    
    global class SummaryActivities {
    		@AuraEnabled global String numMarketsRecentlyActive;
    		@AuraEnabled global String numRecordsInShelfMarket;
    		@AuraEnabled global String numUniquePDBTripMarketCode;
    		
    		@AuraEnabled global String numPropsRecentlyActive;
    		@AuraEnabled global String numRecordsInShelfProp;
    }
    
    global class TRProgramInfo  {
    		@AuraEnabled global String tierExporeDate;
    		@AuraEnabled global String CYTierCreditLabel;
    		@AuraEnabled global String CYTierCreditBalance;
    		@AuraEnabled global String currentRCBankBalance;
    }
    
    global class AllPropInfo {
    	
    }
    
    global class HotelPreferenes {
    			
    }
    
    global class OtherPreferences {
    	
    }
}