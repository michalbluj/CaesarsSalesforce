/**
*	 @description model class for StatusMatrix
*    @author Patryk Lompart
*    @date 8/11/2017
*    @group Model 
*/
public with sharing class MatrixModel {
	public MatrixModel(){

	}
	
	public Matrix getMatrix(){
		List<Matrix__c> mtxs = Matrix__c.getAll().values();

		return new Matrix(mtxs[0].Matrix__c);
	}

	public Matrix__c getSetting(){
		List<Matrix__c> mtxs = Matrix__c.getAll().values();

		return mtxs[0];
	}
	
	public MatrixCellValue retrieveValue(Integer existing, Integer incoming){
		return translateToEnum(getMatrix().getCell(incoming,existing));
	}
	
	private MatrixCellValue translateToEnum(String value){
		for(MatrixCellValue val : MatrixCellValue.values()){
			if(value == val.name()){
				return val;
			}
		}
		return null;
	}
    
}