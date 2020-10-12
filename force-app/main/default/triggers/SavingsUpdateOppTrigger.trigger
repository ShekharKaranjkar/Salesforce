trigger SavingsUpdateOppTrigger on Opportunity (before insert,before update,after update) {

        //system.debug('Mobile + : '+Trigger.New.get(0).Secondary_Mobile_Number__c);

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate) ){
      SavingsUpdateOppController.handleMethod(Trigger.New);
    }
    
}