/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (NxtgenAddress)
**/
public with sharing class NxtgenAddressCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('email', wrapper.data.c_email);
		row.put('notes', wrapper.data.c_notes);
		row.put('phone', wrapper.data.c_phone);
		row.put('addr_1', wrapper.data.c_addr_1);
		row.put('addr_2', wrapper.data.c_addr_2);
		row.put('addr_3', wrapper.data.c_addr_3);
		row.put('app_code', wrapper.data.c_app_cd);
		row.put('rep_id', wrapper.data.c_rep_id);
		row.put('zip_code', wrapper.data.c_zip_cd);
		row.put('book_id', wrapper.data.c_book_id);
		row.put('prop_code', wrapper.data.c_prop_cd);
		row.put('state_code', wrapper.data.c_state_cd);
		row.put('address_description', wrapper.data.c_addr_desc);
		row.put('city_name', wrapper.data.c_city_name);
		row.put('create_date', wrapper.data.d_create_dt);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('country_code', wrapper.data.c_country_cd);
		row.put('state_name', wrapper.data.c_state_name);
		row.put('note_pad_id', wrapper.data.i_note_pad_id);
		row.put('creator_login', wrapper.data.c_creator_login);
		row.put('address_status_code', wrapper.data.c_addr_status_cd);
		row.put('modifier_login', wrapper.data.c_modifier_login);
		row.put('pcs_address_id', wrapper.data.i_pcs_address_id);
		return row;
	}
}