/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (NxtgenEmail)
**/
public with sharing class NxtgenEmailCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('email', wrapper.data.c_email);
		row.put('app_code', wrapper.data.c_app_cd);
		row.put('email_id', wrapper.data.i_email_id);
		row.put('create_date', wrapper.data.d_create_dt);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('created_by', wrapper.data.c_created_by);
		row.put('email_type', wrapper.data.c_email_type);
		row.put('email_status', wrapper.data.c_email_status);
		return row;
	}
}