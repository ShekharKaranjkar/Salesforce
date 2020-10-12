global class SchedulerForInactivity implements Schedulable{
     global void execute (SchedulableContext SC){
        
       // system.abortJob(SC.getTriggerId());
        Batch_InactivityReminder fb1 = new Batch_InactivityReminder();
        Database.executeBatch(fb1);
        
    }

}