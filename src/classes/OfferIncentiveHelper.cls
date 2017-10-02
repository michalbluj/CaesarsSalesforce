public class OfferIncentiveHelper
{
    public static void OfferIncentiveUpdates(list<Offer_Incentive__c> OfferIncentiveLst)
    {
        set<string> projectIds = new set<string> ();
        for(Offer_Incentive__c oi:OfferIncentiveLst)
        {
            
            if(oi.Project_Campaign_Offer_Redemption_Key__c!=null && 
                oi.Project_Campaign_Offer_Redemption_Key__c.substringAfter('$<id>$')=='HasValues'
                && oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$')!='NoProject')
            {
                system.debug('adding to pid set'+oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$'));
                projectIds.add(oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$'));
            }
           // 
        }
        map<string,string> mapprojectRedemptionChannel = new map<string,string> ();
        system.debug('pid are'+projectIds);
        if(projectIds.size()>0)
        {
            for( Campaign_Project__c cp:[select id, Redemption_Channel__c,Campaign_Redemption_Channel__c   from Campaign_Project__c where id=:projectIds])
            {
                 system.debug(cp.id+' <<id >> Redemption >>'+cp.Redemption_Channel__c);
                mapprojectRedemptionChannel.put( String.valueOf(cp.id).substring(0, 15),cp.Campaign_Redemption_Channel__c);
                
            }
        }
        
        for(Offer_Incentive__c oi:OfferIncentiveLst)
        {
            if(oi.Redemption_Channel__c !=null)
            {
                if( oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$')!='NoProject'&& mapprojectRedemptionChannel!=null
                    && mapprojectRedemptionChannel.get(oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$'))!=null )
                {
                    if(oi.Redemption_Channel__c.contains(';'))
                    {
                        if(isValidSelection(oi.Redemption_Channel__c.split(';'),mapprojectRedemptionChannel.get(oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$'))))
                        {
                            continue;
                        }else{
                            oi.adderror('match with Projects Redemption Values ');
                        }
                    }else{
                        list<string> lsts= new list<string>();
                        lsts.add(oi.Redemption_Channel__c);
                        if(isValidSelection(lsts,mapprojectRedemptionChannel.get(oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$'))))
                        //if(mapprojectRedemptionChannel.get(oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$')).contains(oi.Redemption_Channel__c))
                       // if(oi.Redemption_Channel__c.contains(mapprojectRedemptionChannel.get(oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$'))))
                        {
                            continue;
                        }else{
                            system.debug(mapprojectRedemptionChannel.get(oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$')));
                            oi.adderror('Should match with Projects Redemption Values ');
                        }
                    }
                    //if(isValidSelection())
                }else{
                    system.debug('no proj'+oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$'));
                    oi.adderror('It Looks like their is no Campaign project Associated, so you may not add a value to Redemption Channel');
                }
                
                
            }else{
                system.debug('check>');
                if( oi.Project_Campaign_Offer_Redemption_Key__c!=null && 
                oi.Project_Campaign_Offer_Redemption_Key__c.substringAfter('$<id>$')=='HasValues'
                && oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$')!='NoProject')
                {
                    system.debug('a >');
                    if(mapprojectRedemptionChannel!=null && mapprojectRedemptionChannel.get(oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$'))!=null)
                    system.debug('aa>');
                    oi.Redemption_Channel__c = mapprojectRedemptionChannel.get(oi.Project_Campaign_Offer_Redemption_Key__c.substringBefore('$<id>$')) ;
                }
            }
            
            
        }
        
    
    }
    
     public static Boolean isValidSelection(list<string> SelectedPicklists, String projectRedeptionValue){

        for(String eachInterest : SelectedPicklists){
            //if(a=a){}
            system.debug('eachInterest'+eachInterest );
            if(!projectRedeptionValue.containsIgnoreCase(eachInterest)){
                return false;

            }

        }

        return true;

    }
    
    

}