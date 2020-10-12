Global class DailyDriverCovidController {
    Public String DriverName{Set;Get;}
    Public String VehicleNumber{Set;Get;}
    Public String issuewith{Set;Get;}
    Public String inputfileids{Set;Get;}
    Public Double latitudeval{Set;Get;}
    Public Double longitudeval{Set;Get;}
    Public String userLanguage{Set;Get;}
    public Boolean symptoms{set;get;}
    public string temparature{Set;Get;}
    Public Vehicle_Assignment__c VehicleAssignment {Set;Get;}
    Public Issues__c Issuerec {Set;Get;}
    public string networkid {set;get;}
    public Attachment attrec {set;get;}
    public Boolean showDriver{set;get;}
    public Daily_covid_activities_Driver__c dailyDriverCovid{Set;Get;}
    Public DailyDriverCovidController(){
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
           list<Daily_covid_activities_Driver__c>dailyDriverCovid = [select id from Daily_covid_activities_Driver__c where Driver__c =:VehicleAssignment.Service_Provider__c AND CreatedDate = TODAY order by createddate desc limit 1];
            //if(([select id from Daily_covid_activities_Driver__c where Driver__c =:VehicleAssignment.Service_Provider__c AND CreatedDate = TODAY Limit 1]).length > 0){
            if(dailyDriverCovid !=null && !dailyDriverCovid.isempty()){
               showDriver = true;
                system.debug('showDriver'+showDriver); 
            }
         else{
                  showDriver = false;
            system.debug('showDriver'+showDriver);
            }
              
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
    /*Public void createIssueORservicerequestRec(){
Id RepairevRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByDeveloperName().get('Repair').getRecordTypeId();
Id BreakDownRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByDeveloperName().get('Breakdown').getRecordTypeId();
Id AcciedentRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByDeveloperName().get('Breakdown').getRecordTypeId();
Id TowingORreplacementRecordTypeId = Schema.SObjectType.Service_Request__c.getRecordTypeInfosByDeveloperName().get('Towing_Replacement').getRecordTypeId();

string issuewith1 = Apexpages.currentPage().getParameters().get('issuewith');
string inputfileids1 = system.CurrentPageReference().getParameters().get('inputfileids');
string objectname = system.CurrentPageReference().getParameters().get('objectname');
string issuetype = Apexpages.currentPage().getParameters().get('requesttype');
string latitude = system.CurrentPageReference().getParameters().get('latitude');
string longitude = Apexpages.currentPage().getParameters().get('longitude');
Id recid;
If(objectname == 'ISSUE'){
Issues__c i = New Issues__c();
i.RecordTypeId = RepairevRecordTypeId;
i.Service_Provider__c = VehicleAssignment.Service_Provider__c;
i.Issue_With__c = issuewith1;
i.Vehicle__c = VehicleAssignment.Vehicle__c;

Insert i;
recid = i.id;
system.debug('!@3:'+i.Id);}
else if(objectname == 'ServiceRequest'){
Service_Request__c sr = New Service_Request__c();
sr.RecordTypeId = TowingORreplacementRecordTypeId;
sr.Driver__c = VehicleAssignment.Service_Provider__c;
sr.Vehicle__c = VehicleAssignment.Vehicle__c;
sr.Reason__c = issuewith1;
sr.Type__c = issuetype;
sr.Location__Latitude__s = Double.valueof(latitude);
sr.Location__Longitude__s = Double.valueof(longitude);

Insert sr;
recid = sr.id;
}
If(inputfileids1!=Null){
Set<String>VersionidSet =New Set<String>();
For(String s:inputfileids1.split(',')){
VersionidSet.add(s);
}
List<ContentDocumentLink>linkList=New List<ContentDocumentLink>();
For(ContentVersion webdoc :[Select id,ContentDocumentId From ContentVersion Where Id=:VersionidSet]){
ContentDocumentLink contentlink=new ContentDocumentLink();
contentlink.LinkedEntityId=recid;
contentlink.ShareType= 'V';
contentlink.ContentDocumentId=webdoc.ContentDocumentId;
linkList.add(contentlink);
}
Insert linkList;
}
CollaborationGroup collgroup = [select Id,Name from CollaborationGroup where Name='MT Compliance and COO'];
If(collgroup!=Null){
List<String>userIdsList = New List<String>();
For(CollaborationGroupMember member: [select Id,CollaborationGroupId,MemberId from CollaborationGroupMember where CollaborationGroupId  =:collgroup.Id]){
userIdsList.add(member.MemberId);
}
if(userIdsList!=Null){
Map<String, Object> params = new Map<String, Object>();
params.put('TargetId', recid);
params.put('NotificationTitle', 'Issue Created');
params.put('NotificationBody', 'New Issue was Created, issue with '+issuewith1);
params.put('NotificationRecipientIDs', userIdsList);
Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
flowToRemoveAcc.start();
}
}
}*/
    @RemoteAction
    global static String uploadfiles(String base64Data, String filetName,string NetworkId,string FirstPublishLocationId){
        //base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        ContentVersion cv = new ContentVersion();
        cv.Title = filetName;
        cv.PathOnClient = filetName+'.wav';
        //cv.VersionData = EncodingUtil.base64Decode(base64Data);
        cv.VersionData = EncodingUtil.base64Decode(base64Data);
        cv.IsMajorVersion = false;
        cv.NetworkId = NetworkId;
        cv.FirstPublishLocationId = FirstPublishLocationId;
        try{
            insert cv;
            system.debug('cv============'+cv);
            return cv.id;
        }catch(exception e){
            Debug_Log__c debug=new Debug_Log__c();
            debug.Class_Name__c='DriverMenuCtrl';
            debug.Method_Name__c='uploadfiles';
            debug.User_Id__c=String.valueof(userinfo.getUserId());
            debug.Error_Message__c=e.getMessage( ) + ' LINE_NUMBER : ' + e.getLineNumber( ) + 'STACKTRACE : ' + e.getStacktraceString( );
            debug.Stack_Trace__c = 'Vehicle Assignment Record Id :'+FirstPublishLocationId;
            insert debug;
            Return null;
        }
        
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
    /*public PageReference setlatlong(){
string latitude = Apexpages.currentPage().getParameters().get('latitudeval');
string longitude = Apexpages.currentPage().getParameters().get('longitudeval');
system.debug('## '+system.CurrentPageReference().getParameters().get('latitudeval'));

if(latitude != NUll && longitude !=NUll){
latitudeval = Double.valueof(latitude);
longitudeval = Double.valueof(longitude);

PageReference pageRef = new PageReference('/apex/Driver_BreakDown_Form?latitudeval='+latitudeval+'&longitudeval='+longitudeval);
return pageRef;}
return null;
}*/
    @RemoteAction
    Global Static void createCovidActivity(Map<String,String> dataMap){
        
        string temperature = dataMap.get('temperature');
        string inputfileids1 = dataMap.get('inputfileids');
        system.debug('inputfileids1'+inputfileids1);
        string objectname = dataMap.get('objectname');
        string symptoms = dataMap.get('symptoms');
        string vehicleassignid = dataMap.get('vehicleassignid');
        string vehicle = dataMap.get('vehicle');
        Id recid;
        Boolean covidSymptom;
        if(symptoms=='true'){
            covidSymptom = true;
        }else{
            covidSymptom = false;
            
        }
        Daily_covid_activities_Driver__c covidEntry = new Daily_covid_activities_Driver__c();
        //covidEntry.Body_Temperature__c = temperature;
        //covidEntry.Covid_Symptoms__c = covidSymptom;
        covidEntry.Status__c = 'Submitted';
        covidEntry.Driver__c = dataMap.get('serviceprovider');
        insert covidEntry;
        system.debug('covidEntry'+covidEntry);
        recid = covidEntry.Id;
        If(inputfileids1!=Null){
            Set<String>VersionidSet =New Set<String>();
            For(String s:inputfileids1.split(',')){
                VersionidSet.add(s);
            }
            List<ContentDocumentLink>linkList=New List<ContentDocumentLink>();
            For(ContentVersion webdoc :[Select id,ContentDocumentId From ContentVersion Where Id=:VersionidSet]){
                ContentDocumentLink contentlink=new ContentDocumentLink();
                contentlink.LinkedEntityId=recid;
                contentlink.ShareType= 'V';
                contentlink.ContentDocumentId=webdoc.ContentDocumentId;
                linkList.add(contentlink);
            }
            Insert linkList;
            
            ContentDocumentLink conlist = [select id,ContentDocumentId from ContentDocumentLink where id =:linkList[0].id];
            system.debug('conlist'+conlist.ContentDocumentId);
            string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
            String[] arrTest = temp.split('\\.');
            String st='/';
            string t=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+conlist.ContentDocumentId+'/view';
            Daily_covid_activities_Driver__c dailyRec=[select id,Aarogya_Setu_Screenshot__c,name from Daily_covid_activities_Driver__c where id=:covidEntry.Id];
            dailyRec.Aarogya_Setu_Screenshot__c=t;
            update dailyRec;
            system.debug('dailyRec'+dailyRec);
            system.debug('test'+t);
        }
    }
    @RemoteAction
    Global Static void createisseus(Map<String,String> dataMap){
        Id RepairevRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByDeveloperName().get('Repair').getRecordTypeId();
        Id BreakDownRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByDeveloperName().get('Breakdown').getRecordTypeId();
        Id AcciedentRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByDeveloperName().get('Accident').getRecordTypeId();
        Id TowingORreplacementRecordTypeId = Schema.SObjectType.Service_Request__c.getRecordTypeInfosByDeveloperName().get('Accident_Breakdown').getRecordTypeId();
        
        string issuewith1 = dataMap.get('issuewith');
        string inputfileids1 = dataMap.get('inputfileids');
        string objectname = dataMap.get('objectname');
        string issuetype = dataMap.get('requesttype');
        string latitude = dataMap.get('latitude');
        string longitude = dataMap.get('longitude');
        string recordtypename =dataMap.get('RecordtypeName'); 
        string accidenttype =dataMap.get('accidenttype'); 
        string issuecategory =dataMap.get('issuecategory'); 
        string issuepriority =dataMap.get('issuepriority');
        string reason =dataMap.get('reason');
        string Comments = dataMap.get('Comments');
        string vehicleassignid = dataMap.get('vehicleassignid');
        Id recid;
        try{     
            Issues__c i = New Issues__c();
            if(recordtypename == 'Repair')
                i.RecordTypeId = RepairevRecordTypeId;
            if(recordtypename == 'BreakDown')
                i.RecordTypeId = BreakDownRecordTypeId;
            if(recordtypename == 'Accident')
                i.RecordTypeId = AcciedentRecordTypeId;
            i.Service_Provider__c = dataMap.get('serviceprovider');
            i.Issue_With__c = issuewith1;
            i.Vehicle__c = dataMap.get('vehicle');
            i.Current_Location__Latitude__s  = Decimal.valueof(latitude);
            i.Current_Location__Longitude__s  = Decimal.valueof(longitude);
            //i.Service_Provider__c
            if(accidenttype != Null && !String.isBlank(accidenttype) && !String.isEmpty(accidenttype)){
                i.Type__c= accidenttype;
                if(accidenttype == 'Major')
                    i.Human_Injury__c = 'Yes';
                else
                    i.Human_Injury__c = 'No';   
            }
            if(issuepriority != Null && !String.isBlank(issuepriority) && !String.isEmpty(issuepriority))
                i.Priority__c = issuepriority;
            if(issuecategory == 'Body Panels ')
                issuecategory = 'Body Panels & Parts';
            i.Issue_Category__c = issuecategory;
            i.Comments__c = Comments;
            if(vehicleassignid != Null && !String.isBlank(vehicleassignid) && !String.isEmpty(vehicleassignid))
                i.Vehicle_Assignment__c = vehicleassignid;
            System.debug('issue== '+i);
            Insert i;
            
            recid = i.id;
            system.debug('!!'+i);
            If(objectname == 'ServiceRequest'){
                
                Service_Request__c sr = New Service_Request__c();
                sr.RecordTypeId = TowingORreplacementRecordTypeId;
                sr.Driver__c = dataMap.get('serviceprovider');
                sr.Vehicle__c = dataMap.get('vehicle');
                ///if(reason != Null && !String.isBlank(reason) && !String.isEmpty(reason))
                //sr.Reason__c = reason;
                sr.Type__c = issuetype;
                sr.Location__Latitude__s = Double.valueof(latitude);
                sr.Location__Longitude__s = Double.valueof(longitude);
                sr.Issues__c = i.id;
                Insert sr;
            }
            If(inputfileids1!=Null){
                Set<String>VersionidSet =New Set<String>();
                For(String s:inputfileids1.split(',')){
                    VersionidSet.add(s);
                }
                List<ContentDocumentLink>linkList=New List<ContentDocumentLink>();
                For(ContentVersion webdoc :[Select id,ContentDocumentId From ContentVersion Where Id=:VersionidSet]){
                    ContentDocumentLink contentlink=new ContentDocumentLink();
                    contentlink.LinkedEntityId=recid;
                    contentlink.ShareType= 'V';
                    contentlink.ContentDocumentId=webdoc.ContentDocumentId;
                    linkList.add(contentlink);
                }
                Insert linkList;
                system.debug('linkList'+linkList);
            }
            /* CollaborationGroup collgroup = [select Id,Name from CollaborationGroup where Name='MT Compliance and COO' OR Name='MTComplianceandCOOId from Test Class'];
If(collgroup!=Null){
List<String>userIdsList = New List<String>();
For(CollaborationGroupMember member: [select Id,CollaborationGroupId,MemberId from CollaborationGroupMember where CollaborationGroupId  =:collgroup.Id]){
userIdsList.add(member.MemberId);
}*/
            Map<Id,User>usersMap = New Map<Id,User>([Select id from User where UserRole.Name =: Label.Major_Notification_Roles.split(',') AND IsActive=true ]);
            if(usersMap!=Null){
                Issues__c iss = [Select id,name from Issues__c where id=:i.id];
                Map<String, Object> params = new Map<String, Object>();
                String Notificationbody = 'Issue no : '+iss.Name+', New Issue was Created , issue with '+issuewith1 ;
                if(accidenttype != Null && !String.isBlank(accidenttype) && !String.isEmpty(accidenttype))
                    Notificationbody = 'Issue no : '+iss.Name+', New Issue was Created, accident type is '+accidenttype;
                if(reason != Null && !String.isBlank(reason) && !String.isEmpty(reason))
                    Notificationbody = 'Issue no : '+iss.Name+', New Issue was Created , issue with '+reason ;
                params.put('TargetId', recid);
                params.put('NotificationTitle', 'New '+recordtypename+' Issue Created');
                params.put('NotificationBody', Notificationbody);
                params.put('NotificationRecipientIDs', usersMap.KeySet());
                Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
                flowToRemoveAcc.start();
            }
        }catch(exception e){
            Debug_Log__c debug=new Debug_Log__c();
            debug.Class_Name__c='DriverMenuCtrl';
            debug.Method_Name__c='createisseus';
            debug.User_Id__c=String.valueof(userinfo.getUserId());
            debug.Error_Message__c=e.getMessage( ) + ' LINE_NUMBER : ' + e.getLineNumber( ) + 'STACKTRACE : ' + e.getStacktraceString( );
            insert debug;
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