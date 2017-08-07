/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Email)
**/
public with sharing class EmailCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('email', wrapper.data.c_email);
		row.put('source', wrapper.data.c_source);
		row.put('qual_cd', wrapper.data.c_qual_cd);
		row.put('ofr_freq', wrapper.data.c_ofr_freq);
		row.put('qual_cat', wrapper.data.c_qual_cat);
		row.put('email_flag', wrapper.data.c_email_flag);
		row.put('quality_cd', wrapper.data.c_quality_cd);
		row.put('contact_count', wrapper.data.i_contact_count);
		row.put('last_bounce_cd', wrapper.data.c_last_bounce_cd);
		row.put('qual_reason_cd', wrapper.data.c_qual_reason_cd);
		row.put('qual_hygiene_cd', wrapper.data.c_qual_hygiene_cd);
		row.put('bounce_timestamp', wrapper.data.d_bounce_timestamp);
		row.put('qual_chg_timestamp', wrapper.data.d_qual_chg_timestamp);
		row.put('email_engagement_cd', wrapper.data.c_email_engagement_cd);
		row.put('email_chg_timestamp', wrapper.data.d_email_chg_timestamp);
		row.put('qual_conf_timestamp', wrapper.data.d_qual_conf_timestamp);
		row.put('email_address_valid_cd', wrapper.data.c_email_address_valid_cd);
		row.put('email_address_quality_cd', wrapper.data.c_email_address_quality_cd);
		row.put('last_change_timestamp_utc', wrapper.data.d_last_change_timestamp_utc);
		return row;
	}
}