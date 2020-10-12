@isTest(SeeAllData=true)
public class AttendanceNotificationHelper_Test {
    static testMethod void createNotificationss() {
        
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
        
        list<Attendance__c> attenList = new list<Attendance__c>();
         Map<Id,Id> serviceProIDUserIdMap= new Map<Id,Id>();
        Attendance__c aht = new Attendance__c();
        
        aht.Login__c = system.now();
        
        insert aht;
        
        
        list<Notification__c> notificationInsertlist = new  list<Notification__c>();
        set<string> setnames = new set<string>();
        
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
         Campus.Site_Supervisor__c =usrObj.id ;
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
        
        Service_Provider__c service = new Service_Provider__c( );
        //  service.Service_Provider_Name1__c='TEST_Service';
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='8902290425';
        service.Aadhar_Number__c='123456789012';
        service.Name='test';
        service.Site__c=campus.id;
        service.Location__c='Bangalore';
        service.LithiumIds__c = '1234556677';
        service.Phone__c = 1234567;
        service.Last_Name__c ='test12345';
        service.First_Name__c ='testfirst';
        service.Last_Name__c='testlast';
        service.Status__c='Active';
        insert service;
        
         
        
        
        Attendance__c atten = new Attendance__c();
        
        atten.Type__c ='Check in';
        atten.Status__c='Submitted';
        atten.Login__c = system.now();
        atten.Service_Provider__c = service.Id;
       atten.Logout__c = system.now();
        insert    atten;  
        // insert attenList;
      //  Attendance__c att =[select id,Status__c from Attendance__c where id=:atten.id];
        atten.Status__c='Approved';
        update atten;
        
       // attenList.add(atten);
        
       // update attenList;
        Map<id,Attendance__c> AttentMap = new Map<id,Attendance__c>();

         list<user> userId= [select id,username,Name from User limit 10];
    //    id userId = UserInfo.getUserId();
        system.debug('userId'+userId);
        Notification__c noti = new Notification__c();
        noti.User_ID__c = userId[0].id;
        noti.Message__c='tdfsfcv';
        notificationInsertlist.add(noti);
        
        insert notificationInsertlist;
        Test.startTest();
        
        AttendanceNotificationHelper.createNotification(attenList,AttentMap);
        Test.stopTest();
    }
}