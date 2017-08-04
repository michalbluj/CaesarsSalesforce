/**
 * Created by Michal Bluj on 2017-07-12.
 */

public with sharing class PreGame5CustomerInfo implements CustomerInfoInterface {

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public Map<String, Object> populateData(Map<String, Object> row, CustomerInfo wrapper) {
        row.put('denom',wrapper.data.i_denom);
        row.put('groups',wrapper.data.i_groups);
        row.put('group_1',wrapper.data.c_group_1);
        row.put('group_2',wrapper.data.c_group_2);
        row.put('group_3',wrapper.data.c_group_3);
        row.put('group_4',wrapper.data.c_group_4);
        row.put('group_5',wrapper.data.c_group_5);
        row.put('machines',wrapper.data.i_machines);
        row.put('game_type',wrapper.data.c_game_type);
        row.put('cards_top',wrapper.data.i_cards_top);
        row.put('denom_pref',wrapper.data.f_denom_pref);
        row.put('user_amt_1',wrapper.data.f_user_amt_1);
        row.put('user_amt_2',wrapper.data.f_user_amt_2);
        row.put('user_amt_3',wrapper.data.f_user_amt_3);
        row.put('user_amt_4',wrapper.data.f_user_amt_4);
        row.put('user_amt_5',wrapper.data.f_user_amt_5);
        row.put('user_amt_6',wrapper.data.f_user_amt_6);
        row.put('user_amt_7',wrapper.data.f_user_amt_7);
        row.put('user_amt_8',wrapper.data.f_user_amt_8);
        row.put('user_amt_9',wrapper.data.f_user_amt_9);
        row.put('denom_pref_i',wrapper.data.i_denom_pref);
        row.put('top1_value',wrapper.data.i_top1_value);
        row.put('top5_value',wrapper.data.i_top5_value);
        row.put('user_flag_1',wrapper.data.c_user_flag_1);
        row.put('user_flag_2',wrapper.data.c_user_flag_2);
        row.put('user_flag_3',wrapper.data.c_user_flag_3);
        row.put('user_flag_4',wrapper.data.c_user_flag_4);
        row.put('user_flag_5',wrapper.data.c_user_flag_5);
        row.put('user_flag_6',wrapper.data.c_user_flag_6);
        row.put('user_flag_7',wrapper.data.c_user_flag_7);
        row.put('user_flag_8',wrapper.data.c_user_flag_8);
        row.put('user_flag_9',wrapper.data.c_user_flag_9);
        row.put('user_amt_10',wrapper.data.f_user_amt_10);
        row.put('cards_total',wrapper.data.i_cards_total);
        row.put('denom_total',wrapper.data.i_denom_total);
        row.put('total_value',wrapper.data.i_total_value);
        row.put('user_flag_10',wrapper.data.c_user_flag_10);
        row.put('user_score_1',wrapper.data.i_user_score_1);
        row.put('user_score_2',wrapper.data.i_user_score_2);
        row.put('user_score_3',wrapper.data.i_user_score_3);
        row.put('user_score_4',wrapper.data.i_user_score_4);
        row.put('user_score_5',wrapper.data.i_user_score_5);
        row.put('user_score_6',wrapper.data.i_user_score_6);
        row.put('user_score_7',wrapper.data.i_user_score_7);
        row.put('user_score_8',wrapper.data.i_user_score_8);
        row.put('user_score_9',wrapper.data.i_user_score_9);
        row.put('user_score_10',wrapper.data.i_user_score_10);
        return row;
    }
}