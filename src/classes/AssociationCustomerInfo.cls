/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Association)
**/
public with sharing class AssociationCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
        row.put('i_secondary_dmid', wrapper.data.i_secondary_dmid);
        row.put('c_assn_reason', MapHandler.getAssociationReasonMap().get(wrapper.data.c_assn_reason));
        row.put('c_req_prop_cd', wrapper.data.c_req_prop_cd);
        row.put('i_req_dmid', wrapper.data.i_req_dmid);
        row.put('c_req_employee', wrapper.data.c_req_employee);
        row.put('d_create_dt', wrapper.data.d_create_dt);
        return row;
    }

}