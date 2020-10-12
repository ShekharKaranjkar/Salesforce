@isTest
public class DrivingLicense2Complaince_Test {
    
    static TestMethod void onLoad(){
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User usrObj = new User();
        usrObj.LastName = 'TestLast';
        usrObj.FirstName='TestFirst';
        usrObj.Alias = 'tst';
        usrObj.Email = 'test@test.com';
        usrObj.Username = 'testkalasinj@gmail.com.staging';
        usrObj.ProfileId = profileId.id;
        usrObj.TimeZoneSidKey = 'GMT';
        usrObj.LanguageLocaleKey = 'en_US';
        usrObj.EmailEncodingKey = 'UTF-8';
        usrObj.LocaleSidKey = 'en_US';
        usrObj.IsActive=True;
        //usrObj.userRoleId='00EC0000001EkqFMAS';
        //usrObj.UserRole.Name='CRM Rep';
        insert usrObj;
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=acc.id;
        Campus.Lithium_Bank_Account__c='State Bank';
        Campus.Site_Supervisor__c =usrObj.id ;
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
        Compliance__c myCustomObject;
        Candidate__c myCustomObjectVal;
        list<ContentDocument> cond;
        Compliance__c compRec;
        Candidate__c cand = new Candidate__c();
        cand.Aadhar_Number__c = '121212564567';
        cand.First_Name__c = 'jj';
        cand.Last_Name__c ='kk';
        cand.Available_From_Date__c=system.today();
        cand.Present_Address_1__c ='kk';
        cand.Pan_Card_Id__c='AAAAA1223W';
        cand.Address__c='Koc';
        cand.Location__c ='Pune';
        cand.Phone__c ='9897077053';
        cand.Licence_Number__c='1234567890123';
        cand.Badge_Number__c='12';
        cand.Full_NameSo1__c='jjj';
        cand.RelationshipSo1__c ='jj';
        cand.PhoneSo1__c='9993420987';
        cand.Company_Address__c ='kk';
        cand.PhoneE__c ='0909878709';
        cand.Landmark__c ='kk';
        cand.Addresscurem__c ='jj';
        cand.Starting_Datecur__c =system.today();
        cand.Police_Station__c ='bvf';
        cand.Period_of_Stay__c ='vv';
        cand.Ending_Datecur__c = system.today();
        cand.Landmarkpocur__c ='gffg';
        cand.Starting_Dateper__c=system.today();
        cand.Ending_Datepo__c =system.today();
        cand.Addresspocur__c ='bv';
        cand.Police_Stationcur__c='jnbvb';
        cand.Period_of_Staycur__c='hvc';
       // cand.Mobile__c ='1212121234';
      //  cand.Pincode__c='455661';
        cand.Addresspolice__c ='fdf';
        cand.Starting_Datepo__c=system.today();
        insert cand;
        
        Service_Provider__c SpNew = new Service_Provider__c ();
        SpNew.Aadhar_Number__c = cand.Aadhar_Number__c;
        SpNew.Address12__c = cand.Address12__c;
        SpNew.Address__c = cand.Address__c;
        SpNew.Name = cand.Candidate__c;
        SpNew.Status__c = 'Active';
        SpNew.First_Name__c = cand.First_Name__c;
        // spNew.Middle_Name__c = cand.Middle_Name__c;
        SpNew.Last_Name__c = cand.Last_Name__c;
        SpNew.Driving_License_Number__c = cand.Licence_Number__c;
        SpNew.Phone_Number__c = cand.Phone__c;
        SpNew.Location__c = cand.Location__c;
        SpNew.Site__c=campus.id;
        insert SpNew;
         

         ContentVersion contentVersionInsert = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true
        );
        insert contentVersionInsert;
        
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        String driverProofNm = documents[0].Title;
        cand.Service_Provider__c = SpNew.Id;
        cand.Driving_Licence_Back_Page_Picture__c = documents[0].id;
        update cand;
        Compliance__c complanceRec = new Compliance__c();
        complanceRec.Driving_License_Expire_Date__c = System.today();
        complanceRec.Lithium_ID__c =SpNew.id;
       // complanceRec.Driving_Licence_Back_Page_Picture__c = documents[0].id;
        insert complanceRec;
        //Create ContentDocumentLink  Record
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = complanceRec.id;
        cdl.ContentDocumentId =   cand.Driving_Licence_Back_Page_Picture__c;
        cdl.shareType = 'V';
        insert cdl;
        string t=string.valueOf(documents[0].id);
        
        id serviceprovideId = SpNew.Id;

        Test.startTest();
        
        ApexPages.standardController sc=new ApexPages.standardController(complanceRec);
        
        DrivingLicense2Complaince db=new DrivingLicense2Complaince(sc);
         db.onLoad();
        DrivingLicense2Complaince.uploadfiles(complanceRec.id,contentVersionInsert.Id);
      db.deleteRecord();
        Test.stopTest();
        
    }
    
}