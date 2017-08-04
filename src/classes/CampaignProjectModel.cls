/**
 *  @author Charu Goyal
 *  @date 6/29/17
 *  @group Model
 *  @description  Model class for the Campaign_Project__c object
 */

public without sharing class CampaignProjectModel {

    public static final  id CampaignProjectProforma= Schema.SObjectType.Proforma__c.getRecordTypeInfosByName().get('Campaign Project Proforma').getRecordTypeId();
    public static final String CAMPAIGN_PROJECT_TYPE_STANDARD = 'Standard';
    public static final String CAMPAIGN_PROJECT_TYPE_STANDALONE_CREATIVE = 'Standalone Creative';
    public static final  id ApprovalRecordID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campaign Project Approval').getRecordTypeId();
    public CampaignProjectModel() {
        
    }

    /*******************************************************************************************************
    * @description create campaign project workflow, based upon campaign project type
    * @param List of campaign project
    * @return n/a
    * @example
    * @date 2017-07-03 IY - change to use Campaign_Project_Type__c, instead of recordTypeId
    *
    */
    public static void createPlanningCases(Map<Id,Campaign_Project__c> oldCampaignProjMap, List<Campaign_Project__c> newcampaignProjects){
        String mode = '';
        List<Id> workflowTemplateIds = new List<Id>();
        //List<Id> planCampProjects = new List<Id>();
        List<Id> caseIdsToClone = new List<Id>();
        List<Case> casesToInsert = new List<Case>();
        Map<Id,List<Id>> campProjIdToCaseIdMap = new Map<Id,List<Id>>();
        Map<Id,List<Case>> campProjIdToCaseMap = new Map<Id,List<Case>>();
        Map<Id,List<Id>> wTemplateIdToCaseIdMap = new Map<Id,List<Id>>();
        Map<Id,Workflow_Template_Case__c> caseIdToWTCMap = new Map<Id,Workflow_Template_Case__c>();
        Map<Id,Campaign_Project__c> planCampProjectsMap = new Map<Id,Campaign_Project__c> ();
        for(Campaign_Project__c cp:newcampaignProjects){
            system.debug('****** cp.Status__c ' + cp.Status__c + ' oldCampaignProjMap.get(cp.Id).Status__c ' + oldCampaignProjMap.get(cp.Id).Status__c);
            if(cp.Status__c == 'Plan' && oldCampaignProjMap.get(cp.Id).Status__c == 'Draft'){
                //planCampProjects.add(cp.Id);
                planCampProjectsMap.put(cp.Id,cp);
            }
        }
        system.debug('****** planCampProjectsMap ' + planCampProjectsMap);
        for(Campaign_Project_Workflow__c cpw:[SELECT Campaign_Project__c,Id,Workflow_Template__c FROM Campaign_Project_Workflow__c where Campaign_Project__c in: planCampProjectsMap.keySet()]){
            workflowTemplateIds.add(cpw.Workflow_Template__c);
        }
        system.debug('****** workflowTemplateIds ' + workflowTemplateIds);

        for(Workflow_Template_Case__c caseTemplateRec:[SELECT Id,Name,Workflow_Template__c,Milestone_Type__c,Order__c,Workflow_Dependency__c,Case__c,Case__r.Planning_Task__c,Member_Escalation_Assignment__c,Entitlement__c FROM Workflow_Template_Case__c where Workflow_Template__c in: workflowTemplateIds]){
            if(caseTemplateRec.Case__r.Planning_Task__c){
                if (wTemplateIdToCaseIdMap.containsKey(caseTemplateRec.Workflow_Template__c)) {
                    wTemplateIdToCaseIdMap.get(caseTemplateRec.Workflow_Template__c).add(caseTemplateRec.Case__c);
                } 
                else {
                    wTemplateIdToCaseIdMap.put(caseTemplateRec.Workflow_Template__c, new List<Id>{caseTemplateRec.Case__c});
                }
                caseIdToWTCMap.put(caseTemplateRec.Case__c,caseTemplateRec);
                caseIdsToClone.add(caseTemplateRec.Case__c);
            }
        }
        system.debug('****** wTemplateIdToCaseIdMap ' + wTemplateIdToCaseIdMap);
        //system.debug('****** caseIdsToClone ' + caseIdsToClone);
        //createCases(planCampProjects,wTemplateIdToCaseIdMap,caseIdsToClone,caseIdToWTCMap);
        ////createCases(planCampProjects,wTemplateIdToCaseIdMap,caseIdToWTCMap,cmpMapToCreateCase);
        createCases(wTemplateIdToCaseIdMap,caseIdToWTCMap,planCampProjectsMap);
    }

    /*******************************************************************************************************
    * @description create campaign project workflow, based upon campaign project type
    * @param List of campaign project
    * @return n/a
    * @example
    * @date IY: 2017-07-03 - change to use Campaign_Project_Type__c, instead of recordTypeId
    *
    */
    public static void createExecutionCases(Map<Id,Campaign_Project__c> oldCampaignProjMap, List<Campaign_Project__c> newcampaignProjects){
        String mode = '';
        List<Id> workflowTemplateIds = new List<Id>();
        //List<Id> approvedCampProjects = new List<Id>();
        List<Id> caseIdsToClone = new List<Id>();
        Map<Id,List<Case>> campProjIdToCaseMap = new Map<Id,List<Case>>();
        Map<Id,List<Id>> wTemplateIdToCaseIdMap = new Map<Id,List<Id>>();
        Map<Id,Workflow_Template_Case__c> caseIdToWTCMap = new Map<Id,Workflow_Template_Case__c>();
        Map<Id,Campaign_Project__c> approvedCampProjectsMap = new Map<Id,Campaign_Project__c>();
        //map<id,Campaign_Project__c> cmpMapToCreateCase = new map<id,Campaign_Project__c> ();
        for(Campaign_Project__c cp:newcampaignProjects){
            system.debug('****** cp.Status__c ' + cp.Status__c + ' oldCampaignProjMap.get(cp.Id).Status__c ' + oldCampaignProjMap.get(cp.Id).Status__c);
            if(cp.Status__c == 'Approved' && oldCampaignProjMap.get(cp.Id).Status__c == 'Submitted for Approval'){
                //approvedCampProjects.add(cp.Id);
                approvedCampProjectsMap.put(cp.Id,cp);
            }
        }
        system.debug('****** approvedCampProjectsMap ' + approvedCampProjectsMap);
        for(Campaign_Project_Workflow__c cpw:[SELECT Campaign_Project__c,Id,Workflow_Template__c FROM Campaign_Project_Workflow__c where Campaign_Project__c in: approvedCampProjectsMap.keySet()]){
            workflowTemplateIds.add(cpw.Workflow_Template__c);
        }
        system.debug('****** workflowTemplateIds ' + workflowTemplateIds);

        for(Workflow_Template_Case__c caseTemplateRec:[SELECT Id,Name,Workflow_Template__c,Milestone_Type__c,Order__c,Workflow_Dependency__c,Case__c,Case__r.Planning_Task__c,Member_Escalation_Assignment__c,Entitlement__c FROM Workflow_Template_Case__c where Workflow_Template__c in: workflowTemplateIds]){
            if(!caseTemplateRec.Case__r.Planning_Task__c){
                if (wTemplateIdToCaseIdMap.containsKey(caseTemplateRec.Workflow_Template__c)) {
                wTemplateIdToCaseIdMap.get(caseTemplateRec.Workflow_Template__c).add(caseTemplateRec.Case__c);
                } else {
                    wTemplateIdToCaseIdMap.put(caseTemplateRec.Workflow_Template__c, new List<Id>{caseTemplateRec.Case__c});
                }
                /*if (wTemplateToWTCMap.containsKey(caseTemplateRec.Workflow_Template__c)) {
                    wTemplateToWTCMap.get(caseTemplateRec.Workflow_Template__c).add(caseTemplateRec);
                } 
                else {
                    wTemplateToWTCMap.put(caseTemplateRec.Workflow_Template__c, new List<Workflow_Template_Case__c>{caseTemplateRec});
                }*/
                caseIdToWTCMap.put(caseTemplateRec.Case__c,caseTemplateRec);
                caseIdsToClone.add(caseTemplateRec.Case__c);
            }    
        }
        system.debug('****** wTemplateIdToCaseIdMap ' + wTemplateIdToCaseIdMap);
        //system.debug('****** caseIdsToClone ' + caseIdsToClone);
        //createCases(approvedCampProjects,wTemplateIdToCaseIdMap,caseIdsToClone,caseIdToWTCMap,cmpMapToCreateCase);
        ////createCases(approvedCampProjects,wTemplateIdToCaseIdMap,caseIdToWTCMap,cmpMapToCreateCase);
        createCases(wTemplateIdToCaseIdMap,caseIdToWTCMap,approvedCampProjectsMap);
    }



    /*******************************************************************************************************
    * @description create cases for campaign project
    *       2017-07-29 , IY: add logic to set the parent case
    * @param
    * @return n/a
    * @example

    *
    */
    //public static void createCases(List<Id> modifiedCampProjects, Map<Id,List<Id>> wTemplateIdToCaseIdMap, Map<Id,Workflow_Template_Case__c> caseIdToWTCMap, map<id,Campaign_Project__c> modifiedCampProjectsMap){
      public static void createCases(Map<Id,List<Id>> wTemplateIdToCaseIdMap, Map<Id,Workflow_Template_Case__c> caseIdToWTCMap, map<id,Campaign_Project__c> modifiedCampProjectsMap){
        List<Case> casesToInsert                                   = new List<Case>();
        Map<Id,List<Id>> campProjIdToCaseIdMap                     = new Map<Id,List<Id>>();
        Map<Id,List<Workflow_Template_Case__c>> campProjIdToWTCMap = new Map<Id,List<Workflow_Template_Case__c>>();
        Map<Id,Case> casesToClone                                  = new Map<Id,Case>([select Id,Project_Type__c,Approval_Case__c,Status,Case_Sub_Group__c,Member_Role__c,Escalation_Assignment__c,EntitlementId,
                                                                                       Planning_Task__c,Anchored__c,Dependencies__c,Legacy_Task_Code__c,Scheduled_Through__c,Target_Duration_Days__c,Target_Duration_Hours__c,
                                                                                       Subject,Target_Duration_Minutes__c,Task_Code__c from Case where Id in: caseIdToWTCMap.keySet()]);
        map<id,Proforma__c> proformaCampaignMap                    = new map<id,Proforma__c>(); // this map will hold the related proforma of a campaign
        Map<String,Id> queueNameToQueueMap                         = new Map<String,Id>(CaseModel.getCaseQueueMap());
        for (Proforma__c pf: [select Campaign_Project__c,Status__c,id from Proforma__c where (Campaign_Project__c=:modifiedCampProjectsMap.keySet() and recordtype.name = 'Campaign Project Proforma')]){ 
                proformaCampaignMap.put(pf.Campaign_Project__c,pf);
        }
        
        for (Campaign_Project_Workflow__c cpw:[SELECT Campaign_Project__c,Id,Workflow_Template__c FROM Campaign_Project_Workflow__c where Campaign_Project__c in: modifiedCampProjectsMap.keySet()]){
            system.debug('****** wTemplateIdToCaseIdMap ' + wTemplateIdToCaseIdMap.get(cpw.Workflow_Template__c));
            system.debug('****** campProjIdToCaseIdMap.get(cpw.Campaign_Project__c) ' + campProjIdToCaseIdMap.get(cpw.Campaign_Project__c));
            if (campProjIdToCaseIdMap.containsKey(cpw.Campaign_Project__c)) {
                campProjIdToCaseIdMap.get(cpw.Campaign_Project__c).addAll(wTemplateIdToCaseIdMap.get(cpw.Workflow_Template__c));
            } else {
                campProjIdToCaseIdMap.put(cpw.Campaign_Project__c, new List<Id>(wTemplateIdToCaseIdMap.get(cpw.Workflow_Template__c)));
            }
        }
        system.debug('****** campProjIdToCaseIdMap ' + campProjIdToCaseIdMap);
        
        for (Id campProjId:campProjIdToCaseIdMap.keySet()){
            for (Id caseId:campProjIdToCaseIdMap.get(campProjId)){
                Case newCase                     = casesToClone.get(caseId).clone(false,false,false,false);
                newCase.ParentId                 = modifiedCampProjectsMap.get(campProjId).Campaign_Project_Case__c;
                newCase.RecordTypeId             = Schema.SObjectType.Case.getRecordTypeInfosByName().get(CaseModel.CASE_TYPE_CAMPAIGN_WORKFLOW_INSTANCE).getRecordTypeId();
                newCase.Campaign_Project__c      = campProjId;
                newCase.Dependencies__c          = (caseIdToWTCMap.get(caseId).Workflow_Dependency__c != null) ? caseIdToWTCMap.get(caseId).Workflow_Dependency__c : '';
                newCase.Order__c                 = (caseIdToWTCMap.get(caseId).Order__c != null) ? String.valueOf(caseIdToWTCMap.get(caseId).Order__c) : '';
                newCase.Escalation_Assignment__c = (modifiedCampProjectsMap.get(campProjId).Market_Text__c != null && caseIdToWTCMap.get(caseId).Member_Escalation_Assignment__c != null) ? modifiedCampProjectsMap.get(campProjId).Market_Text__c + ' - ' +
                                                   caseIdToWTCMap.get(caseId).Member_Escalation_Assignment__c : '';
                newCase.EntitlementId            = (String.isNotBlank(caseIdToWTCMap.get(caseId).Entitlement__c)) ? caseIdToWTCMap.get(caseId).Entitlement__c : null;
                //newCase.Member_Role__c           = (modifiedCampProjectsMap.get(campProjId).Market_Text__c != null && casesToClone.get(caseId).Member_Role__c != null) ? modifiedCampProjectsMap.get(campProjId).Market_Text__c + ' - ' + 
                //                                    casesToClone.get(caseId).Member_Role__c : '';
                newCase.Member_Role__c           = (casesToClone.get(caseId).Member_Role_Queue_Derivation__c == 'Market' && modifiedCampProjectsMap.get(campProjId).Market_Text__c != null && casesToClone.get(caseId).Member_Role__c != null) ?  
                                                   modifiedCampProjectsMap.get(campProjId).Market_Text__c + ' - ' + casesToClone.get(caseId).Member_Role__c : 
                                                   (casesToClone.get(caseId).Member_Role_Queue_Derivation__c == 'DMC' && modifiedCampProjectsMap.get(campProjId).DMC_Text__c != null && casesToClone.get(caseId).Member_Role__c != null) ?
                                                   modifiedCampProjectsMap.get(campProjId).DMC_Text__c + ' - ' + casesToClone.get(caseId).Member_Role__c : 
                                                   (casesToClone.get(caseId).Member_Role_Queue_Derivation__c == 'Generic' && casesToClone.get(caseId).Member_Role__c != null) ? casesToClone.get(caseId).Member_Role__c : '';
                newCase.Milestone__c             = (caseIdToWTCMap.get(caseId).Milestone_Type__c != null) ? caseIdToWTCMap.get(caseId).Milestone_Type__c : ''; 
                newCase.OwnerId                  = (queueNameToQueueMap.get(newCase.Member_Role__c) != null) ? 
                                                    queueNameToQueueMap.get(newCase.Member_Role__c) : UserInfo.getUserId();
                if (modifiedCampProjectsMap !=null && modifiedCampProjectsMap.get(campProjId)!=null)
                {
                    newCase = ValidateTargetDates(modifiedCampProjectsMap.get(campProjId), newCase);
                }

                // below logic is to update the proforma case information 
                if (proformaCampaignMap!=null && proformaCampaignMap.get(campProjId)!=null)
                {
                        if( newCase.subject.contains('Approve Pro Forma')
                            && newCase.Approval_Case__c == true)
                            {
                                // ProformaModel.CheckForUpdates cfu = n
                                ProformaModel.CheckForUpdates cfu = ProformaModel.updateProformaDetailsOnCase(newCase,proformaCampaignMap);
                                if(cfu.isUpdate)
                                {
                                        newCase = cfu.mycase; 
                                }
                            }
                        
                }  
                
                casesToInsert.add(newCase);
            }   
        }
        insert casesToInsert;
    }
    /*******************************************************************************************************
    * @description updatete target start and end dates of Anchor tasks cases 
    * @param - campaign project
    * @return case    
    *
    */
    
    public static void UpdateeAncoredTaskCases(Map<Id,Campaign_Project__c> oldCampaignProjMap, List<Campaign_Project__c> newcampaignProjects){
        set<id> setProjectIDs = new set<id>();
        set<id> ApprovedCampaignIDSet = new set<id>();
        set<id> RejectedCampaignIDSet = new set<id>();
        set<id> collectedIDs = new set<id>();
        set<id> SubmittedforApprovalIDSet = new set<id>();
        system.debug('added to setProjectIDs 11111');
        for(Campaign_Project__c cp:newcampaignProjects )
        {
            if((cp.Email_Drop_Date__c!=oldCampaignProjMap.get(cp.id).Email_Drop_Date__c) || (cp.Valid_Start_Date__c!=oldCampaignProjMap.get(cp.id).Valid_Start_Date__c) 
            || (cp.Valid_End_Date__c!=oldCampaignProjMap.get(cp.id).Valid_End_Date__c) 
            || (cp.Direct_Mail_Drop_Date__c!=oldCampaignProjMap.get(cp.id).Direct_Mail_Drop_Date__c))
            {
                system.debug('added to setProjectIDs');
                setProjectIDs.add(cp.id);
            }
            if((oldCampaignProjMap.get(cp.id).Status__c!=cp.Status__c))
            {
                if(cp.Status__c == 'Approved' )
                {
                    ApprovedCampaignIDSet.add(cp.id);
                }
                
                if(cp.Status__c == 'Submitted for Approval')
                {
                    SubmittedforApprovalIDSet.add(cp.id);
                }
                
                if(cp.Status__c == 'Rejected')
                {
                    RejectedCampaignIDSet.add(cp.id);
                }
            }
            
            
        }
        
        collectedIDs.addall(setProjectIDs);
        collectedIDs.addall(ApprovedCampaignIDSet);
        collectedIDs.addall(RejectedCampaignIDSet);
        collectedIDs.addall(SubmittedforApprovalIDSet);
       map<id,case> mapCasesToUpdate = new map<id,case>();
       Map<string, list<case>> UpdateCasesMap= new Map<string, list<case>>();
       for(case c : [select id, Campaign_Project__c,subject ,Approval_Case__c,Project_Type__c,status,Anchored__c, Target_Start_Date__c,Target_End_Date__c  from case where Campaign_Project__c=:collectedIDs ] )
       {
           if(setProjectIDs.contains(c.Campaign_Project__c) && c.Anchored__c==true)
           {
               if(UpdateCasesMap!=null && UpdateCasesMap.get(c.Campaign_Project__c)!=null)
               {
                   system.debug('anchored case is'+c.id);
                   list<case> tempcaseLst = UpdateCasesMap.get(c.Campaign_Project__c);
                   tempcaseLst.add(c);
                   UpdateCasesMap.put(c.Campaign_Project__c,tempcaseLst);
               }else{
                   list<case> tempcaseLst = new list<case>();
                    tempcaseLst.add(c);
                   UpdateCasesMap.put(c.Campaign_Project__c,tempcaseLst);
               }
           }
           
           if((ApprovedCampaignIDSet.contains(c.Campaign_Project__c) || RejectedCampaignIDSet.contains(c.Campaign_Project__c) || 
               SubmittedforApprovalIDSet.contains(c.Campaign_Project__c))
                && c.Project_Type__c =='Campaign Project' && c.Approval_Case__c == true)
           {
             if(mapCasesToUpdate.get(c.id)!=null){
                case tempCase = new case();
                tempCase= mapCasesToUpdate.get(c.id);
                boolean b; 
                
                if(ApprovedCampaignIDSet.contains(c.Campaign_Project__c))
                {
                    tempCase.status = 'Completed';
                    b= true;
                }
                if(RejectedCampaignIDSet.contains(c.Campaign_Project__c))
                {
                    tempCase.status = 'Rejected';
                    b= true;
                }
                if(SubmittedforApprovalIDSet.contains(c.Campaign_Project__c))
                {
                    tempCase.status = 'Submitted for Approval';
                    b= true;
                }
                if(b){
                    tempCase.recordtypeID = ApprovalRecordID;
                }
                mapCasesToUpdate.put(c.id,tempCase);
             }else{
                boolean b; 
                if(ApprovedCampaignIDSet.contains(c.Campaign_Project__c))
                {
                    c.status = 'Completed';
                    b=true;
                }
                if(RejectedCampaignIDSet.contains(c.Campaign_Project__c))
                {
                    c.status = 'Rejected';
                     b=true;
                }
                if(SubmittedforApprovalIDSet.contains(c.Campaign_Project__c))
                {
                    c.status = 'Submitted for Approval';
                     b=true;
                }
                if(b){
                    c.recordtypeID = ApprovalRecordID;
                }
                mapCasesToUpdate.put(c.id,c);
             }
           }
            
           
           
       }       
              
       for(Campaign_Project__c cp:newcampaignProjects){
         system.debug('going to update case 11111');
         if(setProjectIDs.contains(cp.id) && UpdateCasesMap!=null && UpdateCasesMap.get(cp.id)!=null)
         {
             system.debug('going to update case 22222');
             for(case cs : UpdateCasesMap.get(cp.id))
             {
                if(mapCasesToUpdate.get(cs.id)!=null){
                    case tempCase = new case();
                    tempCase= mapCasesToUpdate.get(cs.id);
                    tempCase= ValidateTargetDates(cp,tempCase);
                    mapCasesToUpdate.put(cs.id,tempCase);                   
                 }else{
                    case tempCase = new case();
                    tempCase= ValidateTargetDates(cp,cs);
                    mapCasesToUpdate.put(cs.id,tempCase);                   
                 }
             }
         }
      }      
      
       
       if(!(mapCasesToUpdate.isEmpty()))
       {
           update mapCasesToUpdate.values();
       }
    }
    
    /*******************************************************************************************************
    * @description return a case with target start and end dates 
    * @param - campaign project
    * @return case    
    *
    */
    
    public static case ValidateTargetDates(Campaign_Project__c cmProject,case c)
    {
        
        if(c.Subject.contains('Prepare & Deploy Email')&& cmProject.Email_Drop_Date__c!=null)
        {
            system.debug('Prepare & Deploy Email'+cmProject.Email_Drop_Date__c);
            c.Target_Start_Date__c = cmProject.Email_Drop_Date__c;
            c.Target_End_Date__c = cmProject.Email_Drop_Date__c+1;
        }
        
        if(c.Subject.contains('Execute Event'))
        {
            if(cmProject.Valid_Start_Date__c!=null) c.Target_Start_Date__c = cmProject.Valid_Start_Date__c;
             if(cmProject.Valid_End_Date__c!=null) c.Target_End_Date__c = cmProject.Valid_End_Date__c;
        }
        
        if(c.Subject.contains('Drop Mail')&& cmProject.Direct_Mail_Drop_Date__c!=null)
        {
            c.Target_Start_Date__c = cmProject.Direct_Mail_Drop_Date__c;
            c.Target_End_Date__c = cmProject.Direct_Mail_Drop_Date__c+1;
        }
        
        if(c.Subject.contains('Approve Pro Forma')&& cmProject.Email_Drop_Date__c!=null)
        {
            c.Target_Start_Date__c = cmProject.Email_Drop_Date__c-90;
            integer dayStDay = c.Target_Start_Date__c.day();
            c.Target_Start_Date__c = date.newInstance(c.Target_Start_Date__c.year(), c.Target_Start_Date__c.month(), 15);
            c.Target_End_Date__c = c.Target_Start_Date__c+2;
        }
        if(c.Target_Start_Date__c!=null)
        {
            Date planendTargetStartDt = c.Target_Start_Date__c;
            Datetime dt = DateTime.newInstance(planendTargetStartDt, Time.newInstance(0, 0, 0, 0));
            String dayOfWeek=dt.format('EEEE');
            System.debug('Day : ' + dayOfWeek);
            if(dayOfWeek=='Saturday')
            {
                c.Target_Start_Date__c = c.Target_Start_Date__c+2;
                if(c.Subject.contains('Approve Pro Forma')&& cmProject.Email_Drop_Date__c!=null)
                {
                    c.Target_End_Date__c = c.Target_Start_Date__c +2;
                }
            }
            if(dayOfWeek=='Sunday')
            {
                c.Target_Start_Date__c = c.Target_Start_Date__c+1;
                if(c.Subject.contains('Approve Pro Forma')&& cmProject.Email_Drop_Date__c!=null)
                {
                    c.Target_End_Date__c = c.Target_Start_Date__c +2;
                }
            }
        }
        
        if(c.Target_End_Date__c!=null)
        {
            Date planendTargetStartDt = c.Target_End_Date__c;
            Datetime dt = DateTime.newInstance(planendTargetStartDt, Time.newInstance(0, 0, 0, 0));
            String dayOfWeek=dt.format('EEEE');
            System.debug('Day : ' + dayOfWeek);
            if(dayOfWeek=='Saturday')
            {
                c.Target_End_Date__c = c.Target_End_Date__c+2;
            }
            if(dayOfWeek=='Sunday')
            {
                c.Target_End_Date__c = c.Target_End_Date__c+1;
            }
        }
        
        
        return c;
    }   
    
    /*******************************************************************************************************
    * @description create campaign project workflow, based upon campaign project type
    * @param List of campaign project
    * @return n/a
    * @example
    * @date 2017-07-03 - IY:  change to use Campaign_Project_Type__c, instead of recordTypeId
    * @date 2017-07-28 : US1257. create  campaign project type case
    *
    */
    public static void createCampaignProjectWorkflow(List<Campaign_Project__c> newcampaignProjects) {

        Workflow_Settings__mdt[] workflowSettings = [SELECT MasterLabel, QualifiedApiName, Campaign_Project_Record_Type__c, Workflow_Template_Name__c, Entitlement_Name__c FROM Workflow_Settings__mdt];


        // create campaign project workflow  (Campaign_Project_Workflow__c)
        Map<String, String> campProjectRecTypeToWorkflowTempMap = new Map<String,String>();
        Map<String, Id> wTemplateNameToIdMap = new Map<String,Id>();
        List<Campaign_Project_Workflow__c> campProjWorkflowToInsertList = new List<Campaign_Project_Workflow__c>();
        for(Workflow_Template__c wt:[SELECT Id, Name, Active__c FROM Workflow_Template__c where Active__c = true]){
            if(wTemplateNameToIdMap.get(wt.Name) == null){
                wTemplateNameToIdMap.put(wt.Name,wt.Id);
            }
        }
        system.debug('****wTemplateNameToIdMap ' + wTemplateNameToIdMap);
        for(Workflow_Settings__mdt workflowSetting:workflowSettings){
            if(workflowSetting.Campaign_Project_Record_Type__c != null && workflowSetting.Workflow_Template_Name__c != null){

                system.debug('****** workflowSetting.Workflow_Template_Name__c ' + workflowSetting.Workflow_Template_Name__c + ' wftemp Id ' +
                    wTemplateNameToIdMap.get(workflowSetting.Workflow_Template_Name__c)
                    );

                campProjectRecTypeToWorkflowTempMap.put(
                    workflowSetting.Campaign_Project_Record_Type__c,
                    wTemplateNameToIdMap.get(workflowSetting.Workflow_Template_Name__c));
            }
        }
        system.debug('****** campProjectRecTypeToWorkflowTempMap' + campProjectRecTypeToWorkflowTempMap);

        for(Campaign_Project__c campProj: newcampaignProjects){
            if(campProj.Status__c == 'Draft'){
                Campaign_Project_Workflow__c newCampProjWFRec = new Campaign_Project_Workflow__c(Campaign_Project__c = campProj.Id,
                    Workflow_Template__c = campProjectRecTypeToWorkflowTempMap.get(campProj.Campaign_Project_Type__c));
                campProjWorkflowToInsertList.add(newCampProjWFRec);
            }
        }
        if(campProjWorkflowToInsertList != null && campProjWorkflowToInsertList.size() > 0){
            DML.save(campProjWorkflowToInsertList); // insert campProjWorkflowToInsertList;
        }

        // create case with campaign project type
        Set <String> entitlementNames = new Set<String>();
        for(Workflow_Settings__mdt workflowSetting:workflowSettings){
            entitlementNames.add(workflowSetting.Entitlement_Name__c);
        }
        Map<String, Id> entitlementNameToIdMap = new Map<String,Id>();
        for(Entitlement et:[select  Name, EndDate, Id, SlaProcessId, StartDate, Status from Entitlement where Status = 'Active' and Name in : entitlementNames]){
            if(entitlementNameToIdMap.get(et.Name) == null){
                entitlementNameToIdMap.put(et.Name,et.Id);
            }
        }
        Map<String, String> campProjectRecTypeToEntitlmentMap = new Map<String,String>();
        for(Workflow_Settings__mdt workflowSetting:workflowSettings){
            if(workflowSetting.Campaign_Project_Record_Type__c != null && workflowSetting.Entitlement_Name__c != null){

                campProjectRecTypeToEntitlmentMap.put(
                        workflowSetting.Campaign_Project_Record_Type__c,
                        entitlementNameToIdMap.get(workflowSetting.Entitlement_Name__c));
            }
        }

        List<Case> caseToInserList = new List<Case>();
        for(Campaign_Project__c campProj: newcampaignProjects){
            Case c = CaseModel.createCampaignProjectMilestoneCase(campProj);
            c.EntitlementId =  campProjectRecTypeToEntitlmentMap.get(campProj.Campaign_Project_Type__c);
            caseToInserList.add(c);
        }
        if(caseToInserList != null && caseToInserList.size() > 0){
            DML.save(caseToInserList); // insert campProjWorkflowToInsertList;

            // finally update the campaign project field again.
            List <Campaign_Project__c> cpForUpdate = new List <Campaign_Project__c>();
            for (Case c: caseToInserList ){
                for(Campaign_Project__c campProj: newcampaignProjects){
                    if (c.Campaign_Project__c == campProj.Id){
                        cpForUpdate.add(new Campaign_Project__c(Id =campProj.Id, Campaign_Project_Case__c = c.Id ) );
                    }
                }
            }
            DML.save(cpForUpdate);

        }

    }


    /*******************************************************************************************************
    * @description update email required and/or direct mail required flag, based upon channel selection
    * @param  Trigger.oldMap, Trigger.new
    * @return n/a
    * @example
    *
    */
    public static void setChannelFlag(Map<Id,Campaign_Project__c> oldCampaignProjMap, List<Campaign_Project__c> newcampaignProjects) {

        Set<Id> planCampProjects = new Set<Id>();

        // all the campaign project change from draft to plan status
        for (Campaign_Project__c cp:newcampaignProjects) {
            // if channel flag change or if it is a new record
            if (oldCampaignProjMap == null || cp.Delivery_Channel__c  != oldCampaignProjMap.get(cp.Id).Delivery_Channel__c ) {
                // set the channel flags
                if (cp.Delivery_Channel__c != null) {
                    String[] deliveryChannels = cp.Delivery_Channel__c.split(';');
                    for (String dc: deliveryChannels) {
                        if (dc.equalsIgnoreCase('Email')) {
                            cp.Email_Required__c = true;
                        }

                        if (dc.equalsIgnoreCase('Direct Mail')) {
                            cp.Direct_Mail_Required__c = true;
                        }
                    }
                } else {
                    cp.Email_Required__c = false;
                    cp.Direct_Mail_Required__c = false;
                }
            }
        }

    }


    /*******************************************************************************************************
    * @description update Record type, based upon the initial campaign project setup
    * @param  Trigger.oldMap, Trigger.new
    * @return n/a
    * @example
    *
    */
    public static void setRecordType(Map<Id,Campaign_Project__c> oldCampaignProjMap, List<Campaign_Project__c> newcampaignProjects){

        Set<Id> planCampProjects = new Set<Id>();

        // all the campaign project change from draft to plan status
        for(Campaign_Project__c cp:newcampaignProjects){
            system.debug('****** cp.Status__c ' + cp.Status__c + ' oldCampaignProjMap.get(cp.Id).Status__c ' + oldCampaignProjMap.get(cp.Id).Status__c);
            if(cp.Status__c == 'Plan' && oldCampaignProjMap.get(cp.Id).Status__c == 'Draft'){
                planCampProjects.add(cp.Id);
            }
        }
        system.debug('****** planCampProjects ' + planCampProjects);

        // find the campaign project record type map
        map<String, Campaign_Project_Record_Type_Map__mdt> recordTypeMap = new map<String, Campaign_Project_Record_Type_Map__mdt>();
        if (planCampProjects.size() > 0 ){
            for (Campaign_Project_Record_Type_Map__mdt r: [ select Campaign_Project_Type__c, Event_Details_Required__c, Direct_Mail_Required__c, Email_Required__c, Id,  Record_Type_Name__c from Campaign_Project_Record_Type_Map__mdt where Active_Flag__c = true] ){
                // key is campaign project type + Email Required + DM Required
                String key = r.Campaign_Project_Type__c ; // + r.Email_Required__c + r.Direct_Mail_Required__c;
                system.debug('****** key in record type Map ' + key);
                recordTypeMap.put(key, r );
            }
        }

        for(Campaign_Project__c cp:newcampaignProjects){
            if (planCampProjects.contains(cp.Id)){
                String key = cp.Campaign_Project_Type__c; // +  cp.Email_Required__c + cp.Direct_Mail_Required__c;
                system.debug('****** key in campaign project ' + key);
                String recordTypeName = recordTypeMap.get(key).Record_Type_Name__c;
                if (String.isNotBlank(recordTypeName)){
                    Id recordTypeId = Schema.SObjectType.Campaign_Project__c.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
                    cp.RecordTypeId = recordTypeId;
                }
            }

        }

    }
    
   

}