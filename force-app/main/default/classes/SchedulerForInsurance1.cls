global class SchedulerForInsurance1 implements Schedulable{
    global void execute (SchedulableContext SC){
        
       // system.abortJob(SC.getTriggerId());
        Batch_Insurance fb1 = new Batch_Insurance();
       // ID batchprocessid = Database.executeBatch(fb);
        Database.executeBatch(fb1);
        
    }
}