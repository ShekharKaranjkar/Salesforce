@isTest
public class vehicledocumenttrigger_Test{
    static testmethod void vehdoc(){
        String fc = [Select Id From RecordType Where SobjectType = 'Vehicle_Documents__c' and Name = 'Fitness Certificate'].Id;
        String permit = [Select Id From RecordType Where SobjectType = 'Vehicle_Documents__c' and Name = 'Permit'].Id;
        String reg = [Select Id From RecordType Where SobjectType = 'Vehicle_Documents__c' and Name = 'Registration'].Id;
        String taxes = [Select Id From RecordType Where SobjectType = 'Vehicle_Documents__c' and Name = 'Taxes'].Id;
        
        
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
        
        Vehicle__c v1 = new Vehicle__c();
        v1.Site__c=campus.Id;
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
        v1.Task_Stage__c = false;
        v1.All_Vehicle_Documents_Received__C = false;
        v1.Is_Accessories_filled__c = false;
        v1.Name = 'MP09213421';
        v1.City__c = c.id;
        v1.Finance_Type__c ='Owned';
        v1.Financer__c = 'Intelligrow';
        v1.Delivery_Date__c = system.today().addDays(3);
        insert v1;
        
        
        Vehicle_Documents__c vfc = new Vehicle_Documents__c();
        vfc.Vehicle__c = v1.Id;
        vfc.RecordTypeId = fc;
        vfc.Date_of_Expiry__c = system.today().addDays(7);
        vfc.Expiration_Date__c = system.today().addDays(2);
        //  vfc.Registration_Number__c = 'tn 52z ';
        vfc.Receipt_Date__c = system.today();
        insert vfc;
        
        Vehicle_Documents__c vper = new Vehicle_Documents__c();
        vper.Vehicle__c = v1.Id;
        vper.RecordTypeId = permit;
        vper.P_Co_P_No__c ='pco';
        vper.Date_of_Expiry__c = system.today().addDays(15);
        // vper.Expiration_Date__c = system.today().addDays(2);
        //    vper.Registration_Number__c = 'tn 52z ';
        vper.Receipt_Date__c = system.today();
        insert vper;
        
        Vehicle_Documents__c vreg = new Vehicle_Documents__c();
        vreg.Vehicle__c = v1.Id;
        vreg.RecordTypeId = reg;
        vreg.RC_Registration_Date__c = system.today().addDays(2);
        // vreg.Date_of_Expiry__c = system.today().addDays(15);
        // vreg.Expiration_Date__c = system.today().addDays(2);
        //  vreg.Registration_Number__c = 'tn 52z ';
        vreg.Receipt_Date__c =system.today().addDays(15);
        vreg.Chassis_Number__c = 'num';
        insert vreg;
        
        Vehicle_Documents__c vtax = new Vehicle_Documents__c();
        vtax.Vehicle__c = v1.Id;
        vtax.RecordTypeId = taxes;
        vtax.End_Date__c = system.today().addDays(15);
        vtax.Start_Date__c = system.today().addDays(2);
        // vtax.Registration_Number__c = 'tn 52z ';
        vtax.Tax_Type__c = 'Road Tax';
        vtax.Receipt_Date__c =system.today().addDays(15);
        insert vtax;
        
        Test.startTest();
        update v1;
        
        Test.stopTest();
    }
}