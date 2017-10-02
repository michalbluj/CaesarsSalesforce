/**
 * @author Cezary Zeleznicki
 * @date 04.08.2017
 **/

@IsTest
private class ExternalObjectServiceTest {

    static testMethod void test_sendHttpRequest() {
        DataSource.QueryContext qc = new DataSource.QueryContext();
        DataSource.TableSelection tableSelection = new DataSource.TableSelection();
        DataSource.ColumnSelection column = new DataSource.ColumnSelection();
        column.columnName = 'Test Col';
        tableSelection.tableSelected = 'caesars$offers_sent';
        tableSelection.columnsSelected = new List<DataSource.ColumnSelection>{column};
        DataSource.Filter filter = new DataSource.Filter();
        filter.columnName = 'Test col';
        filter.columnValue = 'Test col val';
        tableSelection.filter = filter;
        qc.tableSelection = tableSelection;

        HttpRequest req = ExternalObjectService.createHttpRequest('https://test.com', qc);

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(null, null, null));
        Test.startTest();
        HttpResponse response = ExternalObjectService.sendHttpRequest(req);
        Test.stopTest();

        System.assert(response != null, 'Response correctly generated');
    }

    static testMethod void test_parseData() {
        DataSource.QueryContext qc = new DataSource.QueryContext();
        DataSource.TableSelection tableSelection = new DataSource.TableSelection();
        tableSelection.tableSelected = 'caesars$offers_sent';
        qc.tableSelection = tableSelection;

        OfferSent offer = new OfferSent();
        OfferSent.Record record = new OfferSent.Record();
        record.id = '1234';
        record.contact = '5678';
        offer.body = new List<OfferSent.Record>{record};
        String jsonBody = JSON.serialize(offer);

        Test.startTest();
        ExternalObjectInterface eoi = ExternalObjectService.parseData(jsonBody, qc);
        Test.stopTest();

        System.assert(eoi instanceof OfferSent, 'Proper class should be instantiated');
        OfferSent offerParsed = (OfferSent) eoi;
        System.assertEquals(offer.body[0].id, offerParsed.body[0].id, 'Id should be correctly parsed');
        System.assertEquals(offer.body[0].contact, offerParsed.body[0].contact, 'Contact should be correctly parsed');
    }
}