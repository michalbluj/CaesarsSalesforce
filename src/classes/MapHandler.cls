/**
* @author Michał Bluj
* @date 2017
* @group Utils
* @description Class responsible for holding frequently used maps
**/
public with sharing class MapHandler {

    public static final Map<String, String> EXTERNAL_OBJECT_TO_TABLE_MAP = new Map<String, String> {
        'caesars$offers_sent' => 'offers_sent',
        'caesars$offers_redeemed' => 'offers_redeemed',
        'caesars$iot_action' => 'iot_action',
        'caesars$marketing_campaigns' => 'marketing_campaigns',
        'caesars$marketing_campaigns_properties' => 'marketing_campaigns_properties',
        'caesars$marketing_campaigns_weekly' => 'marketing_campaigns_weekly',
        'caesars$marketing_campaigns_lvm' => 'marketing_campaigns_lvm',
        'caesars$marketing_campaigns_enterprise' => 'marketing_campaigns_enterprise',
        'caesars$gst_game_dtl' => 'gst_game_dtl',
        'caesars$gst_slot_rating_dtl' => 'gst_slot_rating_dtl',
        'caesars$gst_table_rating_dtl' => 'gst_table_rating_dtl',
        'caesars$lms_hotel_activity' => 'lms_hotel_activity',
        'caesars$lms_folio_hdr' => 'lms_folio_hdr',
        'caesars$lms_folio_dtl' => 'lms_folio_dtl',
        'caesars$gst_hotel_activity_vedw' => 'gst_hotel_activity_vedw',
        'caesars$marketing_enterprise_campaign' => 'marketing_enterprise_campaign',
        'public$applogs' => 'applogs',
        'caesars$pos_trans_discount' => 'pos_trans_discount',
        'caesars$pos_trans_hdr' => 'pos_trans_hdr',
        'caesars$pos_trans_itemizer' => 'pos_trans_itemizer',
        'caesars$pos_trans_line_item' => 'pos_trans_line_item',
        'caesars$pos_trans_service_charge' => 'pos_trans_service_charge',
        'caesars$pos_trans_tender' => 'pos_trans_tender',
        'caesars$ap_pdb_trip_cms' => 'ap_pdb_trip_cms',
        'caesars$ap_pdb_trip_cmx' => 'ap_pdb_trip_cmx',
        'caesars$ap_pdb_trip_hdr' => 'ap_pdb_trip_hdr',
        'caesars$ap_pdb_trip_htl' => 'ap_pdb_trip_htl',
        'caesars$gst_cons_xref' => 'gst_cons_xref',
        'caesars$gst_id_xref' => 'gst_id_xref',
        'caesars$pdb_trip' => 'pdb_trip',
        'caesars$pdb_trip_info' => 'pdb_trip_info',
        'caesars$comp_detail' => 'comp_detail',
        'caesars$hotel_event' => 'hotel_event',
        'caesars$gst_pdb_trip_day_dtl_bidl' => 'gst_pdb_trip_day_dtl_bidl',
        'caesars$iot_events' => 'iot_events'
    };

    public static final Map<String, String> EXTERNAL_TABLE_TO_CLASSNAME_MAP = new Map<String, String> {
        'caesars$offers_sent' => 'OfferSent',
        'caesars$offers_redeemed' => 'OfferRedeemed',
        'caesars$iot_action' => 'IOTAction',
        'caesars$marketing_campaigns' => 'MarketingCampaign',
        'caesars$marketing_campaigns_properties' => 'MarketingCampaignProperty',
        'caesars$marketing_campaigns_lvm' => 'MarketingLVM',
        'caesars$marketing_campaigns_weekly' => 'MarketingCampaignWeekly',
        'caesars$marketing_campaigns_enterprise' => 'EnterpriseCampaign',
        'caesars$gst_game_dtl' => 'GuestGameDetail',
        'caesars$gst_slot_rating_dtl' => 'GuestSlotRatingDetail',
        'caesars$gst_table_rating_dtl' => 'GuestTableRatingDetail',
        'caesars$lms_hotel_activity' => 'LmsHotelActivity',
        'caesars$lms_folio_hdr' => 'LmsFolioHdr',
        'caesars$lms_folio_dtl' => 'LmsFolioDtl',
        'caesars$gst_hotel_activity_vedw' => 'GuestHotelActivityVedw',
        'public$applogs' => 'AppLog',
        'caesars$pos_trans_discount' => 'PosTransDiscount',
        'caesars$pos_trans_hdr' => 'PosTransHdr',
        'caesars$pos_trans_itemizer' => 'PosTransItemizer',
        'caesars$pos_trans_line_item' => 'PosTransLineItem',
        'caesars$pos_trans_service_charge' => 'PosTransServiceCharge',
        'caesars$pos_trans_tender' => 'PosTransTender',
        'caesars$ap_pdb_trip_cms' => 'ApPdbTripCms',
        'caesars$ap_pdb_trip_cmx' => 'ApPdbTripCmx',
        'caesars$ap_pdb_trip_hdr' => 'ApPdbTripHdr',
        'caesars$ap_pdb_trip_htl' => 'ApPdbTripHtl',
        'caesars$gst_cons_xref' => 'GstConsXref',
        'caesars$gst_id_xref' => 'GstIdXref',
        'caesars$pdb_trip' => 'PdbTrip',
        'caesars$pdb_trip_info' => 'PdbTripInfo',
        'caesars$comp_detail' => 'CompDetail',
        'caesars$hotel_event' => 'HotelEvent',
        'caesars$gst_pdb_trip_day_dtl_bidl' => 'GstPdbTripDayDtlBidl',
        'caesars$iot_events' => 'IOTEvent'
    };

    private static Map<String, Id> acquisitionCodeMap = null;
    private static Map<String, Acquisition_Code__c> acquisitionCodeObjectMap = null;
    
    private static Map<String, Id> associationReasonCodeMap = null;
    private static Map<String, Association_Reason__c> associationReasonCodeObjectMap = null;
    
    private static Map<String, Interest_Description__c> interestDescriptionCodeObjectMap = null;
    
    private static Map<String, Zip_Description__c> zipDescriptionCodeObjectMap = null;
    
    private static Map<String, Account> propertyCodeObjectMap = null;

    private static Map<String, POS_Revenue_Center__c> revenueCenterObjectMap = null;

    /*
    * @description Builds map of acquisition codes
    * @return Acquisition codes map
    */
    public static Map<String, Id> getAcquisitionCodeMap() {
        if (acquisitionCodeMap == null) {
            acquisitionCodeMap = new Map<String, Id>();
            for (Acquisition_Code__c code : [select id , name from Acquisition_Code__c]) {
                acquisitionCodeMap.put(code.name, code.id);
            }
        }
        return acquisitionCodeMap;
    }
    
    /*
    * @description Builds map of acquisition codes
    * @return Acquisition codes map
    */
    public static Map<String, Acquisition_Code__c> getAcquisitionCodeObjectMap() {
        if (acquisitionCodeObjectMap == null) {
            acquisitionCodeObjectMap = new Map<String, Acquisition_Code__c>();
            Map<String,sObject> sObjectMap = CacheUtils.getMapFromCache('Acquisition_Code__c',new List<String>{'Id','name'});
            for (String code : sObjectMap.keySet()) {
                acquisitionCodeObjectMap.put(code,(Acquisition_Code__c)sObjectMap.get(code));
            }
        }
        return acquisitionCodeObjectMap;
    }

    /*
    * @description Builds map of association reasons
    * @return Association reasons map
    */
    public static Map<String, Id> getAssociationReasonMap() {
        if (associationReasonCodeMap == null) {
            associationReasonCodeMap = new Map<String, Id>();
            for (Association_Reason__c code : [select id , name from Association_Reason__c]) {
                associationReasonCodeMap.put(code.name, code.id);
            }
        }
        return associationReasonCodeMap;
    }
    
    /*
    * @description Builds map of association reasons
    * @return Association reasons map
    */
    public static Map<String, Association_Reason__c> getAssociationReasonObjectMap() {
        if (associationReasonCodeObjectMap == null) {
            associationReasonCodeObjectMap = new Map<String, Association_Reason__c>();
            Map<String,sObject> sObjectMap = CacheUtils.getMapFromCache('Association_Reason__c',new List<String>{'Id','name'});
            for (String code : sObjectMap.keySet()) {
                associationReasonCodeObjectMap.put(code,(Association_Reason__c)sObjectMap.get(code));
            }
        }
        return associationReasonCodeObjectMap;
    }
    
    /*
    * @description Builds map of interest descriptions
    * @return Iterest description map
    */
    public static Map<String, Interest_Description__c> getInterestDescriptionCodeObjectMap() {
    	if (interestDescriptionCodeObjectMap == null) {
            Map<String,sObject> sObjectMap = CacheUtils.getMapFromCache('Interest_Description__c',new List<String>{'Id','name'});
            interestDescriptionCodeObjectMap = new Map<String, Interest_Description__c>();
            for (String code : sObjectMap.keySet()) {
                interestDescriptionCodeObjectMap.put(code,(Interest_Description__c)sObjectMap.get(code));
            }
        }
        return interestDescriptionCodeObjectMap;
    }
    
    
    /*
    * @description Builds map of zip descriptions
    * @return Zip description map
    */
    public static Map<String, Zip_Description__c> getZipDescriptionCodeObjectMap() {
    	if (zipDescriptionCodeObjectMap == null) {
            Map<String,sObject> sObjectMap = CacheUtils.getMapFromCache('Zip_Description__c',new List<String>{'Id','name'});
            zipDescriptionCodeObjectMap = new Map<String, Zip_Description__c>();
            for (String code : sObjectMap.keySet()) {
                zipDescriptionCodeObjectMap.put(code,(Zip_Description__c)sObjectMap.get(code));
            }
        }
        return zipDescriptionCodeObjectMap;
    }
    
    /*
    * @description Builds map of properties
    * @return Zip description map
    */
    public static Map<String, Account> getPropertyCodeObjectMap(){
    	if(propertyCodeObjectMap == null){
    		propertyCodeObjectMap = new Map<String, Account>();
    		for(Account acc : [select id, property_code__c from Account where recordType.name = 'Property']){
    			propertyCodeObjectMap.put(acc.property_code__c, acc);
    		}
    	}
    	return propertyCodeObjectMap;
    }

    /*
    * @description Builds map of pos revenue center
    * @return Rev center map
    */
    public static Map<String, POS_Revenue_Center__c> getRevenueCenterObjectMap(){
        if(revenueCenterObjectMap == null){
            revenueCenterObjectMap = new Map<String, POS_Revenue_Center__c>();
            Map<String,sObject> sObjectMap = CacheUtils.getMapFromCache('POS_Revenue_Center__c',new List<String>{'Id','name'});
            for(String code : sObjectMap.keySet()){
                revenueCenterObjectMap.put(code,(POS_Revenue_Center__c)sObjectMap.get(code));
            }
        }
        return revenueCenterObjectMap;
    }

}