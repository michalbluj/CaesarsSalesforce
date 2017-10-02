/**
 *  @author Ivan Yeung
 *  @date 7/22/17
 *  @group Entitlement
 *  @description  The implementation of Support.MilestoneTriggerTimeCalculator interface to support the calcuation of the milestone trigger time
 */


global with sharing class CaseWorkflowStdMilestoneTimeCalculator implements Support.MilestoneTriggerTimeCalculator  {



    /*******************************************************************************************************
    * @description implmentation of interface's calculateMilestoneTriggerTime
    * @param String caseId, String milestoneTypeId
    * @return the milestone time in term of minutes
    *
    */
    global Integer calculateMilestoneTriggerTime(String caseId, String milestoneTypeId){


        Case c = [SELECT Ready_To_Start_Date__c, Target_Start_Date__c, Target_End_Date__c, Target_Duration_Days__c, Target_Duration_Hours__c, Target_Duration_Minutes__c FROM Case WHERE Id=:caseId];
        MilestoneType mt = [SELECT Name FROM MilestoneType WHERE Id=:milestoneTypeId];

        Integer milestoneTime = 0;

        // for milestone due and milestone 2/3, the main reference point is the target due date
        if (mt != null && mt.Name != null){
            if (mt.Name.equals(MilestoneModel.MILESTONE_CHECKPOINT_23)  ||mt.Name.equals(MilestoneModel.MILESTONE_CHECKPOINT_DUE)  ) {
                milestoneTime = milestoneTimeByDueDate(c, mt);
            } else if ( mt.Name.equals(MilestoneModel.MILESTONE_WORKFLOW_SLA)) {
                milestoneTime = milestoneTimeByDuration(c, mt);
            }
        }


        return  milestoneTime;

    }

    /*******************************************************************************************************
    * @description calcuate milestone time by duration
    * @param Case, MilestoneType
    * @return the milestone time in term of minutes
    *
    */
    private Integer milestoneTimeByDuration( Case c,  MilestoneType mt) {

        Integer milestoneTime = 0;

        Decimal durationDays =0;
        Decimal durationHours = 0;
        Decimal durationMinutes = 0;

        if (c != null ) {
            if (c.Target_Duration_Days__c != null) {
                durationDays = c.Target_Duration_Days__c;
            }
            if (c.Target_Duration_Hours__c != null) {
                durationHours = c.Target_Duration_Hours__c;
            }
            if (c.Target_Duration_Minutes__c != null) {
                durationMinutes = c.Target_Duration_Minutes__c;
            }

            milestoneTime = (durationDays * 8 * 60 + durationHours * 60 + durationMinutes).intValue();

        }

        return milestoneTime;

    }


    /*******************************************************************************************************
    * @description calcuate milestone time by due date
    * @param Case, MilestoneType
    * @return the milestone time in term of minutes
    *
    */
    private Integer milestoneTimeByDueDate(Case c, MilestoneType mt){

        Integer milestoneTime = 0;

        Decimal percentageOfDuration = 1;
        // three milestones: 2/3 Checkpoint and  Due, SLA
        // to do: use custom metadata type for the milestone type and calculation mapping
        if (mt.Name.equals(MilestoneModel.MILESTONE_CHECKPOINT_23)) {
            percentageOfDuration =  0.66;
        } else if (mt.Name.equals(MilestoneModel.MILESTONE_CHECKPOINT_DUE) || mt.Name.equals(MilestoneModel.MILESTONE_WORKFLOW_SLA)) {
            percentageOfDuration = 1;  // SLA and due milestone calcuation is the same. the main difference is the reference point
        }

        Decimal durationDays =0;
        Decimal durationHours = 0;
        Decimal durationMinutes = 0;
        Datetime dueDateTime;
        Datetime targetDue;



        if (c != null && BusinessHourUtil.caesarsBusinessWeek != null ){
            if (c.Target_Duration_Days__c != null){
                durationDays =   c.Target_Duration_Days__c;
            }
            if (c.Target_Duration_Hours__c != null){
                durationHours =   c.Target_Duration_Hours__c;
            }
            if (c.Target_Duration_Minutes__c != null){
                durationMinutes =   c.Target_Duration_Minutes__c;
            }
            if (c.Target_End_Date__c != null){

                //  for the target end date, we translate to 5pm, local user time
                targetDue = DateTime.newInstance(c.Target_End_Date__c, Time.newInstance(17,0,0,0)); // 5pm on that day

                System.debug('#### Target_End_Date__c: ' + c.Target_End_Date__c );
                System.debug('#### targetDue: ' + targetDue );

                Integer intervalMilliseconds = ( BusinessHourUtil.durationInMs(durationDays, durationHours, durationMinutes)  * (1-percentageOfDuration) ).intValue();
                System.debug('#### offset in milliseconds : ' + intervalMilliseconds );

                // calculate the offer date with business hours, in local user time
                System.debug('#### business hours: ' + BusinessHourUtil.caesarsBusinessWeek);

                dueDateTime = BusinessHours.add(BusinessHourUtil.caesarsBusinessWeek.Id , targetDue, -(intervalMilliseconds));

                System.debug('#### dueDateTime from offset : ' + dueDateTime );

                //  finally calculate the milestones, in business hours, in unit of minutues
                // SLA enter milestone when the ownership changed
                // due when it is first set to ready to start.
                milestoneTime = (BusinessHours.diff(BusinessHourUtil.caesarsBusinessWeek.Id ,  Datetime.now(), dueDateTime) / (60 *1000)) .intValue();

                System.debug('#### milestone in min: ' + milestoneTime );


            }
        }


        // System.debug('#### durationDays: ' + durationDays );
        System.debug('#### durationHours: ' + durationHours );
        System.debug('#### durationMinutes: ' + durationMinutes );
        System.debug('#### percentageOfDuration: ' + percentageOfDuration );


        return milestoneTime;

    }



}