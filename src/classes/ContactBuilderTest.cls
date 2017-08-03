/**
* @author Jakub Kołacz
* @date 2017
* @group UnitTest
* @description Unit test class for ContactBuilder class
**/

@isTest
private class ContactBuilderTest
{
	@isTest
	static void testAll()
	{
		Test.startTest();
		
		ContactBuilder newContactBuilder= ContactBuilder.buildContact();
		Contact contactFromBuilder= newContactBuilder.get();
		System.assert(contactFromBuilder !=null);

		newContactBuilder.withFirstName('FirstName');
		System.assertEquals('FirstName',contactFromBuilder.firstName);

		newContactBuilder.withLastName('LastName');
		System.assertEquals('LastName',contactFromBuilder.lastName);

		newContactBuilder.withWinetId('WinetId');
		System.assertEquals('WinetId',contactFromBuilder.winet_id__c);

		Account newAccount=new Account(
			Name='AccountName');
		insert newAccount;
		newContactBuilder.withAccount(newAccount.Id);
		System.assertEquals(newAccount.Id,contactFromBuilder.accountId);

		newContactBuilder.withEstablishedDate(Date.today());
		System.assertEquals(Date.today(),contactFromBuilder.Established_Date__c);

		Test.stopTest();
	}
}