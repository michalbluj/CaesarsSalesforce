/**
* @author Jakub Kołacz
* @date 2017
* @group UnitTest
* @description Unit test class for AccountBuilder class
**/

@isTest
private class AccountBuilderTest
{
	@isTest
	static void buildAccountTest(){
		Test.startTest();
		AccountBuilder newAccountBuilder= AccountBuilder.buildAccount();
		Test.stopTest();
		System.assert(newAccountBuilder.get() != null);
	}


	@isTest
	static void withNameTest(){
		Test.startTest();
		AccountBuilder newAccountBuilderWithName= AccountBuilder.buildAccount().withName('AccountName');
		Account newAccount=newAccountBuilderWithName.get();
		Test.stopTest();
		System.assertEquals('AccountName',newAccount.Name);
	}

}