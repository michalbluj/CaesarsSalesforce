/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Alias)
**/
public with sharing class AliasCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
        row.put('first_name', wrapper.data.c_first_name);
        row.put('last_name', wrapper.data.c_last_name);
        return row;
    }

}