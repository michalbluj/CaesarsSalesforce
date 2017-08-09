/**
 * @author Cezary Zeleznicki
 * @date 31.07.2017.
 * @group Model
 * @description generic class responsible mappign AppLog json response
 */
public with sharing class AppLog extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public String id {get; set;}

        public final String level {get; set;}
        public final String meta {get; set;}
        public final String msg {get; set;}
        public final String reqkey {get; set;}
        public final String ttime {get; set;}
    }

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (AppLog.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('id', wrapper.id);
            row.put('level', wrapper.level);
            row.put('meta', wrapper.meta);
            row.put('msg', wrapper.msg);
            row.put('reqkey', wrapper.reqkey);
            row.put('time', wrapper.ttime);
            rows.add(row);
        }
        return rows;
    }
}