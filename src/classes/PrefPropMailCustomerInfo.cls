/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (PrefPropMail)
**/
public with sharing class PrefPropMailCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('prop_cd', wrapper.data.c_prop_cd);
		row.put('quality_cd', wrapper.data.c_quality_cd);
		row.put('gst_pref_mail_flag', wrapper.data.c_gst_pref_mail_flag);
		return row;
	}
}