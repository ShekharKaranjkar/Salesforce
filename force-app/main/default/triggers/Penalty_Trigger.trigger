trigger Penalty_Trigger on Penalty__c (After Update) {
if(trigger.isAfter && trigger.isUpdate){
       
        PenaltyNotificationhelper.createNotification(trigger.New,trigger.oldmap);
    }
}