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
            System.assertEquals('1234', (String) row.get('ExternalId'));
            System.assertEquals('1234', (String) row.get('DisplayUrl'));
        }
    }
}