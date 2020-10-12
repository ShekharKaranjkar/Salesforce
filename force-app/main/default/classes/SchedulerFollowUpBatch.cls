global class SchedulerFollowUpBatch implements Schedulable{
    global void execute (SchedulableContext SC){
        
        system.abortJob(SC.getTriggerId());
        FollowUpBatch fb = new FollowUpBatch();
        ID batchprocessid = Database.executeBatch(fb);
        
    }
}