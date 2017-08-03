/**
 * Created by ceezar on 31.07.2017.
 */

public with sharing class LmsSourceDescSda extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public final String id {get; set;}

        public final String c_prop_cd {get; set;}
        public final String c_prop_cd_fk {get; set;}
        public final String c_quality_cd {get; set;}
        public final String c_rms_group_source_cd {get; set;}
        public final String c_source_cat1 {get; set;}
        public final String c_source_cat2 {get; set;}
        public final String c_source_cat3 {get; set;}
        public final String c_source_cat4 {get; set;}
        public final String c_source_cat5 {get; set;}
        public final String c_source_cat6 {get; set;}
        public final String c_source_cat_sda {get; set;}
        public final String c_source_cd {get; set;}
        public final String c_source_cd_desc {get; set;}
        public final String c_source_cd_fk {get; set;}
        public final String c_source_group {get; set;}
        public final String c_user_flag1 {get; set;}
        public final String c_user_flag2 {get; set;}
        public final String c_user_flag3 {get; set;}
        public final String c_user_flag4 {get; set;}
        public final String c_user_flag5 {get; set;}
        public final String c_user_flag6 {get; set;}
        public final String c_user_flag7 {get; set;}
        public final String c_user_flag8 {get; set;}
        public final DateTime d_last_update_ts {get; set;}
        public final DateTime d_timestamp {get; set;}
        public final Decimal f_user_amt1 {get; set;}
        public final Decimal f_user_amt2 {get; set;}
        public final Decimal f_user_amt3 {get; set;}
        public final Decimal f_user_amt4 {get; set;}
        public final Integer i_source_cat1_sort {get; set;}
        public final Integer i_source_cat2_sort {get; set;}
        public final Integer i_source_cat3_sort {get; set;}
        public final Integer i_source_cat4_sort {get; set;}
        public final Integer i_source_cat5_sort {get; set;}
        public final Integer i_source_cat6_sort {get; set;}
        public final Integer i_source_cat_sda_sort {get; set;}
        public final Integer i_user_score1 {get; set;}
        public final Integer i_user_score2 {get; set;}
        public final Integer i_user_score3 {get; set;}
        public final Integer i_user_score4 {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (LmsSourceDescSda.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_prop_cd_fk', wrapper.c_prop_cd_fk);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('c_rms_group_source_cd', wrapper.c_rms_group_source_cd);
            row.put('c_source_cat1', wrapper.c_source_cat1);
            row.put('c_source_cat2', wrapper.c_source_cat2);
            row.put('c_source_cat3', wrapper.c_source_cat3);
            row.put('c_source_cat4', wrapper.c_source_cat4);
            row.put('c_source_cat5', wrapper.c_source_cat5);
            row.put('c_source_cat6', wrapper.c_source_cat6);
            row.put('c_source_cat_sda', wrapper.c_source_cat_sda);
            row.put('c_source_cd', wrapper.c_source_cd);
            row.put('c_source_cd_desc', wrapper.c_source_cd_desc);
            row.put('c_source_cd_fk', wrapper.c_source_cd_fk);
            row.put('c_source_group', wrapper.c_source_group);
            row.put('c_user_flag1', wrapper.c_user_flag1);
            row.put('c_user_flag2', wrapper.c_user_flag2);
            row.put('c_user_flag3', wrapper.c_user_flag3);
            row.put('c_user_flag4', wrapper.c_user_flag4);
            row.put('c_user_flag5', wrapper.c_user_flag5);
            row.put('c_user_flag6', wrapper.c_user_flag6);
            row.put('c_user_flag7', wrapper.c_user_flag7);
            row.put('c_user_flag8', wrapper.c_user_flag8);
            row.put('d_last_update_ts', wrapper.d_last_update_ts);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('f_user_amt1', wrapper.f_user_amt1);
            row.put('f_user_amt2', wrapper.f_user_amt2);
            row.put('f_user_amt3', wrapper.f_user_amt3);
            row.put('f_user_amt4', wrapper.f_user_amt4);
            row.put('i_source_cat1_sort', wrapper.i_source_cat1_sort);
            row.put('i_source_cat2_sort', wrapper.i_source_cat2_sort);
            row.put('i_source_cat3_sort', wrapper.i_source_cat3_sort);
            row.put('i_source_cat4_sort', wrapper.i_source_cat4_sort);
            row.put('i_source_cat5_sort', wrapper.i_source_cat5_sort);
            row.put('i_source_cat6_sort', wrapper.i_source_cat6_sort);
            row.put('i_source_cat_sda_sort', wrapper.i_source_cat_sda_sort);
            row.put('i_user_score1', wrapper.i_user_score1);
            row.put('i_user_score2', wrapper.i_user_score2);
            row.put('i_user_score3', wrapper.i_user_score3);
            row.put('i_user_score4', wrapper.i_user_score4);
            rows.add(row);
        }
        return rows;
    }
}