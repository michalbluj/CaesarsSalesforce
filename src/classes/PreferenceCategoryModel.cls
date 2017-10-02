public class PreferenceCategoryModel {
	
	//PreferenceCategoryModel.getPath('10074');
    
    private static list<Preference_Category__c> pPrefCategoryList = null;
    public static list<Preference_Category__c> prefCategoryList {
    		get {
    			if (pPrefCategoryList == null) {
    				pPrefCategoryList = [
    					select id, Name, Authors__c,Business_Owner__c,Category_Group__c,Category_Id__c,Parent_Category_Id__r.Category_Id__c,
    					Depth__c,Parent_Category_Id__c,Quality_Code__c,Rank_Rule__c,Response_Rule__c,Timestamp__c 
    					from Preference_Category__c ];
    			}
    			return pPrefCategoryList;
    		}
    }
    
    private static map<String,Preference_Category__c> pPrefCategoryMap = null;
    public static map<String,Preference_Category__c> prefCategoryMap {
    		get {
    			if (pPrefCategoryMap == null) {
    				pPrefCategoryMap = new map<String,Preference_Category__c>();
    				for(Preference_Category__c prefCategory : prefCategoryList) {
    					pPrefCategoryMap.put(prefCategory.Category_Id__c.toPlainString(), prefCategory);
    				}
    			}
    			return pPrefCategoryMap;
    		}
    }
    
    public static String getPath(String categoryId){
    		if (!prefCategoryMap.containsKey(categoryId)){
    			return 'categoryId : '+categoryId+' is not a valid category id';
    		}
    		Preference_Category__c prefCat = prefCategoryMap.get(categoryId);
    		
    		if (prefCat.Depth__c == 1) {
    			return prefCat.Name;
    		} else {
    			return getPath(prefCat.Parent_Category_Id__r.Category_Id__c.toPlainString()) +':'+prefCat.Name;
    		}
    }
    
    /*
    SELECT Category_Id__c,Name,Parent_Category_Id__c, Parent_Category_Id__r.name, depth__c
	FROM Preference_Category__c
	where depth__c = 2
    */

    public static boolean isPrefBeverage(String path) {
    		if(path.contains('Beverage on Demand Master List:')) {
    			return true;
    		}
    		return false;
    }   
    
    
    public static boolean isPrefEvents(String path) {
    		if(path.contains('Marketing:Events:')) {
    			return true;
    		}
    		return false;
    }    

    public static boolean isPrefGLBA(String path) {
    	//to investigate wtih Dara
    		if(path.contains('GLBA')) {
    			return true;
    		}
    		return false;
    }  

    public static boolean isPrefHtlBrand(String path) {
    		if(path.contains('Marketing:Hotels & Casinos:')) {
    			return true;
    		}
    		return false;
    }  

    public static boolean isPrefInterests(String path) {
    		if(path.contains('Marketing:Interests:')) {
    			return true;
    		}
    		return false;
    }  

    public static boolean isPrefPartnerSubs(String path) {
    	    	//to investigate wtih Dara
    		if(path.contains('Marketing:PartnerSubs:')) {
    			return true;
    		}
    		return false;
    } 
    
    public static boolean isPrefProgramSubs(String path) {
    	    	//to investigate wtih Dara
    		if(path.contains('Marketing:ProgramSubs:')) {
    			return true;
    		}
    		return false;
    }  

    public static boolean isPrefSpecialty(String path) {
    		if(path.contains('Marketing Lists:Specialty Lists:')) {
    			return true;
    		}
    		return false;
    }  

    public static boolean isPrefTemp(String path) {
    		if(path.contains('Marketing Lists:Temp Lists:')) {
    			return true;
    		}
    		return false;
    }  

}