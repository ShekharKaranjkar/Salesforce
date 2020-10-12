trigger UpdateOpportunityTrigger on Opportunity (before update ){
if(Trigger.isBefore && Trigger.isUpdate){
        system.debug('Trigger isBefore Update');
        UpdateOpportunityHandler.isStatusChecked(Trigger.new,Trigger.oldMap,UpdateOpportunityHandler.IsRecurssive);
    }
}