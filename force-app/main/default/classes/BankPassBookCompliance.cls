/*
 ** To Uplode Files in inline Fileuploader for "Bank PassBook"in Compliance Object..**
 */ 

global class BankPassBookCompliance {
    
  
     public Candidate__c myCustomObjectVal{set;get;}
    public Compliance__c compRec{get;set;}
   
    private Attachment myDocument1;
    public  boolean show{set;get;}
   
    public  boolean drivingLicence{set;get;}
 
    public String driverProofNm{get;set;}
    
    public Id serviceProviderId{set;get;}
  
   
    public BankPassBookCompliance(ApexPages.StandardController controller){
        show = false;
        serviceProviderId = controller.getId();
        onLoad();
        
        
    }
    public void onLoad(){
        try{
            if(String.isNotBlank(serviceProviderId)){
           // myCustomObject = [SELECT Id,Bank_PassBook_Picture__c FROM Compliance__c WHERE Id =: serviceProviderId  ];
            
           // system.debug('myCustomObject'+myCustomObject);
             compRec = [SELECT id,name,Service_Provider_Name__c, Aadhar_Card__c,Lithium_ID__r.Id from Compliance__c where id=:serviceProviderId];
            myCustomObjectVal = [SELECT Id, Aadhar_Card_Id__c,Bank_PassBook_Picture__c FROM Candidate__c WHERE Service_Provider__c =:compRec.Lithium_ID__r.Id];
            
            
            if(String.isBlank(myCustomObjectVal.Bank_PassBook_Picture__c)){
                drivingLicence=true;
            }else if(String.isNotBlank(myCustomObjectVal.Bank_PassBook_Picture__c)){
                drivingLicence=false;
                //SELECT id,Title,ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where LinkedEntityId in ( SELECT id FROM Service_Provider__c  where Id ='a0m0w0000007RUYAA2') and LinkedEntity.Type='Service_Provider__c'

                List<ContentDocument> conVLst = [select id,Title from ContentDocument where id=:myCustomObjectVal.Bank_PassBook_Picture__c];
                if(conVLst.size() > 0)
                    driverProofNm = conVLst[0].Title;
            } 
        }   
            
            
        }catch(exception ex){
            system.debug(ex.getMessage());
        }

         
    }
  
    
}