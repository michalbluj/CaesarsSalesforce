/**
 * @author Cezary Zeleznicki
 * @date 31.07.2017.
 * @group Model
 * @description generic class responsible mappign PdbTripInfo json response
 */

public with sharing class PdbTripInfo extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public String id {get; set;}

        public final String account_c_prop_cd_fk {get; set;}
        public final String c_prop_cd {get; set;}
        public final String c_user_flag_1 {get; set;}
        public final String c_user_flag_2 {get; set;}
        public final String c_user_flag_3 {get; set;}
        public final String c_user_flag_4 {get; set;}
        public final String contact_fk {get; set;}
        public final String d_end_dt {get; set;}
        public final String d_start_dt {get; set;}
        public final Decimal f_cash_cost {get; set;}
        public final Decimal f_cash_value {get; set;}
        public final Decimal f_cashless_cost {get; set;}
        public final Decimal f_cashless_value {get; set;}
        public final Decimal f_exl_from_profitb_value {get; set;}
        public final Decimal f_hotel_cost {get; set;}
        public final Decimal f_hotel_value {get; set;}
        public final Decimal f_other_cost1 {get; set;}
        public final Decimal f_other_cost2 {get; set;}
        public final Decimal f_other_cost3 {get; set;}
        public final Decimal f_other_cost4 {get; set;}
        public final Decimal f_other_cost5 {get; set;}
        public final Decimal f_other_cost {get; set;}
        public final Decimal f_other_value {get; set;}
        public final Decimal f_total_cost {get; set;}
        public final Decimal f_trip_value1 {get; set;}
        public final Decimal f_trip_value2 {get; set;}
        public final Decimal f_trip_value3 {get; set;}
        public final Decimal f_trip_value4 {get; set;}
        public final Decimal f_trip_value5 {get; set;}
        public final Decimal f_user_amt_10 {get; set;}
        public final Decimal f_user_amt_1 {get; set;}
        public final Decimal f_user_amt_2 {get; set;}
        public final Decimal f_user_amt_3 {get; set;}
        public final Decimal f_user_amt_4 {get; set;}
        public final Decimal f_user_amt_5 {get; set;}
        public final Decimal f_user_amt_6 {get; set;}
        public final Decimal f_user_amt_7 {get; set;}
        public final Decimal f_user_amt_8 {get; set;}
        public final Decimal f_user_amt_9 {get; set;}
        public final Integer i_cash_coup {get; set;}
        public final Integer i_cashless_coup {get; set;}
        public final String i_dmid {get; set;}
        public final Integer i_exl_from_profitb_coup {get; set;}
        public final Integer i_hotel_coup {get; set;}
        public final Integer i_offers {get; set;}
        public final Integer i_other_coup {get; set;}
        public final String i_pdb_trip_id {get; set;}
        public final Integer i_pdb_trip_id_fk {get; set;}
        public final Integer i_total_coup {get; set;}
        public final Integer i_user_score_10 {get; set;}
        public final Integer i_user_score_1 {get; set;}
        public final Integer i_user_score_2 {get; set;}
        public final Integer i_user_score_3 {get; set;}
        public final Integer i_user_score_4 {get; set;}
        public final Integer i_user_score_5 {get; set;}
        public final Integer i_user_score_6 {get; set;}
        public final Integer i_user_score_7 {get; set;}
        public final Integer i_user_score_8 {get; set;}
        public final Integer i_user_score_9 {get; set;}
    }

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (PdbTripInfo.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('account_c_prop_cd_fk', wrapper.account_c_prop_cd_fk);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_user_flag_1', wrapper.c_user_flag_1);
            row.put('c_user_flag_2', wrapper.c_user_flag_2);
            row.put('c_user_flag_3', wrapper.c_user_flag_3);
            row.put('c_user_flag_4', wrapper.c_user_flag_4);
            row.put('contact_fk', wrapper.contact_fk);
            row.put('d_end_dt', wrapper.d_end_dt);
            row.put('d_start_dt', wrapper.d_start_dt);
            row.put('f_cash_cost', wrapper.f_cash_cost);
            row.put('f_cash_value', wrapper.f_cash_value);
            row.put('f_cashless_cost', wrapper.f_cashless_cost);
            row.put('f_cashless_value', wrapper.f_cashless_value);
            row.put('f_exl_from_profitb_value', wrapper.f_exl_from_profitb_value);
            row.put('f_hotel_cost', wrapper.f_hotel_cost);
            row.put('f_hotel_value', wrapper.f_hotel_value);
            row.put('f_other_cost1', wrapper.f_other_cost1);
            row.put('f_other_cost2', wrapper.f_other_cost2);
            row.put('f_other_cost3', wrapper.f_other_cost3);
            row.put('f_other_cost4', wrapper.f_other_cost4);
            row.put('f_other_cost5', wrapper.f_other_cost5);
            row.put('f_other_cost', wrapper.f_other_cost);
            row.put('f_other_value', wrapper.f_other_value);
            row.put('f_total_cost', wrapper.f_total_cost);
            row.put('f_trip_value1', wrapper.f_trip_value1);
            row.put('f_trip_value2', wrapper.f_trip_value2);
            row.put('f_trip_value3', wrapper.f_trip_value3);
            row.put('f_trip_value4', wrapper.f_trip_value4);
            row.put('f_trip_value5', wrapper.f_trip_value5);
            row.put('f_user_amt_10', wrapper.f_user_amt_10);
            row.put('f_user_amt_1', wrapper.f_user_amt_1);
            row.put('f_user_amt_2', wrapper.f_user_amt_2);
            row.put('f_user_amt_3', wrapper.f_user_amt_3);
            row.put('f_user_amt_4', wrapper.f_user_amt_4);
            row.put('f_user_amt_5', wrapper.f_user_amt_5);
            row.put('f_user_amt_6', wrapper.f_user_amt_6);
            row.put('f_user_amt_7', wrapper.f_user_amt_7);
            row.put('f_user_amt_8', wrapper.f_user_amt_8);
            row.put('f_user_amt_9', wrapper.f_user_amt_9);
            row.put('i_cash_coup', wrapper.i_cash_coup);
            row.put('i_cashless_coup', wrapper.i_cashless_coup);
            row.put('i_dmid', wrapper.i_dmid);
            row.put('i_exl_from_profitb_coup', wrapper.i_exl_from_profitb_coup);
            row.put('i_hotel_coup', wrapper.i_hotel_coup);
            row.put('i_offers', wrapper.i_offers);
            row.put('i_other_coup', wrapper.i_other_coup);
            row.put('i_pdb_trip_id', wrapper.i_pdb_trip_id);
            row.put('i_pdb_trip_id_fk', wrapper.i_pdb_trip_id_fk);
            row.put('i_total_coup', wrapper.i_total_coup);
            row.put('i_user_score_10', wrapper.i_user_score_10);
            row.put('i_user_score_1', wrapper.i_user_score_1);
            row.put('i_user_score_2', wrapper.i_user_score_2);
            row.put('i_user_score_3', wrapper.i_user_score_3);
            row.put('i_user_score_4', wrapper.i_user_score_4);
            row.put('i_user_score_5', wrapper.i_user_score_5);
            row.put('i_user_score_6', wrapper.i_user_score_6);
            row.put('i_user_score_7', wrapper.i_user_score_7);
            row.put('i_user_score_8', wrapper.i_user_score_8);
            row.put('i_user_score_9', wrapper.i_user_score_9);
            rows.add(row);
        }
        return rows;
    }
}