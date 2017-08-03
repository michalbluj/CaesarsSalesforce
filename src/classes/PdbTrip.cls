/**
 * Created by ceezar on 31.07.2017.
 */

public with sharing class PdbTrip extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public final String id {get; set;}

        public final String account_c_home_prop_cd_fk {get; set;}
        public final String account_c_prop_cd_fk {get; set;}
        public final String c_as_brand_flag {get; set;}
        public final String c_as_cms_flag {get; set;}
        public final String c_casino_flag {get; set;}
        public final String c_cons_rev_flag {get; set;}
        public final String c_curr_flag {get; set;}
        public final String c_first_prop_visit {get; set;}
        public final String c_home_prop_cd {get; set;}
        public final String c_hotel_flag {get; set;}
        public final String c_pos_flag {get; set;}
        public final String c_prop_cd {get; set;}
        public final String c_quality_cd {get; set;}
        public final String c_rated_trip {get; set;}
        public final String c_w2g_flag {get; set;}
        public final String c_week_cd {get; set;}
        public final String contact_fk {get; set;}
        public final String d_end_dt {get; set;}
        public final String d_rpt_per {get; set;}
        public final String d_start_dt {get; set;}
        public final String d_timestamp {get; set;}
        public final Decimal f_actual_all {get; set;}
        public final Decimal f_actual_game {get; set;}
        public final Decimal f_actual_oth {get; set;}
        public final Decimal f_actual_slot {get; set;}
        public final Decimal f_avgbet_game {get; set;}
        public final Decimal f_avgbet_oth {get; set;}
        public final Decimal f_avgbet_slot {get; set;}
        public final Decimal f_beer_amt {get; set;}
        public final Decimal f_cash_chrg_amt {get; set;}
        public final Decimal f_cash_play_game {get; set;}
        public final Decimal f_cash_play_oth {get; set;}
        public final Decimal f_cash_play_slot {get; set;}
        public final Decimal f_comp_rev {get; set;}
        public final Decimal f_comp_worth {get; set;}
        public final Decimal f_discount_amt {get; set;}
        public final Decimal f_entertain_actual_profit {get; set;}
        public final Decimal f_entertain_avg_profit {get; set;}
        public final Decimal f_entertain_cash_rev {get; set;}
        public final Decimal f_entertain_cash_tt {get; set;}
        public final Decimal f_entertain_comp_rev {get; set;}
        public final Decimal f_entertain_comp_tt {get; set;}
        public final Decimal f_event_actual_profit {get; set;}
        public final Decimal f_event_avg_profit {get; set;}
        public final Decimal f_event_cash_rev {get; set;}
        public final Decimal f_event_cash_tt {get; set;}
        public final Decimal f_event_comp_rev {get; set;}
        public final Decimal f_event_comp_tt {get; set;}
        public final Decimal f_fb_rev {get; set;}
        public final Decimal f_food_amt {get; set;}
        public final Decimal f_food_bev_nc_actual_profit {get; set;}
        public final Decimal f_food_bev_nc_avg_profit {get; set;}
        public final Decimal f_food_bev_nc_cash_rev {get; set;}
        public final Decimal f_food_bev_nc_cash_tt {get; set;}
        public final Decimal f_food_bev_nc_comp_rev {get; set;}
        public final Decimal f_food_bev_nc_comp_tt {get; set;}
        public final Decimal f_food_cd_actual_profit {get; set;}
        public final Decimal f_food_cd_avg_profit {get; set;}
        public final Decimal f_food_cd_cash_rev {get; set;}
        public final Decimal f_food_cd_cash_tt {get; set;}
        public final Decimal f_food_cd_comp_rev {get; set;}
        public final Decimal f_food_cd_comp_tt {get; set;}
        public final Decimal f_food_comp_amt {get; set;}
        public final Decimal f_food_fd_actual_profit {get; set;}
        public final Decimal f_food_fd_avg_profit {get; set;}
        public final Decimal f_food_fd_cash_rev {get; set;}
        public final Decimal f_food_fd_cash_tt {get; set;}
        public final Decimal f_food_fd_comp_rev {get; set;}
        public final Decimal f_food_fd_comp_tt {get; set;}
        public final Decimal f_food_qs_actual_profit {get; set;}
        public final Decimal f_food_qs_avg_profit {get; set;}
        public final Decimal f_food_qs_cash_rev {get; set;}
        public final Decimal f_food_qs_cash_tt {get; set;}
        public final Decimal f_food_qs_comp_rev {get; set;}
        public final Decimal f_food_qs_comp_tt {get; set;}
        public final Decimal f_golf_actual_profit {get; set;}
        public final Decimal f_golf_avg_profit {get; set;}
        public final Decimal f_golf_cash_rev {get; set;}
        public final Decimal f_golf_cash_tt {get; set;}
        public final Decimal f_golf_comp_rev {get; set;}
        public final Decimal f_golf_comp_tt {get; set;}
        public final Decimal f_liq_amt {get; set;}
        public final Decimal f_marker_play_game {get; set;}
        public final Decimal f_marker_play_oth {get; set;}
        public final Decimal f_marker_play_slot {get; set;}
        public final Decimal f_misc_amt {get; set;}
        public final Decimal f_na_bev_amt {get; set;}
        public final Decimal f_oth_amt {get; set;}
        public final Decimal f_other_actual_profit {get; set;}
        public final Decimal f_other_avg_profit {get; set;}
        public final Decimal f_other_cash_rev {get; set;}
        public final Decimal f_other_cash_tt {get; set;}
        public final Decimal f_other_comp_amt {get; set;}
        public final Decimal f_other_comp_rev {get; set;}
        public final Decimal f_other_comp_tt {get; set;}
        public final Decimal f_other_payment_amt {get; set;}
        public final Decimal f_other_rev {get; set;}
        public final Decimal f_package_actual_profit {get; set;}
        public final Decimal f_package_avg_profit {get; set;}
        public final Decimal f_package_cash_rev {get; set;}
        public final Decimal f_package_cash_tt {get; set;}
        public final Decimal f_package_comp_rev {get; set;}
        public final Decimal f_package_comp_tt {get; set;}
        public final Decimal f_pos_actual_profit_amt {get; set;}
        public final Decimal f_pos_avg_profit_amt {get; set;}
        public final Decimal f_pos_comp_amt {get; set;}
        public final Decimal f_retail_amt {get; set;}
        public final Decimal f_retail_le_actual_profit {get; set;}
        public final Decimal f_retail_le_avg_profit {get; set;}
        public final Decimal f_retail_le_cash_rev {get; set;}
        public final Decimal f_retail_le_cash_tt {get; set;}
        public final Decimal f_retail_le_comp_rev {get; set;}
        public final Decimal f_retail_le_comp_tt {get; set;}
        public final Decimal f_retail_owned_actual_profit {get; set;}
        public final Decimal f_retail_owned_avg_profit {get; set;}
        public final Decimal f_retail_owned_cash_rev {get; set;}
        public final Decimal f_retail_owned_cash_tt {get; set;}
        public final Decimal f_retail_owned_comp_rev {get; set;}
        public final Decimal f_retail_owned_comp_tt {get; set;}
        public final Decimal f_room_actual_profit {get; set;}
        public final Decimal f_room_avg_profit {get; set;}
        public final Decimal f_room_cash_rev {get; set;}
        public final Decimal f_room_cash_tt {get; set;}
        public final Decimal f_room_chrg_amt {get; set;}
        public final Decimal f_room_comp_amt {get; set;}
        public final Decimal f_room_comp_rev {get; set;}
        public final Decimal f_room_comp_tt {get; set;}
        public final Decimal f_room_rev {get; set;}
        public final Decimal f_service_charge_amt {get; set;}
        public final Decimal f_spa_actual_profit {get; set;}
        public final Decimal f_spa_avg_profit {get; set;}
        public final Decimal f_spa_cash_rev {get; set;}
        public final Decimal f_spa_cash_tt {get; set;}
        public final Decimal f_spa_comp_rev {get; set;}
        public final Decimal f_spa_comp_tt {get; set;}
        public final Decimal f_tax_amt {get; set;}
        public final Decimal f_tax_discount_oth_amt {get; set;}
        public final Decimal f_theo_all {get; set;}
        public final Decimal f_theo_game {get; set;}
        public final Decimal f_theo_oth {get; set;}
        public final Decimal f_theo_slot {get; set;}
        public final Decimal f_total_comp_amount {get; set;}
        public final Decimal f_total_item_amt {get; set;}
        public final Decimal f_total_payment_amt {get; set;}
        public final Decimal f_trans_amt {get; set;}
        public final Decimal f_transport_actual_profit {get; set;}
        public final Decimal f_transport_avg_profit {get; set;}
        public final Decimal f_transport_cash_rev {get; set;}
        public final Decimal f_transport_cash_tt {get; set;}
        public final Decimal f_transport_comp_rev {get; set;}
        public final Decimal f_transport_comp_tt {get; set;}
        public final Decimal f_wine_amt {get; set;}
        public final Integer i_avgbet_div_game {get; set;}
        public final Integer i_avgbet_div_oth {get; set;}
        public final Integer i_avgbet_div_slot {get; set;}
        public final Integer i_brand_trip_nbr {get; set;}
        public final Integer i_comped_trip {get; set;}
        public final Integer i_covers {get; set;}
        public final String i_dmid {get; set;}
        public final Integer i_events {get; set;}
        public final Integer i_len_of_play_game {get; set;}
        public final Integer i_len_of_play_oth {get; set;}
        public final Integer i_len_of_play_slot {get; set;}
        public final Integer i_line_item_qty {get; set;}
        public final Integer i_nbr_cms_trips {get; set;}
        public final Integer i_nbr_cons_rev_days {get; set;}
        public final Integer i_nbr_days {get; set;}
        public final Integer i_nbr_line_item {get; set;}
        public final Integer i_nbr_occupants {get; set;}
        public final Integer i_nbr_offers_red {get; set;}
        public final Integer i_nbr_offers_unred {get; set;}
        public final Integer i_nbr_pos_days {get; set;}
        public final Integer i_nbr_rev_centers {get; set;}
        public final Integer i_nbr_rooms {get; set;}
        public final Integer i_nbr_trans {get; set;}
        public final Integer i_nbr_trip_game {get; set;}
        public final Integer i_nbr_trip_oth {get; set;}
        public final Integer i_nbr_trip_slot {get; set;}
        public final String i_pdb_trip_id {get; set;}
        public final Integer i_rated_days {get; set;}
        public final Integer i_rated_trips {get; set;}
        public final Integer i_rm_night {get; set;}
        public final Integer i_stay {get; set;}
        public final Integer i_trip_nbr {get; set;}
        public final Integer week_code_fk {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (PdbTrip.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('account_c_home_prop_cd_fk', wrapper.account_c_home_prop_cd_fk);
            row.put('account_c_prop_cd_fk', wrapper.account_c_prop_cd_fk);
            row.put('c_as_brand_flag', wrapper.c_as_brand_flag);
            row.put('c_as_cms_flag', wrapper.c_as_cms_flag);
            row.put('c_casino_flag', wrapper.c_casino_flag);
            row.put('c_cons_rev_flag', wrapper.c_cons_rev_flag);
            row.put('c_curr_flag', wrapper.c_curr_flag);
            row.put('c_first_prop_visit', wrapper.c_first_prop_visit);
            row.put('c_home_prop_cd', wrapper.c_home_prop_cd);
            row.put('c_hotel_flag', wrapper.c_hotel_flag);
            row.put('c_pos_flag', wrapper.c_pos_flag);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('c_rated_trip', wrapper.c_rated_trip);
            row.put('c_w2g_flag', wrapper.c_w2g_flag);
            row.put('c_week_cd', wrapper.c_week_cd);
            row.put('contact_fk', wrapper.contact_fk);
            row.put('d_end_dt', wrapper.d_end_dt);
            row.put('d_rpt_per', wrapper.d_rpt_per);
            row.put('d_start_dt', wrapper.d_start_dt);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('f_actual_all', wrapper.f_actual_all);
            row.put('f_actual_game', wrapper.f_actual_game);
            row.put('f_actual_oth', wrapper.f_actual_oth);
            row.put('f_actual_slot', wrapper.f_actual_slot);
            row.put('f_avgbet_game', wrapper.f_avgbet_game);
            row.put('f_avgbet_oth', wrapper.f_avgbet_oth);
            row.put('f_avgbet_slot', wrapper.f_avgbet_slot);
            row.put('f_beer_amt', wrapper.f_beer_amt);
            row.put('f_cash_chrg_amt', wrapper.f_cash_chrg_amt);
            row.put('f_cash_play_game', wrapper.f_cash_play_game);
            row.put('f_cash_play_oth', wrapper.f_cash_play_oth);
            row.put('f_cash_play_slot', wrapper.f_cash_play_slot);
            row.put('f_comp_rev', wrapper.f_comp_rev);
            row.put('f_comp_worth', wrapper.f_comp_worth);
            row.put('f_discount_amt', wrapper.f_discount_amt);
            row.put('f_entertain_actual_profit', wrapper.f_entertain_actual_profit);
            row.put('f_entertain_avg_profit', wrapper.f_entertain_avg_profit);
            row.put('f_entertain_cash_rev', wrapper.f_entertain_cash_rev);
            row.put('f_entertain_cash_tt', wrapper.f_entertain_cash_tt);
            row.put('f_entertain_comp_rev', wrapper.f_entertain_comp_rev);
            row.put('f_entertain_comp_tt', wrapper.f_entertain_comp_tt);
            row.put('f_event_actual_profit', wrapper.f_event_actual_profit);
            row.put('f_event_avg_profit', wrapper.f_event_avg_profit);
            row.put('f_event_cash_rev', wrapper.f_event_cash_rev);
            row.put('f_event_cash_tt', wrapper.f_event_cash_tt);
            row.put('f_event_comp_rev', wrapper.f_event_comp_rev);
            row.put('f_event_comp_tt', wrapper.f_event_comp_tt);
            row.put('f_fb_rev', wrapper.f_fb_rev);
            row.put('f_food_amt', wrapper.f_food_amt);
            row.put('f_food_bev_nc_actual_profit', wrapper.f_food_bev_nc_actual_profit);
            row.put('f_food_bev_nc_avg_profit', wrapper.f_food_bev_nc_avg_profit);
            row.put('f_food_bev_nc_cash_rev', wrapper.f_food_bev_nc_cash_rev);
            row.put('f_food_bev_nc_cash_tt', wrapper.f_food_bev_nc_cash_tt);
            row.put('f_food_bev_nc_comp_rev', wrapper.f_food_bev_nc_comp_rev);
            row.put('f_food_bev_nc_comp_tt', wrapper.f_food_bev_nc_comp_tt);
            row.put('f_food_cd_actual_profit', wrapper.f_food_cd_actual_profit);
            row.put('f_food_cd_avg_profit', wrapper.f_food_cd_avg_profit);
            row.put('f_food_cd_cash_rev', wrapper.f_food_cd_cash_rev);
            row.put('f_food_cd_cash_tt', wrapper.f_food_cd_cash_tt);
            row.put('f_food_cd_comp_rev', wrapper.f_food_cd_comp_rev);
            row.put('f_food_cd_comp_tt', wrapper.f_food_cd_comp_tt);
            row.put('f_food_comp_amt', wrapper.f_food_comp_amt);
            row.put('f_food_fd_actual_profit', wrapper.f_food_fd_actual_profit);
            row.put('f_food_fd_avg_profit', wrapper.f_food_fd_avg_profit);
            row.put('f_food_fd_cash_rev', wrapper.f_food_fd_cash_rev);
            row.put('f_food_fd_cash_tt', wrapper.f_food_fd_cash_tt);
            row.put('f_food_fd_comp_rev', wrapper.f_food_fd_comp_rev);
            row.put('f_food_fd_comp_tt', wrapper.f_food_fd_comp_tt);
            row.put('f_food_qs_actual_profit', wrapper.f_food_qs_actual_profit);
            row.put('f_food_qs_avg_profit', wrapper.f_food_qs_avg_profit);
            row.put('f_food_qs_cash_rev', wrapper.f_food_qs_cash_rev);
            row.put('f_food_qs_cash_tt', wrapper.f_food_qs_cash_tt);
            row.put('f_food_qs_comp_rev', wrapper.f_food_qs_comp_rev);
            row.put('f_food_qs_comp_tt', wrapper.f_food_qs_comp_tt);
            row.put('f_golf_actual_profit', wrapper.f_golf_actual_profit);
            row.put('f_golf_avg_profit', wrapper.f_golf_avg_profit);
            row.put('f_golf_cash_rev', wrapper.f_golf_cash_rev);
            row.put('f_golf_cash_tt', wrapper.f_golf_cash_tt);
            row.put('f_golf_comp_rev', wrapper.f_golf_comp_rev);
            row.put('f_golf_comp_tt', wrapper.f_golf_comp_tt);
            row.put('f_liq_amt', wrapper.f_liq_amt);
            row.put('f_marker_play_game', wrapper.f_marker_play_game);
            row.put('f_marker_play_oth', wrapper.f_marker_play_oth);
            row.put('f_marker_play_slot', wrapper.f_marker_play_slot);
            row.put('f_misc_amt', wrapper.f_misc_amt);
            row.put('f_na_bev_amt', wrapper.f_na_bev_amt);
            row.put('f_oth_amt', wrapper.f_oth_amt);
            row.put('f_other_actual_profit', wrapper.f_other_actual_profit);
            row.put('f_other_avg_profit', wrapper.f_other_avg_profit);
            row.put('f_other_cash_rev', wrapper.f_other_cash_rev);
            row.put('f_other_cash_tt', wrapper.f_other_cash_tt);
            row.put('f_other_comp_amt', wrapper.f_other_comp_amt);
            row.put('f_other_comp_rev', wrapper.f_other_comp_rev);
            row.put('f_other_comp_tt', wrapper.f_other_comp_tt);
            row.put('f_other_payment_amt', wrapper.f_other_payment_amt);
            row.put('f_other_rev', wrapper.f_other_rev);
            row.put('f_package_actual_profit', wrapper.f_package_actual_profit);
            row.put('f_package_avg_profit', wrapper.f_package_avg_profit);
            row.put('f_package_cash_rev', wrapper.f_package_cash_rev);
            row.put('f_package_cash_tt', wrapper.f_package_cash_tt);
            row.put('f_package_comp_rev', wrapper.f_package_comp_rev);
            row.put('f_package_comp_tt', wrapper.f_package_comp_tt);
            row.put('f_pos_actual_profit_amt', wrapper.f_pos_actual_profit_amt);
            row.put('f_pos_avg_profit_amt', wrapper.f_pos_avg_profit_amt);
            row.put('f_pos_comp_amt', wrapper.f_pos_comp_amt);
            row.put('f_retail_amt', wrapper.f_retail_amt);
            row.put('f_retail_le_actual_profit', wrapper.f_retail_le_actual_profit);
            row.put('f_retail_le_avg_profit', wrapper.f_retail_le_avg_profit);
            row.put('f_retail_le_cash_rev', wrapper.f_retail_le_cash_rev);
            row.put('f_retail_le_cash_tt', wrapper.f_retail_le_cash_tt);
            row.put('f_retail_le_comp_rev', wrapper.f_retail_le_comp_rev);
            row.put('f_retail_le_comp_tt', wrapper.f_retail_le_comp_tt);
            row.put('f_retail_owned_actual_profit', wrapper.f_retail_owned_actual_profit);
            row.put('f_retail_owned_avg_profit', wrapper.f_retail_owned_avg_profit);
            row.put('f_retail_owned_cash_rev', wrapper.f_retail_owned_cash_rev);
            row.put('f_retail_owned_cash_tt', wrapper.f_retail_owned_cash_tt);
            row.put('f_retail_owned_comp_rev', wrapper.f_retail_owned_comp_rev);
            row.put('f_retail_owned_comp_tt', wrapper.f_retail_owned_comp_tt);
            row.put('f_room_actual_profit', wrapper.f_room_actual_profit);
            row.put('f_room_avg_profit', wrapper.f_room_avg_profit);
            row.put('f_room_cash_rev', wrapper.f_room_cash_rev);
            row.put('f_room_cash_tt', wrapper.f_room_cash_tt);
            row.put('f_room_chrg_amt', wrapper.f_room_chrg_amt);
            row.put('f_room_comp_amt', wrapper.f_room_comp_amt);
            row.put('f_room_comp_rev', wrapper.f_room_comp_rev);
            row.put('f_room_comp_tt', wrapper.f_room_comp_tt);
            row.put('f_room_rev', wrapper.f_room_rev);
            row.put('f_service_charge_amt', wrapper.f_service_charge_amt);
            row.put('f_spa_actual_profit', wrapper.f_spa_actual_profit);
            row.put('f_spa_avg_profit', wrapper.f_spa_avg_profit);
            row.put('f_spa_cash_rev', wrapper.f_spa_cash_rev);
            row.put('f_spa_cash_tt', wrapper.f_spa_cash_tt);
            row.put('f_spa_comp_rev', wrapper.f_spa_comp_rev);
            row.put('f_spa_comp_tt', wrapper.f_spa_comp_tt);
            row.put('f_tax_amt', wrapper.f_tax_amt);
            row.put('f_tax_discount_oth_amt', wrapper.f_tax_discount_oth_amt);
            row.put('f_theo_all', wrapper.f_theo_all);
            row.put('f_theo_game', wrapper.f_theo_game);
            row.put('f_theo_oth', wrapper.f_theo_oth);
            row.put('f_theo_slot', wrapper.f_theo_slot);
            row.put('f_total_comp_amount', wrapper.f_total_comp_amount);
            row.put('f_total_item_amt', wrapper.f_total_item_amt);
            row.put('f_total_payment_amt', wrapper.f_total_payment_amt);
            row.put('f_trans_amt', wrapper.f_trans_amt);
            row.put('f_transport_actual_profit', wrapper.f_transport_actual_profit);
            row.put('f_transport_avg_profit', wrapper.f_transport_avg_profit);
            row.put('f_transport_cash_rev', wrapper.f_transport_cash_rev);
            row.put('f_transport_cash_tt', wrapper.f_transport_cash_tt);
            row.put('f_transport_comp_rev', wrapper.f_transport_comp_rev);
            row.put('f_transport_comp_tt', wrapper.f_transport_comp_tt);
            row.put('f_wine_amt', wrapper.f_wine_amt);
            row.put('i_avgbet_div_game', wrapper.i_avgbet_div_game);
            row.put('i_avgbet_div_oth', wrapper.i_avgbet_div_oth);
            row.put('i_avgbet_div_slot', wrapper.i_avgbet_div_slot);
            row.put('i_brand_trip_nbr', wrapper.i_brand_trip_nbr);
            row.put('i_comped_trip', wrapper.i_comped_trip);
            row.put('i_covers', wrapper.i_covers);
            row.put('i_dmid', wrapper.i_dmid);
            row.put('i_events', wrapper.i_events);
            row.put('i_len_of_play_game', wrapper.i_len_of_play_game);
            row.put('i_len_of_play_oth', wrapper.i_len_of_play_oth);
            row.put('i_len_of_play_slot', wrapper.i_len_of_play_slot);
            row.put('i_line_item_qty', wrapper.i_line_item_qty);
            row.put('i_nbr_cms_trips', wrapper.i_nbr_cms_trips);
            row.put('i_nbr_cons_rev_days', wrapper.i_nbr_cons_rev_days);
            row.put('i_nbr_days', wrapper.i_nbr_days);
            row.put('i_nbr_line_item', wrapper.i_nbr_line_item);
            row.put('i_nbr_occupants', wrapper.i_nbr_occupants);
            row.put('i_nbr_offers_red', wrapper.i_nbr_offers_red);
            row.put('i_nbr_offers_unred', wrapper.i_nbr_offers_unred);
            row.put('i_nbr_pos_days', wrapper.i_nbr_pos_days);
            row.put('i_nbr_rev_centers', wrapper.i_nbr_rev_centers);
            row.put('i_nbr_rooms', wrapper.i_nbr_rooms);
            row.put('i_nbr_trans', wrapper.i_nbr_trans);
            row.put('i_nbr_trip_game', wrapper.i_nbr_trip_game);
            row.put('i_nbr_trip_oth', wrapper.i_nbr_trip_oth);
            row.put('i_nbr_trip_slot', wrapper.i_nbr_trip_slot);
            row.put('i_pdb_trip_id', wrapper.i_pdb_trip_id);
            row.put('i_rated_days', wrapper.i_rated_days);
            row.put('i_rated_trips', wrapper.i_rated_trips);
            row.put('i_rm_night', wrapper.i_rm_night);
            row.put('i_stay', wrapper.i_stay);
            row.put('i_trip_nbr', wrapper.i_trip_nbr);
            row.put('week_code_fk', wrapper.week_code_fk);
            rows.add(row);
        }
        return rows;
    }
}