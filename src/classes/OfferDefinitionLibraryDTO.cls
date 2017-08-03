/**
 *  @author Ivan Yeung
 *  @date 07/12/2017
 *  @group DTO
 *  @description  data transfer object to supprt the offer definiton library features
 */


public with sharing class OfferDefinitionLibraryDTO {

    public static final String PROPERTY_CODE_ALL = 'All'; // special value to represent all properties in search critiera
    public static final String CATEGORY_CODE_ALL = 'All';
    public static final String SUBCATEGORY_CODE_ALL = 'All';


    /**
    * @description - the dto of offer defintion, it can be used as of list of offer for search result. It can also be used as offer detail display
    */
    public class OfferDefinition implements Comparable {

        public string campaignProjectId; // the campaign project where this offer definition is associated with
        public String name;
        public String id; // offer definition record id
        public String offerId; // base60 string for display
        public Integer maxChoice;
        public String offerDefinitionType; // Choice or Package offer definition
        public String description;
        public String guestLabel;
        public String employeeDescription;
        public Integer offerIncentiveCount;
        public Integer offerIncentiveGroupCount;
        public boolean ottr;

        public List<OfferIncentiveGroup> offerIncentiveGroups;
        public List<OfferIncentive> offerIncentives;

        public Integer weight; // for sorting
        public decimal relevance; // relevance score for the search result. the vaule is from 0 to 1. the highest the number the more relevant. For this display, we should show as percentage.

        /**
        *  @description compare method so that the higher weight come first
         */
        public Integer compareTo(Object compareTo) {

            OfferDefinition offer = (OfferDefinition)compareTo;
            Integer weightA = this.weight == null ? 0 : this.weight;
            Integer weightB = offer.weight == null ? 0 : offer.weight;

            return weightB - weightA;

        }

        // default constructor
        public OfferDefinition(){}

        public OfferDefinition(Offer_Definition__c od){
            campaignProjectId = od.Campaign_Project__c;
            name = od.name;
            id = od.Id;
            offerId = od.Offer_Id__c;
            maxChoice = od.Max_Choice__c.intValue();
            offerDefinitionType = od.Offer_Definition_Type__c;
            description = String.isBlank(od.Description__c)?od.Offer_Id__c: od.Description__c ;
            // to do: confirm label and desc mapping
            guestLabel = String.isBlank(od.Offer_Guest_Label__c)?od.Offer_Id__c: od.Offer_Guest_Label__c ;
            employeeDescription = String.isBlank(od.Offer_Employee_Description__c)?od.Offer_Id__c: od.Offer_Employee_Description__c ;

        }

        // only map those fields used for udpate / insert
        public Offer_Definition__c ToObject(){

            Offer_Definition__c offer = new Offer_Definition__c();
            offer.id = id;
            offer.Campaign_Project__c = campaignProjectId;
            offer.Offer_Definition_Type__c = offerDefinitionType;
            offer.Description__c = description;
            offer.Offer_Guest_Label__c = guestLabel;
            offer.Offer_Employee_Description__c = employeeDescription;

            return offer;

        }


        }


    /**
    * @description DTO class for Offer_Incentive_Group__c object
    */
    public class OfferIncentiveGroup {

        public String id; // offer incentive group recordId;
        public String name;
        public String offerDefinitionId;
        // public String offerIncentiveGroupId; // base 30 id for display
        public String offerIncentiveGroupLabel;
        public Integer maxChoice;

        public List <OfferIncentive> offerIncentives;

        public OfferIncentiveGroup(){}

        public OfferIncentiveGroup(Offer_Incentive_Group__c o ){
            id = o.Id;
            name = o.name;
            offerDefinitionId = o.Offer_Definition__c;
            offerIncentiveGroupLabel = String.isBlank(o.Offer_Incentive_Group_Label__c)? o.name: o.Offer_Incentive_Group_Label__c;
            maxChoice = o.Max_Choice__c == null? 1: Integer.valueOf(o.Max_Choice__c);
        }

        // only map those fields used for udpate / insert
        public Offer_Incentive_Group__c ToObject(){
            Offer_Incentive_Group__c o = new Offer_Incentive_Group__c(Offer_Definition__c = offerDefinitionId);
            o.Id = id;
            o.Offer_Incentive_Group_Label__c = offerIncentiveGroupLabel;
            o.Max_Choice__c = String.valueOf(  maxChoice) ; // max Choice is a picklist

            return o;
        }

    }



    /**
    * @description DTO class for Offer_Incentive__c object
    */
    public class OfferIncentive {

        public String id; // offer incentive recordId;
        public String name;
        public String offerIncentiveGroupId;
        public String offerDefinitionId;
        public String offerIncentiveId; // base 30 id for display
        public Decimal amount;
        String offerIncentiveCategory;
        String offerIncentiveSubcategory;
        public String guestDescription;
        public String guestLabel;
        public String employeeDescription;
        public String market;
        public Date validStartDate;
        public Date validEndDate;
        public Integer maxRedemption;

        public OfferIncentive(){}

        public OfferIncentive(Offer_Incentive__c o){
            id = o.id;
            name = o.name;
            offerIncentiveGroupId = o.Offer_Incentive_Group__c;
            offerDefinitionId = o.Offer_Definition__c;
            offerIncentiveId = o.Offer_Incentive_Id__c;  // base 30 id
            amount = o.Amount__c;
            offerIncentiveCategory = o.Offer_Incentive_Category__c;
            offerIncentiveSubcategory = o.Offer_Incentive_Subcategory__c;
            guestDescription = String.isBlank(o.Guest_Description__c)? o.Offer_Incentive_Id__c: o.Guest_Description__c ;
            guestLabel = String.isBlank(o.Guest_Description__c)? o.Offer_Incentive_Id__c: o.Guest_Description__c ; // TO DO: MAP TO NEW FIELD
            employeeDescription = String.isBlank(o.Employee_Description__c)? o.Offer_Incentive_Id__c: o.Employee_Description__c ;
            market = o.Market__c;
            validEndDate = o.Valid_End_Date__c;
            validStartDate = o.Valid_Start_Date__c;
            maxRedemption = Integer.valueOf(o.Max_Redemption__c);
        }

        public Offer_Incentive__c ToObject(){

            Offer_Incentive__c o = new Offer_Incentive__c();
            o.id = id;
            o.Offer_Incentive_Group__c = offerIncentiveGroupId;
            o.Offer_Definition__c = offerDefinitionId;
            o.Amount__c = amount;
            o.Offer_Incentive_Category__c = offerIncentiveCategory;
            o.Offer_Incentive_Subcategory__c = offerIncentiveSubcategory;
            o.Guest_Description__c = guestDescription;
            // o.Guest_Label__c guestLabel;  TBD
            o.Employee_Description__c = employeeDescription;
            o.Valid_Start_Date__c = validStartDate;
            o.Valid_End_Date__c = validEndDate;
            o.Max_Redemption__c = String.valueOf(maxRedemption);

            return o;
        }

    }

    /**
    * @description provide the data structure for the search paramters. It is meant to provide to input for the search functions
    */
    public class SearchParamters {

        // NOTE: if the user choose 'All' , return all the items in the list. in the futuer, we might allow mulit-pick

        public List <String> property; // assume it is single property for now
        public List <String> incentiveCategory; // this is the incentive category code, not the descripiton value
        public List <String> incentiveSubCategory;
        public String offerDescription; // search the offer label, offer incentive or offer incentive group
        

    }


    /**
    * @description provide the data structure for the search critiera. It is meant to provide search critiera to be displayed in Offer Definition Library
    */
    public class SearchCriteria {

        // String market;
        // Date validStartDate;
        // Date validEndDate;
        public Map <String, String> properties; // key=propery code, value = property descriptino for display
        public Map <String, String> incentiveCategories; // key=category code, value = incentive category desc
        public Map <String, String> incentiveSubCategories; // key=subcategory code, value = incentive Sub category desc
        public String offerDescription; // offer description or offer label search string
        

    }


    public static final Integer STATUS_SERVER_ERROR_CODE = 500;
    public static final Integer STATUS_OK = 200;
    /**
    * @description  service status
    *     status code will use http status convention
    *         1xx Informational responses
    *         2xx Success
    *         5xx Server errors
     */
    public class Status {
        public Integer statusCode;
        public String statusDescription;
    }

}