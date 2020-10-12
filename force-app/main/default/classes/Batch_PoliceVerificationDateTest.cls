@isTest
public class Batch_PoliceVerificationDateTest {
    static testMethod void createNotification() {
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
          Date before2days = system.today();
        List<Compliance__c> complainceList = new List<Compliance__c>();
        
        Account Acc = new Account();
        Acc.Name = 'Test 15:56';
        Acc.Lithium_Bank_Account__c  = 'Bangalore';
        Acc.Lithium_Billing_Entity__c  = 'Canara Bank';
        Insert Acc;
        
        City__c City = new City__c();
        City.Name = 'Bangalore';
        City.Account__c = Acc.id;
        insert City;
        
        Campus__c Campus = new Campus__c();
        Campus.Name = 'Test 15:43';
        Campus.Location__c = City.id;
        Campus.Account__c = Acc.Id;
        Campus.Lithium_Billing_Entity__c = 'Bangalore';
        Campus.Lithium_Bank_Account__c = 'Canara Bank';
        Campus.PAN__c = 'AAAAA1234A';
        Campus.GSTN__c = '29AABCT5589K1ZL';
        Campus.Invoice_Creation_Date__c = system.today();
        Campus.Payment_Terms__c = '30';
        Campus.Billing_Street__c = 'xcvbn';
        Campus.Billing_City__c = 'KA';
        Campus.Billing_State_Province__c = 'KA';
        Campus.Billing_Country__c = 'INdia';
        Campus.Billing_Zip_Postal_Code__c = '1234565';
        Campus.Shipping_City__c ='Chennai';
        Campus.Shipping_Country__c = 'India';
        Campus.Shipping_State_Province__c = 'KA';
        Campus.Shipping_Street__c = 'xyz';
        Campus.Shipping_Zip_Postal_Code__c = '123456';
        Campus.Site_Supervisor__c=usrObj.Id;
        Insert Campus;
        
        Service_Provider__c sp=new Service_Provider__c();
        sp.Name='ru';
        sp.Driving_License_Number__c='1234561890123457';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992134424';
        sp.Aadhar_Number__c='122456789022';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        sp.Phone__c=1214567892;
        sp.Status__c ='Active';
        sp.Last_Name__c ='kamal';
        insert sp;        
        
        Compliance__c com = new Compliance__c();
        com.Police_Verification_Date__c = system.today().addDays(14);
        com.Lithium_ID__c = sp.Id;
        
        complainceList.add(com);
         insert complainceList;
        Test.startTest();
       
        Batch_PoliceVerificationDate lve = new Batch_PoliceVerificationDate(); 
        database.executebatch(lve);
        Test.stopTest();
    }
}