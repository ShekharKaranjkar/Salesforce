@isTest
public class PenaltyController_Test {
   static TestMethod void  uploadfiles(){
        account ac=new account();
        ac.Name='rag';
        ac.Lithium_Billing_Entity__c='Pune';
        ac.Lithium_Bank_Account__c='State Bank';
        insert ac;
        City__c c=new City__c();
        c.Account__c=ac.id;
        insert c;
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
        insert campus;
        
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
        sp.Status__c = 'Active';
        insert sp;
        
        Penalty__c pen1 = new Penalty__c();
        pen1.Penalty_Reason__c ='SP Violates traffic rules';
        pen1.Service_Provider_Name__c = sp.Id;
        pen1.Status__c='Requested';
        insert pen1;
       
        id serviceprovideId = pen1.Id;
        String filetName='Test Document';
        string base64Data ='Unit Test Attachment Body'; 
        //   String Notescmt = 'Notescmt';
        ContentVersion contentVersionInsert = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true
        );
        insert contentVersionInsert;
        pen1.Penalty_Picture__c = contentVersionInsert.Id;
        update sp;
        Test.startTest();
        PenaltyController.uploadfiles(serviceprovideId,contentVersionInsert.Id);
        Test.stopTest(); 
        
    }
    static TestMethod void onLoad(){
        
        account ac=new account();
        ac.Name='rag';
        ac.Lithium_Billing_Entity__c='Pune';
        ac.Lithium_Bank_Account__c='State Bank';
        insert ac;
        City__c c=new City__c();
        c.Account__c=ac.id;
        insert c;
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
        insert campus;
        
        Service_Provider__c sp1=new Service_Provider__c();
        sp1.Name='test1';
        sp1.Last_Name__c = 'test11';
        sp1.Driving_License_Number__c='1234567890123456';
        sp1.Address__c='209,ga';
        sp1.Phone_Number__c='9992734425';
        sp1.Aadhar_Number__c='123456789012';
        sp1.Location__c='Hyderabad';
        sp1.Site__c=campus.id;
        sp1.Phone__c=1234567890;
        sp1.Status__c = 'Active';
        insert sp1;
        
         Penalty__c pen1 = new Penalty__c();
        pen1.Penalty_Reason__c ='SP Violates traffic rules';
        pen1.Service_Provider_Name__c = sp1.Id;
        pen1.Status__c='Requested';
        insert pen1;
        
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
        cdl.LinkedEntityId = sp1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        
        ApexPages.standardController sc=new ApexPages.standardController(pen1);
        PenaltyController db=new PenaltyController(sc);
        db.onLoad();
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
        
        account ac=new account();
        ac.Name='rag';
        ac.Lithium_Billing_Entity__c='Pune';
        ac.Lithium_Bank_Account__c='State Bank';
        insert ac;
        City__c c=new City__c();
        c.Account__c=ac.id;
        insert c;
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
        insert campus;
        
        Service_Provider__c sp2=new Service_Provider__c();
        sp2.Name='test2';
        sp2.Last_Name__c = 'test12';
        sp2.Driving_License_Number__c='1234567890123456';
        sp2.Address__c='209,ga';
        sp2.Phone_Number__c='9992734426';
        sp2.Aadhar_Number__c='123456789012';
        sp2.Location__c='Hyderabad';
        sp2.Site__c=campus.id;
        sp2.Phone__c=1234567890;
        sp2.Status__c = 'Active';
       
        insert sp2;
        
          Penalty__c pen1 = new Penalty__c();
        pen1.Penalty_Reason__c ='SP Violates traffic rules';
        pen1.Service_Provider_Name__c = sp2.Id;
        pen1.Status__c='Requested';
        // string t=System.Label.urlRedirrecttocontentdocument+ '.lightning.force.com/lightning/r/ContentDocument/'+documents[0].Id+'/view';
      //  sp2.Profile_Picture__c = t;
        pen1.Penalty_Picture__c =documents[0].Id;
        insert pen1;
        
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = sp2.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        
        ApexPages.standardController sc=new ApexPages.standardController(pen1);
        
        PenaltyController db1=new PenaltyController(sc);
        db1.deleteRecord();
        Test.stopTest();
    } 
}