@isTest(SeeAllData=true)
public class ContentiousTripNotificationHelper_Test {
   
	
	
    static testMethod void createNotification(){
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
			
		
         User userid12 = [Select id from User limit 1];
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
        campus.Site_Supervisor__c =userid12.id;
        insert campus;
        
        Service_Provider__c sp = new Service_Provider__c( );
        //  sp.Service_Provider_Name1__c='TEST_Service';
        sp.Driving_License_Number__c='1234567890123456'; 
        sp.Address__c='asd';
        sp.Phone_Number__c='1234563690';
        sp.Aadhar_Number__c='123456789012';
        sp.Name='test';
        sp.First_Name__c='T1';
       	sp.LithiumIds__c = '1233456';
        sp.Site__c=campus.id;
        sp.Location__c='Bangalore';
        sp.Phone__c = 1234567;
        sp.Last_Name__c ='test12345';
        sp.Status__c ='Active';
        insert sp;
        
       system.debug('utest ' + [SELECT ID FROM User where Contact.Service_Provider__c =: sp.Id]);
      list<Continous_trip__c> conList = new list<Continous_trip__c>();
        Continous_trip__c ct = new Continous_trip__c();
        ct.Service_Provider__c =  sp.Id;
        ct.Shift__c ='Day';
        ct.Shift_Start__c=system.now();
        ct.Shift_End__c = system.now().addDays(2);
        ct.Status__c ='Initiate';
        ct.Trip_Start__c= system.now();
        ct.Trip_End__c = system.now().addDays(2);
        insert ct;
       
        
       ct.Status__c='Approved by City Ops';
         update ct;
         list<user> userId= [select id,username,Name from User limit 10];
        system.debug('userId'+userId);
        Notification__c noti = new Notification__c();
        noti.User_Id__c =userId[0].id;
        noti.Message__c = 'Penalty has been raised for ';
        insert noti;
        Map<id,Continous_trip__c> conMap = new Map<id,Continous_trip__c>();
        
        test.startTest();
        ContentiousTripNotificationHelper.createNotification(conList,conMap);
        test.stopTest();
        
    }
}