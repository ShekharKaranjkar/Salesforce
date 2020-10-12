/*
 * Two Way Approval for particular campus assigned Site Incharge & City Head for Extra Trip.
 */
public class AdvanceAmountApprovalHelper {
    public static void sendApproval(list<Advance__c>extList){
    
        list<Advance__c> extL =[select id,Service_Provider_Name__c,Status__c , Service_Provider_Name__r.Site__r.Site_Supervisor__c from Advance__c where id  in:extList];
        system.debug('extList'+extList);
        system.debug('extL'+extL[0].Service_Provider_Name__r.Site__r.Site_Supervisor__c);   
        List<Approval.ProcessSubmitRequest> appRequest = new List<Approval.ProcessSubmitRequest>();
        for(Advance__c ex :extL ){
            system.debug('ex'+ex);
           
                if(ex.Status__c == 'Requested' && ex.Service_Provider_Name__r.Site__r.Site_Supervisor__c !=null ){
                    system.debug('ex.Lithium_ID__r.Site__r.Site_Incharge__r.Id'+ex.Service_Provider_Name__r.Site__r.Site_Supervisor__c);
                    
                    
                    Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
                    approvalRequest.setComments('submitted  for Approval');
                    approvalRequest.setObjectId(ex.Id);
                    approvalRequest.setNextApproverIds(new Id[] {ex.Service_Provider_Name__r.Site__r.Site_Supervisor__c});
                    appRequest.add(approvalRequest);
                }
                
                Approval.process(appRequest);
            
        }

    }
    
    @Future
    public static void sendApprovaltoclusterHead(set<id>exptList){
       
        list<Advance__c> extL =[select id,Service_Provider_Name__c,Status__c , Service_Provider_Name__r.Site__r.HR__c from Advance__c where id  in:exptList];
        system.debug('extList'+exptList);
        system.debug('extL'+extL[0].Service_Provider_Name__r.Site__r.HR__c); 
        List<Approval.ProcessSubmitRequest> appRequest = new List<Approval.ProcessSubmitRequest>();
        for(Advance__c ex :extL ){
            if(ex.Status__c == 'Approved by Site Manager' && ex.Service_Provider_Name__r.Site__r.HR__c !=null ){
                Approval.ProcessSubmitRequest approvalRequest1 = new Approval.ProcessSubmitRequest();
                approvalRequest1.setObjectId(ex.Id);
                approvalRequest1.setNextApproverIds(new Id[] {ex.Service_Provider_Name__r.Site__r.HR__c});
                Approval.process(approvalRequest1);
            }
        }

    }
}