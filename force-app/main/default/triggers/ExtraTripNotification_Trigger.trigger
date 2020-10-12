trigger ExtraTripNotification_Trigger on Extra_Trip__c (After Insert,Before Insert,After Update) {

    if(trigger.isAfter && trigger.isUpdate){
       
        ExtraTripNotificationHelper.createNotification(trigger.New,trigger.oldmap);
    }
  
}