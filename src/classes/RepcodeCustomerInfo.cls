/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Repcode)
**/
public with sharing class RepcodeCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
        row.put('rep_code', wrapper.data.c_rep_cd);
        row.put('efft_dy', wrapper.data.i_efft_dy);
        row.put('efft_mn', wrapper.data.i_efft_mn);
        row.put('efft_yr', wrapper.data.i_efft_yr);
        row.put('rep_type', wrapper.data.c_rep_type);
        row.put('rep_rank', wrapper.data.i_rep_rank);
        row.put('patron_id', wrapper.data.i_patron_id);
        row.put('current_code', wrapper.data.c_current_cd);
        row.put('entered_by', wrapper.data.c_entered_by);
        row.put('trans_time', wrapper.data.d_trans_time);
        row.put('effective_end_date', wrapper.data.d_efft_end_dt);
        row.put('trans_100', wrapper.data.d_trans_100_yr);
        row.put('trans_cal', wrapper.data.d_trans_cal_dt);
        row.put('rep_trip', wrapper.data.i_rep_trip_nbr);
        row.put('effective_start_date', wrapper.data.d_efft_start_dt);
        row.put('patron_rep_appv', wrapper.data.c_patron_rep_appv);
        row.put('last_rep_h_date', wrapper.data.i_last_rep_h_date);
        row.put('assigned_century', wrapper.data.i_assigned_century);
        row.put('last_rep_code_date', wrapper.data.i_last_rep_cd_date);
        return row;
    }

}