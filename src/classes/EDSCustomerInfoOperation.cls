/**
 * Created by Michal Bluj on 2017-06-28.
 */

public with sharing class EDSCustomerInfoOperation implements ExternalDataSourceOperation{

    private static Map<String,CustomerInfoInterface> cInfoRecordsMap = new Map<String,CustomerInfoInterface>{
        'Acquisition'        => new AcquisitionCustomerInfo(),
        'ActivityFtd'        => new ActivityFtdCustomerInfo(),
        'Address'            => new AddressCustomerInfo(),
        'Alias'              => new AliasCustomerInfo(),
        'Association'        => new AssociationCustomerInfo(),
        'Casino'             => new CasinoCustomerInfo(),
        'Email'              => new EmailCustomerInfo(),
        'EthnicityAppend'    => new EthnicityAppendCustomerInfo(),
        'Event'              => new PrefCustomerInfo(),
        'Interest'           => new InterestCustomerInfo(),
        'NxtgenAddress'      => new NxtgenAddressCustomerInfo(),
        'NxtgenContactChan'  => new NxtgenContactChanCustomerInfo(),
        'NxtgenContactHist'  => new NxtgenContactHistCustomerInfo(),
        'NxtgenEmail'        => new NxtgenEmailCustomerInfo(),
        'NxtgenInterest'     => new NxtgenInterestCustomerInfo(),
        'NxtgenNickname'     => new NxtgenNicknameCustomerInfo(),
        'NxtgenNotePad'      => new NxtgenNotePadCustomerInfo(),
        'NxtgenPhone'        => new NxtgenPhoneCustomerInfo(),
        'NxtgenRelationship' => new NxtgenRelationshipCustomerInfo(),
        'NxtgenToDo'         => new NxtgenToDoCustomerInfo(),
        'Occupation'         => new OccupationCustomerInfo(),
        'PatronPref'         => new PatronPrefCustomerInfo(),
        'PatronPrefResp'     => new PatronPrefRespCustomerInfo(),
        'Personal'           => new PersonalCustomerInfo(),
        'PreGame5'           => new PreGame5CustomerInfo(),
        'PrefGlba'           => new PrefGlbaCustomerInfo(),
        'PrefHotel'          => new PrefHotelCustomerInfo(),
        'PrefHotelBrand'     => new PrefCustomerInfo(),
        'PrefInterests'      => new PrefCustomerInfo(),
        'PrefPartner'        => new PrefCustomerInfo(),
        'PrefProgram'        => new PrefCustomerInfo(),
        'PrefSpecialty'      => new PrefCustomerInfo(),
        'PrefSpecified'      => new PrefSpecifiedCustomerInfo(),
        'PrefTemp'           => new PrefCustomerInfo(),
        'PropMail'           => new PropMailCustomerInfo(),
        'Repcode'            => new RepcodeCustomerInfo(),
        'ScoreProp'          => new ScorePropCustomerInfo(),
        'TierScore'          => new TierScoreCustomerInfo(),
        'VedwAssociated'     => new VedwAssociatedCustomerInfo(),
        'VedwEthnicity'      => new VedwEthnicityCustomerInfo(),
        'VedwRelationship'   => new VedwRelationshipCustomerInfo()
    };

    public List<Map<String, Object>> query(DataSource.QueryContext context) {
        List<Map<String, Object>> rows = new List<Map<String, Object>>();
        HttpRequest req = CustomerInfoService.createHttpRequest(HKUEndpoint.getCustomerEndpoint(),context);
        HttpResponse res = CustomerInfoService.sendHttpRequest(req);
        CustomerInfoResponse response = CustomerInfoService.parseData(res.getBody());
        return populateResponseData(response);
    }

    public List<Map<String, Object>> populateResponseData(CustomerInfoResponse response){
        List<Map<String, Object>> rows = new List<Map<String, Object>>();
        for(CustomerInfo wrapper : response.body) {
            Map<String, Object> row = new Map<String, Object>();

            CustomerInfoInterface common = new GenericCustomerInfo();
            row = common.populateData(row,wrapper);

            CustomerInfoInterface cInfo = cInfoRecordsMap.get(wrapper.recordType);
            if(cInfo != null){
                row = cInfo.populateData(row, wrapper);
            }
            rows.add(row);
        }
        return rows;
    }

    public List<DataSource.TableResult> search(DataSource.SearchContext context) {
        List<DataSource.TableResult> results = new List<DataSource.TableResult>();

        HttpRequest req = CustomerInfoService.createHttpRequest(HKUEndpoint.getEndpoint(),context);
        HttpResponse res = CustomerInfoService.sendHttpRequest(req);
        String responseBody = res.getBody();
        CustomerInfoResponse response = CustomerInfoService.parseData(res.getBody());

        for(CustomerInfo wrapper : response.body){

        }

        return results;
    }
}