public class UpdateOppOnTaskCompleteHnadler {
    Public Static void updateparentrecordsopp(List<Task> taskList,Map<Id,Task>oldTaskMap){
      
             Set<String> whatIdSet = new Set<String>();
       
        For(Task t:taskList){
            If(t.WhatId != null && 
               t.WhatId.getSobjectType() == Opportunity.SobjectType &&
               oldTaskMap.get(t.id).Status!=t.status && 
               t.Status == 'Completed')
            {
                               whatIdSet.add(t.whatId);
            }
            }
         if(whatIdSet.size() > 0){
          updateOpportunityFromTask(whatIdSet);
       }
        }
        public static void updateOpportunityFromTask(Set<String>OpportunityIds){

       // system.debug('!!!@'+whatIdMap.size());
        if(OpportunityIds.size()>0){
          //  system.debug('!!!@'+subjectSet);
                List<Opportunity>oppList =new List<Opportunity>();
              Set<String> updateOpportunitySet = new Set<String>();
            For(Opportunity o:[Select id,Stagename,Question__c,Task_Stage__c,(Select Id,Subject,Opp_Next_Step__c From Tasks where Status !='Completed') from Opportunity where Id IN : OpportunityIds]){
                system.debug('!!!@'+o.Tasks.Size());
                  for(Task t: o.tasks){
                  }
                if(o.tasks.size() == 0){
                      o.Task_Stage__c = true;
                      oppList.add(o);
                  }
              }
              if(oppList.Size()>0){
                  system.debug('Step 7 '+ oppList);
                  Update oppList;
                  system.debug('Step 6 '+ oppList);
              }
              
        }
    
    }
}