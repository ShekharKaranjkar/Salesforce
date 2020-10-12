@isTest
public class ChecklistDetailsTest {
    
    static testMethod void getId() {
        
        
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
        v1.Name = 'MP09213421';
        v1.City__c = c.id;
        v1.Finance_Type__c ='Owned';
        v1.Financer__c = 'Intelligrow';
        v1.Delivery_Date__c = system.today().addDays(3);
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
        
        String str=v1.id;
        
        
        Test.startTest();
        ChecklistDetails.getcheckvalues(str);
        Test.stopTest();
    }
    
    static testMethod void getownervalues() {
        
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
        
        Vehicle__c vh = new Vehicle__c();
        vh.Name = 'MP09213421';
        vh.City__c = c.id;
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
        
        
        Test.startTest();
        ChecklistDetails.getownervalues(campus.id);
        Test.stopTest();
    }
    
    static testMethod void getcheckvalues1() {
        
        Checklist__c c=new Checklist__c();
        c.AC_Check__c='d';
        insert c;
        
        
        
        Test.startTest();
        ChecklistDetails.getcheckvalues1(c.id);
        Test.stopTest();
    }
    
    static testMethod void createRecord() {
        
        Checklist__c c=new Checklist__c();
        c.AC_Check__c='d';
        insert c;
        
        
        Checklist__c check = new Checklist__c();
        String jsoncheck = JSON.serialize(check);
        Test.startTest();
        ChecklistDetails.getcheckvalues1(c.id);
        try{
            ChecklistDetails.createRecord(jsoncheck,System.today(),System.Today());
        }
        catch(Exception e){
            system.debug(e.getMessage());
        }
        
        Test.stopTest();
    }    
    static testMethod void createAccessriesRecord() {
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
        v1.Name = 'MP09213421';
        v1.City__c = c.id;
        v1.Finance_Type__c ='Owned';
        v1.Financer__c = 'Intelligrow';
        v1.Delivery_Date__c = system.today().addDays(3);
        v1.Is_Accessories_filled__c=true;
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
        v1.OEM__c = 'MG';
        update v1;
        
        Checklist__c cl=new Checklist__c();
        cl.AC_Check__c='d';
        cl.Vehicle__c=v1.id;
        insert cl;
        
        Issues__c is = new Issues__c();
        is.Vehicle__c = v1.id;
        insert is;
        
        
        Checklist__c check = new Checklist__c();
        String jsoncheck = JSON.serialize(cl);
        
        Double lattitude = 37.4232982802915;
        Double longitude = -122.0834237197085;
        
        Test.startTest();
        ChecklistDetails.getcheckvalues1(cl.id);
            ChecklistDetails.getissuecheckvalue(is.Id);
        ChecklistDetails.createAccessriesRecord(jsoncheck,System.today(),System.Today(),true);
        ChecklistDetails.createPDIRecord(jsoncheck,System.today(),System.Today(),true,lattitude,longitude);
        ChecklistDetails.createIssueAccessriesRecord(jsoncheck,System.today(),System.Today());
            Test.stopTest();
    }   
}