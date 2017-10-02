/**
 * Created by Michal Bluj on 2017-07-12.
 */

public with sharing class ExternalObjectService {

    public static HttpRequest createHttpRequest(String endpoint,DataSource.QueryContext context){
        HttpRequest req = createHttpRequest();
        req.setBody(buildQueryBody(context));
        req.setEndpoint(endpoint);
        return req;
    }
    private static HttpRequest createHttpRequest(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setTimeout(60000);
        return req;
    }

    private static String buildQueryBody(DataSource.QueryContext context){
        DataSource.TableSelection tableSelection = context.tableSelection;
        DataSource.Filter filter = tableSelection == null ? null : tableSelection.filter;
        String body = '{"header" : {'+buildConfigSection(tableSelection)+'},"body" : '+JSON.serializePretty(filter)+'}';
        System.debug(body);
        return body;
    }

    private static String buildConfigSection(DataSource.TableSelection tableSelection){
        String configJson = '"config":{"columns": [';
        List<DataSource.ColumnSelection> columns = tableSelection.columnsSelected;
        for(DataSource.ColumnSelection column : columns){
            configJson += '{"name":"'+column.columnName+'"},';
        }
        configJson = configJson.substring(0,configJson.length() - 1);
        configJson += '],';
        String tableNameJson = '"tableName":"'+MapHandler.EXTERNAL_OBJECT_TO_TABLE_MAP.get(tableSelection.tableSelected)+'"}';
        
        System.debug(configJson+tableNameJson);
        
        return configJson+tableNameJson;
    }

    public static ExternalObjectInterface parseData(String jsonData,DataSource.QueryContext context){
        DataSource.TableSelection tableSelection = context.tableSelection;
        String tableSelected = tableSelection.tableSelected;
        System.debug('jsonData ' + jsonData);
        System.Type objectClass = Type.forName(MapHandler.EXTERNAL_TABLE_TO_CLASSNAME_MAP.get(tableSelected));
        return (ExternalObjectInterface) JSON.deserialize(jsonData, objectClass);
    }

    public static HttpResponse sendHttpRequest(HttpRequest request){
        Http http = new Http();
        return http.send(request);
    }

}