@isTest
public class PlannedLeaveApprovalBtch_Test {
    
      public Testmethod static void tstmethod () {
          
	 account ac=new account();
        ac.Name='rag';
        ac.Lithium_Billing_Entity__c='Pune';
        ac.Lithium_Bank_Account__c='State Bank';
        insert ac;
        City__c c=new City__c();
        c.Account__c=ac.id;
        insert c;
      Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=ac.id;
        Campus.Lithium_Bank_Account__c='State Bank';
        campus.PAN__c='XXXXX1234X';
        campus.GSTN__c='qwertyuiopasdfg';
        campus.Invoice_Creation_Date__c=system.today();
        campus.Payment_Terms__c= '30';
        campus.Billing_City__c='mrt';
        campus.Billing_State_Province__c='tp';
        campus.Billing_Street__c='ee';
        campus.Billing_Zip_Postal_Code__c='ff';
        campus.Shipping_City__c='ff';
        campus.Shipping_State_Province__c='ff';
        campus.Shipping_Street__c='ff';
        campus.Shipping_Zip_Postal_Code__c='ff';
        insert campus;
        

        Vehicle__c v1 = new Vehicle__c();
        v1.Site__c=campus.Id;
        v1.City__c = c.id;
        v1.Finance_Type__c ='Owned';
        v1.Delivery_Date__c = system.today().addDays(3);
        v1.Financer__c = 'Intelligrow';
        v1.Name = 'MP09213421';
        v1.VIN_Number__c='12345678901234567';
        v1.Re_enter_VIN_Number__c='12345678901234567';
        v1.Lease_Loan_Amount__c= 1000;
        v1.Status1__c='New';
        v1.Lease_Loan_Start_Date__c = system.today();
        v1.Lease_Loan_End_Date__c= system.today().addDays(3);
        v1.OEM__c ='Tata';
        v1.Manufacturing_Date__c = system.today().addDays(4);
        v1.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v1.Date_of_Purchase__c=system.today().addDays(2);
        v1.RC_Registration_Date__c = system.today().addDays(1);
        
        // vhlist.add(v1);
        insert v1;
        
        
        
         Service_Provider__c sp=new Service_Provider__c();
        sp.Name='test';
        sp.Last_Name__c = 'test1';
        sp.Driving_License_Number__c='1234567890123456';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992734422';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        sp.Phone__c=1234567890;
        sp.Vehicle_Assigned_To__c=v1.id;
          insert sp;
        Date before2days = system.today();
         
          Leave__c lv = new Leave__c();
          lv.From_date__c = system.today().addDays(8);
          lv.To_date__c = system.today().addDays(8);
          lv.From_Date_Reference__c = system.now().addHours(-6);
          lv.Approval_Request__c = 'Initial';
          lv.Service_Provider__c = sp.id;
          lv.Reason__c = 'Family Emergency';
          insert lv;
         
		
         
           Test.startTest();
      
        PlannedLeaveApprovalBtch bc  = new PlannedLeaveApprovalBtch();
        Database.executeBatch(bc);
        
        Test.stopTest();
      }
      

}