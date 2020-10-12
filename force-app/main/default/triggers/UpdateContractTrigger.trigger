trigger UpdateContractTrigger on Contract (before update) {
 if(Trigger.isBefore && Trigger.isUpdate){
        system.debug('Trigger isBefore Update');
        UpdateConHandler.isStatusChecked(Trigger.new,Trigger.oldMap);
    }
}