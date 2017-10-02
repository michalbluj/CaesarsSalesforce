global with sharing class PreferenceEnterpriseMock {
	
    global PreferenceEnterpriseMock() {}
    
    @RemoteAction
	@AuraEnabled
	global static PreferenceEnterpriseCC.EnterprisePreferncesWrapper getMock() {
		PreferenceEnterpriseCC.EnterprisePreferncesWrapper result = new PreferenceEnterpriseCC.EnterprisePreferncesWrapper();
		
		result.entPrefGlba = getEntPrefGlba();
		result.entPrefSpecialty = getEntPrefSpecialty();
		result.entPrefPartnerSubs = getEntPrefPartnerSubs();
		result.entPrefProgramSubs = getEntPrefProgramSubs();
		result.entPrefTemp = getEntPrefTemp();
		result.entPrefInterests = getEntPrefInterests();
		result.entPrefEvents = getEntPrefEvents();
		result.entPrefHotelBrands = getEntPrefHotelBrands();
		result.entPrefOthers = getEntPrefOthers();
		return result;
	}  
	
	private static PreferenceEnterpriseCC.EntPrefSubType getEntPrefGlba() {
		return null;
	}
	
	private static PreferenceEnterpriseCC.EntPrefSubType getEntPrefSpecialty() {
		return null;	
	}
	
	private static PreferenceEnterpriseCC.EntPrefSubType getEntPrefPartnerSubs() {
		return null;	
	}
	
	private static PreferenceEnterpriseCC.EntPrefSubType getEntPrefProgramSubs() {
		return null;		
	}
	
	private static PreferenceEnterpriseCC.EntPrefSubType getEntPrefTemp() {
		return null;		
	}
	
	private static PreferenceEnterpriseCC.EntPrefSubType getEntPrefInterests() {
		return null;	
	}
	
	private static PreferenceEnterpriseCC.EntPrefSubType getEntPrefEvents() {
		return null;	
	}
	
	private static PreferenceEnterpriseCC.EntPrefSubType getEntPrefHotelBrands() {
		return null;		
	}
	
	private static PreferenceEnterpriseCC.EntPrefSubType getEntPrefOthers() {
		return null;		
	}
	
	
}