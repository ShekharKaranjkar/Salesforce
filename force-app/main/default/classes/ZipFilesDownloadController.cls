global with sharing class ZipFilesDownloadController{
 public static String recordId {get; set;}
 public String recordName {get; set;}
 public ZipFilesDownloadController(){
     String recordId1 = ApexPages.currentPage().getParameters().get('id');
     for(ContentDocumentLink  cdl : [SELECT Id,ContentDocumentId,LinkedEntity.Name FROM ContentDocumentLink WHERE LinkedEntityId =: recordId1 limit 1]){
         recordName = cdl.LinkedEntity.Name;
     }
 }
 

@RemoteAction
public static Set<String> getVersionIds(String parentId){
     //system.debug('recordId ' + recordId);
     //String parentId = ApexPages.currentPage().getParameters().get('id');
     //system.debug(parentId);
     Set<String> documentIds = new Set<String>();
     Set<String> versionIds = new Set<String>();
     String zipName  = '';
     for(ContentDocumentLink  cdl : [SELECT Id,ContentDocumentId,LinkedEntity.Name FROM ContentDocumentLink WHERE LinkedEntityId =: parentId]){
         documentIds.add(cdl.ContentDocumentId);
         //recordName = cdl.LinkedEntity.Name;
     }
     for(ContentVersion cv : [Select Id,VersionNumber,ContentDocumentid,VersionData,Title,FileType  from ContentVersion where ContentDocumentId IN :documentIds order by createdDate desc]){
         versionIds.add(cv.Id);
     }
     //versionIds.add(recordName);
     //List<ContentVersion>
     if(versionIds.size() > 0)
         return versionIds;
     return versionIds;
 } 
 
}