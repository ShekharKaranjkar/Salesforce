@isTest
public class Post_Estimation_Invoice_Test {
 static TestMethod void  uploadfiles(){
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
        
        
        Service_Center__c ser = new Service_Center__c();
        
        ser.Name = 'Mettur';
        
        ser.Location__Latitude__s =11.7863 ;
        ser.Location__Longitude__s=77.8008 ;
        insert ser;
        
        Quotation__c qu = new Quotation__c();
        qu.Name = 'test';
        qu.Vehicle__c = v.id;
        qu.Goodwill_Amount__c = 1000;
        qu.Pre_Estimation_Amount__c = 1000;
        qu.Service_Center__c = ser.Id;
        insert qu;
        
        id serviceprovideId = qu.Id;
        String filetName='Test Document';
        string base64Data ='Unit Test Attachment Body'; 
        //   String Notescmt = 'Notescmt';
        
        Test.startTest();
        Post_Estimation_Invoice.uploadfiles(serviceprovideId, base64Data, filetName);
        Test.stopTest(); 
        
    }
    static TestMethod void onLoad(){
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
        
        
        Service_Center__c ser = new Service_Center__c();
        
        ser.Name = 'Mettur';
        
        ser.Location__Latitude__s =11.7863 ;
        ser.Location__Longitude__s=77.8008 ;
        insert ser;
        
        Quotation__c qu1 = new Quotation__c();
        qu1.Name = 'test';
        qu1.Vehicle__c = v.id;
        qu1.Goodwill_Amount__c = 1000;
        qu1.Pre_Estimation_Amount__c = 1000;
        qu1.Service_Center__c = ser.Id;
     //   qu1.Pre_Estimation_Invoice_Text__c = 
        insert qu1;
        
        
    
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
        cdl.LinkedEntityId = qu1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        ApexPages.standardController sc=new ApexPages.standardController(qu1);
        Post_Estimation_Invoice driver=new Post_Estimation_Invoice(sc);
        driver.onLoad();
        
        Test.stopTest(); 
    }
    static TestMethod void deleteRecord(){
        
        
        
        
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
        
        
        Service_Center__c ser = new Service_Center__c();
        
        ser.Name = 'Mettur';
        
        ser.Location__Latitude__s =11.7863 ;
        ser.Location__Longitude__s=77.8008 ;
        insert ser;
        
        Quotation__c qu2 = new Quotation__c();
        qu2.Name = 'test';
        qu2.Vehicle__c = v.id;
        qu2.Goodwill_Amount__c = 1000;
        qu2.Pre_Estimation_Amount__c = 1000;
        qu2.Service_Center__c = ser.Id;
        qu2.Post_Estimation_Invoice_Text__c = documents[0].id;
        insert qu2;
        
        //Create ContentDocumentLink  Record
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = qu2.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        
        ApexPages.standardController sc=new ApexPages.standardController(qu2);
        
        Post_Estimation_Invoice driver1 =new Post_Estimation_Invoice(sc);
        driver1.deletedriverRecord();
        Test.stopTest();
        
    }
}