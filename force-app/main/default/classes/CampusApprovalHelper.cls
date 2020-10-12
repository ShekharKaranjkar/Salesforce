/*
*  Approval for particular campus assigned HR
*/
public class CampusApprovalHelper {
    public static void sendApproval(list<Campus__c>extList,map<id,Campus__c>oldmap){
        
        list<Campus__c> extL =[select id,HR__c,Approval_Request__c,No_of_Buffer__c,Total_Limit__c from Campus__c where id  in:extList];
        system.debug('extList'+extList);
  //      system.debug('extL'+extL[0].HR__c);   
        List<Approval.ProcessSubmitRequest> appRequest = new List<Approval.ProcessSubmitRequest>();
        list<Campus__c> cList=new List<Campus__c>();
        for(Campus__c ex :extL ){
            system.debug('ex'+ex);
            
            if((ex.Approval_Request__c == 'Initiate' ) && ex.No_of_Buffer__c>0 && ex.HR__c !=null ){
                system.debug('ex.Lithium_ID__r.Site__r.Site_Incharge__r.Id'+ex.HR__c);
                
                
                Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
                approvalRequest.setComments('submitted  for Approval');
                approvalRequest.setObjectId(ex.Id);
                approvalRequest.setNextApproverIds(new Id[] {ex.HR__c});
                appRequest.add(approvalRequest);
            }
            
            Approval.process(appRequest);
          
            system.debug('ex.Approval_Request__c=================='+ex.Approval_Request__c);
            if(ex.Approval_Request__c == 'Approve' && oldmap.get(ex.id).Approval_Request__c!=ex.Approval_Request__c && ex.No_of_Buffer__c>0 && ex.HR__c !=null ){
                ex.Approval_Request__c = 'Initiate';
                
                //  if(oldmap.get(ex.id).Approval_Request__c!=ex.Approval_Request__c && ex.Approval_Request__c == 'Approve' && oldmap.get(ex.id).Approval_Request__c =='Initiate'){
                ex.Total_Limit__c = ex.Total_Limit__c + ex.No_of_Buffer__c;
                //   }
                
                ex.No_of_Buffer__c=0;
                cList.add(ex);
            }
            if(ex.Approval_Request__c == 'Approve' && oldmap.get(ex.id).Approval_Request__c=='Approve'){
                  ex.Approval_Request__c = 'Initiate';
                  cList.add(ex);
                  }
                  
            if(ex.Approval_Request__c == 'Remove' && ex.No_of_Buffer__c>0 && ex.HR__c !=null ){
                ex.Approval_Request__c = 'Initiate';
                //ex.Total_Limit__c = ex.Total_Limit__c + ex.No_of_Buffer__c;
                //  ex.No_of_Buffer__c=0;
                cList.add(ex);
            }
            
        }
        update cList;
        
    }
}