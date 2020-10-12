@isTest
public class Insurance_License_Test {
    static TestMethod void  uploadfiles(){
        Insurance_Claim__c inscl = new Insurance_Claim__c();
        inscl.Name ='test123';
        inscl.Survey_Date__c= system.today().addDays(1);
        insert inscl;
         id serviceprovideId = inscl.Id;
        String filetName='Test Document';
        string base64Data ='Unit Test Attachment Body'; 
        //   String Notescmt = 'Notescmt';
        
        Test.startTest();
        Insurance_License.uploadfiles(serviceprovideId, base64Data, filetName);
        Test.stopTest(); 
    }
    static TestMethod void onLoad(){
         Insurance_Claim__c inscl1 = new Insurance_Claim__c();
        inscl1.Name ='test123';
        inscl1.Survey_Date__c= system.today().addDays(1);
        insert inscl1;
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
        cdl.LinkedEntityId = inscl1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        ApexPages.standardController sc=new ApexPages.standardController(inscl1);
        Insurance_License insu=new Insurance_License(sc);
        insu.onLoad();
       
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

         Insurance_Claim__c insc2 = new Insurance_Claim__c();
        insc2.Name ='test123';
        insc2.Survey_Date__c= system.today().addDays(1);
        insc2.License_Ip_proof__c = documents[0].id;
        insert insc2;
         ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = insc2.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();

        ApexPages.standardController sc=new ApexPages.standardController(insc2);
      
          Insurance_License in1=new Insurance_License(sc);
        in1.deleteRecord();
        Test.stopTest();
     
    }
}