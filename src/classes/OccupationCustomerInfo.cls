/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Occupation)
**/
public with sharing class OccupationCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('sic_cd', wrapper.data.c_sic_cd);
		row.put('firm_name', wrapper.data.c_firm_name);
		row.put('job_title', wrapper.data.c_job_title);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('occupation', wrapper.data.c_occupation);
		row.put('owner_flag', wrapper.data.c_owner_flag);
		row.put('quality_cd', wrapper.data.c_quality_cd);
		row.put('nbr_yr_emply', wrapper.data.c_nbr_yr_emply);
		return row;
	}
}