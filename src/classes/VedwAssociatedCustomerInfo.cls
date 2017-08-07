/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (VedwAssociated)
**/
public with sharing class VedwAssociatedCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('age', wrapper.data.age);
		row.put('dob', wrapper.data.d_dob);
		row.put('suffix', wrapper.data.c_suffix);
		row.put('addr_pref', wrapper.data.c_addr_pref);
		row.put('mail_flag', wrapper.data.c_mail_flag);
		row.put('create_dt', wrapper.data.d_create_dt);
		row.put('quality_cd', wrapper.data.c_quality_cd);
		return row;
	}
}