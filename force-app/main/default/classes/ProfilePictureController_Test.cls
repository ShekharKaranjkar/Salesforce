@isTest
public class ProfilePictureController_Test {
   
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
        
        ApexPages.standardController sc=new ApexPages.standardController(sp1);
         ProfilePictureController.uploadfiles(sp1.Id,contentVersionInsert.Id);
         
        ProfilePictureController db=new ProfilePictureController(sc);
        db.onLoad();
        db.deleteRecord();
        Test.stopTest();
    }
   
}