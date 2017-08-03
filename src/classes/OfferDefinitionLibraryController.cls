/**
 *  @author Ivan Yeung
 *  @date 07/12/2017
 *  @group Controller
 *  @description  controller for the offer definition library feature.
 */


public with sharing class OfferDefinitionLibraryController {



    /**
    * @description callback
    * @param  a JSON representation of OfferDefinition.searchParamters
    * @return String, a JSON representation of an array of OfferDefinitionLibraryDTO.OfferDefinition objects
    */
    @AuraEnabled
    public static String searchOffers( String strSearchParamter
    ) {
        OfferDefinitionLibraryDTO.SearchParamters searchParameters = (OfferDefinitionLibraryDTO.SearchParamters) JSON.deserialize(strSearchParamter, OfferDefinitionLibraryDTO.SearchParamters.Class );
        system.debug(searchParameters);
        List <OfferDefinitionLibraryDTO.OfferDefinition> results = OfferDefinitionLibraryService.searchOffers(searchParameters);

        return JSON.serialize(results);

    }

    /**
    * @description callback
    * @param  a JSON representation of OfferDefinition.searchParamters
    * @return String, a JSON representation of OfferDefinitionLibraryDTO.OfferDefinition, including all the children offer incentives
    */
    @AuraEnabled
    public static String getOfferDetails( String offerDefinitionId)
    {

        OfferDefinitionLibraryDTO.OfferDefinition result = OfferDefinitionLibraryService.getOfferDetails(offerDefinitionId);
       // return result;
        //string resultval = '{"weight":null,"relevance":null,"ottr":null,"offerIncentives":[{"validStartDate":null,"validEndDate":null,"offerIncentiveSubcategory":"EA","offerIncentiveId":null,"offerIncentiveGroupId":"a1g0v0000000YT8AAM","offerIncentiveCategory":"AM","offerDefinitionId":"a1J0v0000008XO0EAM","maxRedemption":1,"market":"TEST","id":"a1f0v0000001QxbAAE","guestLabel":"parent1","guestDescription":null,"employeeDescription":null,"amount":null},{"validStartDate":null,"validEndDate":null,"offerIncentiveSubcategory":"CM","offerIncentiveId":null,"offerIncentiveGroupId":"a1g0v0000000YT8AAM","offerIncentiveCategory":"CM","offerDefinitionId":"a1J0v0000008XO0EAM","maxRedemption":1,"market":"TEST","id":"a1f0v0000001QxqAAE","guestLabel":"parent2","guestDescription":null,"employeeDescription":null,"amount":null}],"offerIncentiveGroups":[{"offerIncentives":[{"validStartDate":null,"validEndDate":null,"offerIncentiveSubcategory":"EA","offerIncentiveId":null,"offerIncentiveGroupId":"a1g0v0000000YT8AAM","offerIncentiveCategory":"AM","offerDefinitionId":"a1J0v0000008XO0EAM","maxRedemption":1,"market":"TEST","id":"a1f0v0000001QxbAAE","guestLabel":"child1","guestDescription":null,"employeeDescription":null,"amount":null},{"validStartDate":null,"validEndDate":null,"offerIncentiveSubcategory":"CM","offerIncentiveId":null,"offerIncentiveGroupId":"a1g0v0000000YT8AAM","offerIncentiveCategory":"CM","offerDefinitionId":"a1J0v0000008XO0EAM","maxRedemption":1,"market":"TEST","id":"a1f0v0000001QxqAAE","guestLabel":"child2","guestDescription":null,"employeeDescription":null,"amount":null}],"offerIncentiveGroupLabel":"parent3","offerDefinitionId":"a1J0v0000008XO0EAM","maxChoice":0,"id":"a1g0v0000000YT8AAM"}],"offerIncentiveGroupCount":null,"offerIncentiveCount":null,"offerId":"40016","offerDefinitionType":null,"maxChoice":1,"id":"a1J0v0000008XO0EAM","guestLabel":"granparent","employeeDescription":null,"description":"percentage off hotel rate","campaignProjectId":"a140v0000004jTVAAY"}';
        string resultval =JSON.serialize(result);
       OfferDefinitionLibraryController pasedJson = (OfferDefinitionLibraryController) System.JSON.deserialize(resultval, OfferDefinitionLibraryController.class);
        
            OfferDefinitionGP offGP = new OfferDefinitionGP();
            offGP.guestLabel = pasedJson.guestLabel;
            List<offerIncentivesParent> PList = new List<offerIncentivesParent>();
        for(cls_offerIncentives offRec : pasedJson.offerIncentives){
            offerIncentivesParent offP = new offerIncentivesParent();
            offP.guestLabel = offRec.guestLabel;  
            PList.add(offP);
        }
        for(cls_offerIncentiveGroups offRecGroup : pasedJson.offerIncentiveGroups){
            offerIncentivesParent offP = new offerIncentivesParent();
            offP.guestLabel = offRecGroup.offerIncentiveGroupLabel; 
            PList.add(offP);
            List<offerIncentivesChild> CHList = new List<offerIncentivesChild>();
            for(cls_offerIncentives offRecGroupCh : offRecGroup.offerIncentives){
                offerIncentivesChild offCh = new offerIncentivesChild();
                offCh.guestLabel = offRecGroupCh.guestLabel;  
                CHList.add(offCh);
            }
            offP.offerIncentivesChild = CHList;
        }
        offGP.offerIncentivesParent = PList;
        system.debug('offGP-->'+JSON.serialize(offGP));
        //return JSON.serialize(result);
       return JSON.serialize(offGP);
     }


    /**
    * @description callback
    * @param  the record id of the campaign project id that the offer defintion will be copied into.  a json string of the OfferDefinitionLibraryDTO.OfferDefinition
    * @return String : JSON string of OfferDefinitionLibraryDTO.Status
    */
    @AuraEnabled
    public static String copyOfferDefinition(String campaignProjectId, String offerDefinitionDTO
    ) {

        OfferDefinitionLibraryDTO.OfferDefinition offerDef = (OfferDefinitionLibraryDTO.OfferDefinition) JSON.deserialize(offerDefinitionDTO, OfferDefinitionLibraryDTO.OfferDefinition.Class );
        OfferDefinitionLibraryDTO.Status status = OfferDefinitionLibraryService.copyOfferDefinition( campaignProjectId , offerDef);
        return JSON.serialize(status);

    }

    /**
    * @description callback
    * @param  the record id of the campaign project id
    * @return String, a JSON representation of  OfferDefinition.searchCritiera objects
    */
    @AuraEnabled
    public static String listSearchCriteria( String campaignProjectId
    ) {

        OfferDefinitionLibraryDTO.SearchCriteria dto = OfferDefinitionLibraryService.getSearchCriteria(campaignProjectId);

        return JSON.serialize(dto);

    }
    
    public class OfferDefinitionGP{
        @AuraEnabled
        public string guestLabel{get;set;}
        @AuraEnabled
        public List<offerIncentivesParent> offerIncentivesParent{get;set;}
    }
    public class offerIncentivesParent{
        @AuraEnabled
        public string guestLabel{get;set;}
        @AuraEnabled
        public List<offerIncentivesChild> offerIncentivesChild{get;set;}
    }
    public class offerIncentivesChild{
        @AuraEnabled
        public string guestLabel{get;set;}
    }
    
    public List<cls_offerIncentives> offerIncentives;
    public List<cls_offerIncentiveGroups> offerIncentiveGroups;
    public String guestLabel;   //granparent
    public class cls_offerIncentives {
        public String guestLabel;   //child1
    }
    public class cls_offerIncentiveGroups {
        public List<cls_offerIncentives> offerIncentives;
        public String offerIncentiveGroupLabel;
    }
}