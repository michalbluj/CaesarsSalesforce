public with sharing class ProformaModel {

    public static final  id CampaignProjectProforma= Schema.SObjectType.Proforma__c.getRecordTypeInfosByName().get('Campaign Project Proforma').getRecordTypeId();
  public static void AssociateProformaToCase(Map<Id,Proforma__c> oldCProformaMap, 
                                            List<Proforma__c> newcProformaLst)
    {

        map<id,Proforma__c> proformaCampaignMap = new map<id,Proforma__c>();
        set<id> cpIds = new set<id>();  
        for(Proforma__c pf : newcProformaLst)
        {
            //cehck to see if the campaign project id has changed for Campaign Project Proforma RT
            // check for approved proformas 
            // check for rejected projormas 
            // check for submitted for approval proformas 
            system.debug('The proforma rec is'+pf+'   rec name is  >>'+pf.recordtype.name+'>>>>> Status is <<<<'+ pf.Status__c);
            if(
                    pf.recordtypeid == CampaignProjectProforma
                    && 
                    pf.Campaign_Project__c!=null 
                    &&
                    (
                        (
                            oldCProformaMap!=null 
                            &&
                            (
                                ( 
                                    oldCProformaMap.get(pf.id)!=null 
                                    &&
                                    oldCProformaMap.get(pf.id).Campaign_Project__c!=null 
                                    &&
                                    oldCProformaMap.get(pf.id).Campaign_Project__c!= pf.Campaign_Project__c
                                )
                                ||
                                (   
                                    pf.Status__c!='' 
                                    && 
                                    pf.Status__c!= oldCProformaMap.get(pf.id).status__C 
                                    && 
                                    pf.Status__c != 'Draft' 
                                )
                            )
                        )
                        
                        ||
                        
                        (
                            oldCProformaMap==null 
                        )
                        
                    )
                )
                {
                    cpIds.add(pf.Campaign_Project__c);
                    /*it is agreed that a campaign project would have only one proforma{RT - Campaign Project Proforma }
                     associated , that is the reason we are using a map<id,id> and not map<id,list<id>> */
                    // add to a map of (campaignprojectID, Proforma__C)
                    proformaCampaignMap.put(pf.Campaign_Project__c,pf);
                    
                    system.debug('is a campaign project proforma'+pf.Campaign_Project__c);
                    
                }
        }
        
        // inner query to find the campaign project and Associated proforma case 
        list<case> casesToUpdate = new list<case>();// these are the cases which will be updated
        
        
            for(Campaign_Project__c cp:[select id,
                                        ( select 
                                            id,
                                            Campaign_Project__c,
                                            subject,
                                            status,
                                            Approval_Case__c,
                                            Project_Type__c,
                                            Associated_Proforma__c 
                                            from 
                                            Cases__r 
                                            where recordtype.name ='Campaign Workflow Instance'  and subject LIKE '%Approve Pro Forma%'
                                        )  
                                        from Campaign_Project__c where id=:proformaCampaignMap.keyset()
                                    ]
            )
            {
                system.debug('the cp quey and inner query is '+cp);
                for(case c : cp.Cases__r )
                {
                    system.debug('the case is '+c.id);
                    if(c.Approval_Case__c == true)
                    {
                        CheckForUpdates cfu = updateProformaDetailsOnCase(c,proformaCampaignMap);
                        system.debug('the cfu wrapper is'+cfu);
                        if(cfu.isUpdate)
                        {
                                if(cfu.mycase.status=='Approved')
                                {
                                    cfu.mycase.status='Completed';
                                }
                                //cfu.mycase.recordtypeid= CampaignProjectProforma;
                                system.debug('the cfu wrapper, my case variable is'+cfu.mycase);
                                casesToUpdate.add(cfu.mycase);
                                  
                        }
                    }
                }
            }
        
        if(casesToUpdate.size()>0)
        {
            system.debug('casesToUpdate list size is >>>>>> '+casesToUpdate.size()+' >> the casesToUpdate is'+casesToUpdate); 
            update casesToUpdate; // update the cases 
        }
        
    }
    
    public static CheckForUpdates updateProformaDetailsOnCase(case c , map<id,Proforma__c> proformaCampaignMap){
        
        system.debug('reached updateProformaDetailsOnCase METHOD >>>>>> Case is '+c+' >> the proformaCampaignMap is'+proformaCampaignMap);     
        boolean b; 
        if((c.Project_Type__c=='' || c.Project_Type__c=='Campaign Project'))
        {
             
            c.Project_Type__c = 'Proforma';
            b= true;
        }
        
        if(proformaCampaignMap!=null 
                && 
                proformaCampaignMap.get(c.Campaign_Project__c)!=null 
                && c.Associated_Proforma__c ==null 
                ){
            
            c.Associated_Proforma__c = proformaCampaignMap.get(c.Campaign_Project__c).id;
            b= true;
            
        }
        
         if(proformaCampaignMap!=null 
                && proformaCampaignMap.get(c.Campaign_Project__c)!=null
                && proformaCampaignMap.get(c.Campaign_Project__c).status__c != c.status ){
                
                
                c.status = proformaCampaignMap.get(c.Campaign_Project__c).status__c;
                
                b= true;
                system.debug('proformaCampaignMap.get(c.Campaign_Project__c).status__c is '+proformaCampaignMap.get(c.Campaign_Project__c).status__c);     
                
            } 
            
            CheckForUpdates cfu = new CheckForUpdates();
            if(b)
            {
                cfu.mycase= c; 
                cfu.isUpdate = b; 
                return cfu;
            }else{
                cfu.isUpdate = b;
                return cfu;
            }
              
    }  
    
    public class CheckForUpdates{
            public case mycase {get;set;}
            public boolean isUpdate {get;set;}
    }
}