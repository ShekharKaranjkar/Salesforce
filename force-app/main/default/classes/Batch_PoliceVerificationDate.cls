/*
* To check Police Verification Date in Complaince,
* And Bell Notifications to shif Incharge before 2 weeks,

*/


global class Batch_PoliceVerificationDate implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id,Name,Police_Verification_Date__c,Lithium_ID__c,Lithium_ID__r.Status__c,Lithium_ID__r.Site__r.Site_Supervisor__c,'+
                                        'Service_Provider_Name__c FROM Compliance__c where Police_Verification_Date__c !=null And Service_Provider_Name__c !=null AND Lithium_ID__r.Status__c =\'Active\'  ');
    }
    
    global void execute(Database.BatchableContext BC, List<Compliance__c> complainceList){
        Date before2days = system.today();
        
        //  list<Notification__c> notificationInsertlist = new  list<Notification__c>();
        List<String>userIdsList = New List<String>();
        //        List<String>useremailList = New List<String>();
        
        
        system.debug('user'+userIdsList);
        for(Compliance__c com : complainceList){
            
            system.debug('com'+com);
            system.debug(com.Police_Verification_Date__c.adddays(-14));
            system.debug('Service_Provider_Name__c'+com.Service_Provider_Name__c);
            if(com.Police_Verification_Date__c.adddays(-14) == before2days &&  com.Lithium_ID__r.Site__r.Site_Supervisor__c != null){
                Map<String, Object> params = new Map<String, Object>();
                params.put('TargetId', com.id);
                params.put('NotificationTitle', 'Reminder for Police Verification Date Expiry ');
                params.put('NotificationBody', 'Police Verification is going to Expiry with in Two Weeks for Compliance '+' '+ com.Name +' And Service Provider Name -'+' '+ com.Service_Provider_Name__c);
                params.put('NotificationRecipientIDs',  com.Lithium_ID__r.Site__r.Site_Supervisor__c);
              
                Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
                flowToRemoveAcc.start(); 
            }
            
        }
          
    }        
    
    
    
    global void finish(Database.BatchableContext BC){
        
        
        
    }
}