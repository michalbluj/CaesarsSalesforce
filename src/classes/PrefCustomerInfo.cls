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
        row.put('modifier', wrapper.data.c_modifier);
        row.put('response', wrapper.data.i_response);
        row.put('pref_flag', wrapper.data.c_pref_flag);
        row.put('quality_cd', wrapper.data.c_quality_cd);
        row.put('category_id', wrapper.data.i_category_id);
        row.put('derived_flag', wrapper.data.c_derived_flag);
        row.put('preference_id', wrapper.data.i_preference_id);
        row.put('data_source_cd', wrapper.data.c_data_source_cd);
        row.put('pref_type_name', wrapper.data.c_pref_type_name);
        row.put('modifier_location', wrapper.data.c_modifier_location);
        row.put('pref_category_name', wrapper.data.c_pref_category_name);
        row.put('modifier_workstation', wrapper.data.c_modifier_workstation);
        return row;
    }
}