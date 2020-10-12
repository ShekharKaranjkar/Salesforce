global class DriverProof {
    
    public Service_Provider__c myCustomObject{set;get;}
    private Attachment myDocument1;
    public  boolean show{set;get;}
    public  boolean drivingLicence{set;get;}
  
    public String driverProofNm{get;set;}
    
    public Id serviceProviderId{set;get;}
      private ApexPages.StandardController sctrl;
    public DriverProof(ApexPages.StandardController controller){
         this.sctrl = controller;
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
         string error;
        if(String.isNotBlank(serviceProviderId)){
            myCustomObject = [SELECT Id,Driving_Proof_Picture__c FROM Service_Provider__c WHERE Id =: serviceProviderId  ];
 
            system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObject.Driving_Proof_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObject.Driving_Proof_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.Driving_Proof_Picture__c.split('/').get(6)];
                if(conVLst.size() > 0 )
                    driverProofNm = conVLst[0].Title;
               
               
            } 
        }  
        
    }
    
    @RemoteACtion
    global static String uploadfiles(String serviceprovideId, String cvid){
        String error;
        string driverProoNme;
        ContentVersion cv = [Select ID,ContentDocumentId from ContentVersion where id=:cvid];
        string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
        String[] arrTest = temp.split('\\.');
        String st='/';
        string t=System.Label.urlRedirrecttocontentdocument+ '.lightning.force.com/lightning/r/ContentDocument/'+cv.ContentDocumentId+'/view';
        List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:cvid];
                if(conVLst.size() > 0 )
                    driverProoNme = conVLst[0].Title;
        system.debug('driverProoNme'+driverProoNme);
         if(driverProoNme!=null && driverProoNme.contains('pdf') ){
                    system.debug('pdf is coming ');
                    error = 'err'; 
                } 
                else  if(driverProoNme!=null && driverProoNme.contains('csv')){
                    system.debug('csv is coming ');
                    error = 'err'; 
                } else
                {
                   Service_Provider__c sc = new Service_Provider__c();
        sc.id = serviceprovideId;
        sc.Driving_Proof_Picture__c =t;
        update sc; 
                    
                }
        
        
        
        return error;
    }
    
    
    public PageReference deleteRecord() {
       List<ContentDocument > delfieldids = new List<ContentDocument >();
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:myCustomObject.Driving_Proof_Picture__c.split('/').get(6)];
        Service_Provider__c deldrvsc = myCustomObject;
        deldrvsc.Driving_Proof_Picture__c = null;
        update deldrvsc;
        PageReference cancel = sctrl.cancel();
        return cancel;
        
    }
}