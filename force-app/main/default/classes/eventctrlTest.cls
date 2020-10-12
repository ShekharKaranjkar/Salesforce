@isTest
public class eventctrlTest {
    static testMethod void testName(){
        Account accObject = new Account();
        accObject.Name ='TESTACCOUNT';
        accObject.Lithium_Billing_Entity__c = 'Bangalore';
        accObject.Lithium_Bank_Account__c = 'State Bank';
        Insert accObject;
        
        Contact conObject = new Contact();
        conObject.LastName = 'TESTCONTACT';
        conObject.AccountId = accObject.Id;
        Insert conObject;
        
        Event eventObject = new Event();
        eventObject.WhoId=conObject.id;
        eventObject.WhatId =accObject.id;
        eventObject.StartDateTime=system.today();
        eventObject.EndDateTime=system.today()+5;
        eventObject.Attendes__c = 'TEST';
        Insert eventObject;
        
        Event eventObject1 = new Event();
        eventObject1.WhoId=conObject.id;
        eventObject1.WhatId =accObject.id;
        eventObject1.StartDateTime=system.today();
        eventObject1.EndDateTime=system.today()+5;
        eventObject1.Attendes__c = 'TEST';
        
        List<String> evenList = new List<String>();
		evenList.add('TEST2');
        
        List<Task> tasklist = new List<Task>();
        Task t = new Task();
        t.OwnerId = UserInfo.getUserId();
        t.Subject='Donni';
        t.Status='Not Started';
        t.Priority='Normal';
		tasklist.add(t);
        //insert t;
        
        String eventre ='TEST4';
        String over = 'TEST5';
        String meet = JSON.serialize(eventObject);
        String MeetingSummary = 'TEST7';
        
        
        Test.startTest();
        eventctrl.getevent(eventObject.id);
        eventctrl.getAccountcontactRelastionshiprecords(accObject.id);
        eventctrl.updateEvent(eventObject,evenList);
        eventctrl.updateeventinserttask(tasklist,eventre,over,meet,MeetingSummary);
        Test.stopTest();
    }
}