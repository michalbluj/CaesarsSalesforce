/**
 * Created by Michal Bluj on 2017-07-12.
 */

public with sharing class OperationBuilder {

    private static ExternalDataSourceOperation customerOperation = new EDSCustomerInfoOperation();
    private static ExternalDataSourceOperation externalObjectOperation = new EDSExternalObjectOperation();

    public static ExternalDataSourceOperation buildOperation(DataSource.QueryContext context){
        DataSource.TableSelection tableSelection = context.tableSelection;
        return tableSelection.tableSelected == 'caesars$customer_info' ? customerOperation : externalObjectOperation;
    }

    public static ExternalDataSourceOperation buildOperation(DataSource.SearchContext context){
        List<DataSource.TableSelection> tableSelections = context.tableSelections;
        ExternalDataSourceOperation operation = externalObjectOperation;
        if(tableSelections.size() == 1){
            if(tableSelections.get(0).tableSelected == 'caesars$customer_info'){
                operation = customerOperation;
            }
        }
        return operation;
    }

}