@isTest
public class VehicleTaskHandler_Test {
    static testMethod void testName(){
        List<Task> taskList = new List<Task>();
        Map<Id,Task> oldTaskMap = new Map<Id,Task>();
        
        Account Acc = new Account();
        Acc.Name = 'Test 15:56';
        Acc.Lithium_Bank_Account__c  = 'Bangalore';
        Acc.Lithium_Billing_Entity__c  = 'Canara Bank';
        Insert Acc;
        
        City__c City = new City__c();
        City.Name = 'Bangalore';
        City.Account__c = Acc.id;
        insert City;
        
        Campus__c Campus = new Campus__c();
        Campus.Name = 'Test 15:43';
        Campus.Location__c = City.id;
        Campus.Account__c = Acc.Id;
        Campus.Lithium_Billing_Entity__c = 'Bangalore';
        Campus.Lithium_Bank_Account__c = 'Canara Bank';
        Campus.PAN__c = 'AAAAA1234A';
        Campus.GSTN__c = '29AABCT5589K1ZL';
        Campus.Invoice_Creation_Date__c = system.today();
        Campus.Payment_Terms__c = '30';
        Campus.Billing_Street__c = 'xcvbn';
        Campus.Billing_City__c = 'KA';
        Campus.Billing_State_Province__c = 'KA';
        Campus.Billing_Country__c = 'INdia';
        Campus.Billing_Zip_Postal_Code__c = '1234565';
        Campus.Shipping_City__c ='Chennai';
        Campus.Shipping_Country__c = 'India';
        Campus.Shipping_State_Province__c = 'KA';
        Campus.Shipping_Street__c = 'xyz';
        Campus.Shipping_Zip_Postal_Code__c = '123456';
        Insert Campus;
        
        Vehicle__c vh = new Vehicle__c();
         vh.Name = 'MP09213421';
        vh.City__c = City.id;
        vh.Finance_Type__c ='Owned';
        vh.Financer__c = 'Intelligrow';
        vh.Delivery_Date__c = system.today().addDays(3);
        vh.VIN_Number__c= '12345678901234567';
         vh.Re_enter_VIN_Number__c='12345678901234567';
        vh.Finance_Type__c='Owned';
        vh.Financer__c = 'ALD';
        vh.Delivery_Date__c = system.today().addDays(3);
        vh.Site__c = Campus.Id;
        vh.Lease_Loan_Amount__c= 1000;
        vh.Lease_Loan_Start_Date__c = system.today();
        vh.Lease_Loan_End_Date__c= system.today().addDays(3);
        vh.OEM__c ='Tata';
        vh.Manufacturing_Date__c = system.today().addDays(4);
        vh.Vehicle_Registration_Number__c = 'GJ01RX0349';
        vh.Date_of_Purchase__c=system.today().addDays(2);
        vh.RC_Registration_Date__c = system.today().addDays(1);
        insert vh;
        
        
        Task taskObject = new Task();
        taskObject.OwnerId = UserInfo.getUserId();
        taskObject.Subject='Donni';
        taskObject.WhatId = vh.id;
        taskObject.Status='Not Started';
        taskObject.Priority='Normal';
		oldTaskMap.put(taskObject.id,taskObject);
        
        //insert oldTaskMap;
        Task taskObject1 = new Task();
        taskObject1.OwnerId = UserInfo.getUserId();
        taskObject1.Subject='Donni';
        taskObject1.WhatId = vh.id;
        taskObject1.Status='Completed';
        taskObject1.Priority='Normal';
		taskList.add(taskObject1);
        
        test.startTest();
        
        VehicleTaskHandler.updateparentrecords(taskList,oldTaskMap);
        test.stopTest();
        
    }
}