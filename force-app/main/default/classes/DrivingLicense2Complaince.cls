/*
 ** To Uplode Files in inline Fileuploader for "Driving License Back Page"in Compliance Object..**
 */ 


global class DrivingLicense2Complaince {
    
    public Compliance__c myCustomObject{set;get;}
      public Candidate__c myCustomObjectVal{set;get;}
    public Compliance__c compRec{get;set;}
    
    private Attachment myDocument1;
    public  boolean show{set;get;}
  
    public  boolean drivingLicence{set;get;}
   
    public String driverProofNm{get;set;}
    
    public Id serviceProviderId{set;get;}
    
   private ApexPages.StandardController sctrl;
    public DrivingLicense2Complaince(ApexPages.StandardController controller){
         this.sctrl = controller;
        show = false;
        serviceProviderId = controller.getId();
        myCustomObjectVal = new Candidate__c();
        onLoad();
        
        
    }
    public void onLoad(){
        try{
            
            if(String.isNotBlank(serviceProviderId)){
           // myCustomObject = [SELECT Id,Driving_Licence_Back_Page_Picture__c FROM Compliance__c WHERE Id =: serviceProviderId  ];
            
           // system.debug('myCustomObject'+myCustomObject);
              compRec = [SELECT id,name,Service_Provider_Name__c, Aadhar_Card__c,Lithium_ID__r.Id from Compliance__c where id=:serviceProviderId];
            myCustomObjectVal = [SELECT Id, Aadhar_Card_Id__c,Driving_Licence_Back_Page_Picture__c FROM Candidate__c WHERE Service_Provider__c =:compRec.Lithium_ID__r.Id];
            
            
            if(String.isBlank(myCustomObjectVal.Driving_Licence_Back_Page_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObjectVal.Driving_Licence_Back_Page_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObjectVal.Driving_Licence_Back_Page_Picture__c];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
            } 
        } 
        }catch(exception ex){
            system.debug(ex.getMessage());
        }

           
    }
    
    @RemoteACtion
    global static void uploadfiles(String compId, String cvid){
         if(String.isNotBlank(compId)){
        ContentVersion cv = [Select ID,ContentDocumentId from ContentVersion where id=:cvid];
        string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
        String[] arrTest = temp.split('\\.');
        String st='/';
        string t=string.valueOf(cv.ContentDocumentId);
      
          Compliance__c compRec = [SELECT id,name,Service_Provider_Name__c,Lithium_ID__r.Id from Compliance__c where id=:compId];
          Candidate__c cRec = [SELECT Id,Driving_Licence_Back_Page_Picture__c FROM Candidate__c WHERE Service_Provider__c =:compRec.Lithium_ID__r.Id];
system.debug('cRec'+cRec);
        Candidate__c cand = new Candidate__c();
        cand.Id = cRec.Id;
       // cand.Service_Provider__c = serviceprovideId;
        cand.Driving_Licence_Back_Page_Picture__c =t;
        update cand;
             
               ContentDocumentLink conLink = [SELECT id,ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where ContentDocumentId =:cand.Driving_Licence_Back_Page_Picture__c and  LinkedEntityId =:compRec.Id];
system.debug('conLink'+conLink);
                 
                  ContentDocumentLink cdl = New ContentDocumentLink();
                cdl.LinkedEntityId = cRec.Id;
                cdl.ContentDocumentId = conLink.ContentDocumentId;
                cdl.shareType = 'V';
                insert cdl;
             system.debug('cdl'+cdl);
             
             ContentDocumentLink cdl1 = New ContentDocumentLink();
                cdl1.LinkedEntityId = compRec.Lithium_ID__r.Id;
                cdl1.ContentDocumentId = conLink.ContentDocumentId;
                cdl1.shareType = 'V';
                insert cdl1;
             system.debug('cdl'+cdl1);
    }
    }
    
    
    
    public PageReference deleteRecord() {
        
        List<ContentDocument > delfieldids = new List<ContentDocument >();
        if(String.isNotBlank(myCustomObjectVal.Driving_Licence_Back_Page_Picture__c)){
            
       
        system.debug('myCustomObject-------'+myCustomObjectVal.Driving_Licence_Back_Page_Picture__c);
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:myCustomObjectVal.Driving_Licence_Back_Page_Picture__c];
        Candidate__c deldrvsc = myCustomObjectVal;
        deldrvsc.Driving_Licence_Back_Page_Picture__c = null;
        update deldrvsc;
        drivingLicence=true;
             }
  PageReference cancel = sctrl.cancel();
        return cancel;
    } 
}