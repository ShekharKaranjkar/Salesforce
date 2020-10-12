/*
 ** To Uplode Files in inline Fileuploader for "Penalty Image"in Penalty Object..**
 */ 

global class PenaltyController {
  public Penalty__c myCustomObject{set;get;}
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

    public PenaltyController(ApexPages.StandardController controller){
                          this.sctrl = controller;

        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        if(String.isNotBlank(serviceProviderId)){
            myCustomObject = [SELECT Id,PenaltyId__c,Penalty_Picture__c FROM Penalty__c WHERE Id =: serviceProviderId  ];
            
            system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObject.Penalty_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObject.Penalty_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.Penalty_Picture__c];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
            } 
        }    
    }
    
    @RemoteACtion
    global static void uploadfiles(String serviceprovideId, String cvid){
        system.debug('cvid'+cvid);
        
        ContentVersion cv = [Select ID,ContentDocumentId from ContentVersion where id=:cvid];
        string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
        string t=string.valueOf(cv.ContentDocumentId);
        Penalty__c sc = new Penalty__c();
        sc.id = serviceprovideId;
        sc.Penalty_Picture__c =t;
        update sc;
        system.debug('sc------------'+sc);
    }
    
    
    
    public PageReference deleteRecord() {
        List<ContentDocument > delfieldids = new List<ContentDocument >();
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:myCustomObject.Penalty_Picture__c];
        Penalty__c deldrvsc = myCustomObject;
        deldrvsc.Penalty_Picture__c = null;
        update deldrvsc;
        drivingLicence=true;
          PageReference cancel = sctrl.cancel();
        return cancel;
          
    }
}