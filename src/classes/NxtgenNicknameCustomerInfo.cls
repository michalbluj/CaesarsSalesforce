/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (NxtgenNickname)
**/
public with sharing class NxtgenNicknameCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('app_cd', wrapper.data.c_app_cd);
		row.put('nick_name', wrapper.data.c_nick_name);
		row.put('create_dt', wrapper.data.d_create_dt);
		row.put('creator_login', wrapper.data.c_creator_login);
		row.put('modifier_login', wrapper.data.c_modifier_login);
		return row;
	}
}