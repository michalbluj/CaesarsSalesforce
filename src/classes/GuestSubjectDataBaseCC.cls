/**
* @author Sarah Kennedy / Benjamin Lau
* @date July 2017
*
* @description Base Class to retrieve Shelf (Marketing Campaign) Data
*/
global virtual class GuestSubjectDataBaseCC {

	global String soqlFromFieldSet(Schema.FieldSet fieldSet, String objectApiName, List<String> recordType){
		
		List<Schema.FieldSetMember> fieldSetMembers = fieldSet.getFields();
		String soql = 'SELECT ';
        for(Schema.FieldSetMember f : fieldSet.getFields()) {
			soql += f.getFieldPath() + ', ';
        }
        soql += 'Id,externalId, RecordType__c FROM '+objectApiName;
        if(recordType <> null) {
        		soql += ' WHERE recordtype__c in :recordtypes';
        }
		soql = String.escapeSingleQuotes(soql);
		
		return soql;
	}

	global String soqlFromFieldSet(Schema.FieldSet fieldSet, String objectApiName, List<String> recordType, List<String> addFieldsList){
		
		List<Schema.FieldSetMember> fieldSetMembers = fieldSet.getFields();
		String soql = 'SELECT ';
        for(Schema.FieldSetMember f : fieldSet.getFields()) {
			soql += f.getFieldPath() + ', ';
        }
        String addFields = '';
        for (String s : addFieldsList){
        	addFields += s + ',';
        }

        soql += addFields + 'Id,externalId, RecordType__c FROM '+objectApiName;
        if(recordType <> null) {
        		soql += ' WHERE recordtype__c in :recordtypes';
        }
		soql = String.escapeSingleQuotes(soql);
		
		return soql;
	}

	/*******************************************************************************************************
	* @description Add the xref dmid contacts to capture those activities that have not yet been merged
	* @param List<Id> of Contact Ids used to retrieve the Contact dmids
	* @return List<String> containing the combination of input contact Ids and the xref contact Ids
	* @example
	* 	Set<String> allContactIds = getConsXrefIds(contactIds);
	*/
	@TestVisible global List<String> getConsXrefIds(List<String> contactIds) {
		system.debug('*** in getxref');
		Set<String> winnetIds = new Set<String>();
		Set<String> xWinnetIds = new Set<String>();
		List<String> xContactIds = new List<String>();
		for (Contact ctc : [SELECT Id, winet_Id__c FROM Contact WHERE Id in :contactIds]) {
			if (ctc.winet_Id__c != null) {
				winnetIds.add(ctc.winet_Id__c);
			}
		}

		system.debug('*** winnetIds ' + winnetIds);

		List<gst_cons_xref__x> xRefList = [SELECT i_dmid__c, i_xref_dmid__c FROM gst_cons_xref__x WHERE i_dmid__c in: winnetIds ];

		system.debug('*** xRefList ' + xRefList);

		for (gst_cons_xref__x gstx : xRefList) {
			if (gstx.i_xref_dmid__c != null) {
				xWinnetIds.add(gstx.i_xref_dmid__c);
			}
		}

		for (Contact xCtc : [SELECT Id FROM Contact WHERE winet_Id__c in :xWinnetIds]) {
			xContactIds.add(xCtc.Id);
		}

		contactIds.addAll(xContactIds);

		return contactIds;

	}

	/*******************************************************************************************************
	* @description Strip the time off of a string datetime
	* @param String datetime
	* @return String date
	* @example
	* 	String myDate = stripTime(String dateTimeIn);
	*/
	global String stripTime(String dtIn){
		String dtOut = dtIn;
		if (!String.IsBlank(dtIn) &&
			dtIn.indexOf('T') > -1){
			dtOut =dtIn.substring(0,dtIn.indexOf('T') );
		}
		return dtOut;
	}

	
	global virtual class PrefWrapperBase {
	  	override global String toString() {
	  		return JSON.serializePretty(this);
	  	}
	}
}