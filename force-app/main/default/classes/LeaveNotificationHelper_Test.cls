@isTest
public class LeaveNotificationHelper_Test {
    
    static testMethod void createNotificationss() {
        
        Id leaveTypeId = Schema.SObjectType.Leave__c.getRecordTypeInfosByDeveloperName().get('Emergency_Leave').getRecordTypeId();
        Id leaveTypeIdplanned = Schema.SObjectType.Leave__c.getRecordTypeInfosByDeveloperName().get('Planned_Leave').getRecordTypeId();
        //  list<Leave__c>leaveList1 = new list<Leave__c>();
        
        list<Leave__c>leaveList = new list<Leave__c>();

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
        
         contact con=new contact();
        con.LastName='test';
        con.MobilePhone='8791634367';
        con.AccountId=acc.id;
        con.Service_Provider__c = service.id;
        insert con;
         Profile profileId = [SELECT Id FROM Profile WHERE Name = 'SP' LIMIT 1];
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
       			 usrObj.ContactId = con.Id;
				//usrObj.userRoleId='00EC0000001EkqFMAS';
				//usrObj.UserRole.Name='CRM Rep';
				insert usrObj;
        
        Leave__c le2 = new Leave__c();
        le2.RecordTypeId =leaveTypeIdplanned;
        le2.From_date__c = system.today().addDays(3);
        le2.To_date__c = system.today().addDays(3);
        
        le2.Approval_Request__c = 'Initial';
        le2.Service_Provider__c = service.Id;  
        insert le2;
        le2.Approval_Request__c='Rejected';
        update le2;
        
        le2.Approval_Request__c='Approved By Hr';
        update le2;
        Leave__c le1 = new Leave__c();
        le1.RecordTypeId =leaveTypeId;
        le1.From_date__c = system.today().addDays(-3);
        le1.To_date__c = system.today().addDays(-3);
        le1.Emergency_Type__c ='Pre Emergency';
        le1.Emergency_Leave_Approval__c = 'Initiate';
        le1.Service_Provider__c = service.Id;  
        insert le1;
        
        le1.Emergency_Leave_Approval__c='Approved';
        update le1;
        
        le1.Emergency_Leave_Approval__c='Rejected';
        update le1;
        // attenList.add(atten);
        
        // update attenList;
        
        
        list<user> userId= [select id,username,Name from User limit 10];
        //    id userId = UserInfo.getUserId();
        system.debug('userId'+userId);
        Notification__c noti = new Notification__c();
        noti.User_ID__c = userId[0].id;
        noti.Message__c='tdfsfcv';
        notificationInsertlist.add(noti);
        
        insert notificationInsertlist;
        Test.startTest();
        
        LeaveNotificationHelper.createNotification(leaveList);
        Test.stopTest();
    }
    
}