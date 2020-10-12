@isTest
public class AttendanceApprovalController_Test {
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
	
	
    static testMethod void fetchattendance() {
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
        Campus.Site_Supervisor__c =userid.id ;
       // Campus.Site_Incharge__c =userid.Id;
           // Campus.Cluster_Head__c=userid.Id;
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
          service.Status__c='Active';
        service.Location__c='Bangalore';
        service.Phone__c = 1234567;
        service.Last_Name__c ='test';
        insert service;
        
        Attendance__c att = new Attendance__c();
        att.Service_Provider__c = service.Id;
        att.Type__c ='Check in';
        att.Status__c='Submitted';
        att.Login__c = system.now();
        insert att;
        
        Test.startTest();
       
         AttendanceApprovalController.fetchAttendance();

        Test.stopTest();
        
    }
    static testMethod void saveRecord() {
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
         Campus.Site_Supervisor__c =userid.id ;
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
        service.Status__c='Active';
        service.Last_Name__c ='test';
        insert service;
        
        Attendance__c att = new Attendance__c();
        att.Service_Provider__c = service.Id;
        att.Type__c ='Check in';
        att.Status__c='Submitted';
        att.Login__c = system.now();
        insert att;
        
        Attendance__c attendance = [select id from Attendance__c where id =:att.Id];
        
        attendance.Type__c ='Check in';
        attendance.Status__c='Approved';
        attendance.Service_Provider__c=service.Id;
        update attendance;
       
        Test.startTest();
       
         AttendanceApprovalController.saveRecord(attendance);

        Test.stopTest();
    }
    static testMethod void saverej() {
        
         User userid = [Select id from User limit 1];
        
         account acc=new account();
        acc.Name='rag1';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        Campus__c   Campus=new Campus__c();
        Campus.Name='rag1';
        Campus.Location__c=c.id;
        Campus.Account__c=acc.id;
        Campus.Lithium_Bank_Account__c='State Bank';
        campus.PAN__c='XXXXX1234X';
        campus.GSTN__c='qwertyuiopasdfg';
        campus.Invoice_Creation_Date__c=system.today();
        campus.Payment_Terms__c= '30';
        campus.Billing_City__c='mrt';
           Campus.Site_Supervisor__c =userid.id ;
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
        service.Name='test1';
        service.Site__c=campus.id;
        service.Location__c='Bangalore';
        service.Phone__c = 1234567;
        service.Last_Name__c ='test2';
          service.Status__c='Active';
        insert service;
        
        Attendance__c attendance = new Attendance__c();
        
        attendance.Type__c ='Check in';
        attendance.Status__c='Rejected';
        attendance.Login__c = system.now();
        attendance.Service_Provider__c=service.Id;
        insert attendance;
        
   
       
        Test.startTest();
       
         AttendanceApprovalController.saverej(attendance);
//AttendanceNotificationHelper.createNotification(attenList);
        Test.stopTest();
    }
}