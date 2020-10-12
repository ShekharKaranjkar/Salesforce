global class SchedulerForVehicleDocument1 implements Schedulable {
   global void execute(SchedulableContext sc) {
      Batch_VehicleDocument vehicle = new Batch_VehicleDocument(); 
      database.executebatch(vehicle);
   }
}