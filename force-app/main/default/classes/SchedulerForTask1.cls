global class SchedulerForTask1 implements Schedulable {
    global void execute (SchedulableContext SC){
        
    
        BatchTask batchTask = new BatchTask();
     
        Database.executeBatch(batchTask);
        
    }
}