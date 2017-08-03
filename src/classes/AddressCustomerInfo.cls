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
        row.put('address_type', wrapper.data.c_addr_type);
        row.put('address', wrapper.data.c_address_1);
        row.put('address_2', wrapper.data.c_address_2);
        row.put('state_code', wrapper.data.c_state_cd);
        row.put('country_code', wrapper.data.c_country_cd);
        row.put('apartment_number', wrapper.data.c_apt_num);
        row.put('zip', wrapper.data.c_zip_7);
        row.put('city', wrapper.data.c_city);
        row.put('zip_3', wrapper.data.c_zip_3);
        row.put('zip_plus_4', wrapper.data.c_zip_plus_4);
        row.put('county', wrapper.data.c_county);
        row.put('msa_code', wrapper.data.c_msa_cd);
        row.put('mail_code', wrapper.data.c_mail_cd);
        row.put('tele_num', wrapper.data.c_tele_num);
        row.put('country_tele_code', wrapper.data.c_country_tele_cd);
        row.put('acquisition_code', MapHandler.getAcquisitionCodeMap().get(wrapper.data.c_acquisition_cd));
        row.put('am_pm_cd', wrapper.data.c_am_pm_cd);
        row.put('area_cd', wrapper.data.c_area_cd);
        row.put('pci_cd', wrapper.data.c_pci_cd);
        row.put('date', wrapper.data.d_date);
        row.put('dpbc', wrapper.data.c_dpbc);
        row.put('adi', wrapper.data.c_adi);
        return row;
    }

}