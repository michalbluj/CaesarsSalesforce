/**
* @author         Benjamin Lau    
* @date           01/06/2016
* @description    Unit test class for LogModel
* @group          Test
**/
@IsTest
private class LogModelTest {

    @IsTest
    public static void unitTest_Basic() {

        LogModel log = LogModel.startLog('LogModelTest', 'Unit Test');
        System.assertEquals(null, log.logId);

        log.addErrorLog('Error Message');
        log.addSummaryLog('Summary Message');
        log.addLog('A long.......................................................................................................................................................................................................................................................................... Message'); // long message

        Account acc = AccountBuilder.buildAccount().withName('TestAcc').get();
        insert acc;

        log.addLog('New Account added', acc.Id);

        log.endLog();

        System.assertNotEquals(null, log.logId);

        LogModel.clearLog();

    }

    @IsTest
    public static void unitTest_Exception() {
        LogModel log = LogModel.startLog('ModelTest');
        try {
            Account a = AccountBuilder.buildAccount().get();
            insert a;
        } catch (Exception e){
            log.addExceptionLog(e);
        }
        LogModel.clearLog(1);
    }

    @IsTest
    public static void unitTest_Advance() {
        LogModel log = LogModel.startLog('LogModelTest', 'Unit Test',  LogModel.LOG_CATEGORY_INBOUND_WEBSERVICE);
        System.assertEquals(null, log.logId);
        log.addLog('LogModelTest', 'Test Error Message2', LogModel.LOG_TYPE_ERROR) ;
        LogModel.clearLog('LogModelTest');
    }

    @isTest 
    public static void  unitTest_SingleLog(){
        LogModel.singleLog('unitTest Class', 'This is a very long................................................................................................................................................................................................................................................Test Message', LogModel.LOG_CATEGORY_APEX);
    }

}