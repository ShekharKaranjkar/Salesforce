@isTest
public class ExternalUserChangePasswordTest {
	@isTest
    public static void unitTest1(){
        Profile p = [SELECT Id FROM Profile WHERE Name='SP']; 
        
        Account acc = new Account(Name ='Lithium Service Providers');
        insert acc;
        Contact con = new Contact(FirstName ='Test',LastName = 'Test',MobilePhone = '9438695401' ,AccountId = acc.Id);
        insert con;
        User user = [SELECT Id FROM User WHERE ContactId =: con.Id];
        
        System.runAs(user) {
            ExternalUserChangePassword ecp = new ExternalUserChangePassword();
            ecp.onLoad();
            ecp.confirmPassword = 'admin@123';
            ecp.newPassword = 'admin@123';
            ecp.setPassword();
    		ecp.newPassword = 'admin@1233';
            ecp.setPassword();
    		ecp.newPassword = '';
            ecp.setPassword();
            ecp.confirmPassword = '';
            ecp.setPassword();
            
    		
        }
    }
}