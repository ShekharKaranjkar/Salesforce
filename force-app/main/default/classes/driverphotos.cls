public class driverphotos
{ 
    public Vehicle_Assignment__c myCustomObject{set;get;}
    private Attachment myDocument;
    public Attachment myDoc
    {
        get
        {
            if(myDocument==null)
            {
                myDocument = new Attachment();
            }
            return myDocument;
        }
        set;
    }
     public driverphotos(ApexPages.StandardController controller){
        
        
    }
    
        public void upload(){
        //show = true;
        ContentVersion cv = new ContentVersion();
        cv.Title = myDoc.Name;
        cv.PathOnClient = myDoc.Name;
        cv.VersionData = myDoc.Body;
        cv.IsMajorVersion = false;
        insert cv;
        List<ContentVersion> docList = [SELECT Id,ContentDocumentid FROM ContentVersion where id=:cv.id];
        if(docList!=Null ){
            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = myCustomObject.Id;
            cdl.ContentDocumentId = docList[0].ContentDocumentid;
            cdl.shareType = 'V';
            Insert cdl;
        }
        myDoc =new Attachment();
        
       // Vehicle_Assignment__c sc = myCustomObject;
       // String attname= myDocument.name.substringbefore('.');
        
       // sc.Driver_License_Proof__c = string.valueOf(docList[0].ContentDocumentid);
       // update sc;
        //drivingLicence=true;
      //  system.debug('qqq'+sc);
        
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'File Uploaded successfully'));
        //onLoad();
       // show = false;
        
        }

}