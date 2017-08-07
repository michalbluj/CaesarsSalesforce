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
        soql += 'Id,externalId,RecordType__c FROM '+objectApiName;
        if(recordType <> null) {
        		soql += ' WHERE recordtype__c in :recordtypes';
        }
		soql = String.escapeSingleQuotes(soql);
		
		return soql;
	}
	
	global virtual class PrefWrapperBase {
	  	override global String toString() {
	  		return JSON.serializePretty(this);
	  	}
	}
}