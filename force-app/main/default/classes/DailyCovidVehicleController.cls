public class DailyCovidVehicleController {
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
    public static Boolean createRecord1(String certificateApexString,Boolean app,Boolean duty,string vehicleid){
        system.debug('certificateApexString'+certificateApexString);
        // system.debug('signedApexString'+signedApexString);
        system.debug('app'+app);
        system.debug('duty'+duty);
        Daily_Covid_activity_vehicle__c c1=new Daily_Covid_activity_vehicle__c();
        
        c1.Upload_Image__c = getFieldUrlLink(certificateApexString);
       
        c1.Vehicle__c = vehicleid;
        insert c1;
        
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