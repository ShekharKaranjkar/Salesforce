/*
* To check Driving License Expire Date in Complaince,
* And Send Email ,Bell Notifications & Notification record will also create before 2 weeks,
* Email will send to particular Campus Assigned Site Manager.
*/

global class Batch_DrivingExpireDate implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id,Name,Driving_License_Expire_Date__c,Lithium_ID__c,Sp_Phone_Number__c,Lithium_ID__r.Site__r.Site_Supervisor__r.Email,Lithium_ID__r.Status__c,Lithium_ID__r.Name,Lithium_ID__r.Site__r.Site_Supervisor__c,'+
                                        'Service_Provider_Name__c FROM Compliance__c where Driving_License_Expire_Date__c !=null And Lithium_ID__c !=null AND Lithium_ID__r.Status__c =\'Active\'' );
    }
    
    
    
    global void execute(Database.BatchableContext BC, List<Compliance__c> complainceList){
        Date before2days = system.today();
        
        list<Notification__c> notificationInsertlist = new  list<Notification__c>();
        List<String>userIdsList = New List<String>();
        List<String>useremailList = New List<String>();
        set<string> serviceProIds = new set<string>();
        for(Compliance__c co:  [select id,Lithium_ID__c,Lithium_ID__r.name,Lithium_ID__r.Phone_Number__c from Compliance__c where id=: complainceList]){
            serviceProIds.add(co.Lithium_ID__c);
            
        }
        
      
        system.debug('useremailList-------'+useremailList);
        set<id> comId=new set<id>();
        set<string> comname=new set<string>();
        Id comIdOne;
        string comnamee;
        string spname;
        Map<Id,String>ComplaiceNamesMap =New Map<Id,String>();
        Map<Id,Id> serviceProIDUserIdMap= new Map<Id,Id>();
        for(user u:[select id,username,Name,contact.Service_Provider__c from User where contact.Service_Provider__c  IN :serviceProIds]){
            serviceProIDUserIdMap.put(u.contact.Service_Provider__c,u.Id);
        }
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        for(Compliance__c com : complainceList){
            system.debug('com--'+com);
            comId.add(com.Id);
            comname.add(com.Name);
            comIdOne=com.Id;
            system.debug('comIdOne'+comIdOne);
            comnamee=com.Name;
            spname =com.Lithium_ID__r.Name;
            if(serviceProIDUserIdMap.containsKey(com.Lithium_ID__c)){
                if(com.Driving_License_Expire_Date__c.adddays(-14) == before2days && com.Lithium_ID__r.Status__c=='Active' ){
                    Notification__c noti = new Notification__c();
                    noti.User_Id__c = serviceProIDUserIdMap.get(com.Lithium_ID__c);
                    
                    noti.Message__c = 'Driving License is going to Expire with in 2 Weeks ';
                    noti.Compliance__c = com.id;
                    notificationInsertlist.add(noti);
                    system.debug('notificationInsertlist 27'+notificationInsertlist);
                    
                    Map<String, Object> params = new Map<String, Object>();
                    params.put('TargetId', com.id);
                    params.put('NotificationTitle', 'Reminder for Driving License Expiry ');
                    params.put('NotificationBody', 'Driving License is going to Expiry with in Two Weeks for Compliance '+ '  ' + com.Name +' And Service Provider Name -' + '  ' + com.Service_Provider_Name__c);
                    
                    if(com.Id !=null &&  com.Lithium_ID__r.Site__r.Site_Supervisor__c != null) {
                       
                            mail.setToAddresses(New list<String>{com.Lithium_ID__r.Site__r.Site_Supervisor__r.Email}); 
                            
                            
                            params.put('NotificationRecipientIDs', com.Lithium_ID__r.Site__r.Site_Supervisor__c);
                            Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
                            flowToRemoveAcc.start(); 
                            
                        
                    }  
                }
            }
            
            
            ComplaiceNamesMap.put(com.id,com.Name);
            
        }
        if(notificationInsertlist.size()> 0){
            insert notificationInsertlist;
            system.debug('notificationInsertlist---------->>>'+notificationInsertlist);
            
            String messageBody;
            
            // String[] toAddresses = new String[] {'chandrasekar@dazeworks.com'};
            
            //mail.setToAddresses(useremailList);
            //  mail.setToAddresses(toAddresses);
            //mail.setTargetObjectId(u.Id);
            mail.setSubject('Driving Licence is Going to Expiry for Service Provider ');
            mail.setSaveAsActivity(false);
            // mail.setPlainTextBody('Driving License is going to Exipry with in Two Days for Compliance');
            string mailLink='https://lithium--uat.lightning.force.com/lightning/r/Compliance__c/'+comIdOne+'/view';
            //   mail.setHtmlBody('Driving License is going to Exipry with in Two Days for : ' + comnamee + ' ' + mailLink);
            
            messageBody = '<html><body> Hi Sir/Madam, '  + '<br><br>This Email is Regarding to Inform you that the Driving Licence is going to Expiry for Service Provider - ' +  spname  + ' within 2 Weeks. ' + '<br><br>Compliance Record Name :  ' + comnamee +' .' + '<br><br>Click the link to open Compliance Record  : ' + mailLink  +'<br><br> I Request you to please complete  it ASAP.' +'<br><br> Thanks and Regards,</body></html>';
            mail.setHtmlBody(messageBody);
            if(!Test.isRunningTest()){
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }        
        }
    }
    
    
    global void finish(Database.BatchableContext BC){
        
        
        
    }
}