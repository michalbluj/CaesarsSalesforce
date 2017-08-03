/**
 * Created by Michal Bluj on 2017-06-28.
 */

public with sharing class CustomerInfoService {

    public static HttpRequest createHttpRequest(String endpoint,DataSource.QueryContext context){
        HttpRequest req = createHttpRequest();
        req.setBody(buildQueryBody(context));
        req.setEndpoint(endpoint);
        return req;
    }

    public static HttpRequest createHttpRequest(String endpoint,DataSource.SearchContext context){
        HttpRequest req = createHttpRequest();
        req.setEndpoint(endpoint);
        return req;
    }

    private static String buildQueryBody(DataSource.QueryContext context){
        DataSource.TableSelection tableSelection = context.tableSelection;
        DataSource.Filter filter = tableSelection != null ? tableSelection.filter : null;
        String body = '';
        if(filter != null && (filter.columnName != null && filter.columnValue != null || !filter.subfilters.isEmpty())) {
            body = '{"header" : "","body" : '+JSON.serializePretty(filter)+'}';
        }
        return body;
    }

    private static HttpRequest createHttpRequest(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setTimeout(60000);
        return req;
    }

    public static HttpResponse sendHttpRequest(HttpRequest request){
        Http http = new Http();
        System.debug('body' + request.getBody());
        return http.send(request);
    }

    public static CustomerInfoResponse parseData(String jsonData){
        System.debug(jsonData);
        return (CustomerInfoResponse)JSON.deserialize(jsonData,CustomerInfoResponse.class);
    }

}