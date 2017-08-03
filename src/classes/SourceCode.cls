/**
 * Created by ceezar on 31.07.2017.
 */

public with sharing class SourceCode extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public final String id {get; set;}

        public final String c_prop_cd {get; set;}
        public final String c_prop_cd_fk {get; set;}
        public final String c_quality_cd {get; set;}
        public final String c_source_cd {get; set;}
        public final String c_source_cd_desc {get; set;}
        public final String c_source_group {get; set;}
        public final DateTime d_timestamp {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (SourceCode.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_prop_cd_fk', wrapper.c_prop_cd_fk);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('c_source_cd', wrapper.c_source_cd);
            row.put('c_source_cd_desc', wrapper.c_source_cd_desc);
            row.put('c_source_group', wrapper.c_source_group);
            row.put('d_timestamp', wrapper.d_timestamp);
            rows.add(row);
        }
        return rows;
    }
}