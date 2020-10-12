@isTest
public class ContinuousTripApprovalHelper_Test {
    @testSetup static void methodName() {
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User usrObj = new User();
        usrObj.LastName = 'TestLast';
        usrObj.FirstName='TestFirst';
        usrObj.Alias = 'tst';
        usrObj.Email = 'test@test.com';
        usrObj.Username = 'testkalasinj@gmail.com.staging';
        usrObj.ProfileId = profileId.id;
        usrObj.TimeZoneSidKey = 'GMT';
        usrObj.LanguageLocaleKey = 'en_US';
        usrObj.EmailEncodingKey = 'UTF-8';
        usrObj.LocaleSidKey = 'en_US';
        usrObj.IsActive=True;
        //usrObj.userRoleId='00EC0000001EkqFMAS';
        //usrObj.UserRole.Name='CRM Rep';
        insert usrObj;
        
        
        
        
    }
    public Testmethod static void Testmethod1 () {
        User userid = [Select id from User limit 1];
        
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
        campus.Site_Supervisor__c = userid.Id;
        insert campus;
        Service_Provider__c service = new Service_Provider__c( );
        //  service.Service_Provider_Name1__c='TEST_Service';
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='1234567890';
        service.Aadhar_Number__c='123456789012';
        service.Name='test';
        service.Site__c=campus.id;
        service.Location__c='Bangalore';
        service.Phone__c = 1234567;
        service.Last_Name__c ='test12345';
        service.First_Name__c ='testfirst';
        service.Last_Name__c='testlast';
        service.Status__c='Active';
        insert service;
        list<Continous_trip__c>conList = new list<Continous_trip__c>();
        
        Continous_trip__c co = new Continous_trip__c();
        co.Service_Provider__c=service.Id;
        co.Name ='Test';
        co.Shift__c ='Day';
        co.Date__c =system.today();
        co.Shift_Start__c =system.today();
        co.Shift_End__c = system.today().addDays(1);
        co.Trip_Start__c =system.today();
        co.Trip_End__c =system.today().addDays(1);
        co.Status__c ='Initiate';
        conList.add(co);
        insert conList;
        
        Test.startTest();
        
        // ContinuousTripApprovalHelper.sendApproval(conList);
        
        Test.stopTest();
    }
    public Testmethod static void Testmethod2 () {
        User userid = [Select id from User limit 1];
        
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
        campus.City_Head__c = userid.Id;
        insert campus;
        Service_Provider__c service = new Service_Provider__c( );
        //  service.Service_Provider_Name1__c='TEST_Service';
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='1234567890';
        service.Aadhar_Number__c='123456789012';
        service.Name='test';
        service.Site__c=campus.id;
        service.Location__c='Bangalore';
        service.Phone__c = 1234567;
        service.Last_Name__c ='test12345';
        service.First_Name__c ='testfirst';
        service.Last_Name__c='testlast';
        service.Status__c='Active';
        insert service;
        
        set<id>contList = new set<id>();
        Continous_trip__c co = new Continous_trip__c();
        co.Service_Provider__c=service.Id;
        co.Name ='Test';
        co.Shift__c ='Day';
        co.Date__c =system.today();
        co.Shift_Start__c =system.today();
        co.Shift_End__c = system.today().addDays(1);
        co.Trip_Start__c =system.today();
        co.Trip_End__c =system.today().addDays(1);
        co.Status__c ='Initiate';
        insert co;
        co.Status__c ='Approved by Site Manager';
        update co;
        contList.add(co.Id);
        Test.startTest();
        //   ContinuousTripApprovalHelper.sendApprovaltoclusterHead(contList);
        Test.stopTest();
        
    }
}