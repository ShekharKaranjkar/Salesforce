@isTest
public class ExternalUserLoginTest {
    
    @isTest
    public static void unitTest1(){      
        Account ac = new Account(Name ='Lithium Service Providers');
        insert ac;
        
        Contact con = new Contact(FirstName ='Test',LastName = 'Test',MobilePhone = '9843190458' ,IsFirstLogin__c = true,AccountId = ac.Id,username__c ='testemail'+Math.round(Math.random()*Math.pow(10, 7))+'@testemail.com',Email ='testemail'+Math.round(Math.random()*Math.pow(10, 7))+'@testemail.com',userid__c='test123');
        insert con;
        
        //system.runAs(u) {
            Test.startTest();
            ExternalUserLogin.getOtp(con.MobilePhone); 
            ExternalUserLogin.getOtp('32435345');
            ExternalUserLogin.checkStatus(con.MobilePhone);
            ExternalUserLogin.checkStatus('32435345');
            ExternalUserLogin.setUserPassword(con.MobilePhone,'Test@123');
            ExternalUserLogin.setUserPassword('32435345','Test@123');
            ExternalUserLogin.loginPassword(con.MobilePhone,'Test@123');
            ExternalUserLogin.loginPassword('32435345','Test@123');
        	ExternalUserLogin.loginSOAP(con.MobilePhone,'Test@123');
            
            Test.stopTest();
        //}
    }
}