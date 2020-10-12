public class UpdateConHandler {
 public static void isStatusChecked(List<Contract> ContractLst,Map<Id,Contract> oldLeadMap){
        system.debug('Step 13 isStatusChecked');
        Map<String,String> stageMap = 
                          new Map<String,String>{
                                    'Upload Signed Contract'=>'Historical',
                                    'Historical'=>'Active',
                                    'Active'=>'Active'
                                    
                         };
                         
        for(Contract con : ContractLst){
            system.debug('!!@'+con.Task_Stage__c);
            system.debug('###'+con.Question__c);
                if((con.Status == 'Historical'  )
                     && con.Task_Stage__c ){
                     system.debug('con.status >> ' + con.status);
                     con.Status=stageMap.get(con.Status);
                     con.Task_Stage__c = false;
                }
                else if((con.Status == 'Upload Signed Contract' || con.Status == 'Active')
                      &&
                     con.Question__c && con.Task_Stage__c){
                    con.Status=stageMap.get(con.Status);
                    con.Task_Stage__c = false;
                    con.Question__c = false;
                }else if(con.Status != oldLeadMap.get(con.Id).Status)
                    con.addError('Before changing the sub-stage ,please fill all questionnaire and complete the tasks');
                
            
        }
    } 
}