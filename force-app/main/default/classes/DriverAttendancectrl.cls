Global class DriverAttendancectrl {
 Public Double latitude{Set;Get;}
    Public Double longitude{Set;Get;}
    Public String DriverName{Set;Get;}
    Public String VehicleNumber{Set;Get;}
    Public String issuewith{Set;Get;}
    Public String inputfileids{Set;Get;}
    Public Double latitudeval{Set;Get;}
    Public Double longitudeval{Set;Get;}
    Public String userLanguage{Set;Get;}
 
    public List<Notification__c> notificationList{Set;Get;}
   public List<Attendance__c>  todaysAttendanceList{Set;Get;}
      public Boolean showNotification{set;get;}
    
      public Boolean showcheckoutrecords{set;get;}
    public List<Attendance__c> todaysAttendanceListcheckout{Set;Get;}
   
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
      public Boolean showTodaysAttendance{set;get;}
    public Daily_covid_activities_Driver__c dailyDriverCovid{Set;Get;}
    Public DriverAttendancectrl(){
        //showHeaderOrnot=false;
        userLanguage=UserInfo.getLanguage();
        List<Vehicle_Assignment__c>VehicleAssignmentList = New  List<Vehicle_Assignment__c>();
        if(userinfo.getUserType() != 'Standard'){
            Contact provider = [Select Id,Service_Provider__c from Contact where Id=:[Select id,contactid from user where id=:userinfo.getUserId()].ContactID];
            VehicleAssignmentList = [Select Id,Name,Vehicle__c,Service_Provider__c,Service_Provider__r.Name,Vehicle__r.Vehicle_Registration_Number__c from Vehicle_Assignment__c where Vehicle__r.Vehicle_Registration_Number__c !=null AND Service_Provider__c =:provider.Service_Provider__c AND Check_Out_Time__c = null Order By Createddate desc Limit 1];
            // if(VehicleAssignmentList.isempty())
 todaysAttendanceList = [select id,Name,Lithium_ID__c,Login__c,Status__c,Type__c from Attendance__c where  CreatedDate = Today AND Service_Provider__c =: provider.Service_Provider__c];  
         todaysAttendanceListcheckout = [select id,Name,Lithium_ID__c,Login__c,Status__c,Type__c from Attendance__c where  CreatedDate = Today AND Service_Provider__c =: provider.Service_Provider__c AND Type__c ='Check out'];
               
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
            
             notificationList = [select id,Name,User_Id__c,User_Id__r.Name,Message__c from Notification__c where createdDate=Today  AND User_Id__c = :userinfo.getUserId() Order By Createddate desc ];
           system.debug('notificationList-----------'+notificationList);
            if(notificationList !=null && !notificationList.isempty()){
                showNotification = true;
                system.debug('showNotification'+showNotification); 
            } else{
                showNotification = false;
                system.debug('showNotification'+showNotification);
            }
            
            
            
            list<Attendance__c> attenList = [select id from Attendance__c where Service_Provider__c =:VehicleAssignment.Service_Provider__c AND CreatedDate = Today order by createddate desc limit 1];
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
            
             
            //if(([select id from Daily_covid_activities_Driver__c where Driver__c =:VehicleAssignment.Service_Provider__c AND CreatedDate = TODAY Limit 1]).length > 0){
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
        }
    
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
    Global Static string createAttadance(Map<String,String> dataMap){
        
        string inputfileids1 = dataMap.get('inputfileids');
        system.debug('inputfileids1'+inputfileids1);
        string objectname = dataMap.get('objectname');
        string symptoms = dataMap.get('symptoms');
        system.debug('symptoms'+symptoms);
        string vehicleassignid = dataMap.get('vehicleassignid');
        string vehicle = dataMap.get('vehicle');
        string latitude = dataMap.get('latitude');
        string longitude = dataMap.get('longitude');
        Id recid;
        Service_Provider__c sProvider = [select id,City__c,Site__c,Site__r.Geo_Location__c,Site__r.Geo_Location__Latitude__s, Site__r.Geo_Location__Longitude__s,Site__r.Radius__c from Service_Provider__c where id=:dataMap.get('serviceprovider') ];
        Attendance__c atta = new Attendance__c();
        decimal  declati = sProvider.Site__r.Geo_Location__Latitude__s;
        decimal  declongti =  sProvider.Site__r.Geo_Location__Longitude__s;
        decimal radius = sProvider.Site__r.Radius__c;
        system.debug('radius 500----->>>'+radius);
        atta.Type__c ='Check in';
        atta.Login__c = system.now();
        
        atta.Geo_location__Latitude__s=  Double.valueof(latitude);
        atta.Geo_location__Longitude__s = Double.valueof(longitude);
        atta.Service_Provider__c = dataMap.get('serviceprovider');
        
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
                contentlink.Visibility = 'AllUsers';
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
            string t=System.Label.urlRedirrecttocontentdocument+ '.lightning.force.com/lightning/r/ContentDocument/'+conlist.ContentDocumentId+'/view';
            //string t=arrTest[0].substring(0, arrTest[0].length()-3)+ '.lightning.force.com/lightning/r/ContentDocument/'+conlist.ContentDocumentId+'/view';
            Attendance__c dailyRec=[select id,Upload_Selfie__c,name from Attendance__c where id=:atta.Id];
            dailyRec.Upload_Selfie__c=t;
            update dailyRec;
            system.debug('dailyRec'+dailyRec);
            system.debug('test'+t);
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

          
    
  
}