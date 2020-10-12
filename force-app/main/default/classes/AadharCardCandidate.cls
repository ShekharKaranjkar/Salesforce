/*
 ** To Uplode Files in inline Fileuploader for "Aadhar Card"in Candidate Object..**
 */ 


global class AadharCardCandidate {
    public Candidate__c  myCustomObject{set;get;}
//   public Id docId{set;get;}
    private Attachment myDocument1;
    public  boolean show{set;get;}
   // public  boolean addressproof{set;get;}
    public  boolean drivingLicence{set;get;}
  //  public attachment getid{get;set;}
  //  public blob file { get; set; }
  //  public String addressProofNm{get;set;}
    public String driverProofNm{get;set;}
  //  public String uploadType{get;set;}
    public Id serviceProviderId{set;get;}
  //  public string filename{set;get;}
   private ApexPages.StandardController sctrl; 
    public AadharCardCandidate(ApexPages.StandardController controller){
           this.sctrl = controller;
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        if(String.isNotBlank(serviceProviderId)){
            myCustomObject = [SELECT Id,Aadhar_Card_Picture__c FROM Candidate__c WHERE Id =: serviceProviderId  ];
            
            system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObject.Aadhar_Card_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObject.Aadhar_Card_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.Aadhar_Card_Picture__c];
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
        Candidate__c sc = new Candidate__c();
        sc.id = serviceprovideId;
        sc.Aadhar_Card_Picture__c =t;
        update sc;
        system.debug('sc------------'+sc);
    }
    
    
    
    public PageReference deleteRecord() {
        List<ContentDocument > delfieldids = new List<ContentDocument >();
        if(myCustomObject.Aadhar_Card_Picture__c !=null )
         {
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:myCustomObject.Aadhar_Card_Picture__c];
        Candidate__c deldrvsc = myCustomObject;
        deldrvsc.Aadhar_Card_Picture__c = null;
        update deldrvsc;
        drivingLicence=true;
        
         }
        PageReference cancel = sctrl.cancel();
        return cancel;
    }
}