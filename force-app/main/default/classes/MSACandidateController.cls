/*
 ** To Uplode Files in inline Fileuploader for "MSA" in Candidate Object..**
 */ 


global class MSACandidateController {
    public Candidate__c  myCustomObject{set;get;}
    private Attachment myDocument1;
    public  boolean show{set;get;}
    public  boolean drivingLicence{set;get;}
   
    public String driverProofNm{get;set;}
    public Id serviceProviderId{set;get;}
          private ApexPages.StandardController sctrl; 

    public MSACandidateController(ApexPages.StandardController controller){
                  this.sctrl = controller;

        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        if(String.isNotBlank(serviceProviderId)){
            myCustomObject = [SELECT Id,MSA_Picture__c	 FROM Candidate__c WHERE Id =: serviceProviderId  ];
            
            system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObject.MSA_Picture__c	)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObject.MSA_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.MSA_Picture__c];
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
        sc.MSA_Picture__c	 =t;
        update sc;
        system.debug('sc------------'+sc);
    }
    
    
    
    public PageReference deleteRecord() {
        List<ContentDocument > delfieldids = new List<ContentDocument >();
         
        delfieldids =  [SELECT Id FROM ContentDocument WHERE Id =:myCustomObject.MSA_Picture__c];
        if(myCustomObject.MSA_Picture__c !=null )
         {
        delete delfieldids;
        system.debug('SELECT Id FROM ContentDocument WHERE Id =:driverProofNm'+delfieldids);
        Candidate__c deldrvsc = myCustomObject;
        deldrvsc.MSA_Picture__c	 = null;
        update deldrvsc;
        drivingLicence=true;
        
         }
         PageReference cancel = sctrl.cancel();
        return cancel;
    }
}