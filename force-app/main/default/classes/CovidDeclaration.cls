Global class CovidDeclaration {
    
    
 public ContentVersion cont {get;set;}
    Public String DriverName{Set;Get;}
    Public String VehicleNumber{Set;Get;}
    Public String issuewith{Set;Get;}
    Public String inputfileids{Set;Get;}
    Public Double latitudeval{Set;Get;}
    Public Double longitudeval{Set;Get;}
    Public String userLanguage{Set;Get;}
    Public Boolean setuApp {set;get;}
    Public Boolean duty {set;get;}
    public attachment document {set;get;}  
    Public Vehicle_Assignment__c VehicleAssignment {Set;Get;}
    Public Covid_Declaration__c covid {Set;Get;}
    Public Issues__c Issuerec {Set;Get;}
    Public string doctorContentVersionId {set;get;}
    Public string signedContentVersionId {set;get;}
    public string networkid {set;get;}
    public Attachment attrec {set;get;}
    Public CovidDeclaration(){
        duty=false;
        setuApp=false;
        document=new attachment();
        covid=new Covid_Declaration__c();
        userLanguage=UserInfo.getLanguage();
        List<Vehicle_Assignment__c>VehicleAssignmentList = New  List<Vehicle_Assignment__c>();
        if(userinfo.getUserType() != 'Standard'){
            Contact provider = [Select Id,Service_Provider__c from Contact where Id=:[Select id,contactid from user where id=:userinfo.getUserId()].ContactID];
            VehicleAssignmentList = [Select Id,Name,Vehicle__c,Service_Provider__c,Service_Provider__r.Name,Vehicle__r.Vehicle_Registration_Number__c from Vehicle_Assignment__c where Vehicle__r.Vehicle_Registration_Number__c !=null AND Service_Provider__c =:provider.Service_Provider__c AND Check_Out_Time__c = null Order By Createddate desc Limit 1];
            // if(VehicleAssignmentList.isempty())
        }
        else
            VehicleAssignmentList = [Select Id,Name,Vehicle__c,Service_Provider__c,Service_Provider__r.Name,Vehicle__r.Vehicle_Registration_Number__c from Vehicle_Assignment__c where Vehicle__r.Vehicle_Registration_Number__c !=null AND Service_Provider__c !=null Order By Createddate desc Limit 1];
        
        if(VehicleAssignmentList !=Null && !VehicleAssignmentList.IsEmpty()){
            VehicleAssignment = VehicleAssignmentList.get(0);
            DriverName = VehicleAssignment.Service_Provider__r.Name;
            VehicleNumber = VehicleAssignment.Vehicle__r.Vehicle_Registration_Number__c;
            string lat = Apexpages.currentPage().getParameters().get('latitudeval');
            string log= Apexpages.currentPage().getParameters().get('longitudeval');
            issuewith = Apexpages.currentPage().getParameters().get('issuewith');
            if(issuewith != Null && !String.isBlank(issuewith) && !userLanguage.containsIgnoreCase('en_')){
                string issuewithid = Apexpages.currentPage().getParameters().get('recid');
                if(issuewithid !=null){
                    List<Service_Providers_Issue_with__c> issuewithList= [Select id,Issue_With_Hindi__c,Issue_With__c,Issue_With_Teliugu__c,Issue_With_Kannada__c,Issue_With_Tamil__c from Service_Providers_Issue_with__c where id=:issuewithid];
                    if(userLanguage == 'hi')
                        issuewith = issuewithList.get(0).Issue_With_Hindi__c;                 
                    if(userLanguage == 'ta')
                        issuewith = issuewithList.get(0).Issue_With_Tamil__c;
                    if(userLanguage == 'te')
                        issuewith = issuewithList.get(0).Issue_With_Teliugu__c;
                    if(userLanguage == 'kn')
                        issuewith = issuewithList.get(0).Issue_With_Kannada__c;
                }
            }
            if(lat !=null)
                latitudeval=double.valueof(lat);
            if(log !=null)
                longitudeval=double.valueof(log);    
            List<Issues__c>IssuerecList = [Select id ,Issue_With__c from Issues__c where Vehicle__c =: VehicleAssignment.Vehicle__c And Service_Provider__c =: VehicleAssignment.Service_Provider__c order by createddate desc limit 1];
            if(IssuerecList !=null && !IssuerecList.isempty())
                Issuerec = IssuerecList.get(0);
            networkid = Network.getNetworkId();
        }
        attrec = new Attachment();
    }
    
    
    public void delcontentfiles(){
        String contentversionId = Apexpages.currentPage().getParameters().get('firstParam');
        
        // system.debug('contentDocumentId ' + contentDocumentId);
        try{
            List<ContentVersion> docList = [SELECT Id,ContentDocumentid FROM ContentVersion where id=:contentversionId];
            DELETE [SELECT Id FROM ContentDocument WHERE Id =:docList[0].ContentDocumentid];
        }catch(Exception e){
            Debug_Log__c debug=new Debug_Log__c();
            debug.Class_Name__c='DriverMenuCtrl';
            debug.Method_Name__c='delcontentfiles';
            debug.User_Id__c=String.valueof(userinfo.getUserId());
            debug.Error_Message__c=e.getMessage( ) + ' LINE_NUMBER : ' + e.getLineNumber( ) + 'STACKTRACE : ' + e.getStacktraceString( );
            insert debug;
        }
    }
    
    @RemoteAction
    Global Static void createisseus(Map<String,String> dataMap){ 
      // system.debug('dataMap'+dataMap);
        string inputfileids1 = dataMap.get('inputfileids');
        string inputfileids2= dataMap.get('inputfileids2');
        string Comments = dataMap.get('Comments');
        string Comments2 = dataMap.get('Comments2');
        string vehicleassignid = dataMap.get('vehicleassignid');
        If(inputfileids1!=Null){
                Set<String>VersionidSet1 =New Set<String>();
                     Set<String>VersionidSet2 =New Set<String>();
                For(String s:inputfileids1.split(',')){
                    VersionidSet1.add(s);
                }
                For(String s:inputfileids2.split(',')){
                    VersionidSet2.add(s);
                }
                string certificateLinkNew ='';
                string signLinkNew='';

                if(inputfileids1 != Null && !String.isBlank(inputfileids1) && !String.isEmpty(inputfileids1)){
                    string signLink=[Select id,ContentDocumentId From ContentVersion Where Id=:VersionidSet1 limit 1].ContentDocumentId;
                    signLinkNew=System.Label.UrlToRedirectContentDoc+'.lightning.force.com/lightning/r/ContentDocument/'+signLink+'/view';
                    //signLinkNew=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+signLink+'/view';
                    system.debug('signLinkNew'+signLinkNew);
                }
                if(inputfileids2 != Null && !String.isBlank(inputfileids2) && !String.isEmpty(inputfileids2)){
                    string certificateLink=[Select id,ContentDocumentId From ContentVersion Where Id=:VersionidSet2 limit 1].ContentDocumentId;
                     certificateLinkNew=System.Label.UrlToRedirectContentDoc+'.lightning.force.com/lightning/r/ContentDocument/'+certificateLink+'/view';
                  //  certificateLinkNew=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+certificateLink+'/view';
                    system.debug('certificateLinkNew'+certificateLinkNew);  
                }
                Covid_Declaration__c c=new Covid_Declaration__c();
                c.Upload_doctors_certificate__c= certificateLinkNew;
                c.Upload_signed_declaration__c=signLinkNew;
           
                    c.AarogyaApp__c=Comments;
                

                    c.JoinedDuty__c=Comments2;
                
           
                
               c.Service_Provider__c=dataMap.get('serviceprovider');
                insert c;
                system.debug('cccccccccc========='+c);
            }
            
            
      
    }
    @AuraEnabled
    Public Static List<Service_Providers_Issue_with__c> getissuewithrecords(){
        String  userLanguage = UserInfo.getLanguage();
        if(userLanguage == 'en_IN' || userLanguage.containsIgnoreCase('en_'))
            return [Select id,Issue_Category__c,Issue_With__c,Priority__c from Service_Providers_Issue_with__c];
        else if(userLanguage == 'hi')
            return [Select id,Issue_Category__c,Issue_With_Hindi__c,Priority_Hindi__c,Issue_Category_Hindi__c,Issue_With__c from Service_Providers_Issue_with__c];
        else if(userLanguage == 'ta')
            return [Select id,Issue_Category__c,Issue_Category_Tamil__c,Priority_Tamil__c,Issue_With_Tamil__c,Issue_With__c from Service_Providers_Issue_with__c];
        else if(userLanguage == 'te')
            return [Select id,Issue_Category__c,Priority_Telugu__c,Issue_With_Teliugu__c,Issue_Category_Telugu__c,Issue_With__c from Service_Providers_Issue_with__c];
        else if(userLanguage == 'kn')
            return [Select id,Issue_Category__c,Issue_Category_Kannada__c,Priority_Kannada__c,Issue_With_Kannada__c,Issue_With__c  from Service_Providers_Issue_with__c];
        else
            return null;
    }
}