/*
 ** To Uplode Files in inline Fileuploader for "Address Proof"in Service Provider Object..**
 */ 

global class AddressproofSP {
   public Compliance__c myCustomObject{set;get;}
    public Candidate__c myCustomObjectVal{set;get;}
   // Public list<ContentDocument> cond{set;get;}
   // public Compliance__c compRec{get;set;}
 //  public Id docId{set;get;}
    private Attachment myDocument1;
    public  boolean show{set;get;}
  //  public  boolean addressproof{set;get;}
    public  boolean drivingLicence{set;get;}
    //public attachment getid{get;set;}
  //  public blob file { get; set; }
    //public String addressProofNm{get;set;}
    public String driverProofNm{get;set;}
   // public String uploadType{get;set;}
    public Id serviceProviderId{set;get;}
   // public string filename{set;get;}
   
    public AddressproofSP(ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        try{
             if(String.isNotBlank(serviceProviderId) &&serviceProviderId!=null ){
                 system.debug('serviceProviderId'+serviceProviderId);
            myCustomObjectVal = [SELECT Id,Address_Proof_Picture__c FROM Candidate__c WHERE Service_Provider__c =:serviceProviderId];
			system.debug('myCustomObjectVal'+myCustomObjectVal.Address_Proof_Picture__c);
            if(String.isBlank(myCustomObjectVal.Address_Proof_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObjectVal.Address_Proof_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObjectVal.Address_Proof_Picture__c];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
            } 
        }   
            
            
        }
        catch(exception ex){
            system.debug(ex.getMessage());
        }
       
    }
    
 
}