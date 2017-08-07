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
        'caesars$hotel_event' => 'hotel_event'
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
        'caesars$hotel_event' => 'HotelEvent'
    };

    private static Map<String, Id> acquisitionCodeMap = null;
    private static Map<String, Id> associationReasonCodeMap = null;

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

}