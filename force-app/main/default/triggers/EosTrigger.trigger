trigger EosTrigger on Leave__c (After Insert,After Update) {
     if(trigger.isAfter && trigger.isInsert){
        
        EosTriggerHandler.sendApproval(trigger.New);
    }
    if(trigger.isAfter && trigger.isUpdate){
       // String jsonOldMap  = JSON.serialize(Trigger.oldMap);
      
        for (Leave__c newRecord : trigger.new)
        {
            if (newRecord.Approval_Request__c != trigger.oldMap.get(newRecord.Id).Approval_Request__c)
            {
                EosTriggerHandler.sendApprovalToHr(trigger.NewMap.Keyset() );
                
            }
        }
    }

}