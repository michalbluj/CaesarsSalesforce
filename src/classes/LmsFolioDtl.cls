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
			rows.add(row);
		}
		return rows;
	}
}