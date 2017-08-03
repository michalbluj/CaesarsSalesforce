/**
 * Created by ceezar on 03.08.2017.
 */

public with sharing class HotelEvent extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public String id {get; set;}

        public final String d_created_date {get; set;}
    }

    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (HotelEvent.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('d_created_date', wrapper.d_created_date);
            rows.add(row);
        }
        return rows;
    }
}


for(String clName : MapHandler.externalTableToClassNameMap.values()) {
    createTestClass(clName);
}

    private void createTestClass(String className) {
        String mainClass = '@isTest\n' +
        'private class ' + className + 'Test {\n'+
        '\n'+
        '    static testMethod void populateDataTest() {\n'+
        '\n'+
        '        '+className+'.Record dataRecord = new 'className'+'.Record();\n'+
        '        dataRecord.id = \'1234\';\n'+
        '\n'+
        '        '+className+' wrapper = new '+className+'();\n'+
        '        wrapper.body = new List<'+className+'.Record>{dataRecord};\n'+
        '\n'+
        '        Test.startTest();\n'+
        '        List<Map<String, Object>> rows = wrapper.populateData(new List<Map<String, Object>>());\n'+
        '        Test.stopTest();\n'+
        '\n'+
        '        for(Map<String, Object> row : rows) {\n'+
        '            System.assertEquals((String) row.get(\'id\'), \'1234\');\n';
        '            System.assertEquals((String) row.get(\'ExternalId\'), \'1234\');\n'+
        '            System.assertEquals((String) row.get(\'DisplayUrl\'), \'1234\');\n'+
        '        }\n'+
        '    }\n'+
        '}';
        System.debug(mainClass);
    }
}

