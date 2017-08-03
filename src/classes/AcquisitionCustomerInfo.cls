/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Acquisition)
**/
public with sharing class AcquisitionCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
        row.put('prop_cd', wrapper.data.c_prop_cd);
        row.put('acq_date', wrapper.data.d_acq_date);
        row.put('quality_cd', wrapper.data.c_quality_cd);
        row.put('acquisition_cd', MapHandler.getAcquisitionCodeMap().get(wrapper.data.c_acquisition_cd));
        return row;
    }

}