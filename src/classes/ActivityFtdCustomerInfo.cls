/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (ActivityFtd)
**/
public with sharing class ActivityFtdCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('prop_cd', wrapper.data.c_prop_cd);
		row.put('pos_flag', wrapper.data.c_pos_flag);
		row.put('w2g_flag', wrapper.data.c_w2g_flag);
		row.put('acq_date', wrapper.data.d_acq_date);
		row.put('comp_flag', wrapper.data.c_comp_flag);
		row.put('curr_flag', wrapper.data.c_curr_flag);
		//row.put('timestamp', wrapper.data.d_timestamp);
		row.put('event_flag', wrapper.data.c_event_flag);
		row.put('hotel_flag', wrapper.data.c_hotel_flag);
		row.put('quality_cd', wrapper.data.c_quality_cd);
		row.put('visit_flag', wrapper.data.c_visit_flag);
		row.put('rating_flag', wrapper.data.c_rating_flag);
		row.put('last_trip_dt', wrapper.data.d_last_trip_dt);
		row.put('cons_rev_flag', wrapper.data.c_cons_rev_flag);
		row.put('first_trip_dt', wrapper.data.d_first_trip_dt);
		row.put('acquisition_cd', MapHandler.getAcquisitionCodeMap().get(wrapper.data.c_acquisition_cd));
		row.put('offer_rdm_flag', wrapper.data.c_offer_rdm_flag);
		row.put('last_activity_dt', wrapper.data.d_last_activity_dt);
        return row;
    }
}