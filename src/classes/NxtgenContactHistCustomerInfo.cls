/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (NxtgenContactHist)
**/
public with sharing class NxtgenContactHistCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('app_cd', wrapper.data.c_app_cd);
		row.put('rep_id', wrapper.data.c_rep_id);
		row.put('book_id', wrapper.data.c_book_id);
		row.put('outcome', wrapper.data.c_outcome);
		row.put('prop_cd', wrapper.data.c_prop_cd);
		row.put('task_id', wrapper.data.c_task_id);
		row.put('to_do_id', wrapper.data.i_to_do_id);
		row.put('direction', wrapper.data.c_direction);
		row.put('last_name', wrapper.data.c_last_name);
		row.put('create_dt', wrapper.data.d_create_dt);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('first_name', wrapper.data.c_first_name);
		row.put('contact_dt', wrapper.data.d_contact_dt);
		row.put('contact_id', wrapper.data.i_contact_id);
		row.put('middle_init', wrapper.data.c_middle_init);
		row.put('outcome_desc', wrapper.data.c_outcome_desc);
		row.put('outcome_more', wrapper.data.c_outcome_more);
		row.put('creator_login', wrapper.data.c_creator_login);
		row.put('outcome_notes', wrapper.data.c_outcome_notes);
		row.put('contact_status', wrapper.data.c_contact_status);
		row.put('modifier_login', wrapper.data.c_modifier_login);
		row.put('contact_subject', wrapper.data.c_contact_subject);
		row.put('contacted_channel', wrapper.data.c_contacted_channel);
		return row;
	}
}