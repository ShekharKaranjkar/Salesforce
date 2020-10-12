@isTest
public class FileUploadControllerTestclass {
    static TestMethod void SaveFile(){
        
        Lead lea = new Lead(Lastname='TEST_LEAD',Company='ABCDEFG',LeadSource = 'Events',Status='C1: New');
        
        insert lea;
        id parentId = lea.Id;
        String fileName='Test Document';
        string base64Data ='Unit Test Attachment Body'; 
        String Notescmt = 'Notescmt';
        
       ContentVersion cv = new ContentVersion();
        cv.Title = fileName;
        cv.PathOnClient = fileName;
        cv.VersionData = Blob.valueOf(base64Data);
        cv.ReasonForChange = Notescmt;
        cv.IsMajorVersion = false;
        Insert cv;
        
        List<ContentDocument> contentDocLst = [SELECT Id,Title, LatestPublishedVersionId FROM ContentDocument];
        system.debug('contentDocLst'+contentDocLst);
        
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = lea.Id;
        cdl.ContentDocumentId = contentDocLst[0].id;
        cdl.shareType = 'V';
        Insert cdl;
        system.debug('cdl'+cdl); 
        
        Test.startTest();
        
        FileUploadController.SaveFile(parentId, fileName, base64Data,null, Notescmt);
        FileUploadController.downlaod(parentId);
        Test.stopTest(); 
         }
    
    
}