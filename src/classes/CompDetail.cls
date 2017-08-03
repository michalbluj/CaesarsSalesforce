/**
 * Created by ceezar on 03.08.2017.
 */

public with sharing class CompDetail extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public final String id {get; set;}

        public final String account_c_prop_cd_fk {get; set;}
        public final String c_comp_comment {get; set;}
        public final String c_comp_prof_used {get; set;}
        public final String c_comp_status {get; set;}
        public final String c_comp_type {get; set;}
        public final String c_compor_code {get; set;}
        public final String c_compor_name {get; set;}
        public final String c_dept_cd {get; set;}
        public final String c_non_decrementing_comps {get; set;}
        public final String c_outlet_cat {get; set;}
        public final String c_outlet_cd {get; set;}
        public final String c_prop_cd {get; set;}
        public final String c_quality_cd_2 {get; set;}
        public final String c_quality_cd {get; set;}
        public final Integer c_transaction_id {get; set;}
        public final Decimal f_cw_dlrs_avail {get; set;}
        public final Decimal f_cw_dlrs_issued {get; set;}
        public final Decimal f_cw_dlrs_used {get; set;}
        public final Decimal f_dlrs_foreign_rc {get; set;}
        public final Decimal f_num_foreign_rc {get; set;}
        public final Decimal f_rc_avail_dlrs {get; set;}
        public final Decimal f_rc_dlrs_issued {get; set;}
        public final Decimal f_rc_dlrs_used {get; set;}
        public final Decimal f_rc_num_issued {get; set;}
        public final Decimal f_rc_num_used {get; set;}
        public final Integer i_comp_number {get; set;}
        public final Integer i_comp_worth_profile {get; set;}
        public final Integer i_dmid_2 {get; set;}
        public final Integer i_dmid {get; set;}
        public final Integer i_reward_credit_num {get; set;}
        public final Integer i_xref_dmid {get; set;}
        public final String d_comp_issue_date {get; set;}
        public final String d_comp_used_date {get; set;}
        public final String d_timestamp_2 {get; set;}
        public final String d_timestamp {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (CompDetail.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('account_c_prop_cd_fk', wrapper.account_c_prop_cd_fk);
            row.put('c_comp_comment', wrapper.c_comp_comment);
            row.put('c_comp_prof_used', wrapper.c_comp_prof_used);
            row.put('c_comp_status', wrapper.c_comp_status);
            row.put('c_comp_type', wrapper.c_comp_type);
            row.put('c_compor_code', wrapper.c_compor_code);
            row.put('c_compor_name', wrapper.c_compor_name);
            row.put('c_dept_cd', wrapper.c_dept_cd);
            row.put('c_non_decrementing_comps', wrapper.c_non_decrementing_comps);
            row.put('c_outlet_cat', wrapper.c_outlet_cat);
            row.put('c_outlet_cd', wrapper.c_outlet_cd);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_quality_cd_2', wrapper.c_quality_cd_2);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('c_transaction_id', wrapper.c_transaction_id);
            row.put('f_cw_dlrs_avail', wrapper.f_cw_dlrs_avail);
            row.put('f_cw_dlrs_issued', wrapper.f_cw_dlrs_issued);
            row.put('f_cw_dlrs_used', wrapper.f_cw_dlrs_used);
            row.put('f_dlrs_foreign_rc', wrapper.f_dlrs_foreign_rc);
            row.put('f_num_foreign_rc', wrapper.f_num_foreign_rc);
            row.put('f_rc_avail_dlrs', wrapper.f_rc_avail_dlrs);
            row.put('f_rc_dlrs_issued', wrapper.f_rc_dlrs_issued);
            row.put('f_rc_dlrs_used', wrapper.f_rc_dlrs_used);
            row.put('f_rc_num_issued', wrapper.f_rc_num_issued);
            row.put('f_rc_num_used', wrapper.f_rc_num_used);
            row.put('i_comp_number', wrapper.i_comp_number);
            row.put('i_comp_worth_profile', wrapper.i_comp_worth_profile);
            row.put('i_dmid_2', wrapper.i_dmid_2);
            row.put('i_dmid', wrapper.i_dmid);
            row.put('i_reward_credit_num', wrapper.i_reward_credit_num);
            row.put('i_xref_dmid', wrapper.i_xref_dmid);
            row.put('d_comp_issue_date', wrapper.d_comp_issue_date);
            row.put('d_comp_used_date', wrapper.d_comp_used_date);
            row.put('d_timestamp_2', wrapper.d_timestamp_2);
            row.put('d_timestamp', wrapper.d_timestamp);
            rows.add(row);
        }
        return rows;
    }
}