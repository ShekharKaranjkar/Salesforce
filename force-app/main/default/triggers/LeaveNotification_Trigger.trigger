trigger LeaveNotification_Trigger on Leave__c (After Insert,Before Insert,After Update) {

    if(trigger.isAfter && trigger.isUpdate){
       
        LeaveNotificationHelper.createNotification(trigger.New);
    }
   /* if(trigger.isAfter && trigger.isUpdate){
       
        LeaveNotificationHelper.createEmenrgencyNotification(trigger.New);
    } */
}