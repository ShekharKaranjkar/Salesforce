public with sharing class FileUploadController {
     
    @AuraEnabled
    public static Id SaveFile(Id parentId, String fileName, String base64Data, String contentType, String Notescmt) {
        
        system.debug('Notescmt--------->'+Notescmt);
            base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
		List<ContentDocument> contentDocLst = [SELECT Id,Title FROM ContentDocument WHERE Title =: fileName ];
       
        List<ContentDocumentLink> cdlst = [SELECT Id,ContentDocumentId FROM ContentDocumentLink WHERE ContentDocumentId IN : contentDocLst AND LinkedEntityId =: parentId];
            ContentVersion cv = new ContentVersion();
            cv.Title = fileName;
            cv.PathOnClient = fileName;
            cv.VersionData = EncodingUtil.base64Decode(base64Data);
            cv.IsMajorVersion = false;
            cv.ReasonForChange =Notescmt;
        	if(cdlst.size() > 0 )
        		cv.ContentDocumentId = cdlst[0].ContentDocumentId;
            Insert cv;
            List<ContentVersion> docList = [SELECT Id,ContentDocumentid FROM ContentVersion where id=:cv.id];
            if(cdlst.size() == 0 ){
                
                ContentDocumentLink cdl = New ContentDocumentLink();
                cdl.LinkedEntityId = parentId;
                cdl.ContentDocumentId = docList[0].ContentDocumentid;
                cdl.shareType = 'V';
                Insert cdl;
            }
       
        return null;
    } 
    @AuraEnabled
    public static String downlaod (String recordid){
        
    
     List<ContentDocumentLink> ContentList = new List <ContentDocumentLink>();
         ContentList = [SELECT ContentDocumentId,ContentDocument.Title, ContentDocument.CreatedDate,LinkedEntityId FROM ContentDocumentLink where LinkedEntityId=:recordid];
        if(ContentList.size() >0 ){
            return 'success';
        }else{
            return 'error';
        }
    }
/*@AuraEnabled
    public static list <ContentVersion> fetchfiles(){
        List <ContentVersion> returnConversion = new List < ContentVersion > ();
        
         for(ContentVersion conver: [SELECT Id,ContentDocumentid FROM ContentVersion])
             
         {
             returnConversion.add(conver);
             system.debug('???'+returnConversion);
          }
         return returnConversion;
       
   }*/
    
    
    
}