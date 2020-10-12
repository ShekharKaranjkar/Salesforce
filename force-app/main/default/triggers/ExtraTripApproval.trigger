trigger ExtraTripApproval on Extra_Trip__c (After Insert,After Update) {
    if(trigger.isAfter && trigger.isInsert){
        
        ExtraTripApprovalHelper.sendApproval(trigger.New);
    }
    if(trigger.isAfter && trigger.isUpdate){
       // String jsonOldMap  = JSON.serialize(Trigger.oldMap);
        for (Extra_Trip__c newRecord : trigger.new)
        {
            if (newRecord.Status__c != trigger.oldMap.get(newRecord.Id).Status__c)
            {
                ExtraTripApprovalHelper.sendApprovaltoclusterHead(trigger.NewMap.Keyset() );
                
            }
        }
    }
}