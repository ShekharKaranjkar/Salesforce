@isTest
public class MomdetailsTest {
    static testmethod void myMethod(){
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
    
    	Event eventObject = new Event();
        eventObject.WhatId=accObject.id;
        eventObject.WhoId=conObject.id;
        eventObject.Attendes__c = 'TEST';
        eventObject.StartDateTime=system.today();
        eventObject.EndDateTime=system.today()+5;
        insert eventObject;
    
    	String jsonEvent = JSON.serialize(eventObject);
    	
    	List<Task> taskList = new List<Task>();
    
    	Task taskObject = new Task();
        taskObject.OwnerId = UserInfo.getUserId();
        taskObject.Subject='Maintenance';
        taskObject.Status='Not Started';
        taskObject.Priority='Normal';
		taskObject.WhoId = conObject.id;
    	taskObject.Event_ID__c = eventObject.Id;
        taskList.add(taskObject);
        //insert taskList;
        Task taskObject1 = new Task();
        taskObject1.OwnerId = UserInfo.getUserId();
        taskObject1.Subject='Driver Behaviour';
        taskObject1.Status='Not Started';
        taskObject1.Priority='Normal';
		taskObject1.WhoId = conObject.id;
    	taskObject1.Event_ID__c = eventObject.Id;
        taskList.add(taskObject1);
        
        Task taskObject2 = new Task();
        taskObject2.OwnerId = UserInfo.getUserId();
        taskObject2.Subject='Team Issues';
        taskObject2.Status='Not Started';
        taskObject2.Priority='Normal';
		taskObject2.WhoId = conObject.id;
    	taskObject2.Event_ID__c = eventObject.Id;
        taskList.add(taskObject2);
        
        Task taskObject3 = new Task();
        taskObject3.OwnerId = UserInfo.getUserId();
        taskObject3.Subject='New Vendor';
        taskObject3.Status='Not Started';
        taskObject3.Priority='Normal';
		taskObject3.WhoId = conObject.id;
    	taskObject3.Event_ID__c = eventObject.Id;
        taskList.add(taskObject3);
        
        Task taskObject4 = new Task();
        taskObject4.OwnerId = UserInfo.getUserId();
        taskObject4.Subject='Current Technology Change';
        taskObject4.Status='Not Started';
        taskObject4.Priority='Normal';
		taskObject4.WhoId = conObject.id;
    	taskObject4.Event_ID__c = eventObject.Id;
        taskList.add(taskObject4);
    	insert taskList;
    	test.startTest();
    	
        Momdetails.geteventvalues(eventObject.id,taskList);
        Momdetails.updateeventvalues(jsonEvent);
        
    	test.stopTest();
    

}
}