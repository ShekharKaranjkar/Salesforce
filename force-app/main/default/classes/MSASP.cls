global class MSASP {
 public Compliance__c myCustomObject{set;get;}
    public Candidate__c myCustomObjectVal{set;get;}
  
    public  boolean show{set;get;}
    public  boolean drivingLicence{set;get;}
  
    public String driverProofNm{get;set;}
    public Id serviceProviderId{set;get;}
   
    public MSASP(ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        try{
            
            if(String.isNotBlank(serviceProviderId)){
         myCustomObjectVal = [SELECT Id,MSA_Picture__c FROM Candidate__c WHERE Service_Provider__c =:serviceProviderId];
            
            
            if(String.isBlank(myCustomObjectVal.MSA_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObjectVal.MSA_Picture__c)){
                drivingLicence=false;
                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObjectVal.MSA_Picture__c];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
            } 
        }     
            
        }catch(exception ex){
            system.debug(ex.getMessage());
        }
       
    }
}