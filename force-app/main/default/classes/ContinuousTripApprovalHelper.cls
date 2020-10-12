/*
 ** Two Way Approval for particular campus assigned Site Incharge & City Head.
 */


public class ContinuousTripApprovalHelper {
 public static void sendApproval(list<Continous_trip__c>conList){
        
        list<Continous_trip__c> extL =[select id,Service_Provider__c, Service_Provider__r.Site__r.Site_Supervisor__r.Name,Status__c,Service_Provider__r.Site__r.City_Head__c,
                                   Service_Provider__r.Site__r.Site_Supervisor__c from Continous_trip__c where id  in:conList AND Service_Provider__r.Status__c ='Active'];
        system.debug('extList'+conList);
        //  list<id> setIds = new list<id>();
        //    list<id> setIdsss = new list<id>();
        //  setIds.add(extL[0].Lithium_ID__r.Site__r.Site_Incharge__c );
        //     setIdsss.add(extL[0].Lithium_ID__r.Site__r.Cluster_Head__c );
        //     List<Service_Provider__c> spList = [select id,Site__c from Service_Provider__c  ];    
        system.debug('extL'+extL[0].Service_Provider__r.Site__r.Site_Supervisor__c);   
        //   system.debug('extL'+extL[0].Lithium_ID__r.Site__r.City_Head__c);   
        List<Approval.ProcessSubmitRequest> appRequest = new List<Approval.ProcessSubmitRequest>();
        for(Continous_trip__c ex :extL ){
            system.debug('ex'+ex);
           
                if(ex.Status__c == 'Initiate' && ex.Service_Provider__r.Site__r.Site_Supervisor__c !=null ){
                    system.debug('ex.Service_Provider__r.Site__r.Site_Incharge__r.Id'+ex.Service_Provider__r.Site__r.Site_Supervisor__c);
                    
                    
                    Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
                    // ProcessInstanceWorkitem pItem = [Select Id,ProcessInstance.TargetObjectId from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId in:userIdsList ];   
                    approvalRequest.setComments('submitted  for Approval');
                    approvalRequest.setObjectId(ex.Id);
                    approvalRequest.setNextApproverIds(new Id[] {ex.Service_Provider__r.Site__r.Site_Supervisor__c});
                    appRequest.add(approvalRequest);
                    //  Approval.ProcessResult approvalResult = Approval.process(approvalRequest);
                    //    System.debug('offer submitted for approval successfully: '+approvalResult .isSuccess()); 
                }
                
                Approval.process(appRequest);
            
        }
    }
    
 /*   private static List<ProcessInstanceWorkitem> getProcessInstanceWorkItems(Id objectId) {
        return [
            SELECT
            Id
            FROM
            ProcessInstanceWorkitem
            WHERE
            ProcessInstance.TargetObjectId =: objectId
        ];
    } */
    @Future
    public static void sendApprovaltoclusterHead(set<id>contList){
        
        list<Continous_trip__c> extL =[select id, Service_Provider__c,Service_Provider__r.Site__r.Site_Supervisor__r.Name,Status__c,Service_Provider__r.Site__r.City_Head__c,
                                   Service_Provider__r.Site__r.Site_Incharge__c from Continous_trip__c where id in:contList];
        system.debug('extList'+contList);
        
        system.debug('extL'+extL[0].Service_Provider__r.Site__r.City_Head__c); 
        List<Approval.ProcessSubmitRequest> appRequest = new List<Approval.ProcessSubmitRequest>();
        
        for(Continous_trip__c ex :extL ){
            if(ex.Status__c == 'Approved by Site Manager' && ex.Service_Provider__r.Site__r.City_Head__c !=null ){
                /*Id approvalStepId =  getProcessInstanceWorkItems(ex.Id)[0].Id;
Approval.ProcessWorkitemRequest result = new Approval.ProcessWorkitemRequest();
// result.setComments(commentFromApprover);
result.setAction('Approve');
result.setWorkitemId(approvalStepId);
result.setNextApproverIds(new List<Id>{ex.Lithium_ID__r.Site__r.City_Head__c});
//Approval.process(result);
}*/
                
                Approval.ProcessSubmitRequest approvalRequest1 = new Approval.ProcessSubmitRequest();
                // ProcessInstanceWorkitem pItem = [Select Id,ProcessInstance.TargetObjectId from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId in:userIdsList ];   
                //approvalRequest1.setComments('submitted  for Approval');
                approvalRequest1.setObjectId(ex.Id);
                
                // approvalRequest1.
                approvalRequest1.setNextApproverIds(new Id[] {ex.Service_Provider__r.Site__r.City_Head__c});
                Approval.process(approvalRequest1);
                //appRequest.add(approvalRequest1);
                //  Approval.ProcessResult approvalResult = Approval.process(approvalRequest);
                //    System.debug('offer submitted for approval successfully: '+approvalResult .isSuccess()); 
            }
            
            /*Approval.process(appRequest);*/
        }
    }
}