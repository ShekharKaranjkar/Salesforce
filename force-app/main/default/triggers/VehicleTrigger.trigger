trigger VehicleTrigger on Vehicle__c (before insert) {
    if(trigger.isBefore && trigger.isinsert){
     VehicleName.notSame(trigger.new);
    }
}