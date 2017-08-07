/**
 * @author Cezary Zeleznicki
 * @date 03.08.2017.
 * @group Model
 * @description generic class responsible mappign HotelEvent json response
 */

public with sharing class HotelEvent extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public String id {get; set;}

        public final String d_created_date {get; set;}
    }

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
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