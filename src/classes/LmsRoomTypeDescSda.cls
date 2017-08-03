/**
 * Created by ceezar on 31.07.2017.
 */

public with sharing class LmsRoomTypeDescSda extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public final String id {get; set;}

        public final String c_prop_cd {get; set;}
        public final String c_prop_cd_fk {get; set;}
        public final String c_rm_type {get; set;}
        public final String c_room_accessible {get; set;}
        public final String c_room_bed_type {get; set;}
        public final String c_room_desc1 {get; set;}
        public final String c_room_desc2 {get; set;}
        public final String c_room_desc3 {get; set;}
        public final String c_room_desc4 {get; set;}
        public final String c_room_quality {get; set;}
        public final String c_room_smoking {get; set;}
        public final String c_user_flag1 {get; set;}
        public final String c_user_flag2 {get; set;}
        public final String c_user_flag3 {get; set;}
        public final String c_user_flag4 {get; set;}
        public final String c_user_flag5 {get; set;}
        public final String c_user_flag6 {get; set;}
        public final String c_user_flag7 {get; set;}
        public final String c_user_flag8 {get; set;}
        public final Date d_last_update_date {get; set;}
        public final Decimal f_user_amt1 {get; set;}
        public final Decimal f_user_amt2 {get; set;}
        public final Decimal f_user_amt3 {get; set;}
        public final Decimal f_user_amt4 {get; set;}
        public final Integer i_rm_sort_1 {get; set;}
        public final Integer i_rm_sort_2 {get; set;}
        public final Integer i_rm_sort_3 {get; set;}
        public final Integer i_rm_sort_4 {get; set;}
        public final Integer i_room_bet_type_sort {get; set;}
        public final Integer i_room_quality_sort {get; set;}
        public final Integer i_user_score1 {get; set;}
        public final Integer i_user_score2 {get; set;}
        public final Integer i_user_score3 {get; set;}
        public final Integer i_user_score4 {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (LmsRoomTypeDescSda.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_prop_cd_fk', wrapper.c_prop_cd_fk);
            row.put('c_rm_type', wrapper.c_rm_type);
            row.put('c_room_accessible', wrapper.c_room_accessible);
            row.put('c_room_bed_type', wrapper.c_room_bed_type);
            row.put('c_room_desc1', wrapper.c_room_desc1);
            row.put('c_room_desc2', wrapper.c_room_desc2);
            row.put('c_room_desc3', wrapper.c_room_desc3);
            row.put('c_room_desc4', wrapper.c_room_desc4);
            row.put('c_room_quality', wrapper.c_room_quality);
            row.put('c_room_smoking', wrapper.c_room_smoking);
            row.put('c_user_flag1', wrapper.c_user_flag1);
            row.put('c_user_flag2', wrapper.c_user_flag2);
            row.put('c_user_flag3', wrapper.c_user_flag3);
            row.put('c_user_flag4', wrapper.c_user_flag4);
            row.put('c_user_flag5', wrapper.c_user_flag5);
            row.put('c_user_flag6', wrapper.c_user_flag6);
            row.put('c_user_flag7', wrapper.c_user_flag7);
            row.put('c_user_flag8', wrapper.c_user_flag8);
            row.put('d_last_update_date', wrapper.d_last_update_date);
            row.put('f_user_amt1', wrapper.f_user_amt1);
            row.put('f_user_amt2', wrapper.f_user_amt2);
            row.put('f_user_amt3', wrapper.f_user_amt3);
            row.put('f_user_amt4', wrapper.f_user_amt4);
            row.put('i_rm_sort_1', wrapper.i_rm_sort_1);
            row.put('i_rm_sort_2', wrapper.i_rm_sort_2);
            row.put('i_rm_sort_3', wrapper.i_rm_sort_3);
            row.put('i_rm_sort_4', wrapper.i_rm_sort_4);
            row.put('i_room_bet_type_sort', wrapper.i_room_bet_type_sort);
            row.put('i_room_quality_sort', wrapper.i_room_quality_sort);
            row.put('i_user_score1', wrapper.i_user_score1);
            row.put('i_user_score2', wrapper.i_user_score2);
            row.put('i_user_score3', wrapper.i_user_score3);
            row.put('i_user_score4', wrapper.i_user_score4);
            rows.add(row);
        }
        return rows;
    }
}