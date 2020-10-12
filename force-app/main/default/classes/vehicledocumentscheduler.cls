global class vehicledocumentscheduler implements Schedulable {
   global void execute(SchedulableContext sc) {
      batchclass_vehicledocument vehicle = new batchclass_vehicledocument(); 
      database.executebatch(vehicle);
   }
}