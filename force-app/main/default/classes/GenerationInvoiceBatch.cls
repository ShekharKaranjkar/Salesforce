global class GenerationInvoiceBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id,Name,Invoice_Creation_Date__c,Invoice_Generation__c FROM Account WHERE Invoice_Creation_Date__c = TODAY');
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accountLst){
        List<Task> taskLst = new List<Task>(); 
        //MPM4_BASE
        User billUser = [SELECT Id FROM User WHERE username =: Label.BillingUser LIMIT 1];
        List<Task> tkLst = [SELECT Id FROM Task WHERE ActivityDate =: system.today() AND Subject = 'Generate Invoice' ];
        if(tkLst.size() == 0){
            Task tk = new Task();
            tk.Subject = 'Generate Invoice';
            //tk.WhatId = acc.Id;
            tk.ActivityDate = system.today();
            tk.OwnerId = billUser.Id;
            tk.Priority = 'Normal';
            tk.IsReminderSet = true;
            tk.Status = 'Open';
            insert tk;
        }
        
        List<Account> accLst = new List<Account>();
        for(Account acc : accountLst){
            if(acc.Invoice_Generation__c == 'Monthly' 
               && acc.Invoice_Creation_Date__c.day() == system.today().day()){
                   acc.Invoice_Creation_Date__c = system.today();
                   accLst.add(acc);
               }else if(acc.Invoice_Generation__c == 'Fortnightly' && 
                        acc.Invoice_Creation_Date__c.addDays(15).day() == system.today().day()){
                            acc.Invoice_Creation_Date__c = system.today();
                            accLst.add(acc);
                        }
            
            
        }
        if(accLst.size() > 0){
            update accLst;
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
        System.schedule('Generation Invoice', strSchedule, new SchedulerGenerationInvoice());
        
    }
}