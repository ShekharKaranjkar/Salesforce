@isTest
public class EngagementActivitiesImage_Test {
    static TestMethod void  uploadfiles(){
        
         account ac=new account();
        ac.Name='rag';
        ac.Lithium_Billing_Entity__c='Pune';
        ac.Lithium_Bank_Account__c='State Bank';
        insert ac;
        
        Contact con = new Contact();
        con.LastName='tetse';
        con.AccountId = ac.Id;
        
        insert con;
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
      Engagement_Activities__c ea = new Engagement_Activities__c();
        ea.Activity_Name__c='test';
        ea.Description__c='est';
        ea.Site__c = campus.Id;
        
        insert ea;
        
         id serviceprovideId = ea.Id;
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
        ea.Engagement_Activity_Picture__c = contentVersionInsert.Id;
        update ea;
        Test.startTest();
        EngagementActivitiesImage.uploadfiles(serviceprovideId,contentVersionInsert.Id);
        Test.stopTest(); 
        
    }
        
    
    static TestMethod void onLoad(){
        
         account ac=new account();
        ac.Name='rag';
        ac.Lithium_Billing_Entity__c='Pune';
        ac.Lithium_Bank_Account__c='State Bank';
        insert ac;
        
        Contact con = new Contact();
        con.LastName='tetse';
        con.AccountId = ac.Id;
        
        insert con;
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
        
       Engagement_Activities__c ea1 = new Engagement_Activities__c();
        ea1.Activity_Name__c='test';
        ea1.Description__c='est';
        ea1.Site__c =campus.Id;
        
        insert ea1;
        
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
        cdl.LinkedEntityId = ea1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        
        ApexPages.standardController sc=new ApexPages.standardController(ea1);
        EngagementActivitiesImage db=new EngagementActivitiesImage(sc);
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
        
        Contact con = new Contact();
        con.LastName='tetse';
        con.AccountId = ac.Id;
        
        insert con;
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
         Engagement_Activities__c ea2 = new Engagement_Activities__c();
        ea2.Activity_Name__c='test';
        ea2.Description__c='est';
    //    string t=System.Label.urlRedirrecttocontentdocument+ '.lightning.force.com/lightning/r/ContentDocument/'+documents[0].Id+'/view';
  
         ea2.Engagement_Activity_Picture__c = documents[0].Id;
        ea2.Site__c = campus.Id;
        
        insert ea2;

                 
         ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = ea2.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();

        ApexPages.standardController sc=new ApexPages.standardController(ea2);
      
          EngagementActivitiesImage db1=new EngagementActivitiesImage(sc);
        db1.deleteRecord();
        Test.stopTest();
    } 
}