/**
 * Created by iyeung on 7/12/17.
 */

public with sharing class OfferDefinitionLibraryService {


    public static final Integer MIN_SEARCH_ROWS = 10; // if it is less than this result, tokenize the
    public static final Integer MAX_SEARCH_ROWS = 200; //



    /**
    * @description get the offer library search criteria with respect to the campaign project
    * @param  record id of campaign project
    * @example
    *     OfferDefinitionLibraryService.copyOfferDefinition( 'a140v0000004mFHAAY, 'a1J0v0000008Y6lEAE');
    * @return String : OfferDefinitionLibraryDTO.SearchCriteria
    */

    public static OfferDefinitionLibraryDTO.Status copyOfferDefinition(String campaignProjectId, OfferDefinitionLibraryDTO.OfferDefinition offerDefinition
    ) {

        OfferDefinitionLibraryDTO.Status status = new OfferDefinitionLibraryDTO.Status();

        // create the offer definiton
        Offer_Definition__c offerDef = offerDefinition.ToObject();
        offerDef.Campaign_Project__c = campaignProjectId; // move hte offer definiton to the new campaign project;
        DML.save(offerDef);
        System.debug('~~~~~ offer def: ' + offerDef);


        List <Offer_Incentive__c> lIncentives = new List <Offer_Incentive__c>();

        if (offerDef.Id != null && offerDefinition.offerIncentiveGroups != null) {
            // create the offer incentive group
            List <Offer_Incentive_Group__c> lGroups = new List <Offer_Incentive_Group__c>();
            for (Integer i = 0; i < offerDefinition.offerIncentiveGroups.size(); i++) {
                Offer_Incentive_Group__c oGroup = offerDefinition.offerIncentiveGroups[i].ToObject();
                oGroup.Offer_Definition__c = offerDef.Id; // updated with the new id;
                lGroups.add(oGroup);
            }
            DML.save(lGroups);
            System.debug('~~~~~ offer incentive groups: ' + lGroups);


            // create offer incentives from group
            for (Integer i = 0; i < offerDefinition.offerIncentiveGroups.size(); i++) {
                for (OfferDefinitionLibraryDTO.OfferIncentive incentive: offerDefinition.offerIncentiveGroups[i].offerIncentives) {
                    Offer_Incentive__c oIncentive = incentive.ToObject();
                    oIncentive.Offer_Incentive_Group__c = lGroups[i].Id; // assume the two arrays are in sync
                    lIncentives.add(oIncentive);
                }
            }
        }
        if (offerDef.Id != null && offerDefinition.offerIncentives != null) {
            // create offer incentive from offer definition
            for (OfferDefinitionLibraryDTO.OfferIncentive incentive: offerDefinition.offerIncentives) {
                Offer_Incentive__c oIncentive = incentive.ToObject();
                oIncentive.Offer_Definition__c = offerDef.Id;  // assume the two arrays are in sync
                lIncentives.add(oIncentive);
            }
            DML.save(lIncentives);
            System.debug('~~~~ offer incentives: ' + lIncentives);
        }

        status.statusCode = OfferDefinitionLibraryDTO.STATUS_OK;
        status.statusDescription = 'OK';

        return status;

    }

    /**
    * @description get the offer library search criteria with respect to the campaign project
    * @param  record id of campaign project
    * @return String : OfferDefinitionLibraryDTO.SearchCriteria
    */
    public static OfferDefinitionLibraryDTO.SearchCriteria getSearchCriteria(String CampaignProjectId){

        OfferDefinitionLibraryDTO.SearchCriteria result = new OfferDefinitionLibraryDTO.SearchCriteria();

        // properties
        result.properties = new Map<String, String>();
        for (Campaign_Project_Property__c cpp: [select Campaign_Project__c, Property__r.Property_Code__c, Property__r.Name,  Name, Property__c from Campaign_Project_Property__c where Campaign_Project__c =: CampaignProjectId  ]){
            result.properties.put(cpp.Property__r.Property_Code__c, cpp.Property__r.Name);
        }
        // if (result.properties.size() > 0 ){
        //     result.properties.put(OfferDefinitionLibraryDTO.PROPERTY_CODE_ALL, OfferDefinitionLibraryDTO.PROPERTY_CODE_ALL );
        // }

        result.incentiveCategories = GlobalPicklistModel.offerIncentiveCategories;

        result.incentiveSubCategories = GlobalPicklistModel.offerIncentiveSubCategories;

        return result;

    }


    /**
    * @description get offer details
    *
    * @param  String offerDefinitionId
    * @return OfferDefinitionLibraryDTO.OfferDefinition
    */
    public static OfferDefinitionLibraryDTO.OfferDefinition getOfferDetails(String offerDefinitionId){

        OfferDefinitionLibraryDTO.OfferDefinition result = new OfferDefinitionLibraryDTO.OfferDefinition();
        if (String.isNotBlank(offerDefinitionId)){
            // expect only one.
            for (Offer_Definition__c o: [select name, Campaign_Project__c,  Description__c, Id, Max_Choice__c, Offer_Definition_Type__c, Offer_Employee_Description__c, Offer_Guest_Label__c, Offer_Id__c, Offer_Incentive_Count__c, Offer_Incentive_Group_Count__c, Offer_Intent__c, OwnerId, RecordTypeId from Offer_Definition__c where Id =: offerDefinitionId]){
                result = new  OfferDefinitionLibraryDTO.OfferDefinition(o);
            }
            System.debug('#### result: ' + result);
            // offer incentive groups associated with offer definitions
            Set <Id> offerIncentiveGroupIds = new Set<Id>();
            List <OfferDefinitionLibraryDTO.OfferIncentiveGroup> offerIncentiveGroups = new List <OfferDefinitionLibraryDTO.OfferIncentiveGroup>();
            Map<id, OfferDefinitionLibraryDTO.OfferIncentiveGroup> offerIncentiveGroupMap = new Map<id, OfferDefinitionLibraryDTO.OfferIncentiveGroup>();
            for (Offer_Incentive_Group__c o: [select CreatedById, CreatedDate, Id, LastModifiedById, LastModifiedDate, Max_Choice__c, Name, Offer_Definition__c, Offer_Incentive_Group_Label__c from Offer_Incentive_Group__c where Offer_Definition__c = :offerDefinitionId]){
                OfferDefinitionLibraryDTO.OfferIncentiveGroup dto = new OfferDefinitionLibraryDTO.OfferIncentiveGroup(o);
                dto.offerIncentives = new List<OfferDefinitionLibraryDTO.OfferIncentive> ();
                offerIncentiveGroups.add(dto);
                offerIncentiveGroupIds.add(o.Id);
                offerIncentiveGroupMap.put(o.Id, dto);
            }
            result.offerIncentiveGroups = offerIncentiveGroups;
            System.debug('#### result: ' + result);

            List <OfferDefinitionLibraryDTO.OfferIncentive> offerIncentiveWithDef = new List<OfferDefinitionLibraryDTO.OfferIncentive>();
            for (Offer_Incentive__c o: [select  Amount__c, Booking_End_Date__c, Booking_End_Hour__c, Booking_Start_Date__c, Booking_Start_Hour__c, Calculation_Type__c, Campaign_Vaild_End_Date__c, Campaign_Valid_Start_Date__c, Companion_Share__c, CreatedById, CreatedDate, Disclaimer__c, Employee_Description__c, Guest_Description__c, Id, Market__c, Market_Time_Zone__c, Max_Offer_Amount__c, Max_Redemption__c, Min_Offer_Amount__c, Name, Offer_Definition__c, Offer_Incentive_Category__c, Offer_Incentive_Group__c, Offer_Incentive_Id__c, Offer_Incentive_Subcategory__c, Offer_Valid_Day_Count__c, Override_Campaign_Date__c, OwnerId, Percentage_of_Worth__c, Reservation_Phone_Number__c, SystemModstamp, Time_Valid_Type__c, Valid_End_Date__c, Valid_End_Duration__c, Valid_End_Hour__c, Valid_End_Minute__c, Valid_Start_Date__c, Valid_Start_Hour__c, Valid_Start_Minute__c, Value_Type__c, Visible_to_Guest__c from Offer_Incentive__c where Offer_Definition__c = :offerDefinitionId or Offer_Incentive_Group__c in : offerIncentiveGroupIds] ){
                if (o.Offer_Definition__c != null){
                    offerIncentiveWithDef.add(new OfferDefinitionLibraryDTO.OfferIncentive(o));
                }
                if (o.Offer_Incentive_Group__c != null){
                    if (offerIncentiveGroupMap.containsKey(o.Offer_Incentive_Group__c)){
                        offerIncentiveGroupMap.get(o.Offer_Incentive_Group__c).offerIncentives.add(new OfferDefinitionLibraryDTO.OfferIncentive(o));
                    }
                }
            }
            result.offerIncentives = offerIncentiveWithDef;
            System.debug('#### result: ' + result);


        }

        return result;

    }

    /**
    * @description search the offer definiton based upon the search parameters.
    *
    * @param  OfferDefinitionLibraryDTO.SearchParamters
    * @return List<OfferDefinitionLibraryDTO.OfferDefinition>
    */
    /*
     * example
            OfferDefinitionLibraryDTO.SearchParamters searchParameters = OfferDefinitionLibraryDTO.SearchParamters();
            searchParameters.offerDescription = 'Free buffett';
            List<OfferDefinitionLibraryDTO.OfferDefinition>  listOffers = OfferDefinitionLibraryService.searchOffers(searchParameters);
            System.debug('~~~~' + listOffers);

     */
    public static List<OfferDefinitionLibraryDTO.OfferDefinition> searchOffers(OfferDefinitionLibraryDTO.SearchParamters searchParameters){

        List<OfferDefinitionLibraryDTO.OfferDefinition> results = new List<OfferDefinitionLibraryDTO.OfferDefinition>();

        Map<Id, Integer> resultWeightMap = new Map<Id, Integer>(); // keep track of search result weight
        String searchString;
        Set<Id> offerDefinitionIds;
        Integer weight;
        List<List<SObject>> searchList;
        map<Id, OfferDefinitionLibraryDTO.OfferDefinition> offerMap = new map<Id,  OfferDefinitionLibraryDTO.OfferDefinition>();

        // STEP 1: offer description search
        if (String.isNotBlank(searchParameters.offerDescription)) {

            // Round 1: find all the offer definiton with exact search pharse, offer incentive group, offer incentive that match with the label
            searchString = searchParameters.offerDescription;
            weight = 3; // exact pharse match has higher weight
            searchList = [FIND :searchString IN ALL FIELDS RETURNING Offer_Definition__c (Id, Name, Offer_Id__c), Offer_Incentive__c(Id, Offer_Definition__c, Offer_Incentive_Group__r.Offer_Definition__c), Offer_Incentive_Group__c(Id, Offer_Definition__c)];
            system.debug('searchList-->'+searchList);
            for (Offer_Definition__c o: (List <Offer_Definition__c>) searchList[0]) {
                if (!offerMap.containsKey(o.Id)) {
                    OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                    dto.weight = weight;
                    dto.Id = o.Id;
                    offerMap.put(o.Id, dto);
                } else {
                    offerMap.get(o.Id).weight += weight;
                }
            }
            for (Offer_Incentive__c o: (List <Offer_Incentive__c>) searchList[1]) {
                Id offerDefinitionId;
                if (o.Offer_Definition__c != null ){
                    offerDefinitionId = o.Offer_Definition__c;
                } else if (o.Offer_Incentive_Group__r.Offer_Definition__c != null ){
                    offerDefinitionId = o.Offer_Incentive_Group__r.Offer_Definition__c;
                }
                if (offerDefinitionId != null) {
                    if (!offerMap.containsKey(offerDefinitionId)) {
                        OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                        dto.weight = weight;
                        dto.Id = offerDefinitionId;
                        offerMap.put(offerDefinitionId, dto);
                    } else {
                        offerMap.get(offerDefinitionId).weight += weight;
                    }
                }
            }
            for (Offer_Incentive_Group__c o: (List <Offer_Incentive_Group__c>) searchList[2]) {
                if (!offerMap.containsKey(o.Offer_Definition__c)) {
                    OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                    dto.weight = weight;
                    dto.Id = o.Offer_Definition__c;
                    offerMap.put(o.Offer_Definition__c, dto);
                } else {
                    offerMap.get(o.Offer_Definition__c).weight += weight;
                }
            }
            System.debug('~~~~ offerMap round1 search String: ' + searchString + ' size:  ' + offerMap.size());
            System.debug('~~~~ offerMap round1: ' + offerMap);


            if (offerMap.size() < MIN_SEARCH_ROWS) {
                // Round 2: find all the offer definiton with exact search pharse, offer incentive group, offer incentive that match with all tokens in the label
                String[] searchStrings = searchParameters.offerDescription.split(' ');
                searchString = searchStrings[0];
                for (Integer i = 1; i < searchStrings.size(); i++) {
                    searchString += ' AND ' + searchStrings[i];
                }
                weight = 2; // all the word
                searchList = [FIND :searchString IN ALL FIELDS RETURNING Offer_Definition__c (Id, Name, Offer_Id__c), Offer_Incentive__c(Id, Offer_Definition__c, Offer_Incentive_Group__r.Offer_Definition__c), Offer_Incentive_Group__c(Id, Offer_Definition__c)];
                for (Offer_Definition__c o: (List <Offer_Definition__c>) searchList[0]) {
                    if (!offerMap.containsKey(o.Id)) {
                        OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                        dto.weight = weight;
                        dto.Id = o.Id;
                        offerMap.put(o.Id, dto);
                    } else {
                        offerMap.get(o.Id).weight += weight;
                    }
                }
                for (Offer_Incentive__c o: (List <Offer_Incentive__c>) searchList[1]) {
                    Id offerDefinitionId;
                    if (o.Offer_Definition__c != null ){
                        offerDefinitionId = o.Offer_Definition__c;
                    } else if (o.Offer_Incentive_Group__r.Offer_Definition__c != null ){
                        offerDefinitionId = o.Offer_Incentive_Group__r.Offer_Definition__c;
                    }
                    if (offerDefinitionId != null ) {
                        if (!offerMap.containsKey(offerDefinitionId)) {
                            OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                            dto.weight = weight;
                            dto.Id = offerDefinitionId;
                            offerMap.put(offerDefinitionId, dto);
                        } else {
                            offerMap.get(offerDefinitionId).weight += weight;
                        }
                    }
                }
                for (Offer_Incentive_Group__c o: (List <Offer_Incentive_Group__c>) searchList[2]) {
                    if (!offerMap.containsKey(o.Offer_Definition__c)) {
                        OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                        dto.weight = weight;
                        dto.Id = o.Offer_Definition__c;
                        offerMap.put(o.Offer_Definition__c, dto);
                    } else {
                        offerMap.get(o.Offer_Definition__c).weight += weight;
                    }
                }
            }
            System.debug('~~~~ offerMap round2 search String: ' + searchString + ' size:  ' + offerMap.size());
            System.debug('~~~~ offerMap round2: ' + offerMap);

            if (offerMap.size() < MIN_SEARCH_ROWS ) {
                // Round 3: find all the offer definiton with exact search pharse, offer incentive group, offer incentive that match with all tokens in the label
                String[] searchStrings = searchParameters.offerDescription.split(' ');
                searchString = searchStrings[0];
                for (Integer i = 1; i < searchStrings.size(); i++) {
                    searchString += ' OR ' + searchStrings[i];
                }
                weight = 1; // one of the word
                searchList = [FIND :searchString IN ALL FIELDS RETURNING Offer_Definition__c (Id, Name, Offer_Id__c), Offer_Incentive__c(Id, Offer_Definition__c, Offer_Incentive_Group__r.Offer_Definition__c), Offer_Incentive_Group__c(Id, Offer_Definition__c)];
                for (Offer_Definition__c o: (List <Offer_Definition__c>) searchList[0]) {
                    if (!offerMap.containsKey(o.Id)) {
                        OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                        dto.weight = weight;
                        dto.Id = o.Id;
                        offerMap.put(o.Id, dto);
                    } else {
                        offerMap.get(o.Id).weight += weight;
                    }
                }
                for (Offer_Incentive__c o: (List <Offer_Incentive__c>) searchList[1]) {
                    Id offerDefinitionId;
                    if (o.Offer_Definition__c != null ){
                        offerDefinitionId = o.Offer_Definition__c;
                    } else if (o.Offer_Incentive_Group__r.Offer_Definition__c != null ){
                        offerDefinitionId = o.Offer_Incentive_Group__r.Offer_Definition__c;
                    }
                    if (offerDefinitionId != null) {
                        if (!offerMap.containsKey(offerDefinitionId)) {
                            OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                            dto.weight = weight;
                            dto.Id = offerDefinitionId;
                            offerMap.put(offerDefinitionId, dto);
                        } else {
                            offerMap.get(offerDefinitionId).weight += weight;
                        }
                    }
                }
                for (Offer_Incentive_Group__c o: (List <Offer_Incentive_Group__c>) searchList[2]) {
                    if (!offerMap.containsKey(o.Offer_Definition__c)) {
                        OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                        dto.weight = weight;
                        dto.Id = o.Offer_Definition__c;
                        offerMap.put(o.Offer_Definition__c, dto);
                    } else {
                        offerMap.get(o.Offer_Definition__c).weight += weight;
                    }
                }
            }
            System.debug('~~~~ offerMap round3 search String: ' + searchString + ' size:  ' + offerMap.size());
            System.debug('~~~~ offerMap round3 size:  ' + offerMap.size());
            System.debug('~~~~ offerMap round3: ' + offerMap);

        }


        // STEP 2 property search
        if (searchParameters.property != null && searchParameters.property.size() > 0 ){

            weight = 1; // property search weight
            Set <Id> offerIncentiveWithMatchedPropertyIds = new Set<Id>();
            System.debug('~~~~ properties being search: ' + searchParameters.property  ); 

            for (Offer_Incentive_Property__c op: [select Id, Offer_Incentive__c, Property__c, Property__r.Property_Code__c from Offer_Incentive_Property__c where Property__r.Property_Code__c != null and Property__r.Property_Code__c in :searchParameters.property ]){
                offerIncentiveWithMatchedPropertyIds.add(op.Offer_Incentive__c);
            }
            for (Offer_Incentive__c o: [select Id, Offer_Definition__c, Offer_Incentive_Group__r.Offer_Definition__c from Offer_Incentive__c where Id in :offerIncentiveWithMatchedPropertyIds  ] ){
                Id offerDefinitionId;
                if (o.Offer_Definition__c != null ){
                    offerDefinitionId = o.Offer_Definition__c;
                } else if (o.Offer_Incentive_Group__r.Offer_Definition__c != null ){
                    offerDefinitionId = o.Offer_Incentive_Group__r.Offer_Definition__c;
                }
                if (offerDefinitionId != null) {
                    if (!offerMap.containsKey(offerDefinitionId)) {
                        OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                        dto.weight = weight;
                        dto.Id = offerDefinitionId;
                        offerMap.put(offerDefinitionId, dto);
                    } else {
                        offerMap.get(offerDefinitionId).weight += weight;
                    }
                }
            }
            System.debug('~~~~ offerMap STEP 2 size:  ' + offerMap.size());
            System.debug('~~~~ offerMap STEP 3 size:  ' + offerMap);
        }



        // STEP3 offer incentive category and offer incentive subcategory
        // to do: conver to dynamic soql later on
        if (searchParameters.incentiveCategory != null && searchParameters.incentiveCategory.size() > 0 &&  searchParameters.incentiveSubCategory != null && searchParameters.incentiveSubCategory.size() > 0  ){

            weight = 1; // incentive category
            for (Offer_Incentive__c o: [select Id, Offer_Definition__c, Offer_Incentive_Group__r.Offer_Definition__c from Offer_Incentive__c where Offer_Incentive_Subcategory__c in : searchParameters.incentiveSubCategory and Offer_Incentive_Category__c in : searchParameters.incentiveCategory ] ){
                Id offerDefinitionId;
                if (o.Offer_Definition__c != null ){
                    offerDefinitionId = o.Offer_Definition__c;
                } else if (o.Offer_Incentive_Group__r.Offer_Definition__c != null ){
                    offerDefinitionId = o.Offer_Incentive_Group__r.Offer_Definition__c;
                }
                if (offerDefinitionId != null ){
                    if (!offerMap.containsKey(offerDefinitionId)) {
                        OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition();
                        dto.weight = weight;
                        dto.Id = offerDefinitionId;
                        offerMap.put(offerDefinitionId, dto);
                    }  else {
                        offerMap.get(offerDefinitionId).weight += weight;
                    }
                }
            }
            System.debug('~~~~ offerMap STEP 3 size:  ' + offerMap.size());
            System.debug('~~~~ offerMap STEP 3 :  ' + offerMap);
        }





        // FINAL STEP sort and retrieve details
        List<OfferDefinitionLibraryDTO.OfferDefinition> offerBuffer = offerMap.values();
        System.debug('~~~~ buffer size: ' + offerBuffer.size());
        offerBuffer.sort();
        offerDefinitionIds = new Set<Id>();
        for (Integer i = 0; i < MAX_SEARCH_ROWS && i < offerMap.size(); i++){
            offerDefinitionIds.add(offerBuffer[i].Id);
        }
        System.debug('~~~~ offerdef id size: ' + offerDefinitionIds.size());
        System.debug('~~~~ offerdef id : ' + offerDefinitionIds);

        if (offerMap.size() > 0 ) {
                Decimal highestWeight = offerBuffer[0].weight;
                // adding filter to ignore bad data.
                for (Offer_Definition__c od: [select Id,  name,  Campaign_Project__c, Description__c, Max_Choice__c, Offer_Definition_Type__c, Offer_Employee_Description__c, Offer_Guest_Label__c, Offer_Id__c, Offer_Incentive_Count__c, Offer_Incentive_Group_Count__c from Offer_Definition__c where Id in: offerDefinitionIds
                and Offer_Definition_Type__c != null ]){
                    OfferDefinitionLibraryDTO.OfferDefinition dto = new OfferDefinitionLibraryDTO.OfferDefinition(od);
                    dto.weight = offerMap.get(od.Id).weight;
                    dto.relevance = offerMap.get(od.Id).weight / highestWeight;
                    results.add(dto);
            }
        }

        System.debug('~~~~ final result size: ' + results.size());
        System.debug('~~~~ final result size: ' + results);
        results.sort(); // finally sort it for display


        return results;


    }


}