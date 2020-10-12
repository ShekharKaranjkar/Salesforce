@isTest
public class ChangeUserContactUserName_Test {
static testMethod void testMethod2() {
  
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        
        contact c=new contact();
        c.LastName='test';
        c.MobilePhone='8791634367';
        c.AccountId=acc.id;
        insert c;
        
          Profile profileId = [SELECT Id FROM Profile WHERE Name = 'SP' LIMIT 1];
        User usrObj = new User();
        usrObj.LastName = 'TestLast';
        usrObj.FirstName='TestFirst';
        usrObj.Alias = 'tst';
        usrObj.Email = 'test@test.com';
        usrObj.ContactId=c.id;
        usrObj.Username = '8791634367@lithiumtest.com';
        usrObj.MobilePhone='8791634367';
        usrObj.ProfileId = profileId.id;
        usrObj.TimeZoneSidKey = 'GMT';
        usrObj.LanguageLocaleKey = 'en_US';
        usrObj.EmailEncodingKey = 'UTF-8';
        usrObj.LocaleSidKey = 'en_US';
        usrObj.IsActive=True;
        //usrObj.userRoleId='00EC0000001EkqFMAS';
        //usrObj.UserRole.Name='CRM Rep';
        insert usrObj;
        

        
        City__c ci=new City__c();
        ci.Account__c=acc.id;
        ci.Name='ncr';
        insert ci;
        
        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=ci.Id;
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
        // service.Service_Provider_Name1__c='TEST_Service';
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='1234567890';
        service.Aadhar_Number__c='123456789012';
        service.Name='test';
        service.Site__c=campus.id;
        service.Location__c='Pune';
        service.Phone__c = 1234567;
        service.Last_Name__c ='testname1';
        service.Status__c ='Active';
        insert service;
        c.Service_Provider__c=service.Id;
        update c;
        service.Phone_Number__c ='9933026315';
        update service;
          
         Test.startTest();
     //   LithiumIdFormat.changeUserContactPhone(spNewMap,spOldMap);
        Test.stopTest();
    }
}