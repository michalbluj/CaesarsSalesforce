/**
 * Created by iyeung on 7/30/17.
 */

public with sharing class CaseUpdateQueueable implements  Queueable{

private List <Case> cases;

public caseUpdateQueueable(List <Case> records ){
this.cases = records;
}

public void execute(QueueableContext context){
DML.save(cases);
}

}