/**
*	@description   model class for RecordType
*
*
*    @author Benjamin Lau
*    @date 01/14/2016
*    @group Model
*/
public  without Sharing class RecordTypeModel {

    /////////////////////////////////////////////////////////////////////////
    private static List<RecordType> pRecordTypeList = null;
    public static List<RecordType> recordTypeList {
        get {
            if (pRecordTypeList == null) {
                pRecordTypeList = [select id, SobjectType, DeveloperName, Name  from RecordType where isActive = true];
            }
            return pRecordTypeList;
        }
    }

    private static Map<Id, RecordType> pRecordTypeMapById = null;
    public static Map<Id, RecordType> recordTypeMapById {
        get {
            if ( pRecordTypeMapById == null) {
                pRecordTypeMapById = new Map<Id, RecordType>();
                for(RecordType rt : RecordTypeList) {
                    pRecordTypeMapById.put(rt.id, rt);
                }
            }
            return pRecordTypeMapById;
        }
    }

    public static string findRecordTypeNameById(Id recordTypeId) {
        if (RecordTypeMapById.containsKey(recordTypeId) ) {
            return RecordTypeMapById.get(recordTypeId).DeveloperName;
        } else {
            return 'Unknown RecordTypeId : ' + recordTypeId;
        }
    }

    private static Map<String,RecordType> pRecordTypeMap = null;
    public static Map<String,RecordType> recordTypeMap {
        get {
            if ( pRecordTypeMap == null){
                pRecordTypeMap = new Map<String,RecordType>();

                for(RecordType rt : RecordTypeList){
                    pRecordTypeMap.put(rt.SobjectType+':'+rt.Name, rt);
                    //System.Debug(rt.SobjectType+':'+rt.Name);
                    if ( rt.Name <> rt.DeveloperName){
                        pRecordTypeMap.put(rt.SobjectType+':'+rt.DeveloperName, rt);
                        //System.Debug(rt.SobjectType+':'+rt.DeveloperName);
                    }
                }
            }
            return pRecordTypeMap;
        }
    }

    public static RecordType lookupRecordType(string sObjectName, string RecordTypeName){
        if(recordTypeMap.containsKey(sObjectName+':'+RecordTypeName)){
            return recordTypeMap.get(sObjectName+':'+RecordTypeName);
        } else {
            //unable to locate
            System.Debug('RecordTypeModel::LookupRecordType unable to locate '+sObjectName+':'+RecordTypeName);
            return null;
        }
    }


    public static Id lookupRecordTypeId(string sObjectName, string recordTypeName){
        if(recordTypeMap.containsKey(sObjectName+':'+recordTypeName)){
            return recordTypeMap.get(sObjectName+':'+recordTypeName).Id;
        } else {
            //unable to locate
            System.Debug('RecordTypeModel::LookupRecordType unable to locate '+sObjectName+':'+recordTypeName);
            return null;
        }
    }


    ///////////////////////////////////////////////////////////////////////////////////////
    // Account
    public static id Account_PropertyId {
        get {
            return LookupRecordTypeId('Account','Property');
        }
    }

    ///////////////////////////////////////////////////////////////////////////////////////
    // Campaign Project
    public static id CampaignProject_DraftId {
        get {
            return LookupRecordTypeId('Campaign_Project__c','Draft');
        }
    }

    ///////////////////////////////////////////////////////////////////////////////////////
    // Offer Definition
    public static id OfferDefinition_ChoiceId {
        get {
            return LookupRecordTypeId('Offer_Definition__c','Choice');
        }
    }
    
    public static id OfferDefinition_PackageId {
        get {
            return LookupRecordTypeId('Offer_Definition__c','Package');
        }
    }



}