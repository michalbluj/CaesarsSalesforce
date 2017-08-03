/**
 * Created by Michal Bluj on 2017-06-28.
 */

global class ExternalDataSourceProvider extends DataSource.Provider {

    override global List<DataSource.AuthenticationCapability> getAuthenticationCapabilities() {
        List<DataSource.AuthenticationCapability> capabilities = new List<DataSource.AuthenticationCapability>();
        capabilities.add(DataSource.AuthenticationCapability.ANONYMOUS);
        return capabilities;
    }

    override global List<DataSource.Capability> getCapabilities() {
        List<DataSource.Capability> capabilities = new List<DataSource.Capability>();
        capabilities.add(DataSource.Capability.ROW_QUERY);
        capabilities.add(DataSource.Capability.SEARCH);
        return capabilities;
    }

    override global DataSource.Connection getConnection(DataSource.ConnectionParams connectionParams) {
        return new ExternalDataSourceConnection(connectionParams);
    }
}