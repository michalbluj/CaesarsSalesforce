/**
 *  @author Michal Bluj, Ivan Yeung
 *  @date 2017-06-28
 *  @group Test
 *  @description  Factory class for unit test data generation.
 *                Note all test data should be created using singleton, lazy loading pattern
 */

public with sharing class TestFactory {


    /*******************************************************************************************************
    * @description generate AcquisitionCodes
    * @param   n/a
    * @return List<Acquisition_Code__c> ; AcquisitionCodes[0] = Acquisition Code One, AcquisitionCodes[1] = Acquisition Code Two
    */
    private static List<Acquisition_Code__c> pAcquisitionCodes = null;
    public static List<Acquisition_Code__c>  AcquisitionCodes {
        get {
            if (pAcquisitionCodes == null) {
                    pAcquisitionCodes = new List<Acquisition_Code__c>{
                        new Acquisition_Code__c (name = 'Acquisition Code One'),
                        new Acquisition_Code__c (name = 'Acquisition Code Two')
                    };
            DML.save(pAcquisitionCodes);
            }
            return pAcquisitionCodes;
        }
    }

    /*******************************************************************************************************
    * @description generate AssociationReasons
    * @param   n/a
    * @return List<Association_Reason__c> ; AssociationReasons[0] = Association Reason One, AssociationReasons[1] = Association Reason Two
    */
    public static List<Association_Reason__c> pAssociationReasons = null;
    public static List<Association_Reason__c> AssociationReasons{
        get {
            if (pAssociationReasons == null) {
                pAssociationReasons = new List<Association_Reason__c>{
                        new Association_Reason__c(name = 'Association Reason One'),
                        new Association_Reason__c(name = 'Association Reason Two')
                };
                DML.save(pAssociationReasons);
            }
            return pAssociationReasons;
        }
    }



   /*******************************************************************************************************
    * @description generate PODs
    * @param   n/a
    * @return List<POD__c> ; PODs[0] = Atlantic City POD, PODs[1] = Las Vegas POD,  PODs[2] = Enterprise POD
    */
    private static List<POD__c> pPODs = null;
    public static List<POD__c> pODs{

        get {
            if (pPODs == null) {
                pPODs = new List<POD__c>();
                POD__c pod = new POD__c();
                pod.Description__c = 'Atlantic City POD';
                pod.POD_Name__c = 'Atlantic City POD';
                pPODs.add(pod);

                pod = new POD__c();
                pod.Description__c = 'Las Vegas POD';
                pod.POD_Name__c = 'Las Vegas POD';
                pPODs.add(pod);

                pod = new POD__c();
                pod.Description__c = 'Enterprise POD';
                pod.POD_Name__c = 'Enterprise POD';
                pPODs.add(pod);

                DML.save(pPODs);
                system.debug('#### POD List ' + pPODs);
            }
            return pPODs;
        }

    }

     /*******************************************************************************************************
    * @description generate Direct Marketing Center (DMC)
    * @param   n/a
    * @return List<Direct_Marketing_Center__c> ; DMCs[0] = Atlantic City, DMCs[1] = Nevada,  PODs[2] = Enterprise
    */
    private static List<Direct_Marketing_Center__c> pDMCs = null;
    public static List<Direct_Marketing_Center__c> dMCs{

        get {
            if (pDMCs == null) {
                pDMCs = new List<Direct_Marketing_Center__c>();
                Direct_Marketing_Center__c dmc = new Direct_Marketing_Center__c();
                dmc.DMC_Name__c = 'Atlantic City';
                pDMCs.add(dmc);

                dmc = new Direct_Marketing_Center__c();
                dmc.DMC_Name__c = 'Nevada';
                pDMCs.add(dmc);

                dmc = new Direct_Marketing_Center__c();
                dmc.DMC_Name__c = 'Enterprise';
                pDMCs.add(dmc);

                DML.save(pDMCs);
                system.debug('#### DMC List ' + pDMCs);
            }
            return pDMCs;
        }

    }

       /*******************************************************************************************************
    * @description generate Market
    * @param   n/a
    * @return List<Market__c>; Markets[0] = Atlantic City, Markets[1] = Las Vegas, Markets[2] = Enterprise
    */
    private static List<Market__c> pMarkets = null;
    public static List<Market__c> markets{

        get {
            if (pMarkets == null) {
                pMarkets = new List<Market__c>();
                Market__c market = new Market__c();
                market.Active_Flag__c = true;
                market.Description__c = 'Atlantic City';
                market.Market_Code__c = 'ACM';
                market.Name = 'ACM';
                market.POD__c = PODs[0].Id;
                market.Direct_Marketing_Center__c = DMCs[0].Id;
                pMarkets.add(market);


                market = new Market__c();
                market.Active_Flag__c = true;
                market.Description__c = 'Las Vegas';
                market.Market_Code__c = 'LVM';
                market.Name = 'LVM';
                market.POD__c = PODs[1].Id;
                market.Direct_Marketing_Center__c = DMCs[1].Id;
                pMarkets.add(market);


                market = new Market__c();
                market.Active_Flag__c = true;
                market.Description__c = 'Enterprise';
                market.Market_Code__c = 'ENT';
                market.Name = 'ENT';
                market.POD__c = PODs[2].Id;
                market.Direct_Marketing_Center__c = DMCs[2].Id;
                pMarkets.add(market);


                DML.save(pMarkets);
                system.debug('#### POD List ' + pMarkets);
            }
            return pMarkets;
        }

    }

    /*******************************************************************************************************
    * @description generate prooperties
    * @param   n/a
    * @return List<Market__c>; Properties[0] =Harrah\'s Resort Atlantic City, Properties[1] = CLV-Caesars Palace'
    */
    private static List<Account> pProperties = null;
    public static List<Account> properties {

        get {
            if (pProperties == null){

                pProperties = new List<Account>();
                Account property = new Account();
                property.recordTypeId = RecordTypeModel.Account_PropertyId;
                property.Description  = 'Harrah\'s Resort Atlantic City';
                property.Name = 'ATL-Harrah\'s Resort Atlantic City';
                property.property_brand__c = 'Harrah\'s';
                property.Property_Code__c = 'ATL';
                property.Market__c = Markets[0].Id;
                property.Property_Active__c = true;
                pProperties.add(property);

                property = new Account();
                property.recordTypeId = RecordTypeModel.Account_PropertyId;
                property.Description  = 'Caesar\'s Palace';
                property.Name = 'CLV-Caesars Palace';
                property.property_brand__c = 'Caesars';
                property.Property_Code__c = 'CLV';
                property.Market__c = Markets[1].Id;
                property.Property_Active__c = true;
                pProperties.add(property);

                DML.save(pProperties);
                system.debug('#### Property List ' + pProperties);

            }

            return pProperties;
        }

    }

    /*******************************************************************************************************
    * @description generate campaign project
    * @param   n/a
    * @return List<Campaign_project__c>;
    */
    private static List<Campaign_Project__c> pCampaignProjects = null;
    public static List<Campaign_Project__c> campaignProjects {

        get {
            if (pCampaignProjects == null) {
                /*list<case> CampaignWorkflowTemplateCases =  UniqueCases;
                system.debug('*****CampaignWorkflowTemplateCases ' + CampaignWorkflowTemplateCases);
                list<Workflow_Template__c> workflowTemplateRecs = WorkflowTemplates;
                list<Workflow_Template_Case__c> workflowTemplateCase= new  list<Workflow_Template_Case__c>();
                for(case c:CampaignWorkflowTemplateCases)
                {
                    if(!(workflowTemplateRecs.isEmpty())){
                        if(workflowTemplateRecs.size()>1)
                        {
                            workflowTemplateCase.add(new Workflow_Template_Case__c(Case__c=c.id,Workflow_Template__c=workflowTemplateRecs[0].id));
                            workflowTemplateCase.add(new Workflow_Template_Case__c(Case__c=c.id,Workflow_Template__c=workflowTemplateRecs[1].id));
                        }else{
                             workflowTemplateCase.add(new Workflow_Template_Case__c(Case__c=c.id,Workflow_Template__c=workflowTemplateRecs[0].id));
                        }
                    }else{                    
                        break;
                    }
                    
                }*/
                //DML.save(workflowTemplateCase);
                TestFactory.addworkflowTemplateCases();
                pCampaignProjects = new List<Campaign_Project__c>();
                Campaign_Project__c campaignProject = new Campaign_Project__c();
                campaignProject.Market__c = Markets[0].Id;
                CampaignProject.Valid_Start_Date__c = Date.valueOf('2017-07-01');
                CampaignProject.Valid_End_Date__c = Date.valueOf('2017-09-30');
                CampaignProject.recordTypeId = RecordTypeModel.CampaignProject_DraftId;
                CampaignProject.Status__c = 'Draft';
                
                CampaignProject.Email_Drop_Date__c = date.today();
                CampaignProject.Valid_Start_Date__c =date.today()+3;
                CampaignProject.Valid_End_Date__c =date.today()+4;
                CampaignProject.Direct_Mail_Drop_Date__c =date.today()+4;
                CampaignProject.Campaign_Project_Type__c = 'Standard';
                CampaignProject.Delivery_Channel__c = 'Direct Mail;Email;Digital RSVP;Advertise in Core;Play by TR app - Push Notification;Social;Telemarketing';
                pCampaignProjects.add(CampaignProject); // Added this by VNP on 7/10 as we are trying to insert in the below line
                
                campaignProject = new Campaign_Project__c();
                campaignProject.Market__c = Markets[0].Id;
                CampaignProject.Valid_Start_Date__c = Date.valueOf('2017-07-01');
                CampaignProject.Valid_End_Date__c = Date.valueOf('2017-09-30');
                CampaignProject.recordTypeId = RecordTypeModel.CampaignProject_DraftId;
                CampaignProject.Status__c = 'Draft';
                CampaignProject.Email_Drop_Date__c = date.today();
                CampaignProject.Valid_Start_Date__c =date.today()+3;
                CampaignProject.Valid_End_Date__c =date.today()+4;
                CampaignProject.Direct_Mail_Drop_Date__c =date.today()+4;
                
                CampaignProject.Campaign_Project_Type__c = 'Standard';
                CampaignProject.Delivery_Channel__c = 'Direct Mail;Email;Digital RSVP;Advertise in Core;Play by TR app - Push Notification;Social;Telemarketing';
                pCampaignProjects.add(CampaignProject); // Added this by VNP on 7/10 as we are trying to insert in the below line
                
                
                DML.save(pCampaignProjects);

            }

            return pCampaignProjects;
        }
    }



    private static List<Workflow_Template__c> pWorkflowTemplates = null;
    public static List<Workflow_Template__c> workflowTemplates{

        get{
            if(pWorkflowTemplates == null){
                pWorkflowTemplates =  new List<Workflow_Template__c>{ new Workflow_Template__c(Name='Standard (New)',Active__c=true)};
                DML.save(pWorkflowTemplates ); // insert workflow templates
            }
            return pWorkflowTemplates;
        }    
        
    }
    
 /*******************************************************************************************************
    * @description offer incentive properties
    * @param   n/a
    * @return void
    */
    public static List<Offer_Incentive_Property__c> pOfferIncentiveProperties;
    public static List<Offer_Incentive_Property__c> offerIncentiveProperties {
        get {
            if (pOfferIncentiveProperties == null) {
                pOfferIncentiveProperties = new List<Offer_Incentive_Property__c>();
                For (Offer_Incentive__c cp: offerIncentives){
                    pOfferIncentiveProperties.addAll(addOfferIncentiveProperties(cp));
                }
            }
            return pOfferIncentiveProperties;
        }
    }

    /*******************************************************************************************************
    * @description generate two offer definition for a campaign project
    * @param   n/a
    * @return void
    */
    public static List <Offer_Incentive_Property__c> addOfferIncentiveProperties(Offer_Incentive__c offer) {

        List <Offer_Incentive_Property__c> incentiveProperties = new List<Offer_Incentive_Property__c>();

        for (Account property: properties) {
            Offer_Incentive_Property__c p = new Offer_Incentive_Property__c();
            p.Offer_Incentive__c = offer.Id;
            p.Property__c = property.Id;
            incentiveProperties.add(p);
        }

        DML.save(incentiveProperties);

        return incentiveProperties;

    }



    /*******************************************************************************************************
    * @description campaign project properties
    * @param   n/a
    * @return void
    */
    public static List<Campaign_Project_Property__c> pCampaignProjectProperties;
    public static List<Campaign_Project_Property__c> campaignProjectProperties {
        get {
            if (pCampaignProjectProperties == null) {
                pCampaignProjectProperties = new List<Campaign_Project_Property__c>();
                For (Campaign_Project__c cp: campaignProjects){
                    pCampaignProjectProperties.addAll(addCampaignProjectProperties(cp));
                }
            }
            return pCampaignProjectProperties;
        }
    }

    /*******************************************************************************************************
    * @description generate two offer definition for a campaign project
    * @param   n/a
    * @return void
    */
    public static List <Campaign_Project_Property__c> addCampaignProjectProperties(Campaign_Project__c cp) {

        List <Campaign_Project_Property__c> pCampaignProjectProperties = new List<Campaign_Project_Property__c>();

        for (Account property: properties) {
            Campaign_Project_Property__c p = new Campaign_Project_Property__c();
            p.Campaign_Project__c = cp.Id;
            p.Property__c = property.Id;
            pCampaignProjectProperties.add(p);
        }

        DML.save(pCampaignProjectProperties);

        return pCampaignProjectProperties;

    }



    /*******************************************************************************************************
    * @description generate two offer definition for a campaign project
    * @param   n/a
    * @return void
    */
    public static List <Offer_Definition__c> addOfferDefinitions(Campaign_Project__c cp){

        List <Offer_Definition__c> pOffer_definitions = new List<Offer_Definition__c>();
        Offer_Definition__c offer = new Offer_Definition__c();
        offer.Campaign_Project__c = cp.Id;
        offer.Description__c = 'Test Offer 1';
        offer.Offer_Definition_Type__c = 'Package';
        offer.Offer_Guest_Label__c = 'Test Offer 1';
        offer.Offer_Employee_Description__c = 'Test Offer 1';
        offer.recordTypeId = RecordTypeModel.OfferDefinition_PackageId;
        pOffer_definitions.add(offer); 

        offer = new Offer_Definition__c();
        offer.Campaign_Project__c = cp.Id;
        offer.Description__c = 'Test Offer 2';
        offer.Offer_Definition_Type__c = 'Choice';
        offer.Offer_Guest_Label__c = 'Test Offer 2';
        offer.Offer_Employee_Description__c = 'Test Offer 2';
        offer.recordTypeId = RecordTypeModel.OfferDefinition_ChoiceId;
        pOffer_definitions.add(offer);// Added this by VNP on 7/10 as we are trying to insert in the below line

        DML.save(pOffer_definitions);

        return pOffer_definitions;


    }

    /*******************************************************************************************************
    * @description generate offer definition
    * @param   n/a
    * @return List<Campaign_project__c>;
    */
    private static List<Offer_Definition__c> pOfferdefinitions = null;
    public static List<Offer_Definition__c> offerDefinitions {
        get {
            if (pOfferdefinitions == null) {
                pOfferdefinitions = new List<Offer_Definition__c>();
                For (Campaign_Project__c cp: campaignProjects){
                    pOfferdefinitions.addAll(addOfferDefinitions(cp));
                }
            }
            return pOfferdefinitions;
        }
    }


    /*******************************************************************************************************
    * @description generate two offer incentive for a offer definition
    * @param   n/a
    * @return void
    */
    public static List <Offer_Incentive__c> addOfferIncentives(Offer_Definition__c offer){
        List <Offer_Incentive__c> pOffer_incentives = new List <Offer_Incentive__c>();
        Offer_Incentive__c oi = new Offer_Incentive__c();
        oi.Amount__c = 1;
        oi.Offer_Incentive_Category__c = 'FB';
        oi.Offer_Incentive_Subcategory__c = 'DR';
        oi.Offer_Definition__c = offer.Id;
        oi.Max_Redemption__c = '1';
        oi.Offer_Incentive_Label__c = 'Two free drink or One buffet';
        oi.Guest_Description__c = 'Two free drink or One buffet';
        oi.Employee_Description__c = 'Two free drink or One buffet';
        pOffer_incentives.add(oi);

        oi = new Offer_Incentive__c();
        oi.Amount__c = 1;
        oi.Offer_Incentive_Category__c = 'GM';
        oi.Offer_Incentive_Subcategory__c = 'CA';
        oi.Offer_Definition__c = offer.Id;
        oi.Max_Redemption__c = '2';
        oi.Offer_Incentive_Label__c = 'Two Free slot play';
        oi.Guest_Description__c = 'Two Free slot play';
        oi.Employee_Description__c = 'Two Free slot play';
        pOffer_incentives.add(oi);

        DML.save(pOffer_incentives);

        return pOffer_incentives;
    }
    
    /*******************************************************************************************************
    * @description generate proformas
    * @param   n/a
    * @return List<Proforma__c>;
    */
    private static List<Proforma__c> ProformaLst = null;
    public static List<Proforma__c> getCampaignProjectProformaLst {
        get {
              if (ProformaLst == null) {
                  Proforma__c pf = new Proforma__c();
                  id pfID = pf.recordtypeid= Schema.SObjectType.Proforma__c.getRecordTypeInfosByName().get('Campaign Project Proforma').getRecordTypeId();
                  pf.Status__c = 'Draft';
                  ProformaLst.add(pf);
                  
                  pf = new Proforma__c();
                  pf.recordtypeid = pfID; 
                  pf.Status__c = 'Submitted For approval'; // associate this to second case 
                  ProformaLst.add(pf);
                  
                  
              }
              
              return ProformaLst;
        }
    }




    /*******************************************************************************************************
    * @description generate offer incentives
    * @param   n/a
    * @return List<Offer_Incentive__c>;
    */
    private static List<Offer_Incentive__c> pOfferIncentives = null;
    public static List<Offer_Incentive__c> offerIncentives {
        get {
            if (pOfferIncentives == null) {
                pOfferIncentives = new List<Offer_Incentive__c>();
                For (Offer_Definition__c offer: offerDefinitions){
                    pOfferIncentives.addAll(addOfferIncentives(offer));
                }
            }
            return pOfferIncentives;
        }
    }

    
    /*******************************************************************************************************
    * @description generate Campaign Workflow Template cases 
    * @param   n/a
    * @return List<case>;
    */
    private static List<case> pUniqueCases = null;
    private static id caseCampaignWorkflowTypeRecordTypeID = [select id from recordtype where name = 'Campaign Workflow Template'].id;
    public static List<case> uniqueCases {

        get {
            if (uniqueCases == null) {

                uniqueCases = new List<case>();
                case  planningTaskCase = new case();
                planningTaskCase.Case_Sub_Group__c = 'Project Kick Off';
                planningTaskCase.Planning_Task__c = True;
                planningTaskCase.Anchored__c = false;
                planningTaskCase.Legacy_Task_Code__c = 'MPE7';
                planningTaskCase.Scheduled_Through__c = 'Bus.';
                planningTaskCase.Target_Duration_Days__c = 1;
                planningTaskCase.Target_Duration_Hours__c = 2;
                planningTaskCase.Status = 'Ready to Start';
                planningTaskCase.Description = planningTaskCase.Subject = '1.02 Build T1 Creative';
                planningTaskCase.Target_Duration_Minutes__c = 10;
                planningTaskCase.Approval_Case__c = true;
                planningTaskCase.Anchored__c=true;
                planningTaskCase.subject = 'Prepare & Deploy Email';
                planningTaskCase.Project_Type__c = 'Campaign Project';
                if(caseCampaignWorkflowTypeRecordTypeID!=null)planningTaskCase.recordtypeID = caseCampaignWorkflowTypeRecordTypeID;
                uniqueCases.add(planningTaskCase);
                
                planningTaskCase = new case();
                planningTaskCase.Case_Sub_Group__c = 'Studio Tier 1 Content Development and Review';
                planningTaskCase.Planning_Task__c = false;
                planningTaskCase.Anchored__c = true;
                planningTaskCase.Dependencies__c = 'Studio9' ;
                planningTaskCase.Legacy_Task_Code__c = 'Studio12';
                planningTaskCase.Scheduled_Through__c = 'Bus.';
                planningTaskCase.Target_Duration_Days__c = 10;
                planningTaskCase.Target_Duration_Hours__c = 2;
                planningTaskCase.Status = 'Not Started';
                planningTaskCase.Description = planningTaskCase.Subject = 'Execute Event';
                planningTaskCase.Target_Duration_Minutes__c = 20;
                if(caseCampaignWorkflowTypeRecordTypeID!=null)planningTaskCase.recordtypeID = caseCampaignWorkflowTypeRecordTypeID;
                uniqueCases.add(planningTaskCase);
                
                
                planningTaskCase = new case();
                planningTaskCase.Case_Sub_Group__c = 'Project Kick Off';
                planningTaskCase.subject = 'Approve Pro Forma';
                planningTaskCase.Planning_Task__c = false;
                planningTaskCase.Anchored__c = false;
                planningTaskCase.Dependencies__c = 'Studio9' ;
                planningTaskCase.Legacy_Task_Code__c = 'Studio12';
                planningTaskCase.Scheduled_Through__c = 'Bus.';
                planningTaskCase.Target_Duration_Days__c = 10;
                planningTaskCase.Target_Duration_Hours__c = 2;
                planningTaskCase.Status = 'Not Started';
                planningTaskCase.Description = planningTaskCase.Subject = 'Drop Mail';
                planningTaskCase.Target_Duration_Minutes__c = 20;
                planningTaskCase.Approval_Case__c = true;
                planningTaskCase.Project_Type__c = 'Proforma';
                planningTaskCase.Anchored__c=true;
                if(caseCampaignWorkflowTypeRecordTypeID!=null)planningTaskCase.recordtypeID = caseCampaignWorkflowTypeRecordTypeID;
                uniqueCases.add(planningTaskCase);
                
                
                
                planningTaskCase = new case();
                planningTaskCase.Case_Sub_Group__c = 'Project Kick Off';
                planningTaskCase.Planning_Task__c = false;
                planningTaskCase.Anchored__c = false;
                planningTaskCase.Dependencies__c = 'MPE13, MPE14';
                planningTaskCase.Legacy_Task_Code__c = 'MPE15';
                planningTaskCase.Scheduled_Through__c = 'Bus.';
                planningTaskCase.Target_Duration_Days__c = 4;
                planningTaskCase.Target_Duration_Hours__c = 2;
                planningTaskCase.Status = 'Not Started';
                planningTaskCase.Description = planningTaskCase.Subject = 'Approve Pro Forma';
                planningTaskCase.Target_Duration_Minutes__c = 20;
                planningTaskCase.Anchored__c=true;
                planningTaskCase.Approval_Case__c = true;
                planningTaskCase.Project_Type__c = 'Proforma';
                if(caseCampaignWorkflowTypeRecordTypeID!=null)planningTaskCase.recordtypeID = caseCampaignWorkflowTypeRecordTypeID;
                uniqueCases.add(planningTaskCase);
                system.debug('****pUniqueCases ' + pUniqueCases);
                DML.save(uniqueCases);
            }

            return uniqueCases;
        }
    }

    /*******************************************************************************************************
    * @description generate records for Workflow Template Case
    * @param   n/a
    * @return void
    */
    public static void addworkflowTemplateCases() {

        list<Workflow_Template__c> metadataWT =  WorkflowTemplates;
        list<Case> metadataCases = uniqueCases;
        List <Workflow_Template_Case__c> workflowTemplateCases = new List<Workflow_Template_Case__c>();
        decimal i = 0.01;
        system.debug('****metadataWT ' + metadataWT);
        system.debug('****metadataCases ' + metadataCases);
        for(Workflow_Template__c wt:metadataWT){
           for (Case c:metadataCases) {
            Workflow_Template_Case__c wtc = new Workflow_Template_Case__c();
            wtc.Workflow_Template__c = wt.Id;
            wtc.Case__c = c.Id;
            wtc.Order__c = 1.0 + i;
            if(i == 0.03){
                wtc.Workflow_Dependency__c = String.valueOf(wtc.Order__c - 0.01) + ', ' +  String.valueOf(wtc.Order__c - 0.02);
            }
            else
            {
                wtc.Workflow_Dependency__c = String.valueOf(wtc.Order__c - 0.01);
            }
            workflowTemplateCases.add(wtc);
            system.debug('****** adding wtc instance ' + wtc);
            i = i + 0.01;
            } 
        }
        system.debug('******workflowTemplateCases ' + workflowTemplateCases);
        DML.save(workflowTemplateCases);

    }
    
    


}