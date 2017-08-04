/**
 * Created by ceezar on 04.08.2017.
 */
@isTest
private class ExternalDataSourceUtilTest {


    static testMethod void test_constructTable(){
        List<DataSource.Table> tables = new List<DataSource.Table>();
        Set<String> supportedTableNames = new Set<String>(ExternalDataSourceUtil.retrieveSupportedTables());
        Test.startTest();
        for (String tableName : supportedTableNames) {
            tables.add(ExternalDataSourceUtil.constructTable(tableName));
        }
        Test.stopTest();

        System.assert(!tables.isEmpty(), 'Tables should be generated');
        for(DataSource.Table t : tables) {
            System.assert(supportedTableNames.contains(t.name), 'Name of the table should match supported tables');
        }
    }
}