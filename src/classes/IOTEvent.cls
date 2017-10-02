public with sharing class IOTEvent extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
    	public String id {get;set;}
    	public final String d_created_date  {get; set;}
    	public final String event_payload  {get; set;}
    	public final String event_type  {get; set;}
    	public final String retention_policy {get; set;}
    	public final String ucp_guest_id {get; set;}
    }

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (IOTEvent.Record wrapper : this.body) {
        	Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('d_created_date', wrapper.d_created_date);
        	row.put('event_payload', wrapper.event_payload);
        	row.put('event_type', wrapper.event_type);
        	row.put('retention_policy', wrapper.retention_policy);
        	row.put('ucp_guest_id', wrapper.ucp_guest_id);
        	rows.add(row);
        }
        return rows;
    }
}