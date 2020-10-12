trigger AdvanceAmountTrigger on Advance__c  (After Insert,After Update) {
    if(trigger.isAfter && trigger.isInsert){
        
        AdvanceAmountApprovalHelper.sendApproval(trigger.New);
    }
    if(trigger.isAfter && trigger.isUpdate){
       // String jsonOldMap  = JSON.serialize(Trigger.oldMap);
        for (Advance__c newRecord : trigger.new)
        {
            if (newRecord.Status__c != trigger.oldMap.get(newRecord.Id).Status__c)
            {
                AdvanceAmountApprovalHelper.sendApprovaltoclusterHead(trigger.NewMap.Keyset() );
                
            }
        }
    }
}