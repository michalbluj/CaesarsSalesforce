/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Offer Sent external object
**/
public with sharing class OfferSent extends ExternalObjectResponse implements ExternalObjectInterface{

	public List<Record> body {get;set;}

	public class Record {
		public String contact {get;set;}
		public String id {get;set;}

		public final String c_offer_id {get; set;}
		public final String c_offer_status {get; set;}
		public final String c_purge_flag {get; set;}
		public final String c_quality_cd {get; set;}
		public final String c_recp_grp_id {get; set;}
		public final String i_dmid {get; set;}
		public final String i_gst_offer_nbr {get; set;}
		public final Integer i_mail_id {get; set;}
		public final Integer i_nbr_coup_redeem {get; set;}
		public final Integer i_offer_counter {get; set;}
		public final Integer i_paradb_list_id {get; set;}
		public final Integer i_prospect_id {get; set;}
		public final String d_offer_status_dt {get; set;}
		public final String d_purge_date {get; set;}
		public final String d_rpt_period {get; set;}
		public final String d_send_date {get; set;}
		public final String d_timestamp {get; set;}

	}

	public List<Map<String, Object>> populateData(List<Map<String, Object>> rows){
		for(OfferSent.Record wrapper : this.body) {
			Map<String, Object> row = new Map<String, Object>();
			row.put('ExternalId',wrapper.id);
			row.put('DisplayUrl',wrapper.id);
			row.put('contact',wrapper.contact);
			row.put('c_offer_id', wrapper.c_offer_id);
			row.put('c_offer_status', wrapper.c_offer_status);
			row.put('c_purge_flag', wrapper.c_purge_flag);
			row.put('c_quality_cd', wrapper.c_quality_cd);
			row.put('c_recp_grp_id', wrapper.c_recp_grp_id);
			row.put('i_dmid', wrapper.i_dmid);
			row.put('i_gst_offer_nbr', wrapper.i_gst_offer_nbr);
			row.put('i_mail_id', wrapper.i_mail_id);
			row.put('i_nbr_coup_redeem', wrapper.i_nbr_coup_redeem);
			row.put('i_offer_counter', wrapper.i_offer_counter);
			row.put('i_paradb_list_id', wrapper.i_paradb_list_id);
			row.put('i_prospect_id', wrapper.i_prospect_id);
			row.put('d_offer_status_dt', wrapper.d_offer_status_dt);
			row.put('d_purge_date', wrapper.d_purge_date);
			row.put('d_rpt_period', wrapper.d_rpt_period);
			row.put('d_send_date', wrapper.d_send_date);
			row.put('d_timestamp', wrapper.d_timestamp);
			rows.add(row);
		}
		return rows;
	}
}