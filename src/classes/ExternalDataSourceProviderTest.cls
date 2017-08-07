/**
 * Created by ceezar on 04.08.2017.
 */
@isTest
private class ExternalDataSourceProviderTest {

    static testMethod void test_getAuthenticationCapabilities() {
        ExternalDataSourceProvider edsp = new ExternalDataSourceProvider();

        Test.startTest();
        List<DataSource.AuthenticationCapability> caps = edsp.getAuthenticationCapabilities();
        Test.stopTest();

        System.assertEquals(DataSource.AuthenticationCapability.ANONYMOUS, caps[0], 'Should contain anonymous capability');
    }

    static testMethod void test_getCapabilities() {
        ExternalDataSourceProvider edsp = new ExternalDataSourceProvider();

        Test.startTest();
        List<DataSource.Capability> caps = edsp.getCapabilities();
        Test.stopTest();

        System.assertEquals(DataSource.Capability.ROW_QUERY, caps[0], 'Should contain ROW_QUERY capability');
    }

    static testMethod void test_getConnection() {
        DataSource.ConnectionParams conParams = new DataSource.ConnectionParams();
        ExternalDataSourceProvider edsp = new ExternalDataSourceProvider();

        Test.startTest();
        DataSource.Connection connection = edsp.getConnection(conParams);
        Test.stopTest();

        System.assert(connection instanceof ExternalDataSourceConnection, 'Proper class should be returned');
    }
}