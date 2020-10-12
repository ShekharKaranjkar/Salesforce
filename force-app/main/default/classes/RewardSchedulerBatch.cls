global class RewardSchedulerBatch implements Schedulable{
    global void execute (SchedulableContext SC){
        
        RewardsBatchClass fb = new RewardsBatchClass();
        Database.executeBatch(fb);
        
    }
}