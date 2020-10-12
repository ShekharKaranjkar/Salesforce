@isTest
public class NOC_From_Lesse_Test {
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
        
        Vehicle__c v1 = new Vehicle__c();
        v1.Name = 'MP09213421';
        v1.City__c = c.id;
        v1.Finance_Type__c ='Owned';
        v1.Financer__c = 'Intelligrow';
        v1.Delivery_Date__c = system.today().addDays(3);
        v1.Site__c=campus.Id;
        v1.VIN_Number__c='12345678901234567';
        v1.Re_enter_VIN_Number__c='12345678901234567';
        v1.Lease_Loan_Amount__c= 1000;
        v1.Lease_Loan_Start_Date__c = system.today();
        v1.Lease_Loan_End_Date__c= system.today().addDays(3);
        v1.OEM__c ='Tata';
        v1.Manufacturing_Date__c = system.today().addDays(4);
        v1.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v1.Date_of_Purchase__c=system.today().addDays(2);
        v1.RC_Registration_Date__c = system.today().addDays(1);
        
        insert v1;
        
        id serviceprovideId = v1.Id;
        String filetName='Test Document';
        string base64Data ='Unit Test Attachment Body'; 
        //   String Notescmt = 'Notescmt';
        
        Test.startTest();
        NOC_From_Lesse.uploadfiles(serviceprovideId, base64Data, filetName);
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
        
        Vehicle__c v2 = new Vehicle__c();
        v2.Name = 'MP09213421';
        v2.City__c = c.id;
        v2.Finance_Type__c ='Owned';
        v2.Financer__c = 'Intelligrow';
        v2.Delivery_Date__c = system.today().addDays(3);
        v2.Site__c=campus.Id;
        v2.VIN_Number__c='12345678901234567';
        v2.Re_enter_VIN_Number__c='12345678901234567';
        v2.Lease_Loan_Amount__c= 1000;
        v2.Lease_Loan_Start_Date__c = system.today();
        v2.Lease_Loan_End_Date__c= system.today().addDays(3);
        v2.OEM__c ='Tata';
        v2.Manufacturing_Date__c = system.today().addDays(4);
        v2.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v2.Date_of_Purchase__c=system.today().addDays(2);
        v2.RC_Registration_Date__c = system.today().addDays(1);
        
        insert v2;
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
        cdl.LinkedEntityId = v2.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        ApexPages.standardController sc=new ApexPages.standardController(v2);
        NOC_From_Lesse Nocform=new NOC_From_Lesse(sc);
        Nocform.onLoad();
        
        Test.stopTest(); 
        
    }
    
    static TestMethod void deleteRecord(){
        
        
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
        
        Vehicle__c v2 = new Vehicle__c();
         v2.Name = 'MP09213421';
        v2.City__c = c.id;
        v2.Finance_Type__c ='Owned';
        v2.Financer__c = 'Intelligrow';
        v2.Delivery_Date__c = system.today().addDays(3);
        v2.Site__c=campus.Id;
        v2.VIN_Number__c='12345678901234567';
        v2.Re_enter_VIN_Number__c='12345678901234567';
        v2.Lease_Loan_Amount__c= 1000;
        v2.Lease_Loan_Start_Date__c = system.today();
        v2.Lease_Loan_End_Date__c= system.today().addDays(3);
        v2.OEM__c ='Tata';
        v2.Manufacturing_Date__c = system.today().addDays(4);
        v2.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v2.Date_of_Purchase__c=system.today().addDays(2);
        v2.RC_Registration_Date__c = system.today().addDays(1);
        v2.NOC_from_Lesse__c = documents[0].Id;
        insert v2;
        Test.startTest();
        
        ApexPages.standardController sc=new ApexPages.standardController(v2);
        NOC_From_Lesse noc= new NOC_From_Lesse(sc);
        noc.deleteRecord();
        Test.stopTest();
    } 
}