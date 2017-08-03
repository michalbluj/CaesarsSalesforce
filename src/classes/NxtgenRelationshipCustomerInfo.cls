/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (NxtgenRelationship)
**/
public with sharing class NxtgenRelationshipCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('app_code', wrapper.data.c_app_cd);
		row.put('rel_dob', wrapper.data.d_rel_dob);
		row.put('rel_name', wrapper.data.c_rel_name);
		row.put('rel_notes', wrapper.data.c_rel_notes);
		row.put('create_date', wrapper.data.d_create_dt);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('gst_rel_id', wrapper.data.i_gst_rel_id);
		row.put('rel_type_code', wrapper.data.c_rel_type_cd);
		row.put('relationship', wrapper.data.c_relationship);
		row.put('creator_login', wrapper.data.c_creator_login);
		row.put('rel_status_code', wrapper.data.c_rel_status_cd);
		row.put('modifier_login', wrapper.data.c_modifier_login);
		row.put('plays_with_dmid', wrapper.data.i_plays_with_dmid);
		return row;
	}
}