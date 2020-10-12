/*
 ** To Uplode Files in inline Fileuploader for "PAN Card"in Candidate Object..**
 */ 



global class PanCardCandidate {
    
    public Candidate__c  myCustomObject{set;get;}
    private Attachment myDocument1;
    public  boolean show{set;get;}
    public  boolean drivingLicence{set;get;}
    public String driverProofNm{get;set;}
    public Id serviceProviderId{set;get;}
       private ApexPages.StandardController sctrl; 
    public PanCardCandidate(ApexPages.StandardController controller){
          this.sctrl = controller;
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        if(String.isNotBlank(serviceProviderId)){
            myCustomObject = [SELECT Id,PAN_Card_Picture__c FROM Candidate__c WHERE Id =: serviceProviderId  ];
            
            system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObject.PAN_Card_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObject.PAN_Card_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.PAN_Card_Picture__c];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
            } 
        }    
    }
    
    @RemoteACtion
    global static void uploadfiles(String serviceprovideId, String cvid){
        
        ContentVersion cv = [Select ID,ContentDocumentId from ContentVersion where id=:cvid];
        string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
        String[] arrTest = temp.split('\\.');
        String st='/';
        string t=string.valueOf(cv.ContentDocumentId);
        Candidate__c sc = new Candidate__c();
        sc.id = serviceprovideId;
        sc.PAN_Card_Picture__c =t;
        update sc;
        system.debug('sc------------'+sc);
    }
    
    
    
    public PageReference deleteRecord() {
        List<ContentDocument > delfieldids = new List<ContentDocument >();
         if(myCustomObject.PAN_Card_Picture__c !=null )
         {
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:myCustomObject.PAN_Card_Picture__c];
        Candidate__c deldrvsc = myCustomObject;
        deldrvsc.PAN_Card_Picture__c = null;
        update deldrvsc;
        drivingLicence=true;
         }
         PageReference cancel = sctrl.cancel();
        return cancel;
    }
}