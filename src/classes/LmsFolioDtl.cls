/**
* @author Jakub Kołacz
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Lms Folio Dtl external object
**/

public with sharing class LmsFolioDtl extends ExternalObjectResponse implements ExternalObjectInterface{

	public List<Record> body {get; set;}

	public class Record {
		public String id {get; set;}
		public final Decimal c_account {get; set;}
		public final String c_bill_cd {get; set;}
		public final String c_bill_cd_desc {get; set;}
		public final String c_cashier_first_name {get; set;}
		public final String c_cashier_id  {get; set;}
		public final String c_cashier_last_name {get; set;}
		public final String c_cashier_user_profile {get; set;}
		public final String c_cc_lead_digit_type {get; set;}
		public final String c_comments {get; set;}
		public final String c_compor_dept {get; set;}
		public final String lms_folio_hdr_fk {get; set;}
		public final Decimal f_tax_amt {get;set;}
		public final Decimal f_tip_amt {get;set;}
		public final Decimal f_ticket_amt {get;set;}
		public final String c_compor_first_name {get; set;}
		public final String c_compor_gl_cd {get; set;}
		public final String c_compor_last_name {get; set;}
		public final String c_external_ticket_nbr {get; set;}
		public final String c_meal_period_cd {get; set;}
		public final String c_meal_period_desc {get; set;}
		public final String c_prop_cd {get; set;}
		public final String c_prop_cd_fk {get; set;}
		public final String c_quality_cd {get; set;}
		public final String c_rev_center_cd {get; set;}
		public final String c_server_nbr {get; set;}
		public final String c_settle_method_cd {get; set;}
		public final String c_settle_method_short_desc {get; set;}
		public final String c_settle_method_type {get; set;}
		public final String c_split_ticket_flag {get; set;}
		public final String c_ticket_type_cd {get; set;}
		public final String f_folio_id {get; set;}
		public final String d_create_ts {get; set;}
		public final String f_ticket_id {get; set;}
		public final String i_cashier_emp_id {get; set;}
		public final Integer i_covers {get; set;}
		public final Integer i_invoice_number {get; set;}
		public final Integer i_seq_nbr {get; set;}
		public final String d_timestamp {get; set;}
		public final String d_trans_dt {get; set;}
	}

	public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
		for (LmsFolioDtl.Record wrapper : this.body) {
			Map<String, Object> row = new Map<String, Object>();
			row.put('ExternalId', wrapper.id);
			row.put('DisplayUrl', wrapper.id);
			row.put('c_account', wrapper.c_account);
			row.put('c_bill_cd', wrapper.c_bill_cd);
			row.put('c_bill_cd_desc', wrapper.c_bill_cd_desc);
			row.put('c_cashier_first_name', wrapper.c_cashier_first_name);
			row.put('c_cashier_id', wrapper.c_cashier_id);
			row.put('c_cashier_last_name', wrapper.c_cashier_last_name);
			row.put('c_cashier_user_profile', wrapper.c_cashier_user_profile);
			row.put('c_cc_lead_digit_type', wrapper.c_cc_lead_digit_type);
			row.put('c_comments', wrapper.c_comments);
			row.put('c_compor_dept', wrapper.c_compor_dept);
			row.put('f_tax_amt',wrapper.f_tax_amt);
			row.put('f_tip_amt',wrapper.f_tip_amt);
			row.put('f_ticket_amt',wrapper.f_ticket_amt);
			row.put('lms_folio_hdr_fk', wrapper.lms_folio_hdr_fk);
			row.put('c_compor_first_name', wrapper.c_compor_first_name);
			row.put('c_compor_gl_cd', wrapper.c_compor_gl_cd);
			row.put('c_compor_last_name', wrapper.c_compor_last_name);
			row.put('c_external_ticket_nbr', wrapper.c_external_ticket_nbr);
			row.put('c_meal_period_cd', wrapper.c_meal_period_cd);
			row.put('c_meal_period_desc', wrapper.c_meal_period_desc);
			row.put('c_prop_cd', wrapper.c_prop_cd);
			row.put('c_prop_cd_fk', wrapper.c_prop_cd_fk);
			row.put('c_quality_cd', wrapper.c_quality_cd);
			row.put('c_rev_center_cd', wrapper.c_rev_center_cd);
			row.put('c_server_nbr', wrapper.c_server_nbr);
			row.put('c_settle_method_cd', wrapper.c_settle_method_cd);
			row.put('c_settle_method_short_desc', wrapper.c_settle_method_short_desc);
			row.put('c_settle_method_type', wrapper.c_settle_method_type);
			row.put('c_split_ticket_flag', wrapper.c_split_ticket_flag);
			row.put('c_ticket_type_cd', wrapper.c_ticket_type_cd);
			row.put('f_folio_id', wrapper.f_folio_id);
			row.put('d_create_ts', wrapper.d_create_ts);
			row.put('f_ticket_id', wrapper.f_ticket_id);
			row.put('i_cashier_emp_id', wrapper.i_cashier_emp_id);
			row.put('i_covers', wrapper.i_covers);
			row.put('i_invoice_number', wrapper.i_invoice_number);
			row.put('i_seq_nbr', wrapper.i_seq_nbr);
			row.put('d_timestamp', wrapper.d_timestamp);
			row.put('d_trans_dt', wrapper.d_trans_dt);
			rows.add(row);
		}
		return rows;
	}
}