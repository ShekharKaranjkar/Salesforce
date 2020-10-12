global class Batch_InactivityReminder implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        Date presentDate = system.today().addDays(10);
        return Database.getQueryLocator('select id,name,Status__c,Account_Settlement__c,Site_Manager_Settlement__c,Maintenance_Team_Settlement__c,Last_Name__c,Inactive_From__c,Site__r.Site_Supervisor__r.Id,Site__r.Maintenance_Manager__r.id,Site__r.Maintenance_Manager__r.Email,Site__r.Site_Supervisor__r.Email  from Service_Provider__c where Status__c =\'InActive\' and Inactive_From__c <= :presentDate and (Account_Settlement__c = false or Site_Manager_Settlement__c = false or Maintenance_Team_Settlement__c = false)');
    }
    global void execute(Database.BatchableContext BC, List<Service_Provider__c> spList){
        
        list<Notification__c> notificationInsertlist = new list<Notification__c>();
        List<String>userId = new List<String>();
        
        List<String>userIdsList = New List<String>();
        List<String>useremailList = New List<String>();
          List<String>usernameList = New List<String>();
        
        List<String>userIdsSM = New List<String>();
        List<String>useremailSM = New List<String>();
        
        List<String>userIdsAT = New List<String>();
        List<String>useremailAT = New List<String>();
        List<String>mmUser = New List<String>();
        
        for (User ATT :  [select id,Email from User where IsActive = True AND  Profile.Name in ('Account Team')]){
            userIdsAT.add(ATT.id);
            useremailAT.add(ATT.Email);
          	//system.debug('useremailAT'+useremailAT);
        }
        Map<String, Object> params = new Map<String, Object>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        for(Service_Provider__c sp : spList){
            boolean flag = false;
            system.debug('spNamesssss'+sp.Name);
            params.put('TargetId', sp.id);
            String messageBody;
            params.put('NotificationTitle', 'Reminder for Settelement ');
            params.put('NotificationBody', 'Is there any due or upcoming for Service Provider - '+sp.Name +' in terms of settlement if yes then do settlement ASAP. ');
            if(sp.id != null && sp.Site_Manager_Settlement__c == false && sp.Site__r.Site_Supervisor__c != NULL){
                mail.setToAddresses(new List<String>{sp.Site__r.Site_Supervisor__r.Email});
                flag = true;
                params.put('NotificationRecipientIDs', sp.Site__r.Site_Supervisor__c); 
                Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
                flowToRemoveAcc.start();
                
            }
            if(sp.id != null &&sp.Maintenance_Team_Settlement__c == false && sp.Site__r.Maintenance_Manager__c != NULL){
                //system.debug('inside msintanace settlement'+sp.Name);               
                //system.debug('umaintanace'+userIdsList); 
                mail.setToAddresses(New list<String>{sp.Site__r.Maintenance_Manager__r.Email}); 
                flag = true;
                params.put('NotificationRecipientIDs', sp.Site__r.Maintenance_Manager__c); 
                Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
                flowToRemoveAcc.start();

            }
            if(sp.id != null &&sp.Account_Settlement__c == false){
    			system.debug('inside account settlement'+sp.Name);
               // params.put('NotificationRecipientIDs', userIdsAT); 
               if(useremailAT.size()>0){
                   system.debug('userIdsAT'+userIdsAT);
                   mail.setToAddresses(useremailAT);  
                   flag = true;
                   params.put('NotificationRecipientIDs', userIdsAT); 
                   Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
                   flowToRemoveAcc.start();
				}
            }
            //mail.setToAddresses(toAddresses);
            mail.setSubject('Settlement Reminder for Service Provider');
            mail.setSaveAsActivity(false);
           messageBody = '<html><body> Hi Sir/Madam, '  + '<br><br>This Email is Regarding to Inform you that you that Its already 10 days to Exit the Service Provider and the Settlement is Pending from your side for Service Provider  - ' + sp.Name +'<br><br>I Request you to please complete it ASAP.' +'<br><br>For More Query Please contact to HR or Admin regarding Exit Process.' +'<br><br> Thanks and Regards,</body></html>';
            mail.setHtmlBody(messageBody);
           // mail.setPlainTextBody(' Hi '+ usernameList +' This mail is regarding any due or upcoming for Service Provider - '+sp.Name +' in terms of settlement if yes then do settlement ASAP. ');
            if(params.size()> 0 &&  flag ){
                system.debug('params'+params);
               // Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
               // flowToRemoveAcc.start();  

                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
            }
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
        
        
    }
}