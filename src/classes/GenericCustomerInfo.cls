/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object
**/
public with sharing class GenericCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
        row.put('ExternalId', wrapper.id);
        row.put('DisplayUrl', wrapper.id);
        row.put('RecordType', wrapper.recordType);
        row.put('winet_id', wrapper.i_dmid);
        row.put('property_code', wrapper.data.c_prop_cd);
        row.put('quality_code', wrapper.data.c_quality_cd);
        row.put('contact', wrapper.contact);
        return row;
    }

}