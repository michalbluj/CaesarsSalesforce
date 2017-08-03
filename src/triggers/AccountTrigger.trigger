/**
 * Created by Michal Bluj on 2017-06-29.
 */

trigger AccountTrigger on Account (before insert, before update) {
    new AccountTriggerHandler().run();
}