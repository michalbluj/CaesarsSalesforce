public with sharing class CustomerInfoListControllerCC {

    @AuraEnabled
    public static List<Customer_Info_External_c__x> findAll() {
        //return [SELECT ExternalId FROM Customer_Info_External_c__x LIMIT 50];
        return [SELECT Id, contact__c, ExternalId, RecordType__c FROM Customer_Info_External_c__x WHERE contact__r.Id = '0030v000002bWbz'];
    }
    
    /*
    @AuraEnabled
    public static List<Contact> findByName(String searchKey) {
        String name = '%' + searchKey + '%';
        return [SELECT id, name, phone FROM Contact WHERE name LIKE :name LIMIT 50];
    }

    @AuraEnabled
    public static Contact findById(String contactId) {
        return [SELECT id, name, title, phone, mobilephone, Account.Name
                    FROM Contact WHERE Id = :contactId];
    }
    */
    
    public static List<Schema.FieldSetMember> readFieldSet(String fieldSetName, String ObjectName) {
    
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
    
        //system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));
    
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
    
        //List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();
        //system.debug('fieldSetMemberList ====>' + fieldSetMemberList);  
        return fieldSetObj.getFields(); 
    }  
}