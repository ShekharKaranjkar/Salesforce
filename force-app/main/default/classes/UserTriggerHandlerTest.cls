@IsTest
public class UserTriggerHandlerTest {
 @IsTest
    Static void controllerTestMethod(){
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
        insert usrObj;
         usrObj.Username = 'abc@gmail.com';
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
       
        System.runAs (thisUser) {
             update usrObj;
        }
       
    }
}