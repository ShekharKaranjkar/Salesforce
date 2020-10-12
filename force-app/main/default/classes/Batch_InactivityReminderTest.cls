@isTest
public class Batch_InactivityReminderTest {
     @testSetup static void methodName() {
          Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Account Team' LIMIT 1];
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
        
		
	
    }
	
    public Testmethod static void tstmethod () {
        list<Notification__c> notificationInsertlist = new list<Notification__c>();
        String profId = [select Id from Profile where name='SP' limit 1].Id;
       account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        contact con =new contact();
        con.AccountId = acc.Id;
        con.LastName = 'test';
       // con.Service_Provider__c = service.Id;
        insert con;
        
        User us = new User();
        us.Username= 'jis@gmail.com';
        //us.alias= uniqueName.substring(18, 23); 
        us.email = 'jj@gmail.com';
        us.emailencodingkey = 'UTF-8'; 
        us.firstname = 'jisna'; 
        us.lastname = 'test';
        us.MobilePhone = '9898099890';
        us.languagelocalekey = 'en_US'; 
        us.localesidkey = 'en_US'; 
        us.timezonesidkey = 'Asia/Kolkata';
        us.ProfileId = profId;
        us.IsActive = false;
        us.ContactId = con.Id;
        us.Alias ='abbbc';
        //  us.Name ='jisna';
        insert us;
        
        
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        Campus__c   Campus1 =new Campus__c();
        Campus1.Name='rag';
        Campus1.Location__c=c.id;
        Campus1.Account__c=acc.id;
        Campus1.Lithium_Bank_Account__c='State Bank';
        campus1.PAN__c='XXXXX1234X';
        campus1.GSTN__c='qwertyuiopasdfg';
        campus1.Invoice_Creation_Date__c=system.today();
        campus1.Payment_Terms__c= '30';
        campus1.Billing_City__c='mrt';
        campus1.Billing_State_Province__c='tp';
        campus1.Billing_Street__c='ee';
        campus1.Billing_Zip_Postal_Code__c='ff';
        campus1.Shipping_City__c='ff';
        campus1.Shipping_State_Province__c='ff';
        campus1.Shipping_Street__c='ff';
        campus1.Shipping_Zip_Postal_Code__c='ff';
        insert campus1;
        Service_Provider__c service = new Service_Provider__c( );
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='1234567890';
        service.Aadhar_Number__c='123456789012';
        service.Name='jisna';
       service.Site__c=campus1.Id;
        service.Location__c='Bangalore';
        service.Phone__c = 1234567;
        service.Last_Name__c ='test';
        service.Account_Settlement__c = false;
        service.Site_Manager_Settlement__c = true;
        service.First_Name__c = 'jis';
        service.Maintenance_Team_Settlement__c = true;
        service.Status__c = 'InActive' ;
        service.Shift__c='Day';
        service.Inactive_From__c = system.today().addDays(-10);
        
        insert service;

       
        
        Notification__c noti = new Notification__c();
        noti.User_Id__c = UserInfo.getUserId();
        noti.Message__c = 'Please do the settelment of Service Provider';
        
        notificationInsertlist.add(noti);
        
        // insert notificationInsertlist;
        
        Notification__c noti1 = new Notification__c();
        noti1.User_Id__c = UserInfo.getUserId();
        noti1.Message__c = 'Please do the settelment of Service Provider';
        
        notificationInsertlist.add(noti1);
        
        insert notificationInsertlist;
        
        
        Test.startTest();
        
        Batch_InactivityReminder bc  = new Batch_InactivityReminder();
        Database.executeBatch(bc);
        
        Test.stopTest();
        
    }   
  
    public Testmethod static void tstmethod2 () {
          Campus__c campus = [Select id from Campus__c limit 1];
        list<Notification__c> notificationInsertlist = new list<Notification__c>();
        String profId = [select Id from Profile where name='SP' limit 1].Id;
        // Campus__c cps =  [select id,Name from Campus__c limit 1];
        
        Service_Provider__c service = new Service_Provider__c( );
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='1234567890';
        service.Aadhar_Number__c='123456789012';
        service.Name='jisna';
        service.Site__c=campus.Id;
        service.Location__c='Bangalore';
        service.Phone__c = 1234567;
        service.Last_Name__c ='test';
        service.Account_Settlement__c = true;
        service.Site_Manager_Settlement__c = true;
        service.Maintenance_Team_Settlement__c = false;
        service.First_Name__c = 'jis';
         service.Status__c = 'InActive' ;
        service.Shift__c='Day';
         service.Inactive_From__c = system.today().addDays(-10);
        
        insert service;
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        contact con =new contact();
        con.AccountId = acc.Id;
        con.LastName = 'test';
        con.Service_Provider__c = service.Id;
        insert con;
        
        User us = new User();
        us.Username= 'jis@gmail.com';
        //us.alias= uniqueName.substring(18, 23); 
        us.email = 'jj@gmail.com';
        us.emailencodingkey = 'UTF-8'; 
        us.firstname = 'jisna'; 
        us.lastname = 'test';
        us.MobilePhone = '9898099890';
        us.languagelocalekey = 'en_US'; 
        us.localesidkey = 'en_US'; 
        us.timezonesidkey = 'Asia/Kolkata';
        us.ProfileId = profId;
        us.IsActive = false;
        us.ContactId = con.Id;
        us.Alias ='abbbc';
        //  us.Name ='jisna';
        insert us;
        
        
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        Campus__c   Campus1=new Campus__c();
        Campus1.Name='rag';
        Campus1.Location__c=c.id;
        Campus1.Account__c=acc.id;
        Campus1.Lithium_Bank_Account__c='State Bank';
        campus1.PAN__c='XXXXX1234X';
        campus1.GSTN__c='qwertyuiopasdfg';
        campus1.Invoice_Creation_Date__c=system.today();
        campus1.Payment_Terms__c= '30';
        campus1.Billing_City__c='mrt';
        campus1.Billing_State_Province__c='tp';
        campus1.Billing_Street__c='ee';
        campus1.Billing_Zip_Postal_Code__c='ff';
        campus1.Shipping_City__c='ff';
        campus1.Shipping_State_Province__c='ff';
        campus1.Shipping_Street__c='ff';
        campus1.Shipping_Zip_Postal_Code__c='ff';
        insert campus1;
        
        
        Notification__c noti = new Notification__c();
        noti.User_Id__c = UserInfo.getUserId();
        noti.Message__c = 'Please do the settelment of Service Provider';
        
        notificationInsertlist.add(noti);
        
        // insert notificationInsertlist;
        
        Notification__c noti1 = new Notification__c();
        noti1.User_Id__c = UserInfo.getUserId();
        noti1.Message__c = 'Please do the settelment of Service Provider';
        
        notificationInsertlist.add(noti1);
        
        insert notificationInsertlist;
        
        
        Test.startTest();
        
        Batch_InactivityReminder bc  = new Batch_InactivityReminder();
        Database.executeBatch(bc);
        
        Test.stopTest();
        
    }  
    
}