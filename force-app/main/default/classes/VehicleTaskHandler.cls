public class VehicleTaskHandler {
    public Static void updateparentrecords(List<Task> taskList,Map<Id,Task>oldTaskMap){
        Set<String> whatIdSet = new Set<String>();
        For(Task t:taskList){
            If(t.WhatId != NULL &&
               t.WhatId.getSobjectType() == Vehicle__c.SobjectType && 
               oldTaskMap.get(t.id).Status != t.status &&
               t.Status == 'Completed'){
                   system.debug('t Step 21' + t.Id + ' '+ t.Subject);
                   whatIdSet.add(t.WhatId);
               }
        }
        if(whatIdSet.size() > 0){
            updateVehicleFromTask(whatIdSet);
        }
    }
    public static void updateVehicleFromTask(Set<String> vehIds){
        if(vehIds.size() > 0){
            
            List<Vehicle__c>vehList =new List<Vehicle__c>();
            Set<String> updatevehSet = new Set<String>();
            For(Vehicle__c l:[Select id,Task_Stage__c,(Select Id,Subject,status From Tasks
                                                       WHERE Status != 'Completed') from Vehicle__c where Id IN :vehIds]){
                                                           for(Task t: l.tasks){
                                                               
                                                               system.debug('Step Task Step 10'+ t.Subject );
                                                               
                                                               
                                                           }
                                                           if(l.tasks.size() == 0){
                                                               l.Task_Stage__c = true;
                                                               vehList.add(l);
                                                           }
                                                       }
            if(vehList.Size()>0){
                system.debug('Step 7 '+ vehList);
                Update vehList;
                system.debug('Step 6 '+ vehList);
            }
        }
    }
}