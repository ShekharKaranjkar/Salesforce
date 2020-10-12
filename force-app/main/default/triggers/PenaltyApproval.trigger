trigger PenaltyApproval on Penalty__c (After Insert,After Update) {
    if(trigger.isAfter && trigger.isInsert){
        
        PenaltyApprovalHelper.sendApproval(trigger.New);
    }
    if(trigger.isAfter && trigger.isUpdate){
        for (Penalty__c newRecord : trigger.new)
        {
            if (newRecord.Status__c != trigger.oldMap.get(newRecord.Id).Status__c)
            {			
                PenaltyApprovalHelper.sendApprovaltoclusterHead(trigger.NewMap.Keyset());
            }
        }
    }
}