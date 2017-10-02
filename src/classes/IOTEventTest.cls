/**
 * Created by Patryk Lompart on 2017-08-14.
 */

@IsTest
private class IOTEventTest {

	static testMethod void populateDataTest() {

		IOTEvent eObject = new IOTEvent();
		IOTEvent.Record record = new IOTEvent.Record();
		record.id = '1234';
		eObject.body = new List<IOTEvent.Record>{record};

		List<Map<String, Object>> rows = new List<Map<String, Object>>();

		Test.startTest();
		rows = eObject.populateData(rows);
		Test.stopTest();

		System.assertEquals((String)rows.get(0).get('id'),'1234');

	}

}