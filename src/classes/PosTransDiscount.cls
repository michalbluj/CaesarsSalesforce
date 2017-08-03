/**
 * Created by ceezar on 31.07.2017.
 */

public with sharing class PosTransDiscount extends ExternalObjectResponse implements ExternalObjectInterface {

    public List<Record> body {get; set;}

    public class Record {
        public final String id {get; set;}

        public final String c_file_prop_cd {get; set;}
        public final String c_pos_rev_center_cd {get; set;}
        public final String c_pos_trans_id {get; set;}
        public final String c_prop_cd {get; set;}
        public final String c_quality_cd {get; set;}
        public final String c_trans_discount_type_desc {get; set;}
        public final String c_trans_type_cd {get; set;}
        public final String d_pos_trans_dt {get; set;}
        public final String d_pos_trans_end_time {get; set;}
        public final String d_pos_trans_start_time {get; set;}
        public final String d_timestamp {get; set;}
        public final Decimal f_discount_amt {get; set;}
        public final Integer i_check_nbr {get; set;}
        public final Integer i_pos_trans_discount_seq_id {get; set;}
        public final String i_xref_dmid {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (PosTransDiscount.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('c_file_prop_cd', wrapper.c_file_prop_cd);
            row.put('c_pos_rev_center_cd', wrapper.c_pos_rev_center_cd);
            row.put('c_pos_trans_id', wrapper.c_pos_trans_id);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('c_trans_discount_type_desc', wrapper.c_trans_discount_type_desc);
            row.put('c_trans_type_cd', wrapper.c_trans_type_cd);
            row.put('d_pos_trans_dt', wrapper.d_pos_trans_dt);
            row.put('d_pos_trans_end_time', wrapper.d_pos_trans_end_time);
            row.put('d_pos_trans_start_time', wrapper.d_pos_trans_start_time);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('f_discount_amt', wrapper.f_discount_amt);
            row.put('i_check_nbr', wrapper.i_check_nbr);
            row.put('i_pos_trans_discount_seq_id', wrapper.i_pos_trans_discount_seq_id);
            row.put('i_xref_dmid', wrapper.i_xref_dmid);
            rows.add(row);
        }
        return rows;
    }
}