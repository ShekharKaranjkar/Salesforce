trigger ContentiousTripNotification_Trigger on Continous_trip__c (After Insert,Before Insert,After Update) {
   
    if(trigger.isAfter && trigger.isUpdate){
       
        ContentiousTripNotificationHelper.createNotification(trigger.New,trigger.oldmap);
    }
}