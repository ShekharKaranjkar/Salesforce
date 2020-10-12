public class CovidDeclarationController {
    
    @AuraEnabled
    public static boolean SaveFile(Id parentId, String fileName, String base64Data, String contentType) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        ContentVersion contentVersion = new ContentVersion(
            versionData = EncodingUtil.base64Decode(base64Data),
            title = fileName,
            pathOnClient =  '/' + fileName
        );
      //  insert contentVersion; 
        return true;
        /* base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
Attachment attach = new Attachment();
attach.parentId = 'a1k0w0000005iWpAAI';
attach.Body = EncodingUtil.base64Decode(base64Data);
attach.Name = fileName;
attach.ContentType = contentType;
Insert attach;
return attach.Id;
*/
    }
    @AuraEnabled
    public static Boolean createRecord(String certificateApexString,String signedApexString,Boolean app,Boolean duty){
        system.debug('certificateApexString'+certificateApexString);
            system.debug('signedApexString'+signedApexString);
            system.debug('app'+app);
            system.debug('duty'+duty);
        Covid_Declaration__c c=new Covid_Declaration__c();
        c.Upload_doctors_certificate__c= getFieldUrlLink(certificateApexString);
        c.Upload_signed_declaration__c=getFieldUrlLink(signedApexString);
       // c.AarogyaApp__c=app;
      //  c.JoinedDuty__c=duty;
        insert c;
        
        return true;
    }
    
    public Static string getFieldUrlLink(String content){
       string t='';
        string[] contentarr=content.split('----');
        
        if( contentarr.size()==3){
          string base64Data=contentarr[2];
        string fileName=contentarr[1];
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        ContentVersion contentVersion = new ContentVersion(
            versionData = EncodingUtil.base64Decode(base64Data),
            title = fileName,
            pathOnClient =  '/' + fileName
        );
        insert contentVersion; 
        system.debug('contentVersion'+contentVersion);
        ContentVersion cv=     [Select id,ContentDocumentId From ContentVersion Where Id=:contentVersion.Id];
        
        string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
        String[] arrTest = temp.split('\\.');
        system.debug(arrTest[0]);
         t=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+cv.ContentDocumentId+'/view';
        
        system.debug('test'+t);
      
        }
   return t; 
    }
    
}