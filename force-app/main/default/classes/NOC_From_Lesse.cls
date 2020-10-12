global class NOC_From_Lesse {  public Vehicle__c myCustomObject{set;get;}
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
    public String deleteType{get;set;}
    public Id serviceProviderId;
   // public string oldrecid {get;set;}
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
    
    public NOC_From_Lesse(ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        myCustomObject = [SELECT Id,NOC_from_Lesse__c FROM Vehicle__c WHERE Id =: serviceProviderId];
        
        system.debug('myCustomObject'+myCustomObject);
        If(String.isBlank(myCustomObject.NOC_from_Lesse__c) ){
            addressproof=true; 
            
        }else if(String.isNotBlank(myCustomObject.NOC_from_Lesse__c)){
            addressproof=false;
            List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.NOC_from_Lesse__c];
            if(conVLst.size() > 0)
                addressProofNm = conVLst[0].Title;
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
        sc.NOC_from_Lesse__c =string.valueOf(docList[0].ContentDocumentid);
       
        update sc;
    }

    
    
    
    
    public void deleteRecord() {
       List<ContentDocument > delfieldid = new List<ContentDocument >();
        delfieldid = [select id,Title FROM ContentDocument where id =: myCustomObject.NOC_from_Lesse__c];
        if(delfieldid.size()>0){
            delete delfieldid;
            system.debug('qwert'+delfieldid);
             addressproof=true; 
            
             Vehicle__c delsc = myCustomObject;
      //  String attname= myDocument.name.substringbefore('.');
           // system.debug('abc'+attname) ;
        delsc.NOC_from_Lesse__c = null;
        update delsc;
        system.debug('123'+delsc);
        addressproof=true;
          
        }
    } 
    
}