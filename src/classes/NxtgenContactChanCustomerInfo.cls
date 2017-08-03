/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (NxtgenContactChan)
**/
public with sharing class NxtgenContactChanCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('app_code', wrapper.data.c_app_cd);
		row.put('create_date', wrapper.data.d_create_dt);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('creator_login', wrapper.data.c_creator_login);
		row.put('modifier_login', wrapper.data.c_modifier_login);
		row.put('do_not_contact_channel', wrapper.data.c_do_not_contact_channel);
		row.put('preferred_contact_channel', wrapper.data.c_preferred_contact_channel);
		return row;
	}
}