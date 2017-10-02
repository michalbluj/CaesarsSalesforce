/**
 * Created by ceezar on 04.08.2017.
 */
@isTest
private class OperationBuilderTest {

    static testMethod void test_buildOperation_CustomerInfo() {
        DataSource.QueryContext qc = new DataSource.QueryContext();
        DataSource.TableSelection ts = new DataSource.TableSelection();
        ts.tableSelected = 'caesars$customer_info';
        qc.tableSelection = ts;

        Test.startTest();
        ExternalDataSourceOperation edso = OperationBuilder.buildOperation(qc);
        Test.stopTest();

        System.assert(edso instanceof EDSCustomerInfoOperation, 'Operation should be instance of EDSCustomerInfoOperation');
    }

    static testMethod void test_buildOperation_ExtObjOp() {
        DataSource.QueryContext qc = new DataSource.QueryContext();
        DataSource.TableSelection ts = new DataSource.TableSelection();
        ts.tableSelected = 'some table';
        qc.tableSelection = ts;

        Test.startTest();
        ExternalDataSourceOperation edso = OperationBuilder.buildOperation(qc);
        Test.stopTest();

        System.assert(edso instanceof EDSExternalObjectOperation, 'Operation should be instance of EDSExternalObjectOperation');
    }

}