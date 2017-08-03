/**
 * Created by Michal Bluj on 2017-06-28.
 */

public with sharing class ExternalDataSourceTable {

    private List<DataSource.Column> columns;
    private String nameColumn;

    public ExternalDataSourceTable() {
        nameColumn = 'ExternalId';
        constructTable();
    }

    private void constructTable() {
        columns = new List<DataSource.Column>();
        columns.add(DataSource.Column.text('ExternalId', 255));
        columns.add(DataSource.Column.url('DisplayUrl'));
    }

    public List<DataSource.Column> getTableColumns() {
        return columns;
    }

    public String getNameColumn() {
        return nameColumn;
    }

}