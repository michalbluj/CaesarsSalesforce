/**
*	 @description Matrix class that represents matrix
*    @author Michał Bluj
*    @date 6/9/2016
*	 @group model
*/
public class Matrix {
		
	private Integer DIM = 6;
		
	public List<List<String>> cells;
		
	public Matrix(String stringMatrix){
		updateValues(stringMatrix);
	}
		
	public String getCell(Integer col,Integer row){
		return cells.get(row).get(col);
	}
	
	public List<List<String>> getCells(){
		return cells;
	}
	
	public void updateValues(String stringMatrix){
		List<String> splitedValues = stringMatrix.split(',');
		cells = new List<List<String>>();
		for(Integer row = 0; row < DIM ; row ++){
			cells.add(new List<String>());
			for(Integer index = row * DIM ; index < (row + 1) * DIM ; index ++){
				String value = splitedValues.get(index);
				cells[row].add(value);
			}
		}
	}
		
}