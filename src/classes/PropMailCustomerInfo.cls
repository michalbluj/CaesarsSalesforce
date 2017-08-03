/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (PropMail)
**/
public with sharing class PropMailCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('quality_cd', wrapper.data.c_quality_cd);
		row.put('prop_mail_cd', wrapper.data.c_prop_mail_cd);
		return row;
	}
}