@isTest
private class LmsFolioHdrTest {
	
	static testMethod void populateDataTest() {
		LmsFolioHdr eObject = new LmsFolioHdr();
        LmsFolioHdr.Record record = new LmsFolioHdr.Record();
        record.id = '1234';
        eObject.body = new List<LmsFolioHdr.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');
	}
	
}