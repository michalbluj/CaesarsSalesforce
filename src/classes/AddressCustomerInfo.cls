/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Address)
**/
public with sharing class AddressCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
        row.put('adi', wrapper.data.c_adi);
        row.put('city', wrapper.data.c_city);
        row.put('dpbc', wrapper.data.c_dpbc);
        row.put('date', wrapper.data.d_date);
        row.put('dmid', wrapper.data.i_dmid);
        row.put('zip_3', wrapper.data.c_zip_3);
        row.put('zip_7', wrapper.data.c_zip_7);
        row.put('county', wrapper.data.c_county);
        row.put('msa_cd', wrapper.data.c_msa_cd);
        row.put('pci_cd', wrapper.data.c_pci_cd);
        row.put('apt_num', wrapper.data.c_apt_num);
        row.put('area_cd', wrapper.data.c_area_cd);
        row.put('mail_cd', wrapper.data.c_mail_cd);
        row.put('am_pm_cd', wrapper.data.c_am_pm_cd);
        row.put('route_cd', wrapper.data.c_route_cd);
        row.put('state_cd', wrapper.data.c_state_cd);
        row.put('tele_num', wrapper.data.c_tele_num);
        row.put('addr_type', wrapper.data.c_addr_type);
        row.put('address_1', wrapper.data.c_address_1);
        row.put('address_2', wrapper.data.c_address_2);
        row.put('country_cd', wrapper.data.c_country_cd);
        row.put('quality_cd', wrapper.data.c_quality_cd);
        row.put('zip_plus_4', wrapper.data.c_zip_plus_4);
        row.put('acquisition_cd', MapHandler.getAcquisitionCodeMap().get(wrapper.data.c_acquisition_cd));
        row.put('country_tele_cd', wrapper.data.c_country_tele_cd);
        return row;
    }

}