/*
 ** To Uplode Files in inline Fileuploader for "CRA" in Candidate Object..**
 */ 

global class Address_Proof  {
    public Service_Provider__c  myCustomObject{set;get;}
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
   
    public Address_Proof (ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        if(String.isNotBlank(serviceProviderId)){
            myCustomObject = [SELECT Id,Address_Proof__c,Driver_License_Proof__c  FROM Service_Provider__c WHERE Id =: serviceProviderId  ];
            
            system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObject.Address_Proof__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObject.Address_Proof__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObject.Address_Proof__c.split('/').get(6)];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
            } 
        }    
    }
    
    @RemoteACtion
    global static void uploadfiles(String serviceprovideId, String cvid){
        
        ContentVersion docList = [Select ID,ContentDocumentId from ContentVersion where id=:cvid];

        string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
        String[] arrTest = temp.split('\\.');
        String st='/';
        string t=System.Label.urlRedirrecttocontentdocument+ '.lightning.force.com/lightning/r/ContentDocument/'+docList.ContentDocumentId+'/view';

        Service_Provider__c sc = new Service_Provider__c();
        sc.id = serviceprovideId;
        sc.Address_Proof__c =t;
        update sc;    }
    
    
    
    public void deleteRecord() {
        system.debug('insiededelete');
        List<ContentDocument > delfieldids = new List<ContentDocument>();
        system.debug('addressproof'+myCustomObject.Address_Proof__c);
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:myCustomObject.Address_Proof__c.split('/').get(6)];
        Service_Provider__c deldrvsc = myCustomObject;
        deldrvsc.Address_Proof__c = null;
        update deldrvsc;
        drivingLicence=false;
    }
}