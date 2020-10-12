@isTest
public class contractActivation_Test {
    static testmethod void contractactivation(){
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Opportunity' and Name = 'Actual'].Id;        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User usrObj = new User();
        usrObj.LastName = 'TestLast';
        usrObj.FirstName='TestFirst';
        usrObj.Alias = 'tst';
        usrObj.Email = 'test@test.com';
        usrObj.Username = 'testkalasinj@gmail.com.staging';
        usrObj.ProfileId = profileId.id;
        usrObj.TimeZoneSidKey = 'GMT';
        usrObj.LanguageLocaleKey = 'en_US';
        usrObj.EmailEncodingKey = 'UTF-8';
        usrObj.LocaleSidKey = 'en_US';
        usrObj.IsActive=True;
        //usrObj.userRoleId='00EC0000001EkqFMAS';
        //usrObj.UserRole.Name='CRM Rep';
        insert usrObj;
        
        
        Account Acc = new Account();
        Acc.Name = 'Test 15:56';
        Acc.Lithium_Bank_Account__c  = 'Bangalore';
        Acc.Lithium_Billing_Entity__c  = 'Canara Bank';
        Insert Acc;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'testtest';
        opp.AccountId = Acc.id;
        opp.CloseDate = system.today() +5;
        opp.RecordTypeId =strRecordTypeId ;
        opp.StageName = 'M1: Solution Sent for Approval';
        insert opp;
        Contract contractte= new Contract();
        contractte.Name = 'test';
        contractte.AccountId = acc.Id;
        contractte.StartDate = system.today();
        contractte.Opportunity__c = opp.Id;
        contractte.Status = 'Upload Signed Contract';
        insert contractte;

        test.startTest();
        contractte.Task_Stage__c = true;
        contractte.Question__c = true;
        Update contractte;
        contractte.Task_Stage__c = true;
        contractte.Question__c = true;
        Update contractte;
        
        List<Task>tasklist = [Select id,status from task where WhatId=:contractte.ID];
        for(Task t:tasklist){
            t.status='Completed';
        }
        update tasklist;
        test.stopTest();
       
        
    }
}