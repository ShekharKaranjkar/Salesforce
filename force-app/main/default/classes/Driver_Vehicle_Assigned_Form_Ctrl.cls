Global class Driver_Vehicle_Assigned_Form_Ctrl{ 
    public  Vehicle_Assignment__c VehicleAssignment{set;get;}
    Public List<String> objectFieldsList {Set;Get;}
    Public String vehicleassignmentrecord {Set;Get;}
    Public String fieldsJSON {Set;Get;}
    Public String checklistrecord {Set;Get;}
    Public String checkfiledfieldsJSON {Set;Get;}
    public string networkid {set;get;}
    Public String userLanguage{Set;Get;}
    Public String noerrors{Set;Get;}
    Public String buttonname{Set;Get;}
    Public decimal odometeradingcheckin{Set;Get;}
    Public Decimal odometerReading{Set;Get;}
    Public boolean flag{Set;Get;}
    Global Driver_Vehicle_Assigned_Form_Ctrl(){
        userLanguage=UserInfo.getLanguage();
        objectFieldsList = New List<String>();
           flag=true;
        //odometerReading=0.0;
        String recId = Apexpages.currentPage().getParameters().get('id');
        if(recId != Null){
            
            Id AccessorylistRecordTypeId = Schema.SObjectType.Checklist__c.getRecordTypeInfosByDeveloperName().get('Accessory_List').getRecordTypeId();
            String query='Select ';
            set<String>filedapiSet = new Set<String>();
            for(Schema.FieldSetMember f : SObjectType.Vehicle_Assignment__c.FieldSets.Accessory_Mismatch.getFields()) {
                query += f.getFieldPath() + ',';
                filedapiSet.add(f.getFieldPath());
            }
            
            query += 'Id,Service_Provider__c,Vehicle__c,Vehicle__r.Name,Charging__c,Odometer_reading__c,Photos__c,Check_In_Time__c,Check_Out_Time__c FROM Vehicle_Assignment__c where id=:recId';
            
            
            list<Vehicle_Assignment__c> VehicleAssignmentList = Database.query(query);
            VehicleAssignment = VehicleAssignmentList.get(0);
            system.debug('132'+VehicleAssignment);
            string vehicleid = VehicleAssignment.Vehicle__c;
            
            vehicleassignmentrecord=JSON.serialize(VehicleAssignmentList.get(0));
            objectFieldsList.addAll(query.split(','));
            fieldsJSON = JSON.serialize(objectFieldsList);
            String query1 = 'Select ';
            string querfields;
            for(Schema.FieldSetMember f : SObjectType.Checklist__c.FieldSets.Accessory_Mismatch.getFields()) {
                query1 += f.getFieldPath() + ',';
                if(querfields != null)
                    querfields += f.getFieldPath() + ',';
                else
                    querfields =  f.getFieldPath() + ',';
            }
            query1 += 'id,Vehicle__c from Checklist__c where RecordTypeId=:AccessorylistRecordTypeId and Vehicle__c =:vehicleid order by createddate desc limit 1';
            //list<Checklist__c> AccessoryList = Database.query(query1);
            
            list<Checklist__c> ChecklistList = Database.query(query1);
            List<String>filedlist = new List<String>();
            if(ChecklistList != Null && !ChecklistList.isEmpty())
                checklistrecord=JSON.serialize(ChecklistList.get(0));
            filedlist.addAll(querfields.split(','));
            checkfiledfieldsJSON = JSON.serialize(filedlist);
            networkid = Network.getNetworkId();
            noerrors = 'NO';
        }
    }
    
    public void updaterecord(){
        odometeradingcheckin = VehicleAssignment.Odometer_reading__c ;
        system.debug('odometeradingcheckin'+odometeradingcheckin);
        system.debug(VehicleAssignment);
        system.debug(VehicleAssignment.Id);
        system.debug(VehicleAssignment.Odometer_reading__c );
       // system.debug('chkout'+VehicleAssignment.Check_Out_Odometer_Reading__c);
        Vehicle_Assignment__c v=[select id,Odometer_reading__c from Vehicle_Assignment__c where id=: VehicleAssignment.Id];
        system.debug('v.Odometer_reading__c'+v.Odometer_reading__c); 
        system.debug('v'+v); 
        try{            
            if(VehicleAssignment.Check_Out_Time__c==null){
                update VehicleAssignment;
            }else{
                
                VehicleAssignment.Odometer_reading__c=odometerReading;
                update VehicleAssignment;
            }
            
            
            //  update VehicleAssignment;
            String inputfileids = Apexpages.currentPage().getParameters().get('fileids');
            
            Id AccessorylistRecordTypeId = Schema.SObjectType.Checklist__c.getRecordTypeInfosByDeveloperName().get('Accessory_List').getRecordTypeId();
            Id MismatchRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByDeveloperName().get('Accessory_Mismatch').getRecordTypeId();
            Vehicle_Assignment__c  vehicleassignrecord= VehicleAssignment;
            
            String query1 = 'Select ';
            for(Schema.FieldSetMember f : SObjectType.Checklist__c.FieldSets.Accessory_Mismatch.getFields()) {
                query1 += f.getFieldPath() + ',';
            }
            System.debug('AccessorylistRecordTypeId '+ AccessorylistRecordTypeId);
            System.debug('vehicleassignrecord.Vehicle__c '+ vehicleassignrecord.Vehicle__c);
            String vehicleId =vehicleassignrecord.Vehicle__c;
            system.debug('Step test'+[SELECT Id,RecordType.Name,Vehicle__c FROM Checklist__c]);
            query1 += 'id,Vehicle__c from Checklist__c where RecordTypeId=:AccessorylistRecordTypeId and Vehicle__c =:vehicleId order by createddate desc limit 1';
            //list<Checklist__c> AccessoryList = Database.query(query1);
            System.debug('Database.query(query1) '+ Database.query(query1));
            list<Checklist__c> AccessoryList = Database.query(query1);
            
            if(AccessoryList != null && !AccessoryList.isempty()){
                
                String mismatchfileds ='';
                Boolean isexecute = false;
                if(vehicleassignrecord.First_Aid_kit__c != 'Yes' && AccessoryList[0].First_Aid_kit__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'First Aid kit ,';isexecute= true;}
                if(vehicleassignrecord.Mats__c != 'Yes' && AccessoryList[0].Mats__c == 'Yes' ){
                    mismatchfileds = mismatchfileds +'Mats ,';isexecute= true;}
                if(vehicleassignrecord.Torch__c != 'Yes' && AccessoryList[0].Torch__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Torch ,';isexecute= true;}
                if(vehicleassignrecord.Umbrella__c != 'Yes' && AccessoryList[0].Umbrella__c == 'Yes' ){
                    mismatchfileds = mismatchfileds +'Umbrella ,';isexecute= true;}
                if(vehicleassignrecord.Physical_Condition_scratches_dents__c != 'Yes' &&  AccessoryList[0].Physical_Condition_scratches_dents__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Physical Condition scratches dents ,';isexecute= true;}
                if(vehicleassignrecord.Spare_Wheel__c != 'Yes' && AccessoryList[0].Spare_Wheel__c == 'Yes' ){
                    mismatchfileds = mismatchfileds +'Spare Wheel ,';isexecute= true;}
                if(vehicleassignrecord.Mobile_Charger__c != 'Yes' && AccessoryList[0].Mobile_Charger__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Mobile Charger ,';isexecute= true;}
                if(vehicleassignrecord.Camera__c != 'Yes' && AccessoryList[0].Camera__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Camera ,';isexecute= true;}
                if(vehicleassignrecord.Perfume__c != 'Yes' && AccessoryList[0].Perfume__c == 'Yes'){
                    mismatchfileds = mismatchfileds +  'Perfume ,';isexecute= true;}
                if(vehicleassignrecord.Fire_extinguisher__c != 'Yes' && AccessoryList[0].Fire_extinguisher__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'Fire_extinguisher ,';isexecute= true;}
                if(vehicleassignrecord.Sleep_Alert__c != 'Yes' && AccessoryList[0].Sleep_Alert__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'Sleep Alert ,';isexecute= true;}
                if(vehicleassignrecord.Branding__c != 'Yes' && AccessoryList[0].Branding__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'Branding,';isexecute= true;}
                if(vehicleassignrecord.Telematics__c != 'Yes' && AccessoryList[0].Telematics__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Telematics ';isexecute= true;}
                
                
                if(vehicleassignrecord.AIS_140_GPS__c != 'Yes' && AccessoryList[0].AIS_140_GPS__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'AIS 140 GPS ,';isexecute= true;}
                if(vehicleassignrecord.AIS_140_Certificate__c != 'Yes' && AccessoryList[0].AIS_140_Certificate__c == 'Yes' ){
                    mismatchfileds = mismatchfileds +'AIS 140 Certificate ,';isexecute= true;}
                if(vehicleassignrecord.Cleanliness__c != 'Yes' && AccessoryList[0].Cleanliness__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Cleanliness ,';isexecute= true;}
                if(vehicleassignrecord.Door_Lock_Windows__c != 'Yes' && AccessoryList[0].Door_Lock_Windows__c == 'Yes' ){
                    mismatchfileds = mismatchfileds +'Door Lock Windows ,';isexecute= true;}
                if(vehicleassignrecord.Mirrors__c != 'Yes' &&  AccessoryList[0].Mirrors__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Mirrors ,';isexecute= true;}
                if(vehicleassignrecord.Head_Lights__c != 'Yes' && AccessoryList[0].Head_Lights__c == 'Yes' ){
                    mismatchfileds = mismatchfileds +'Head Lights ,';isexecute= true;}
                if(vehicleassignrecord.Hazard_Lights_Parking_lights__c != 'Yes' && AccessoryList[0].Hazard_Lights_Parking_lights__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Hazard Lights Parking lights ,';isexecute= true;}
                if(vehicleassignrecord.Charging_Cable__c != 'Yes' && AccessoryList[0].Charging_Cable__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Charging Cable ,';isexecute= true;}
                if(vehicleassignrecord.Charging_Socket__c != 'Yes' && AccessoryList[0].Charging_Socket__c == 'Yes'){
                    mismatchfileds = mismatchfileds +  'Charging Socket ,';isexecute= true;}
                if(vehicleassignrecord.Wipers_Washers_Wiper_Blades__c != 'Yes' && AccessoryList[0].Wipers_Washers_Wiper_Blades__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'Wipers Washers Wiper Blades ,';isexecute= true;}
                if(vehicleassignrecord.Tyres__c != 'Yes' && AccessoryList[0].Tyres__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'Tyres ,';isexecute= true;}
                if(vehicleassignrecord.Triangle__c != 'Yes' && AccessoryList[0].Triangle__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'Triangle,';isexecute= true;}
                if(vehicleassignrecord.Internal_Lights__c != 'Yes' && AccessoryList[0].Internal_Lights__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Internal Lights ';isexecute= true;}
                
                
                
                if(vehicleassignrecord.Brake_Lights__c != 'Yes' && AccessoryList[0].Brake_Lights__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Brake Lights ,';isexecute= true;}
                if(vehicleassignrecord.Spare_Tyre__c != 'Yes' && AccessoryList[0].Spare_Tyre__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Spare Tyre ,';isexecute= true;}
                if(vehicleassignrecord.Steering__c != 'Yes' && AccessoryList[0].Steering__c == 'Yes'){
                    mismatchfileds = mismatchfileds +  'Steering ,';isexecute= true;}
                if(vehicleassignrecord.BrakesHandBrakes__c != 'Yes' && AccessoryList[0].BrakesHandBrakes__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'BrakesHandBrakes ,';isexecute= true;}
                if(vehicleassignrecord.Horn__c != 'Yes' && AccessoryList[0].Horn__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'Horn ,';isexecute= true;}
                if(vehicleassignrecord.Head_Restraints__c != 'Yes' && AccessoryList[0].Head_Restraints__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'Head Restraints,';isexecute= true;}
                if(vehicleassignrecord.Seats__c != 'Yes' && AccessoryList[0].Seats__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Seats ';isexecute= true;}
                
                if(vehicleassignrecord.Safety_Belts__c != 'Yes' && AccessoryList[0].Safety_Belts__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'Safety Belts ,';isexecute= true;}
                if(vehicleassignrecord.Jack__c != 'Yes' && AccessoryList[0].Jack__c == 'Yes' ){
                    mismatchfileds = mismatchfileds + 'Jack,';isexecute= true;}
                if(vehicleassignrecord.Jack_Rod__c != 'Yes' && AccessoryList[0].Jack_Rod__c == 'Yes'){
                    mismatchfileds = mismatchfileds + 'Jack Rod ';isexecute= true;}
                mismatchfileds = mismatchfileds.removeEnd(',');
                if(isexecute){
                    Issues__c i = New Issues__c();
                    i.RecordTypeId = MismatchRecordTypeId;
                    i.Mismatch_Accessories__c= mismatchfileds;
                    i.Service_Provider__c = vehicleassignrecord.Service_Provider__c;
                    i.Vehicle__c = vehicleassignrecord.Vehicle__c;
                    i.Vehicle_Assignment__c = vehicleassignrecord.Id;
                    Insert i;
                }
            } 
        }catch(exception e){
            noerrors ='Yes';
            Debug_Log__c debug=new Debug_Log__c();
            debug.Class_Name__c='Driver_Vehicle_Assigned_Form_Ctrl';
            debug.Method_Name__c='updaterecord';
            debug.User_Id__c=String.valueof(userinfo.getUserId());
            debug.Error_Message__c=e.getMessage( ) + ' LINE_NUMBER : ' + e.getLineNumber( ) + 'STACKTRACE : ' + e.getStacktraceString( );
            insert debug;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,Label.Error_found_please_contact_system_admin));
            
        }
    }
    public void delcontentfiles(){
        String contentversionId = Apexpages.currentPage().getParameters().get('firstParam');
        List<ContentVersion> docList = [SELECT Id,ContentDocumentid FROM ContentVersion where id=:contentversionId];
        // system.debug('contentDocumentId ' + contentDocumentId);
        DELETE [SELECT Id FROM ContentDocument WHERE Id =:docList[0].ContentDocumentid];
    }
    @RemoteAction
    Global Static Boolean updateCheckIn_CheckOutTime(String recordid,Boolean checkin,Boolean checkout){
        try{
            Vehicle_Assignment__c  vehicleassignrecord= new Vehicle_Assignment__c();
            vehicleassignrecord.Id= recordid;
            if(checkin){
                vehicleassignrecord.Check_In_Time__c = System.Now();
                update vehicleassignrecord;
            }
            if(checkout){
                vehicleassignrecord.Check_Out_Time__c = system.now();
                update vehicleassignrecord;
            }
            
            
            return true;
        }catch(exception e){
            return false;
        }
        
    }
    
    public void updatechekincheckout(){
        Vehicle_Assignment__c  vehicleassignrecord= VehicleAssignment;
        String checkin = Apexpages.currentPage().getParameters().get('fileids1');
        String checkout = Apexpages.currentPage().getParameters().get('fileids2');
        system.debug('!@!'+checkin);
        system.debug('#@@'+checkout);
        try{
            if(checkin == 'True'){
                vehicleassignrecord.Check_In_Time__c = System.Now();
                update vehicleassignrecord;
                Vehicle__c vc = New Vehicle__c();
                vc.id= vehicleassignrecord.Vehicle__c;
                vc.Is_Available__c = false;
                update vc;
                buttonname = 'CheckIn';
            }
            if(checkout == 'True'){
                Vehicle_Assignment__c v=[select id,Odometer_reading__c from Vehicle_Assignment__c where id=: VehicleAssignment.Id];
                system.debug('v.Odometer_reading__c'+v.Odometer_reading__c); 
                odometerReading=v.Odometer_reading__c;
                
                    
                    vehicleassignrecord.Check_Out_Time__c = system.now();
                 vehicleassignrecord.Odometer_reading__c= odometerReading;
                    system.debug('v.Odometer_reading__c'+    v.Odometer_reading__c);
                    system.debug('odometerReading'+    odometerReading);
                    //vehicleassignrecord.Check_Out_Time__c = system.now();
                    update vehicleassignrecord;
                    Vehicle__c vc = New Vehicle__c();
                    vc.id= vehicleassignrecord.Vehicle__c;
                    vc.Is_Available__c = true;
                    update vc;
                    Service_Provider__c sp = new Service_Provider__c();
                    sp.Id=vehicleassignrecord.Service_Provider__c;
                    sp.vehicle_Assigned_To__c = null;
                    sp.Is_Available__c   = true;
                    update sp;
                    buttonname = 'CheckOut';
                             flag=true;
                
                
                
            }
            
        }catch(exception e){
            noerrors ='checkincheckouttimeerror';
            Debug_Log__c debug=new Debug_Log__c();
            debug.Class_Name__c='Driver_Vehicle_Assigned_Form_Ctrl';
            debug.Method_Name__c='updatechekincheckout';
            debug.User_Id__c=String.valueof(userinfo.getUserId());
            debug.Error_Message__c=e.getMessage( ) + ' LINE_NUMBER : ' + e.getLineNumber( ) + 'STACKTRACE : ' + e.getStacktraceString( );
            insert debug;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,Label.Error_found_please_contact_system_admin));
            
        }
    }
}