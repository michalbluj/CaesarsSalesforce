/**
 * @author Cezary Zeleznicki
 * @date 07.08.2017
 **/

@IsTest
private class ExternalDataSourceConnectionTest {

    static testMethod void test_sync() {
        ExternalDataSourceConnection edsc = new ExternalDataSourceConnection(new DataSource.ConnectionParams());
        Test.startTest();
        List<DataSource.Table> tables = edsc.sync();
        Test.stopTest();

        System.assert(!tables.isEmpty(), 'Tables should be created');

        System.assertEquals(ExternalDataSourceUtil.retrieveSupportedTables()[0], tables[0].name,
            'Name of the first table should match first supported table');
        System.assertEquals('ExternalId', tables[0].columns[0].name, 'Column should be equal ExternalId');
        System.assertEquals('DisplayUrl', tables[0].columns[1].name, 'Column should be equal DisplayUrl');
    }

    static testMethod void test_query() {
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

        OfferSent.Record re = new OfferSent.Record();
        OfferSent os = new OfferSent();
        os.body = new List<OfferSent.Record>{re};
        String jsonBody = JSON.serialize(os);
        jsonBody = jsonBody.replace('"c_offer_id":null', '"c_offer_id":"test"');

        ExternalDataSourceConnection edsc = new ExternalDataSourceConnection(new DataSource.ConnectionParams());

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(null, null, jsonBody));
        Test.startTest();
        DataSource.TableResult tableResult = edsc.query(qc);
        Test.stopTest();

        System.assert(tableResult.success, 'Table results should be created successfully');
        System.assertEquals(tableSelection.tableSelected, tableResult.tableName, 'Table name should match requested table');
        System.assertEquals('test', (String) tableResult.rows[0].get('c_offer_id'), 'Rows of data should be populated');
    }

    static testMethod void test_getLogs() {
        Test.startTest();
        LogModel lm = ExternalDataSourceConnection.getLogs();
        Test.stopTest();

        System.assert(lm != null, 'Logs were started correctly');
    }
}