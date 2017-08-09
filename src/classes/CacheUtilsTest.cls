@isTest
private class CacheUtilsTest {
	@testSetup
	static void init(){
		Account acc = new Account(Name = 'test', Phone = '123');
		insert acc;
	}
	
	@isTest 
	static void getMapTest(){
		Test.startTest();
		Map<String, SObject> nameToObjectMap = CacheUtils.getMapFromCache('Account', new List<String>{'Phone', 'Name'});
		Test.stopTest();

		System.assertEquals(true, nameToObjectMap.containsKey('test'));
		System.assertEquals('123', nameToObjectMap.get('test').get('Phone'));
	}	
}