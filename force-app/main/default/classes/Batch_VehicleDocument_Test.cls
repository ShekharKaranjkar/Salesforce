@isTest

public class Batch_VehicleDocument_Test {
    public Testmethod static void Testmethod1 () {
         Date before7days = system.today();
        Date before15dys = system.today();
        Date before30days = system.today();
        Date befor60ays = system.today();
        
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
        
        
         String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Vehicle_Documents__c' and Name = 'Fitness Certificate'].Id;
          String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Vehicle_Documents__c' and Name = 'Taxes'].Id;
        CollaborationGroup cg = new CollaborationGroup();
        cg.Name = 'MTComplianceandCOOId';
        cg.CollaborationType ='Public';

        insert cg;
        
        
        Vehicle_Documents__c vd7 = new Vehicle_Documents__c();
        vd7.RecordTypeId = strRecordTypeId;
        vd7.Date_of_Expiry__c = system.today().addDays(7);
        vd7.Expiration_Date__c = system.today().addDays(2);
     //   vd7.Registration_Number__c = 'tn 52z ';
        vd7.Receipt_Date__c = system.today();
        insert vd7;
        Vehicle_Documents__c vd15 = new Vehicle_Documents__c();
        vd15.RecordTypeId = strRecordTypeId;
        vd15.Date_of_Expiry__c = system.today().addDays(15);
        vd15.Expiration_Date__c = system.today().addDays(2);
      //   vd15.Registration_Number__c = 'tn 52z ';
        vd15.Receipt_Date__c = system.today();
        insert vd15;
         Vehicle_Documents__c vd30 = new Vehicle_Documents__c();
        vd30.RecordTypeId = strRecordTypeId;
        vd30.Date_of_Expiry__c = system.today().addDays(30);
        vd30.Expiration_Date__c = system.today().addDays(2);
      //   vd30.Registration_Number__c = 'tn 52z ';
        vd30.Receipt_Date__c = system.today();
        insert vd30;
         Vehicle_Documents__c vd60 = new Vehicle_Documents__c();
        vd60.RecordTypeId = strRecordTypeId;
        vd60.Date_of_Expiry__c = system.today().addDays(60);
        vd60.Expiration_Date__c = system.today().addDays(2);
     //    vd60.Registration_Number__c = 'tn 52z ';
        vd60.Receipt_Date__c = system.today();
        insert vd60;
        
         
        Vehicle_Documents__c vd7T = new Vehicle_Documents__c();
        vd7T.RecordTypeId = strRecordTypeId1;
        vd7T.Date_of_Expiry__c = system.today().addDays(7);
        vd7T.Expiration_Date__c = system.today().addDays(2);
    //    vd7T.Registration_Number__c = 'tn 52z ';
        vd7T.Receipt_Date__c = system.today();
        insert vd7T;
        Vehicle_Documents__c vd15T = new Vehicle_Documents__c();
        vd15T.RecordTypeId = strRecordTypeId1;
        vd15T.Date_of_Expiry__c = system.today().addDays(15);
        vd15T.Expiration_Date__c = system.today().addDays(2);
     //    vd15T.Registration_Number__c = 'tn 52z ';
        vd15.Receipt_Date__c = Date.today();
       //insert vd15T;
         Vehicle_Documents__c vd30T = new Vehicle_Documents__c();
        vd30T.RecordTypeId = strRecordTypeId1;
        vd30T.Date_of_Expiry__c = system.today().addDays(30);
        vd30T.Expiration_Date__c = system.today().addDays(2);
       //  vd30T.Registration_Number__c = 'tn 52z ';
        vd30T.Receipt_Date__c = system.today();
        insert vd30T;
         Vehicle_Documents__c vd60T = new Vehicle_Documents__c();
        vd60T.RecordTypeId = strRecordTypeId1;
        vd60T.Date_of_Expiry__c = system.today().addDays(60);
        vd60T.Expiration_Date__c = system.today().addDays(2);
     //    vd60T.Registration_Number__c = 'tn 52z ';
        vd60T.Receipt_Date__c = system.today();
        insert vd60T;
        
         Map<string,FeedItem> feeditemaList =new   Map<string,FeedItem>();
        
           FeedItem fi = New FeedItem(ParentId = cg.id,Body = '7 days to go for this Record'+vd60T.Name);
        feeditemaList.put(vd60T.Name,fi);
        insert feeditemaList.values();
        
        Test.startTest();
        Batch_VehicleDocument bv = new Batch_VehicleDocument();
          Database.executeBatch(bv);
        Test.stopTest();
    }
}