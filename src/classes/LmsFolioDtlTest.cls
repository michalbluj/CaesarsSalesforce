@isTest
private class LmsFolioDtlTest {
    
    static testMethod void populateDataTest() {
        LmsFolioDtl eObject = new LmsFolioDtl();
        LmsFolioDtl.Record record = new LmsFolioDtl.Record();
        record.id = '1234';
        eObject.body = new List<LmsFolioDtl.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');
    }
}