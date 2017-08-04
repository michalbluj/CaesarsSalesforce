/* @author Patryk Lompart
* @date 2017
* @group UnitTest
* @description Unit test class for AddressCustomerInfo class
**/
@IsTest
private class AddressCustomerInfoTest {

    static testMethod void populateDataTest() {
        AddressCustomerInfo info = new AddressCustomerInfo();

        CustomerInfo.CustomerInfoData dataRecord = new CustomerInfo.CustomerInfoData();
        dataRecord.c_adi                = '';
        dataRecord.c_city               = 'BORDENTOWN';
        dataRecord.c_dpbc               = '64';
        dataRecord.d_date               = '2017-04-28';
        dataRecord.i_dmid               = '40103662491';
        dataRecord.c_zip_3              = '85';
        dataRecord.c_zip_7              = '';
        dataRecord.c_county             = null;
        dataRecord.c_msa_cd             = '';
        dataRecord.c_pci_cd             = '5';
        dataRecord.c_apt_num            = '';
        dataRecord.c_area_cd            = '609';
        dataRecord.c_mail_cd            = 'G';
        dataRecord.c_am_pm_cd           = '';
        dataRecord.c_route_cd           = 'C010';
        dataRecord.c_state_cd           = 'NJ';
        dataRecord.c_tele_num           = null;
        dataRecord.c_addr_type          = 'H';
        dataRecord.c_address_1          = '123 MAIN STREET';
        dataRecord.c_address_2          = null;
        dataRecord.c_country_cd         = '';
        dataRecord.c_quality_cd         = '';
        dataRecord.c_zip_plus_4         = '3180';
        //dataRecord.c_acquisition_cd     = 'HTL';
        dataRecord.c_country_tele_cd    = '';

        CustomerInfo wrapper = new CustomerInfo();
        wrapper.data = dataRecord;

        Test.startTest();
        Map<String,Object> row = info.populateData(new Map<String, Object>(),wrapper);
        Test.stopTest();

        System.assertEquals((String)row.get('adi'),'');
        System.assertEquals((String)row.get('city'),'BORDENTOWN');
        System.assertEquals((String)row.get('dpbc'),'64');
        System.assertEquals((String)row.get('date'),'2017-04-28');
        System.assertEquals((String)row.get('dmid'),'40103662491');
        System.assertEquals((String)row.get('zip_3'),'85');
        System.assertEquals((String)row.get('zip_7'),'');
        System.assertEquals((String)row.get('county'),null);
        System.assertEquals((String)row.get('msa_cd'),'');
        System.assertEquals((String)row.get('pci_cd'),'5');
        System.assertEquals((String)row.get('apt_num'),'');
        System.assertEquals((String)row.get('area_cd'),'609');
        System.assertEquals((String)row.get('mail_cd'),'G');
        System.assertEquals((String)row.get('am_pm_cd'),'');
        System.assertEquals((String)row.get('route_cd'),'C010');
        System.assertEquals((String)row.get('state_cd'),'NJ');
        System.assertEquals((String)row.get('tele_num'),null);
        System.assertEquals((String)row.get('addr_type'),'H');
        System.assertEquals((String)row.get('address_1'),'123 MAIN STREET');
        System.assertEquals((String)row.get('address_2'),null);
        System.assertEquals((String)row.get('country_cd'),'');
        System.assertEquals((String)row.get('quality_cd'),'');
        System.assertEquals((String)row.get('zip_plus_4'),'3180');
        //System.assertEquals((String)row.get('acquisition_cd'),'HTL');
        System.assertEquals((String)row.get('country_tele_cd'),'');
    }
}