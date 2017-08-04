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
        row.put('year', wrapper.data.i_year);
        row.put('as_of', wrapper.data.d_as_of);
        row.put('posted_on', wrapper.data.d_posted_on);
        row.put('quality_cd', wrapper.data.c_quality_cd);
        row.put('promo_base', wrapper.data.f_promo_base);
        row.put('tier_score', wrapper.data.f_tier_score);
        row.put('adjust_base', wrapper.data.f_adjust_base);
        row.put('earned_base', wrapper.data.f_earned_base);
        row.put('prev_tier_score', wrapper.data.f_prev_tier_score);
        return row;
    }

}