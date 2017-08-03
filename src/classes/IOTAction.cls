/**
 * Created by Michal Bluj on 2017-07-24.
 */

public with sharing class IOTAction extends ExternalObjectResponse implements ExternalObjectInterface {

    public List<Record> body {get;set;}

    public class Record {
        public String id {get;set;}
        public final String contact {get;set;}
        public final String c_delivery_mechanism {get;set;}
        public final String c_offer_id {get;set;}
        public final String c_ucp_guest_id {get;set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows){
        for(IOTAction.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId',wrapper.id);
            row.put('DisplayUrl',wrapper.id);
            row.put('contact',wrapper.contact);
            row.put('c_delivery_mechanism',wrapper.c_delivery_mechanism);
            row.put('c_offer_id',wrapper.c_offer_id);
            row.put('c_ucp_guest_id',wrapper.c_ucp_guest_id);
            rows.add(row);
        }
        return rows;
    }

}