@isTest
public class LithiumIdFormatTest {
    static testMethod void testMethod1() {
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
        campus.Total_Limit__c = 3;
        insert campus;
        
        
        list<Service_Provider__c> spp=new list<Service_Provider__c>();
        Service_Provider__c service = new Service_Provider__c( );
        // service.Service_Provider_Name1__c='TEST_Service';
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='9890100970';
        service.Aadhar_Number__c='123456789012';
        service.Name='test';
        service.Site__c=campus.id;
        service.Location__c='Pune';
        service.Phone__c = 1234567;
        service.Last_Name__c ='testname1';
        service.Status__c = 'Active';
        spp.add(service);
        
        Service_Provider__c service1 = new Service_Provider__c( );
        // service.Service_Provider_Name1__c='TEST_Service';
        service1.Driving_License_Number__c='1234567890123456'; 
        service1.Address__c='asd';
        service1.Phone_Number__c='9890100970';
        service1.Aadhar_Number__c='123456789012';
        service1.Name='test';
        service1.Site__c=campus.id;
        service1.Location__c='Pune';
        service1.Phone__c = 1234567;
        service1.Last_Name__c ='testname';
         service1.Status__c = 'Active';
        spp.add(service1);
        insert spp;
        
        Map<string,Locations__c> mapLocationCodes;
        list<String> phnList;
        Test.startTest();
        LithiumIdFormat.accordingToLocation(spp);
           LithiumIdFormat.accordingToLocation(spp);
       LithiumIdFormat.checkSiteLimit(spp);
        
        Test.stopTest();
    }
        static testMethod void testMethod2() {
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
        
        
        list<Service_Provider__c> spp=new list<Service_Provider__c>();
        Service_Provider__c service = new Service_Provider__c( );
        // service.Service_Provider_Name1__c='TEST_Service';
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='1234567890';
        service.Aadhar_Number__c='123456789012';
        service.Name='test';
        service.Site__c=campus.id;
        service.Location__c='Pune';
        service.Phone__c = 1234567;
        service.Last_Name__c ='testname1';
             service.Status__c = 'Active';
        spp.add(service);
        
        Service_Provider__c service1 = new Service_Provider__c( );
        // service.Service_Provider_Name1__c='TEST_Service';
        service1.Driving_License_Number__c='1234567890123456'; 
        service1.Address__c='asd';
        service1.Phone_Number__c='1234567890';
        service1.Aadhar_Number__c='123456789012';
        service1.Name='test';
        service1.Site__c=campus.id;
        service1.Location__c='Pune';
        service1.Phone__c = 1234567;
        service1.Last_Name__c ='testname';
        service1.Status__c = 'Active';
        spp.add(service1);
        insert spp;
         list<String> phnList = new list<String>();
            phnList.add(service1.Phone_Number__c);
        
        Test.startTest();
        LithiumIdFormat.accordingToLocation(spp);
        LithiumIdFormat.checkSiteLimit(spp);
        
        Test.stopTest();
    }
            static testMethod void testMetho32() {
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
        
        
        list<Service_Provider__c> spp=new list<Service_Provider__c>();
        Service_Provider__c service = new Service_Provider__c( );
        // service.Service_Provider_Name1__c='TEST_Service';
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='1234567890';
        service.Aadhar_Number__c='123456789012';
        service.Name='test';
        service.Site__c=campus.id;
        service.Location__c='Pune';
        service.Phone__c = 1234567;
              
        service.Last_Name__c ='testname1';
             service.Status__c = 'Active';
   insert service;
        
        Service_Provider__c service1 = new Service_Provider__c( );
        // service.Service_Provider_Name1__c='TEST_Service';
        service1.Driving_License_Number__c='1234567890123456'; 
        service1.Address__c='asd';
        service1.Phone_Number__c='1234567890';
        service1.Aadhar_Number__c='123456789012';
        service1.Name='test';
        service1.Site__c=campus.id;
        service1.Location__c='Pune';
        service1.Phone__c = 1234567;
        service1.Last_Name__c ='testname';
        service1.Status__c = 'Active';
        spp.add(service1);
        insert spp;
         list<String> phnList = new list<String>();
            phnList.add(service1.Phone_Number__c);
        
        Test.startTest();
        LithiumIdFormat.accordingToLocation(spp);
        LithiumIdFormat.checkSiteLimit(spp);
        LithiumIdFormat.incresecoverge();
        Test.stopTest();
    }

}