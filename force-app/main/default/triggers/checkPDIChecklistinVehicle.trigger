trigger checkPDIChecklistinVehicle on Vehicle__c (before update) {
     if(trigger.isBefore && trigger.isUpdate){
         checkPDIChecklistinVehicleHelper.checklist(trigger.oldmap,Trigger.Newmap);
    }
    }