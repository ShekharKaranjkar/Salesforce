global class Post_Estimation_Invoice {
public Quotation__c myCustomObject{set;get;}
    private Attachment myDocument;
    private Attachment myDocument1;
    public  boolean show{set;get;}
    public  boolean addressproof{set;get;}
    public  boolean drivingLicence{set;get;}
    public attachment getid{get;set;}
    public blob file { get; set; }
    public String addressProofNm{get;set;}
    public String driverProofNm{get;set;}
    public String uploadType{get;set;}
    public Id serviceProviderId;
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
    public Post_Estimation_Invoice(ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        myCustomObject = [SELECT Id,Post_Estimation_Invoice_Text__c FROM Quotation__c WHERE Id =: serviceProviderId];
        
        system.debug('myCustomObject'+myCustomObject);
        
        
        if(String.isBlank(myCustomObject.Post_Estimation_Invoice_Text__c)){
            drivingLicence=true;
        }else if(String.isNotBlank(myCustomObject.Post_Estimation_Invoice_Text__c)){
            drivingLicence=false;
            List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.Post_Estimation_Invoice_Text__c];
            if(conVLst.size() > 0)
                driverProofNm = conVLst[0].Title;
        } 
        
    }
    
  
    
       @RemoteACtion
   global static void uploadfiles(String serviceprovideId, String base64Data, String filetName){
       // show = true;
         base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        ContentVersion cv = new ContentVersion();
        cv.Title = filetName;
        cv.PathOnClient = filetName;
        cv.VersionData = EncodingUtil.base64Decode(base64Data);
        cv.IsMajorVersion = false;
        insert cv;
        system.debug('cv'+cv);
        List<ContentVersion> docList = [SELECT Id,ContentDocumentid FROM ContentVersion where id=:cv.id];
        if(docList!=Null ){
            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = serviceprovideId;
            cdl.ContentDocumentId = docList[0].ContentDocumentid;
            cdl.shareType = 'V';
            Insert cdl;
            system.debug('cdl'+cdl);
        }
        Quotation__c sc = new Quotation__c();
		sc.id = serviceprovideId;
      //  String filetName= myDocument.name.substringbefore('.');
        sc.Post_Estimation_Invoice_Text__c =string.valueOf(docList[0].ContentDocumentid);
       
        update sc;
    }

    
    
    
    
    public void deletedriverRecord() {
        List<ContentDocument > delfieldids = new List<ContentDocument >();
        delfieldids = [select id,Title FROM ContentDocument where id =: myCustomObject.Post_Estimation_Invoice_Text__c];
        if(delfieldids.size()>0){
            delete delfieldids;
            system.debug('qwert'+delfieldids);
            drivingLicence=true; 
            Quotation__c deldrvsc = myCustomObject;
            //  String attname= myDocument.name.substringbefore('.');
            // system.debug('abc'+attname) ;
            deldrvsc.Post_Estimation_Invoice_Text__c = null;
            update deldrvsc;
            system.debug('123'+deldrvsc);
            drivingLicence=true;
        }
    }

}