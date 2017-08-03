/**
 * Created by Michal Bluj on 2017-06-14.
 */

/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description generic class responsible mappign customer info json response
**/
public class CustomerInfo {

    public String id {get;set;}
    public String recordType {get;set;}
    public String contact {get;set;}
    public String i_dmid {get;set;}
    public CustomerInfoData data {get;set;}

    public class CustomerInfoData {

        public String i_dmid {get;set;}
        public String c_prop_cd {get;set;}
        public String c_quality_cd {get;set;}

        //Alias
        public String c_last_name {get;set;}
        public String c_first_name {get;set;}
        public String c_phonetic_last {get;set;}
        public String c_phonetic_first {get;set;}

        //Address
        public String c_addr_type {get;set;}
        public String c_address_1 {get;set;}
        public String c_address_2 {get;set;}
        public String c_state_cd {get;set;}
        public String c_country_cd {get;set;}
        public String c_apt_num {get;set;}
        public String c_zip_7 {get;set;}
        public String c_city {get;set;}
        public String c_zip_3 {get;set;}
        public String c_zip_plus_4 {get;set;}
        public String c_county {get;set;}
        public String c_msa_cd {get;set;}
        public String c_mail_cd {get;set;}
        public String c_tele_num {get;set;}
        public String c_country_tele_cd {get;set;}
        public String c_am_pm_cd {get;set;}
        public String c_area_cd {get;set;}
        public String c_pci_cd {get;set;}
        public String d_date {get;set;}
        public String c_dpbc {get;set;}
        public String c_adi {get;set;}
        public String c_route_cd {get;set;}

        // Acquisitions
        public String c_acquisition_cd {get;set;}
        public String d_acq_date {get;set;}

        // Casino
        public String c_rep_id {get;set;}
        public String d_update_dt {get;set;}
        public Integer i_casino_id {get;set;}
        public String d_create_date {get;set;}
        public String d_purge_react {get;set;}
        public String c_cred_appr_by {get;set;}
        public String c_prop_mail_cd {get;set;}
        public Decimal f_avail_credit {get;set;}
        public Decimal f_credit_limit {get;set;}
        public String c_credit_status {get;set;}
        public Decimal f_outstand_credit {get;set;}

        // Repcode assignments
        public String c_rep_cd {get;set;}
        public Integer i_efft_dy {get;set;}
        public Integer i_efft_mn {get;set;}
        public Integer i_efft_yr {get;set;}
        public String c_rep_type {get;set;}
        public Integer i_rep_rank {get;set;}
        public Integer i_patron_id {get;set;}
        public String c_current_cd {get;set;}
        public String c_entered_by {get;set;}
        public Integer d_trans_time {get;set;}
        public String d_efft_end_dt {get;set;}
        public String d_trans_100_yr {get;set;}
        public String d_trans_cal_dt {get;set;}
        public Integer i_rep_trip_nbr {get;set;}
        public String d_efft_start_dt {get;set;}
        public String c_patron_rep_appv {get;set;}
        public Integer i_last_rep_h_date {get;set;}
        public Integer i_assigned_century {get;set;}
        public Integer i_last_rep_cd_date {get;set;}

        //Associations
        public String i_primary_dmid {get;set;}
        public String i_secondary_dmid {get;set;}
        public String c_assn_reason {get;set;}
        public String c_req_prop_cd {get;set;}
        public String i_req_dmid {get;set;}
        public String c_req_employee {get;set;}
        public String d_create_dt {get;set;}

        //TierScore
        public String i_year {get;set;}
        public String d_as_of {get;set;}
        public String d_posted_on {get;set;}
        public Decimal f_promo_base {get;set;}
        public Decimal f_tier_score {get;set;}
        public Decimal f_adjust_base {get;set;}
        public Decimal f_earned_base {get;set;}
        public Decimal f_prev_tier_score {get;set;}

        //Event, PrefInterests, PrefPartner, PrefProgram, PrefSpecialty, PrefTemp, PrefHotel
        public String c_modifier {get;set;}
        public String i_response {get;set;}
        public String c_pref_flag {get;set;}
        public String i_category_id {get;set;}
        public String c_derived_flag {get;set;}
        public String i_preference_id {get;set;}
        public String c_data_source_cd {get;set;}
        public String c_pref_type_name {get;set;}
        public String c_modifier_location {get;set;}
        public String c_pref_category_name {get;set;}
        public String c_modifier_workstation {get;set;}

        //Interest
        public String c_interest_cd {get;set;}

        //pref5Game
        public Integer i_denom {get;set;}
        public Integer i_groups {get;set;}
        public String c_group_1 {get;set;}
        public String c_group_2 {get;set;}
        public String c_group_3 {get;set;}
        public String c_group_4 {get;set;}
        public String c_group_5 {get;set;}
        public Integer i_machines {get;set;}
        public String c_game_type {get;set;}
        public Integer i_cards_top {get;set;}
        public Decimal f_denom_pref {get;set;}
        public Decimal f_user_amt_1 {get;set;}
        public Decimal f_user_amt_2 {get;set;}
        public Decimal f_user_amt_3 {get;set;}
        public Decimal f_user_amt_4 {get;set;}
        public Decimal f_user_amt_5 {get;set;}
        public Decimal f_user_amt_6 {get;set;}
        public Decimal f_user_amt_7 {get;set;}
        public Decimal f_user_amt_8 {get;set;}
        public Decimal f_user_amt_9 {get;set;}
        public Integer i_denom_pref {get;set;}
        public Integer i_top1_value {get;set;}
        public Integer i_top5_value {get;set;}
        public String c_user_flag_1 {get;set;}
        public String c_user_flag_2 {get;set;}
        public String c_user_flag_3 {get;set;}
        public String c_user_flag_4 {get;set;}
        public String c_user_flag_5 {get;set;}
        public String c_user_flag_6 {get;set;}
        public String c_user_flag_7 {get;set;}
        public String c_user_flag_8 {get;set;}
        public String c_user_flag_9 {get;set;}
        public Decimal f_user_amt_10 {get;set;}
        public Integer i_cards_total {get;set;}
        public Integer i_denom_total {get;set;}
        public Integer i_total_value {get;set;}
        public String c_user_flag_10 {get;set;}
        public Integer i_user_score_1 {get;set;}
        public Integer i_user_score_2 {get;set;}
        public Integer i_user_score_3 {get;set;}
        public Integer i_user_score_4 {get;set;}
        public Integer i_user_score_5 {get;set;}
        public Integer i_user_score_6 {get;set;}
        public Integer i_user_score_7 {get;set;}
        public Integer i_user_score_8 {get;set;}
        public Integer i_user_score_9 {get;set;}
        public Integer i_user_score_10 {get;set;}

        //PrefSpecified
        public String c_channel_pref {get;set;}

        //ActivityFtd
        public String c_pos_flag {get;set;}
        public String c_w2g_flag {get;set;}
        public String c_comp_flag {get;set;}
        public String c_curr_flag {get;set;}
        //public Datetime d_timestamp {get;set;}
        public String c_event_flag {get;set;}
        public String c_hotel_flag {get;set;}
        public String c_visit_flag {get;set;}
        public String c_rating_flag {get;set;}
        public String d_last_trip_dt {get;set;}
        public String c_cons_rev_flag {get;set;}
        public String d_first_trip_dt {get;set;}
        public String c_offer_rdm_flag {get;set;}
        public String d_last_activity_dt {get;set;}

        //Email
        public String c_email {get;set;}
        public String c_source {get;set;}
        public String c_qual_cd {get;set;}
        public String c_ofr_freq {get;set;}
        public String c_qual_cat {get;set;}
        public String c_email_flag {get;set;}
        public Integer i_contact_count {get;set;}
        public String c_last_bounce_cd {get;set;}
        public String c_qual_reason_cd {get;set;}
        public String c_qual_hygiene_cd {get;set;}
        public String d_bounce_timestamp {get;set;}
        public String d_qual_chg_timestamp {get;set;}
        public String c_email_engagement_cd {get;set;}
        public String d_email_chg_timestamp {get;set;}
        public String d_qual_conf_timestamp {get;set;}
        public String c_email_address_valid_cd {get;set;}
        public String c_email_address_quality_cd {get;set;}
        public String d_last_change_timestamp_utc {get;set;}

        //EthnicityAppend
        public String c_asian_flag {get;set;}
        public String c_source_file {get;set;}
        public String c_ethnic_group1 {get;set;}
        public String c_ethnic_group2 {get;set;}
        public String c_pref_language {get;set;}
        public String d_last_update_dt {get;set;}
        public String c_sub_ethnic_type {get;set;}
        public String c_main_ethnic_type {get;set;}

        //NxtgenAddress
        public String c_notes {get; set;}
        public String c_phone {get; set;}
        public String c_addr_1 {get; set;}
        public String c_addr_2 {get; set;}
        public String c_addr_3 {get; set;}
        public String c_app_cd {get; set;}
        public String c_zip_cd {get; set;}
        public String c_book_id {get; set;}
        public String c_addr_desc {get; set;}
        public String c_city_name {get; set;}
        public String c_state_name {get; set;}
        public Integer i_note_pad_id {get; set;}
        public String c_creator_login {get; set;}
        public String c_addr_status_cd {get; set;}
        public String c_modifier_login {get; set;}
        public Integer i_pcs_address_id {get; set;}

        //NxtgenContactChan
        public String c_do_not_contact_channel {get;set;}
        public String c_preferred_contact_channel {get;set;}

        //NxtgenContactHist
        public String c_outcome {get; set;}
        public String c_task_id {get; set;}
        public Integer i_to_do_id {get; set;}
        public String c_direction {get; set;}
        public String d_contact_dt {get; set;}
        public Integer i_contact_id {get; set;}
        public String c_middle_init {get; set;}
        public String c_outcome_desc {get; set;}
        public String c_outcome_more {get; set;}
        public String c_outcome_notes {get; set;}
        public String c_contact_status {get; set;}
        public String c_contact_subject {get; set;}
        public String c_contacted_channel {get; set;}

        //NxtgenEmail
        public Integer i_email_id {get;set;}
        public String c_created_by {get;set;}
        public String c_email_type {get;set;}
        public String c_email_status {get;set;}

        //NxtgenInterest
        public String c_interest {get;set;}
        public Integer i_interest_id {get;set;}
        public String c_interest_group {get;set;}
        public String c_interest_notes {get;set;}
        public String c_interest_status {get;set;}

        //NxtgenInterestResp
        public String c_nick_name {get;set;}

        //NxtgenNotePad
        public String c_private {get;set;}
        public String c_note_pad {get;set;}
        public String c_note_pad_status {get;set;}
        public String c_note_pad_priority {get;set;}
        public String c_send_notification {get;set;}

        //NxtgenPhone
        public String c_phone_type {get;set;}
        public String c_phone_status {get;set;}
        public Integer i_pcs_phone_id {get;set;}

        //NxtgenRelationship
        public String d_rel_dob {get;set;}
        public String c_rel_name {get;set;}
        public String c_rel_notes {get;set;}
        public Integer i_gst_rel_id {get;set;}
        public String c_rel_type_cd {get;set;}
        public String c_relationship {get;set;}
        public String c_rel_status_cd {get;set;}
        public String i_plays_with_dmid {get;set;}

        //NxtgenToDo
        public Decimal f_worth {get;set;}
        public String d_due_dt {get;set;}
        public String d_due_time {get;set;}
        public Integer i_event_id {get;set;}
        public String c_to_do_type {get;set;}
        public Decimal f_market_adw {get;set;}
        public String c_to_do_notes {get;set;}
        public String c_to_do_status {get;set;}
        public String c_to_do_segment {get;set;}
        public String c_to_do_subject {get;set;}
        public String c_offer_reserved {get;set;}
        public String c_suggested_channel {get;set;}
        public String d_contact_dt_by_all {get;set;}
        public String d_my_last_contact_dt {get;set;}
        public String d_last_contact_dt_by_me {get;set;}
        public String d_phone_contact_dt_by_all {get;set;}

        //Occupation
        public String c_sic_cd {get;set;}
        public String c_firm_name {get;set;}
        public String c_job_title {get;set;}
        public String c_occupation {get;set;}
        public String c_owner_flag {get;set;}
        public String c_nbr_yr_emply {get;set;}

        //PatronPref
        public Integer i_file_id {get;set;}
        public Integer i_ins_run_id {get;set;}
        public Integer i_rank_value {get;set;}
        public Integer i_upd_run_id {get;set;}
        public String c_ok2ask_flag {get;set;}
        public String d_create_update {get;set;}
        public Integer i_original_dmid {get;set;}
        public String c_freeform_value {get;set;}
        public String c_it_qry_category {get;set;}

        //Personal
        public Integer i_ssn {get;set;}
        public String c_dl_num {get;set;}
        public String c_gender {get;set;}
        public String c_dl_state_cd {get;set;}
        public String c_id_verified {get;set;}
        public String d_annivers_dt {get;set;}
        public String c_marital_status {get;set;}

        //PrefGlba
        public String c_pref_suppress_flag {get;set;}

        //PrefHotel
        public String c_cc_type {get;set;}
        public String c_smoking {get;set;}
        public String c_bed_type {get;set;}
        public String c_cc_number {get;set;}
        public String c_room_type {get;set;}
        public String c_companion_id {get;set;}
        public String c_spcl_request {get;set;}
        public String d_cc_expire_dt {get;set;}
        public String c_spcl_instruction {get;set;}

        //VedwAssociated
        public String age {get;set;}
        public String d_dob {get;set;}
        public String c_suffix {get;set;}
        public String c_addr_pref {get;set;}
        public String c_mail_flag {get;set;}
        
        //VedwEthnicity
        public String c_group1 {get;set;}
        public String c_group2 {get;set;}
        public String c_group3 {get;set;}
        public String c_group4 {get;set;}
        public String c_group_code {get;set;}
        public String c_match_type {get;set;}
        public String d_lastupdate {get;set;}
        public String c_ethnic_code {get;set;}
        public String c_vendor_code {get;set;}
        public String c_ethdom_relg_cd {get;set;}
        public Integer i_est_names_12mn {get;set;}
        public String c_group_code_desc {get;set;}
        public String c_ethnic_code_desc {get;set;}
        public String c_ethdom_relg_cd_desc {get;set;}
    }
}