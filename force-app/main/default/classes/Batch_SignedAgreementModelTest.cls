@isTest
public class Batch_SignedAgreementModelTest {
    
    
    public Testmethod static void tstmethod () {
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
        campus.Site_Supervisor__c =usrObj.Id;
        insert campus;
        
        
        Service_Provider__c sp = new Service_Provider__c( );
        //  sp.sp_Provider_Name1__c='TEST_sp';
        sp.Driving_License_Number__c='1234567890123456'; 
        sp.Address__c='asd';
        sp.Phone_Number__c='1234567890';
        sp.Aadhar_Number__c='123456789012';
        sp.Name='test';
        sp.Site__c=campus.id;
        sp.Location__c='Bangalore';
        sp.Phone__c = 1234567;
        sp.Last_Name__c ='test12345';
        sp.Signed_Agreement_Model__c ='12 hrs';
        sp.Status__c ='Active';
        insert sp;
        
        List<Attendance__c> attenList = new List<Attendance__c>();
        
        Attendance__c att = new Attendance__c();
        att.Service_Provider__c = sp.Id;
        att.Type__c ='Check in';
        att.Status__c='Submitted';
        att.Login__c = system.now().addHours(-14);
       // att.Logout__c =  system.now().addHours(-14);
        insert att;
        List<Attendance__c> updateattList = new List<Attendance__c>();
        Test.startTest();
        Batch_SignedAgreementModel bc  = new Batch_SignedAgreementModel();
        Database.executeBatch(bc);
        
        Test.stopTest();
        
    }
    public Testmethod static void tstmethod1 () {
        
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
        campus.Site_Supervisor__c =usrObj.Id;
        insert campus;
        
      
        
        Service_Provider__c sp1 = new Service_Provider__c( );
        //  sp.sp_Provider_Name1__c='TEST_sp';
        sp1.Driving_License_Number__c='1234567890123456'; 
        sp1.Address__c='asd';
        sp1.Phone_Number__c='1234567890';
        sp1.Aadhar_Number__c='123456789012';
        sp1.Name='test';
        sp1.Site__c=campus.id;
        sp1.Location__c='Bangalore';
        sp1.Phone__c = 1234567;
        sp1.Last_Name__c ='test12345';
        sp1.Signed_Agreement_Model__c ='16 hrs';
         sp1.Status__c ='Active';
        insert sp1;
        
        List<Attendance__c> attenList = new List<Attendance__c>();
        
        Attendance__c att1 = new Attendance__c();
        att1.Service_Provider__c = sp1.Id;
        att1.Type__c ='Check in';
        att1.Status__c='Submitted';
        att1.Login__c = system.now().addHours(-16);
        
        insert att1;
        List<Attendance__c> updateattList = new List<Attendance__c>();
        Test.startTest();
        Batch_SignedAgreementModel bc  = new Batch_SignedAgreementModel();
        Database.executeBatch(bc);
        
        Test.stopTest();
        
    }
}