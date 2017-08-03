/**
 * Created by Michal Bluj on 2017-06-28.
 */

public with sharing class ExternalDataSourceUtil {

    private static Map<String, ExternalDataSourceTable> tableMap = new Map<String, ExternalDataSourceTable>();
    public static Map<String, ExternalDataSourceTable> getTableMap() {
        if (tableMap.isEmpty()) {
            tableMap = constructExternalDataSourceTableMap();
        }
        return tableMap;
    }

    public static Map<String, ExternalDataSourceTable> constructExternalDataSourceTableMap() {
        return new Map<String, ExternalDataSourceTable> {
            'Customer_Info_External__c' => new ExternalDataSourceTable(),
            'Offers_sent' => new ExternalDataSourceTable(),
            'Offers_redeemed' => new ExternalDataSourceTable(),
            'IOTAction' => new ExternalDataSourceTable(),
            'marketing_campaigns' => new ExternalDataSourceTable(),
            'marketing_campaigns_properties' => new ExternalDataSourceTable(),
            'marketing_lvm' => new ExternalDataSourceTable(),
            'marketing_campaigns_weekly' => new ExternalDataSourceTable(),
            'Guest_game_details' => new ExternalDataSourceTable(),
            'Guest_slot_rating_details' => new ExternalDataSourceTable(),
            'Guest_table_rating_details' => new ExternalDataSourceTable(),
            'lms_hotel_activity' => new ExternalDataSourceTable(),
            'lms_folio_hdr' => new ExternalDataSourceTable(),
            'lms_folio_dtl' => new ExternalDataSourceTable(),
            'guest_hotel_activity_vedw' => new ExternalDataSourceTable(),
            'marketing_enterprise_campaign' => new ExternalDataSourceTable(),
            'applogs' => new ExternalDataSourceTable(),
            'pos_trans_discount' => new ExternalDataSourceTable(),
            'pos_trans_hdr' => new ExternalDataSourceTable(),
            'pos_trans_itemizer' => new ExternalDataSourceTable(),
            'pos_trans_line_item' => new ExternalDataSourceTable(),
            'pos_trans_service_charge' => new ExternalDataSourceTable(),
            'pos_trans_tender' => new ExternalDataSourceTable(),
            'customer_control_segments' => new ExternalDataSourceTable(),
            'hotel_act_status_code' => new ExternalDataSourceTable(),
            'hotel_wing_code' => new ExternalDataSourceTable(),
            'lms_source_desc_sda' => new ExternalDataSourceTable(),
            'source_code' => new ExternalDataSourceTable(),
            'lms_room_type_desc_sda' => new ExternalDataSourceTable(),
            'ap_pdb_trip_cms' => new ExternalDataSourceTable(),
            'ap_pdb_trip_cmx' => new ExternalDataSourceTable(),
            'ap_pdb_trip_hdr' => new ExternalDataSourceTable(),
            'ap_pdb_trip_htl' => new ExternalDataSourceTable(),
            'gst_cons_xref' => new ExternalDataSourceTable(),
            'gst_id_xref' => new ExternalDataSourceTable(),
            'pdb_trip' => new ExternalDataSourceTable(),
            'pdb_trip_info' => new ExternalDataSourceTable()
        };
    }

    public static DataSource.Table constructTable(String tableName) {
        ExternalDataSourceTable table = ExternalDataSourceUtil.getTableMap().get(tableName);
        return DataSource.Table.get(tableName, table.getNameColumn(), table.getTableColumns());
    }

    public static List<String> retrieveSupportedTables() {
        return new List<String> {'Customer_Info_External__c',
                                 'Offers_sent',
                                 'Offers_redeemed',
                                 'IOTAction',
                                 'marketing_campaigns',
                                 'marketing_campaigns_properties',
                                 'marketing_lvm',
                                 'marketing_campaigns_weekly',
                                 'Guest_game_details',
                                 'Guest_slot_rating_details',
                                 'Guest_table_rating_details',
                                 'lms_hotel_activity',
                                 'lms_folio_hdr',
                                 'lms_folio_dtl',
                                 'guest_hotel_activity_vedw',
                                 'marketing_enterprise_campaign',
                                 'applogs',
                                 'pos_trans_discount',
                                 'pos_trans_hdr',
                                 'pos_trans_itemizer',
                                 'pos_trans_line_item',
                                 'pos_trans_service_charge',
                                 'pos_trans_tender',
                                 'customer_control_segments',
                                 'hotel_act_status_code',
                                 'hotel_wing_code',
                                 'lms_source_desc_sda',
                                 'source_code',
                                 'lms_room_type_desc_sda',
                                 'ap_pdb_trip_cms',
                                 'ap_pdb_trip_cmx',
                                 'ap_pdb_trip_hdr',
                                 'ap_pdb_trip_htl',
                                 'gst_cons_xref',
                                 'gst_id_xref',
                                 'pdb_trip',
                                 'pdb_trip_info'
                                };
    }
}