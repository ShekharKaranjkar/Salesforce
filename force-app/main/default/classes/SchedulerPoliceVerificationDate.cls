global class SchedulerPoliceVerificationDate implements Schedulable {
   global void execute(SchedulableContext sc) {
      Batch_PoliceVerificationDate bc = new Batch_PoliceVerificationDate(); 
      database.executebatch(bc);
   }
}