Global class ApplyLeaveController {
    
    Public String DriverName{Set;Get;}
    Public String reason{Set;Get;}
    Public Double latitudeval{Set;Get;}
    Public Double longitudeval{Set;Get;}
    Public String userLanguage{Set;Get;}
    public string LithiumId{Set;Get;}
    public string temparature{Set;Get;}
    Public list<string> selectedname{get;set;}
    Public Vehicle_Assignment__c VehicleAssignment {Set;Get;}
    public string networkid {set;get;}
    
    public String withwhomdidyoutravel{set;get;}
    public List<SelectOption> withwhomdidyoutravelPicklist {get;set;}
    
    Public ApplyLeaveController(){
        
        userLanguage=UserInfo.getLanguage();
        string userId= userinfo.getUserId();
        system.debug('userId'+userId);
        list<Service_Provider__c> servList = new list<Service_Provider__c>();
        if(userinfo.getUserType() != 'Standard'){
            Contact provider = [Select Id,Service_Provider__c from Contact where Id=:[Select id,contactid from user where id=:userinfo.getUserId()].ContactID];
            servList = [Select Id,Name,Lithium_ID__c from Service_Provider__c where id =:provider.Service_Provider__c Order By Createddate desc Limit 1];
            // if(VehicleAssignmentList.isempty())
            system.debug('servList12'+servList);
        }
        else
            servList = [Select Id,Name,Lithium_ID__c from Service_Provider__c Order By Createddate desc Limit 1];
        system.debug('outside'+servList);
        LithiumId = servList[0].Lithium_ID__c;
        DriverName = servList[0].Name;
        system.debug('LithiumId'+LithiumId);
        withwhomdidyoutravelpicklist = new List<SelectOption>();
        withwhomdidyoutravelpicklist.add(new SelectOption('Family Emergency','Family Emergency'));
        withwhomdidyoutravelpicklist.add(new SelectOption('Personal illness or injury','Personal illness or injury'));
        withwhomdidyoutravelpicklist.add(new SelectOption('Religious Observance','Religious Observance'));
        withwhomdidyoutravelpicklist.add(new SelectOption('Medical Leave','Medical Leave'));
        withwhomdidyoutravelpicklist.add(new SelectOption('Festival','Festival'));
        withwhomdidyoutravelpicklist.add(new SelectOption('Personal Reasons','Personal Reasons'));
        withwhomdidyoutravelpicklist.add(new SelectOption('Marriage','Marriage'));
        withwhomdidyoutravelpicklist.add(new SelectOption('Family Functions','Family Functions'));
        
        networkid = Network.getNetworkId();
    }
    
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
            //      system.debug('cv============'+cv);
            return cv.id;
        }catch(exception e){
            Debug_Log__c debug=new Debug_Log__c();
            debug.Class_Name__c='ApplyLeaveController';
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
            debug.Class_Name__c='ApplyLeaveController';
            debug.Method_Name__c='delcontentfiles';
            debug.User_Id__c=String.valueof(userinfo.getUserId());
            debug.Error_Message__c=e.getMessage( ) + ' LINE_NUMBER : ' + e.getLineNumber( ) + 'STACKTRACE : ' + e.getStacktraceString( );
            insert debug;
        }
    }
    @RemoteAction
    Global Static string createNewLeave(Map<String,String> dataMap){
        
        Id recid;
        string toDate = dataMap.get('toDate');
        string fromDate = dataMap.get('fromDate');
        string reason = dataMap.get('reason');
        Date to = Date.valueOf(toDate);
        Date fromd = Date.valueOf(fromDate);
        System.debug('to');
        string inputfileids1 = dataMap.get('inputfileids');
        system.debug('inputfileids1'+inputfileids1);
        string objectname = dataMap.get('objectname');
        Date Stoday = system.today();
        Datetime timeVal = Datetime.newInstance(fromd.year(), fromd.month(),fromd.day());
        Date ApplyDate = Date.valueOf(fromDate);
        Integer numberDaysDue = Stoday.daysBetween(ApplyDate);
        system.debug('numberDaysDue'+numberDaysDue);
        Service_Provider__c sProvider = [select id,Lithium_ID__c,Site__c from Service_Provider__c where Name=:dataMap.get('serviceprovider') ];
        system.debug('sProvider'+sProvider);
        string sCity = sProvider.Site__c;
        system.debug('sCity'+sCity);
        
        string Sp = 'select COUNT() from Service_Provider__c where Site__c=:sCity';
        Double totalSP= database.countQuery(Sp);
        
        String squery = 'select COUNT() from Leave__c where Service_Provider__r.Site__c =:sCity and From_date__c=:fromd';
        Double totalLeave= database.countQuery(squery);
        Double leavePercent = totalLeave / 100 ;
        // Id totalLeave =[select COUNT(id) from Leave__c where Service_Provider__r.Site__c =:sProvider.Site__c and From_date__c =:fromd];
        system.debug('totalSP'+totalSP);
        system.debug('totalLeave'+totalLeave);
        Double lePerc = totalSP *(totalLeave / 10);
        system.debug('lePerc'+lePerc);
        string error;
        if(numberDaysDue < 2){
            
            error = 'todayError'; 
            
        } else if( lePerc > 0.1) {
            
            error = 'siteError'; 
            
            
        } else{
            Id plannedRecordTypeId = Schema.SObjectType.Leave__c.getRecordTypeInfosByDeveloperName().get('Planned_Leave').getRecordTypeId();
            system.debug('plannedRecordTypeId'+plannedRecordTypeId);
            Leave__c  leaveRec = new Leave__c();
            leaveRec.RecordTypeId = plannedRecordTypeId;
            leaveRec.From_date__c = fromd;
            leaveRec.To_date__c = to;
            leaveRec.Reason__c = reason;
            leaveRec.Approval_Request__c = 'Initial';
            leaveRec.From_Date_Reference__c = system.now();
            system.debug('From_Date_Reference__c'+leaveRec.From_Date_Reference__c);
            //leaveRec.Lithium_ID__c = sProvider.Lithium_ID__c;
            leaveRec.Service_Provider__c = sProvider.Id;
            insert leaveRec;
            recid = leaveRec.Id;
            system.debug('leaveRec'+leaveRec);
            If(inputfileids1!=Null){
                Set<String>VersionidSet =New Set<String>();
                For(String s:inputfileids1.split(',')){
                    VersionidSet.add(s);
                }
                system.debug('VersionidSet'+VersionidSet);
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
                if(linkList !=null && !linkList.isempty()){ 
                    system.debug('linkList1111111111'+linkList);
                    ContentDocumentLink conlist = [select id,ContentDocumentId from ContentDocumentLink where id =:linkList[0].id];
                    system.debug('conlist'+conlist.ContentDocumentId);
                    string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
                    String[] arrTest = temp.split('\\.');
                    String st='/';
                    // string t=System.Label.UrlToRedirectContentDoc+ '.lightning.force.com/lightning/r/ContentDocument/'+conlist.ContentDocumentId+'/view';
                    string t=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+conlist.ContentDocumentId+'/view';
                    Leave__c leaveDoc=[select id,Document__c,name from Leave__c where id=:leaveRec.Id];
                    leaveDoc.Document__c = t;
                    update leaveDoc;
                    //system.debug('dailyRec'+leaveDoc);
                    system.debug('test'+t);
                }
            }
        } 
        system.debug('error'+error);
        return error;
    }
}