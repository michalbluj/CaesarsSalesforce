/**
* @author Jakub Kołacz
* @date 2017
* @group UnitTest
* @description Unit test class for CustomerInfoService class
**/

@IsTest
private class CustomerInfoServiceTest {

	public class CustomerInfoServiceResponseGenerator implements HttpCalloutMock {
		public HTTPResponse respond(HTTPRequest req) {
			System.assertEquals('http://customerserviceinfo.com', req.getEndpoint());
			System.assertEquals('POST', req.getMethod());

			HttpResponse res = new HttpResponse();
			res.setHeader('Content-Type', 'application/json');
			res.setBody('{"test":"test"}');
			res.setStatusCode(200);
			return res;

		}
	}

	@isTest
	static  void createHttpRequestWithQueryContext() {
		Test.startTest();
		DataSource.Filter filter = new DataSource.Filter();
		filter.columnName = 'columnName';
		filter.columnValue = 'columnValue';
		DataSource.TableSelection tableSelection = new  DataSource.TableSelection();
		tableSelection.filter = filter;
		DataSource.QueryContext queryContext = new DataSource.QueryContext();
		queryContext.tableSelection = tableSelection;
		HttpRequest request = CustomerInfoService.createHttpRequest('http://www.customerserviceinfo.com', queryContext );
		Test.stopTest();

		System.assertEquals('POST', request.getMethod());
		System.assertEquals('http://www.customerserviceinfo.com',request.getEndpoint());
		Map<String, Object> deserializedJson = (Map<String, Object>) JSON.deserializeUntyped(request.getBody());
		Map<String, Object> deserializedBody = (Map<String, Object>)deserializedJson.get('body');
		System.assertEquals('columnName', deserializedBody.get('columnName'));
		System.assertEquals('columnValue', deserializedBody.get('columnValue'));
	}

	@isTest
	static void parseDataTest(){
		String jsonData = '{"test":"test"}';

		Test.startTest();
		CustomerInfoResponse res = CustomerInfoService.parseData(jsonData);
		Test.stopTest();

		System.assert(res != null);
	}

}