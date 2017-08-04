/**
 * Created by ceezar on 04.08.2017.
 */
@isTest
private class EDSCustomerInfoOperationTest {

    static testMethod void test_query() {
        DataSource.QueryContext qc = new DataSource.QueryContext();
        DataSource.TableSelection tableSelection = new DataSource.TableSelection();
        DataSource.Filter filter = new DataSource.Filter();
        filter.columnName = 'Test col';
        filter.columnValue = 'Test col val';
        tableSelection.filter = filter;
        qc.tableSelection = tableSelection;

        CustomerInfo.CustomerInfoData cid = new CustomerInfo.CustomerInfoData();
        cid.c_quality_cd = 'quality_cd_test';
        CustomerInfo ci = new CustomerInfo();
        ci.data = cid;
        ci.recordType = 'Acquisition';
        CustomerInfoResponse cir = new CustomerInfoResponse();
        cir.timestamp = '1999-03-23';
        cir.body = new List<CustomerInfo>{ci};

        String body = JSON.serialize(cir);

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(null, null, body));
        Test.startTest();
        EDSCustomerInfoOperation ecio = new EDSCustomerInfoOperation();
        List<Map<String, Object>> results = ecio.query(qc);
        Test.stopTest();

        System.assertEquals('quality_cd_test', (String) results[0].get('quality_cd'), 'Value should be populated correctly');
    }

    static testMethod void test_search() {
        DataSource.SearchContext sc = new DataSource.SearchContext();

        CustomerInfo.CustomerInfoData cid = new CustomerInfo.CustomerInfoData();
        cid.c_quality_cd = 'quality_cd_test';
        CustomerInfo ci = new CustomerInfo();
        ci.data = cid;
        ci.recordType = 'Acquisition';
        CustomerInfoResponse cir = new CustomerInfoResponse();
        cir.timestamp = '1999-03-23';
        cir.body = new List<CustomerInfo>{ci};

        String body = JSON.serialize(cir);

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(null, null, body));
        Test.startTest();
        EDSCustomerInfoOperation ecio = new EDSCustomerInfoOperation();
        List<DataSource.TableResult> results = ecio.search(sc);
        Test.stopTest();

        //currently method search returns empty list
        System.assert(results.isEmpty(), 'List should be empty');
    }
}