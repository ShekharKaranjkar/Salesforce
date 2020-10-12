global class SchedulerGenerationInvoice implements Schedulable{
    global void execute (SchedulableContext SC){
        
        system.abortJob(SC.getTriggerId());
        GenerationInvoiceBatch fb = new GenerationInvoiceBatch();
        ID batchprocessid = Database.executeBatch(fb);
        
    }
}