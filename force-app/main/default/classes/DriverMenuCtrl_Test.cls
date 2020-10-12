@IsTest(seealldata=true)
public class DriverMenuCtrl_Test {
    @IsTest
    Static void controllerTestMethod(){
        Profile p = [select id from profile where name='System Administrator'];
        Profile psp = [select id from profile where name='SP'];
        //Create a new sys admin user and do an insert  
        User u = new User(alias = 'standt', email='no@testorg.com',
                          emailencodingkey='UTF-8', lastname='Testo', languagelocalekey='en_US', localesidkey='en_US', profileid = p.Id,
                          timezonesidkey='America/Los_Angeles', username='User@test.com');
        
        
        User u1 = [Select u.Profile.Name, u.ProfileId, u.Name, u.Id From User u where u.Profile.Name = 'System Administrator' limit 1];
        system.debug('u1+'+u1);
        
        account ac=new account();
        ac.Name='rag';
        ac.Lithium_Billing_Entity__c='Pune';
        ac.Lithium_Bank_Account__c='State Bank';
        insert ac;
        
        City__c c=new City__c();
        c.Account__c=ac.id;
        insert c;
        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=ac.id;
        Campus.Lithium_Bank_Account__c='State Bank';
        Campus.PAN__c='XXXXX1234X';
        Campus.GSTN__c='qwertyuiopasdfg';
        Campus.Invoice_Creation_Date__c=system.today();
        Campus.Payment_Terms__c= '30';
        Campus.Billing_City__c='mrt';
        Campus.Billing_State_Province__c='tp';
        Campus.Billing_Street__c='ee';
        Campus.Billing_Zip_Postal_Code__c='ff';
        Campus.Shipping_City__c='ff';
        Campus.Shipping_State_Province__c='ff';
        Campus.Shipping_Street__c='ff';
        Campus.Site_Supervisor__c=u1.Id;
        Campus.Shipping_Zip_Postal_Code__c='ff';
        Campus.Geo_Location__Latitude__s=11.7958;
        Campus.Geo_Location__Longitude__s=77.7989;
        Campus.Radius__c =500;
        insert Campus;
        

        Vehicle__c v1 = new Vehicle__c();
        v1.Site__c=campus.Id;
        v1.City__c = c.id;
        v1.Finance_Type__c ='Owned';
        v1.Delivery_Date__c = system.today().addDays(3);
        v1.Financer__c = 'Intelligrow';
        v1.Name = 'MP09213421';
        v1.VIN_Number__c='12345678901234567';
        v1.Re_enter_VIN_Number__c='12345678901234567';
        v1.Lease_Loan_Amount__c= 1000;
        v1.Status1__c='New';
        v1.Lease_Loan_Start_Date__c = system.today();
        v1.Lease_Loan_End_Date__c= system.today().addDays(3);
        v1.OEM__c ='Tata';
        v1.Manufacturing_Date__c = system.today().addDays(4);
        v1.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v1.Date_of_Purchase__c=system.today().addDays(2);
        v1.RC_Registration_Date__c = system.today().addDays(1);
        
        // vhlist.add(v1);
        insert v1;
        
        String accessRecordTypeId = [Select Id From RecordType Where SobjectType = 'Checklist__c' and Name = 'Accessory List'].Id;
        Checklist__c check = new Checklist__c();
        check.Torch__c = 'Yes';
        check.Mats__c = 'Yes';
        //First_Aid_kit__c
        check.RecordTypeId = accessRecordTypeId;
        check.Vehicle__c = v1.Id;
        //insert check;
        
        
        Service_Provider__c sp=new Service_Provider__c();
        sp.Name='uattest';
        sp.Last_Name__c = 'test uat';
        sp.Driving_License_Number__c='1134567899123456';
        sp.Address__c='109,gx';
        sp.Phone_Number__c='9192734422';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        sp.Phone__c=1234567899;
       sp.Vehicle_Assigned_To__c=v1.id;
        sp.Status__c='Active';
        
        insert sp;
      
        Contact provider = new Contact();
        provider.LastName = 'st';
        provider.AccountId =ac.id;
        provider.Service_Provider__c = sp.id;
        provider.MobilePhone =sp.Phone_Number__c;
        insert provider;   
        //u1.Id =u.Id;
       // u1.ContactId = provider.id;
         User usrObj = new User();
        usrObj.LastName = 'TestLast';
        usrObj.FirstName='TestFirst';
        usrObj.Alias = 'tst';
        usrObj.Email = 'test@test.com';
        usrObj.Username = 'testkalasinj@gmail.com.staging';
        usrObj.ProfileId = psp.id;
        usrObj.TimeZoneSidKey = 'GMT';
        usrObj.LanguageLocaleKey = 'en_US';
        usrObj.EmailEncodingKey = 'UTF-8';
        usrObj.LocaleSidKey = 'en_US';
        usrObj.IsActive=True;
        usrObj.ContactId = provider.Id;
        usrObj.MobilePhone =provider.MobilePhone;
        //usrObj.userRoleId='00EC0000001EkqFMAS';
        //usrObj.UserRole.Name='CRM Rep';
        insert usrObj;
   
        system.debug('usrObj'+usrObj);
          id servceproviderid = usrObj.contact.Service_Provider__c;
        
        CollaborationGroup cg1 = new CollaborationGroup();
        cg1.Name = 'MTComplianceandCOOId from Test Class';
        cg1.CollaborationType ='Public';
        insert cg1;
        
        Vehicle_Assignment__c va=new Vehicle_Assignment__c();
        
        va.Service_Provider__c=sp.id;
        va.Vehicle__c=v1.id;
        va.Check_In_Time__c = system.now();
        va.First_Aid_kit__c = 'No';
        va.Mats__c = 'No';
        va.Torch__c = 'No';
        va.Umbrella__c = 'No' ;
        va.Physical_Condition_scratches_dents__c = 'No';
        va.Spare_Wheel__c = 'No' ;
        va.Mobile_Charger__c = 'No';
        va.Camera__c = 'No';
        va.Perfume__c = 'No';
        va.Fire_extinguisher__c = 'No' ;
        va.Sleep_Alert__c = 'No' ;
        va.Branding__c = 'No' ;
        va.Telematics__c = 'No';             
        va.AIS_140_GPS__c = 'No';
        va.AIS_140_Certificate__c = 'No' ;
        va.Cleanliness__c = 'No';
        va.Door_Lock_Windows__c = 'No' ;
        va.Mirrors__c = 'No';
        va.Head_Lights__c = 'No' ;
        va.Hazard_Lights_Parking_lights__c = 'No';
        va.Charging_Cable__c = 'No';
        va.Charging_Socket__c = 'No';
        va.Wipers_Washers_Wiper_Blades__c = 'No' ;
        va.Tyres__c = 'No' ;
        va.Triangle__c = 'No' ;
        va.Internal_Lights__c = 'No';         
        va.Brake_Lights__c = 'No';
        va.Spare_Tyre__c = 'No';
        va.Steering__c = 'No';
        va.BrakesHandBrakes__c = 'No'; 
        va.Horn__c = 'No' ;
        va.Head_Restraints__c = 'No' ;
        va.Seats__c = 'No';
        va.Safety_Belts__c = 'No' ;
        va.Jack__c = 'No' ;
        va.Jack_Rod__c = 'No';
        
        Test.startTest();
        insert va;
        Id AccessorylistRecordTypeId = Schema.SObjectType.Checklist__c.getRecordTypeInfosByDeveloperName().get('Accessory_List').getRecordTypeId();
        
        Checklist__c acc = new Checklist__c();
        acc.RecordTypeId = AccessorylistRecordTypeId;
        acc.First_Aid_kit__c = 'Yes';
        acc.Mats__c = 'Yes';
        acc.Torch__c = 'Yes';
        acc.Umbrella__c = 'Yes' ;
        acc.Physical_Condition_scratches_dents__c = 'Yes';
        acc.Spare_Wheel__c = 'Yes' ;
        acc.Mobile_Charger__c = 'Yes';
        acc.Camera__c = 'Yes';
        acc.Perfume__c = 'Yes';
        acc.Fire_extinguisher__c = 'Yes' ;
        acc.Sleep_Alert__c = 'Yes' ;
        acc.Branding__c = 'Yes' ;
        acc.Telematics__c = 'Yes';             
        acc.AIS_140_GPS__c = 'Yes';
        acc.AIS_140_Certificate__c = 'Yes' ;
        acc.Cleanliness__c = 'Yes';
        acc.Door_Lock_Windows__c = 'Yes' ;
        acc.Mirrors__c = 'Yes';
        acc.Head_Lights__c = 'Yes' ;
        acc.Hazard_Lights_Parking_lights__c = 'Yes';
        acc.Charging_Cable__c = 'Yes';
        acc.Charging_Socket__c = 'Yes';
        acc.Wipers_Washers_Wiper_Blades__c = 'Yes' ;
        acc.Tyres__c = 'Yes' ;
        acc.Triangle__c = 'Yes' ;
        acc.Internal_Lights__c = 'Yes';         
        acc.Brake_Lights__c = 'Yes';
        acc.Spare_Tyre__c = 'Yes';
        acc.Steering__c = 'Yes';
        acc.BrakesHandBrakes__c = 'Yes'; 
        acc.Horn__c = 'Yes' ;
        acc.Head_Restraints__c = 'Yes' ;
        acc.Seats__c = 'Yes';
        acc.Safety_Belts__c = 'Yes' ;
        acc.Jack__c = 'Yes' ;
        acc.Jack_Rod__c = 'Yes';
        acc.Physical_Condition_scratches_dents__c = 'Yes';
        acc.Vehicle__c = v1.id;
        insert acc;
        Issues__c issue= new Issues__c();
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Issues__c' and Name = 'Breakdown'].Id;
        
        issue.Vehicle__c = v1.id;
        issue.Service_Provider__c = sp.id;
        issue.RecordTypeId = strRecordTypeId;
        issue.Current_Location__Latitude__s=12.9569;
        issue.Current_Location__Longitude__s=77.7011;
        insert issue;
        
        
        Id MismatchRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByDeveloperName().get('Accessory_Mismatch').getRecordTypeId();
        Issues__c issue1= new Issues__c();
        issue1.Vehicle__c = v1.id;
        issue1.RecordTypeId = MismatchRecordTypeId;
        issue1.Service_Provider__c = sp.id;
        issue1.Current_Location__Latitude__s=12.9569;
        issue1.Current_Location__Longitude__s=77.7011;
        
        insert issue1;   
        
        
        ContentVersion cv=new Contentversion();
        cv.title='ABC';
        cv.PathOnClient ='test';
        Blob b=Blob.valueOf('Unit Test Attachment Body');
        cv.versiondata=EncodingUtil.base64Decode('Unit Test Attachment Body');
        insert cv;
        
        ContentVersion cv1=new Contentversion();
        cv1.title='ABC';
        cv1.PathOnClient ='test';
        Blob b1=Blob.valueOf('Unit Test Attachment Body');
        cv1.versiondata=EncodingUtil.base64Decode('Unit Test Attachment Body');
        insert cv1;
        
        ContentVersion cv2=new Contentversion();
        cv2.title='ABC';
        cv2.PathOnClient ='test';
        Blob b2=Blob.valueOf('Unit Test Attachment Body');
        cv2.versiondata=EncodingUtil.base64Decode('Unit Test Attachment Body');
        insert cv2; 
        System.runAs(usrObj){
            
        DriverMenuCtrl ctrl1 = New DriverMenuCtrl();
        }
         DriverMenuCtrl ctrl = New DriverMenuCtrl();
        System.currentPageReference().getParameters().put('issuewith', 'Brake');
        System.currentPageReference().getParameters().put('inputfileids', cv.id);
        System.currentPageReference().getParameters().put('inputfileids1', cv2.id);
        System.currentPageReference().getParameters().put('objectname', 'ServiceRequest');
        System.currentPageReference().getParameters().put('requesttype', '');
        System.currentPageReference().getParameters().put('latitude', '12.0000');
        System.currentPageReference().getParameters().put('longitude', '70.0000');
        System.currentPageReference().getParameters().put('firstParam', cv.id);
        System.currentPageReference().getParameters().put('recid', sp.id);
        //ctrl.createIssueORservicerequestRec();
        DriverMenuCtrl.uploadfiles('base64Data', 'filetName',Network.getNetworkId(),issue1.Id);
        DriverMenuCtrl.getissuewithrecords();
        Map<String,String> dataMap = new Map<String,String>{'issuewith'=>'Brake','inputfileids'=>cv.id,'objectname'=>'ServiceRequest','requesttype'=>'',
            'latitude'=> '12.0000','longitude'=>'70.0000','serviceprovider'=>sp.Id,'vehicle'=>v1.Id};
                DriverMenuCtrl.createisseus(dataMap);
        
        ctrl.delcontentfiles();
        System.currentPageReference().getParameters().put('id',va.id );
        System.currentPageReference().getParameters().put('fileids',cv1.id );
        System.currentPageReference().getParameters().put('firstParam',cv1.id );
      /*  Driver_Vehicle_Assigned_Form_Ctrl vctrl = new Driver_Vehicle_Assigned_Form_Ctrl();
        vctrl.VehicleAssignment = va;
        vctrl.updaterecord();
        vctrl.delcontentfiles();
        vctrl.updatechekincheckout();*/
        
      //  Driver_Vehicle_Assigned_Form_Ctrl.updateCheckIn_CheckOutTime(va.id, true, true);
        
        dataMap = new Map<String,String>{'issuewith'=>'Brake','inputfileids'=>cv.id,'objectname'=>'ServiceRequest','requesttype'=>'',
            'latitude'=> '','longitude'=>'','serviceprovider'=>sp.Id,'vehicle'=>v1.Id};
                
       System.currentPageReference().getParameters().put('temperature', '98');
        System.currentPageReference().getParameters().put('vehicleassignid', va.id);
        System.currentPageReference().getParameters().put('symptoms', 'Yes');
       Map<String,String> dataMapNew = new Map<String,String>{'temperature'=>'98','inputfileids'=>cv2.id,'symptoms'=>'Yes','objectname'=>'Daily_covid_activities_Driver__c','serviceprovider'=>sp.Id};
       DriverMenuCtrl.createCovidActivity(dataMapNew);
            
        DriverMenuCtrl.createisseus(dataMap);
        System.currentPageReference().getParameters().put('firstParam','' );
		ctrl.delcontentfiles();
        DriverMenuCtrl.uploadfiles('base64Data', '',Network.getNetworkId(),issue1.Id);
        
        
                System.currentPageReference().getParameters().put('comments1', 'Yes');
        System.currentPageReference().getParameters().put('comments2', 'Yes');
        System.currentPageReference().getParameters().put('vehicleid', v1.id);
        
        
        Map<String,String> dataMapNew1 = new Map<String,String>{'Comments'=>'Yes','Comments2'=>'Yes','inputfileids'=>cv2.id,'inputfileids2'=>cv2.id,'objectname'=>'Daily_Covid_activity_vehicle__c','serviceprovider'=>sp.Id};
            DriverMenuCtrl.createCovidDeclaration(dataMapNew1);

                System.currentPageReference().getParameters().put('comments3', 'Yes');
        System.currentPageReference().getParameters().put('comments4', 'Yes');
        System.currentPageReference().getParameters().put('vehicleid', v1.id);
        
        
        Map<String,String> dataMapNew2 = new Map<String,String>{'Comments3'=>'Yes','Comments4'=>'Yes','inputfileids'=>cv2.id,'inputfileids2'=>cv2.id,'objectname'=>'Daily_Covid_activity_vehicle__c','serviceprovider'=>sp.Id,'vehicleid'=>v1.id};
            DriverMenuCtrl.createcovidvvehicle(dataMapNew2);
        
            ContentVersion contentVersionInsert = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true
        );
        insert contentVersionInsert;  
         List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        String addressProofNm = documents[0].Title;
        
        //Create ContentDocumentLink  Record
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = sp.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        Map<String,String> dataMapatten = new Map<String,String>{'inputfileids'=>contentVersionInsert.id,'objectname'=>'Attendance__c','serviceprovider'=>sp.Id,'latitude'=>'11.79792','longitude'=>'77.79794'};
            System.runAs(usrObj){
               DriverMenuCtrl.createAttadance(dataMapatten); 
            }
            
        
      
        Map<String,String> dataMapattenupdaate = new Map<String,String>{'serviceprovider'=>sp.Id};
             System.runAs(usrObj){
                     DriverMenuCtrl.updateAttadancestatus(dataMapattenupdaate);
             }
        System.currentPageReference().getParameters().put('firstParam','' );

        
        
        
        Test.stopTest();
    }
}