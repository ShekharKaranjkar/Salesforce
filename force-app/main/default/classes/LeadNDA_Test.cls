@isTest
public class LeadNDA_Test {

    static TestMethod void  uploadfiles(){
        Lead leadObj = new Lead(Lastname='TEST_LEAD',Company='ABCDEFG',LeadSource = 'Events',Status='C1: New');
        insert leadObj;
        
        id LeadId = leadObj.Id;
        String filetName='Test Document';
        string base64Data ='Unit Test Attachment Body'; 
        String Notescmt = 'Notescmt';

        Test.startTest();
        LeadFfileupload.uploadfiles(LeadId, base64Data, filetName);
        Test.stopTest(); 
        
     }
    static TestMethod void onLoad(){
        Lead leadobj1=new Lead();
        	leadobj1.LastName='TestLeadobj';
        	leadobj1.Company='Dazeworks';
        	leadobj1.LeadSource = 'Cold Call';
        	leadobj1.Status ='C1: New';
        	insert leadobj1;
        
        
        // Create Content Version Record
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
        cdl.LinkedEntityId = leadobj1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        ApexPages.standardController sc=new ApexPages.standardController(leadobj1);
        LeadFfileupload leadfile=new LeadFfileupload(sc);
        leadfile.onLoad();
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
        Lead leadobj2=new Lead();
        	leadobj2.LastName='TestLeadobj';
        	leadobj2.Company='Dazeworks';
        	leadobj2.LeadSource = 'Cold Call';
        	leadobj2.Status ='C1: New';
        	leadobj2.NDA_Proof__c = documents[0].Id;
        	insert leadobj2;
        
        //Create ContentDocumentLink  Record
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = leadobj2.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();

        ApexPages.standardController sc=new ApexPages.standardController(leadobj2);
        LeadFfileupload leadfile1=new LeadFfileupload(sc);
        leadfile1.deleteRecord();
        Test.stopTest();
        
    }
    
}