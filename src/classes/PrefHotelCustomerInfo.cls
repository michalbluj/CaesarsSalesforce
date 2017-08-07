/**
* @author Patryk Lompart
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (PrefHotel)
**/
public with sharing class PrefHotelCustomerInfo implements CustomerInfoInterface{
	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
	public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
		row.put('cc_type', wrapper.data.c_cc_type);
		row.put('smoking', wrapper.data.c_smoking);
		row.put('bed_type', wrapper.data.c_bed_type);
		row.put('cc_number', wrapper.data.c_cc_number);
		row.put('room_type', wrapper.data.c_room_type);
		row.put('quality_cd', wrapper.data.c_quality_cd);
		row.put('companion_id', wrapper.data.c_companion_id);
		row.put('spcl_request', wrapper.data.c_spcl_request);
		row.put('cc_expire_dt', wrapper.data.d_cc_expire_dt);
		row.put('spcl_instruction', wrapper.data.c_spcl_instruction);
		return row;
	}
}