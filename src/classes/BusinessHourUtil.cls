/**
 *  @author Ivan Yeung
 *  @date 7/25/2017
 *  @group Utility
 *  @description  Utility class for various business hour function. Conceptually, it acts as facade pattern to hide some complexity
 *       https://developer.salesforce.com/page/Apex_Design_Patterns_-_Facade
 */

public with sharing class BusinessHourUtil {

    /*******************************************************************************************************
    * @description 'Caesars Business Week' business hour id
    *
    */
    private static BusinessHours pCaesarsBusinessWeek = null;
    public static BusinessHours caesarsBusinessWeek {
        get {
            if (pCaesarsBusinessWeek == null) {
                pCaesarsBusinessWeek = [select CreatedById, CreatedDate, FridayEndTime, FridayStartTime, Id, IsActive, IsDefault, MondayEndTime, MondayStartTime, Name, SaturdayEndTime, SaturdayStartTime, SundayEndTime, SundayStartTime, SystemModstamp, ThursdayEndTime, ThursdayStartTime, TimeZoneSidKey, TuesdayEndTime, TuesdayStartTime, WednesdayEndTime, WednesdayStartTime from BusinessHours where Name = 'Caesars Business Week' limit 1];
            }
            return pCaesarsBusinessWeek;
        }
    }


    /*******************************************************************************************************
    * @description convert a duration in days, hours and minutes to milliseconds
    *
    */
    public static Integer durationInMs (Decimal days, Decimal hours, Decimal minutes){

        Decimal durationDays = days==null? 0:days ;
        Decimal durationHours = hours==null?0:hours;
        Decimal durationMinutes = minutes==null?0:minutes ;

        Decimal dayinMinutes = durationDays * 8 * 60  ; // 8 hours work day
        Integer intervalMilliseconds = ((dayinMinutes + durationHours * 60 + durationMinutes)  *60 * 1000 ).intValue();

        return intervalMilliseconds;
    }

}