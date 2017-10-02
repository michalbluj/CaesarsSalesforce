/**
*	@description Controller extension for Matrix page
*   @author Patryk Lompart
*   @date 8/11/2017
*   @group Controller
*/
public with sharing class MatrixController {
	public Matrix matrix {get;set;}	
	public String values {get;set;}
	private Matrix__c cstSetting;
	public String errorMessage {get;set;}
	public String message {get;set;}
	
	public MatrixController(){
		MatrixModel model = new MatrixModel();
		matrix = model.getMatrix();
		cstSetting = model.getSetting();
	}
	
	public PageReference saveMatrix(){
		if(cstSetting != null) {
			try{
				cstSetting.Matrix__c = values;
				update cstSetting;
			}catch(Exception e){
				errorMessage = 'Error while saving matrix: ' + e.getMessage();
				message = '';
				return null;
			}
			matrix.updateValues(values);
			errorMessage = '';
			message = 'All changes done on matrix has been saved';
		}
		return null;
	}
}