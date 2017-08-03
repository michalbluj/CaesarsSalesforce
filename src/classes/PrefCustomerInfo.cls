/**
 * Created by Michal Bluj on 2017-07-13.
 */

public with sharing class PrefCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row, CustomerInfo wrapper) {
        row.put('c_modifier', wrapper.data.c_modifier);
        row.put('i_response', wrapper.data.i_response);
        row.put('c_pref_flag', wrapper.data.c_pref_flag);
        row.put('i_category_id', wrapper.data.i_category_id);
        row.put('c_derived_flag', wrapper.data.c_derived_flag);
        row.put('i_preference_id', wrapper.data.i_preference_id);
        row.put('c_data_source_cd', wrapper.data.c_data_source_cd);
        row.put('c_pref_type_name', wrapper.data.c_pref_type_name);
        row.put('c_modifier_location', wrapper.data.c_modifier_location);
        row.put('c_pref_category_name', wrapper.data.c_pref_category_name);
        row.put('c_modifier_workstation', wrapper.data.c_modifier_workstation);
        return row;
    }
}