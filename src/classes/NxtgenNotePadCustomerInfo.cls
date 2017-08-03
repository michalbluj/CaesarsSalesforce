/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (NxtgenNotePad)
**/
public with sharing class NxtgenNotePadCustomerInfo implements CustomerInfoInterface{
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
		row.put('private', wrapper.data.c_private);
		row.put('prop_cd', wrapper.data.c_prop_cd);
		row.put('note_pad', wrapper.data.c_note_pad);
		row.put('create_date', wrapper.data.d_create_dt);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('note_pad_id', wrapper.data.i_note_pad_id);
		row.put('creator_login', wrapper.data.c_creator_login);
		row.put('modifier_login', wrapper.data.c_modifier_login);
		row.put('note_pad_status', wrapper.data.c_note_pad_status);
		row.put('note_pad_priority', wrapper.data.c_note_pad_priority);
		row.put('send_notification', wrapper.data.c_send_notification);
		return row;
	}
}