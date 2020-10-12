@isTest(seealldata=true)
public class DailyCovidActivityVehicle_Test {
    @isTest
    Static void controllerTestMethod(){
        Profile p = [select id from profile where name='System Administrator'];
        
        //Create a new sys admin user and do an insert  
        User u = new User(alias = 'standt', email='noEmail@testorg.com',
                          emailencodingkey='UTF-8', lastname='Testo', languagelocalekey='en_US', localesidkey='en_US', profileid = p.Id,
                          timezonesidkey='America/Los_Angeles', username='MrTestUser@testorg.com');
        
        
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
        campus.PAN__c='XXXXX1234X';
        campus.GSTN__c='qwertyuiopasdfg';
        campus.Invoice_Creation_Date__c=system.today();
        campus.Payment_Terms__c= '30';
        campus.Billing_City__c='mrt';
        campus.Billing_State_Province__c='tp';
        campus.Billing_Street__c='ee';
        campus.Billing_Zip_Postal_Code__c='ff';
        campus.Shipping_City__c='ff';
        campus.Shipping_State_Province__c='ff';
        campus.Shipping_Street__c='ff';
        campus.Shipping_Zip_Postal_Code__c='ff';
        insert campus;
        
        
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
        Service_Provider__c sp=new Service_Provider__c();
        sp.Name='test';
        sp.Last_Name__c = 'test1';
        sp.Driving_License_Number__c='1234567890123456';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992734422';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        sp.Phone__c=1234567890;
        sp.Vehicle_Assigned_To__c=v1.id;
        
        insert sp;
        
        Daily_Covid_activity_vehicle__c dcv =new Daily_Covid_activity_vehicle__c();
        dcv.Vehicle__c=v1.id;
        dcv.Car_has_been_cleaned1__c='yes';
        insert dcv;
        
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
        
        DailyCovidActivityVehicle dv = new DailyCovidActivityVehicle();
   System.currentPageReference().getParameters().put('issuewith', 'Brake');
        System.currentPageReference().getParameters().put('inputfileids', cv.id);
        System.currentPageReference().getParameters().put('inputfileids1', cv2.id);
        System.currentPageReference().getParameters().put('objectname', 'ServiceRequest');
        System.currentPageReference().getParameters().put('requesttype', '');
        System.currentPageReference().getParameters().put('latitude', '12.0000');
        System.currentPageReference().getParameters().put('longitude', '70.0000');
        System.currentPageReference().getParameters().put('firstParam', cv.id);
        System.currentPageReference().getParameters().put('recid', sp.id);
        
     
        Map<String,String> dataMap = new Map<String,String>{'issuewith'=>'Brake','inputfileids'=>cv.id,'objectname'=>'ServiceRequest','requesttype'=>'',
            'latitude'=> '12.0000','longitude'=>'70.0000','serviceprovider'=>sp.Id,'vehicle'=>v1.Id};
                   DailyCovidActivityVehicle.getissuewithrecords();
        DailyCovidActivityVehicle.createcovidvvehicle(dataMap);
        
        System.currentPageReference().getParameters().put('comments1', 'Yes');
        System.currentPageReference().getParameters().put('comments2', 'Yes');
        System.currentPageReference().getParameters().put('vehicleid', v1.id);
        
        
        Map<String,String> dataMapNew = new Map<String,String>{'comments1'=>'Yes','comments2'=>'Yes','inputfileids1'=>cv2.id,'objectname'=>'Daily_Covid_activity_vehicle__c','serviceprovider'=>sp.Id};
            DailyCovidActivityVehicle.createcovidvvehicle(dataMapNew);
        
        dv.delcontentfiles();
        System.currentPageReference().getParameters().put('firstParam','' );
         Test.stopTest();
        
    }
}