/*
 * To check Driving Badge Expire Date in Complaince,
 * And Send Email ,Bell Notifications & Notification record will also create before 2 weeks,
 * Email will send to particular Campus Assigned Site Manager.
 */



global class Batch_DrivingBadgeExpireDate implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id,Name,Driving_Badge_Expire_Date__c ,Lithium_ID__c,Sp_Phone_Number__c,Lithium_ID__r.Name,Lithium_ID__r.Site__r.Site_Supervisor__c,'+
                                        'Service_Provider_Name__c FROM Compliance__c where Driving_Badge_Expire_Date__c !=null And Service_Provider_Name__c !=null AND Lithium_ID__r.Status__c =\'Active\'');
    }
    
    global void execute(Database.BatchableContext BC, List<Compliance__c> complainceList){
        Date before2days = system.today();
        list<Notification__c> notificationInsertlist = new  list<Notification__c>();
        List<String>userIdsList = New List<String>();
         List<String>useremailList = New List<String>();
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();        
        
        for (User member :  [select id, Email from User where IsActive = True AND  Profile.Name in ('Site Manager')]){
            userIdsList.add(member.id);
              useremailList.add(member.Email);
        }
         set<string> setnumber = new set<string>();
       for(Compliance__c co:  [select id,Lithium_ID__c,Lithium_ID__r.name,Lithium_ID__r.Phone_Number__c from Compliance__c where id=: complainceList]){
           setnumber.add(co.Lithium_ID__r.Phone_Number__c +'@lithium.com');
            system.debug('setnumber----'+setnumber);
        }
        system.debug('user'+userIdsList);
        system.debug('useremailList-------'+useremailList);
        //     Map<Id,String>VehicleNamesMap =New Map<Id,String>();
         set<id> comId=new set<id>();
        Id comIdOne;
         string comnamee;
           string spname;
         list<user> userId= [select id,username,Name from User where username =:setnumber ];
           system.debug('userId 00000'+userId);
        for(Compliance__c com : complainceList){
             comId.add(com.Id);
             comIdOne=com.Id;
             comnamee=com.Name;
              spname =com.Lithium_ID__r.Name;
            system.debug(before2days);
            system.debug(com.Driving_Badge_Expire_Date__c.adddays(-14));
            system.debug('Service_Provider_Name__c'+com.Sp_Phone_Number__c);
            system.debug('userId----------'+userId);
            
            if(com.Driving_Badge_Expire_Date__c.adddays(-14) == before2days ){
                Notification__c noti = new Notification__c();
                noti.User_Id__c = userId[0].id;
                noti.Message__c = 'Driving Badge is going to Expire with in 2 Weeks ';
                noti.Compliance__c = com.id;
                notificationInsertlist.add(noti);
                system.debug('notificationInsertlist 27'+notificationInsertlist);
                
                
                Map<String, Object> params = new Map<String, Object>();
                params.put('TargetId', com.id);
                params.put('NotificationTitle', 'Reminder for Driving Badge Expiry for Service Provider');
                params.put('NotificationBody', ' Driving Badge is going to Expire with in Two Weeks for Compliance '+ ' ' + com.Name + ' ' + ' and Service Provider Name -  '+ '  ' + com.Service_Provider_Name__c);
                if(com.Id !=null && userIdsList.contains( com.Lithium_ID__r.Site__r.Site_Supervisor__c) ) {
                     if(useremailList.size()>0){
                             mail.setToAddresses(useremailList); 
                params.put('NotificationRecipientIDs', userIdsList);
                Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
                flowToRemoveAcc.start();
                     }
                }
            }
            //   VehicleNamesMap.put(com.id,com.Name);
            
        }
        
        if(notificationInsertlist.size()> 0){
            insert notificationInsertlist;
            system.debug('notificationInsertlist---------->>>'+notificationInsertlist);
            
              String messageBody;
         
        
                
                //mail.setToAddresses(useremailList);
                //mail.setToAddresses(toAddresses);
            //mail.setTargetObjectId(u.Id);
            mail.setSubject('Driving Badge is going to Exipre ');
            mail.setSaveAsActivity(false);
            mail.setPlainTextBody('Driving Dadge is going to Exipry with in Two Days for Compliance');
             string mailLink='https://lithium--dev.lightning.force.com/lightning/r/Compliance__c/'+comIdOne+'/view';
              //  mail.setHtmlBody('Driving License is going to Exipry with in Two Days for :' + comnamee + ' ' +mailLink);
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