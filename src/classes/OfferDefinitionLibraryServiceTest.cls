/**
 *  @author Ivan Yeung
 *  @date 07/20/2017
 *  @group Test
 *  @description  Test class for OfferDefinitionLibraryService
 */

@IsTest
private class OfferDefinitionLibraryServiceTest{



    @IsTest
    public static void unitTest() {


        System.assert(TestFactory.campaignProjects.size() > 0);
        System.assert(TestFactory.campaignProjectProperties.size() > 0);
        System.assert(TestFactory.offerDefinitions.size()> 0);
        System.assert(TestFactory.offerIncentives.size() > 0);
        System.assert(TestFactory.offerIncentiveProperties.size() > 0);

        // search critiera
        OfferDefinitionLibraryDTO.SearchCriteria sc =  OfferDefinitionLibraryService.getSearchCriteria(TestFactory.campaignProjects[0].Id);
        System.assert(sc.properties.size() > 0 );

        // search itself
        OfferDefinitionLibraryDTO.SearchParamters searchParameters = new OfferDefinitionLibraryDTO.SearchParamters();
        List <String> key = new List <String>();
        key.addAll(sc.properties.keySet());
        searchParameters.property = new list<String> {key[0] };
        searchParameters.incentiveCategory = new list<String> {'TV','MC','LC','GM','FB','EP','CM','AM'};
        searchParameters.incentiveSubCategory = new list<String> { 'HT','CR','BS','AR','RS','GF','GC','TC','RC','EC','RG','RW','PC','MP','DC','DB','CA','FD','DR','TE','SH','SE','PD','IW','CM','VL','SP','PK','NC','LI','GO','EA' };
        searchParameters.offerDescription = TestFactory.offerIncentives[0].Offer_Incentive_Label__c;
        List<OfferDefinitionLibraryDTO.OfferDefinition>  listOffers = OfferDefinitionLibraryService.searchOffers(searchParameters);
        System.assert(listOffers.size() > 0);

        // get offer details
        OfferDefinitionLibraryDTO.OfferDefinition offerDefinition = OfferDefinitionLibraryService.getOfferDetails( listOffers[0].id );
        System.assert(offerDefinition.id != null);

        // copy offer
        OfferDefinitionLibraryService.copyOfferDefinition( TestFactory.campaignProjects[0].Id, offerDefinition);


    }

}