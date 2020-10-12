global with sharing class ZipFileDownloadController{
 public static String recordId {get; set;}
 
 public ZipFileDownloadController(){
     //recordId = ApexPages.currentPage().getParameters().get('id');
 }

 

 /*Function to fetch the attachments related to the Account*/
 @RemoteAction
 public static List<FileWrapper> getFiles(String parentId){
     List<FileWrapper> fwLst = new List<FileWrapper>();
     //system.debug('recordId ' + recordId);
     //String parentId = ApexPages.currentPage().getParameters().get('id');
     //system.debug(parentId);
     Set<String> documentIds = new Set<String>();
     String zipName  = '';
     for(ContentDocumentLink  cdl : [SELECT Id,ContentDocumentId,LinkedEntity.Name FROM ContentDocumentLink WHERE LinkedEntityId =: parentId]){
         documentIds.add(cdl.ContentDocumentId);
         zipName = cdl.LinkedEntity.Name;
     }
     for(ContentVersion cv : [Select Id,VersionNumber,ContentDocumentid,VersionData,Title,FileType  from ContentVersion where ContentDocumentId IN :documentIds]){
         FileWrapper fw = new FileWrapper();
         fw.zipName = zipName;
         fw.fileName = cv.Title;
         fw.contentType = cv.FileType;
         system.debug(cv.VersionData);
         fw.versionData = EncodingUtil.base64Encode(cv.VersionData);    
         fwLst.add(fw);
     }
        
     //List<ContentVersion>
     if(fwLst.size() > 0)
         return fwLst;
     return null;
 }
 public class FileWrapper{
     public String fileName;
     public String versionData;
     public String contentType;
     public String zipName;
     
 }
}