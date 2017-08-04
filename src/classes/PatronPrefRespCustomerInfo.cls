/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (PatronPrefResp)
**/
public with sharing class PatronPrefRespCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('file_id', wrapper.data.i_file_id);
		row.put('modifier', wrapper.data.c_modifier);
		row.put('response', wrapper.data.i_response);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('quality_cd', wrapper.data.c_quality_cd);
		row.put('ins_run_id', wrapper.data.i_ins_run_id);
		row.put('upd_run_id', wrapper.data.i_upd_run_id);
		row.put('derived_flag', wrapper.data.c_derived_flag);
		row.put('create_update', wrapper.data.d_create_update);
		row.put('original_dmid', wrapper.data.i_original_dmid);
		row.put('preference_id', wrapper.data.i_preference_id);
		row.put('data_source_cd', wrapper.data.c_data_source_cd);
		row.put('modifier_location', wrapper.data.c_modifier_location);
		row.put('modifier_workstation', wrapper.data.c_modifier_workstation);
		return row;
	}
}