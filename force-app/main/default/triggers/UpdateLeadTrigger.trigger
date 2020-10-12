trigger UpdateLeadTrigger on Lead (before insert,before update,after update) {
        system.debug('Mobile + : '+Trigger.New.get(0).Secondary_Mobile_Number__c);

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate) ){
      QuestionaryCalculation.handleMethod(Trigger.New);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        system.debug('Trigger isBefore Update');
        UpdateLeadHandler.isStatusChecked(Trigger.new,Trigger.oldMap);
    }
}