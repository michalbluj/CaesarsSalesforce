/**
 * Created by ceezar on 04.08.2017.
 */
@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    private Integer statusCode;
    private String status;
    private String body;

    global MockHttpResponseGenerator(Integer statusCode, String status, String body) {
        this.statusCode = statusCode != null ? statusCode : 200;
        this.status = status != null ? status : 'SUCCESS';
        this.body = body != null ? body : '{"test":"test"}';
    }

    global HTTPResponse respond(HTTPRequest req) {

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(body);
        res.setStatusCode(statusCode);
        res.setStatus(status);
        return res;
    }
}