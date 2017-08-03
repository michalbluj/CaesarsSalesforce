/**
 * Created by ceezar on 03.08.2017.
 */

public with sharing class HotelEvent extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public final String id {get; set;}

        public final String d_created_date {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (HotelEvent.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('d_created_date', wrapper.d_created_date);
            rows.add(row);
        }
        return rows;
    }
}