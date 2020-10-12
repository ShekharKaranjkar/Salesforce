@isTest
public class DailyJournalTest {

    @isTest
    public static void unitTest(){
        Account acc = new Account(Name ='Test');
        insert acc;
        
        Lead lead = new Lead(LastName ='Test',Company='Test1',Status='C1: New');
        insert lead;
        
        Log_Hour__c lh = new Log_Hour__c();
        lh.Log_Assigned__c = UserInfo.getUserId();
        lh.Date__c = system.today();
        insert lh;
        
        Id RecordTypeIdTask = Schema.SObjectType.Task.getRecordTypeInfosByName().get('MPM4_BASE').getRecordTypeId();
        
        Task task = new Task();
        task.OwnerId = userInfo.getUserId();
        task.ActivityDate = system.today();
        task.RecordTypeId = RecordTypeIdTask;
        //task.WhatId = acc.Id;
        insert task;
        
        Log_Line_Hour__c llh = new Log_Line_Hour__c();
        llh.Account__c = acc.Id;
        llh.Log_Hour__c = lh.Id;
        llh.Task__c = task.id;
        insert llh;
    	
        Log_Line_Hour__c llh1 = new Log_Line_Hour__c();
        llh1.Lead__c = lead.Id;
        llh1.Log_Hour__c = lh.Id;
        insert llh1;
        
        
        
        DailyJournal.getJournal();
 		
        List<DailyJournal.LogWrapper> djLst = new List<DailyJournal.LogWrapper>();
        DailyJournal.LogWrapper dl = new DailyJournal.LogWrapper();
        dl.AccountId = acc.Id;
        dl.AccountName = 'Test2';
        dl.Log_Hour = '2';
        dl.Id = llh1.Id;
		djLst.add(dl);        
        
        Set<String> removeIds = new Set<String>();
        removeIds.add(lh.Id);
        DailyJournal.saveJournal(JSON.serialize(djLst),JSON.serialize(removeIds));
        
    }
}