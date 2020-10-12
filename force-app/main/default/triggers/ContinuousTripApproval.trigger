trigger ContinuousTripApproval on Continous_trip__c (After Insert,After Update) {
    if(trigger.isAfter && trigger.isInsert){
        
        ContinuousTripApprovalHelper.sendApproval(trigger.New);
    }
    if(trigger.isAfter && trigger.isUpdate){
        for (Continous_trip__c newRecord : trigger.new)
        {
            if (newRecord.Status__c != trigger.oldMap.get(newRecord.Id).Status__c)
            {
                ContinuousTripApprovalHelper.sendApprovaltoclusterHead(trigger.NewMap.Keyset());
            }
        }
    }
}