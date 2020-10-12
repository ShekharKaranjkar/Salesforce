@isTest
public class MomEmailTriggerHandlerTest {
    static testMethod void testName(){
        Account accObject = new Account();
        accObject.Name ='TESTACCOUNT';
        accObject.Lithium_Billing_Entity__c = 'Bangalore';
        accObject.Lithium_Bank_Account__c = 'State Bank';
        accObject.Email__c = 'xyz@gmail.com';
        Insert accObject;
        
        Contact conObject = new Contact();
        conObject.LastName = 'TESTCONTACT';
        conObject.AccountId = accObject.id;
        conObject.Email = 'xyz@gmail.com';
        Insert conObject;
        
        AccountContactRelation acctcr = new AccountContactRelation(AccountId = accObject.id, ContactId = conObject.id );
        //insert acctcr;
        
        List<Event> eventList = new List<Event>();
        
        Event eventObject = new Event();
        //eventObject.WhatId=accObject.id;
        eventObject.WhoId=conObject.id;
        eventObject.Attendes__c = 'TEST';
        eventObject.StartDateTime=system.today();
        eventObject.EndDateTime=system.today()+5;
        eventList.add(eventObject);
        
        string email = 'xyz@gmail.com';
        string subject = 'TEST1';
        date start = date.today();
        date endDate = date.today()+5;
        string discuss = 'TEST2';
            
        test.startTest();
        MomEmailTriggerHandler.handleMethod(eventList);
        MomEmailTriggerHandler.sendEmail(email,subject,start,endDate,discuss);
        test.stopTest();
    }
}