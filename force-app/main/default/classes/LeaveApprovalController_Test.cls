@isTest
public class LeaveApprovalController_Test {
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
        
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        
        
    }
    static testMethod void createLeave() {

         account ac=[select id from Account limit 1];
     	 User userid = [Select id from User limit 1];
        City__c c=[select id from City__c limit 1];
 		 Id p = [select id from profile where name='SP'].id;

        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=ac.id;
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
        campus.Site_Supervisor__c = UserInfo.getUserId();
        insert campus;
        
        
        Service_Provider__c sp=new Service_Provider__c();
        sp.Name='test';
        sp.First_Name__c = 'TestNmae';
        sp.Last_Name__c = 'test1';
        sp.LithiumIds__c = '1234';
        sp.Driving_License_Number__c='1234567890123456';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992734422';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        sp.Phone__c=1234567890;
        sp.Status__c = 'Active';
        insert sp;
        
         Contact con = new Contact(LastName ='testCon',AccountId = ac.Id,Service_Provider__c =sp.Id);
        insert con;  
                  
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       
        insert user;
        
        
        
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Leave__c' and Name = 'Planned EOS'].Id;
        Leave__c lea = new Leave__c();
        lea.RecordTypeId = strRecordTypeId;
        lea.From_date__c=system.today().addDays(10);
        lea.To_date__c = system.today().addDays(10);
        lea.Reason__c ='Family Emergency';
        lea.Approval_Request__c = 'Initial';
        lea.Service_Provider__c= sp.Id;
        insert lea;

        Test.startTest();
        LeaveApprovalController.fetchLeave();
        LeaveApprovalController.fetchLeaveHistory(sp.Id);
        LeaveApprovalController.saveRecord(lea, 'Approve');
       
        Test.stopTest();         
        
        
    }
    static testMethod void createLeave1() {

          account ac=[select id from Account limit 1];
     	 User userid = [Select id from User limit 1];
        City__c c=[select id from City__c limit 1];
        
		 		 Id p = [select id from profile where name='SP'].id;

        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=ac.id;
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
        campus.Site_Supervisor__c = UserInfo.getUserId();
        insert campus;
        
        
        Service_Provider__c sp=new Service_Provider__c();
        sp.Name='test';
        sp.First_Name__c = 'TestNmae';
        sp.Last_Name__c = 'test1';
        sp.LithiumIds__c = '1234';
        sp.Driving_License_Number__c='1234567890123456';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992734429';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        sp.Phone__c=1234567890;
        sp.Status__c = 'Active';
        insert sp;
        
         Contact con = new Contact(LastName ='testContact',AccountId = ac.Id,Service_Provider__c =sp.Id);
        insert con;  
                  
        User user = new User(alias = 'test123', email='test1883@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester212@noemail.com');
       
        insert user;
        
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Leave__c' and Name = 'Planned EOS'].Id;
        Leave__c lea = new Leave__c();
        lea.RecordTypeId = strRecordTypeId;
        lea.From_date__c=system.today().addDays(10);
        lea.To_date__c = system.today().addDays(10);
        lea.Reason__c ='Family Emergency';
        lea.Approval_Request__c = 'Initial';
        lea.Service_Provider__c= sp.Id;
        insert lea;
       
        Test.startTest();
        LeaveApprovalController.fetchLeave();
        LeaveApprovalController.fetchLeaveHistory(sp.Id);
        LeaveApprovalController.saveRecord(lea, 'Reject');
        Test.stopTest();         
        
        
    }
    


}