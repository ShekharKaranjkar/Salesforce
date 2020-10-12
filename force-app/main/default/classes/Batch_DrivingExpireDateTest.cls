@isTest(SeeAllData=true)
public class Batch_DrivingExpireDateTest {
    public Testmethod static void tstmethod () {
        Date before2days = system.today();
           List<String>userIdsList = New List<String>();
       // list<Compliance__c> comList = new list<Compliance__c>();
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        
        User usrObj = new User();
        usrObj.LastName = 'TestLast123';
        usrObj.FirstName='TestFirst123';
        usrObj.Alias = 'tst';
        usrObj.Email = 'test3@gmail.com';
        usrObj.Username = 'testkalasinj123@gmail.com';
        usrObj.ProfileId = profileId.id;
        usrObj.TimeZoneSidKey = 'GMT';
        usrObj.LanguageLocaleKey = 'en_US';
        usrObj.EmailEncodingKey = 'UTF-8';
        usrObj.LocaleSidKey = 'en_US';
        usrObj.IsActive=True;
        //usrObj.userRoleId='00EC0000001EkqFMAS';
        //usrObj.UserRole.Name='CRM Rep';
        insert usrObj;
        
        Profile profileId1 = [SELECT Id FROM Profile WHERE Name = 'Site Manager' LIMIT 1];
        
        User usrObj1 = new User();
        usrObj1.LastName = 'TestLast12312';
        usrObj1.FirstName='TestFirst12312';
        usrObj1.Alias = 'tst';
        usrObj1.Email = 'test12312@test.com';
        usrObj1.Username = 'testkalasinj123123@gmail.com.staging';
        usrObj1.ProfileId = profileId1.id;
        usrObj1.TimeZoneSidKey = 'GMT';
        usrObj1.LanguageLocaleKey = 'en_US';
        usrObj1.EmailEncodingKey = 'UTF-8';
        usrObj1.LocaleSidKey = 'en_US';
        usrObj1.IsActive=True;
        //usrObj1.userRoleId='00EC0000001EkqFMAS';
        //usrObj1.UserRole.Name='CRM Rep';
        insert usrObj1;
        
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
        campus.Site_Supervisor__c = usrObj.id;
        insert campus;
        Service_Provider__c service = new Service_Provider__c( );
        //  service.Service_Provider_Name1__c='TEST_Service';
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='8903390425';
        service.Aadhar_Number__c='123456789012';
        service.Name='test';
        service.Site__c=campus.id;
        service.Location__c='Bangalore';
        service.Phone__c = 1234567;
        service.Last_Name__c ='test12345';
        service.Status__c='Active';
        service.First_Name__c ='Tst';
        service.LithiumIds__c = '123455678';
        insert service;
        
        Compliance__c com = new Compliance__c();
        com.Driving_License_Expire_Date__c= system.today().addDays(14);
        com.Lithium_ID__c =  service.Id;
       // com.Service_Provider_Name__c=service.Name;
         insert com;
       // comList.add(com);
        //  insert comList;
        
        Notification__c noti = new Notification__c();
        noti.User_ID__c =UserInfo.getUserId();
        noti.Message__c='test';
        noti.Compliance__c=com.Id;
        insert noti;
        
      
        Test.startTest();
      
        Batch_DrivingExpireDate bc  = new Batch_DrivingExpireDate();
        Database.executeBatch(bc);
        
        Test.stopTest();
    }
}