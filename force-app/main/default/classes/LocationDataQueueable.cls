public class LocationDataQueueable implements Queueable,Database.AllowsCallouts {
    public void execute(QueueableContext context) {
        // Your processing logic here       
		HttpLocationChargeController.getLocationData();
        // Chain this job to next job by submitting the next job\
        if(!Test.isRunningTest())
        	System.enqueueJob(new ChargeDataQueueable());
    }
}