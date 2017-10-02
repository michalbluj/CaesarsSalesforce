public with sharing class GstPdbTripDayDtlBidl extends ExternalObjectResponse implements ExternalObjectInterface {

    public List<Record> body {get; set;}

    public class Record {
    	public final String c_market_cd {get;set;}
		public final String c_market_cd_fk {get;set;}
		public final String c_prop_cd {get;set;}
		public final String c_prop_cd_fk {get;set;}
		public final String c_prop_market_cd {get;set;}
		public final String c_prop_market_cd_fk {get;set;}
		public final String c_quality_cd {get;set;}
		public final String contact {get;set;}
		public final String d_date {get;set;}
		public final String d_end_dt_pdb_trip {get;set;}
		public final String d_start_dt_pdb_trip {get;set;}
		public final String d_timestamp {get;set;}
		public final Decimal f_act_all {get;set;}
		public final Decimal f_act_game {get;set;}
		public final Decimal f_act_other {get;set;}
		public final Decimal f_act_slot {get;set;}
		public final Decimal f_actual_profit_amt {get;set;}
		public final Decimal f_avg_profit_amt {get;set;}
		public final Decimal f_cash_marker_game {get;set;}
		public final Decimal f_cash_marker_other {get;set;}
		public final Decimal f_cash_rev_amt {get;set;}
		public final Decimal f_cash_tt_amt {get;set;}
		public final Decimal f_coinin_slot {get;set;}
		public final Decimal f_comp_rev_amt {get;set;}
		public final Decimal f_comp_tt_amt {get;set;}
		public final Decimal f_cw_dlrs_dec_food_used {get;set;}
		public final Decimal f_cw_dlrs_dec_other_used {get;set;}
		public final Decimal f_cw_dlrs_dec_room_used {get;set;}
		public final Decimal f_cw_dlrs_dec_trans_used {get;set;}
		public final Decimal f_cw_dlrs_dec_used {get;set;}
		public final Decimal f_cw_dlrs_food_used {get;set;}
		public final Decimal f_cw_dlrs_nondec_food_used {get;set;}
		public final Decimal f_cw_dlrs_nondec_other_used {get;set;}
		public final Decimal f_cw_dlrs_nondec_room_used {get;set;}
		public final Decimal f_cw_dlrs_nondec_trans_used {get;set;}
		public final Decimal f_cw_dlrs_nondec_used {get;set;}
		public final Decimal f_cw_dlrs_other_used {get;set;}
		public final Decimal f_cw_dlrs_room_used {get;set;}
		public final Decimal f_cw_dlrs_trans_used {get;set;}
		public final Decimal f_cw_dlrs_used {get;set;}
		public final Decimal f_rc_dlrs_food_used {get;set;}
		public final Decimal f_rc_dlrs_other_used {get;set;}
		public final Decimal f_rc_dlrs_room_used {get;set;}
		public final Decimal f_rc_dlrs_trans_used {get;set;}
		public final Decimal f_rc_dlrs_used {get;set;}
		public final Decimal f_theo_all {get;set;}
		public final Decimal f_theo_game {get;set;}
		public final Decimal f_theo_other {get;set;}
		public final Decimal f_theo_slot {get;set;}
		public final Decimal f_total_cms_comps {get;set;}
		public final Integer i_cash_cost {get;set;}
		public final Integer i_cash_coupons {get;set;}
		public final Integer i_comp_tickets {get;set;}
		public final Integer i_division_sort {get;set;}
		public final String i_dmid {get;set;}
		public final Integer i_event_cost {get;set;}
		public final Integer i_event_coupons {get;set;}
		public final Integer i_fb_cost {get;set;}
		public final Integer i_fb_coupons {get;set;}
		public final Integer i_hotel_cost {get;set;}
		public final Integer i_hotel_coupons {get;set;}
		public final Integer i_lop_all {get;set;}
		public final Integer i_lop_game {get;set;}
		public final Integer i_lop_other {get;set;}
		public final Integer i_lop_slot {get;set;}
		public final Integer i_merchandise_cost {get;set;}
		public final Integer i_merchandise_coupons {get;set;}
		public final Integer i_other_cost {get;set;}
		public final Integer i_other_coupons {get;set;}
		public final Integer i_pdb_trip_id {get;set;}
		public final Integer i_promo_rc_cost {get;set;}
		public final Integer i_promo_rc_coupons {get;set;}
		public final Integer i_prop_sort {get;set;}
		public final Integer i_rrerr_cash_cost {get;set;}
		public final Integer i_rrerr_cash_coupons {get;set;}
		public final Integer i_tot_cost {get;set;}
		public final Integer i_tot_coupons {get;set;}
		public final String id {get;set;}
    }
    
     public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (GstPdbTripDayDtlBidl.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('c_market_cd', wrapper.c_market_cd);
			row.put('c_market_cd_fk', wrapper.c_market_cd_fk);
			row.put('c_prop_cd', wrapper.c_prop_cd);
			row.put('c_prop_cd_fk', wrapper.c_prop_cd_fk);
			row.put('c_prop_market_cd', wrapper.c_prop_market_cd);
			row.put('c_prop_market_cd_fk', wrapper.c_prop_market_cd_fk);
			row.put('c_quality_cd', wrapper.c_quality_cd);
			row.put('contact', wrapper.contact);
			row.put('d_date', wrapper.d_date);
			row.put('d_end_dt_pdb_trip', wrapper.d_end_dt_pdb_trip);
			row.put('d_start_dt_pdb_trip', wrapper.d_start_dt_pdb_trip);
			row.put('d_timestamp', wrapper.d_timestamp);
			row.put('f_act_all', wrapper.f_act_all);
			row.put('f_act_game', wrapper.f_act_game);
			row.put('f_act_other', wrapper.f_act_other);
			row.put('f_act_slot', wrapper.f_act_slot);
			row.put('f_actual_profit_amt', wrapper.f_actual_profit_amt);
			row.put('f_avg_profit_amt', wrapper.f_avg_profit_amt);
			row.put('f_cash_marker_game', wrapper.f_cash_marker_game);
			row.put('f_cash_marker_other', wrapper.f_cash_marker_other);
			row.put('f_cash_rev_amt', wrapper.f_cash_rev_amt);
			row.put('f_cash_tt_amt', wrapper.f_cash_tt_amt);
			row.put('f_coinin_slot', wrapper.f_coinin_slot);
			row.put('f_comp_rev_amt', wrapper.f_comp_rev_amt);
			row.put('f_comp_tt_amt', wrapper.f_comp_tt_amt);
			row.put('f_cw_dlrs_dec_food_used', wrapper.f_cw_dlrs_dec_food_used);
			row.put('f_cw_dlrs_dec_other_used', wrapper.f_cw_dlrs_dec_other_used);
			row.put('f_cw_dlrs_dec_room_used', wrapper.f_cw_dlrs_dec_room_used);
			row.put('f_cw_dlrs_dec_trans_used', wrapper.f_cw_dlrs_dec_trans_used);
			row.put('f_cw_dlrs_dec_used', wrapper.f_cw_dlrs_dec_used);
			row.put('f_cw_dlrs_food_used', wrapper.f_cw_dlrs_food_used);
			row.put('f_cw_dlrs_nondec_food_used', wrapper.f_cw_dlrs_nondec_food_used);
			row.put('f_cw_dlrs_nondec_other_used', wrapper.f_cw_dlrs_nondec_other_used);
			row.put('f_cw_dlrs_nondec_room_used', wrapper.f_cw_dlrs_nondec_room_used);
			row.put('f_cw_dlrs_nondec_trans_used', wrapper.f_cw_dlrs_nondec_trans_used);
			row.put('f_cw_dlrs_nondec_used', wrapper.f_cw_dlrs_nondec_used);
			row.put('f_cw_dlrs_other_used', wrapper.f_cw_dlrs_other_used);
			row.put('f_cw_dlrs_room_used', wrapper.f_cw_dlrs_room_used);
			row.put('f_cw_dlrs_trans_used', wrapper.f_cw_dlrs_trans_used);
			row.put('f_cw_dlrs_used', wrapper.f_cw_dlrs_used);
			row.put('f_rc_dlrs_food_used', wrapper.f_rc_dlrs_food_used);
			row.put('f_rc_dlrs_other_used', wrapper.f_rc_dlrs_other_used);
			row.put('f_rc_dlrs_room_used', wrapper.f_rc_dlrs_room_used);
			row.put('f_rc_dlrs_trans_used', wrapper.f_rc_dlrs_trans_used);
			row.put('f_rc_dlrs_used', wrapper.f_rc_dlrs_used);
			row.put('f_theo_all', wrapper.f_theo_all);
			row.put('f_theo_game', wrapper.f_theo_game);
			row.put('f_theo_other', wrapper.f_theo_other);
			row.put('f_theo_slot', wrapper.f_theo_slot);
			row.put('f_total_cms_comps', wrapper.f_total_cms_comps);
			row.put('i_cash_cost', wrapper.i_cash_cost);
			row.put('i_cash_coupons', wrapper.i_cash_coupons);
			row.put('i_comp_tickets', wrapper.i_comp_tickets);
			row.put('i_division_sort', wrapper.i_division_sort);
			row.put('i_dmid', wrapper.i_dmid);
			row.put('i_event_cost', wrapper.i_event_cost);
			row.put('i_event_coupons', wrapper.i_event_coupons);
			row.put('i_fb_cost', wrapper.i_fb_cost);
			row.put('i_fb_coupons', wrapper.i_fb_coupons);
			row.put('i_hotel_cost', wrapper.i_hotel_cost);
			row.put('i_hotel_coupons', wrapper.i_hotel_coupons);
			row.put('i_lop_all', wrapper.i_lop_all);
			row.put('i_lop_game', wrapper.i_lop_game);
			row.put('i_lop_other', wrapper.i_lop_other);
			row.put('i_lop_slot', wrapper.i_lop_slot);
			row.put('i_merchandise_cost', wrapper.i_merchandise_cost);
			row.put('i_merchandise_coupons', wrapper.i_merchandise_coupons);
			row.put('i_other_cost', wrapper.i_other_cost);
			row.put('i_other_coupons', wrapper.i_other_coupons);
			row.put('i_pdb_trip_id', wrapper.i_pdb_trip_id);
			row.put('i_promo_rc_cost', wrapper.i_promo_rc_cost);
			row.put('i_promo_rc_coupons', wrapper.i_promo_rc_coupons);
			row.put('i_prop_sort', wrapper.i_prop_sort);
			row.put('i_rrerr_cash_cost', wrapper.i_rrerr_cash_cost);
			row.put('i_rrerr_cash_coupons', wrapper.i_rrerr_cash_coupons);
			row.put('i_tot_cost', wrapper.i_tot_cost);
			row.put('i_tot_coupons', wrapper.i_tot_coupons);
			row.put('id', wrapper.id);
        	rows.add(row);
        }
        return rows;
     }
}