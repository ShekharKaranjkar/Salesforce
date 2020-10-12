@isTest
public class AssignCarTest {
    static testMethod void testMethod1() 
    {
       account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        
        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=acc.id;
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
        
        Service_Provider__c sp=new Service_Provider__c();
        sp.Name = 'test1';
        sp.Name='test';
        sp.Last_Name__c='test';
        sp.City__c=c.id;
        sp.Status__c='Active';
        sp.Driving_License_Number__c='1234567890123456';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992734422';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        insert sp;
        
        Service_Provider__c sp1=new Service_Provider__c();
        sp1.Name='test1';
        sp1.Last_Name__c='test';
            sp1.Status__c='Active';
        sp1.Driving_License_Number__c='1231567890123456';
        sp1.Address__c='201,ga';
        sp1.City__c=c.id;
        sp1.Phone_Number__c='9912734422';
        sp1.Aadhar_Number__c='113456789012';
        sp1.Location__c='Pune';
        sp1.Site__c=campus.id;
        insert sp1;
        string spstring=sp1.id;
        
        
        
        
        Vehicle__c v= new Vehicle__c();
        v.Site__c=campus.Id;
        v.VIN_Number__c='23456789052234567';
        v.Name = 'MP09213421';
        v.City__c = c.id;
        v.Finance_Type__c ='Owned';
        v.Financer__c = 'Intelligrow';
        v.Delivery_Date__c = system.today().addDays(3);
        v.Re_enter_VIN_Number__c='23456789052234567';
        v.Status1__c='Onroad';
        v.Lease_Loan_Amount__c= 1000;
        v.Lease_Loan_Start_Date__c = system.today();
        v.Lease_Loan_End_Date__c= system.today().addDays(3);
        v.OEM__c ='Tata';
        v.Manufacturing_Date__c = system.today().addDays(4);
        v.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v.Date_of_Purchase__c=system.today().addDays(2);
        v.RC_Registration_Date__c = system.today().addDays(1);
        insert v;
        
        
        
        
        Vehicle_Assignment__c va = new Vehicle_Assignment__c();
        va.Service_Provider__c = sp.Id;
        va.Vehicle__c=v.id;
        insert va;
        
        Test.startTest();
        
        PageReference pageRef = Page.CarAssign; // Add your VF page Name here
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(new PageReference('Page.CarAssign')); 
        System.currentPageReference().getParameters().put('drivernametoController', sp.Id);
        System.currentPageReference().getParameters().put('hiddendcar', v.VIN_Number__c);
        System.currentPageReference().getParameters().put('hiddendriver', sp.Id);
        System.currentPageReference().getParameters().put('hiddendriver', sp1.Phone_Number__c);
        System.currentPageReference().getParameters().put('searchServiceProvider','test');
        //       System.currentPageReference().getParameters().put('searchVehicles','MP09213421');
        
        System.currentPageReference().getParameters().put('driverNameget',spstring);
        AssignCar testAccPlan = new AssignCar();
        testAccPlan.GetRecordFetching();    
        testAccPlan.GetRecordPageforServicProvider();   
        testAccPlan.serchServiceProviderRecords();   
        testAccPlan.GetRecordPageforVehicle();   
        testAccPlan.GetRecordPageforVehicles();   
        
        testAccPlan.GetRecordFetching1();
        testAccPlan.GetRecordPage();
        testAccPlan.GetRecordPage1();
        testAccPlan.save(); 
        testAccPlan.savemethod();   
      
        Test.stopTest();
    }
}