trigger compliance_Trigger on Compliance__c (after insert) {

        if(trigger.isAfter && trigger.isInsert){
        system.debug('inside the trigger');
        ComplianceTriggerController.attachFiles(trigger.New);
    }
}