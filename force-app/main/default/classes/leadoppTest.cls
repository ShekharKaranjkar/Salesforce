@isTest
public class leadoppTest {
	static testMethod void testName(){
        Account accObject = new Account();
        accObject.Name ='TESTACCOUNT';
        accObject.Lithium_Billing_Entity__c = 'Bangalore';
        accObject.Lithium_Bank_Account__c = 'State Bank';
        Insert accObject;
        
        
        Opportunity oppObject1 = new Opportunity();
        oppObject1.Name = 'TESTOPPORTUNITY';
        oppObject1.AccountId = accObject.id;
        oppObject1.CloseDate = date.today()+2;
        oppObject1.StageName='	M1: Solution Sent for Approval';
        Insert oppObject1;

           
        Task taskObject = new Task();
        taskObject.OwnerId = UserInfo.getUserId();
        taskObject.Subject='Donni';
        taskObject.Status='Not Started';
        taskObject.Priority='Normal';
		taskObject.WhatId = oppObject1.id;
        insert taskObject; 
        
        String jsonOpportunity = JSON.serialize(oppObject1);
        
        Opportunity oppObject = new Opportunity();
        oppObject.Name = 'TESTOPPORTUNITY1';
        oppObject.AccountId = accObject.id;
        oppObject.CloseDate = date.today()+2;
        oppObject.StageName='	M1: Solution Sent for Approval';
        oppObject.Task_Stage__c = false;
        oppObject.Question__c = false;
        oppObject.Have_we_internally_reviewed_the_final__c='Test';
        oppObject.Does_the_solution_meet_the_client_object__c='Test';
        oppObject.Approval_Status__c ='Approved';
        Insert oppObject;
        
        
        test.startTest();
        leadopp.createRecord(jsonOpportunity);
        leadopp.getleadvalues(oppObject.id);
        leadopp.updateOpportunity(oppObject.id);
        OPPController.getoppvalues(oppObject.id);
        test.stopTest();
    }
}