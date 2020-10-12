trigger VehicleAssignmentTrigger on Vehicle_Assignment__c (Before update,After update, After insert,after delete) {
    
    if(trigger.isAfter && trigger.isUpdate){
        VehicleAssignmentTriggerHelper1.checkOdoMeterReading1(Trigger.New,trigger.oldmap);
    }
  /*  if(trigger.isafter && trigger.isdelete) // Using context variable.
    {
        VehicleAssingmentupdate.updateVehicleAndServiceProvider(Trigger.old);  // Calling apex class method.
    } */
    
}