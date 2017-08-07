/**
 * Created by Michal Bluj on 2017-06-28.
 */

global class ExternalDataSourceConnection extends DataSource.Connection
{
    private static LogModel logs;
    @testVisible
    private static LogModel getLogs() {
        if (logs == null) {
            logs = LogModel.startLog('ExternalDataSourceConnection', 'Exception', LogModel.LOG_CATEGORY_APEX);
        }
        return logs;
    }

    global ExternalDataSourceConnection(DataSource.ConnectionParams connectionParams) {}

    override global List<DataSource.Table> sync() {
        List<DataSource.Table> tables = new List<DataSource.Table>();
        for (String tableName : ExternalDataSourceUtil.retrieveSupportedTables()) {
            tables.add(ExternalDataSourceUtil.constructTable(tableName));
        }
        return tables;
    }

    override global DataSource.TableResult query(DataSource.QueryContext context) {
        ExternalDataSourceOperation operation = OperationBuilder.buildOperation(context);
        List<Map<String, Object>> result = operation.query(context);
        return DataSource.TableResult.get(context, result);
    }

    override global List<DataSource.TableResult> search(DataSource.SearchContext context) {
        List<DataSource.TableResult> result = OperationBuilder.buildOperation(context).search(context);
        return result;
    }

}