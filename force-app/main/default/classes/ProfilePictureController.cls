global class ProfilePictureController {
    
    public Service_Provider__c myCustomObject{set;get;}
    private Attachment myDocument1;
    public  boolean show{set;get;}
    public  boolean drivingLicence{set;get;}
   
    public String driverProofNm{get;set;}
   
    public Id serviceProviderId{set;get;}
         private ApexPages.StandardController sctrl;

    public ProfilePictureController(ApexPages.StandardController controller){
        this.sctrl = controller;
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        string error;
        if(String.isNotBlank(serviceProviderId)){
            myCustomObject = [SELECT Id,Profile_Picture__c FROM Service_Provider__c WHERE Id =: serviceProviderId  ];
            
            system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObject.Profile_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObject.Profile_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.Profile_Picture__c];
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
        string t=string.valueOf(cv.ContentDocumentId);
            
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
            sc.Profile_Picture__c =t;
            update sc; 
            
        }
        
        
        
        return error;
    }
    
    
    public PageReference deleteRecord() {
        List<ContentDocument > delfieldids = new List<ContentDocument >();
        if(myCustomObject.Profile_Picture__c !=null )
         {
          system.debug('myCustomObject.Profile_Picture__c'+ myCustomObject.Profile_Picture__c);
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:myCustomObject.Profile_Picture__c];
        
        Service_Provider__c deldrvsc = myCustomObject;
        deldrvsc.Profile_Picture__c = null;
        update deldrvsc;
         }
        PageReference cancel = sctrl.cancel();
        return cancel;
        
        
    }
    
}