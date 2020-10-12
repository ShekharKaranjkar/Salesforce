global class PlannedLeaveApprovalBtch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select id,name,From_Date_Reference__c,Approval_Request__c from Leave__c where From_Date_Reference__c!=null ');
    }
    
    global void execute(Database.BatchableContext BC, List<Leave__c> leaveList){
        system.debug('leaveList'+leaveList);
        Datetime cTime = system.now();
        system.debug('cTime'+cTime);
        
         List<String>leaveids = New List<String>();
        List<String>userIdsList = New List<String>();
        for (Leave__c member : [select id from Leave__c where From_Date_Reference__c!=null and Approval_Request__c='Initial']){
            userIdsList.add(member.id);
        }
        system.debug('userIdsList'+userIdsList);
        
        //Class used for Rejecting Record
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        list<ProcessInstanceWorkitem> pItem = [Select Id,ProcessInstance.TargetObjectId from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId in :userIdsList ];
        
        
        for(Leave__c lv : leaveList){
            system.debug('lv'+lv);
            if(lv.From_Date_Reference__c.addHours(6) <= cTime && lv.Approval_Request__c =='Initial')
                leaveids.add(lv.Id);
        }
            
            for(ProcessInstanceWorkitem pI:pItem){
                system.debug('pIiiiiiiiiii'+pI);
				   if(leaveids.contains(pI.ProcessInstance.TargetObjectId) && pI!= null){
                    req.setComments('Rejecting request for EOS');
                    //Approve or Reject Record
                    req.setAction('Reject');
                    //Getting Work Item Id
                    req.setWorkitemId(pI.Id);
                    // Submit the request for approval
                    Approval.ProcessResult result = Approval.process(req);
                    
                }
                
                
                
            }

        
    }
    
    
    global void finish(Database.BatchableContext BC){
        
        
        
    }
}