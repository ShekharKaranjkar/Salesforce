/*
 ** To Uplode Files in inline Fileuploader for "Engagement Activities Picture"in Engagement Activity Object..**
 */ 

global class EngagementActivitiesImage {

   public Engagement_Activities__c myCustomObject{set;get;}
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
    public EngagementActivitiesImage(ApexPages.StandardController controller){
        this.sctrl = controller;
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        if(String.isNotBlank(serviceProviderId)){
            myCustomObject = [SELECT Id,Engagement_Activity_Picture__c FROM Engagement_Activities__c WHERE Id =: serviceProviderId  ];
            
            system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObject.Engagement_Activity_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObject.Engagement_Activity_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.Engagement_Activity_Picture__c];
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
        Engagement_Activities__c sc = new Engagement_Activities__c();
        sc.id = serviceprovideId;
        sc.Engagement_Activity_Picture__c =t;
        update sc;
        system.debug('sc------------'+sc);
    }
    
    
    
    public PageReference deleteRecord() {
        List<ContentDocument > delfieldids = new List<ContentDocument >();
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:myCustomObject.Engagement_Activity_Picture__c];
        Engagement_Activities__c deldrvsc = myCustomObject;
        deldrvsc.Engagement_Activity_Picture__c = null;
        update deldrvsc;
        drivingLicence=true;
         PageReference cancel = sctrl.cancel();
        return cancel;
    }
}