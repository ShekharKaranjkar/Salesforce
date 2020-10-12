/*
 ** To Uplode Files in inline Fileuploader for "VoterID Card"in Compliance Object..**
 */ 


global class VoterIdCompliance {
   
    public Candidate__c myCustomObjectVal{set;get;}
    public Compliance__c compRec{get;set;}
  
    private Attachment myDocument1;
    public  boolean show{set;get;}
   
    public  boolean drivingLicence{set;get;}
    
    public String driverProofNm{get;set;}
  
    public Id serviceProviderId{set;get;}
  
   
    public VoterIdCompliance(ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        try{
             if(String.isNotBlank(serviceProviderId)){
            //myCustomObject = [SELECT Id,VoterId_Card_Picture__c FROM Compliance__c WHERE Id =: serviceProviderId  ];
            
            //system.debug('myCustomObject'+myCustomObject);
            compRec = [SELECT id,name,Service_Provider_Name__c, Aadhar_Card__c,Lithium_ID__r.Id from Compliance__c where id=:serviceProviderId];
            myCustomObjectVal = [SELECT Id, Aadhar_Card_Id__c,VoterId_Card_Picture__c FROM Candidate__c WHERE Service_Provider__c =:compRec.Lithium_ID__r.Id];
            
            
            if(String.isBlank(myCustomObjectVal.VoterId_Card_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObjectVal.VoterId_Card_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObjectVal.VoterId_Card_Picture__c];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
            } 
        }   
            
            
        }catch(exception ex){
            system.debug(ex.getMessage());
        }
        
        
    }
    
  
}