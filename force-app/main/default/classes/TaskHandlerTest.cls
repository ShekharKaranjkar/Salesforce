@isTest
public class TaskHandlerTest {
    static testMethod void testName(){
        List<Task> taskList = new List<Task>();
        Map<Id,Task> oldTaskMap = new Map<Id,Task>();
        
        Lead leadObject = new Lead();
        leadObject.LastName = 'TESTLEAD';
        leadObject.Company = 'XYZ';
        leadObject.Status = 'C1: New';
        leadObject.LeadSource = 'Cold Call';
        insert leadObject;
        
        Task taskObject = new Task();
        taskObject.OwnerId = UserInfo.getUserId();
        taskObject.Subject='Donni';
        taskObject.WhoId = leadObject.id;
        taskObject.Status='Not Started';
        taskObject.Priority='Normal';
		oldTaskMap.put(taskObject.id,taskObject);
        
        //insert oldTaskMap;
        Task taskObject1 = new Task();
        taskObject1.OwnerId = UserInfo.getUserId();
        taskObject1.Subject='Donni';
        taskObject1.WhoId = leadObject.id;
        taskObject1.Status='Completed';
        taskObject1.Priority='Normal';
		taskList.add(taskObject1);
        
        test.startTest();
        
        TaskHandler.updateparentrecords(taskList,oldTaskMap);
        
        test.stopTest();
        
    }
    @isTest
    public static void unitTest2(){
        Account Acc = new Account();
        Acc.Name = 'Test 15:56';
        Acc.Lithium_Bank_Account__c  = 'Bangalore';
        Acc.Lithium_Billing_Entity__c  = 'Canara Bank';
        Insert Acc;
        
        Contract contractte1= new Contract();
        contractte1.Status = 'Upload Signed Contract';
        //contractte1.Question__c = true;
        //contractte1.Task_Stage__c = true;
        contractte1.AccountId = Acc.Id;
        insert contractte1; 
       
        Opportunity opp = new Opportunity();
        opp.StageName = 'M1: Solution Sent for Approval';
        opp.Name = 'test'; 
        opp.CloseDate = System.today();
        opp.Contract_Term__c = '12';
        insert opp;
        
        Task taskObject = new Task();
        taskObject.OwnerId = UserInfo.getUserId();
        taskObject.Subject='Donni';
        taskObject.WhatId = contractte1.id;
        taskObject.Status='Not Started';
        taskObject.Priority='Normal';
		insert taskObject; 
        //oldTaskMap.put(taskObject.id,taskObject);
        
        //insert oldTaskMap;
        Task taskObject1 = new Task();
        taskObject1.OwnerId = UserInfo.getUserId();
        taskObject1.Subject='Donni';
        taskObject1.WhatId = opp.id;
        taskObject1.Status='Not Started';
        taskObject1.Priority='Normal';
		insert taskObject1;
        
        taskObject.Status ='Completed';
        update taskObject;
        taskObject1.Status ='Completed';
        update taskObject1;
    }
    
   
}