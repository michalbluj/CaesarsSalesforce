/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Interest)
**/
public with sharing class InterestCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row, CustomerInfo wrapper) {
        row.put('c_interest_cd', wrapper.data.c_interest_cd);
        return row;
    }
}