/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (ScoreProp)
**/
public with sharing class ScorePropCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('prop_cd', wrapper.data.c_prop_cd);
		row.put('mileage', wrapper.data.i_mileage);
		row.put('quality_cd', wrapper.data.c_quality_cd);
		row.put('prep_trips', wrapper.data.f_prep_trips);
		row.put('user_amt_1', wrapper.data.f_user_amt_1);
		row.put('user_amt_2', wrapper.data.f_user_amt_2);
		row.put('user_amt_3', wrapper.data.f_user_amt_3);
		row.put('user_amt_4', wrapper.data.f_user_amt_4);
		row.put('user_amt_5', wrapper.data.f_user_amt_5);
		row.put('user_amt_6', wrapper.data.f_user_amt_6);
		row.put('user_amt_7', wrapper.data.f_user_amt_7);
		row.put('user_amt_8', wrapper.data.f_user_amt_8);
		row.put('user_amt_9', wrapper.data.f_user_amt_9);
		row.put('pred_worth', wrapper.data.i_pred_worth);
		row.put('user_flag_1', wrapper.data.c_user_flag_1);
		row.put('user_flag_2', wrapper.data.c_user_flag_2);
		row.put('user_flag_3', wrapper.data.c_user_flag_3);
		row.put('user_flag_4', wrapper.data.c_user_flag_4);
		row.put('user_flag_5', wrapper.data.c_user_flag_5);
		row.put('user_flag_6', wrapper.data.c_user_flag_6);
		row.put('user_flag_7', wrapper.data.c_user_flag_7);
		row.put('user_flag_8', wrapper.data.c_user_flag_8);
		row.put('user_flag_9', wrapper.data.c_user_flag_9);
		row.put('last_update', wrapper.data.d_last_update);
		row.put('user_score_1', wrapper.data.i_user_score_1);
		row.put('user_score_2', wrapper.data.i_user_score_2);
		row.put('user_score_3', wrapper.data.i_user_score_3);
		row.put('user_score_4', wrapper.data.i_user_score_4);
		row.put('user_score_5', wrapper.data.i_user_score_5);
		row.put('user_score_6', wrapper.data.i_user_score_6);
		row.put('user_score_7', wrapper.data.i_user_score_7);
		row.put('user_score_8', wrapper.data.i_user_score_8);
		row.put('user_score_9', wrapper.data.i_user_score_9);
		row.put('pred_hotel_day', wrapper.data.i_pred_hotel_day);
		row.put('pred_hotel_trip', wrapper.data.i_pred_hotel_trip);
		return row;
	}
}