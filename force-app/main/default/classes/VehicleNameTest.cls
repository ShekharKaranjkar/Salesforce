@isTest
public class VehicleNameTest {
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
        
        Service_Provider__c sp =new Service_Provider__c();
        sp.Address__c='blr';
        sp.Site__c=campus.id;
        insert sp;
        list<Vehicle__c>vlist =new list<Vehicle__c>();
        Vehicle__c v= new Vehicle__c();
        v.Site__c=campus.Id;
        v.VIN_Number__c='23456789052234567';
        v.Re_enter_VIN_Number__c='23456789052234567';
        insert v;
        vlist.add(v);
        Test.startTest();
        VehicleName.notSame(vlist);
        
        Test.stopTest();
    }
}