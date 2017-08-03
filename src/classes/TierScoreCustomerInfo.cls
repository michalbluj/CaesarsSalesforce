/**
* @author Michał Bluj
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Customer Info external object (Tier Score)
**/
public with sharing class TierScoreCustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row,CustomerInfo wrapper){
        row.put('i_year', wrapper.data.i_year);
        row.put('d_as_of', wrapper.data.d_as_of);
        row.put('d_posted_on', wrapper.data.d_posted_on);
        row.put('f_promo_base', wrapper.data.f_promo_base);
        row.put('f_tier_score', wrapper.data.f_tier_score);
        row.put('f_adjust_base', wrapper.data.f_adjust_base);
        row.put('f_earned_base', wrapper.data.f_earned_base);
        row.put('f_prev_tier_score', wrapper.data.f_prev_tier_score);
        return row;
    }

}