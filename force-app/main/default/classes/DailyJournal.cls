public class DailyJournal {
    @AuraEnabled
    public static List<LogWrapper> getJournal(){
        //List<Log_Line_Hour__c> LOGLSTs = new List<Log_Line_Hour__c>(); 
        
        Date TODAY = System.today();
        String currentUserId = UserInfo.getUserId();
        
        Set<String> existingLogTaskSet = new Set<String>();
        List<LogWrapper> logWrapperLst = new List<LogWrapper>();
        
        for(Log_Line_Hour__c llh : [SELECT Id,Hours__c,Details__c,Date__c,Lead__c,Lead__r.Name,Account__c,Account__r.Name,Category__c,Log_Hour__c,
                                    Task__c FROM Log_Line_Hour__c WHERE
                                    Log_Hour__r.Date__c =: TODAY AND Log_Hour__r.Log_Assigned__c =: currentUserId]){
                                        existingLogTaskSet.add(llh.Task__c);
                                        LogWrapper lw = new LogWrapper();
                                        lw.Id = llh.Id;
                                        lw.Details = llh.Details__c;
                                        if(String.isNotBlank(llh.Account__c)){
                                            lw.AccountId = llh.Account__c;
                                            lw.AccountName = llh.Account__r.Name;
                                        }
                                        if(String.isNotBlank(llh.Lead__c)){
                                            lw.LeadId = llh.Lead__c;
                                            lw.LeadName = llh.Lead__r.Name;
                                        }
                                        lw.Category = llh.Category__c;
                                        lw.Hours = llh.Hours__c;
                                        lw.TaskId = llh.Task__c;
                                        lw.Log_Hour = llh.Log_Hour__c;
                                        if(String.isNotBlank(llh.Account__c)){
                                            lw.Type = 'Account';    
                                        }else if(String.isNotBlank(llh.Lead__c)){
                                            lw.Type = 'Lead';
                                        }
                                        
                                        logWrapperLst.add(lw);
                                        
                                    }
        for(Task tk :[SELECT Id,Subject,WhatId,What.Name,WhoId,Who.Name FROM Task 
                      WHERE OwnerId =:currentUserId AND ActivityDate = TODAY ]){
                          if(existingLogTaskSet.contains(tk.Id))
                              continue;
                          LogWrapper lw = new LogWrapper();
                          lw.Details = tk.Subject;
                          lw.TaskId = tk.Id;
                              
                          if(tk.WhatId != NULL && tk.WhatId.getSObjectType() == Account.sObjectType){
                              lw.AccountId = tk.WhatId;
                              lw.AccountName = tk.What.Name;
                              lw.Type = 'Account';
                              //logWrapperLst.add(lw);
                          }else if(tk.WhoId != NULL && tk.WhoId.getSObjectType() == Lead.sObjectType){
                              lw.LeadId = tk.WhoId;
                              lw.LeadName = tk.Who.Name;
                              lw.Type = 'Lead';
                              
                          }
                          logWrapperLst.add(lw);
                      }
        if(logWrapperLst.size() == 0){
            logWrapperLst.add(new LogWrapper());
        }
        system.debug('Step 1' + logWrapperLst);
        return logWrapperLst;
    }
    @AuraEnabled
    public static void saveJournal(string dailyList,String removeIds){
        //system.debug('>>>>>>>>>>>>>>'+dailyList);
        system.debug('dailyList ' + dailyList);
        Set<String> removeDIds = (Set<String>) JSON.deserialize(removeIds, Set<String>.class);
        List<LogWrapper> logWrapTimeLst = (List<LogWrapper>) JSON.deserialize(dailyList,List<LogWrapper>.class);
        List<Log_Line_Hour__c> logTimeLst = new List<Log_Line_Hour__c>();
        for(LogWrapper lw : logWrapTimeLst){
            Log_Line_Hour__c llh = new Log_Line_Hour__c();
            if(String.isNotBlank(lw.Id))
                llh.Id = lw.Id;
            llh.Details__c = lw.Details;
            llh.Account__c = NULL;
            llh.Lead__c = NULL;
            system.debug('type '+lw.Type);
            if(lw.Type == 'Account' && String.isNotBlank(lw.AccountId))
                llh.Account__c = lw.AccountId;
            else if(lw.Type == 'Lead' && String.isNotBlank(lw.LeadId))
                llh.Lead__c = lw.LeadId;
            llh.Category__c = lw.Category;
            llh.Hours__c = lw.Hours;
            if(String.isNotBlank(lw.TaskId))
            llh.Task__c = lw.TaskId;
            /*if(String.isNotBlank(lw.Log_Hour))
                llh.Log_Hour__c = lw.Log_Hour;*/
            logTimeLst.add(llh);
        }
        Map<String,Log_Line_Hour__c> upsertLogs = new Map<String,Log_Line_Hour__c>();
        List<Log_Hour__c> logLst = new List<Log_Hour__c>();
        
        Date TODAY = System.today();
        String currentUserId = UserInfo.getUserId();
        String logHoursId = '';
        List<Log_Hour__c> lg = [SELECT Id FROM Log_Hour__c WHERE Date__c =: TODAY 
                                AND Log_Assigned__c =: currentUserId LIMIT 1];
        if(lg.size() > 0){
            logHoursId = lg[0].Id;      
        }else{
            Log_Hour__c newLog = new Log_Hour__c(Log_Assigned__c = currentUserId, Date__c = TODAY);
            insert newLog;
            logHoursId = newLog.Id;   
        }
        if(String.isNotBlank(logHoursId)){
            List<Log_Line_Hour__c> logLineLst = new List<Log_Line_Hour__c>();
            for(Log_Line_Hour__c  llh : logTimeLst){
                if(String.isBlank(llh.Id))
                    llh.Log_Hour__c = logHoursId;
                logLineLst.add(llh);
            }   
            if(logLineLst.size() > 0){
                upsert logLineLst;
            }
            
        }
        if(removeDIds.size() > 0){
            system.debug('removeDIds ' + removeDIds);
            delete [SELECT Id FROM Log_Line_Hour__c WHERE Id IN : removeDIds];
        }        
    }
    public class LogWrapper{
        @AuraEnabled
        public String Id{get;set;}
        @AuraEnabled
        public String AccountId{get;set;}
        @AuraEnabled
        public String AccountName{get;set;}
        @AuraEnabled
        public String LeadId{get;set;}
        @AuraEnabled
        public String LeadName{get;set;}
        
        @AuraEnabled
        public Decimal Hours{get;set;}
        @AuraEnabled
        public String Details{get;set;}
        @AuraEnabled
        public String Category{get;set;}
        @AuraEnabled
        public String TaskId{get;set;}
        @AuraEnabled
        public String Log_Hour{get;set;}
        @AuraEnabled
        public String Type{get;set;}
    }
}