/**
 * Created by ceezar on 31.07.2017.
 */

public with sharing class CustomerControlSegments extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public final String id {get; set;}

        public final String c_control_segment_desc {get; set;}
        public final String c_control_segment_lvl {get; set;}
        public final String c_customer_segment_desc {get; set;}
        public final String c_customer_segment_short_desc {get; set;}
        public final String c_incented_status {get; set;}
        public final String c_known_status {get; set;}
        public final String c_prop_cd {get; set;}
        public final String c_prop_cd_fk {get; set;}
        public final String c_quality_cd {get; set;}
        public final Datetime d_end_dt {get; set;}
        public final Datetime d_start_dt {get; set;}
        public final DateTime d_timestamp {get; set;}
        public final Integer i_control_segment {get; set;}
        public final Integer i_control_segment_max {get; set;}
        public final Integer i_control_segment_min {get; set;}
        public final Integer i_customer_segment {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (CustomerControlSegments.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('c_control_segment_desc', wrapper.c_control_segment_desc);
            row.put('c_control_segment_lvl', wrapper.c_control_segment_lvl);
            row.put('c_customer_segment_desc', wrapper.c_customer_segment_desc);
            row.put('c_customer_segment_short_desc', wrapper.c_customer_segment_short_desc);
            row.put('c_incented_status', wrapper.c_incented_status);
            row.put('c_known_status', wrapper.c_known_status);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_prop_cd_fk', wrapper.c_prop_cd_fk);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('d_end_dt', wrapper.d_end_dt);
            row.put('d_start_dt', wrapper.d_start_dt);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('i_control_segment', wrapper.i_control_segment);
            row.put('i_control_segment_max', wrapper.i_control_segment_max);
            row.put('i_control_segment_min', wrapper.i_control_segment_min);
            row.put('i_customer_segment', wrapper.i_customer_segment);
            rows.add(row);
        }
        return rows;
    }
}