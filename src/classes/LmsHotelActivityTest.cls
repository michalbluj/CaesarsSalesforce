@isTest
private class LmsHotelActivityTest {
	
	static testMethod void populateDataTest() {
		LmsHotelActivity eObject = new LmsHotelActivity();
        LmsHotelActivity.Record record = new LmsHotelActivity.Record();
        record.id = '1234';
        eObject.body = new List<LmsHotelActivity.Record>{record};

        List<Map<String, Object>> rows = new List<Map<String, Object>>();

        Test.startTest();
        rows = eObject.populateData(rows);
        Test.stopTest();

        System.assertEquals((String)rows.get(0).get('ExternalId'),'1234');
	}

}