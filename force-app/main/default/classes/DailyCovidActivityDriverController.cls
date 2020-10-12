public class DailyCovidActivityDriverController {
    
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
    public static Boolean createRecord(String certificateApexString,String signedApexString,String app,Boolean duty){
        system.debug('certificateApexString'+certificateApexString);
            system.debug('signedApexString'+signedApexString);
            system.debug('app'+app);
            system.debug('duty'+duty);
        Daily_covid_activities_Driver__c c=new Daily_covid_activities_Driver__c();
       // c.Aarogya_Setu_Screenshot__c= getFieldUrlLink(certificateApexString);
       // c.Upload_signed_declaration__c=getFieldUrlLink(signedApexString);
       // c.Body_Temperature__c=app;
       // c.Covid_Symptoms__c=duty;
        c.Status__c = 'Submitted';
        insert c;
        
        return true;
    }
    
    public Static string getFieldUrlLink(String content){
       
        string[] contentarr=content.split('----');
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
        
        string t=arrTest[0]+ '.lightning.force.com/lightning/r/ContentDocument/'+cv.ContentDocumentId+'/view';
        
        system.debug('test'+t);
        return t;
    }
    
}