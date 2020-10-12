/*
 ** To Uplode Files in inline Fileuploader for "Address Proof"in Compliance Object..**
 */ 

global class AddressproofComplaince {
    public Compliance__c myCustomObject{set;get;}
    public Candidate__c myCustomObjectVal{set;get;}
    public Compliance__c compRec{get;set;}

    private Attachment myDocument1;
    public  boolean show{set;get;}
  
    public  boolean drivingLicence{set;get;}
 
  
    public String driverProofNm{get;set;}
   
    public Id serviceProviderId{set;get;}
  
   
    public AddressproofComplaince(ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        try{
             if(String.isNotBlank(serviceProviderId)){
            //myCustomObject = [SELECT Id,Address_Proof_Picture__c FROM Compliance__c WHERE Id =: serviceProviderId  ];
            
           // system.debug('myCustomObject'+myCustomObject);
            compRec = [SELECT id,name,Service_Provider_Name__c, Aadhar_Card__c,Lithium_ID__r.Id from Compliance__c where id=:serviceProviderId];
            myCustomObjectVal = [SELECT Id, Aadhar_Card_Id__c,Address_Proof_Picture__c FROM Candidate__c WHERE Service_Provider__c =:compRec.Lithium_ID__r.Id];
            
            
            if(String.isBlank(myCustomObjectVal.Address_Proof_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObjectVal.Address_Proof_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObjectVal.Address_Proof_Picture__c];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
            } 
        }  
            
        }catch(exception ex){
            system.debug(ex.getMessage());
        }
         
         
    }
    
   
}