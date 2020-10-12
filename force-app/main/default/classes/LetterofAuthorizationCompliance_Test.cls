@isTest
public class LetterofAuthorizationCompliance_Test {
    static TestMethod void  uploadfiles(){
        Compliance__c com = new Compliance__c();
        com.Police_Verification__c = true;
        
        insert com;
        
          
           id serviceprovideId = com.Id;
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
        com.Letter_of_Authorization_Picture__c = contentVersionInsert.Id;
        update com;
        Test.startTest();
        LetterofAuthorizationCompliance.uploadfiles(serviceprovideId,contentVersionInsert.Id);
        Test.stopTest(); 
        
        
    }
    static TestMethod void onLoad(){
        
        Compliance__c com1 = new Compliance__c();
        com1.Police_Verification__c = true;
        insert com1;
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
        cdl.LinkedEntityId = com1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        
        ApexPages.standardController sc=new ApexPages.standardController(com1);
        LetterofAuthorizationCompliance db=new LetterofAuthorizationCompliance(sc);
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
        
         Compliance__c com2 = new Compliance__c();
        com2.Police_Verification__c = true;
      //  string t=System.Label.urlRedirrecttocontentdocument+ '.lightning.force.com/lightning/r/ContentDocument/'+documents[0].Id+'/view';
       
        com2.Letter_of_Authorization_Picture__c =documents[0].Id;
     //   com2.Letter_of_Authorization_Id__c = documents[0].Id;
        insert com2;
         ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = com2.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        
        ApexPages.standardController sc=new ApexPages.standardController(com2);
        
        LetterofAuthorizationCompliance db1=new LetterofAuthorizationCompliance(sc);
        db1.deleteRecord();
        Test.stopTest();
    } 
}