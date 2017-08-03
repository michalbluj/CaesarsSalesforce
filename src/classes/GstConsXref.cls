/**
 * Created by ceezar on 31.07.2017.
 */

public with sharing class GstConsXref extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public String id {get; set;}

        public final String c_quality_cd {get; set;}
        public final DateTime d_timestamp {get; set;}
        public final String i_dmid {get; set;}
        public final String i_xref_dmid {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (GstConsXref.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('i_dmid', wrapper.i_dmid);
            row.put('i_xref_dmid', wrapper.i_xref_dmid);
            rows.add(row);
        }
        return rows;
    }
}