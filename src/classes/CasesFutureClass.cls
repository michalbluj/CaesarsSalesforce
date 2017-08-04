global class CasesFutureClass
{
    public static boolean firstRun = true;
    @future
    public static void FutureMethodToAssociateAnchoredCases(set<string> projectIDs, map<string,string> mapAchoredTasks, set<string> caseIDs)
    {   
             
          
             // Perform some operations
             map<string, string> mapParentAnchoredTask = new map<string, string>();
             set<string> setAnchoredSubject = new set<string>();
            if(mapAchoredTasks.values().size()>0)
            {
                setAnchoredSubject.addall(mapAchoredTasks.values());
            }
            system.debug('setAnchoredSubject'+setAnchoredSubject);
            system.debug('projectIDs'+projectIDs);
            map<id,case> mapAnchoredCases = new map<id,case>();
            for (case ac : [select id, 
                                subject,
                                Campaign_Project__c,
                                Controlling_Anchored_Case__c,
                                Controlling_Anchored_Case__r.subject ,
                                Target_Start_Date__c,
                                Target_End_Date__c,
                                Target_Duration_Minutes__c,
                                Target_Duration_Hours__c,
                                Target_Duration_Days__c,
                                Successor_Task_To_Anchored_Case__c,
                                Predecessor_Task_To_Anchored_Case__c,
                                Anchored__c 
                                from 
                                case 
                                where subject!=null 
                                and Campaign_Project__c=:projectIDs and subject =:setAnchoredSubject
                                ])
                                
             {
                system.debug('id is'+ac.id);
                mapParentAnchoredTask.put(ac.subject +'$%'+ac.Campaign_Project__c,ac.id); 
                 mapAnchoredCases.put(ac.id,ac); 
             }
             
             list<case> CaselstToUpdate = new list<case>();
             for(case f : [select id, 
                                subject,
                                Campaign_Project__c,
                                Controlling_Anchored_Case__c,
                                Controlling_Anchored_Case__r.subject ,
                                Target_Start_Date__c,
                                Target_End_Date__c,
                                Target_Duration_Minutes__c,
                                Target_Duration_Hours__c,
                                Target_Duration_Days__c,
                                Successor_Task_To_Anchored_Case__c,
                                Predecessor_Task_To_Anchored_Case__c,
                                Anchored__c    from case where id=:caseIDs and Campaign_Project__c=:projectIDs and subject =:mapAchoredTasks.keyset()
                                 order by subject desc])
             {
                if(mapAchoredTasks!=null && mapAchoredTasks.get(f.subject)!=null )
                {
                    if ( mapParentAnchoredTask !=null && 
                            mapParentAnchoredTask.get((mapAchoredTasks.get(f.subject)+'$%'+f.Campaign_Project__c)) != null 
                    ){
                        
                        f.Controlling_Anchored_Case__c = mapParentAnchoredTask.get((mapAchoredTasks.get(f.subject)+'$%'+f.Campaign_Project__c));
                        if(f.Controlling_Anchored_Case__c!=null && mapAnchoredCases!=null &&mapAnchoredCases.get(f.Controlling_Anchored_Case__c)!=null )
                        {
                            if(mapAnchoredCases.get(f.Controlling_Anchored_Case__c).Target_Start_Date__c!=null)
                            {
                                system.debug('st date is'+mapAnchoredCases.get(f.Controlling_Anchored_Case__c).Target_Start_Date__c);
                                f= AnchoredDateUtil(mapAnchoredCases.get(f.Controlling_Anchored_Case__c),f) ; //only update when Target_Start_Date__c is not empty
                            }
                            
                        }
                        CaselstToUpdate.add(f);
                    }
                }      
                 
             }
             
             if(CaselstToUpdate.size()>0)
             {
                update CaselstToUpdate;
             }
    }
     @future
    public static void UpdateCaseTargetEndDates(set<id> caseIds,set<id> projectIds){
    
        list<case> casesToBeUpdated = new List<case>();
        
        map<id,Datetime> mapTargetDue = new map<id,Datetime>();
        for(case cs: [select id,subject,
                                Target_Start_Date__c,
                                Target_End_Date__c,
                                Target_Duration_Minutes__c,
                                Target_Duration_Hours__c,
                                Target_Duration_Days__c,
                                Successor_Task_To_Anchored_Case__c,
                                Predecessor_Task_To_Anchored_Case__c,
                                Anchored__c,(select id,subject,
                                Target_Start_Date__c,
                                Target_End_Date__c,
                                Target_Duration_Minutes__c,
                                Target_Duration_Hours__c,
                                Target_Duration_Days__c,
                                Successor_Task_To_Anchored_Case__c,
                                Predecessor_Task_To_Anchored_Case__c,
                                Anchored__c from ControllingAnchored__r order by subject desc)                                
                                from  case where recordtype.name = 'Campaign Workflow Instance' and id=:caseIds
                        
                        
          ])
          {
              system.debug('id cs'+cs.id+'parent start date'+cs.Target_Start_Date__c);
              date TargSt = cs.Target_Start_Date__c;
              date TargEn= cs.Target_End_Date__c; 
              for(case inC:cs.ControllingAnchored__r ){
                   inC= AnchoredDateUtil(cs,inC); 
                   casesToBeUpdated.add(inc);

              }
          }
          
          if(casesToBeUpdated.size()>0)
          {
              update casesToBeUpdated;
          }
          
        
    }
    public static map<id,Datetime> mapTargetDue;
    // @param- parent case, case
    public static case AnchoredDateUtil(case cs , case inC)
    {
                   firstRun = false; 
                   if(mapTargetDue==null)
                    {
                        mapTargetDue = new map<id,Datetime>();
                    } 
                    //map<id,Datetime> mapTargetDue = new map<id,Datetime>();
                    
                    system.debug('id cs'+cs.subject);  
                    Decimal percentageOfDuration = 1;
                    Decimal durationDays =0;
                    Decimal durationHours = 0;
                    Decimal durationMinutes = 0;
                    Datetime targetDue;
                    Datetime targetEndDue;
                  //add days
                   if (inC.Target_Duration_Days__c != null){
                      durationDays =inc.Target_Duration_Days__c; 
                   }
                  
                  // add hours
                   if (inC.Target_Duration_Hours__c != null){
                      durationHours =inc.Target_Duration_Hours__c ;
                   }
                  
                   //add mins
                  if (inC.Target_Duration_Minutes__c != null){  
                      durationMinutes =inc.Target_Duration_Minutes__c ;
                  }
                  
                  system.debug('subj_--->'+inc.subject+'>>  days   <<'+inc.Target_Duration_Days__c +'>>  hours<<'+inc.Target_Duration_Hours__c +'>>  mins<<'+inc.Target_Duration_Minutes__c+'..id  '+inc.id);
                  Integer intervalMilliseconds = ( BusinessHourUtil.durationInMs(durationDays, durationHours, durationMinutes));
                  system.debug('intervalMilliseconds '+intervalMilliseconds);
                  if(mapTargetDue!=null && mapTargetDue.get(cs.id)!=null)
                  {                      
                      targetEndDue = mapTargetDue.get(cs.id);
                      targetDue = BusinessHours.add(BusinessHourUtil.caesarsBusinessWeek.Id , mapTargetDue.get(cs.id),(inC.Predecessor_Task_To_Anchored_Case__c==false) ? -(intervalMilliseconds): (intervalMilliseconds) );
                       mapTargetDue.put(cs.id,targetDue );
                  }else{
                      targetDue = BusinessHours.add(BusinessHourUtil.caesarsBusinessWeek.Id , DateTime.newInstance(cs.Target_Start_Date__c, Time.newInstance(17,0,0,0)), (inC.Predecessor_Task_To_Anchored_Case__c==false) ? -(intervalMilliseconds): (intervalMilliseconds) );
                      //DateTime.newInstance(cs.Target_End_Date__c, Time.newInstance(17,0,0,0)); // 5pm on that day
                      targetEndDue = DateTime.newInstance(cs.Target_Start_Date__c, Time.newInstance(17,0,0,0));
                      system.debug('begin loop');
                      mapTargetDue.put(cs.id,targetDue );
                      
                  }
                   
                  if(targetDue!=null)
                  {
                      inc.Target_End_Date__c= targetEndDue.date();
                      inc.Target_Start_Date__c = targetDue.date();
                      system.debug('subj_--->'+inc.subject+'>>Date<<'+inc.Target_Start_Date__c+'  In Seconds   -->'+targetDue+'   util;  '+targetDue.format());
                  }
                  
                  return inc;
                 // Integer intervalMilliseconds = ( BusinessHourUtil.durationInMs(durationDays, durationHours, durationMinutes)  * (1-percentageOfDuration) ).intValue();

              
    }
}