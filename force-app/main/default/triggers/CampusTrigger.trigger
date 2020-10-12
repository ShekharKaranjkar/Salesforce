trigger CampusTrigger on Campus__c (After Insert,After Update) {
    if((trigger.isAfter && trigger.isInsert) ||(trigger.isAfter && trigger.isUpdate)){
        
        CampusApprovalHelper.sendApproval(trigger.New,trigger.oldmap);
    }
}