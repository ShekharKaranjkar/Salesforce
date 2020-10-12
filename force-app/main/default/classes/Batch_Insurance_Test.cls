@isTest
public class Batch_Insurance_Test {
    public Testmethod static void Testmethod1 () {
        Date before7days = system.today();
        Date before15dys = system.today();
        Date before30days = system.today();
        Date befor60ays = system.today();
        
        
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
        insert v1;
        
        
        Insurance__c ins7 = new Insurance__c();
        ins7.Name = 'Test insu';
        ins7.Vehicle__c = v1.id;
        ins7.Insurance_Company__c = 'MAGMA';
        ins7.Policy_Number__c = 'Test123';
        ins7.Status__c = 'Not Initiated';
        ins7.Policy_Start_Date__c = system.today();
        ins7.Policy_End_Date__c = system.today().addDays(2);
        ins7.Renewal_Date__c = system.today().addDays(7);
        insert ins7;
        Insurance__c ins15 = new Insurance__c();
        ins15.Name = 'Test insu';
        ins15.Vehicle__c = v1.id;
        ins15.Insurance_Company__c = 'MAGMA';
        ins15.Status__c = 'Not Initiated';
        ins15.Policy_Number__c = 'Test123';
        ins15.Policy_Start_Date__c = system.today();
        ins15.Policy_End_Date__c = system.today().addDays(2);
        ins15.Renewal_Date__c = system.today().addDays(15);
        insert ins15;
        Insurance__c ins30 = new Insurance__c();
        ins30.Name = 'Test insu';
        ins30.Vehicle__c = v1.id;
        ins30.Insurance_Company__c = 'MAGMA';
        ins30.Policy_Number__c = 'Test123';
        ins30.Status__c = 'Not Initiated';
        ins30.Policy_Start_Date__c = system.today();
        ins30.Policy_End_Date__c = system.today().addDays(2);
        ins30.Renewal_Date__c = system.today().addDays(30);
        insert ins30;
        /* Insurance__c ins60 = new Insurance__c();
ins60.Name = 'Test insu';
ins60.Vehicle__c = v1.id;
ins60.Insurance_Company__c = 'MAGMA';
ins60.Policy_Number__c = 'Test123';
ins60.Status__c = 'Not Initiated';
ins60.Policy_Start_Date__c = system.today();
ins60.Policy_End_Date__c = system.today().addDays(2);
ins60.Renewal_Date__c = system.today().addDays(60);
insert ins60; */
        
        CollaborationGroup cg1 = new CollaborationGroup();
        cg1.Name = 'MTComplianceandCOOId';
        cg1.CollaborationType ='Public';
        insert cg1;
        system.debug('cg1'+cg1);
        Map<string,FeedItem> feeditemaList =new   Map<string,FeedItem>();
        
        FeedItem fi = New FeedItem(ParentId = cg1.id,Body = '7 days to go for this Record'+ins30.Name);
        feeditemaList.put(ins30.Name,fi);
        
        Test.startTest();
        insert feeditemaList.values(); 
        Batch_Insurance bi = new Batch_Insurance();
        Database.executeBatch(bi);
        Test.stopTest();
    }
}