@isTest
public class CRAComplianceTest {

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
        Candidate__c com1 = new Candidate__c();
        com1.Aadhar_Number__c = '121212564567';
        com1.First_Name__c = 'jj';
        com1.Last_Name__c ='kk';
        com1.Available_From_Date__c=system.today();
        com1.Present_Address_1__c ='kk';
        com1.Pan_Card_Id__c='AAAAA1223W';
        com1.Address__c='Koc';
        com1.Location__c ='Pune';
        com1.Phone__c ='9897077053';
        com1.Licence_Number__c='1234567890123';
        com1.Badge_Number__c='12';
        com1.Full_NameSo1__c='jjj';
        com1.RelationshipSo1__c ='jj';
        com1.PhoneSo1__c='9993420987';
        com1.Company_Address__c ='kk';
        com1.PhoneE__c ='0909878709';
        com1.Landmark__c ='kk';
        com1.Addresscurem__c ='jj';
        com1.Starting_Datecur__c =system.today();
        com1.Police_Station__c ='bvf';
        com1.Period_of_Stay__c ='vv';
        com1.Ending_Datecur__c = system.today();
        com1.Landmarkpocur__c ='gffg';
        com1.Starting_Dateper__c=system.today();
        com1.Ending_Datepo__c =system.today();
        com1.Addresspocur__c ='bv';
        com1.Police_Stationcur__c='jnbvb';
        com1.Period_of_Staycur__c='hvc';
       // com1.Mobile__c ='1212121234';
      //  com1.Pincode__c='455661';
        com1.Addresspolice__c ='fdf';
        com1.Starting_Datepo__c=system.today();
       insert com1;
        
        Service_Provider__c SpNew = new Service_Provider__c ();
        SpNew.Aadhar_Number__c = com1.Aadhar_Number__c;
        SpNew.Address12__c = com1.Address12__c;
        SpNew.Address__c = com1.Address__c;
        SpNew.Name = com1.Candidate__c;
        SpNew.Status__c = 'Active';
        SpNew.First_Name__c = com1.First_Name__c;
       // spNew.Middle_Name__c = com1.Middle_Name__c;
        SpNew.Last_Name__c = com1.Last_Name__c;
        SpNew.Driving_License_Number__c = com1.Licence_Number__c;
        SpNew.Phone_Number__c = com1.Phone__c;
        SpNew.Location__c = com1.Location__c;
          SpNew.Site__c=campus.id;
        insert SpNew;
        
      
         Compliance__c comp = new Compliance__c();
     comp.Driving_License_Expire_Date__c = System.today();
        insert comp;
        
        
        com1.Service_Provider__c = comp.Service_Provider_Id__c;
          update com1;
        id serviceprovideId = SpNew.Id;
         ContentVersion contentVersionInsert = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true
        );
        insert contentVersionInsert;
       
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        String driverProofNm = documents[0].Title;
        
        //Create ContentDocumentLink  Record
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = com1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
         string temp=System.Url.getSalesforceBaseUrl().toExternalForm();
        String[] arrTest = temp.split('\\.');
        String st='/';
        string t=documents[0].id;
		com1.CRA_Picture__c = t;
        
        update com1;
        
        
        Test.startTest();
        
        ApexPages.standardController sc=new ApexPages.standardController(comp);
        CRACompliance db=new CRACompliance(sc);
        db.onLoad();
        Test.stopTest();
    }
  
    
}