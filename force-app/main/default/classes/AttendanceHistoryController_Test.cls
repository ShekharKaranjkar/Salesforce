@isTest
public class AttendanceHistoryController_Test {
    static TestMethod void  aatten(){
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
         account ac=new account();
        ac.Name='rag';
        ac.Lithium_Billing_Entity__c='Pune';
        ac.Lithium_Bank_Account__c='State Bank';
        insert ac;
        
        Contact con = new Contact();
        con.LastName='tetse';
        con.AccountId = ac.Id;
        
        insert con;
        City__c c=new City__c();
        c.Account__c=ac.id;
        insert c;
        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=ac.id;
        Campus.Lithium_Bank_Account__c='State Bank';
        campus.PAN__c='XXXXX1234X';
        campus.GSTN__c='qwertyuiopasdfg';
        campus.Invoice_Creation_Date__c=system.today();
        campus.Payment_Terms__c= '30';
        campus.Site_Supervisor__c = usrObj.Id;
        campus.Billing_City__c='mrt';
        campus.Billing_State_Province__c='tp';
        campus.Billing_Street__c='ee';
        campus.Billing_Zip_Postal_Code__c='ff';
        campus.Shipping_City__c='ff';
        campus.Shipping_State_Province__c='ff';
        campus.Shipping_Street__c='ff';
        campus.Shipping_Zip_Postal_Code__c='ff';
        insert campus;
        
        
        Service_Provider__c sp=new Service_Provider__c();
        sp.Name='test';
        sp.Last_Name__c = 'test1';
        sp.Driving_License_Number__c='1234567890123456';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992734422';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        sp.Phone__c=1234567890;
        sp.Status__c='Active';
        insert sp;
        
        
          
        Attendance__c atten = new Attendance__c();
        
        atten.Type__c ='Check in';
        atten.Status__c='Submitted';
        atten.Login__c = system.now();
        atten.Service_Provider__c = sp.Id;
        //   insert attenList;
        insert    atten;  
        
        Test.startTest();
        AttendanceHistoryController.attendanceHistoryMethod();
        Test.stopTest();
    }
}