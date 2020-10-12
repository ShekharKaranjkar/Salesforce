public class ContractHandler {
 public Static void updateparentrecords(List<Task> taskList,Map<Id,Task>oldTaskMap){
        Set<String> whatIdSet = new Set<String>();
        For(Task t:taskList){
            If(t.WhatId != NULL &&
                 t.WhatId.getSobjectType() == Contract.SobjectType && 
                 oldTaskMap.get(t.id).Status != t.status &&
                 t.Status == 'Completed'){
                 system.debug('t Step 21' + t.Id + ' '+ t.Subject);
                whatIdSet.add(t.WhatId);
            }
        }
        if(whatIdSet.size() > 0){
          updateContractFromTask(whatIdSet);
       }
    }
    public static void updateContractFromTask(Set<String> ContractIds){
          if(ContractIds.size() > 0){
            
                List<Contract>ContractList =new List<Contract>();
              Set<String> updateContractSet = new Set<String>();
              For(Contract con:[Select id,Status,Question__c,Task_Stage__c,(Select Id,Subject,Lead_Next_Step__c,status From Tasks
                           WHERE Status != 'Completed') from Contract where Id IN :ContractIds]){
                  for(Task t: con.tasks){
                      
                      system.debug('Step Task Step 10'+ t.Subject );
                    //  system.debug('Step Task Step 11'+ t.status);
                      
                  }
                  if(con.tasks.size() == 0){
                      con.Task_Stage__c = true;
                      ContractList.add(con);
                  }
              }
              if(ContractList.Size()>0){
                  system.debug('Step 7 '+ ContractList);
                  Update ContractList;
                  system.debug('Step 6 '+ ContractList);
              }
          }}}