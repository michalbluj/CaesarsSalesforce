/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Offer Redeemed external object
**/
public with sharing class OfferRedeemed extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get;set;}

    public class Record {
        public String contact {get;set;}
        public String id {get;set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows){
        for(OfferRedeemed.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId',wrapper.id);
            row.put('DisplayUrl',wrapper.id);
            row.put('contact',wrapper.contact);
            rows.add(row);
        }
        return rows;
    }

}