/**
 * @author Cezary Zeleznicki
 * @date 31.07.2017.
 * @group Model
 * @description generic class responsible mappign PosTransHdr json response
 */

public with sharing class PosTransHdr extends ExternalObjectResponse implements ExternalObjectInterface {

    public List<Record> body {get; set;}

    public class Record {
        public String id {get; set;}

        public final String c_file_prop_cd {get; set;}
        public final String c_pos_employee_name {get; set;}
        public final String c_pos_rev_center_cd {get; set;}
        public final String c_pos_trans_id {get; set;}
        public final String c_prop_cd {get; set;}
        public final String c_quality_cd {get; set;}
        public final String c_trans_type_cd {get; set;}
        public final String d_pos_trans_dt {get; set;}
        public final String d_pos_trans_end_time {get; set;}
        public final String d_pos_trans_start_time {get; set;}
        public final String d_timestamp {get; set;}
        public final Decimal f_beer_amt {get; set;}
        public final Decimal f_cash_chrg_amt {get; set;}
        public final Decimal f_discount_amt {get; set;}
        public final Decimal f_food_amt {get; set;}
        public final Decimal f_liq_amt {get; set;}
        public final Decimal f_misc_amt {get; set;}
        public final Decimal f_na_bev_amt {get; set;}
        public final Decimal f_oth_amt {get; set;}
        public final Decimal f_other_payment_amt {get; set;}
        public final Decimal f_pos_comp_amt {get; set;}
        public final Decimal f_retail_amt {get; set;}
        public final Decimal f_room_chrg_amt {get; set;}
        public final Decimal f_service_charge_amt {get; set;}
        public final Decimal f_sub_total_amt {get; set;}
        public final Decimal f_tax_amt {get; set;}
        public final Decimal f_tax_discount_oth_amt {get; set;}
        public final Decimal f_total_item_amt {get; set;}
        public final Decimal f_total_payment_amt {get; set;}
        public final Decimal f_trans_amt {get; set;}
        public final Decimal f_wine_amt {get; set;}
        public final Integer i_check_nbr {get; set;}
        public final Integer i_covers {get; set;}
        public final Integer i_line_item_qty {get; set;}
        public final Integer i_nbr_line_item {get; set;}
        public final Integer i_open_from_check_nbr {get; set;}
        public final Integer i_order_nbr {get; set;}
        public final Integer i_pos_employee_nbr {get; set;}
        public final String i_table_nbr {get; set;}
        public final String i_xref_dmid {get; set;}
    }

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (PosTransHdr.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('c_file_prop_cd', wrapper.c_file_prop_cd);
            row.put('c_pos_employee_name', wrapper.c_pos_employee_name);
            row.put('c_pos_rev_center_cd', wrapper.c_pos_rev_center_cd);
            if(MapHandler.getRevenueCenterObjectMap().get(wrapper.c_pos_rev_center_cd) != null){
                row.put('c_pos_rev_center_cd_fk', MapHandler.getRevenueCenterObjectMap().get(wrapper.c_pos_rev_center_cd).id);
            }
            row.put('c_pos_trans_id', wrapper.c_pos_trans_id);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            if(MapHandler.getPropertyCodeObjectMap().get(wrapper.c_prop_cd) != null){
                row.put('c_prop_cd_fk', MapHandler.getPropertyCodeObjectMap().get(wrapper.c_prop_cd).id);
            }
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('c_trans_type_cd', wrapper.c_trans_type_cd);
            row.put('d_pos_trans_dt', wrapper.d_pos_trans_dt);
            row.put('d_pos_trans_end_time', wrapper.d_pos_trans_end_time);
            row.put('d_pos_trans_start_time', wrapper.d_pos_trans_start_time);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('f_beer_amt', wrapper.f_beer_amt);
            row.put('f_cash_chrg_amt', wrapper.f_cash_chrg_amt);
            row.put('f_discount_amt', wrapper.f_discount_amt);
            row.put('f_food_amt', wrapper.f_food_amt);
            row.put('f_liq_amt', wrapper.f_liq_amt);
            row.put('f_misc_amt', wrapper.f_misc_amt);
            row.put('f_na_bev_amt', wrapper.f_na_bev_amt);
            row.put('f_oth_amt', wrapper.f_oth_amt);
            row.put('f_other_payment_amt', wrapper.f_other_payment_amt);
            row.put('f_pos_comp_amt', wrapper.f_pos_comp_amt);
            row.put('f_retail_amt', wrapper.f_retail_amt);
            row.put('f_room_chrg_amt', wrapper.f_room_chrg_amt);
            row.put('f_service_charge_amt', wrapper.f_service_charge_amt);
            row.put('f_sub_total_amt', wrapper.f_sub_total_amt);
            row.put('f_tax_amt', wrapper.f_tax_amt);
            row.put('f_tax_discount_oth_amt', wrapper.f_tax_discount_oth_amt);
            row.put('f_total_item_amt', wrapper.f_total_item_amt);
            row.put('f_total_payment_amt', wrapper.f_total_payment_amt);
            row.put('f_trans_amt', wrapper.f_trans_amt);
            row.put('f_wine_amt', wrapper.f_wine_amt);
            row.put('i_check_nbr', wrapper.i_check_nbr);
            row.put('i_covers', wrapper.i_covers);
            row.put('i_line_item_qty', wrapper.i_line_item_qty);
            row.put('i_nbr_line_item', wrapper.i_nbr_line_item);
            row.put('i_open_from_check_nbr', wrapper.i_open_from_check_nbr);
            row.put('i_order_nbr', wrapper.i_order_nbr);
            row.put('i_pos_employee_nbr', wrapper.i_pos_employee_nbr);
            row.put('i_table_nbr', wrapper.i_table_nbr);
            row.put('i_xref_dmid', wrapper.i_xref_dmid);
            rows.add(row);
        }
        return rows;
    }
}