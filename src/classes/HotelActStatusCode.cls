/**
 * Created by ceezar on 31.07.2017.
 */

public with sharing class HotelActStatusCode extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public final String id {get; set;}

        public final String c_activity_desc {get; set;}
        public final String c_activity_status {get; set;}
        public final String c_prop_cd {get; set;}
        public final String c_prop_cd_fk {get; set;}
        public final String c_quality_cd {get; set;}
        public final Datetime d_end_dt {get; set;}
        public final Datetime d_start_dt {get; set;}
        public final Datetime d_timestamp {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (HotelActStatusCode.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('c_activity_desc', wrapper.c_activity_desc);
            row.put('c_activity_status', wrapper.c_activity_status);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_prop_cd_fk', wrapper.c_prop_cd_fk);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('d_end_dt', wrapper.d_end_dt);
            row.put('d_start_dt', wrapper.d_start_dt);
            row.put('d_timestamp', wrapper.d_timestamp);
            rows.add(row);
        }
        return rows;
    }
}