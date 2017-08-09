/**
 *  @author Patryk Lompart
 *  @date 8/08/2017
 *  @group Utility
 *  @description  Utility class for cache
 */
public with sharing class CacheUtils {
		
	private CacheUtils() {}

	public static void putCacheForObject(String objectName, List<String> fields){
		String key = objectName.replace('_', '');
		String joinedFields = String.join(fields, ', ');
		List<SObject> objects = Database.query('SELECT ' + joinedFields + ' FROM ' + objectName);
		Map<String, SObject> nameToIdMap = new Map<String, SObject>();
		for(SObject obj : objects){
			nameToIdMap.put((String)obj.get('Name'), obj);
		}
		Cache.Org.put(key, nameToIdMap);
	}

	public static Map<String, SObject> getMapFromCache(String objectName,List<String> fields){
		String key = objectName.replace('_', '');

		if(!Cache.Org.contains(key)){
			putCacheForObject(objectName,fields);
		}

		return (Map<String, SObject>)Cache.Org.get(key);
	}
}