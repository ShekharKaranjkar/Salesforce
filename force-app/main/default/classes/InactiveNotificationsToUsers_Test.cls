@isTest
public class InactiveNotificationsToUsers_Test {
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
        
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        
        
    }
    static testMethod void testName(){
        City__c c = [select id from City__c limit 1];
        Account acc =[select id from Account limit 1];
        User userid = [Select id from User limit 1];
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
        campus.Site_Supervisor__c=userid.id;
        campus.Shipping_Zip_Postal_Code__c='ff';
        insert campus;
        //   Campus__c camp =[select id from Campus__c limit 1];
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
        service.Status__c ='InActive';
        service.Inactive_From__c =system.today();
        insert service;
        
        Id comIdOne;
        string comname;
        comIdOne = service.id;
        comname =service.Name;
        list<Service_Provider__c> spList = new list<Service_Provider__c>();
        List<String>useremailAT = New List<String>();
        List<String>useremailList = New List<String>();
        
        List<String>userIdsSM = New List<String>();
        List<String>useremailSM = New List<String>();
        
        List<String>userIdsAT = New List<String>();
        List<String>userIdsList = New List<String>();
        Service_Provider__c sp = new Service_Provider__c();
        sp.Driving_License_Number__c='1234567890123456'; 
        sp.Address__c='asda';
        sp.Phone_Number__c='1234567290';
        sp.Aadhar_Number__c='123456289012';
        sp.Name='test';
        sp.Site__c=campus.id;
        sp.Location__c='Bangalore';
        sp.Phone__c = 1234567;
        sp.Last_Name__c ='test12345';
        sp.Status__c ='Active';
        sp.Inactive_From__c =system.today();
        insert sp;
      //  spList.add(sp);
       //  insert spList;
        sp.Status__c ='InActive';
        update sp;
        Map<id,Service_Provider__c> sptMap = new Map<id,Service_Provider__c>();
        list<Service_Provider__c> serviceList = new list<Service_Provider__c>();
        Test.startTest();
       
        InactiveNotificationsToUsers.sendNotification(spList,sptMap);
        InactiveNotificationsToUsers.validations(serviceList, sptMap);
        Test.stopTest();
    }
}