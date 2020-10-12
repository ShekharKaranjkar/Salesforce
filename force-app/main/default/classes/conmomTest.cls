@isTest
public class conmomTest {
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

        Contract conObject = new Contract();
        conObject.name = 'TEST';
        conObject.Question__c = false;
        conObject.AccountId = accObject.id;
        conObject.Opportunity__c = oppObject1.Id;
        conObject.StartDate = date.today();
        conObject.Status = 'Upload Signed Contract';
        insert conObject;
            
        Task taskObject = new Task();
        taskObject.OwnerId = UserInfo.getUserId();
        taskObject.Subject='Donni';
        taskObject.Status='Not Started';
        taskObject.Priority='Normal';
		taskObject.WhatId = conObject.id;
        insert taskObject; 
        
        String jsonLead = JSON.serialize(conObject);
        
        test.startTest();
        conmom.createRecord(jsonLead);
        conmom.getleadvalues(conObject.id);
        test.stopTest();
}
}