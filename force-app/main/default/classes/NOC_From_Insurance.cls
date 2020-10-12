global class NOC_From_Insurance {
 public Vehicle__c myCustomObject{set;get;}
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
    public NOC_from_Insurance(ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        myCustomObject = [SELECT Id,NOC_from_Insurance_Text__c FROM Vehicle__c WHERE Id =: serviceProviderId];
        
        system.debug('myCustomObject'+myCustomObject);
        
        
        if(String.isBlank(myCustomObject.NOC_from_Insurance_Text__c)){
            drivingLicence=true;
        }else if(String.isNotBlank(myCustomObject.NOC_from_Insurance_Text__c)){
            drivingLicence=false;
            List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.NOC_from_Insurance_Text__c];
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
        Vehicle__c sc = new Vehicle__c();
		sc.id = serviceprovideId;
      //  String filetName= myDocument.name.substringbefore('.');
        sc.NOC_from_Insurance_Text__c =string.valueOf(docList[0].ContentDocumentid);
       
        update sc;
    }

    
    
    
    
    public void deleteRecord() {
        List<ContentDocument > delfieldids = new List<ContentDocument >();
        delfieldids = [select id,Title FROM ContentDocument where id =: myCustomObject.NOC_from_Insurance_Text__c];
        if(delfieldids.size()>0){
            delete delfieldids;
            system.debug('qwert'+delfieldids);
            drivingLicence=true; 
            Vehicle__c deldrvsc = myCustomObject;
            //  String attname= myDocument.name.substringbefore('.');
            // system.debug('abc'+attname) ;
            deldrvsc.NOC_from_Insurance_Text__c = null;
            update deldrvsc;
            system.debug('123'+deldrvsc);
            drivingLicence=true;
        }
    }
}