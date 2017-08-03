/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Casino)
**/
public with sharing class CasinoCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
        row.put('rep_id', wrapper.data.c_rep_id);
        row.put('prop_cd', wrapper.data.c_prop_cd);
        //row.put('timestamp', wrapper.data.d_timestamp);
        row.put('update_dt', wrapper.data.d_update_dt);
        row.put('casino_id', wrapper.data.i_casino_id);
        row.put('quality_cd', wrapper.data.c_quality_cd);
        row.put('create_date', wrapper.data.d_create_date);
        row.put('purge_react', wrapper.data.d_purge_react);
        row.put('cred_appr_by', wrapper.data.c_cred_appr_by);
        row.put('prop_mail_cd', wrapper.data.c_prop_mail_cd);
        row.put('avail_credit', wrapper.data.f_avail_credit);
        row.put('credit_limit', wrapper.data.f_credit_limit);
        row.put('credit_status', wrapper.data.c_credit_status);
        row.put('outstand_credit', wrapper.data.f_outstand_credit);
        return row;
    }

}