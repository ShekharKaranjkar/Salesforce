@isTest
public class ZipFilesDownloadControllerTest {
    @isTest
    public static void unitTest(){
        Lead ld = new Lead(LastName = 'test',Company ='test',Status='C1: New');
        insert ld;
        
        ContentVersion cv = new ContentVersion();
        cv.Title = 'Test Document';
        cv.PathOnClient = 'TestDocument.pdf';
        cv.VersionData = Blob.valueOf('Test Content');
        cv.IsMajorVersion = true;
        Insert cv;
        
        //Get Content Documents
        Id conDocId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
        
        //Create ContentDocumentLink 
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = ld.Id;
        cdl.ContentDocumentId = conDocId;
        cdl.shareType = 'V';
        Insert cdl;
        /*Test.setCurrentPageReference(new PageReference(Page.ZipFileDownload)); 
System.currentPageReference().getParameters().put('id', 'test');

*/
        Test.setCurrentPageReference(new PageReference('Page.ZipFilesDownload'));
        System.currentPageReference().getParameters().put('id',ld.Id );
        ZipFilesDownloadController zp = new ZipFilesDownloadController();
        ZipFilesDownloadController.recordId = ld.Id;
        ZipFilesDownloadController.getVersionIds(ld.Id+'');
        
    }
}