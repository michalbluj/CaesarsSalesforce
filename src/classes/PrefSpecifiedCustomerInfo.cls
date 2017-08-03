/**
 * Created by Michal Bluj on 2017-07-12.
 */

public with sharing class PrefSpecifiedCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row, CustomerInfo wrapper) {
        row.put('c_channel_pref',wrapper.data.c_channel_pref);
        return row;
    }
}