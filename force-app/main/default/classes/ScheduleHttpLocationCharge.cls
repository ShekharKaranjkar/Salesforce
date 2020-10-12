global class ScheduleHttpLocationCharge implements Schedulable {
   global void execute(SchedulableContext sc) {
      system.abortJob(sc.getTriggerId());
       System.enqueueJob(new LocationDataQueueable());
   }
}