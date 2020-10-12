/*
 ** To Uplode Files in inline Fileuploader for "Letter Of Authorization"in Compliance Object..**
 */ 


global class LeaveEmergency  {
    
   public Leave__c  myCustomObject{set;get;}
    public Id docId{set;get;}
    private Attachment myDocument1;
    public  boolean show{set;get;}
    public  boolean addressproof{set;get;}
    public  boolean drivingLicence{set;get;}
    public attachment getid{get;set;}
    public blob file { get; set; }
    public String addressProofNm{get;set;}
    public String driverProofNm{get;set;}
    public String uploadType{get;set;}
    public Id serviceProviderId{set;get;}
    public string filename{set;get;}
private ApexPages.StandardController sctrl;   
    public LeaveEmergency(ApexPages.StandardController controller){
           this.sctrl = controller;
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        if(String.isNotBlank(serviceProviderId)){
            myCustomObject = [SELECT Id,Emergency_Document__c FROM Leave__c WHERE Id =: serviceProviderId  ];
            
            system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObject.Emergency_Document__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObject.Emergency_Document__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.Emergency_Document__c];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
            } 
        }    
    }
    
    @RemoteACtion
    global static void uploadfiles(String serviceprovideId, String cvid){
        
        ContentVersion cv = [Select ID,ContentDocumentId from ContentVersion where id=:cvid];
        string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
        string t=string.valueOf(cv.ContentDocumentId);
        Leave__c sc = new Leave__c();
        sc.id = serviceprovideId;
        sc.Emergency_Document__c =t;
        update sc;
        system.debug('sc------------'+sc);
    }
    
    
    
    public PageReference deleteRecord() {
        List<ContentDocument > delfieldids = new List<ContentDocument >();
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:myCustomObject.Emergency_Document__c];
        Leave__c deldrvsc = myCustomObject;
        deldrvsc.Emergency_Document__c = null;
        update deldrvsc;
        drivingLicence=true;
          PageReference cancel = sctrl.cancel();
        return cancel;
    } 
}