/*
* @author Michał Bluj
* @date 2017
* @group Utils
* @description Utils class
**/
public with sharing class Utils {
    
    private static Map<Integer,String> base30Mapping = new Map<Integer,String>{
            0 => '0',1 => '1',2 => '2',3 => '3',4 => '4',5 => '5',6 => '6',7 => '7',8 => '8',9 => '9',
            10 => 'A',11 => 'B',12 => 'C',13 => 'D',14 => 'E',15 => 'F',16 => 'G',17 => 'H',18 => 'I',19 => 'J',
            20 => 'K',21 => 'L',22 => 'M',23 => 'N',24 => 'O',25 => 'P',26 => 'Q',27 => 'R',28 => 'S',29 => 'T'
    };

    /*
    * @description Converts decimal into Base30 representation
    * @param num number to be converted
    * @return Base30 representation
    */
    public static String convertToBase30(Decimal num){
        String value = '';
        Decimal inputValue = num;
        while(inputValue > 0) {
            Decimal element = Math.floor(inputValue / 30.0);
            Integer remainder = Integer.valueOf(inputValue - (30.0 * element));
            value = base30Mapping.get(remainder) + value;
            inputValue = element;
        }
        return value;
    }

    /*
    * @description Converts decimal into Base30 representation witl 0 left padding if required
    * @param num number to be converted
    * @param padLength numer of 0 pad
    * @return Base30 representation
    */
    public static String convertToBase30(Decimal num, Integer padLength){
        return convertToBase30(num).leftPad(padLength,'0');
    }
}