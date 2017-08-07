/**
 * Created by Michal Bluj on 2017-06-28.
 */

public with sharing class ContactTriggerHandler extends TriggerHandler {

    public override void beforeInsert() {
        ContactTriggerHandler.assignAccounts(Trigger.new);
    }

    public override void afterInsert() {
        ContactTriggerHandler.updateDominantOnAccount(Trigger.new);
    }

    public override void afterUpdate() {
        ContactTriggerHandler.updateDominant((List<Contact>)Trigger.new, (Map<Id,Contact>)Trigger.oldMap);
    }

    private static Id ucp = null;

    private static Id getUCPId(){
        if(ucp == null){
            ucp = [select id from RecordType where name = 'UCP'].id;
        }
        return ucp;
    }

    private static Map<String,Account> winetToAccountMap = new Map<String,Account>();

    private static void updateDominantOnAccount(List<Contact> contacts){
        Map<Id,Id> accountDominants = new Map<Id,Id>();
        for(Contact contact : contacts){
            if(contact.Dominant__c){
                accountDominants.put(contact.accountId,contact.id);
            }
        }

        List<Account> accounts = [select Dominant__c from Account where id in: accountDominants.keySet()];
        for(Account account : accounts){
            account.Dominant__c = accountDominants.get(account.id);
        }
        DML.save(accounts);
    }

    private static void updateDominant(List<Contact> contacts, Map<Id,Contact> oldMap){
        Map<Id,String> accountIdWinetIdMap = new Map<Id,String>();
        for(Contact contact : contacts){
            if(contact.Dominant__c && !oldMap.get(contact.id).Dominant__c){
                accountIdWinetIdMap.put(contact.accountId,contact.winet_id__c);
            }
        }

        List<Account> accounts = [select winet_id__c from Account where id in : accountIdWinetIdMap.keySet()];
        for(Account acc : accounts){
            acc.winet_id__c = accountIdWinetIdMap.get(acc.id);
        }
        update accounts;
    }

    private static void assignAccounts(List<Contact> contacts){

        Set<String> winetIds = new Set<String>();
        for(Contact cont : contacts) {
            winetIds.add(cont.winet_id__c);
        }

        List<Account> accounts = [select id,winet_id__c from Account where winet_id__c in : winetIds];
        for(Account acc : accounts){
            winetToAccountMap.put(acc.winet_id__c,acc);
        }

        List<Contact> contactsWithoutAccount = new List<Contact>();
        List<Contact> contactsWithAccount = new List<Contact>();

        Map<Id,Date> accountsEarliestEstablishedDate = new Map<Id,Date>();

        for(Contact cont : contacts){
            if(winetToAccountMap.get(cont.winet_id__c) != null){
                cont.accountId = winetToAccountMap.get(cont.winet_id__c).id;
                if(accountsEarliestEstablishedDate.containsKey(cont.accountId)){
                    if(accountsEarliestEstablishedDate.get(cont.accountId) > cont.Established_Date__c){
                        accountsEarliestEstablishedDate.put(cont.accountId , cont.Established_Date__c);
                    }
                } else {
                    accountsEarliestEstablishedDate.put(cont.accountId , cont.Established_Date__c);
                }
                contactsWithAccount.add(cont);
            } else {
                contactsWithoutAccount.add(cont);
            }
        }

        handleContactsWithAccounts(accounts,contactsWithAccount,accountsEarliestEstablishedDate);
        handleContactsWithoutAccounts(contactsWithoutAccount);

    }

    private static void handleContactsWithAccounts(List<Account> accounts,List<Contact> contactsWithAccount,Map<Id,Date> accountsEarliestEstablishedDate){

        List<Contact> savedContacts = [select id , Established_Date__c, Dominant__c, accountId from Contact where accountId in : accounts order by accountId];

        Map<Id,List<Contact>> acMap = new Map<Id,List<Contact>>();
        savedContacts.addAll(contactsWithAccount);
        for(Contact cont : savedContacts) {
            if(!acMap.containsKey(cont.accountId)){
                acMap.put(cont.accountId,new List<Contact>());
            }
            acMap.get(cont.accountId).add(cont);
        }

        List<Contact> forUpdateList = new List<Contact>();
        for(Id accId : acMap.keySet()){
            List<Contact> accountRelatedContacts = acMap.get(accId);
            Date earliestDate = accountsEarliestEstablishedDate.get(accId);

            Boolean alreadyExitsWithEarlierDate = false;
            for(Contact c : accountRelatedContacts){
                if(c.id != null){
                    if(earliestDate < c.Established_Date__c){
                        c.Dominant__c = false;
                        forUpdateList.add(c);
                    } else {
                        alreadyExitsWithEarlierDate = true;
                    }
                }
            }

            for(Contact c : accountRelatedContacts){
                if (earliestDate >= c.Established_Date__c && c.id == null && !alreadyExitsWithEarlierDate) {
                    c.Dominant__c = true;
                }
            }
        }
        DML.save(forUpdateList);
    }

    private static void handleContactsWithoutAccounts(List<Contact> contactsWithoutAccount){
        List<Account> accounts = new List<Account>();
        Set<String> winets = new Set<String>();
        Map<String,List<Contact>> winetContacts = new Map<String,List<Contact>>();
        for(Contact cont : contactsWithoutAccount){
            if(!winets.contains(cont.winet_id__c)) {
                accounts.add(createContactRelatedAccount(cont));
            }

            if(winetContacts.containsKey(cont.winet_id__c)){
                winetContacts.get(cont.winet_id__c).add(cont);
            } else {
                winetContacts.put(cont.winet_id__c, new List<Contact>{cont});
            }
        }

        DML.save(accounts);

        for(Account acc : accounts) {
            List<Contact> conts = winetContacts.get(acc.winet_Id__c);
            Contact dominant = null;
            Date initialDate = Date.newInstance(9999, 0, 0);
            if (conts != null) {
                for (Contact cont : conts) {
                    cont.accountId = acc.id;
                    if (cont.Established_Date__c != null && cont.Established_Date__c < initialDate) {
                        initialDate = cont.Established_Date__c;
                        dominant = cont;
                    }
                }
                if (dominant != null) {
                    dominant.Dominant__c = true;
                }
            }
        }
    }

    private static Account createContactRelatedAccount(Contact cont){
        return new Account(name = cont.winet_id__c, winet_id__c = cont.winet_id__c, recordTypeId = ContactTriggerHandler.getUCPId());
    }
}