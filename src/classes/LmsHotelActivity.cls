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
		public final String contact1 {get; set;}
		public final String contact2 {get; set;}
		public final String c_activity_status {get; set;}
		public final String c_address_1 {get; set;}
		public final String c_address_2 {get; set;}
		public final String c_email_contact_flag {get; set;}
		public final String c_first_name {get; set;}
		public final String c_group_cd {get; set;}
		public final String c_group_type {get; set;}
		public final String c_last_name {get; set;}
		public final String c_occupant_type {get; set;}
		public final String c_offer_id {get; set;}
		public final String c_original_rm_type {get; set;}
		public final String c_original_wing_cd {get; set;}
		public final String c_pri_cas_guest_id {get; set;}
		public final String c_prop_cd {get; set;}
		public final String c_prop_cd_fk {get; set;}
		public final String c_quality_cd {get; set;}
		public final String c_rate_plan {get; set;}
		public final String c_reservation_agent_id {get; set;}
		public final String c_rm_nbr {get; set;}
		public final String c_rm_type {get; set;}
		public final String c_sec_cas_guest_id {get; set;}
		public final String c_settle_method {get; set;}
		public final String c_share_id {get; set;}
		public final String c_source_cd {get; set;}
		public final String c_state_cd {get; set;}
		public final String c_tracking {get; set;}
		public final String c_transaction_agent_id {get; set;}
		public final String c_wing_cd {get; set;}
		public final String c_zip_cd {get; set;}
		public final String customer_control_segments_fk {get; set;}
		public final DateTime d_timestamp {get; set;}
		public final Decimal f_comp_fb_rev {get; set;}
		public final Decimal f_comp_other_rev {get; set;}
		public final Decimal f_comp_room_rev {get; set;}
		public final Decimal f_deposit_amt_req {get; set;}
		public final Decimal f_deposit_credit_card_chg {get; set;}
		public final Decimal f_fb_rev {get; set;}
		public final Decimal f_other_rev {get; set;}
		public final String f_reserve_id {get; set;}
		public final Decimal f_room_rev {get; set;}
		public final Decimal f_room_rev_reserved {get; set;}
		public final Decimal f_room_tax_reserved {get; set;}
		public final String hotel_act_status_code_fk {get; set;}
		public final String hotel_wing_codes_fk {get; set;}
		public final Integer i_customer_segment {get; set;}
		public final Integer i_nbr_occupants {get; set;}
		public final Integer i_nbr_rooms {get; set;}
		public final Integer i_nbr_shares {get; set;}
		public final Integer i_rm_night {get; set;}
		public final String i_sec_xref_dmid {get; set;}
		public final String i_xref_dmid {get; set;}
		public final String lms_room_type_desc_sda_fk {get; set;}
		public final String source_code_fk {get; set;}
		public final DateTime d_transaction_dt {get; set;}
		public final DateTime d_reserve_dt {get; set;}
		public final DateTime d_dob {get; set;}
		public final DateTime d_departure_dt {get; set;}
		public final DateTime d_checkout_dt {get; set;}
		public final DateTime d_checkin_dt {get; set;}
		public final DateTime d_cancel_dt {get; set;}
		public final DateTime d_arrival_dt {get; set;}
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
			row.put('contact1', wrapper.contact1);
			row.put('contact2', wrapper.contact2);
			row.put('c_activity_status', wrapper.c_activity_status);
			row.put('c_address_1', wrapper.c_address_1);
			row.put('c_address_2', wrapper.c_address_2);
			row.put('c_email_contact_flag', wrapper.c_email_contact_flag);
			row.put('c_first_name', wrapper.c_first_name);
			row.put('c_group_cd', wrapper.c_group_cd);
			row.put('c_group_type', wrapper.c_group_type);
			row.put('c_last_name', wrapper.c_last_name);
			row.put('c_occupant_type', wrapper.c_occupant_type);
			row.put('c_offer_id', wrapper.c_offer_id);
			row.put('c_original_rm_type', wrapper.c_original_rm_type);
			row.put('c_original_wing_cd', wrapper.c_original_wing_cd);
			row.put('c_pri_cas_guest_id', wrapper.c_pri_cas_guest_id);
			row.put('c_prop_cd', wrapper.c_prop_cd);
			row.put('c_prop_cd_fk', wrapper.c_prop_cd_fk);
			row.put('c_quality_cd', wrapper.c_quality_cd);
			row.put('c_rate_plan', wrapper.c_rate_plan);
			row.put('c_reservation_agent_id', wrapper.c_reservation_agent_id);
			row.put('c_rm_nbr', wrapper.c_rm_nbr);
			row.put('c_rm_type', wrapper.c_rm_type);
			row.put('c_sec_cas_guest_id', wrapper.c_sec_cas_guest_id);
			row.put('c_settle_method', wrapper.c_settle_method);
			row.put('c_share_id', wrapper.c_share_id);
			row.put('c_source_cd', wrapper.c_source_cd);
			row.put('c_state_cd', wrapper.c_state_cd);
			row.put('c_tracking', wrapper.c_tracking);
			row.put('c_transaction_agent_id', wrapper.c_transaction_agent_id);
			row.put('c_wing_cd', wrapper.c_wing_cd);
			row.put('c_zip_cd', wrapper.c_zip_cd);
			row.put('customer_control_segments_fk', wrapper.customer_control_segments_fk);
			row.put('d_timestamp', wrapper.d_timestamp);
			row.put('f_comp_fb_rev', wrapper.f_comp_fb_rev);
			row.put('f_comp_other_rev', wrapper.f_comp_other_rev);
			row.put('f_comp_room_rev', wrapper.f_comp_room_rev);
			row.put('f_deposit_amt_req', wrapper.f_deposit_amt_req);
			row.put('f_deposit_credit_card_chg', wrapper.f_deposit_credit_card_chg);
			row.put('f_fb_rev', wrapper.f_fb_rev);
			row.put('f_other_rev', wrapper.f_other_rev);
			row.put('f_reserve_id', wrapper.f_reserve_id);
			row.put('f_room_rev', wrapper.f_room_rev);
			row.put('f_room_rev_reserved', wrapper.f_room_rev_reserved);
			row.put('f_room_tax_reserved', wrapper.f_room_tax_reserved);
			row.put('hotel_act_status_code_fk', wrapper.hotel_act_status_code_fk);
			row.put('hotel_wing_codes_fk', wrapper.hotel_wing_codes_fk);
			row.put('i_customer_segment', wrapper.i_customer_segment);
			row.put('i_nbr_occupants', wrapper.i_nbr_occupants);
			row.put('i_nbr_rooms', wrapper.i_nbr_rooms);
			row.put('i_nbr_shares', wrapper.i_nbr_shares);
			row.put('i_rm_night', wrapper.i_rm_night);
			row.put('i_sec_xref_dmid', wrapper.i_sec_xref_dmid);
			row.put('i_xref_dmid', wrapper.i_xref_dmid);
			row.put('lms_room_type_desc_sda_fk', wrapper.lms_room_type_desc_sda_fk);
			row.put('source_code_fk', wrapper.source_code_fk);
			row.put('d_transaction_dt', wrapper.d_transaction_dt);
			row.put('d_reserve_dt', wrapper.d_reserve_dt);
			row.put('d_dob', wrapper.d_dob);
			row.put('d_departure_dt', wrapper.d_departure_dt);
			row.put('d_checkout_dt', wrapper.d_checkout_dt);
			row.put('d_checkin_dt', wrapper.d_checkin_dt);
			row.put('d_cancel_dt', wrapper.d_cancel_dt);
			row.put('d_arrival_dt', wrapper.d_arrival_dt);
			rows.add(row);
		}
		return rows;
	}
}