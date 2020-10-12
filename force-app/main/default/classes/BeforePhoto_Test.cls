@isTest
public class BeforePhoto_Test {
 static TestMethod void  uploadfiles(){
String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Issues__c' and Name = 'Accident'].Id;
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
        insert campus;
        Service_Provider__c service = new Service_Provider__c( );
      //  service.Service_Provider_Name1__c='TEST_Service';
        service.Driving_License_Number__c='1234567890123456'; 
        service.Address__c='asd';
        service.Phone_Number__c='1234567890';
        service.Aadhar_Number__c='123456789012';
        service.Name='test';
        service.Site__c=campus.id;
        service.Location__c='Bangalore';
        service.Phone__c = 1234567;
        
        insert service;
        
        Vehicle__c v= new Vehicle__c();
        v.Site__c=campus.Id;
        v.VIN_Number__c='23456789052234567';
        v.Name = 'MP09213421';
        v.City__c = c.id;
        v.Finance_Type__c ='Owned';
        v.Financer__c = 'Intelligrow';
        v.Delivery_Date__c = system.today().addDays(3);
        v.Re_enter_VIN_Number__c='23456789052234567';
        v.Status1__c='New';
        v.Lease_Loan_Amount__c= 1000;
        v.Lease_Loan_Start_Date__c = system.today();
        v.Lease_Loan_End_Date__c= system.today().addDays(3);
        v.OEM__c ='Tata';
        v.Manufacturing_Date__c = system.today().addDays(4);
        v.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v.Date_of_Purchase__c=system.today().addDays(2);
        v.RC_Registration_Date__c = system.today().addDays(1);
        insert v;
        
        
        Issues__c iss = new Issues__c();
        iss.RecordTypeId = strRecordTypeId;
        iss.Typecase__c = 'Give to 3rd Party';
        iss.Amount__c = 100;
        iss.Service_Provider__c= service.id;
        iss.Vehicle__c = v.id;
        iss.Policy_No__c = 'test';
        iss.Vehicle_Model__c = '123';
        iss.Vehicle_Make__c = '123';
        iss.Insurance_Company__c = 'test';
        iss.Details__c = 'test';
        iss.Name__c = 'test';
        iss.Phone__c = '1234567';
                  insert iss;
        
        id serviceprovideId = iss.Id;
        String filetName='Test Document';
        string base64Data ='Unit Test Attachment Body'; 
        //   String Notescmt = 'Notescmt';
        
        Test.startTest();
        BeforePhoto.uploadfiles(serviceprovideId, base64Data, filetName);
        Test.stopTest(); 
        
    }
    static TestMethod void onLoad(){
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Issues__c' and Name = 'Accident'].Id;
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
        insert campus;
        Service_Provider__c service1 = new Service_Provider__c( );
     //   service1.Service_Provider_Name1__c='TEST_Service';
        service1.Driving_License_Number__c='1234567890123456'; 
        service1.Address__c='asd';
        service1.Phone_Number__c='1234567890';
        service1.Aadhar_Number__c='123456789012';
        service1.Name='test';
        service1.Site__c=campus.id;
        service1.Phone__c = 1234567;
        service1.Location__c ='Bangalore';
        
        insert service1;
        
         
        
        Vehicle__c v= new Vehicle__c();
        v.Site__c=campus.Id;
        v.VIN_Number__c='23456789052234567';
        v.Name = 'MP09213421';
        v.City__c = c.id;
        v.Finance_Type__c ='Owned';
        v.Financer__c = 'Intelligrow';
        v.Delivery_Date__c = system.today().addDays(3);
        v.Re_enter_VIN_Number__c='23456789052234567';
        v.Status1__c='New';
        v.Lease_Loan_Amount__c= 1000;
        v.Lease_Loan_Start_Date__c = system.today();
        v.Lease_Loan_End_Date__c= system.today().addDays(3);
        v.OEM__c ='Tata';
        v.Manufacturing_Date__c = system.today().addDays(4);
        v.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v.Date_of_Purchase__c=system.today().addDays(2);
        v.RC_Registration_Date__c = system.today().addDays(1);
        insert v;
        
        
        Issues__c iss1 = new Issues__c();
        iss1.RecordTypeId = strRecordTypeId;
        iss1.Typecase__c = 'Give to 3rd Party';
        iss1.Amount__c = 100;
        iss1.Service_Provider__c= service1.id;
        iss1.Vehicle__c = v.id;
        iss1.Policy_No__c = 'test';
        iss1.Vehicle_Model__c = '123';
        iss1.Vehicle_Make__c = '123';
        iss1.Insurance_Company__c = 'test';
        iss1.Details__c = 'test';
        iss1.Name__c = 'test';
        iss1.Phone__c = '1234567';
                  insert iss1;
        
        ContentVersion contentVersionInsert = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true
        );
        insert contentVersionInsert;
        
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        String addressProofNm = documents[0].Title;
        
        //Create ContentDocumentLink  Record
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = iss1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        ApexPages.standardController sc=new ApexPages.standardController(iss1);
        BeforePhoto driver=new BeforePhoto(sc);
        driver.onLoad();
       
        Test.stopTest(); 
    }
     static TestMethod void deleteRecord(){
        
        
   String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Issues__c' and Name = 'Accident'].Id;
         // Create Content Version Record
        ContentVersion contentVersionInsert = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true
        );
        insert contentVersionInsert;
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument limit 1];
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
        insert campus;
        Service_Provider__c service2 = new Service_Provider__c( );
        //service2.name='TEST_Service';
        service2.Driving_License_Number__c='1234567890123456'; 
        service2.Address__c='asd';
        service2.Phone_Number__c='1234567890';
        service2.Aadhar_Number__c='123456789012';
        service2.Name='test';
        service2.Site__c=campus.id;
        service2.Phone__c = 1234567;
     //  service2.Driver_License_Proof__c = documents[0].Id;
         service2.Location__c ='Bangalore';
        insert service2;
         
         
             Vehicle__c v= new Vehicle__c();
        v.Site__c=campus.Id;
        v.VIN_Number__c='23456789052234567';
        v.Name = 'MP09213421';
        v.City__c = c.id;
        v.Finance_Type__c ='Owned';
        v.Financer__c = 'Intelligrow';
        v.Delivery_Date__c = system.today().addDays(3);
        v.Re_enter_VIN_Number__c='23456789052234567';
        v.Status1__c='New';
        v.Lease_Loan_Amount__c= 1000;
        v.Lease_Loan_Start_Date__c = system.today();
        v.Lease_Loan_End_Date__c= system.today().addDays(3);
        v.OEM__c ='Tata';
        v.Manufacturing_Date__c = system.today().addDays(4);
        v.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v.Date_of_Purchase__c=system.today().addDays(2);
        v.RC_Registration_Date__c = system.today().addDays(1);
        insert v;
        
        
        Issues__c iss2 = new Issues__c();
        iss2.RecordTypeId = strRecordTypeId;
        iss2.Typecase__c = 'Give to 3rd Party';
        iss2.Amount__c = 100;
        iss2.Service_Provider__c= service2.id;
        iss2.Vehicle__c = v.id;
        iss2.Policy_No__c = 'test';
        iss2.Vehicle_Model__c = '123';
        iss2.Vehicle_Make__c = '123';
        iss2.Insurance_Company__c = 'test';
        iss2.Details__c = 'test';
        iss2.Name__c = 'test';
         iss2.Before_Photo_Id_Text__c =  documents[0].Id;
        iss2.Phone__c = '1234567';
                  insert iss2;
         
           //Create ContentDocumentLink  Record
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = service2.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();

        ApexPages.standardController sc=new ApexPages.standardController(iss2);
      
          BeforePhoto driver1=new BeforePhoto(sc);
        driver1.deleteRecord();
        Test.stopTest();
        
    }

}