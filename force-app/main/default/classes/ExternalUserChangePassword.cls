public class ExternalUserChangePassword {
    public String newPassword{get;set;}
    public String confirmPassword{get;set;}
    
    public ExternalUserChangePassword(){
        
    }
    
    public PageReference setPassword(){
        try{
        if(String.isNotBlank(newPassword) && String.isNotBlank(confirmPassword)){
            User u =[SELECT Id,MobilePhone,ContactId FROM User WHERE ID=:UserInfo.getUserId()];
            if(newPassword == confirmPassword){
                
               System.setPassword(u.Id, newPassword);
               update new Contact(Id = u.ContactId, IsFirstLogin__c = true);
               return new PageReference('/s/');
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Password mismatch'));    
            }
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Password fields cannot be blank'));    
        }
        }catch(Exception e){
            system.debug(e.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        }
        return null;
    }
    public PageReference onLoad(){
        try{
            List<Contact> con = [SELECT Id,IsFirstLogin__c FROM Contact WHERE UserId__c = :UserInfo.getUserId()];
            if(con.size() > 0){
                if(!con[0].IsFirstLogin__c){
                    return null; 
                }else{
                    return new PageReference('/s/');
                }
            }
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        }
        return null;
    }
}