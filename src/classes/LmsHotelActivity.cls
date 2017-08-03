/**
* @author Jakub Kołacz
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Lms Hotel Activity external object
**/
public with sharing class LmsHotelActivity extends ExternalObjectResponse implements ExternalObjectInterface {

	public List<Record> body {get; set;}

	public class Record {
		public String id {get; set;}
		public final String c_cancel_id {get; set;}
		public final String c_checkin_agent_id {get; set;}
		public final String c_checkin_location {get; set;}
		public final String c_checkout_agent_id {get; set;}
		public final String c_checkout_location {get; set;}
		public final String c_city {get; set;}
		public final String c_confirm_email {get; set;}
		public final String c_confirm_id {get; set;}
		public final String c_credit_card_auth_nbr {get; set;}
		public final String c_credit_card_exp_dt {get; set;}
		public final String c_credit_card_nbr {get; set;}
		public final String contact_pri_fk {get; set;}
		public final String contact_sec_fk {get; set;}
	}

	public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
		for (LmsHotelActivity.Record wrapper : this.body) {
			Map<String, Object> row = new Map<String, Object>();
			row.put('ExternalId', wrapper.id);
			row.put('DisplayUrl', wrapper.id);
			row.put('c_cancel_id', wrapper.c_cancel_id);
			row.put('c_checkin_agent_id', wrapper.c_checkin_agent_id);
			row.put('c_checkin_location', wrapper.c_checkin_location);
			row.put('c_checkout_agent_id', wrapper.c_checkout_agent_id);
			row.put('c_checkout_location', wrapper.c_checkout_location);
			row.put('c_city', wrapper.c_city);
			row.put('c_confirm_email', wrapper.c_confirm_email);
			row.put('c_confirm_id', wrapper.c_confirm_id);
			row.put('c_credit_card_auth_nbr', wrapper.c_credit_card_auth_nbr);
			row.put('c_credit_card_exp_dt', wrapper.c_credit_card_exp_dt);
			row.put('c_credit_card_nbr', wrapper.c_credit_card_nbr);
			row.put('contact_pri_fk', wrapper.contact_pri_fk);
			row.put('contact_sec_fk', wrapper.contact_sec_fk);
			rows.add(row);
		}
		return rows;
	}
}