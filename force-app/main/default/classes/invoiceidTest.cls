@isTest
public class invoiceidTest {
    static testmethod void generatetestmethod(){
        // list<RecordType> rList = [Select id From RecordType Where sObjectType = 'Invoices__c' and RecordType.<b>DeveloperName</b>= 'Regular'];
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Invoices__c' and Name = 'Regular'].Id;
        
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
        
            Location__c locObj=new Location__c();
            locObj.Name='Test2';
            locObj.ownerId = usrObj.id; 
            insert locObj;
        
                Billing_Locations__c settingObj = new Billing_Locations__c();
        		settingObj.Name = 'Bangalore';
        		settingObj.City__c = 'Bangalore';
        		settingObj.GSTIN__c = '1234567';
                settingObj.Location_Name__c =locObj.id;
                settingObj.state__c ='Karnataka';
                settingObj.Street_Address__c = '';
                settingObj.Zip_Code__c = '12345';
                insert settingObj;
                    
        
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
        Insert Campus;
        
        Invoices__c inv = new Invoices__c();
        inv.No_of_Vehicles__c = 12;
        inv.Rate_per_Car__c = 12;
        inv.Account__c = Acc.id;
        inv.Amount__C = 1234567;
        
        inv.AmountG__c = 123456;
        inv.Amountcn__c = 1234567;
        inv.Campus__c = Campus.Id;
        inv.Description__c = 'Test Regular';
        inv.Due_Date__c = system.today();
        inv.Date__c = system.today();
        inv.RecordTypeId = strRecordTypeId;
        insert inv;
        

        
         Test.StartTest(); 
        
        PageReference pageRef = Page.createpdf; // Add your VF page Name here
        pageRef.getParameters().put('recId', String.valueOf(inv.Id));
        Test.setCurrentPage(pageRef);
       invoiceId1 testAccPlan = new invoiceId1();
       Test.StopTest();
        
        
        
    }
}