public class EosTriggerHandler {
    public static void sendApproval(list<Leave__c>leaveRec){
        system.debug('inside EosTriggerHandler');
        Id plannedRecordTypeId = Schema.SObjectType.Leave__c.getRecordTypeInfosByDeveloperName().get('Planned_Leave').getRecordTypeId();
        list<Leave__c> leaveList =[select id,Approval_Request__c,Service_Provider__c, From_date__c,To_date__c,Lithium_ID__c, Service_Provider__r.Site__c, Service_Provider__r.Site__r.HR__c,Service_Provider__r.Site__r.Site_Supervisor__c 
                                   from Leave__c 
                                   where id in:leaveRec AND Service_Provider__r.Status__c  ='Active' AND RecordTypeId=:plannedRecordTypeId ];
        system.debug('leaveList'+leaveList);
  
        List<Approval.ProcessSubmitRequest> appRequest = new List<Approval.ProcessSubmitRequest>();
        string startda;
            list<string> startDate;
          string endda;
            list<string> endDate;
        for(Leave__c leaveValue :leaveList ){
            startda = string.valueOf(leaveValue.From_date__c);
           startDate= startda.split(' ');
             endda = string.valueOf(leaveValue.To_date__c);
           endDate= endda.split(' ');
            system.debug('inside 15--------'+leaveValue.Service_Provider__r.Site__r.Site_Supervisor__c);
            system.debug('leaveValue.Approval_Request__c'+leaveValue.Approval_Request__c);
            if(leaveValue.Approval_Request__c == 'Initial' && leaveValue.Service_Provider__r.Site__r.Site_Supervisor__c !=null ){
                system.debug('leaveValue.Lithium_ID__r.Site__r.Site_Incharge__r.Id'+leaveValue.Service_Provider__r.Site__r.Site_Supervisor__c);
                
                
                Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
                approvalRequest.setComments('submitted  for Approval');
                approvalRequest.setObjectId(leaveValue.Id);
                approvalRequest.setNextApproverIds(new Id[] {leaveValue.Service_Provider__r.Site__r.Site_Supervisor__c});
                appRequest.add(approvalRequest);
            }
            
            Approval.process(appRequest);
            
            
           /* if(appRequest.size()>0 &&!appRequest.isEmpty()&& leaveValue.Approval_Request__c == 'Rejected'){
              
                    system.debug('leaveValue.Approval_Request__c'+leaveValue.Approval_Request__c);
                    Notification__c noti = new Notification__c();
                    noti.User_Id__c = leaveValue.Service_Provider__c;
                    noti.Message__c = ' Your EOS is Rejected' ;
                    insert noti; 
                    
                    
                }*/
                
            } 
        }
    
    
    @Future
    public static void sendApprovalToHr(set<id>leaveRec){
        
        Id plannedRecordTypeId = Schema.SObjectType.Leave__c.getRecordTypeInfosByDeveloperName().get('Planned_Leave').getRecordTypeId();
        list<Leave__c> leaveList =[select id,Approval_Request__c,Service_Provider__c, From_date__c,To_date__c,Lithium_ID__c, Service_Provider__r.Site__c, Service_Provider__r.Site__r.HR__c,Service_Provider__r.Site__r.Site_Supervisor__c 
                                   from Leave__c 
                                   where id in:leaveRec AND Service_Provider__r.Status__c  ='Active' AND RecordTypeId=:plannedRecordTypeId ];
        system.debug('leaveList'+leaveList);
        //system.debug('extL'+extL[0].Service_Provider__r.Site__r.HR__c); 
        List<Approval.ProcessSubmitRequest> appRequest = new List<Approval.ProcessSubmitRequest>();
        for(Leave__c leaveValue :leaveList ){
            if(leaveValue.Approval_Request__c == 'Approved' && leaveValue.Service_Provider__r.Site__r.HR__c !=null ){
                Approval.ProcessSubmitRequest approvalRequest1 = new Approval.ProcessSubmitRequest();
                approvalRequest1.setObjectId(leaveValue.Id);
                approvalRequest1.setNextApproverIds(new Id[] {leaveValue.Service_Provider__r.Site__r.HR__c});
                Approval.process(approvalRequest1);
            }
             Approval.process(appRequest);
               /* if(appRequest.size()>0 &&!appRequest.isEmpty()&&leaveValue.Approval_Request__c == 'Approved'){
                    Notification__c noti = new Notification__c();
                    noti.User_Id__c = leaveValue.Service_Provider__c;
                    noti.Message__c = ' Planned EOS is  Approved' ;
                    insert noti; 
                    
                    
                }*/
        }
    }
}