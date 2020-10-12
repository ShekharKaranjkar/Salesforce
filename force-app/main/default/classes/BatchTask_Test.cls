@isTest
public class BatchTask_Test {
    public Testmethod static void tstmethod () {
        Date before3days = Date.today().adddays(-3);
        Date before7dys = Date.today().adddays(-7);
        Date onthatday = Date.today();
        List<Task> taskLst = new List<Task>();
        List<Vehicle__c> vv = new List<Vehicle__c>();
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
        
        Vehicle__c vh1= new Vehicle__c();
         vh1.Name = 'MP09213421';
        vh1.City__c = City.id;
        vh1.Finance_Type__c ='Owned';
        vh1.Financer__c = 'Intelligrow';
        vh1.Delivery_Date__c = system.today().addDays(3);
        vh1.VIN_Number__c= '12345678901234567';
         vh1.Re_enter_VIN_Number__c='12345678901234567';
        vh1.Finance_Type__c='Owned';
        vh1.Financer__c = 'ALD';
        vh1.Delivery_Date__c = system.today().addDays(7);
        vh1.Site__c = Campus.Id;
         vh1.Lease_Loan_Amount__c= 1000;
        vh1.Lease_Loan_Start_Date__c = system.today();
        vh1.Lease_Loan_End_Date__c= system.today().addDays(3);
        vh1.OEM__c ='Tata';
        vh1.Manufacturing_Date__c = system.today().addDays(4);
        vh1.Vehicle_Registration_Number__c = 'GJ01RX0349';
        vh1.Date_of_Purchase__c=system.today().addDays(2);
        vh1.RC_Registration_Date__c = system.today().addDays(1);
        insert vh1;
        
        Vehicle__c vh2= new Vehicle__c();
         vh2.Name = 'MP09213421';
        vh2.City__c = City.id;
        vh2.Finance_Type__c ='Owned';
        vh2.Financer__c = 'Intelligrow';
        vh2.Delivery_Date__c = system.today().addDays(3);
        vh2.VIN_Number__c= '12345678901234567';
         vh2.Re_enter_VIN_Number__c='12345678901234567';
        vh2.Finance_Type__c='Owned';
        vh2.Financer__c = 'ALD';
        vh2.Delivery_Date__c = system.today();
        vh2.Site__c = Campus.Id;
         vh2.Lease_Loan_Amount__c= 1000;
        vh2.Lease_Loan_Start_Date__c = system.today();
        vh2.Lease_Loan_End_Date__c= system.today().addDays(3);
        vh2.OEM__c ='Tata';
        vh2.Manufacturing_Date__c = system.today().addDays(4);
        vh2.Vehicle_Registration_Number__c = 'GJ01RX0349';
        vh2.Date_of_Purchase__c=system.today().addDays(2);
        vh2.RC_Registration_Date__c = system.today().addDays(1);
        insert vh2;
        
        System.debug('vh'+vh);
        
        Task tk = new Task();
        tk.Subject = 'Call';
        tk.Priority = 'Normal';
        tk.Status = 'Open';
        tk.OwnerId = userinfo.getUserId();
        tk.WhatId = vh.Id;
        taskLst.add(tk);
        //Insert tk;
        
        Task tks = new Task();
        tks.Subject = 'Call';
        tks.Priority = 'Normal';
        tks.Status = 'Open';
        tks.OwnerId = userinfo.getUserId();
        tks.WhatId = vh.Id;
        taskLst.add(tks);
        
        Task tkss = new Task();
        tkss.Subject = 'Call';
        tkss.Priority = 'Normal';
        tkss.Status = 'Open';
        tkss.OwnerId = userinfo.getUserId();
        tkss.WhatId = vh.Id;
        taskLst.add(tkss); 
        
        Test.startTest();
        BatchTask batch1  = new BatchTask();
        Database.executeBatch(batch1);
        insert taskLst;
        Test.stopTest();
    }
    
}