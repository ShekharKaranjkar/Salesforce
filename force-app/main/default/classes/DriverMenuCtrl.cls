Global Class DriverMenuCtrl{
    Public Double latitude{Set;Get;}
    Public Double longitude{Set;Get;}
    Public String DriverName{Set;Get;}
    Public String VehicleNumber{Set;Get;}
    Public String issuewith{Set;Get;}
    Public String inputfileids{Set;Get;}
    Public Double latitudeval{Set;Get;}
    Public Double longitudeval{Set;Get;}
    Public String userLanguage{Set;Get;}
    public Boolean symptoms{set;get;}
    public string temparature{Set;Get;}
    public List<Notification__c> notificationList{Set;Get;}
    public List<Attendance__c>  todaysAttendanceList{Set;Get;}
    public List<Attendance__c> todaysAttendanceListcheckout{Set;Get;}
    public Boolean showNotification{set;get;}
    public string redirectToCovidDeclaration{Set;Get;}
    Public Vehicle_Assignment__c VehicleAssignment {Set;Get;}
    Public Issues__c Issuerec {Set;Get;}
    public string networkid {set;get;}
    public Attachment attrec {set;get;}
    public Boolean showDriver{set;get;}
    public Daily_Covid_activity_vehicle__c dailyVehicleCovid{Set;Get;}
    public Boolean showHeaderOrnot{set;get;}
    public Boolean showVehicle{set;get;}
    public Boolean showCovid{set;get;}
    public Boolean showAttendance{set;get;}
    public Boolean showcheckoutrecords{set;get;}
    public Datetime newDateTime{set;get;}
    public Boolean showTodaysAttendance{set;get;}
    public Daily_covid_activities_Driver__c dailyDriverCovid{Set;Get;}
    public Contact provider{set;get;}
    public Double offset{get{
        TimeZone tz = UserInfo.getTimeZone();
        //Milliseconds to Day
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
    }}
    
    Public DriverMenuCtrl(){
        //showHeaderOrnot=false;
        userLanguage=UserInfo.getLanguage();
        redirectToCovidDeclaration=System.Label.UrlToRedirectContentDoc+'.lightning.force.com/lightning/o/Covid_Declaration__c/list?filterName=Recent';
        system.debug('redirectToCovidDeclaration'+redirectToCovidDeclaration);
        List<Vehicle_Assignment__c>VehicleAssignmentList = New  List<Vehicle_Assignment__c>();
        if(userinfo.getUserType() != 'Standard'){
            system.debug('userinfo.getUserId--------------------'+userinfo.getUserId());
            provider = [Select Id,Service_Provider__c from Contact where Id=:[Select id,contactid from user where id=:userinfo.getUserId()].ContactID];
            system.debug('provider-----------------------------'+provider);
            VehicleAssignmentList = [Select Id,Name,Vehicle__c,Service_Provider__c,Service_Provider__r.Name,Vehicle__r.Vehicle_Registration_Number__c from Vehicle_Assignment__c where Vehicle__r.Vehicle_Registration_Number__c !=null AND Service_Provider__c =:provider.Service_Provider__c AND Check_Out_Time__c = null Order By Createddate desc Limit 1];
            // if(VehicleAssignmentList.isempty())
            todaysAttendanceList = [select id,Name,Lithium_ID__c,Login__c,Status__c,Type__c,Logout__c from Attendance__c where  CreatedDate = Today AND Service_Provider__c =: provider.Service_Provider__c];  
            todaysAttendanceListcheckout = [select id,Name,Lithium_ID__c,Login__c,Status__c,Type__c,Logout__c from Attendance__c where  CreatedDate = Today AND Service_Provider__c =: provider.Service_Provider__c AND Type__c ='Check out'];
            // DateTime newDateTime = myDateTime.addHours(3);
            system.debug('attendanceList-----112'+todaysAttendanceList);
            if(todaysAttendanceList !=null && !todaysAttendanceList.isempty()){
                showTodaysAttendance = true;
                system.debug('showTodaysAttendance'+showTodaysAttendance); 
            }
            else{
                showTodaysAttendance = false;
                system.debug('CovidDec'+showTodaysAttendance);
            }
            
            
            system.debug('attendanceList-----112'+todaysAttendanceListcheckout);
            if(todaysAttendanceListcheckout !=null && !todaysAttendanceListcheckout.isempty()){
                showcheckoutrecords = true;
                system.debug('showTodaysAttendance'+showcheckoutrecords); 
            }
            
            else{
                showcheckoutrecords = false;
                system.debug('CovidDec'+showcheckoutrecords);
            }
            notificationList = [select id,Name,User_Id__c,User_Id__r.Name,Message__c from Notification__c where createdDate=Today  AND User_Id__c = :userinfo.getUserId() Order By Createddate desc ];
            system.debug('notificationList-----------'+notificationList);
            if(notificationList !=null && !notificationList.isempty()){
                showNotification = true;
                system.debug('showNotification'+showNotification); 
            } else{
                showNotification = false;
                system.debug('showNotification'+showNotification);
            }
            
            list<Daily_covid_activities_Driver__c>dailyDriverCovid = [select id from Daily_covid_activities_Driver__c where Driver__c =:provider.Service_Provider__c AND CreatedDate = TODAY AND Status__c != 'Rejected' order by createddate desc limit 1];
            //if(([select id from Daily_covid_activities_Driver__c where Driver__c =:VehicleAssignment.Service_Provider__c AND CreatedDate = TODAY Limit 1]).length > 0){
            if(dailyDriverCovid !=null && !dailyDriverCovid.isempty()){
                showDriver = true;
                system.debug('dailyDriverCovid'+showDriver); 
            }
            else{
                showDriver = false;
                system.debug('dailyDriverCovid'+showDriver);
            }
            list<Covid_Declaration__c>CovidDec = [select id from Covid_Declaration__c where Service_Provider__c =:provider.Service_Provider__c AND CreatedDate = LAST_N_DAYS:30 order by createddate desc limit 1];
            //if(([select id from Daily_covid_activities_Driver__c where Driver__c =:VehicleAssignment.Service_Provider__c AND CreatedDate = TODAY Limit 1]).length > 0){
            system.debug('covidDec---------------'+CovidDec);
            if(CovidDec !=null && !CovidDec.isempty()){
                showCovid = true;
                system.debug('CovidDec'+showCovid); 
            }
            else{
                showCovid = false;
                system.debug('CovidDec'+showCovid);
            }
            list<Daily_Covid_activity_vehicle__c>dailyVehicleCovid = [select id from Daily_Covid_activity_vehicle__c where Service_Provider__c =:provider.Service_Provider__c  AND CreatedDate = TODAY order by createddate desc limit 1];
            
            list<Attendance__c> attenList = [select id from Attendance__c where Service_Provider__c =:provider.Service_Provider__c AND CreatedDate = Today order by createddate desc limit 1];
            //if(([select id from Daily_covid_activities_Driver__c where Driver__c =:VehicleAssignment.Service_Provider__c AND CreatedDate = TODAY Limit 1]).length > 0){
            system.debug('attenList-----81'+attenList);
            if(attenList !=null && !attenList.isempty()){
                showAttendance = true;
                system.debug('CovidDec'+showAttendance); 
            }
            else{
                showAttendance = false;
                system.debug('CovidDec'+showAttendance);
            }
            system.debug('showCovid---------------'+showCovid);
        }
        else
            VehicleAssignmentList = [Select Id,Name,Vehicle__c,Service_Provider__c,Service_Provider__r.Name,Vehicle__r.Vehicle_Registration_Number__c from Vehicle_Assignment__c where Vehicle__r.Vehicle_Registration_Number__c !=null AND Service_Provider__c !=null Order By Createddate desc Limit 1];
        if(VehicleAssignmentList !=Null && !VehicleAssignmentList.IsEmpty() ){
            //system.debug('provider-------------------------------------------'+provider.Service_Provider__c);
            VehicleAssignment = VehicleAssignmentList.get(0);
            DriverName = VehicleAssignment.Service_Provider__r.Name;
            VehicleNumber = VehicleAssignment.Vehicle__r.Vehicle_Registration_Number__c;
            string lat = Apexpages.currentPage().getParameters().get('latitudeval');
            string log= Apexpages.currentPage().getParameters().get('longitudeval');
            issuewith = Apexpages.currentPage().getParameters().get('issuewith');
            
            
            if(VehicleAssignmentList !=Null && !VehicleAssignmentList.IsEmpty() ){              
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
        }
        attrec = new Attachment();
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
    
    @RemoteAction
    Global Static void createCovidActivity(Map<String,String> dataMap){
        
        string temperature = dataMap.get('temperature');
        Double bodytemperature = Double.ValueOf(temperature);
        system.debug('bodytemperature'+bodytemperature);
        string inputfileids1 = dataMap.get('inputfileids');
        system.debug('inputfileids1'+inputfileids1);
        string objectname = dataMap.get('objectname');
        string symptoms = dataMap.get('symptoms');
        system.debug('symptoms'+symptoms);
        string vehicleassignid = dataMap.get('vehicleassignid');
        string vehicle = dataMap.get('vehicle');
        Id recid;
        Service_Provider__c sProvider = [select id,City__c,Site__c from Service_Provider__c where id=:dataMap.get('serviceprovider') ];
        Daily_covid_activities_Driver__c covidEntry = new Daily_covid_activities_Driver__c();
        covidEntry.Body_Temperature__c = bodytemperature;
        covidEntry.Covid_Symptoms__c = symptoms;
        // covidEntry.City__c = sProvider.City__c;
        // covidEntry.Campus__c = sProvider.Site__c;
        //covidEntry.Status__c = 'Submitted';
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
            //     system.debug('linkList'+linkList);
            ContentDocumentLink conlist = [select id,ContentDocumentId from ContentDocumentLink where id =:linkList[0].id];
            //   system.debug('conlist'+conlist.ContentDocumentId);
            string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
            String[] arrTest = temp.split('\\.');
            String st='/';
            string t=System.Label.UrlToRedirectContentDoc+ '.lightning.force.com/lightning/r/ContentDocument/'+conlist.ContentDocumentId+'/view';
            //string t=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+conlist.ContentDocumentId+'/view';
            Daily_covid_activities_Driver__c dailyRec=[select id,Aarogya_Setu_Screenshot__c,name from Daily_covid_activities_Driver__c where id=:covidEntry.Id];
            dailyRec.Aarogya_Setu_Screenshot__c=t;
            update dailyRec;
            system.debug('dailyRec'+dailyRec);
            system.debug('test'+t);
        }
    }
    @RemoteAction
    Global Static void createCovidDeclaration(Map<String,String> dataMap){ 
        //    system.debug('dataMap'+dataMap);
        string inputfileids1 = dataMap.get('inputfileids');
        string inputfileids2= dataMap.get('inputfileids2');
        string Comments = dataMap.get('Comments');
        string Comments2 = dataMap.get('Comments2');
        string vehicleassignid = dataMap.get('vehicleassignid');
        If(inputfileids1!=Null){
            Set<String>VersionidSet =New Set<String>();
            For(String s:inputfileids1.split(',')){
                VersionidSet.add(s);
            }
            For(String s:inputfileids2.split(',')){
                VersionidSet.add(s);
            }
            string certificateLinkNew ='';
            string signLinkNew='';
            
            if(inputfileids1 != Null && !String.isBlank(inputfileids1) && !String.isEmpty(inputfileids1)){
                string signLink=[Select id,ContentDocumentId From ContentVersion Where Id=:inputfileids1].ContentDocumentId;
                signLinkNew=System.Label.UrlToRedirectContentDoc+'.lightning.force.com/lightning/r/ContentDocument/'+signLink+'/view';
                //signLinkNew=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+signLink+'/view';
                //   system.debug('signLinkNew'+signLinkNew);
            }
            if(inputfileids2 != Null && !String.isBlank(inputfileids2) && !String.isEmpty(inputfileids2)){
                string certificateLink=[Select id,ContentDocumentId From ContentVersion Where Id=:inputfileids2].ContentDocumentId;
                certificateLinkNew=System.Label.UrlToRedirectContentDoc+'.lightning.force.com/lightning/r/ContentDocument/'+certificateLink+'/view';
                //  certificateLinkNew=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+certificateLink+'/view';
                //  system.debug('certificateLinkNew'+certificateLinkNew);  
            }
            system.debug('c==========='+certificateLinkNew);
            system.debug('c==========='+signLinkNew);
            system.debug('c==========='+Comments);
            system.debug('c==========='+Comments2);
            system.debug('c==========='+dataMap.get('serviceprovider'));
            
            user u=[Select id,Profile.Name ,name from user where  id=:userinfo.getUserId()];
            if(u.Profile.Name=='Shift Incharge'){
                
                
                Id Incharge = Schema.SObjectType.Covid_Declaration__c.getRecordTypeInfosByName().get('Shift Incharge').getRecordTypeId();
                
                Covid_Declaration__c c=new Covid_Declaration__c();
                c.Upload_doctors_certificate__c= certificateLinkNew;
                c.User_Name1__c= [select id , name from user where id=:userinfo.getUserId()].id;
                c.Upload_signed_declaration__c=signLinkNew;
                c.AarogyaApp__c=Comments;
                c.JoinedDuty__c=Comments2;
                c.RecordTypeId = Incharge;
                insert c;
                system.debug('cccccccccc========='+c);
            }else{
                Service_Provider__c s=[select id ,Name,City__c, Site__c from Service_Provider__c where id=:dataMap.get('serviceprovider')];
                Id Covid = Schema.SObjectType.Covid_Declaration__c.getRecordTypeInfosByName().get('Covid Declaration').getRecordTypeId();
                Covid_Declaration__c c=new Covid_Declaration__c();
                c.RecordTypeId = Covid;
                c.Upload_doctors_certificate__c= certificateLinkNew;
                c.Upload_signed_declaration__c=signLinkNew;
                c.AarogyaApp__c=Comments;
                // c.Campus__c=s.Site__c;
                //  c.City__c=s.City__c;
                c.JoinedDuty__c=Comments2;
                c.Service_Provider__c=dataMap.get('serviceprovider');
                insert c;
                system.debug('cccccccccc========='+c);
            }
            
        }
        
        
        
    }
    
    @RemoteAction
    Global Static void createcovidvvehicle(Map<String,String> dataMap){
        string issuewith1 = dataMap.get('issuewith');
        string inputfileids1 = dataMap.get('inputfileids');
        string inputfileids2= dataMap.get('inputfileids2');
        string vehicleid = dataMap.get('vehicleid'); 
        // string temp1 = dataMap.get('temp');
        string comments3 = dataMap.get('comments3');
        string comments4 = dataMap.get('comments4');
        //   string radio1 = dataMap.get('temp');
        system.debug('inputfield======================'+inputfileids1);
        // system.debug('Comments======================'+temp1);
        system.debug('comments3======================'+comments3);
        system.debug('comments4======================'+comments4);
        system.debug('inputfield======================'+vehicleid);
        If(inputfileids1!=Null){
            Set<String>VersionidSet =New Set<String>();
            For(String s:inputfileids1.split(',')){
                VersionidSet.add(s);
            }
            
            string certificateLinkNew ='';
            string signLinkNew='';
            string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
            String[] arrTest = temp.split('\\.');
            system.debug(arrTest[0]);
            if(inputfileids1 != Null && !String.isBlank(inputfileids1) && !String.isEmpty(inputfileids1)){
                string signLink=[Select id,ContentDocumentId From ContentVersion Where Id=:inputfileids1].ContentDocumentId;
                //  signLinkNew=arrTest[0]+'.lightning.force.com/lightning/r/ContentDocument/'+signLink+'/view';
                signLinkNew=System.Label.UrlToRedirectContentDoc+'.lightning.force.com/lightning/r/ContentDocument/'+signLink+'/view';
                //  signLinkNew=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+signLink+'/view';
                system.debug('signLinkNew'+signLinkNew);
            }
            
            Daily_Covid_activity_vehicle__c dcv = New Daily_Covid_activity_vehicle__c();
            
            //     dcv.Car_has_been_cleaned__c=app;
            dcv.Car_has_been_cleaned1__c=comments3;
            dcv.Sanitization_Done1__c=comments4;
            //       dcv.Sanitization_done__c = duty;
            dcv.Upload_Image__c=signLinkNew;
            dcv.Vehicle__c=vehicleid;
            dcv.Service_Provider__c=dataMap.get('serviceprovider');
            
            Insert dcv;
            system.debug('c----------------->'+dcv);
            // c.Service_Provider__c=dataMap.get('serviceprovider');
            
        }
        
    }
    
    @RemoteAction
    Global Static string createAttadance(Map<String,String> dataMap){
        
        string inputfileids1 = dataMap.get('inputfileids');
        system.debug('inputfileids1'+inputfileids1);
        string objectname = dataMap.get('objectname'); 
        string vehicleassignid = dataMap.get('vehicleassignid');
        string vehicle = dataMap.get('vehicle');
        string latitude = dataMap.get('latitude');
        string longitude = dataMap.get('longitude');
        Id recid;
        Id servceproviderid;
        if(userinfo.getUserType() != 'Standard'){
            system.debug('userinfo.getUserId--------------------'+userinfo.getUserId());
            Contact provider = [Select Id,Service_Provider__c from Contact where Id=:[Select id,contactid from user where id=:userinfo.getUserId()].ContactID];
            system.debug('provider------------serviceprovider-----------------'+provider);
            servceproviderid = provider.Service_Provider__c;
        } 
        
        system.debug('servceproviderid'+servceproviderid);
        Service_Provider__c sProvider = [select id,City__c,Site__c,Site__r.Geo_Location__c,Site__r.Geo_Location__Latitude__s, Site__r.Geo_Location__Longitude__s,Site__r.Radius__c from Service_Provider__c where id=:servceproviderid];
        system.debug('sProvider'+sProvider);
        Attendance__c atta = new Attendance__c();
        decimal  declati = sProvider.Site__r.Geo_Location__Latitude__s;
        decimal  declongti =  sProvider.Site__r.Geo_Location__Longitude__s;
        decimal radius = sProvider.Site__r.Radius__c;
        system.debug('radius 500----->>>'+radius);
        atta.Type__c ='Check in';
        atta.Login__c = system.now();
        
        atta.Geo_location__Latitude__s=  Double.valueof(latitude);
        atta.Geo_location__Longitude__s = Double.valueof(longitude);
        atta.Service_Provider__c = servceproviderid;
        
        Location loc1 = Location.newInstance(declati,declongti);
        system.debug('loc1 ---'+loc1);
        Location loc2 = Location.newInstance(atta.Geo_location__Latitude__s,  atta.Geo_location__Longitude__s);
        system.debug('loc2-------'+loc2);
        Double dist = Location.getDistance(loc1, loc2, 'km');
        system.debug('dist 511----------------'+dist);
        decimal comparedistanc = dist *1000;
        system.debug('comparedistanc ---516 --------'+comparedistanc);
        string error;
        if(comparedistanc >= radius ){
            system.debug(' Out of Range');
            error = 'OutofRange'; 
            
        }else{
            insert atta;
            system.debug('atta-------'+atta);
            recid = atta.Id;
            system.debug('recid'+recid);
            If(inputfileids1!=Null){
                Set<String>VersionidSet =New Set<String>();
                For(String s:inputfileids1.split(',')){
                    VersionidSet.add(s);
                    system.debug('VersionidSet'+VersionidSet);
                }
                List<ContentDocumentLink>linkList=New List<ContentDocumentLink>();
                if(!Test.isRunningTest()){
                    For(ContentVersion webdoc :[Select id,ContentDocumentId From ContentVersion Where Id=:VersionidSet]){
                        system.debug('webdoc'+webdoc);
                        ContentDocumentLink contentlink=new ContentDocumentLink();
                        contentlink.LinkedEntityId=recid;
                        contentlink.ShareType= 'V';
                        contentlink.Visibility = 'AllUsers';
                        contentlink.ContentDocumentId=webdoc.ContentDocumentId;
                        linkList.add(contentlink);
                    }
                    Insert linkList;
                    system.debug('linkList'+linkList);
                    ContentDocumentLink conlist = [select id,ContentDocumentId from ContentDocumentLink where id =:linkList[0].id];
                    //   system.debug('conlist'+conlist.ContentDocumentId);
                    string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
                    String[] arrTest = temp.split('\\.');
                    String st='/';
                    string t=System.Label.urlRedirrecttocontentdocument+ '.lightning.force.com/lightning/r/ContentDocument/'+conlist.ContentDocumentId+'/view';
                    //string t=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+conlist.ContentDocumentId+'/view';
                    Attendance__c dailyRec=[select id,Upload_Selfie__c,name from Attendance__c where id=:atta.Id];
                    dailyRec.Upload_Selfie__c=t;
                    update dailyRec;
                    system.debug('dailyRec'+dailyRec);
                    system.debug('test'+t);
                }
            }
        }
        return error;
    }
    @RemoteAction
    Global Static void updateAttadancestatus(Map<String,String> dataMap){
        list<Attendance__c> atenList = ([select id,Name,Status__c,Logout__c,CreatedDate,Type__c,Service_Provider__c from Attendance__c where CreatedDate=Today   AND Type__c ='Check in' AND Service_Provider__c =:dataMap.get('serviceprovider')  ]);
        system.debug('atenList520'+atenList);
        //  atenList[0].id;
        atenList[0].Type__c ='Check out';
        atenList[0].Logout__c=system.now();
        // atenList.add(atenList);
        
        update atenList;
        system.debug('atenList 528'+atenList);            
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
            //   System.debug('issue== '+i);
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