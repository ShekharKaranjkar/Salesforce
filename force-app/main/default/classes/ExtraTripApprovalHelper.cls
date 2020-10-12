/*
 * Two Way Approval for particular campus assigned Site Incharge & City Head for Extra Trip.
 */
public class ExtraTripApprovalHelper {
    public static void sendApproval(list<Extra_Trip__c>extList){
        
        list<Extra_Trip__c> extL =[select id,Service_Provider_Name__c, Lithium_ID__r.Site__r.Site_Supervisor__r.Name,Status__c,Lithium_ID__r.Site__r.City_Head__c,
                                   Lithium_ID__r.Site__r.Site_Supervisor__c from Extra_Trip__c where id  in:extList AND Lithium_ID__r.Status__c ='Active'];
        system.debug('extList'+extList);
        system.debug('extL'+extL[0].Lithium_ID__r.Site__r.Site_Supervisor__c);   
        List<Approval.ProcessSubmitRequest> appRequest = new List<Approval.ProcessSubmitRequest>();
        for(Extra_Trip__c ex :extL ){
            system.debug('ex'+ex);
           
                if(ex.Status__c == 'Initiate' && ex.Lithium_ID__r.Site__r.Site_Supervisor__c !=null ){
                    system.debug('ex.Lithium_ID__r.Site__r.Site_Incharge__r.Id'+ex.Lithium_ID__r.Site__r.Site_Supervisor__c);
                    
                    
                    Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
                    approvalRequest.setComments('submitted  for Approval');
                    approvalRequest.setObjectId(ex.Id);
                    approvalRequest.setNextApproverIds(new Id[] {ex.Lithium_ID__r.Site__r.Site_Supervisor__c});
                    appRequest.add(approvalRequest);
                }
                
                Approval.process(appRequest);
            
        }
    }
    
    @Future
    public static void sendApprovaltoclusterHead(set<id>exptList){
        
        list<Extra_Trip__c> extL =[select id,Service_Provider_Name__c, Lithium_ID__r.Site__r.Site_Incharge__r.Name,Status__c,Lithium_ID__r.Site__r.City_Head__c,
                                   Lithium_ID__r.Site__r.Site_Incharge__c from Extra_Trip__c where id in:exptList];
        system.debug('extList'+exptList);
        system.debug('extL'+extL[0].Lithium_ID__r.Site__r.City_Head__c); 
        List<Approval.ProcessSubmitRequest> appRequest = new List<Approval.ProcessSubmitRequest>();
        for(Extra_Trip__c ex :extL ){
            if(ex.Status__c == 'Approved by Site Manager' && ex.Lithium_ID__r.Site__r.City_Head__c !=null ){
                Approval.ProcessSubmitRequest approvalRequest1 = new Approval.ProcessSubmitRequest();
                approvalRequest1.setObjectId(ex.Id);
                approvalRequest1.setNextApproverIds(new Id[] {ex.Lithium_ID__r.Site__r.City_Head__c});
                Approval.process(approvalRequest1);
            }
        }
    }
}