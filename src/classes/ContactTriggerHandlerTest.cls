/**
 * Created by Michal Bluj on 2017-06-28.
 */

@IsTest
private class ContactTriggerHandlerTest {

    static testMethod void setUpDominantOnAccountWithExistingAccountTest() {
        Account dominantAccount = AccountBuilder.buildAccount()
                .withName('Clark Kent').get();
        DML.save(dominantAccount);

        Contact dominant = ContactBuilder.buildContact()
                .withFirstName('Peter')
                .withLastName('Parker')
                .withAccount(dominantAccount.id)
                .withWinetId('123456789')
                .withEstablishedDate(System.today()).get();
        DML.save(dominant);

        dominant = [select id , accountId, Dominant__c from Contact where id =: dominant.id];

        System.assert(dominant.Dominant__c);

        Account account = AccountBuilder.buildAccount()
                .withName('Lex Luthor').get();

        Contact contact = ContactBuilder.buildContact()
                .withFirstName('Lois')
                .withLastName('Lane')
                .withWinetId('123456789')
                .withEstablishedDate(System.today().addDays(-1)).get();

        Test.startTest();
        DML.save(contact);
        Test.stopTest();

        contact = [select id , accountId, Dominant__c from Contact where id =: contact.id];

        List<Account> accounts = [select id from Account where id =: contact.accountId];

        dominant = [select id , accountId, Dominant__c from Contact where id =: dominant.id];

        System.assert(!dominant.Dominant__c);
        System.assert(accounts.get(0).id == contact.accountId);
        System.assert(contact.Dominant__c);
    }

    static testMethod void setUpDominantOnAccountWithoutExistingAccountTest() {
        Contact casinoCard1 = ContactBuilder.buildContact()
                .withFirstName('Lois')
                .withLastName('Lane')
                .withWinetId('123456789')
                .withEstablishedDate(system.today()).get();

        Contact casinoCard2 = ContactBuilder.buildContact()
                .withFirstName('Lois')
                .withLastName('Lane')
                .withWinetId('123456789')
                .withEstablishedDate(system.today().addDays(-1)).get();

        // inserting 2 cards without contact created with different established dates

        Test.startTest();
        DML.save(new List<Contact>{casinoCard1,casinoCard2});
        Test.stopTest();

        // second card should be set as dominant because of earlier date
        // both cards should be assigned to the same account

        casinoCard1 = [select id , accountId, Dominant__c from Contact where id =: casinoCard1.id];
        casinoCard2 = [select id , accountId, Dominant__c from Contact where id =: casinoCard2.id];

        List<Account> accounts = [select id, recordType.Name, Dominant__c from Account where id =: casinoCard1.accountId];

        System.assert(accounts.get(0).id == casinoCard1.accountId);
        System.assert(accounts.get(0).id == casinoCard2.accountId);
        System.assertEquals(accounts.get(0).recordType.Name,'UCP');
        System.assertEquals(accounts.get(0).Dominant__c,casinoCard2.id);
        System.assert(!casinoCard1.Dominant__c);
        System.assert(casinoCard2.Dominant__c);
    }
}