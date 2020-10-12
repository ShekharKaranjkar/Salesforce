global class FollowUpBatch implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator('SELECT Id,Name FROM Account WHERE Invoice_Follow_up_Date__c = TODAY');
   }

   global void execute(Database.BatchableContext BC, List<Account> accountLst){
     List<Task> taskLst = new List<Task>(); 
     //MPM4_BASE

     for(Account acc : accountLst){
         Task tk = new Task();
         tk.Subject = 'Follow-up: Invoice Payment of ' + acc.Name;
         tk.WhatId = acc.Id;
         tk.Priority = 'Normal';
         tk.Status = 'Open';
         taskLst.add(tk);
     }
     if(taskLst.size() > 0){
         insert taskLst;
     }
   }

   global void finish(Database.BatchableContext BC){
   
        DateTime dt = System.now().addDays(1);
        String day = string.valueOf(dt.day());
        String month = string.valueOf(dt.month());
        String hour = string.valueOf(dt.hour());
        String minute = string.valueOf(dt.minute());
        String second = string.valueOf(dt.second());
        String year = string.valueOf(dt.year());
        String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
        System.schedule('Daily Follow Up Job', strSchedule, new SchedulerFollowUpBatch());
        
   }
}