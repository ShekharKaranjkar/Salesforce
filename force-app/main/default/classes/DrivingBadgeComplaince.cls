/*
 ** To Uplode Files in inline Fileuploader for "Driving Badges"in Compliance Object..**
 */ 

global class DrivingBadgeComplaince {
    public Compliance__c myCustomObject{set;get;}
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
   
    public DrivingBadgeComplaince(ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        if(String.isNotBlank(serviceProviderId)){
            myCustomObject = [SELECT Id,Driving_Badge_Picture__c FROM Compliance__c WHERE Id =: serviceProviderId  ];
            
            system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObject.Driving_Badge_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObject.Driving_Badge_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.Driving_Badge_Picture__c.split('/').get(6)];
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
        string t=System.Label.urlRedirrecttocontentdocument+ '.lightning.force.com/lightning/r/ContentDocument/'+cv.ContentDocumentId+'/view';

        Compliance__c sc = new Compliance__c();
        sc.id = serviceprovideId;
        sc.Driving_Badge_Picture__c =t;
        update sc;
        system.debug('sc------------'+sc);
    }
    
    
    
    public void deleteRecord() {
        List<ContentDocument > delfieldids = new List<ContentDocument >();
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:driverProofNm];
        Compliance__c deldrvsc = myCustomObject;
        deldrvsc.Driving_Badge_Picture__c = null;
        update deldrvsc;
        drivingLicence=true;
    }
}