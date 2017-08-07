/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Personal)
**/
public with sharing class PersonalCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('ssn', wrapper.data.i_ssn);
		row.put('dl_num', wrapper.data.c_dl_num);
		row.put('gender', wrapper.data.c_gender);
		row.put('quality_cd', wrapper.data.c_quality_cd);
		row.put('dl_state_cd', wrapper.data.c_dl_state_cd);
		row.put('id_verified', wrapper.data.c_id_verified);
		row.put('annivers_dt', wrapper.data.d_annivers_dt);
		row.put('marital_status', wrapper.data.c_marital_status);
		return row;
	}
}