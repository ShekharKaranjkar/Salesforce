public class UpdateLeadHandler{
    public static void isStatusChecked(List<Lead> leadLst,Map<Id,Lead> oldLeadMap){
        system.debug('Step 13 isStatusChecked');
        Map<String,String> stageMap = 
                          new Map<String,String>{
                                    'C1: New'=>'C2: Working - Not Contacted',
                                    'C2: Working - Not Contacted'=>'C3: Working - Contacted',
                                    'C3: Working - Contacted'=>'U1: First Meeting Done',
                                    'U1: First Meeting Done'=>'U2: Info Exchanged',
                                    'U2: Info Exchanged'=>'U3: All Stakeholders Met',
                                    'U3: All Stakeholders Met' => 'U4: Customer Confirms Need or Sends RFP1',
                                    'U4: Customer Confirms Need or Sends RFP1'=>'U4: Customer Confirms Need or Sends RFP1'
                         };
                         
        for(Lead ld : leadLst){
            system.debug('ld'+ld.Status);
            system.debug('ld.status >> ' + ld.Task_Stage__c);
            system.debug('ld.Question__c >> ' + ld.Question__c);
                if((ld.Status == 'C1: New' || ld.Status == 'C2: Working - Not Contacted' || ld.Status == 'C3: Working - Contacted')
                     && ld.Task_Stage__c ){
                     system.debug('ld.status >> ' + ld.status);
                     ld.Status=stageMap.get(ld.Status);
                     ld.Task_Stage__c = false;
                }
                else if((ld.Status == 'U1: First Meeting Done' || ld.Status == 'U2: Info Exchanged' || 
                    ld.Status == 'U3: All Stakeholders Met' || ld.Status == 'U4: Customer Confirms Need or Sends RFP1' ) &&
                     ld.Question__c && ld.Task_Stage__c){
                    ld.Status=stageMap.get(ld.Status);
                    ld.Task_Stage__c = false;
                    ld.Question__c = false;
                } else if(ld.Status == 'U4: Customer Confirms Need or Sends RFP'){
                    
        }else if(ld.Status != oldLeadMap.get(ld.Id).Status)
                    ld.addError('Before changing the sub-stage ,please fill all questionnaire and complete the tasks');
        }
    } 
}