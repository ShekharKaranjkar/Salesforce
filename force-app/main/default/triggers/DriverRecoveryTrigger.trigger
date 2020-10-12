trigger DriverRecoveryTrigger on Driver_Recovery__c (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        RecoveryInstallment.createRecord(trigger.new);
    }

}