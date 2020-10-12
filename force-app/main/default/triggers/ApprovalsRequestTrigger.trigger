trigger ApprovalsRequestTrigger on Approval_Request__c (after Update ,after insert) {
    if(trigger.Isafter && trigger.isUpdate){
        
   
        ApprovalsRequestTriggerHandler.statusChanged(Trigger.new ,trigger.oldmap);
        
    }
}