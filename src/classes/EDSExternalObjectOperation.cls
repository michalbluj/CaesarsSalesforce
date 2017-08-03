/**
 * Created by Michal Bluj on 2017-07-12.
 */

public with sharing class EDSExternalObjectOperation implements ExternalDataSourceOperation{

    public List<Map<String, Object>> query(DataSource.QueryContext context) {
        HttpRequest req = ExternalObjectService.createHttpRequest(HKUEndpoint.getGenericExternalObjectEndpoint(),context);
        HttpResponse res = ExternalObjectService.sendHttpRequest(req);
        ExternalObjectInterface response = ExternalObjectService.parseData(res.getBody(),context);
        return populateResponseData(response,context);
    }

    public List<DataSource.TableResult> search(DataSource.SearchContext context) {
        List<DataSource.TableResult> results = new List<DataSource.TableResult>();
        return results;
    }

    public List<Map<String, Object>> populateResponseData(ExternalObjectInterface response,DataSource.QueryContext context) {
        List<Map<String, Object>> rows = new List<Map<String, Object>>();
        rows = response.populateData(rows);
        return rows;
    }

}