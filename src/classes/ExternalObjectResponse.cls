/**
 * Created by Michal Bluj on 2017-07-19.
 */

/*{
	"timestamp":1500550879378,
	"header":{"result":{"code":0,"status":"SUCCESS","message":"SUCCESS"},
	"trans":{"id":"07201141672","timestamp":"2017-07-20T11:41:19.378Z"}},
	"body":[{"contact":"0030v000002bWo4AAE","id":"1234"}] // handled by concrete child class
	}
*/

public virtual class ExternalObjectResponse {

	public Long timestamp {get;set;}
	public Header header {get;set;}
	public Trans trans {get;set;}

	public class Header{
		public Result result {get;set;}
	}
	
	private class Result{
		public Integer code {get;set;}
		public String status {get;set;}
		public String message {get;set;}
	}
	
	private class Trans{
		public String id {get;set;}
		public String timestamp {get;set;}
	}

}