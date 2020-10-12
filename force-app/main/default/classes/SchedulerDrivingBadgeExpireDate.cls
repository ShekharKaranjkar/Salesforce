global class SchedulerDrivingBadgeExpireDate implements Schedulable {
   global void execute(SchedulableContext sc) {
      Batch_DrivingBadgeExpireDate bc = new Batch_DrivingBadgeExpireDate(); 
      database.executebatch(bc);
   }
}