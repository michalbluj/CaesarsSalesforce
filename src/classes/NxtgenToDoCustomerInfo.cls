/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (NxtgenToDo)
**/
public with sharing class NxtgenToDoCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('worth', wrapper.data.f_worth);
		row.put('app_code', wrapper.data.c_app_cd);
		row.put('rep_id', wrapper.data.c_rep_id);
		row.put('due_date', wrapper.data.d_due_dt);
		row.put('book_id', wrapper.data.c_book_id);
		row.put('prop_code', wrapper.data.c_prop_cd);
		row.put('task_id', wrapper.data.c_task_id);
		row.put('due_time', wrapper.data.d_due_time);
		row.put('event_id', wrapper.data.i_event_id);
		row.put('to_do_id', wrapper.data.i_to_do_id);
		row.put('last_name', wrapper.data.c_last_name);
		row.put('create_date', wrapper.data.d_create_dt);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('first_name', wrapper.data.c_first_name);
		row.put('to_do_type', wrapper.data.c_to_do_type);
		row.put('market_adw', wrapper.data.f_market_adw);
		row.put('middle_init', wrapper.data.c_middle_init);
		row.put('to_do_notes', wrapper.data.c_to_do_notes);
		row.put('to_do_status', wrapper.data.c_to_do_status);
		row.put('last_trip_date', wrapper.data.d_last_trip_dt);
		row.put('creator_login', wrapper.data.c_creator_login);
		row.put('to_do_segment', wrapper.data.c_to_do_segment);
		row.put('to_do_subject', wrapper.data.c_to_do_subject);
		row.put('modifier_login', wrapper.data.c_modifier_login);
		row.put('offer_reserved', wrapper.data.c_offer_reserved);
		row.put('suggested_channel', wrapper.data.c_suggested_channel);
		row.put('contact_date_by_all', wrapper.data.d_contact_dt_by_all);
		row.put('my_last_contact_date', wrapper.data.d_my_last_contact_dt);
		row.put('last_contact_date_by_me', wrapper.data.d_last_contact_dt_by_me);
		row.put('phone_contact_date_by_all', wrapper.data.d_phone_contact_dt_by_all);
		return row;
	}
}