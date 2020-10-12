trigger RewardTrigger on Reward__c (before insert,before Update) {
    if(trigger.isbefore&& trigger.isinsert || trigger.isbefore&& trigger.isUpdate){
        RewardTriggerHandler.calculateDistanceAndTrip(trigger.new);
    }
}