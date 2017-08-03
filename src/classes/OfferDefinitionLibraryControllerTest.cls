@IsTest
private class OfferDefinitionLibraryControllerTest{
     static testMethod void OfferDefinitionLibTest() {
     
         
         List <Account> accountList= TestFactory.properties;
         
         POD__c pocRec = new POD__c();
         pocRec.POD_Name__c = 'Atlantic City POD';
         insert pocRec;
         Market__c mar = new Market__c();
         mar.Name = 'testing';
         mar.Market_Code__c = 'ACM';
         mar.Active_Flag__c = true;
         mar.POD__c = pocRec.id; 
         insert mar;
         Campaign_Project__c campProject = new Campaign_Project__c();
         campProject.Market__c = mar.id;
         campProject.Valid_Start_Date__c = system.today();
         campProject.Valid_End_Date__c = system.today()+2;
         insert campProject;
         Offer_Definition__c OD = new Offer_Definition__c();
         OD.Campaign_Project__c = campProject.id;
         OD.Offer_Definition_Type__c = 'Package';
         OD.Offer_Employee_Description__c  ='test yu';
         OD.Description__c = 'test';
         OD.Offer_Guest_Label__c = 'test label1';
         OD.Offer_Id__c = '04578';
         OD.Offer_Intent__c = 'HOTEL';
         OD.Offer_Incentive_Count__c = 2;
         insert OD;
         Offer_Incentive_Group__c OIG = new Offer_Incentive_Group__c(Max_Choice__c = '2',Offer_Definition__c=OD.id,Offer_Incentive_Group_Label__c='Test Label2');
         insert OIG;
         Offer_Incentive__c OI = new Offer_Incentive__c();
         OI.Offer_Definition__c = OD.id;
         OI.Offer_Incentive_Group__c = OIG.id;
         OI.Offer_Incentive_Subcategory__c = 'CA';
         OI.Offer_Incentive_Category__c = 'GM';
         insert OI;
         
         
         Campaign_Project_Property__c CPP = new Campaign_Project_Property__c(Campaign_Project__c=campProject.id,Property__c=accountList[0].id);
         
        // Campaign_Project__c campProject = [select id from Campaign_Project__c where id='a140v0000004pPFAAY' limit 1];
         OfferDefinitionLibraryController offerDef = new OfferDefinitionLibraryController ();
         string strSearchParamter = '{"property":[""],"incentiveCategory":["GM"],"incentiveSubCategory":["CA"],"offerDescription":"test"}';
         List<OfferDefinitionLibraryDTO.OfferDefinition> offReslt = new List<OfferDefinitionLibraryDTO.OfferDefinition>();
         system.debug('resultValue');
         string resultValue = OfferDefinitionLibraryController.searchOffers(strSearchParamter);
         system.debug(resultValue +'--'+JSON.serialize(resultValue));
         offReslt = (List<OfferDefinitionLibraryDTO.OfferDefinition>) System.JSON.deserialize(resultValue, List<OfferDefinitionLibraryDTO.OfferDefinition>.class);
         system.debug('offReslt--->'+offReslt);
         string offerDefinitionId= offReslt[0].id;
         OfferDefinitionLibraryController.getOfferDetails(offerDefinitionId);
         
         string copyOfferDefinition= JSON.serialize(offReslt[0]);//'{"property":[""],"incentiveCategory":["LC"],"incentiveSubCategory":["BS"],"offerDescription":"test"}';
         OfferDefinitionLibraryController.copyOfferDefinition(campProject.id,copyOfferDefinition);
         
         string campaignProjectId= campProject.id;
         OfferDefinitionLibraryController.listSearchCriteria(campaignProjectId);
         
     }
}