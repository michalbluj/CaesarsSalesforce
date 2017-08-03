/**
* @author Jakub Kołacz
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Guest Hotel Activity Vedw external object
**/

public with sharing class GuestHotelActivityVedw extends ExternalObjectResponse implements ExternalObjectInterface {

	public List<Record> body {get; set;}

	public class Record {

		public final String id {get; set;}

		public final String hotel_act_status_code_fk {get; set;}
		public final String c_activity_status {get; set;}
		public final String c_address_1 {get; set;}
		public final String c_address_2 {get; set;}
		public final String c_cancel_agent_id {get; set;}
		public final String c_cancel_id {get; set;}
		public final String c_checkin_agent_id {get; set;}
		public final String c_checkin_location {get; set;}
		public final String c_checkout_agent_id {get; set;}
		public final String c_checkout_location {get; set;}
        public final String contact_fk {get; set;}

	}

	public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
		for (GuestHotelActivityVedw.Record wrapper : this.body) {
			Map<String, Object> row = new Map<String, Object>();
			row.put('ExternalId', wrapper.id);
			row.put('DisplayUrl', wrapper.id);
			row.put('hotel_act_status_code_fk', wrapper.hotel_act_status_code_fk);
			row.put('c_activity_status', wrapper.c_activity_status);
			row.put('c_address_1', wrapper.c_address_1);
			row.put('c_address_2', wrapper.c_address_2);
			row.put('c_cancel_agent_id', wrapper.c_cancel_agent_id);
			row.put('c_cancel_id', wrapper.c_cancel_id);
			row.put('c_checkin_agent_id', wrapper.c_checkin_agent_id);
			row.put('c_checkin_location', wrapper.c_checkin_location);
			row.put('c_checkout_agent_id', wrapper.c_checkout_agent_id);
			row.put('c_checkout_location', wrapper.c_checkout_location);
            row.put('contact_fk', wrapper.contact_fk);
			rows.add(row);
		}
		return rows;
	}
}