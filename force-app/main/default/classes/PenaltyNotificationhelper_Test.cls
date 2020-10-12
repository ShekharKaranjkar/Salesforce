@isTest
public class PenaltyNotificationhelper_Test {
    
    static testMethod void testName(){
        
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
        
        
        Id p = [select id from profile where name='SP'].id;
       
       
        
        
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
        campus.Site_Supervisor__c=usrObj.id;
        campus.Shipping_Zip_Postal_Code__c='ff';
        insert campus;
        Service_Provider__c service = new Service_Provider__c( );
        //  service.Service_Provider_Name1__c='TEST_Service';
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='1234567822';
        service.Aadhar_Number__c='123456789012';
        service.Name='test';
        service.Site__c=campus.id;
        service.Location__c='Bangalore';
        service.Phone__c = 1234567;
        service.Last_Name__c ='test12345';
        service.Status__c ='Active';
        service.First_Name__c ='Tst';
        service.LithiumIds__c ='1234556';
        insert service;
        
        
        Contact con = new Contact(LastName ='testCon',AccountId = acc.Id,Service_Provider__c =service.Id);
        insert con;  
                  
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       
        insert user;
        
        Service_Provider__c sp = [select id from Service_Provider__c Limit 1];
        list<Penalty__c>  penaltyList = new  list<Penalty__c>();
       /* Penalty__c pen = new Penalty__c();
        pen.Penalty_Reason__c ='SP Violates traffic rules';
        pen.Service_Provider_Name__c = sp.Id;
        pen.Status__c='Requested';
        penaltyList.add(pen); */
        
        Penalty__c pen1 = new Penalty__c();
        pen1.Penalty_Reason__c ='SP Violates traffic rules';
        pen1.Service_Provider_Name__c = sp.Id;
        pen1.Status__c='Requested';
        insert pen1;
         pen1.Status__c='Approved by City Ops';
          update pen1;
                Notification__c noti = new Notification__c();
                noti.User_Id__c = UserInfo.getUserId();
                noti.Message__c = 'Penalty has been raised for ';
       
        test.startTest();
         insert noti;
        Map<id,Penalty__c> penMap = new Map<id,Penalty__c>();
        //insert penaltyList;
        PenaltyNotificationhelper.createNotification(penaltyList,penMap);
        test.stopTest();
    }
}