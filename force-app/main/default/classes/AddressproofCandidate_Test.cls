@isTest
public class AddressproofCandidate_Test {
  
    static TestMethod void onLoad(){
        
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
        cdl.LinkedEntityId = com1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        ApexPages.standardController sc=new ApexPages.standardController(com1);
         AddressproofCandidate.uploadfiles(com1.id,contentVersionInsert.id);
        AddressproofCandidate db=new AddressproofCandidate(sc);
        db.onLoad();
        Test.stopTest();
    }
    static TestMethod void deleteRecord(){
           ContentVersion contentVersionInsert = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true
        );
        insert contentVersionInsert;
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument limit 1];
        
         Candidate__c com2 = new Candidate__c();
         com2.Aadhar_Number__c = '121212564567';
        com2.First_Name__c = 'jj';
            com2.Last_Name__c ='kk';
        com2.Available_From_Date__c=system.today();
        com2.Present_Address_1__c ='kk';
        com2.Pan_Card_Id__c='AAAAA1223W';
        com2.Address__c='Koc';
        com2.Location__c ='Pune';
        com2.Phone__c ='9897077053';
        com2.Licence_Number__c='1111111111111';
        com2.Badge_Number__c='12';
        com2.Full_NameSo1__c='jjj';
        com2.RelationshipSo1__c ='jj';
        com2.PhoneSo1__c='9993420987';
        com2.Company_Address__c ='kk';
        com2.PhoneE__c ='0909878709';
        com2.Landmark__c ='kk';
        com2.Addresscurem__c ='jj';
        com2.Starting_Datecur__c =system.today();
        com2.Police_Station__c ='bvf';
        com2.Period_of_Stay__c ='vv';
        com2.Ending_Datecur__c = system.today();
        com2.Landmarkpocur__c ='gffg';
        com2.Starting_Dateper__c=system.today();
        com2.Ending_Datepo__c =system.today();
        com2.Addresspocur__c ='bv';
        com2.Police_Stationcur__c='jnbvb';
        com2.Period_of_Staycur__c='hvc';
        com2.Address_Proof_Id__c = documents[0].Id;
       // com2.Mobile__c ='1212121234';
      //  com2.Pincode__c='455661';
        com2.Addresspolice__c ='fdf';
        com2.Starting_Datepo__c=system.today();
        insert com2;
        
         ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = com2.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();

        ApexPages.standardController sc=new ApexPages.standardController(com2);
     
          AddressproofCandidate db1=new AddressproofCandidate(sc);
        db1.deleteRecord();
        Test.stopTest();
    }
}