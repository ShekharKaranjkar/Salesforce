public class TaskHandler {
    public Static void updateparentrecords(List<Task> taskList,Map<Id,Task>oldTaskMap){
        Set<String> whoIdSet = new Set<String>();
        For(Task t:taskList){
            If(t.WhoId != NULL &&
                 t.WhoId.getSobjectType() == Lead.SobjectType && 
                 oldTaskMap.get(t.id).Status != t.status &&
                 t.Status == 'Completed'){
                 system.debug('t Step 21' + t.Id + ' '+ t.Subject);
                whoIdSet.add(t.WhoId);
            }
        }
        if(whoIdSet.size() > 0){
          updateLeadFromTask(whoIdSet);
       }
    }
    public static void updateLeadFromTask(Set<String> leadIds){
          if(leadIds.size() > 0){
            
                List<Lead>leadList =new List<Lead>();
              Set<String> updateLeadSet = new Set<String>();
              For(Lead l:[Select id,Status,Question__c,Task_Stage__c,(Select Id,Subject,Lead_Next_Step__c,status From Tasks
                           WHERE Status != 'Completed') from Lead where Id IN :leadIds]){
                  for(Task t: l.tasks){
                      
                      system.debug('Step Task Step 10'+ t.Subject );
                    //  system.debug('Step Task Step 11'+ t.status);
                      
                  }
                  if(l.tasks.size() == 0){
                      l.Task_Stage__c = true;
                      leadList.add(l);
                  }
              }
              if(leadList.Size()>0){
                  system.debug('Step 7 '+ leadList);
                  Update leadList;
                  system.debug('Step 6 '+ leadList);
              }
              
            /*For(Lead l:[Select id,Status,Question__c,Task_Stage__c,(Select Id,Subject,Lead_Next_Step__c   From Tasks where Status !='Completed' Order By Lead_Next_Step__c) from Lead where Id IN :leadIds]){
                system.debug('!!!@'+l.Tasks.Size());
                if(l.Tasks.Size() == 0){//o.tasks.IsEmpty()
                    if(l.Status == 'C1: New' || l.Status == 'C2: Working - Not Contacted' || l.Status == 'C3: Working - Contacted'){
                     system.debug('Step 2 '+ l.status);
                        l.Status=stageMap.get(l.Status);
                        //l.Status='U1: First Meeting Done';//stagenameMap1.get(l.Status);
                        
                        if(l.Status != 'U1: First Meeting Done')
                          l.Question__c = true;
                        l.Task_Stage__c = true;
                        system.debug('Step 3 '+ l.Status);
                        system.debug('Step 4 '+ l.Status);
                        
                        updateLeadSet.add(l.id);
                        leadList.add(l);
                    }
                    else{
                        l.Status=stageMap.get(l.Status);
                        l.Task_Stage__c=true;
                        updateLeadSet.add(l.id);
                        system.debug('U1 Step 2 '+ l);
                        leadList.add(l);
                    }
                }
            }
              if(leadList.Size()>0){
                  system.debug('Step 7 '+ leadList);
                  Update leadList;
                  system.debug('Step 6 '+ leadList);
              }*/
              
        }
    }
}