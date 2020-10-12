/*
 ** To Uplode Files in inline Fileuploader for "Aadhar Card"in Compliance Object..**
 */ 

global class AadharCardCompliance {
   public Compliance__c myCustomObject{set;get;}
        public Candidate__c myCustomObjectVal{set;get;}


    private Attachment myDocument1;
    public  boolean show{set;get;}
 
    public  boolean drivingLicence{set;get;}
    
    public String driverProofNm{get;set;}
   
    public Id serviceProviderId{set;get;}
  
     public Compliance__c compRec{get;set;}
   
    public AadharCardCompliance(ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        try{
            
             if(String.isNotBlank(serviceProviderId)){
compRec = [SELECT id,name,Service_Provider_Name__c, Aadhar_Card__c,Lithium_ID__r.Id from Compliance__c where id=:serviceProviderId];
            myCustomObjectVal = [SELECT Id, Aadhar_Card_Id__c,Aadhar_Card_Picture__c FROM Candidate__c WHERE Service_Provider__c =:compRec.Lithium_ID__r.Id];            
            //system.debug('myCustomObject'+myCustomObject);
            
            
            if(String.isBlank(myCustomObjectVal.Aadhar_Card_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObjectVal.Aadhar_Card_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObjectVal.Aadhar_Card_Picture__c];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
                system.debug('driverProofNm'+driverProofNm);
            } 
        }  
            
        }catch(exception ex){
            system.debug(ex.getMessage());
        }
         
    }
    
  
}