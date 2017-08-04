/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (NxtgenPhone)
**/
public with sharing class NxtgenPhoneCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('phone', wrapper.data.c_phone);
		row.put('app_cd', wrapper.data.c_app_cd);
		row.put('private', wrapper.data.c_private);
		row.put('create_dt', wrapper.data.d_create_dt);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('created_by', wrapper.data.c_created_by);
		row.put('phone_type', wrapper.data.c_phone_type);
		row.put('phone_status', wrapper.data.c_phone_status);
		row.put('pcs_phone_id', wrapper.data.i_pcs_phone_id);
		return row;
	}
}