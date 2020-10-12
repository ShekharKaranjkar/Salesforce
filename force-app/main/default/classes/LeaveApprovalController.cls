public class LeaveApprovalController {
    
    @AuraEnabled
    public static List<Leave__c> fetchLeave(){
        system.debug('insidemethod');
        list <Leave__c> returnLvList = new List <Leave__c> ();
        List<Leave__c> leaveList =[Select Id,Name,Approval_Request__c,From_date__c,CreatedDate,Service_Provider__c,To_date__c,Lithium_ID__c,Service_Provider__r.Name,Service_Provider__r.Site__r.Site_Supervisor__r.id
                                   from Leave__c 
                                   where RecordType.Name ='Planned EOS' AND  Approval_Request__c ='Initial' and Service_Provider__r.Status__c ='Active'
                                   Order by CreatedDate  ASC ];
        system.debug('leaveList'+leaveList);
        
        if(leaveList.size() > 0){   
            system.debug('leaveList111111111111');
            for (Leave__c c: leaveList) {
                system.debug('c.Service_Provider__r.Site__r.Site_Supervisor__r.id'+c.Service_Provider__r.Site__r.Site_Supervisor__r.id);
                if(c.Service_Provider__r.Site__r.Site_Supervisor__r.id ==  UserInfo.getUserId()){
                    returnLvList.add(c);
                }
            }
            return returnLvList;
        }
        else 
        return null;
        
    }
    @AuraEnabled
    public static List<Leave__c> fetchLeaveHistory(String spRecId){
        system.debug('sId'+spRecId);
        Date startDate = system.today();
        Date newDate = startDate.addDays(-30);
        List<Leave__c> leaveList =[Select Id,Name,Approval_Request__c,From_date__c,CreatedDate,Service_Provider__c,To_date__c,Lithium_ID__c,Service_Provider__r.Name,Service_Provider_Name__c
                                   from Leave__c 
                                   Where Service_Provider__c =:spRecId and From_date__c >=:newDate and Service_Provider__r.Status__c ='Active'
                                   Order by CreatedDate  ASC ];
        if(leaveList != null)
        {
            return leaveList;
        }
        else 
        return null;
        
    }
    @AuraEnabled
    public static string saveRecord(Leave__c leaveApprv,String reuestType){
        //Leave record for approve or reject
        Leave__c lvList=[SELECT id, Name, Service_Provider__c,Approval_Request__c,Emergency_Leave_Approval__c,RecordType.Name,Approved_by__c  From Leave__c where id=:leaveApprv.Id and  Approval_Request__c='Initial' ];
        //Creating new approvalrequest 
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        String retVal;
        
      list< ProcessInstanceWorkitem > pItem = [Select Id,ProcessInstance.TargetObjectId from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId=:lvList.Id ];
       system.debug('pItem------'+pItem);
        if(pItem.size() > 0 && !pItem.isEmpty()){
system.debug('pItem'+pItem);
            if(reuestType == 'Approve'){
                req.setComments('Approving request for Leave');
                req.setAction('Approve');
                req.setWorkitemId(pItem[0].Id);
                retVal = 'approveMessage';
                
                
            } else if(reuestType == 'Reject'){
                
                req.setComments('Rejecting request for Leave');
                req.setAction('Reject');
                req.setWorkitemId(pItem[0].Id);
                retVal = 'RejectMessage';
                
            }
        }
        //Submits a new approval request and approves or rejects existing approval requests
        if(pItem.size()>0&& !pItem.isEmpty()){
            Approval.ProcessResult result = Approval.process(req);
        }
        return retVal;
        
    }
}