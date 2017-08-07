/**
 *  @author Charu Goyal
 *  @date 6/29/17
 *  @group Model
 *  @description  Model class for the Campaign_Project__c object
 */


public without sharing class CaseModel {
    

    public static final String CASE_TYPE_CAMPAIGN_WORKFLOW_INSTANCE = 'Campaign Workflow Instance';
    public static final String CASE_TYPE_CAMPAIGN_PROJECT_APPROVAL = 'Campaign Project Approval';
    public static final String CASE_TYPE_CAMPAIGN_PROJECT_MILESTONE = 'Campaign Project Milestone';
    public static final String CASE_TYPE_CAMPAIGN_WORKFLOW_TEMPLATE = 'Campaign Workflow Template';

    public CaseModel() {
        
    }

    /*******************************************************************************************************
    * @description create a case with campaign projec type
    * @param Campaign_Project__c
    * @return Case
    * @example
    *
    */
    public static Case createCampaignProjectMilestoneCase(Campaign_Project__c  project){

        Case c = new Case ();
        c.order__c = '0';
        c.Subject = '' + project.Campaign_Label__c + ': Milestones' ;
        c.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(CASE_TYPE_CAMPAIGN_PROJECT_MILESTONE).getRecordTypeId();
        c.Campaign_Project__c = project.Id;

        return c;

    }

     /*******************************************************************************************************
    * @description Get the Developer Name to Id Map for all queues for Case Assignment 
    * @param - void
    * @return case    
    *
    */
    
    public static Map<String,Id> getCaseQueueMap(){
        Map<String,Id> queueNameToQueueMap = new Map<String,Id>(); 
        for(QueueSobject queueSObj:[SELECT Id,QueueId,SobjectType,Queue.DeveloperName,Queue.Id,Queue.Name FROM QueueSobject where SobjectType = 'Case']){
            if(queueSObj.queue.DeveloperName != null && queueSObj.queue.DeveloperName != '' && queueNameToQueueMap.get(queueSObj.Queue.DeveloperName) == null){
            queueNameToQueueMap.put(queueSObj.Queue.DeveloperName,queueSObj.Queue.Id);
            }
        }
        system.debug('***queueNameToQueueMap ' + queueNameToQueueMap);
        return queueNameToQueueMap;
    }
    
  
    /*******************************************************************************************************
    * @description create case milestone history
    * @param Map<Id,Case> oldCaseMap, List<Case> newCases
    * @return n/a
    * @example
    *
    */
    public static void createCaseMilestoneHistory(Map<Id,Case> oldCaseMap, List<Case> newCases){

        // TO DO: INSTEAD OF RECORD TYPE, USE a field attribute
        Id caseWorkflowInstance = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campaign Workflow Instance').getRecordTypeId();
        Id caseCampaignMilestone = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campaign Project Milestone').getRecordTypeId();



        List <Case> caseWithMilestoneChange = new List<Case>();
        for(Case c: newCases){
            if (c.RecordTypeId == caseWorkflowInstance  || c.RecordTypeId == caseCampaignMilestone ){

                // find the field Last_Milestone_Violated__c that has been changed
                if (c.Last_Milestone_Violated__c != null && oldCaseMap.get(c.Id).Last_Milestone_Violated__c != c.Last_Milestone_Violated__c){
                    caseWithMilestoneChange.add(c);
                }
            }
        }

        MilestoneModel.createCaseMilestoneHistory(caseWithMilestoneChange);


    }



    private static map<String, String > pMilestoneTimeStampMap = null;
    public static map<String, String >  milestoneTimeStampMap{

        get {
            if (pMilestoneTimeStampMap == null){
                pMilestoneTimeStampMap = new  map<String, String >();
                for (Campaign_Milestone_Timestamp_Map__mdt mt: [select Milestone_Name__c, Milestone_Timestamp_Field__c from Campaign_Milestone_Timestamp_Map__mdt]){
                    // change to upper case
                    pMilestoneTimeStampMap.put(mt.Milestone_Name__c.toUpperCase(), mt.Milestone_Timestamp_Field__c );
                }
            }
            return pMilestoneTimeStampMap;
        }

    }

    private static map<String, String > pMilestoneStatusMap = null;
    public static map<String, String >  milestoneStatusMap{

        get {
            if (pMilestoneStatusMap == null){
                pMilestoneStatusMap = new  map<String, String >();
                for (Campaign_Milestone_Timestamp_Map__mdt mt: [select Milestone_Name__c, Milestone_Status_Field__c from Campaign_Milestone_Timestamp_Map__mdt]){
                    // change to upper case
                    pMilestoneStatusMap.put(mt.Milestone_Name__c.toUpperCase(), mt.Milestone_Status_Field__c );
                }
            }
            return pMilestoneStatusMap;
        }

    }

    /*******************************************************************************************************
    * @description process case ownership change
    * @param Map<Id,Case> oldCaseMap, List<Case> newCases
    * @return n/a
    * @example
    *
    */
    public static void processOwnershipChange(Map<Id,Case> oldCaseMap, List<Case> newCases){

        Id caseWorkflowInstance = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campaign Workflow Instance').getRecordTypeId();

        List <Case> caseChange = new List <Case>();

        for(Case c: newCases){
            if (c.RecordTypeId == caseWorkflowInstance){

                // check the case owenership change from queue to indiviudal user
                if ( oldCaseMap.get(c.Id).OwnerId !=  c.OwnerId  && string.valueOf(oldCaseMap.get(c.Id).OwnerId).startsWith('00G') && string.valueOf(c.OwnerId).startsWith('005') ){
                    caseChange.add(new Case (id  = c.Id,  First_User_Assignment_Date__c = datetime.now() ));
                }

            }
        }

        // make another update in order to trigger entitlement process / milestone
        // need to use queueable because the trigger context does not invoke entitlement when owner change. 
        if (caseChange.size() > 0){
            // DML.save(caseChange);
            CaseUpdateQueueable updateJob = new CaseUpdateQueueable(caseChange);
            Id jobId = System.enqueueJob(updateJob);
        }



    }

    /*******************************************************************************************************
    * @description update parent's milestone status and date
    * @param Map<Id,Case> oldCaseMap, List<Case> newCases
    * @return n/a
    * @example
    *
    */
    public static void updateParentMilestone(Map<Id,Case> oldCaseMap, List<Case> newCases){

        Id caseWorkflowInstance = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campaign Workflow Instance').getRecordTypeId();

        Map <Id, Case> slaCaseUpdate = new Map <Id, Case>();

        for(Case c: newCases){
            if (c.RecordTypeId == caseWorkflowInstance){

                if (c.ParentId != null && String.isNotBlank(c.Milestone__c) &&  (oldCaseMap == null || oldCaseMap.get(c.Id).status !=  c.Status ) ){

                    Case milestoneCase = slaCaseUpdate.containsKey(c.ParentId)?slaCaseUpdate.get(c.ParentId): (new Case(Id = c.ParentId));

                    // update the parent status field
                    System.debug('####  milestone field: ' + c.Milestone__c + ' status ' + c.Status);
                    String milestoneStatusField = milestoneStatusMap.get(c.Milestone__c.toUpperCase());
                    if (milestoneStatusField != null){
                        System.debug('#### matched milestone status field: ' + milestoneStatusField);
                        milestoneCase.put( milestoneStatusField,  c.Status);
                    }

                    // update the corresponding milestone in parent case
                    if (oldCaseMap != null && oldCaseMap.get(c.Id).status != 'Ready to Start' &&  c.Status == 'Ready to Start'){
                        // check all other conditions:
                        if (c.Target_End_Date__c != null && c.Target_Start_Date__c != null &&  c.Target_End_Date__c >= Date.Today()
                                && !( c.Target_Duration_Days__c == null && c.Target_Duration_Hours__c==null && c.Target_Duration_Minutes__c == null)) {


                            String milestoneTimeStampField = milestoneTimeStampMap.get(c.Milestone__c.toUpperCase());
                            if (milestoneTimeStampField != null){
                                Datetime targetDue = DateTime.newInstance(c.Target_End_Date__c, Time.newInstance(17,0,0,0)); // 5pm on that day
                                milestoneCase.put(milestoneTimeStampField, targetDue);
                            }
                        }

                    }

                    slaCaseUpdate.put(milestoneCase.Id, milestoneCase);
                }
            }
        }
        // this is used in before trigger. so there is no need to call DML on case

        // update campaign project if needed
        System.debug('#### campaign project milestone: ' + slaCaseUpdate);
        if (slaCaseUpdate.size() > 0){
            DML.save(new List<Case> (slaCaseUpdate.values()));
        }


    }


    /*******************************************************************************************************
    * @description set Ready To start timestamp , which will trigger the milestones for entitlement
    *         7/28: add the timestamp for Last_User_Assignment date
    *         7/29: add the timestamp for milestone ready time stamp
    * @param Map<Id,Case> oldCaseMap, List<Case> newCases
    * @return n/a
    * @example
    *
    */
    public static void setReadyToStartTimeStamp(Map<Id,Case> oldCaseMap, List<Case> newCases){

        Id caseWorkflowInstance = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campaign Workflow Instance').getRecordTypeId();

        for(Case c: newCases){
            if (c.RecordTypeId == caseWorkflowInstance){


                // find ready to start
                if (oldCaseMap.get(c.Id).status != 'Ready to Start' &&  c.Status == 'Ready to Start'){
                    // check all other conditions:
                    if (c.Target_End_Date__c != null && c.Target_Start_Date__c != null &&  c.Target_End_Date__c >= Date.Today()
                        && !( c.Target_Duration_Days__c == null && c.Target_Duration_Hours__c==null && c.Target_Duration_Minutes__c == null)
                            ) {
                        c.Ready_To_Start_Date__c = datetime.now();
                    }

                }

            }
        }
        // this is used in before trigger. so there is no need to call DML on case

    }


    /*******************************************************************************************************
    * @description complete milestone , based upon case status, for workflow case only
    * @param Map<Id,Case> oldCaseMap, List<Case> newCases
    * @return n/a
    * @example
    *
    */
    public static void updateCaseMilestones(Map<Id,Case> oldCaseMap, List<Case> newCases){

        Id caseWorkflowInstance = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campaign Workflow Instance').getRecordTypeId();

        Map<Id, String> progressCase = new Map<Id, String>();  // Set <Id> progressCase = new Set <Id>();   // workflow case - 2/3 milestone
        Map<Id, String> closedCase = new Map<Id, String>();  // Set <Id> closedCase = new Set <Id>();     // workflow case - due milestone
        Map<Id, String> campaignMilestoneCase = new Map<Id, String>(); // Set <Id> campaignMilestoneCase = new Set <Id>();   // campaign project case - all milestones
        for(Case c: newCases){
            if (c.RecordTypeId == caseWorkflowInstance){

                // find closed case
                if (c.IsClosed ==  true  && oldCaseMap.get(c.Id).IsClosed == false ){
                    closedCase.put(c.Id, MilestoneModel.MILESTONE_CHECKPOINT_DUE);
                    progressCase.put(c.Id, MilestoneModel.MILESTONE_CHECKPOINT_23);

                    // if the workflow case being completed is has an associated campaign milestone, update the corresponding milestone in the campaign project case as well
                    if (c.ParentId != null && String.isNotBlank(c.Milestone__c) ){
                        campaignMilestoneCase.put(c.ParentId, c.Milestone__c );
                    }
                }

                // find progress Case
                if (oldCaseMap.get(c.Id).status == 'Ready to Start' && ( c.Status != 'Ready to Start')){
                    progressCase.put(c.Id, MilestoneModel.MILESTONE_CHECKPOINT_23);
                }

                /*
                System.debug('##### old status : ' + oldCaseMap.get(c.Id).status );
                System.debug('##### new status: ' + c.Status );
                System.debug('##### old isClosed ' + oldCaseMap.get(c.Id).IsClosed );
                System.debug('##### new isClosed: ' + c.IsClosed);
                */
            }
        }

        System.debug('##### closed case: ' + closedCase);
        if (closedCase.size()> 0) {
            // make sure to close the due date milestone
            MilestoneModel.completeMilestone(closedCase, null);
        }
        // close the 2/3 milestone
        if (progressCase.size() > 0) {
            MilestoneModel.completeMilestone(progressCase,  null);
        }
        // close milestone in campaign project case
        if (campaignMilestoneCase.size() > 0) {
            MilestoneModel.completeMilestone(campaignMilestoneCase,  null);
        }


    }

    /*******************************************************************************************************
    * @description update case status for dependencies
    * @param Map<Id,Case> oldCaseMap, List<Case> newCases
    * @return n/a
    * @example
    *
    */
    public static void updateCaseStatusForDependencies(Map<Id,Case> oldCaseMap, List<Case> newCases){
        List<Case> newClosedCases = new List<Case>();
        Map<Id,String> caseIdToOrderMap = new Map<Id,String>();
        List<Id> campProjs = new List<Id>();
        List<Case> casesToUpdate = new List<Case>();
        String[] dependencies = new String[]{};
        Map<Id,String[]> dependentCaseToDependenciesMap = new Map<Id,String[]>();
        List<String> caseOrdersToBeChecked = new List<String>();
        Map<Id,Id> caseIdToCampProjId = new Map<Id,Id>();
        Map<String,Boolean> orderKeyToIsClosedMap = new Map<String,Boolean>();
        Set<Id> casesToUpdateSet = new Set<Id>();
        String ordersStringForSOQL = 'select Id, Order__c, Dependencies__c, IsClosed, Campaign_Project__c from Case where Campaign_Project__c in:campProjs and (Dependencies__c like \'%';
        for(Case c: newCases){
            if((c.RecordTypeId == Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campaign Workflow Instance').getRecordTypeId() ||
               c.RecordTypeId == Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campaign Project Approval').getRecordTypeId()) &&
               c.Campaign_Project__c != null && c.IsClosed && !oldCaseMap.get(c.Id).IsClosed){
                newClosedCases.add(c);
                caseIdToOrderMap.put(c.Id, String.valueOf(c.Order__c));
                campProjs.add(c.Campaign_Project__c);
            }
        }
        system.debug('**** caseIdToOrderMap ' + caseIdToOrderMap);
        system.debug('**** campProjs ' + campProjs);
        if(caseIdToOrderMap != null && caseIdToOrderMap.size() > 0){
            for(Id c:caseIdToOrderMap.keySet()){
                if(caseIdToOrderMap.get(c) != null && caseIdToOrderMap.get(c) != '' && caseIdToOrderMap.size() > 1){
                    ordersStringForSOQL = ordersStringForSOQL + caseIdToOrderMap.get(c) + '%\' OR Dependencies__c like \'%' ;
                }
                else if (caseIdToOrderMap.get(c) != null && caseIdToOrderMap.get(c) != '' && caseIdToOrderMap.size() == 1){
                    ordersStringForSOQL = ordersStringForSOQL + caseIdToOrderMap.get(c) + '%\'';
                }
            }
            ordersStringForSOQL = ordersStringForSOQL + ')';

            system.debug('****ordersStringForSOQL ' + ordersStringForSOQL);
            List<Case> dependentCasesList = Database.query(ordersStringForSOQL);
            Map<Id,Case> dependentCases = new Map<Id,Case>(dependentCasesList);
            system.debug('***** dependentCases ' + dependentCases);

            for(Id c:dependentCases.keySet()){
                dependencies = dependentCases.get(c).Dependencies__c.split(', ');
                if(dependencies.size() == 1){
                    dependentCases.get(c).Status = 'Ready to Start';
                    casesToUpdate.add(dependentCases.get(c));
                }
                else if(dependencies.size() > 0){
                    caseOrdersToBeChecked.addAll(dependencies);
                    dependentCaseToDependenciesMap.put(c,dependencies);
                    caseIdToCampProjId.put(c,dependentCases.get(c).Campaign_Project__c);
                }
            }
            system.debug('**** casesToUpdate ' + casesToUpdate);
            system.debug('**** caseOrdersToBeChecked ' + caseOrdersToBeChecked);
            system.debug('**** dependentCaseToDependenciesMap ' + dependentCaseToDependenciesMap);
            system.debug('****  caseIdToCampProjId ' + caseIdToCampProjId);

            if(caseOrdersToBeChecked != null && caseOrdersToBeChecked.size() > 0){
                for(Case c:[select Id,Campaign_Project__c,IsClosed,Order__c from Case where Order__c in:caseOrdersToBeChecked and Campaign_Project__c in: campProjs]){
                    String order = String.valueOf(c.Order__c);
                    orderKeyToIsClosedMap.put(String.valueOf(c.Campaign_Project__c) + order,c.IsClosed);
                }
            }
            system.debug('**** orderKeyToIsClosedMap ' + orderKeyToIsClosedMap);

            for(Id caseId:dependentCaseToDependenciesMap.keySet()){
                //String[] deps = dependentCaseToDependenciesMap.get(caseId);
                String campaignProjId = String.valueOf(caseIdToCampProjId.get(caseId));
                integer i =0;
                //system.debug('**** deps ' + deps);
                system.debug('**** dependentCaseToDependenciesMap.get(caseId) ' + dependentCaseToDependenciesMap.get(caseId));
                for(String s:dependentCaseToDependenciesMap.get(caseId)){
                    system.debug('**** campaignProjId + s ' + campaignProjId + s);
                    system.debug('**** orderKeyToIsClosedMap.get(campaignProjId + s) ' + orderKeyToIsClosedMap.get(campaignProjId + s));
                    if(!orderKeyToIsClosedMap.get(campaignProjId + s)){
                        //deps.remove(i);
                        system.debug('**** in loop for dependency case not closed');
                        break;
                    }
                    else
                        i++;
                }
                if(i == dependentCaseToDependenciesMap.get(caseId).size()){
                    casesToUpdateSet.add(caseId);
                }
            }
            system.debug('**** casesToUpdateSet ' + casesToUpdateSet);
            system.debug('**** casesToUpdate ' + casesToUpdateSet);
            for(Id c:casesToUpdateSet){
                if(dependentCases.get(c) != null){
                    dependentCases.get(c).Status = 'Ready to Start';
                    casesToUpdate.add(dependentCases.get(c));
                }
            }
            system.debug('**** casesToUpdate ' + casesToUpdateSet); 
            DML.save(casesToUpdate);
        }
        

    }
    
    /*******************************************************************************************************
    * @description 
    * @param Map<Id,Case> oldCaseMap, List<Case> newCases
    * @return n/a
    * @example
    *
    */
    
    public static map<string,string> getAnchoredTasksMapping()
    {
        map<string,string> mapAnchoredCaseMapping = new map<string,string>();
        for(case c : [select id, subject, Controlling_Anchored_Case__c,Controlling_Anchored_Case__r.subject from case 
                            where Controlling_Anchored_Case__c!=null 
                                and Controlling_Anchored_Case__r.subject!=null])
        {
            mapAnchoredCaseMapping.put(c.subject,c.Controlling_Anchored_Case__r.subject);
        }
        return mapAnchoredCaseMapping ;
    }
    
     
}