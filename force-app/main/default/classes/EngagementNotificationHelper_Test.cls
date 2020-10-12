@isTest
public class EngagementNotificationHelper_Test {
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
            campus.Site_Supervisor__c=usrObj.id;
        insert campus;
         
        
        
    }
  @isTest static void tstmethod () {
         
        
        list<Engagement_Activities__c>enList = new list<Engagement_Activities__c>();
       Map<id,Engagement_Activities__c> EngMap = new Map<id,Engagement_Activities__c> ();
       Campus__c campus = [Select id from Campus__c limit 1];
      Id p = [select id from profile where name='SP'].id;
      
        User usRec = [Select id from User limit 1];
       account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        Campus__c   Campus1=new Campus__c();
        Campus1.Name='TestCam';
        Campus1.Location__c=c.id;
        Campus1.Account__c=acc.id;
        Campus1.Lithium_Bank_Account__c='State Bank';
        Campus1.PAN__c='XXXXX1234X';
        Campus1.GSTN__c='qwertyuiopasdfg';
        Campus1.Invoice_Creation_Date__c=system.today();
        Campus1.Payment_Terms__c= '30';
        Campus1.Billing_City__c='mrt';
        Campus1.Billing_State_Province__c='tp';
        Campus1.Billing_Street__c='ee';
        Campus1.Billing_Zip_Postal_Code__c='ff';
        Campus1.Shipping_City__c='ff';
        Campus1.Shipping_State_Province__c='ff';
        Campus1.Shipping_Street__c='ff';
        Campus1.Shipping_Zip_Postal_Code__c='ff';
            Campus1.Site_Supervisor__c=usRec.id;
        insert Campus1;
        list<Engagement_Activities__c> updateList = new  list<Engagement_Activities__c>();
       
        
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
      sp.First_Name__c ='tst';
      sp.LithiumIds__c ='213455';
      
      sp.Status__c='Active';
        insert sp;
        
       Contact con = new Contact(LastName ='testCon',AccountId = acc.Id,Service_Provider__c =sp.Id);
        insert con;  
         List<User> lUser = new List<User>();         
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       lUser.add(user);
        insert lUser;
         Map<Id,List<User>> spUserIDMap =new Map<Id,list<User>>();
      spUserIDMap.put(lUser[0].Id,lUser);
         Engagement_Activities__c en1 = new Engagement_Activities__c();
        en1.Site__c = campus.Id;
        en1.Activity_Name__c = 'test';
        en1.Start_Date__c = system.today();
      
		en1.City__c = c.Id;     
        enList.add(en1);
        
      
       
        Test.startTest();
      insert enList;
      
      enList[0].Site__c = campus1.Id;
      update enList;
      EngMap.put(enList[0].Site__c ,enList[0]);
       
        EngagementNotificationHelper.createNotification(enList);
        Test.stopTest();
        
    }
}