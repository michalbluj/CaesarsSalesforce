public class AssignToMeController {
    public static List<Case> cs = new List<Case>();
    @AuraEnabled
    public static Boolean updateCaseOwner(string CaseId) {
        cs = [select id, ownerID from case where id=:CaseId];
        If(cs.size()>0){
            cs[0].ownerid = UserInfo.getUserId();
        }
        update cs;
        return true;
    }
    
    @AuraEnabled
    public static Boolean updateCaseStatus(string CaseId) {
        cs = [select id, ownerID,status from case where id=:CaseId];
        If(cs.size()>0){
            cs[0].Status = 'Closed';
        }
        update cs;
        return true;
    }
    
}