/**
 * Created by ceezar on 03.08.2017.
 */
@isTest
private class GuestHotelActivityVedwTest {

    static testMethod void populateDataTest() {

        GuestHotelActivityVedw.Record dataRecord = new GuestHotelActivityVedw.Record();
        dataRecord.id = '1234';

        GuestHotelActivityVedw wrapper = new GuestHotelActivityVedw();
        wrapper.body = new List<GuestHotelActivityVedw.Record>{dataRecord};

        Test.startTest();
        List<Map<String, Object>> rows = wrapper.populateData(new List<Map<String, Object>>());
        Test.stopTest();

        for(Map<String, Object> row : rows) {
            System.assertEquals((String) row.get('id'), '1234');
            System.assertEquals((String) row.get('ExternalId'), '1234');
            System.assertEquals((String) row.get('DisplayUrl'), '1234');
        }
    }
}