global class SchedulerDrivingLicense implements Schedulable {
   global void execute(SchedulableContext sc) {
      Batch_DrivingExpireDate bc = new Batch_DrivingExpireDate(); 
      database.executebatch(bc);
   }
}