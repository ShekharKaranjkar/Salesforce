global class BatchTask implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id,Name,Delivery_Date__c FROM Vehicle__c where Delivery_Date__c !=null');
    }
    
    global void execute(Database.BatchableContext BC, List<Vehicle__c> vehicleLst){
        Date before3days = system.today();
        Date before7dys = system.today();
        Date onthatday = system.today();
        List<Task> taskLst = new List<Task>(); 
        /*  List<String>userIdsList = New List<String>();

for (User member :  [select id,name from User where IsActive = True AND  User.Name in ('Sanjay Krishnan')]){
userIdsList.add(member.id);
}
system.debug('user'+userIdsList); */
        List<String>userIdsList = New List<String>();
        
        for (User member :  [select id from User where IsActive = True AND  Profile.Name in ('System Administrator','Maintenance Manager','Maintenance Head','Maintenance Executive')]){
            userIdsList.add(member.id);
        }
        system.debug('user'+userIdsList);
        Map<Id,String>VehicleNamesMap =New Map<Id,String>();
        for(Vehicle__c veh : vehicleLst){
            system.debug(before3days);
            system.debug(veh.Delivery_Date__c.adddays(-3));
            
            if(veh.Delivery_Date__c.adddays(-3) == before3days ){
                Task tk = new Task();
                tk.Subject = 'Follow-up for Delivery of Vehicles ';
                tk.Priority = 'Normal';
                tk.Status = 'Open';
                // tk.OwnerId = '0055D000002vhCqQAI';
                tk.WhatId = veh.id;
                tk.ActivityDate = system.today().addDays(7);
                taskLst.add(tk);
                system.debug('tk'+ taskLst);
            }else
                
                if(veh.Delivery_Date__c.adddays(-7) == before7dys ){
                    Task tks = new Task();
                    tks.Subject = 'Order Accessories ';
                    tks.Priority = 'Normal';
                    tks.Status = 'Open';
                    tks.WhatId = veh.id;
                    //  tks.OwnerId = '0055D000002vhCqQAI';
                    tks.ActivityDate = system.today().addDays(7);
                    taskLst.add(tks);
                    // system.debug('tks'+ taskLst);
                  
                }else
                    if(veh.Delivery_Date__c == onthatday ){
                        Task tkss = new Task();
                        tkss.Subject = 'Take Delivery of Vehicles Today ';
                        tkss.Priority = 'Normal';
                        tkss.Status = 'Open';
                        // tkss.OwnerId = '0055D000002vhCqQAI';
                        tkss.WhatId = veh.id;
                        tkss.ActivityDate = system.today().addDays(7);
                        taskLst.add(tkss);
                        // system.debug('rr'+taskLst);
                    }
            VehicleNamesMap.put(veh.id,veh.Name);
        }
        system.debug('taskLst'+taskLst);
        if(taskLst.size() > 0){
            insert taskLst;
            system.debug('qw'+taskLst);
            for(Task t:taskLst){
                if(t.id != Null && t.Subject == 'Order Accessories '){
                      Map<String, Object> params = new Map<String, Object>();
                    params.put('TargetId', t.id);
                    params.put('NotificationTitle', 'Reminder for Task');
                    params.put('NotificationBody', 'one week remaining for '+t.Subject+' with vehicle' +VehicleNamesMap.get(t.WhatId));
                    params.put('NotificationRecipientIDs', userIdsList);
                    Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
                    flowToRemoveAcc.start();
                }
            }
        } 
    }
    
    global void finish(Database.BatchableContext BC){
        
        
        
    }
}