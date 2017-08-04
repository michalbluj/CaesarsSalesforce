/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (VedwEthnicityCustomerInfo)
**/
public with sharing class VedwEthnicityCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('group1', wrapper.data.c_group1);
		row.put('group2', wrapper.data.c_group2);
		row.put('group3', wrapper.data.c_group3);
		row.put('group4', wrapper.data.c_group4);
		row.put('last_name', wrapper.data.c_last_name);
		row.put('group_code', wrapper.data.c_group_code);
		row.put('match_type', wrapper.data.c_match_type);
		row.put('lastupdate', wrapper.data.d_lastupdate);
		row.put('user_amt_1', wrapper.data.f_user_amt_1);
		row.put('user_amt_2', wrapper.data.f_user_amt_2);
		row.put('user_amt_3', wrapper.data.f_user_amt_3);
		row.put('user_amt_4', wrapper.data.f_user_amt_4);
		row.put('ethnic_code', wrapper.data.c_ethnic_code);
		row.put('vendor_code', wrapper.data.c_vendor_code);
		row.put('user_score_1', wrapper.data.i_user_score_1);
		row.put('user_score_2', wrapper.data.i_user_score_2);
		row.put('user_score_3', wrapper.data.i_user_score_3);
		row.put('user_score_4', wrapper.data.i_user_score_4);
		row.put('ethdom_relg_cd', wrapper.data.c_ethdom_relg_cd);
		row.put('est_names_12mn', wrapper.data.i_est_names_12mn);
		row.put('group_code_desc', wrapper.data.c_group_code_desc);
		row.put('ethnic_code_desc', wrapper.data.c_ethnic_code_desc);
		row.put('ethdom_relg_cd_desc', wrapper.data.c_ethdom_relg_cd_desc);
		return row;
	}
}