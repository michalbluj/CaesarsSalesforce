/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (NxtgenInterest)
**/
public with sharing class NxtgenInterestCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('app_cd', wrapper.data.c_app_cd);
		row.put('interest', wrapper.data.c_interest);
		row.put('create_dt', wrapper.data.d_create_dt);
		row.put('interest_id', wrapper.data.i_interest_id);
		row.put('creator_login', wrapper.data.c_creator_login);
		row.put('interest_group', wrapper.data.c_interest_group);
		row.put('interest_notes', wrapper.data.c_interest_notes);
		row.put('modifier_login', wrapper.data.c_modifier_login);
		row.put('interest_status', wrapper.data.c_interest_status);
		return row;
	}
}