@isTest
public class InvetoryProductTest {
    
    static testMethod void CreateInvetoryProduct(){
        
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
        

     
        
        
        Vehicle__c v= new Vehicle__c();
        v.Site__c=campus.Id;
        v.VIN_Number__c='23456789052234567';
        v.Name = 'MP09213421';
        v.City__c = c.id;
        v.Finance_Type__c ='Owned';
        v.Financer__c = 'Intelligrow';
        v.Delivery_Date__c = system.today().addDays(3);
        v.Re_enter_VIN_Number__c='23456789052234567';
        v.VIN_Number__c='123we4r5t6y7uq3e5';
        v.Status1__c='New';
        v.Lease_Loan_Amount__c= 1000;
        v.Lease_Loan_Start_Date__c = system.today();
        v.Lease_Loan_End_Date__c= system.today().addDays(3);
        v.OEM__c ='Tata';
        v.Manufacturing_Date__c = system.today().addDays(4);
        v.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v.Date_of_Purchase__c=system.today().addDays(2);
        v.RC_Registration_Date__c = system.today().addDays(1);
        insert v;
        
        Inventory_Product__c ip=new Inventory_Product__c();
        ip.Name='rag';
        ip.QR_Code__c='12345';
        insert ip;
        
        
        
        
       
        
        Test.startTest();
        
        PageReference pageRef = Page.InventoryProduct; // Add your VF page Name here
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(new PageReference('Page.InventoryProduct')); 
        System.currentPageReference().getParameters().put('drivernametoController',  v.VIN_Number__c);
        System.currentPageReference().getParameters().put('hiddendcar', ip.QR_Code__c);
        System.currentPageReference().getParameters().put('hiddendriver', v.VIN_Number__c);
      //  System.currentPageReference().getParameters().put('hiddendriver', sp1.Id);
        InvetoryProduct testAccPlan = new InvetoryProduct();
        testAccPlan.GetRecordFetching();    
        testAccPlan.GetRecordPageforServicProvider();   
        testAccPlan.serchServiceProviderRecords();   
        testAccPlan.GetRecordPageforVehicle();   
        testAccPlan.GetRecordPageforVehicles();   
        
        testAccPlan.GetRecordFetching1();
        testAccPlan.GetRecordPage();
        testAccPlan.GetRecordPage1();
        
        testAccPlan.savemethod();   
        
        Test.stopTest();

        
    }
        static testMethod void CreateInvetoryProductElsePart(){
        
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
        

     
        
        
        Vehicle__c v= new Vehicle__c();
        v.Site__c=campus.Id;
        v.VIN_Number__c='23456789052234567';
        v.Name = 'MP09213421';
        v.City__c = c.id;
        v.Finance_Type__c ='Owned';
        v.Financer__c = 'Intelligrow';
        v.Delivery_Date__c = system.today().addDays(3);
        v.Re_enter_VIN_Number__c='23456789052234567';
        v.VIN_Number__c='123we4r5t6y7uq3e5';
        v.Status1__c='New';
        v.Lease_Loan_Amount__c= 1000;
        v.Lease_Loan_Start_Date__c = system.today();
        v.Lease_Loan_End_Date__c= system.today().addDays(3);
        v.OEM__c ='Tata';
        v.Manufacturing_Date__c = system.today().addDays(4);
        v.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v.Date_of_Purchase__c=system.today().addDays(2);
        v.RC_Registration_Date__c = system.today().addDays(1);
        insert v;
        
        Inventory_Product__c ip=new Inventory_Product__c();
        ip.Name='rag';
        ip.QR_Code__c='12345';
            ip.City__c=c.id;
        insert ip;
        
        
        
        
       
        
        Test.startTest();
        
        PageReference pageRef = Page.InventoryProduct; // Add your VF page Name here
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(new PageReference('Page.InventoryProduct')); 
        System.currentPageReference().getParameters().put('drivernametoController',  v.VIN_Number__c);
        System.currentPageReference().getParameters().put('hiddendcar', ip.QR_Code__c);
        System.currentPageReference().getParameters().put('hiddendriver', v.VIN_Number__c);
      //  System.currentPageReference().getParameters().put('hiddendriver', sp1.Id);
        InvetoryProduct testAccPlan = new InvetoryProduct();
        testAccPlan.GetRecordFetching();    
        testAccPlan.GetRecordPageforServicProvider();   
        testAccPlan.serchServiceProviderRecords();   
        testAccPlan.GetRecordPageforVehicle();   
        testAccPlan.GetRecordPageforVehicles();   
        
        testAccPlan.GetRecordFetching1();
        testAccPlan.GetRecordPage();
        testAccPlan.GetRecordPage1();
        
        testAccPlan.savemethod();   
        
        Test.stopTest();

        
    }
}