/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (EthnicityAppend)
**/
public with sharing class EthnicityAppendCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('asian_flag', wrapper.data.c_asian_flag);
		row.put('user_amt_1', wrapper.data.f_user_amt_1);
		row.put('user_amt_2', wrapper.data.f_user_amt_2);
		row.put('user_amt_3', wrapper.data.f_user_amt_3);
		row.put('user_amt_4', wrapper.data.f_user_amt_4);
		row.put('source_file', wrapper.data.c_source_file);
		row.put('user_flag_1', wrapper.data.c_user_flag_1);
		row.put('user_flag_2', wrapper.data.c_user_flag_2);
		row.put('user_flag_3', wrapper.data.c_user_flag_3);
		row.put('user_flag_4', wrapper.data.c_user_flag_4);
		row.put('user_flag_5', wrapper.data.c_user_flag_5);
		row.put('user_flag_6', wrapper.data.c_user_flag_6);
		row.put('user_score_1', wrapper.data.i_user_score_1);
		row.put('user_score_2', wrapper.data.i_user_score_2);
		row.put('user_score_3', wrapper.data.i_user_score_3);
		row.put('user_score_4', wrapper.data.i_user_score_4);
		row.put('ethnic_group1', wrapper.data.c_ethnic_group1);
		row.put('ethnic_group2', wrapper.data.c_ethnic_group2);
		row.put('pref_language', wrapper.data.c_pref_language);
		row.put('last_update_date', wrapper.data.d_last_update_dt);
		row.put('sub_ethnic_type', wrapper.data.c_sub_ethnic_type);
		row.put('main_ethnic_type', wrapper.data.c_main_ethnic_type);
		return row;
	}
}